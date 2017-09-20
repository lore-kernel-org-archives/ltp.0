From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 20 Sep 2017 11:29:18 +0200
Subject: [LTP] [PATCH 1/1] network/stress: Update README
Message-ID: <20170920092918.19960-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Petr Vorel <petr.vorel@gmail.com>

networkstress.sh was merged into network.sh and then deleted in
fddb4f3c7 ("network: remove outdated network runtests and scripts")

Also same of network stress tests use test_net.sh instead of using
deprecated LTP_RSH.

This fixes #203.

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
I hate 'ltp-yyyymmdd/' path prefix, but I ignored it now.
---
 testcases/network/stress/README | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/testcases/network/stress/README b/testcases/network/stress/README
index c0d0ad374..ddb2941ea 100644
--- a/testcases/network/stress/README
+++ b/testcases/network/stress/README
@@ -37,24 +37,25 @@ Installation
 
 Like the other network tests, the remote host must have the LTP installed
 in the same exact location as the local host have. Please refer the `Detailed
-Installation 6.' section in ltp-yyyymmdd/INSTALL.
+Installation 5.' section in ltp-yyyymmdd/INSTALL.
 
 
 
 Execution
 =========
 
-To run the network stress testcases, networkstress.sh is prepared in
-ltp-yyyymmdd/testscripts directory. Some envrionment variables have to be
-set for the stress testcases. Please fill the environment variable in
-networkstress.sh.
+To run the network stress testcases, use network.sh script, located in
+ltp-yyyymmdd/testscripts directory. For documentation about using network.sh
+see ltp-yyyymmdd/INSTALL and ltp-yyyymmdd/testcases/network/README.md
 
-Like the other network stress tests, the remote host must be setup to allow
-the local host connection using rsh. Please refer the `Detailed
-Installation 6.' section in ltp-yyyymmdd/INSTALL.
+Unfortunately some stress tests still depend on rsh for accessing remote host, even
+you decide to use SSH or network namespaces with network.sh.
 Instead of rsh, you can use ssh to set the environment variable LTP_RSH.
 Please refer the `Environment Variable' section of this document.
 
+The behaviour of network stress tests is configurable with environment
+variables, described below.
+
 Two command lists is prepared in ltp-yyyymmdd/runtest directory.
 
   network_stress.whole	   : 118 kinds 615 tests
-- 
2.14.1

