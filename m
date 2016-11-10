From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 10 Nov 2016 12:54:39 +0100
Subject: [LTP] [PATCH v2 1/3] doc: update networking related documentation
Message-ID: <20161110115441.17301-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

networktests.sh was removed in fddb4f3.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 INSTALL               | 25 ++++++++++---------------
 doc/ltp-run-files.txt |  2 +-
 2 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/INSTALL b/INSTALL
index ca9b98d..cb4fff9 100644
--- a/INSTALL
+++ b/INSTALL
@@ -196,8 +196,8 @@ contributions are welcome.
    in the CD-ROM drive.  The corresponding tests will fail if either disk is
    missing.
 
-6. The network tests are executed by running the networktests.sh script. The
-   network tests require some configuration for them to work correctly:
+6. The network tests are executed by running the network.sh script. The network
+   tests require some configuration for them to work correctly:
 
      i) First, there MUST be another test machine setup to act as the server
 	to these client side tests.  This machine MUST have the LTP installed
@@ -231,23 +231,18 @@ contributions are welcome.
 	 Also, because certain RPC programs are tested, the "portmapper" daemon
 	 MUST be started, as well as NFS server AND lock services.
 
-    iv) Finally, before running the networktests.sh script, two variables must
-	be set within the script file.  The "RHOST" variable should be set to
-	the hostname of the server.  The "PASSWD" variable should be set to
-	root's password on the server machine.  This is necessary for tests
-	such as telnet01 and ftp01.
+    iv) Finally, before running the network.sh script, two variables must be
+   set: The "RHOST" variable should be set to the hostname of the server.  The
+   "PASSWD" variable should be set to root's password on the server machine.
+   This is necessary for tests such as telnet01 and ftp01.
 
-   You can now successfully execute the networktests.sh script.
-   When you would like to run the whole network tests, specify -w option:
-	# ./networktests.sh -w
-
-   When you would like to run the same tests which networktests.sh ran till
-   2008, specify no option or -d option:
-	# ./networktests.sh
+   You can now successfully execute the network.sh script.
 
    You can run the test category which you are interested in, -h option shows
    the list of the test category:
-	# ./netwoktests.sh -h
+       # ./network.sh -h
+
+   For more info about howto run network.sh see testcases/network/README.md.
 
 
 Cross compiling
diff --git a/doc/ltp-run-files.txt b/doc/ltp-run-files.txt
index 5da5747..0b4cc48 100644
--- a/doc/ltp-run-files.txt
+++ b/doc/ltp-run-files.txt
@@ -27,7 +27,7 @@ Device Mapper tests
  - ltpdmmapper.sh
 
 Network tests
- - networktests.sh
+ - network.sh
  - testcases/network/sockets/ltpSockets.sh
 
 other filesystem or disk type tests
-- 
2.10.2

