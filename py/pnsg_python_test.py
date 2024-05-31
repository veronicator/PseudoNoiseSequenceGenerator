from pylfsr import LFSR
import difflib


seed = [1,0,0,0,0,0,0,0,0,0,0,0,0,0,1]
fpoly = [15, 13, 9, 8, 7, 5]
L = LFSR(fpoly=fpoly, initstate=seed, verbose=True)
L.info()

with open("pnsg_output_py.txt", "w") as f:

    for _ in range(2**15 - 1):
        f.write(L.getState() + '\n')
        L.next()

with open("pnsg_output_py.txt", "r") as f1, open("../modelsim/PN_code_out_file.txt", "r") as f2:
    diff = difflib.unified_diff(f1.readlines(), f2.readlines())
    for line in diff:
        print(line)
    if len(list(diff)) == 0:
        print("\n output sequences are equals -> pnsg correct")
    else:
        print("output sequences are different -> pnsg wrong")

