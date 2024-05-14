Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C40C25B74
	for <ltp@archiver.kernel.org>; Fri, 24 May 2024 06:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1716533293; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=PCQcmRxvC9gbrXlHfnJgfgyH7vOMVlP44aZztFOtUqU=;
 b=lw0PMDwA2W6wRUryZG/uW0eFWkWwfXHZN/OqsEDcSscgRjWagMChHX8lCgyM3KTu/P8oC
 K9LVtpNVnY0NZgCk5A8iQ3StkvzcehwFHnkIyO2CnyIXV3U6N2s7jOftOxthyaTaGbnC9mU
 DBgXahhEmxulX2eLKanBXz8Fld21KL8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D9813D017B
	for <ltp@archiver.kernel.org>; Fri, 24 May 2024 08:48:13 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C63A3D01AC
 for <ltp@lists.linux.it>; Fri, 24 May 2024 08:47:27 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.36.225;
 helo=esa10.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com
 [139.138.36.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6F014201DB6
 for <ltp@lists.linux.it>; Fri, 24 May 2024 08:47:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1716533246; x=1748069246;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bkYX4l3sNyfB8RUqL/T5Qi87aUooKeluAnpKWbI+C4A=;
 b=IVpkIG0Ir0zZoID41Lq3WDum7NOj0iGxpppeFKr4gewLV0564p7orwg7
 pvBlSI9TtSS7xtYdSopykBOFc86NtXelIbPGpqWiDk+ojm/7BH/wzPIbR
 rldw31mvHKBpTxszHe1saivdVW5K4uzfOIShGSuudsoUwoMHxyYaAFfWu
 XK32AlB2MqviJFwFqlSBkk7U0sG5eqqxo50N11z3F1R4cWLG8ZC/fQQ2K
 qSII2BYZmC0zgO4nAzdJlTnzo8ru8Zboh7PRqktJ3+nofZbzcqjl4/6vT
 V/AwzUJzjyzdCNR3raWGPQL/zxgHqjtygPkuvTrFwmUM4uaBx4kOBDleu g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="147140313"
X-IronPort-AV: E=Sophos;i="6.08,184,1712588400"; d="scan'208";a="147140313"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2024 15:47:23 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 071DEC68E1
 for <ltp@lists.linux.it>; Fri, 24 May 2024 15:47:22 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 1EF09C4A14
 for <ltp@lists.linux.it>; Fri, 24 May 2024 15:47:21 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id A03E66B8D4
 for <ltp@lists.linux.it>; Fri, 24 May 2024 15:47:20 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id ECBEF1A000A;
 Fri, 24 May 2024 14:47:19 +0800 (CST)
To: ltp@lists.linux.it
Date: Tue, 14 May 2024 00:51:10 -0400
Message-Id: <20240514045110.85640-2-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240514045110.85640-1-xuyang2018.jy@fujitsu.com>
References: <20240514045110.85640-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28406.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28406.005
X-TMASE-Result: 10--5.745900-10.000000
X-TMASE-MatchedRID: 2wfub8HDRfNSuJfEWZSQfBvMKxHA9efN2FA7wK9mP9dgPgeggVwCFr8F
 Hrw7frluf146W0iUu2tvedD3CYSjHa3GFfJOpzTZBe3KRVyu+k2yTrWV4vwyXyadmYRsugC+07z
 aVZEg+DN+MWqCVY0TmnAPz30EFx7+7PE1ojYEvaH/V0SDC1Do0FZboOoSEvIwACF5TKaad1/ESY
 bFHuYue/+vfH78Rkg8gDLqnrRlXrZ8nn9tnqel2DsAVzN+Ov/s/1hLyQ4p3V2yiZj5BsBv2wJNX
 5uxmOqogCWLBAABhJHm6vxFyx1A7g==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] connect01: Add negative tests
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

Add negative cases for connect(), when errno is EPROTOTYPE or EACCES

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/connect/connect01.c | 54 ++++++++++++++++++-
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/connect/connect01.c b/testcases/kernel/syscalls/connect/connect01.c
index 52a6f154b..97d360482 100644
--- a/testcases/kernel/syscalls/connect/connect01.c
+++ b/testcases/kernel/syscalls/connect/connect01.c
@@ -18,19 +18,26 @@
 #include "tst_test.h"
 #include "lapi/syscalls.h"
 
+#define SOCK_FILE "sock_file"
+
+static struct passwd *pw;
+
 static int fd_share;
 static int fd_server;
 
 static struct sockaddr_in sock1;
 static struct sockaddr_in sock2;
 static struct sockaddr_in sock3;
+static struct sockaddr_un sock4;
 
 static pid_t pid;
 
 static void setup1(unsigned int);
 static void setup2(unsigned int);
 static void setup3(unsigned int);
+static void setup4(unsigned int);
 static void cleanup1(void);
+static void cleanup2(void);
 
 static struct test_case_t {
 	int domain;
@@ -64,6 +71,12 @@ static struct test_case_t {
 	{PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&sock3,
 		sizeof(sock3), EAFNOSUPPORT, setup2, cleanup1,
 		"address doesn't have the correct address family in sa_family"},
+	{AF_UNIX, SOCK_DGRAM, 0, (struct sockaddr *)&sock4,
+		sizeof(sock4), EPROTOTYPE, setup4, cleanup2,
+		"socket type does not support the protocol"},
+	{AF_UNIX, SOCK_STREAM, 0, (struct sockaddr *)&sock4,
+		sizeof(sock4), EACCES, setup4, cleanup2,
+		"write permission is denied on the socket file"},
 };
 
 static int sys_connect(int sockfd, const struct sockaddr *addr,
@@ -145,6 +158,11 @@ static void setup(void)
 	sock3.sin_family = 47;
 	sock3.sin_port = 0;
 	sock3.sin_addr.s_addr = htonl(0x0AFFFEFD);
+
+	sock4.sun_family = AF_UNIX;
+	strncpy(sock4.sun_path, SOCK_FILE, sizeof(sock4.sun_path));
+
+	pw = SAFE_GETPWNAM("nobody");
 }
 
 static void setup1(unsigned int i)
@@ -170,21 +188,53 @@ static void setup3(unsigned int i)
 	SAFE_CONNECT(fd_server, (const struct sockaddr *)&sock1, sizeof(sock1));
 }
 
+static void setup4(unsigned int i)
+{
+	struct test_case_t *tc = &tcases[i];
+
+	fd_share = SAFE_SOCKET(tc->domain, tc->type, tc->proto);
+	fd_server = SAFE_SOCKET(AF_UNIX, SOCK_STREAM, 0);
+	SAFE_BIND(fd_server, tc->sockaddr, tc->salen);
+	SAFE_LISTEN(fd_server, 5);
+}
+
 static void cleanup1(void)
 {
 	if (fd_share > 0)
 		SAFE_CLOSE(fd_share);
 }
 
+static void cleanup2(void)
+{
+	if (fd_share > 0)
+		SAFE_CLOSE(fd_share);
+	if (fd_server > 0)
+		SAFE_CLOSE(fd_server);
+	SAFE_UNLINK(SOCK_FILE);
+}
+
 static void verify_connect(unsigned int i)
 {
 	struct test_case_t *tc = &tcases[i];
+	pid_t pid_child;
 
 	start_server(&sock1);
 	if (tc->setup)
 		tc->setup(i);
-	TST_EXP_FAIL(sys_connect(fd_share, tc->sockaddr, tc->salen),
-		tc->exp_errno, "%s", tc->desc);
+	if (tc->exp_errno == EACCES) {
+		pid_child = SAFE_FORK();
+		if (!pid_child) {
+			SAFE_SETUID(pw->pw_uid);
+			TST_EXP_FAIL(
+				sys_connect(fd_share, tc->sockaddr, tc->salen),
+				tc->exp_errno, "%s", tc->desc);
+			exit(0);
+		}
+		SAFE_WAITPID(pid_child, NULL, 0);
+	} else {
+		TST_EXP_FAIL(sys_connect(fd_share, tc->sockaddr, tc->salen),
+			tc->exp_errno, "%s", tc->desc);
+	}
 	SAFE_KILL(pid, SIGKILL);
 	SAFE_WAITPID(pid, NULL, 0);
 	if (tc->cleanup)
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
