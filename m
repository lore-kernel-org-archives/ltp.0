From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 18 Dec 2019 16:28:32 +0100
Subject: [LTP] [PATCH v2 2/2] network/iptables: add new test for
 iptables-tranlsate and nft
In-Reply-To: <f0aad696-82a5-fb06-0517-a437d95ae2e7@oracle.com>
References: <20191217171918.10237-1-alexey.kodanev@oracle.com>
 <20191217171918.10237-2-alexey.kodanev@oracle.com>
 <20191218084406.GA10966@dell5510>
 <f0aad696-82a5-fb06-0517-a437d95ae2e7@oracle.com>
Message-ID: <20191218152832.GA26689@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Thanks Petr! Fixed them and applied the patches.
Thanks for your work.

BTW even more setup could be moved into iptables_lib.sh.
If you like this change, I can push it.

Kind regards,
Petr

 testcases/network/iptables/iptables01.sh   | 3 ---
 testcases/network/iptables/iptables_lib.sh | 8 ++++++++
 testcases/network/iptables/nft01.sh        | 3 ---
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/testcases/network/iptables/iptables01.sh b/testcases/network/iptables/iptables01.sh
index e6ed4afab..96d68e62e 100755
--- a/testcases/network/iptables/iptables01.sh
+++ b/testcases/network/iptables/iptables01.sh
@@ -4,11 +4,8 @@
 
 TST_SETUP="init"
 TST_CLEANUP="cleanup"
-TST_NEEDS_CMDS="iptables grep ping telnet"
-TST_NEEDS_DRIVERS="ip_tables"
 use_iptables=1
 
 . iptables_lib.sh
-. tst_test.sh
 
 tst_run
diff --git a/testcases/network/iptables/iptables_lib.sh b/testcases/network/iptables/iptables_lib.sh
index b098479e4..87f33dfca 100755
--- a/testcases/network/iptables/iptables_lib.sh
+++ b/testcases/network/iptables/iptables_lib.sh
@@ -12,11 +12,19 @@ TST_NEEDS_TMPDIR=1
 TST_NEEDS_ROOT=1
 
 if [ "$use_iptables" = 1 ]; then
+	cmds="iptables"
 	toolname=iptables
+	TST_NEEDS_DRIVERS="ip_tables"
 else
+	cmds="nft iptables-translate"
 	toolname=nft
+	TST_NEEDS_DRIVERS="nf_tables"
 fi
 
+TST_NEEDS_CMDS="$cmds grep ping telnet"
+
+. tst_test.sh
+
 NFRUN()
 {
 	local rule
diff --git a/testcases/network/iptables/nft01.sh b/testcases/network/iptables/nft01.sh
index 9bd10a7f5..6cbd7a3a6 100755
--- a/testcases/network/iptables/nft01.sh
+++ b/testcases/network/iptables/nft01.sh
@@ -4,14 +4,11 @@
 
 TST_SETUP="do_setup"
 TST_CLEANUP="do_cleanup"
-TST_NEEDS_CMDS="nft iptables-translate grep ping telnet"
-TST_NEEDS_DRIVERS="nf_tables"
 use_iptables=0
 cleanup_table=0
 cleanup_chain=0
 
 . iptables_lib.sh
-. tst_test.sh
 
 do_setup()
 {
-- 
2.24.0

