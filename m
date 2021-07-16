From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 16 Jul 2021 12:04:13 +0200
Subject: [LTP] [PATCH 1/3] netns_helper.sh: Check for ping
In-Reply-To: <20210716100415.27410-1-pvorel@suse.cz>
References: <20210716100415.27410-1-pvorel@suse.cz>
Message-ID: <20210716100415.27410-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

to give more informative message than just:
netns_comm 1 TFAIL: ns_exec 48906 net ping -q -c2 -I veth0 192.168.0.3 failed unexpectedly
netns_comm 1 TFAIL: ns_exec 48908 net ping -q -c2 -I veth1 192.168.0.2 failed unexpectedly
netns_comm 1 TFAIL: ns_exec 48906 net ping -q -c2 -I lo 127.0.0.1 failed unexpectedly

Use the same approach implemented in d57ac0b7a for tst_net.sh: for IPv6
ping6 is preferred (but still require ping), but fallback with warning
if only ping is available (some distros may still miss ping6 symlink
required by upstream since iputils s20150815).

Reported-by: Martin Doucha <mdoucha@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Reported in https://github.com/linux-test-project/ltp/issues/840

 testcases/kernel/containers/netns/netns_helper.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/containers/netns/netns_helper.sh b/testcases/kernel/containers/netns/netns_helper.sh
index 1f97ec4d4..218fcef8c 100755
--- a/testcases/kernel/containers/netns/netns_helper.sh
+++ b/testcases/kernel/containers/netns/netns_helper.sh
@@ -1,11 +1,11 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) Linux Test Project, 2014-2020
+# Copyright (c) Linux Test Project, 2014-2021
 # Copyright (c) 2015 Red Hat, Inc.
 
 TST_CLEANUP=netns_ns_exec_cleanup
 TST_NEEDS_ROOT=1
-TST_NEEDS_CMDS="ip modprobe"
+TST_NEEDS_CMDS="ip modprobe ping"
 . tst_test.sh
 
 # Set to 1 only for test cases using ifconfig (ioctl).
@@ -132,10 +132,12 @@ netns_setup()
 	ipv6)
 		IFCONF_IN6_ARG="inet6 add"
 		IP0=$6; IP1=$7;
-		if which ping6 >/dev/null 2>&1; then
+
+		if tst_cmd_available ping6; then
 		    tping="ping6"
 		else
 		    tping="ping -6"
+			tst_res_ TINFO "ping6 binary/symlink is missing, using workaround. Please, report missing ping6 to your distribution."
 		fi
 		NETMASK=64
 		;;
-- 
2.32.0

