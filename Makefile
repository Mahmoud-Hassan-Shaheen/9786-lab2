dir = my_dir
malicious = malicious_dir
waiting = 3

setup:
	mkdir -p $(malicious)

runpart1: setup
	bash antivirusd.sh $(dir) $(malicious) $(waiting)

runpart2: setup
	bash restore.sh $(dir) $(malicious)
