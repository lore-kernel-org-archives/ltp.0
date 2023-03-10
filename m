Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87605C64EC4
	for <ltp@archiver.kernel.org>; Fri, 10 Mar 2023 12:41:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DDF263CD80E
	for <ltp@archiver.kernel.org>; Fri, 10 Mar 2023 13:41:55 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 672613CAD8D
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 13:41:32 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C0F721A011E3
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 13:41:31 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EE273229A7;
 Fri, 10 Mar 2023 12:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678452090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jP/qSsOpW6Z2TiPWwHZEK8ch+J10raHqyKM/R9+3lqE=;
 b=1YWfpDT40GjJ5QbURJOG8uTSxriaBXv8A/BRP20XruCc2ZBWK0qDWBXpbBTqWr/hbu4WCr
 Gsyat4a5XaWJTRe1pI9UqDzomDGqonAOsBuxxFt5jv4zoNEoztEMzbk1lGquQ7tYmUsuJg
 eHDHXETXT657MFVLxxQFBlVFOljv7F4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678452090;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jP/qSsOpW6Z2TiPWwHZEK8ch+J10raHqyKM/R9+3lqE=;
 b=J06nnw8XqEBMGOkJ8mzZb4Mj12aRgxMs9dOpc/5UpLbdoHBPB9N3KluQdJiMSVptCCz2DA
 NZj9vRjB1YPBDlDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BFC7013592;
 Fri, 10 Mar 2023 12:41:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +Bs5K3olC2T1JgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 10 Mar 2023 12:41:30 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 10 Mar 2023 13:41:24 +0100
Message-Id: <20230310124125.14279-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230310124125.14279-1-pvorel@suse.cz>
References: <20230310124125.14279-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] ns_create.c: Rename to
 testcases/lib/tst_ns_create.c
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
 doc/namespaces-helper-tools.txt                             | 4 ++--
 testcases/kernel/containers/netns/netns_lib.sh              | 6 +++---
 testcases/kernel/containers/netns/netns_sysfs.sh            | 2 +-
 testcases/kernel/containers/share/.gitignore                | 1 -
 testcases/kernel/fs/fs_bind/fs_bind_lib.sh                  | 2 +-
 testcases/lib/.gitignore                                    | 1 +
 testcases/lib/Makefile                                      | 2 +-
 testcases/lib/tst_net.sh                                    | 4 ++--
 .../containers/share/ns_create.c => lib/tst_ns_create.c}    | 3 ++-
 9 files changed, 13 insertions(+), 12 deletions(-)
 rename testcases/{kernel/containers/share/ns_create.c => lib/tst_ns_create.c} (94%)

diff --git a/doc/namespaces-helper-tools.txt b/doc/namespaces-helper-tools.txt
index e5a39657d..74d22593e 100644
--- a/doc/namespaces-helper-tools.txt
+++ b/doc/namespaces-helper-tools.txt
@@ -8,7 +8,7 @@ LTP namespaces helper tools
 LTP provides helper tools for creating and working with namespaces. These are
 located in ltp/testcases/kernel/containers/share directory and include:
 
-* ns_create
+* tst_ns_create
 ** creates a child process in the new specified namespace(s)
 ** child is then daemonized and is running in the background
 ** PID of the daemonized child process is printed on the stdout
@@ -34,7 +34,7 @@ The following code shows how test cases can use the namespaces helper tools:
 -------------------------------------------------------------------------------
 # Creates a new network and ipc namespace and stores the PID of the daemonized
 # process inside that namespace into variable myns
-myns=$(ns_create net,ipc)
+myns=$(tst_ns_create net,ipc)
 
 ip link add veth0 type veth peer name veth1
 
diff --git a/testcases/kernel/containers/netns/netns_lib.sh b/testcases/kernel/containers/netns/netns_lib.sh
index f5ce3b5e3..043127309 100755
--- a/testcases/kernel/containers/netns/netns_lib.sh
+++ b/testcases/kernel/containers/netns/netns_lib.sh
@@ -20,7 +20,7 @@ TST_NET_SKIP_VARIABLE_INIT=1
 IPV4_NET16_UNUSED="10.23"
 IPV6_NET32_UNUSED="fd00:23"
 
-# Set to "net" for ns_create/tst_ns_exec as their options requires
+# Set to "net" for tst_ns_create/tst_ns_exec as their options requires
 # to specify a namespace type. Empty for ip command.
 NS_TYPE=
 
@@ -115,13 +115,13 @@ netns_ns_exec_setup()
 
 	NS_EXEC="tst_ns_exec"
 
-	NS_HANDLE0=$(ns_create $NS_TYPE)
+	NS_HANDLE0=$(tst_ns_create $NS_TYPE)
 	if [ $? -eq 1 ]; then
 		tst_res TINFO "$NS_HANDLE0"
 		tst_brk TBROK "unable to create a new network namespace"
 	fi
 
-	NS_HANDLE1=$(ns_create $NS_TYPE)
+	NS_HANDLE1=$(tst_ns_create $NS_TYPE)
 	if [ $? -eq 1 ]; then
 		tst_res TINFO "$NS_HANDLE1"
 		tst_brk TBROK "unable to create a new network namespace"
diff --git a/testcases/kernel/containers/netns/netns_sysfs.sh b/testcases/kernel/containers/netns/netns_sysfs.sh
index aca339bbf..814274fd0 100755
--- a/testcases/kernel/containers/netns/netns_sysfs.sh
+++ b/testcases/kernel/containers/netns/netns_sysfs.sh
@@ -19,7 +19,7 @@ do_setup()
 	DUMMYDEV_HOST="dummy_test0"
 	DUMMYDEV="dummy_test1"
 
-	NS_HANDLE=$(ns_create $NS_TYPE)
+	NS_HANDLE=$(tst_ns_create $NS_TYPE)
 	if [ $? -eq 1 ]; then
 		tst_res TINFO "$NS_HANDLE"
 		tst_brk TBROK "unable to create a new network namespace"
diff --git a/testcases/kernel/containers/share/.gitignore b/testcases/kernel/containers/share/.gitignore
index e490e86a6..1c5bd4ba7 100644
--- a/testcases/kernel/containers/share/.gitignore
+++ b/testcases/kernel/containers/share/.gitignore
@@ -1,2 +1 @@
 /ns_ifmove
-/ns_create
diff --git a/testcases/kernel/fs/fs_bind/fs_bind_lib.sh b/testcases/kernel/fs/fs_bind/fs_bind_lib.sh
index 2499ce68d..52190a7ca 100644
--- a/testcases/kernel/fs/fs_bind/fs_bind_lib.sh
+++ b/testcases/kernel/fs/fs_bind/fs_bind_lib.sh
@@ -198,7 +198,7 @@ _fs_bind_setup_test()
 fs_bind_create_ns()
 {
 	[ -n "$FS_BIND_MNTNS_PID" ] && tst_brk TBROK "Namespace exist already"
-	FS_BIND_MNTNS_PID=$(ns_create mnt)
+	FS_BIND_MNTNS_PID=$(tst_ns_create mnt)
 }
 
 fs_bind_exec_ns()
diff --git a/testcases/lib/.gitignore b/testcases/lib/.gitignore
index 318aa9fb7..35c2b93ff 100644
--- a/testcases/lib/.gitignore
+++ b/testcases/lib/.gitignore
@@ -11,6 +11,7 @@
 /tst_net_iface_prefix
 /tst_net_ip_prefix
 /tst_net_vars
+/tst_ns_create
 /tst_ns_exec
 /tst_random
 /tst_rod
diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile
index e16a67c79..52d17c914 100644
--- a/testcases/lib/Makefile
+++ b/testcases/lib/Makefile
@@ -12,6 +12,6 @@ MAKE_TARGETS		:= tst_sleep tst_random tst_checkpoint tst_rod tst_kvcmp\
 			   tst_device tst_net_iface_prefix tst_net_ip_prefix tst_net_vars\
 			   tst_getconf tst_supported_fs tst_check_drivers tst_get_unused_port\
 			   tst_get_median tst_hexdump tst_get_free_pids tst_timeout_kill\
-			   tst_check_kconfigs tst_cgctl tst_ns_exec
+			   tst_check_kconfigs tst_cgctl tst_ns_create tst_ns_exec
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 8c94d0f7b..f4ec1a11d 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -115,12 +115,12 @@ init_ltp_netspace()
 	local pid
 
 	if [ ! -f /var/run/netns/ltp_ns -a -z "$LTP_NETNS" ]; then
-		tst_require_cmds ip ns_create tst_ns_exec ns_ifmove
+		tst_require_cmds ip tst_ns_create tst_ns_exec ns_ifmove
 		tst_require_root
 
 		tst_require_drivers veth
 		ROD ip link add name ltp_ns_veth1 type veth peer name ltp_ns_veth2
-		pid="$(ROD ns_create net,mnt)"
+		pid="$(ROD tst_ns_create net,mnt)"
 		mkdir -p /var/run/netns
 		ROD ln -s /proc/$pid/ns/net /var/run/netns/ltp_ns
 		ROD tst_ns_exec $pid net,mnt mount --make-rprivate /sys
diff --git a/testcases/kernel/containers/share/ns_create.c b/testcases/lib/tst_ns_create.c
similarity index 94%
rename from testcases/kernel/containers/share/ns_create.c
rename to testcases/lib/tst_ns_create.c
index 09414b162..1c6258cd1 100644
--- a/testcases/kernel/containers/share/ns_create.c
+++ b/testcases/lib/tst_ns_create.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2015 Red Hat, Inc.
  *               Matus Marhefka <mmarhefk@redhat.com>
  * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ * Copyright (c) Linux Test Project, 2020-2023
  */
 
 /*\
@@ -32,7 +33,7 @@ static void print_help(void)
 {
 	int i;
 
-	printf("usage: ns_create <%s", params[0].name);
+	printf("usage: tst_ns_create <%s", params[0].name);
 
 	for (i = 1; params[i].name; i++)
 		printf("|,%s", params[i].name);
-- 
2.39.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
