Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2E8C4321E
	for <ltp@archiver.kernel.org>; Fri,  2 Dec 2022 11:42:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 66A1E3CC3FF
	for <ltp@archiver.kernel.org>; Fri,  2 Dec 2022 12:42:17 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1AB3C3CC3AA
 for <ltp@lists.linux.it>; Fri,  2 Dec 2022 12:42:07 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 112AD6CE371
 for <ltp@lists.linux.it>; Fri,  2 Dec 2022 12:42:06 +0100 (CET)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CED5A1F88C
 for <ltp@lists.linux.it>; Fri,  2 Dec 2022 11:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669981325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wc79Ymb0yXNlrm6v6JnCEPUNbzbtP9XW8ZevOvTiZJs=;
 b=X8UQM+Lk3nlCgkfmRJhDecfemIfhxp4AGmpnFsxGrU3QK1uqVkN7cUW48xJQazNMHzXBTJ
 0SoNXETZv89Jap+WA5KoWPKUnLOwSwVIbaanofETE9/oVwUvWisVCPxYX7RolanGLAeyrg
 8XBnC0Ctf/BTFiIvcDFClzwVeLPeAy4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669981325;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wc79Ymb0yXNlrm6v6JnCEPUNbzbtP9XW8ZevOvTiZJs=;
 b=nL5L5PvBngi+L3IjcYx2rmvF1dAtnOi+uP4lnN/L6qcvoxUYwCNyV0zX9PZphez6mELqY/
 p2FeTuTbLv5o/qBg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id C025E133DE
 for <ltp@lists.linux.it>; Fri,  2 Dec 2022 11:42:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id NewMLo3kiWPvFAAAGKfGzw
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 02 Dec 2022 11:42:05 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  2 Dec 2022 12:42:05 +0100
Message-Id: <20221202114205.11077-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] cve-2017-16939: Improve and fix test
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

The test was unable to reproduce the kernel bug because it needs to
send then netlink message twice and then close the socket. Sending it
just once is not enough.

Also remove unnecessary structures and code and use taint checks.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/cve/cve-2017-16939.c | 63 ++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 25 deletions(-)

diff --git a/testcases/cve/cve-2017-16939.c b/testcases/cve/cve-2017-16939.c
index e41fb274a..fc3500d57 100644
--- a/testcases/cve/cve-2017-16939.c
+++ b/testcases/cve/cve-2017-16939.c
@@ -29,50 +29,63 @@
 
 #define BUFSIZE 2048
 
-static int fd;
-static struct sockaddr_nl addr;
-
-struct msg_policy {
-	struct nlmsghdr msg;
-	char buf[BUFSIZE];
-};
-static struct msg_policy *p;
+static int fd = -1;
+static struct sockaddr_nl nl_addr;
+static struct nlmsghdr xfrm_msg;
 
 static void setup(void)
 {
 	tst_setup_netns();
 
-	fd = SAFE_SOCKET(PF_NETLINK, SOCK_RAW, NETLINK_XFRM);
-	memset(&addr, 0, sizeof(struct sockaddr_nl));
-	addr.nl_family = AF_NETLINK;
-	addr.nl_pid = 0; /* packet goes into the kernel */
-	addr.nl_groups = XFRMNLGRP_NONE; /* no need for multicast group */
+	nl_addr.nl_family = AF_NETLINK;
+	nl_addr.nl_pid = 0; /* packet goes into the kernel */
+	nl_addr.nl_groups = XFRMNLGRP_NONE; /* no need for multicast group */
 
-	p = SAFE_MALLOC(sizeof(struct msg_policy));
-	memset(p, 0, sizeof(struct msg_policy));
+	xfrm_msg.nlmsg_len = NLMSG_LENGTH(0);
+	xfrm_msg.nlmsg_type = XFRM_MSG_GETPOLICY;
+	xfrm_msg.nlmsg_flags = NLM_F_MATCH | NLM_F_MULTI | NLM_F_REQUEST;
+	xfrm_msg.nlmsg_seq = 0x1;
+	xfrm_msg.nlmsg_pid = 2;
+}
 
-	p->msg.nlmsg_len = 0x10;
-	p->msg.nlmsg_type = XFRM_MSG_GETPOLICY;
-	p->msg.nlmsg_flags = NLM_F_MATCH | NLM_F_MULTI |  NLM_F_REQUEST;
-	p->msg.nlmsg_seq = 0x1;
-	p->msg.nlmsg_pid = 2;
+static void send_nlmsg(int fd, struct nlmsghdr *msg, struct sockaddr_nl *addr)
+{
+	SAFE_SENDTO(1, fd, (void *)msg, msg->nlmsg_len, 0,
+		    (struct sockaddr *)addr, sizeof(struct sockaddr_nl));
 }
 
 static void run(void)
 {
-	int var = 0x100;
+	fd = SAFE_SOCKET(PF_NETLINK, SOCK_RAW, NETLINK_XFRM);
+	SAFE_SETSOCKOPT_INT(fd, SOL_SOCKET, SO_RCVBUF, 0x100);
 
-	SAFE_SETSOCKOPT(fd, SOL_SOCKET, SO_RCVBUF, &var, sizeof(int));
-	SAFE_SENDTO(1, fd, (void *) &p->msg, p->msg.nlmsg_len, 0,
-		    (struct sockaddr *) &addr,
-		    sizeof(struct sockaddr_nl));
+	/* message must be sent twice to trigger the bug */
+	send_nlmsg(fd, &xfrm_msg, &nl_addr);
+	send_nlmsg(fd, &xfrm_msg, &nl_addr);
+	SAFE_CLOSE(fd);
+
+	/* wait for socket close callback to crash */
+	usleep(100000);
+
+	if (tst_taint_check()) {
+		tst_res(TFAIL, "Kernel is vulnerable");
+		return;
+	}
 
 	tst_res(TPASS, "Kernel seems to have survived");
 }
 
+static void cleanup(void)
+{
+	if (fd >= 0)
+		SAFE_CLOSE(fd);
+}
+
 static struct tst_test test = {
 	.setup = setup,
 	.test_all = run,
+	.cleanup = cleanup,
+	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_USER_NS=y",
 		"CONFIG_NET_NS=y",
-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
