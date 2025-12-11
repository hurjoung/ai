import pandas as pd
pd_pds = pd.read_sas('C:/Users/Admin/Downloads/hn22_ap/hn22_ap.sas7bdat', format='sas7bdat')

pd_pds.to_excel('hn22_ap.xlsx')