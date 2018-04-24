From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 24 Apr 2018 11:05:21 +0200
Subject: [LTP] [PATCH v3] *.py : convert python2 to python3
In-Reply-To: <20180423081206.25470-1-yosun@suse.com>
References: <20180419101038.22451-1-yosun@suse.com>
 <20180423081206.25470-1-yosun@suse.com>
Message-ID: <20180424090521.ypic57umpsdfpilg@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yosun,

> From: yosun <yosun@suse.com>

> 1. Convert python code to use python3
> 2. Make shebang same as standard python shebang
> 3. Correct format to solve compiling error in python3

> Signed-off-by: Yong Sun <yosun@suse.com>
> ---
Accepted with removing double brackets (see diff bellow; I guess you run 2to3 twice, in
that case it would be printed as list).

Thanks for your contribution!


Kind regards,
Petr

diff --git a/testcases/kernel/power_management/pm_cpu_consolidation.py b/testcases/kernel/power_management/pm_cpu_consolidation.py
index fbe262aad..ecd2e4fac 100755
--- a/testcases/kernel/power_management/pm_cpu_consolidation.py
+++ b/testcases/kernel/power_management/pm_cpu_consolidation.py
@@ -136,7 +136,7 @@ sched_smt was enabled. This is pre-requisite to proceed")
                 reset_schedsmt()
             return(status)
     except Exception as details:
-        print(("INFO: CPU consolidation failed", details))
+        print("INFO: CPU consolidation failed", details)
         return(1)
 
 if __name__ == "__main__":
diff --git a/testcases/kernel/power_management/pm_ilb_test.py b/testcases/kernel/power_management/pm_ilb_test.py
index 412ceb9f7..920c4e354 100755
--- a/testcases/kernel/power_management/pm_ilb_test.py
+++ b/testcases/kernel/power_management/pm_ilb_test.py
@@ -50,7 +50,7 @@ def main(argv=None):
         return(status)
 
     except Exception as details:
-        print(("INFO: Idle Load Balancer test failed", details))
+        print("INFO: Idle Load Balancer test failed", details)
         return(1)
 
 if __name__ == "__main__":
diff --git a/testcases/kernel/power_management/pm_sched_domain.py b/testcases/kernel/power_management/pm_sched_domain.py
index 0ada3eea4..d5cd327f3 100755
--- a/testcases/kernel/power_management/pm_sched_domain.py
+++ b/testcases/kernel/power_management/pm_sched_domain.py
@@ -46,7 +46,7 @@ def main(argv=None):
             print("INFO: Invalid arguments given")
             return 1
     except Exception as details:
-        print(("INFO: sched domain test failed: ", details))
+        print("INFO: sched domain test failed: ", details)
         return(1)
 
 # Run test based on the command line arguments
diff --git a/testcases/network/nfsv4/acl/random_gen.py b/testcases/network/nfsv4/acl/random_gen.py
index 735dc1de9..37cb17945 100755
--- a/testcases/network/nfsv4/acl/random_gen.py
+++ b/testcases/network/nfsv4/acl/random_gen.py
@@ -33,7 +33,7 @@ class RandomGen(object):
 		opts = "-g" + group + " -p" + "1pilot" + " -m " + username
 		u = subprocess.getoutput('/usr/sbin/useradd '+ opts)
 		if u != "":
-			print(("create user " + username + "failed" + u))
+			print("create user " + username + "failed" + u)
 
 	def createFile(self,path,n):
 		for i in range(n):
@@ -143,10 +143,10 @@ class RandomGen(object):
 		f.close()
 
 	def printUserList(self):
-		print((self.uList))
+		print(self.uList)
 
 	def printGroupList(self):
-		print((self.gList))
+		print(self.gList)
 
 	""" Create a random name of random length """
 	def createOneNameRandomLength(self,maxlength):
diff --git a/testcases/network/nfsv4/acl/test_long_acl.py b/testcases/network/nfsv4/acl/test_long_acl.py
index fae640dd5..79e3a96bc 100755
--- a/testcases/network/nfsv4/acl/test_long_acl.py
+++ b/testcases/network/nfsv4/acl/test_long_acl.py
@@ -26,13 +26,13 @@ def test_longacl(l,path):
 		test.getUserList()
 		testfile = 'testfile' + str(i)
 		u = subprocess.getoutput('touch ' + path + "/" + testfile)
-		print(("setfacl with " + str(i) + " entries\n " + u))
+		print("setfacl with " + str(i) + " entries\n " + u)
 		for j in range(i):
 			user = test.uList.pop()
 			mode = test.createRandomMode()
 			u = subprocess.getoutput('setfacl -m u:' + user + ':' + mode + " " + path + "/" + testfile)
 			if u != "":
-				print(("setfacl -m u:" + user + ':' + mode + " " + path + "/" + testfile))
+				print("setfacl -m u:" + user + ':' + mode + " " + path + "/" + testfile)
 				print(u)
 def main():
 	parser = OptionParser()
diff --git a/testcases/network/nfsv4/locks/locktests.py b/testcases/network/nfsv4/locks/locktests.py
index 42cb18487..80d8c2051 100755
--- a/testcases/network/nfsv4/locks/locktests.py
+++ b/testcases/network/nfsv4/locks/locktests.py
@@ -38,7 +38,7 @@ class Machine:
         self.do()
 
     def printc(self):
-        print(("->"+self.command))
+        print("->"+self.command)
         print("\n")
 
 class Client(Machine):
@@ -124,7 +124,7 @@ def setup():
     fichier=SRC_PATH+"/"+SRC
     commande=""
     for i in clients:
-        print(("Setting up machine "+i))
+        print("Setting up machine "+i)
         c=Client(i)
         c.mkdir(path)
         c.cp(fichier, path)
diff --git a/testcases/realtime/tools/ftqviz.py b/testcases/realtime/tools/ftqviz.py
index 1cd07b408..f331d3375 100644
--- a/testcases/realtime/tools/ftqviz.py
+++ b/testcases/realtime/tools/ftqviz.py
@@ -62,8 +62,8 @@ def smooth_fft(timefile, countfile, sample_hz, wlen):
     # same factor
     ns_per_sample = NS_PER_S / sample_hz
 
-    print(("Interpolated Sample Rate: ", sample_hz, " HZ"))
-    print(("Hamming Window Length: ", wlen))
+    print("Interpolated Sample Rate: ", sample_hz, " HZ")
+    print("Hamming Window Length: ", wlen)
 
     t = fromfile(timefile, dtype=int64, sep='\n')
     x = fromfile(countfile, dtype=int64, sep='\n')
@@ -121,7 +121,7 @@ def smooth_fft(timefile, countfile, sample_hz, wlen):
 
 
 def usage():
-        print(("usage: "+argv[0]+" -t times-file -c counts-file [-s SAMPLING_HZ] [-w WINDOW_LEN] [-h]"))
+        print("usage: "+argv[0]+" -t times-file -c counts-file [-s SAMPLING_HZ] [-w WINDOW_LEN] [-h]")
 
 
 if __name__=='__main__':
diff --git a/testscripts/build/ltp-missing-install-files.py b/testscripts/build/ltp-missing-install-files.py
index 11465a725..232028bd1 100755
--- a/testscripts/build/ltp-missing-install-files.py
+++ b/testscripts/build/ltp-missing-install-files.py
@@ -111,6 +111,6 @@ for logfile in logfiles:
         fd.close()
 
     if len(missing_ents):
-        print(("\n".join(["%s: %s" % (os.path.basename(logfile), i) for i in ["Tag | App"] + missing_ents])))
+        print("\n".join(["%s: %s" % (os.path.basename(logfile), i) for i in ["Tag | App"] + missing_ents]))
     elif opts.verbose:
-        print(("%s: CONGRATULATIONS -- no missing files found!" % os.path.basename(logfile)))
+        print("%s: CONGRATULATIONS -- no missing files found!" % os.path.basename(logfile))
