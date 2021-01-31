import subprocess
import sys
subprocess.run(["ls", "-l"])
arguments = len(sys.argv) - 1
print ("Argument $s" % arguments)

