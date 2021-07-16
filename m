From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 16 Jul 2021 12:04:14 +0200
Subject: [LTP] [PATCH 2/3] netns_helper.sh: Check veth with TST_NEEDS_DRIVERS
In-Reply-To: <20210716100415.27410-1-pvorel@suse.cz>
References: <20210716100415.27410-1-pvorel@suse.cz>
Message-ID: <20210716100415.27410-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

instead loading it with modprobe. ip link can load veth itself
(use the same approach as in tst_net.sh).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/containers/netns/netns_helper.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/containers/netns/netns_helper.sh b/testcases/kernel/containers/netns/netns_helper.sh
index 218fcef8c..c296b8726 100755
--- a/testcases/kernel/containers/netns/netns_helper.sh
+++ b/testcases/kernel/containers/netns/netns_helper.sh
@@ -5,7 +5,8 @@
 
 TST_CLEANUP=netns_ns_exec_cleanup
 TST_NEEDS_ROOT=1
-TST_NEEDS_CMDS="ip modprobe ping"
+TST_NEEDS_CMDS="ip ping"
+TST_NEEDS_DRIVERS="veth"
 . tst_test.sh
 
 # Set to 1 only for test cases using ifconfig (ioctl).
@@ -75,9 +76,6 @@ IFCONF_IN6_ARG=
 # On success function returns, on error tst_brk is called and TC is terminated.
 netns_setup()
 {
-
-	modprobe veth > /dev/null 2>&1
-
 	case "$1" in
 	ns_exec)
 		setns_check
-- 
2.32.0

