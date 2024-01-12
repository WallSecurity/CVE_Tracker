#!/usr/bin/python3
import sys
from datetime import datetime
arg_time = sys.argv[1]
diff = sys.argv[2]
cve_time = datetime.strptime(arg_time, '%Y-%m-%d')
diff_time = datetime.now() - cve_time
if diff_time.days > diff:
	print("True")
else:
	print("False")
