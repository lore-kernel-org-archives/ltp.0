From: Sharan Turlapati <sturlapati@vmware.com>
Date: Thu, 25 Mar 2021 11:21:25 -0700
Subject: [LTP] [PATCH] realtime/scripts: Fix indentation error in parser.py
Message-ID: <20210325182125.2646-1-sturlapati@vmware.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

An indentation error in parser.py causes certain blocks
of code to run even before dependent variables are
initialized when the code in this file is imported
by parse-testpi1.py or parse-testpi2.py.

Post running tests like testpi-2 or testpi-4, the
results of these tests are parsed and added to the
logs/ directory. This bug prevents the results of such
tests from being parsed and thus masks the results of
these tests.

Signed-off-by: Sharan Turlapati <sturlapati@vmware.com>
---
 testcases/realtime/scripts/parser.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/realtime/scripts/parser.py b/testcases/realtime/scripts/parser.py
index 85226deb6..2acbe7d67 100644
--- a/testcases/realtime/scripts/parser.py
+++ b/testcases/realtime/scripts/parser.py
@@ -33,15 +33,15 @@ class Log:
 	def __init__(self,filename):
 		if filename:
 			log_file=filename
-	try:
-		self.__log_file = open(log_file, "r")
-	except IOError as errmsg:
-		sys.exit(errmsg)
+		try:
+			self.__log_file = open(log_file, "r")
+		except IOError as errmsg:
+			sys.exit(errmsg)
 
 	def read(self):
 		for line in self.__log_file.read().split("\n"):
 			yield line
-	self.__log_file.close()
+		self.__log_file.close()
 
 	def eval(self):
 		pass
-- 
2.28.0

