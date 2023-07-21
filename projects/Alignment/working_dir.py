"""
vscodeで編集した場合、pwdが$WORK_DIRから動かない。
そのため、vscodeとjupyterのどちらで編集したかで、
Pathの構造が変わる。
"""

import os

workdir=os.environ["WORK_DIR"]
os.chdir(workdir)
print( f"This notebook is located at {os.getcwd()}" )
