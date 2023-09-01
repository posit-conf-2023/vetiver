import os
import pins
import rsconnect
import vetiver
import pandas as pd
import numpy as np
from sklearn import preprocessing, ensemble, pipeline, compose, model_selection
from vetiver import VetiverModel, vetiver_pin_write
from dotenv import load_dotenv

load_dotenv()
api_key = os.getenv("CO_API_KEY")
url = os.getenv("CO_RSC_URL")
connect_server = rsconnect.api.RSConnectServer(
  url = url,
  api_key = api_key
)
inspections = pd.read_parquet('./data/inspections.parquet', engine = 'pyarrow')
inspections['inspection_date'] = pd.to_datetime(inspections['inspection_date'])
inspections['month'] = inspections['inspection_date'].dt.month
inspections['year'] = inspections['inspection_date'].dt.year
inspections = inspections.drop(columns=['inspection_date'])


categorical_features = ['facility_type', 'risk', 'month']
X, y = inspections.drop(columns=['aka_name', 'results']), inspections['results']
X_train, X_test, y_train, y_test = model_selection.train_test_split(
    X, y,
    stratify = y,
    test_size = 0.2
)

oe = compose.make_column_transformer(
    (preprocessing.OrdinalEncoder(
            handle_unknown="use_encoded_value", unknown_value=-1),
        categorical_features,),
    remainder="passthrough",
).fit(X_train)
rf = ensemble.RandomForestClassifier().fit(oe.transform(X_train), y_train)
inspection_fit = pipeline.Pipeline([("ordinal_encoder", oe), ("random_forest", rf)])

v = VetiverModel(inspection_fit, "isabel.zimmerman/chicago-inspections-python", prototype_data = X_train)
board = pins.board_connect(server_url = url, api_key = api_key, allow_pickle_read = True)

vetiver_pin_write(board, v)

vetiver.deploy_rsconnect(
  connect_server = connect_server,
  board = board,
  pin_name = "isabel.zimmerman/chicago-inspections-python",
  extra_files = ['requirements.txt']
)
