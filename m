Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42431C6FA99
	for <ltp@archiver.kernel.org>; Fri, 10 Mar 2023 12:41:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D3C433CCD80
	for <ltp@archiver.kernel.org>; Fri, 10 Mar 2023 13:41:43 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 63C153C1047
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 13:41:32 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C41DD600F4E
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 13:41:31 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3012C229A8;
 Fri, 10 Mar 2023 12:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678452091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RWs/3S8ci/SoTPFdgmoOa8wM5q1FFd0Xc3YxfgKIdmU=;
 b=zEOxWcpIX3ihQos3bTcuuR3fGQexijCub0Hk+I2qyTQS4LWPWENF22WH+dNyAwL44oS/Ta
 bFiRyds4MlT/XQ8IV0Ehg2ck4dwoxUK6dJ5rQwc1ViOShjcEEg5CW6c7oyzNVSzZUQLEeC
 9G4BHLt3bNnH0iVIab9rW1QGhPvq3XY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678452091;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RWs/3S8ci/SoTPFdgmoOa8wM5q1FFd0Xc3YxfgKIdmU=;
 b=Jpr5bppYZ12vO5MjsXE6PDBU9kny8AiXzCkd9POBuo4fmdjxJdikp9TjQy97H/jHpB3eJw
 HDk9+bvof8kNjRCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0769013592;
 Fri, 10 Mar 2023 12:41:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IAL4OnolC2T1JgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 10 Mar 2023 12:41:30 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 10 Mar 2023 13:41:25 +0100
Message-Id: <20230310124125.14279-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230310124125.14279-1-pvorel@suse.cz>
References: <20230310124125.14279-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] ns_ifmove.c: Rename to
 testcases/lib/tst_ns_ifmove.c
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

It's not only a test, but also tool for tst_net.sh therefore better to
be in common tools directory.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/namespaces-helper-tools.txt               |  4 ++--
 .../kernel/containers/netns/netns_lib.sh      |  2 +-
 testcases/kernel/containers/share/.gitignore  |  1 -
 testcases/kernel/containers/share/Makefile    | 22 -------------------
 testcases/lib/.gitignore                      |  1 +
 testcases/lib/Makefile                        |  2 +-
 testcases/lib/tst_net.sh                      |  4 ++--
 .../share/ns_ifmove.c => lib/tst_ns_ifmove.c} |  2 +-
 8 files changed, 8 insertions(+), 30 deletions(-)
 delete mode 100644 testcases/kernel/containers/share/.gitignore
 delete mode 100644 testcases/kernel/containers/share/Makefile
 rename testcases/{kernel/containers/share/ns_ifmove.c => lib/tst_ns_ifmove.c} (97%)

diff --git a/doc/namespaces-helper-tools.txt b/doc/namespaces-helper-tools.txt
index 74d22593e..b911dd6cc 100644
--- a/doc/namespaces-helper-tools.txt
+++ b/doc/namespaces-helper-tools.txt
@@ -17,7 +17,7 @@ located in ltp/testcases/kernel/containers/share directory and include:
 * tst_ns_exec
 ** enters the namespace(s) of a process specified by a PID
 ** then executes the indicated program inside that namespace(s)
-* ns_ifmove
+* tst_ns_ifmove
 ** moves a network interface to the namespace of a process specified by a PID
 
 Purpose of these helper tools is the ability to execute test cases utilizing
@@ -44,7 +44,7 @@ tst_ns_exec $myns net,ipc ip a
     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
 
 # Moves interface veth1 into the namespace specified by PID in myns variable
-ns_ifmove veth1 $myns
+tst_ns_ifmove veth1 $myns
 tst_ns_exec $myns net,ipc ip a
 1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN
     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
diff --git a/testcases/kernel/containers/netns/netns_lib.sh b/testcases/kernel/containers/netns/netns_lib.sh
index 043127309..f6977f729 100755
--- a/testcases/kernel/containers/netns/netns_lib.sh
+++ b/testcases/kernel/containers/netns/netns_lib.sh
@@ -130,7 +130,7 @@ netns_ns_exec_setup()
 	$NS_EXEC $NS_HANDLE0 $NS_TYPE ip link add veth0 type veth peer name veth1 || \
 		tst_brk TBROK "unable to create veth pair devices"
 
-	$NS_EXEC $NS_HANDLE0 $NS_TYPE ns_ifmove veth1 $NS_HANDLE1
+	$NS_EXEC $NS_HANDLE0 $NS_TYPE tst_ns_ifmove veth1 $NS_HANDLE1
 	ret=$?
 	[ $ret -eq 0 ] && return
 	[ $ret -eq 32 ] && tst_brk TCONF "IFLA_NET_NS_PID not supported"
diff --git a/testcases/kernel/containers/share/.gitignore b/testcases/kernel/containers/share/.gitignore
deleted file mode 100644
index 1c5bd4ba7..000000000
--- a/testcases/kernel/containers/share/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-/ns_ifmove
diff --git a/testcases/kernel/containers/share/Makefile b/testcases/kernel/containers/share/Makefile
deleted file mode 100644
index 962d6889d..000000000
--- a/testcases/kernel/containers/share/Makefile
+++ /dev/null
@@ -1,22 +0,0 @@
-# Copyright (c) 2015 Red Hat, Inc.
-#
-# This program is free software: you can redistribute it and/or modify
-# it under the terms of version 2 the GNU General Public License as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program.  If not, see <http://www.gnu.org/licenses/>.
-##############################################################################
-top_srcdir              ?= ../../../..
-
-include $(top_srcdir)/include/mk/testcases.mk
-include $(abs_srcdir)/../Makefile.inc
-
-LDLIBS                  := -lltp
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/lib/.gitignore b/testcases/lib/.gitignore
index 35c2b93ff..01048647a 100644
--- a/testcases/lib/.gitignore
+++ b/testcases/lib/.gitignore
@@ -13,6 +13,7 @@
 /tst_net_vars
 /tst_ns_create
 /tst_ns_exec
+/tst_ns_ifmove
 /tst_random
 /tst_rod
 /tst_sleep
diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile
index 52d17c914..e9d33892d 100644
--- a/testcases/lib/Makefile
+++ b/testcases/lib/Makefile
@@ -12,6 +12,6 @@ MAKE_TARGETS		:= tst_sleep tst_random tst_checkpoint tst_rod tst_kvcmp\
 			   tst_device tst_net_iface_prefix tst_net_ip_prefix tst_net_vars\
 			   tst_getconf tst_supported_fs tst_check_drivers tst_get_unused_port\
 			   tst_get_median tst_hexdump tst_get_free_pids tst_timeout_kill\
-			   tst_check_kconfigs tst_cgctl tst_ns_create tst_ns_exec
+			   tst_check_kconfigs tst_cgctl tst_ns_create tst_ns_exec tst_ns_ifmove
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index f4ec1a11d..8be61da2d 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -115,7 +115,7 @@ init_ltp_netspace()
 	local pid
 
 	if [ ! -f /var/run/netns/ltp_ns -a -z "$LTP_NETNS" ]; then
-		tst_require_cmds ip tst_ns_create tst_ns_exec ns_ifmove
+		tst_require_cmds ip tst_ns_create tst_ns_exec tst_ns_ifmove
 		tst_require_root
 
 		tst_require_drivers veth
@@ -125,7 +125,7 @@ init_ltp_netspace()
 		ROD ln -s /proc/$pid/ns/net /var/run/netns/ltp_ns
 		ROD tst_ns_exec $pid net,mnt mount --make-rprivate /sys
 		ROD tst_ns_exec $pid net,mnt mount -t sysfs none /sys
-		ROD ns_ifmove ltp_ns_veth1 $pid
+		ROD tst_ns_ifmove ltp_ns_veth1 $pid
 		ROD tst_ns_exec $pid net,mnt ip link set lo up
 	elif [ -n "$LTP_NETNS" ]; then
 		tst_res_ TINFO "using not default LTP netns: '$LTP_NETNS'"
diff --git a/testcases/kernel/containers/share/ns_ifmove.c b/testcases/lib/tst_ns_ifmove.c
similarity index 97%
rename from testcases/kernel/containers/share/ns_ifmove.c
rename to testcases/lib/tst_ns_ifmove.c
index 60dda94d3..cbf6ac746 100644
--- a/testcases/kernel/containers/share/ns_ifmove.c
+++ b/testcases/lib/tst_ns_ifmove.c
@@ -58,7 +58,7 @@ int main(int argc, char **argv)
 	int intf_index, pid, rtnetlink_socket;
 
 	if (argc != 3) {
-		printf("ns_ifmove <INTERFACE_NAME> <NAMESPACE_PID>\n");
+		printf("tst_ns_ifmove <INTERFACE_NAME> <NAMESPACE_PID>\n");
 		return 1;
 	}
 
-- 
2.39.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
