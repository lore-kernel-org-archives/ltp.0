Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B57C4332F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 15:35:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC9303CE100
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 16:35:05 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8AB5B3CC8E9
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 16:34:55 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9EC62600F0B
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 16:34:54 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D7EF71FD7E
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 15:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669390493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yAHiwTTFo3SwSc4dvZ/m2imAA3wI+UrspHLfg7udVAs=;
 b=1ubChDP2UeCeeHZMu5R8/TuqPsMN4PbnyPYDignUEAPlbXUQdIm07eoj4VyU5wfm9fUAe3
 uFf2NXHMJDySlIbgOgIqmSYTHQjYrPg1TyXu/CXM7fYst8idsxRTHh07HlD13RoEo5PHif
 JBC9LpXWcId3OkelI8Eg29qOvKnuXME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669390493;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yAHiwTTFo3SwSc4dvZ/m2imAA3wI+UrspHLfg7udVAs=;
 b=zuZTEE4bnDMtyP9ieYnbx13ocf8MRmhwHKvXbomdY5y5YKELLkRxxT5m6/BpIsyQKlnmxW
 X/VU+gLszAFUTSBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C293513B1B
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 15:34:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ePqzLp3ggGNUDgAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 15:34:53 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 25 Nov 2022 16:34:53 +0100
Message-Id: <20221125153453.19323-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221125153453.19323-1-mdoucha@suse.cz>
References: <20221125153453.19323-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] syscalls: Replace namespace setup boilerplate
 with tst_setup_netns()
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

Removing explicit writes into max_user_namespaces sysfile also restores
the ability to run these tests without root privileges.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/cve/cve-2017-16939.c                | 15 +++++++----
 testcases/cve/icmp_rate_limit01.c             | 14 +++-------
 testcases/kernel/syscalls/bind/bind06.c       | 14 ++--------
 testcases/kernel/syscalls/sendmsg/sendmsg03.c | 15 ++++++++---
 testcases/kernel/syscalls/sendto/sendto03.c   | 14 ++--------
 .../kernel/syscalls/setsockopt/setsockopt05.c | 14 ++--------
 .../kernel/syscalls/setsockopt/setsockopt06.c | 15 ++---------
 .../kernel/syscalls/setsockopt/setsockopt07.c | 15 ++---------
 .../kernel/syscalls/setsockopt/setsockopt08.c |  8 ++----
 .../kernel/syscalls/setsockopt/setsockopt09.c | 15 ++---------
 testcases/network/packet/fanout01.c           | 27 +++++++------------
 11 files changed, 48 insertions(+), 118 deletions(-)

diff --git a/testcases/cve/cve-2017-16939.c b/testcases/cve/cve-2017-16939.c
index d8c09014c..eb5400c0c 100644
--- a/testcases/cve/cve-2017-16939.c
+++ b/testcases/cve/cve-2017-16939.c
@@ -13,7 +13,6 @@
  */
 
 #include <unistd.h>
-#include <sched.h>
 #include <stdlib.h>
 #include <string.h>
 #include <sys/socket.h>
@@ -41,10 +40,7 @@ static struct msg_policy *p;
 
 static void setup(void)
 {
-	if (unshare(CLONE_NEWUSER) != 0)
-		tst_brk(TCONF, "unshare(CLONE_NEWUSER) failed");
-	if (unshare(CLONE_NEWNET) != 0)
-		tst_brk(TCONF, "unshare(CLONE_NEWNET) failed");
+	tst_setup_netns();
 
 	fd = SAFE_SOCKET(PF_NETLINK, SOCK_RAW, NETLINK_XFRM);
 	memset(&addr, 0, sizeof(struct sockaddr_nl));
@@ -77,6 +73,15 @@ static void run(void)
 static struct tst_test test = {
 	.setup = setup,
 	.test_all = run,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_USER_NS=y",
+		"CONFIG_NET_NS=y",
+		NULL
+	},
+	.save_restore = (const struct tst_path_val[]) {
+		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
+		{}
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "1137b5e2529a"},
 		{"CVE", "2017-16939"},
diff --git a/testcases/cve/icmp_rate_limit01.c b/testcases/cve/icmp_rate_limit01.c
index 8f876722f..7a51aa0a4 100644
--- a/testcases/cve/icmp_rate_limit01.c
+++ b/testcases/cve/icmp_rate_limit01.c
@@ -29,12 +29,12 @@
 #include <arpa/inet.h>
 #include <linux/errqueue.h>
 
-#include <sched.h>
 #include <limits.h>
 
 #include "lapi/if_addr.h"
 #include "tst_test.h"
 #include "tst_netdevice.h"
+#include "lapi/namespaces_constants.h"
 
 #define DSTNET 0xfa444e00 /* 250.68.78.0 */
 #define SRCNET 0xfa444e40 /* 250.68.78.64 */
@@ -53,19 +53,11 @@ static void setup(void)
 	struct sockaddr_in ipaddr = { .sin_family = AF_INET };
 	uint32_t addr;
 	int i;
-	int real_uid = getuid();
-	int real_gid = getgid();
 
 	for (i = 0; i < SRCADDR_COUNT; i++)
 		fds[i] = -1;
 
-	SAFE_TRY_FILE_PRINTF("/proc/sys/user/max_user_namespaces", "%d", 10);
-
-	SAFE_UNSHARE(CLONE_NEWUSER);
-	SAFE_UNSHARE(CLONE_NEWNET);
-	SAFE_FILE_PRINTF("/proc/self/setgroups", "deny");
-	SAFE_FILE_PRINTF("/proc/self/uid_map", "0 %d 1\n", real_uid);
-	SAFE_FILE_PRINTF("/proc/self/gid_map", "0 %d 1\n", real_gid);
+	tst_setup_netns();
 
 	/*
 	 * Create network namespace to hide the destination interface from
@@ -269,7 +261,7 @@ static struct tst_test test = {
 		NULL
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/user/max_user_namespaces", NULL, TST_SR_SKIP},
+		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/syscalls/bind/bind06.c b/testcases/kernel/syscalls/bind/bind06.c
index f7813d26a..7c3300c42 100644
--- a/testcases/kernel/syscalls/bind/bind06.c
+++ b/testcases/kernel/syscalls/bind/bind06.c
@@ -14,13 +14,11 @@
  *  net/packet: fix a race in packet_bind() and packet_notifier()
  */
 
-#define _GNU_SOURCE
 #include <sys/socket.h>
 #include <sys/ioctl.h>
 #include <linux/if_packet.h>
 #include <net/ethernet.h>
 #include <net/if.h>
-#include <sched.h>
 #include "tst_test.h"
 #include "tst_fuzzy_sync.h"
 
@@ -30,17 +28,9 @@ static struct tst_fzsync_pair fzsync_pair;
 
 static void setup(void)
 {
-	int real_uid = getuid();
-	int real_gid = getgid();
 	struct ifreq ifr;
 
-	SAFE_TRY_FILE_PRINTF("/proc/sys/user/max_user_namespaces", "%d", 10);
-
-	SAFE_UNSHARE(CLONE_NEWUSER);
-	SAFE_UNSHARE(CLONE_NEWNET);
-	SAFE_FILE_PRINTF("/proc/self/setgroups", "deny");
-	SAFE_FILE_PRINTF("/proc/self/uid_map", "0 %d 1\n", real_uid);
-	SAFE_FILE_PRINTF("/proc/self/gid_map", "0 %d 1\n", real_gid);
+	tst_setup_netns();
 
 	fd = SAFE_SOCKET(AF_PACKET, SOCK_DGRAM, PF_PACKET);
 	strcpy(ifr.ifr_name, "lo");
@@ -110,7 +100,7 @@ static struct tst_test test = {
 		NULL
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/user/max_user_namespaces", NULL, TST_SR_SKIP},
+		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/syscalls/sendmsg/sendmsg03.c b/testcases/kernel/syscalls/sendmsg/sendmsg03.c
index 505a6dd24..38459990f 100644
--- a/testcases/kernel/syscalls/sendmsg/sendmsg03.c
+++ b/testcases/kernel/syscalls/sendmsg/sendmsg03.c
@@ -15,11 +15,9 @@
  *
  *  net: ipv4: fix for a race condition in raw_sendmsg
  */
-#define _GNU_SOURCE
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <netinet/in.h>
-#include <sched.h>
 #include "tst_test.h"
 #include "tst_fuzzy_sync.h"
 
@@ -38,8 +36,8 @@ static void setup(void)
 {
 	int i;
 
-	SAFE_UNSHARE(CLONE_NEWUSER);
-	SAFE_UNSHARE(CLONE_NEWNET);
+	tst_setup_netns();
+
 	sockfd = SAFE_SOCKET(AF_INET, SOCK_RAW, IPPROTO_ICMP);
 
 	memset(buf, 0xcc, PACKET_SIZE);
@@ -106,6 +104,15 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.max_runtime = 150,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_USER_NS=y",
+		"CONFIG_NET_NS=y",
+		NULL
+	},
+	.save_restore = (const struct tst_path_val[]) {
+		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
+		{}
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "8f659a03a0ba"},
 		{"CVE", "2017-17712"},
diff --git a/testcases/kernel/syscalls/sendto/sendto03.c b/testcases/kernel/syscalls/sendto/sendto03.c
index 3709b287c..b07d5122b 100644
--- a/testcases/kernel/syscalls/sendto/sendto03.c
+++ b/testcases/kernel/syscalls/sendto/sendto03.c
@@ -17,7 +17,6 @@
  *  net/packet: fix overflow in tpacket_rcv
  */
 
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <limits.h>
 #include <sys/types.h>
@@ -25,7 +24,6 @@
 #include <sys/ioctl.h>
 #include <net/if.h>
 #include <net/ethernet.h>
-#include <sched.h>
 
 #include "tst_test.h"
 #include "tst_net.h"
@@ -39,17 +37,9 @@ static struct sockaddr_ll bind_addr, addr;
 
 static void setup(void)
 {
-	int real_uid = getuid();
-	int real_gid = getgid();
 	struct ifreq ifr;
 
-	SAFE_TRY_FILE_PRINTF("/proc/sys/user/max_user_namespaces", "%d", 10);
-
-	SAFE_UNSHARE(CLONE_NEWUSER);
-	SAFE_UNSHARE(CLONE_NEWNET);
-	SAFE_FILE_PRINTF("/proc/self/setgroups", "deny");
-	SAFE_FILE_PRINTF("/proc/self/uid_map", "0 %d 1", real_uid);
-	SAFE_FILE_PRINTF("/proc/self/gid_map", "0 %d 1", real_gid);
+	tst_setup_netns();
 
 	sock = SAFE_SOCKET(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
 	strcpy(ifr.ifr_name, "lo");
@@ -218,7 +208,7 @@ static struct tst_test test = {
 		NULL
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/user/max_user_namespaces", NULL, TST_SR_SKIP},
+		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt05.c b/testcases/kernel/syscalls/setsockopt/setsockopt05.c
index 580467dc8..3263da98a 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt05.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt05.c
@@ -17,13 +17,11 @@
  *  udp: consistently apply ufo or fragmentation
  */
 
-#define _GNU_SOURCE
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <netinet/in.h>
 #include <sys/ioctl.h>
 #include <net/if.h>
-#include <sched.h>
 
 #include "tst_test.h"
 #include "tst_net.h"
@@ -35,18 +33,10 @@ static int dst_sock = -1;
 
 static void setup(void)
 {
-	int real_uid = getuid();
-	int real_gid = getgid();
 	struct ifreq ifr;
 	socklen_t addrlen = sizeof(addr);
 
-	SAFE_TRY_FILE_PRINTF("/proc/sys/user/max_user_namespaces", "%d", 10);
-
-	SAFE_UNSHARE(CLONE_NEWUSER);
-	SAFE_UNSHARE(CLONE_NEWNET);
-	SAFE_FILE_PRINTF("/proc/self/setgroups", "deny");
-	SAFE_FILE_PRINTF("/proc/self/uid_map", "0 %d 1", real_uid);
-	SAFE_FILE_PRINTF("/proc/self/gid_map", "0 %d 1", real_gid);
+	tst_setup_netns();
 
 	tst_init_sockaddr_inet_bin(&addr, INADDR_LOOPBACK, 0);
 	dst_sock = SAFE_SOCKET(AF_INET, SOCK_DGRAM, 0);
@@ -102,7 +92,7 @@ static struct tst_test test = {
 		NULL
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/user/max_user_namespaces", NULL, TST_SR_SKIP},
+		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt06.c b/testcases/kernel/syscalls/setsockopt/setsockopt06.c
index e67996a78..00dc69bfb 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt06.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt06.c
@@ -16,11 +16,9 @@
  *  packet: fix race condition in packet_set_ring
  */
 
-#define _GNU_SOURCE
 #include <unistd.h>
 #include <sys/types.h>
 #include <sys/socket.h>
-#include <sched.h>
 
 #include "tst_test.h"
 #include "tst_fuzzy_sync.h"
@@ -33,17 +31,8 @@ static struct tst_fzsync_pair fzsync_pair;
 
 static void setup(void)
 {
-	int real_uid = getuid();
-	int real_gid = getgid();
-
 	pagesize = SAFE_SYSCONF(_SC_PAGESIZE);
-	SAFE_TRY_FILE_PRINTF("/proc/sys/user/max_user_namespaces", "%d", 10);
-
-	SAFE_UNSHARE(CLONE_NEWUSER);
-	SAFE_UNSHARE(CLONE_NEWNET);
-	SAFE_FILE_PRINTF("/proc/self/setgroups", "deny");
-	SAFE_FILE_PRINTF("/proc/self/uid_map", "0 %d 1", real_uid);
-	SAFE_FILE_PRINTF("/proc/self/gid_map", "0 %d 1", real_gid);
+	tst_setup_netns();
 
 	fzsync_pair.exec_loops = 100000;
 	tst_fzsync_pair_init(&fzsync_pair);
@@ -130,7 +119,7 @@ static struct tst_test test = {
 		NULL
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/user/max_user_namespaces", NULL, TST_SR_SKIP},
+		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt07.c b/testcases/kernel/syscalls/setsockopt/setsockopt07.c
index 1c5a0ed6d..f6f94ad97 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt07.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt07.c
@@ -19,11 +19,9 @@
  *  packet: fix tp_reserve race in packet_set_ring
  */
 
-#define _GNU_SOURCE
 #include <unistd.h>
 #include <sys/types.h>
 #include <sys/socket.h>
-#include <sched.h>
 
 #include "tst_test.h"
 #include "tst_fuzzy_sync.h"
@@ -36,17 +34,8 @@ static struct tst_fzsync_pair fzsync_pair;
 
 static void setup(void)
 {
-	int real_uid = getuid();
-	int real_gid = getgid();
-
 	pagesize = SAFE_SYSCONF(_SC_PAGESIZE);
-	SAFE_TRY_FILE_PRINTF("/proc/sys/user/max_user_namespaces", "%d", 10);
-
-	SAFE_UNSHARE(CLONE_NEWUSER);
-	SAFE_UNSHARE(CLONE_NEWNET);
-	SAFE_FILE_PRINTF("/proc/self/setgroups", "deny");
-	SAFE_FILE_PRINTF("/proc/self/uid_map", "0 %d 1", real_uid);
-	SAFE_FILE_PRINTF("/proc/self/gid_map", "0 %d 1", real_gid);
+	tst_setup_netns();
 
 	/*
 	 * Reproducing the bug on unpatched system takes <15 loops. The test
@@ -143,7 +132,7 @@ static struct tst_test test = {
 		NULL
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/user/max_user_namespaces", NULL, TST_SR_SKIP},
+		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt08.c b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
index a29125fd7..5fc1a8b8e 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt08.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
@@ -84,7 +84,6 @@
 #include "tst_test.h"
 #include "tst_safe_net.h"
 #include "lapi/ip_tables.h"
-#include "lapi/namespaces_constants.h"
 
 static void *buffer;
 
@@ -95,10 +94,7 @@ void setup(void)
 			"The vulnerability was only present in 32-bit compat mode");
 	}
 
-	SAFE_TRY_FILE_PRINTF("/proc/sys/user/max_user_namespaces", "%d", 10);
-
-	SAFE_UNSHARE(CLONE_NEWUSER);
-	SAFE_UNSHARE(CLONE_NEWNET);
+	tst_setup_netns();
 }
 
 void run(void)
@@ -159,7 +155,7 @@ static struct tst_test test = {
 		NULL
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/user/max_user_namespaces", NULL, TST_SR_SKIP},
+		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt09.c b/testcases/kernel/syscalls/setsockopt/setsockopt09.c
index b49b17e7d..9ed80e46b 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt09.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt09.c
@@ -26,11 +26,9 @@
  *  packet: fix use-after-free in prb_retire_rx_blk_timer_expired()
  */
 
-#define _GNU_SOURCE
 #include <unistd.h>
 #include <sys/types.h>
 #include <sys/socket.h>
-#include <sched.h>
 
 #include "tst_test.h"
 #include "lapi/if_packet.h"
@@ -40,17 +38,8 @@ static unsigned int pagesize;
 
 static void setup(void)
 {
-	int real_uid = getuid();
-	int real_gid = getgid();
-
 	pagesize = SAFE_SYSCONF(_SC_PAGESIZE);
-	SAFE_TRY_FILE_PRINTF("/proc/sys/user/max_user_namespaces", "%d", 10);
-
-	SAFE_UNSHARE(CLONE_NEWUSER);
-	SAFE_UNSHARE(CLONE_NEWNET);
-	SAFE_FILE_PRINTF("/proc/self/setgroups", "deny");
-	SAFE_FILE_PRINTF("/proc/self/uid_map", "0 %d 1", real_uid);
-	SAFE_FILE_PRINTF("/proc/self/gid_map", "0 %d 1", real_gid);
+	tst_setup_netns();
 }
 
 static void run(void)
@@ -124,7 +113,7 @@ static struct tst_test test = {
 		NULL
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/user/max_user_namespaces", NULL, TST_SR_SKIP},
+		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/network/packet/fanout01.c b/testcases/network/packet/fanout01.c
index 0aad3321b..4243f8400 100644
--- a/testcases/network/packet/fanout01.c
+++ b/testcases/network/packet/fanout01.c
@@ -13,7 +13,6 @@
  * See blogpost in copyright notice for more details.
  */
 #include <errno.h>
-#include <sched.h>
 #include <sys/types.h>
 #include <net/if.h>
 #include <linux/if_packet.h>
@@ -22,7 +21,6 @@
 #include "tst_test.h"
 #include "tst_fuzzy_sync.h"
 #include "lapi/if_packet.h"
-#include "lapi/namespaces_constants.h"
 
 static struct tst_fzsync_pair pair;
 static int fd;
@@ -30,21 +28,7 @@ static struct sockaddr_ll addr;
 
 void setup(void)
 {
-	int real_uid = getuid();
-	int real_gid = getgid();
-
-	TEST(unshare(CLONE_NEWUSER));
-	if (TST_RET)
-		tst_brk(TBROK | TTERRNO, "Can't create new user namespace");
-
-	TEST(unshare(CLONE_NEWNET));
-	if (TST_RET)
-		tst_brk(TBROK | TTERRNO, "Can't create new net namespace");
-
-	FILE_PRINTF("/proc/self/setgroups", "deny");
-	FILE_PRINTF("/proc/self/uid_map", "0 %d 1\n", real_uid);
-	FILE_PRINTF("/proc/self/gid_map", "0 %d 1\n", real_gid);
-
+	tst_setup_netns();
 	tst_fzsync_pair_init(&pair);
 }
 
@@ -107,6 +91,15 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.needs_root = 1,
 	.max_runtime = 180,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_USER_NS=y",
+		"CONFIG_NET_NS=y",
+		NULL
+	},
+	.save_restore = (const struct tst_path_val[]) {
+		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
+		{}
+	},
 	.tags = (const struct tst_tag[]) {
 		{"CVE", "2017-15649"},
 		{"linux-git", "4971613c1639"},
-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
