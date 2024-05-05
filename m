Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD0AC10F1A
	for <ltp@archiver.kernel.org>; Wed,  8 May 2024 02:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1715137008; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=SXeGXOxKICeJQ3Ru6YObPO3vTrFuyNTGBUGm2RVdCgc=;
 b=quxGPaPBVSgJ4TdYV3Exb6DVv/TTroxzZPF9cZ5+D9Yq5B8lfoYzROFUx75TX7ePWmNqK
 a8Yuggk8sZvd8xohuFCTX53yhSjk+m45NIF1g+RGWwBe25qko94votFzKLYz/CO9iq0mkev
 vV7XswOh2OLqwlG0ZygVWla+DirBRG8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 885D73CDC2C
	for <ltp@archiver.kernel.org>; Wed,  8 May 2024 04:56:48 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5FDC23CD806
 for <ltp@lists.linux.it>; Wed,  8 May 2024 04:56:27 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.36.225;
 helo=esa10.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com
 [139.138.36.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 282CB2220BD
 for <ltp@lists.linux.it>; Wed,  8 May 2024 04:56:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1715136987; x=1746672987;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=fQXfs/5SksTMogvb1fM1VYhoXH83yIb1LzvgbcbbfXg=;
 b=atxCvCpVIW5WYBll9bMjDP20vNLsjPLhkbpO1l3O+ckv1wkDZuYr9L7w
 inp0RWo2amkHfh0YNX8TXYaqyf5+tjzwJrHwK4B3xhtehEGy8LWn27MMo
 L/LjEquphitYSCym5DwNNcAr+jSk9kKHjwOsxEVg2QOmVmxXnTTOeIBnW
 9zcj60HRFsz7lRQaeO1NFOKbZZrXyBVlVt6C1vbBSESbaqxaVcshsETtO
 fRF/njI08TG3YPQvMdyGV6kseTv33LmxA3oBrGvq3rX2nxDmxICz7AQax
 af+RMxt0wgKC3fwVNdfKG2Yd3HFLDgzBETIVaIVYvA5CgKycv5W7tJAIQ Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="145204033"
X-IronPort-AV: E=Sophos;i="6.08,143,1712588400"; d="scan'208";a="145204033"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2024 11:56:23 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com
 [192.168.83.65])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 16005C68A8
 for <ltp@lists.linux.it>; Wed,  8 May 2024 11:56:20 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 52263D5461
 for <ltp@lists.linux.it>; Wed,  8 May 2024 11:56:19 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id C0F0E202CE130
 for <ltp@lists.linux.it>; Wed,  8 May 2024 11:56:18 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 547711A0002;
 Wed,  8 May 2024 10:56:18 +0800 (CST)
To: ltp@lists.linux.it
Date: Sun,  5 May 2024 02:17:46 -0400
Message-Id: <20240505061746.77510-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28368.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28368.004
X-TMASE-Result: 10--6.106300-10.000000
X-TMASE-MatchedRID: 2wfub8HDRfNSuJfEWZSQfB1kSRHxj+Z5TfK5j0EZbysc5SGKNk1CG7h+
 pYnZ0bxF8YMGIR6ZqjVVmNrvsGRXOqGGOyqBK41vEXjPIvKd74BMkOX0UoduuUz5vzLEGq8D09D
 6Rw2zIrM2xy17I1v5+P/obOPM9tlrfDMsmEXCX5hVXhlmZsTdjKTYf9v9flolGPh40PSDz6yFcC
 v6HgZ9MJoi4Fk1Ww9PgDLqnrRlXrZ8nn9tnqel2DsAVzN+Ov/siLRc0yVq+ZNGEd/AZObmvXaGG
 RYiaY7UiSaQgzqoE0KaImDMZRpumg==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] bind: Add negative tests for bind
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
From: Yang Xu via ltp <ltp@lists.linux.it>
Reply-To: Yang Xu <xuyang2018.jy@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add negative cases for bind(), when errno is EBADF or ENOTDIR.
Also fix some format check warning for existed code.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/bind/bind01.c | 36 ++++++++++++++++++-------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/bind/bind01.c b/testcases/kernel/syscalls/bind/bind01.c
index c008819a8..6d8338a22 100644
--- a/testcases/kernel/syscalls/bind/bind01.c
+++ b/testcases/kernel/syscalls/bind/bind01.c
@@ -17,11 +17,16 @@
 
 #include "tst_test.h"
 
-int inet_socket;
-int dev_null;
+#define DIR_ENOTDIR "dir_enotdir"
+#define TEST_ENOTDIR "test_enotdir"
 
-struct sockaddr_in sin1, sin2, sin3;
-struct sockaddr_un sun;
+static int inet_socket;
+static int dev_null;
+static int fd_ebadf;
+static int fd_enotdir;
+
+static struct sockaddr_in sin1, sin2, sin3;
+static struct sockaddr_un sun, sock_enotdir;
 
 static struct test_case {
 	int *socket_fd;
@@ -41,24 +46,28 @@ static struct test_case {
 	  EAFNOSUPPORT, "UNIX-domain of current directory" },
 	{ &inet_socket, (struct sockaddr *)&sin3, sizeof(sin3), -1,
 	  EADDRNOTAVAIL, "non-local address" },
+	{ &fd_ebadf, (struct sockaddr *)&sin1, sizeof(sin1), -1,
+	  EBADF, "sockfd is not a valid file descriptor" },
+	{ &fd_enotdir, (struct sockaddr *)&sock_enotdir, sizeof(sock_enotdir), -1,
+	  ENOTDIR, "a component of addr prefix is not a directory"},
 };
 
-void verify_bind(unsigned int nr)
+static void verify_bind(unsigned int nr)
 {
 	struct test_case *tcase = &tcases[nr];
 
 	if (tcase->experrno) {
 		TST_EXP_FAIL(bind(*tcase->socket_fd, tcase->sockaddr, tcase->salen),
-		             tcase->experrno, "%s", tcase->desc);
+				tcase->experrno, "%s", tcase->desc);
 	} else {
 		TST_EXP_PASS(bind(*tcase->socket_fd, tcase->sockaddr, tcase->salen),
-		             "%s", tcase->desc);
+				"%s", tcase->desc);
 		SAFE_CLOSE(inet_socket);
 		inet_socket = SAFE_SOCKET(PF_INET, SOCK_STREAM, 0);
 	}
 }
 
-void test_setup(void)
+static void test_setup(void)
 {
 	/* initialize sockaddr's */
 	sin1.sin_family = AF_INET;
@@ -78,14 +87,22 @@ void test_setup(void)
 	sun.sun_family = AF_UNIX;
 	strncpy(sun.sun_path, ".", sizeof(sun.sun_path));
 
+	SAFE_TOUCH(DIR_ENOTDIR, 0777, NULL);
+	sock_enotdir.sun_family = AF_UNIX;
+	strncpy(sock_enotdir.sun_path, DIR_ENOTDIR "/" TEST_ENOTDIR,
+		sizeof(sock_enotdir.sun_path));
+
 	inet_socket = SAFE_SOCKET(PF_INET, SOCK_STREAM, 0);
 	dev_null = SAFE_OPEN("/dev/null", O_WRONLY);
+	fd_ebadf = -1;
+	fd_enotdir = SAFE_SOCKET(AF_UNIX, SOCK_STREAM, 0);
 }
 
-void test_cleanup(void)
+static void test_cleanup(void)
 {
 	SAFE_CLOSE(inet_socket);
 	SAFE_CLOSE(dev_null);
+	SAFE_CLOSE(fd_enotdir);
 }
 
 static struct tst_test test = {
@@ -93,4 +110,5 @@ static struct tst_test test = {
 	.setup = test_setup,
 	.cleanup = test_cleanup,
 	.test = verify_bind,
+	.needs_tmpdir = 1,
 };
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
