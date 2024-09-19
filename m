Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C3CCE8D45
	for <ltp@archiver.kernel.org>; Thu, 19 Sep 2024 03:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1726716883; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=lraMTbcILHV7ELT1Im+4duwMegdqIBpXw5DltQTMbro=;
 b=oznRcYqyxBg6+kpunldDGAr9GQiHao4BaNE9hbd+buVADgFzXK4Zl9u52GGlnzh/crLN2
 GLjlOEFPIgazxsuDcZ/UIGBRTtFzi6A3A/nDt2GTSgopZu5VX2Hz/Fz51mLPskDgjdhRZ0N
 WKIhE5i3DZoKP2nELS61c2LnExnw5tw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 705C83C2F3D
	for <ltp@archiver.kernel.org>; Thu, 19 Sep 2024 05:34:43 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E6A803C03AD
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 05:34:22 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.48;
 helo=esa2.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com
 [207.54.90.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DFE921400BED
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 05:34:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1726716862; x=1758252862;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=xa+yycs7JTKIb6LLqoNU86zEocNqalhPQclnq/ElDEk=;
 b=haLU9Id3lUqFLakoPClxBkK1K5sApkFeRzD7q2DzOBT8RdX1CA8yfi8l
 7Zt12XnuDiGPUxvRUoEpOq4fD+MKQoDRGA2es1Cn735JDHh/Vluob9TeS
 3q3jrAZ0RODW2x4UTBENaVbr5B+xyEZ4qgQXbeaeQX4BQMCQjkZ2vqx1j
 fnullaxB4YofVFAkzYKb0LSQTG8sUcTi/PEZlxeAcnmrUCWXWgnQQj/4G
 IUp6cIrbAKJxJmvn9EfyTGxZeIT3c9vZsbdyELIYCy3mC3n7DnaBimZwx
 u4p5SIXP7Mra13SJ+eKo8fFOTD0MKbq9QyqnEgBKQr3zphpTRrX/a/5jd w==;
X-CSE-ConnectionGUID: fRPONeiSTGmL8xUFMTUGYw==
X-CSE-MsgGUID: Yix4exvLQ4OaVyB+9KnWcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="174176277"
X-IronPort-AV: E=Sophos;i="6.10,240,1719846000"; d="scan'208";a="174176277"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2024 12:34:19 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 76422E428A
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 12:34:16 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id AB38910350
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 12:34:15 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 2C8BF20086EA0
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 12:34:15 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 97DEC1A000A;
 Thu, 19 Sep 2024 11:34:14 +0800 (CST)
To: ltp@lists.linux.it,
	chrubis@suse.cz
Date: Thu, 19 Sep 2024 11:27:29 +0800
Message-ID: <20240919032729.458711-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28672.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28672.004
X-TMASE-Result: 10--3.213100-10.000000
X-TMASE-MatchedRID: /eTrdDzEmrZjc4vsClPvEwPZZctd3P4BFGFgogmHpnHAuQ0xDMaXkLKo
 UszL+Vmm+FyTwBk2ojzRKmOlruuzzkfr6WG4Th9aSs47mbT7SARZDdHiTk9OcGvlGb+24NaZQo6
 O4KTi9/Uf9OAqZEL+UoAy6p60ZV62G2i4y8P2xXndB/CxWTRRu+rAZ8KTspSzqVLQuRme7N12hc
 uv4bFn+LT+23WwUiGbKEiU7+HKuRdPxfZ14TvKLXR/Rp0VYCi50IheacnqaDgVjK+2A0s9W/XU3
 QAZI2agIcmnZRhVxyrE4HwnSlEuHInEpJmLAFfpC1FNc6oqYVV+3BndfXUhXQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] posix/conformance/interfaces/sem_timedwait/2-1:
 Remove MAP_ANONYMOUS
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
From: Ma Xinjian via ltp <ltp@lists.linux.it>
Reply-To: Ma Xinjian <maxj.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

MAP_ANONYMOUS is not part of POSIX, so remove it from open posix testsuit.
And use open_shm to get the file descriptor.

Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
---
 .../interfaces/sem_timedwait/2-1.c            | 24 +++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/2-1.c
index 2eca8dff6..b1747f01d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/2-1.c
@@ -24,6 +24,7 @@
 #include "posixtest.h"
 
 #define TEST "2-1"
+#define SHM_NAME "posixtest_2-1"
 #define FUNCTION "sem_timedwait"
 #define ERROR_PREFIX "unexpected error: " FUNCTION " " TEST ": "
 
@@ -31,8 +32,25 @@ int main(void)
 {
 	sem_t *mysemp;
 	struct timespec ts;
-	int pid;
-	mysemp = mmap(NULL, sizeof(*mysemp), PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	int fd, pid;
+
+	fd = shm_open(SHM_NAME, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR);
+	if (fd == -1) {
+		perror("An error occurs when calling shm_open()");
+		return PTS_UNRESOLVED;
+	}
+
+	if (ftruncate(fd, sizeof(*mysemp)) == -1) {
+		perror("An error occurs when calling ftruncate()");
+		return PTS_UNRESOLVED;
+	}
+
+	if (shm_unlink(SHM_NAME) != 0) {
+		perror("An error occurs when calling shm_unlink()");
+		return PTS_UNRESOLVED;
+	}
+
+	mysemp = mmap(NULL, sizeof(*mysemp), PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
 	if (mysemp == MAP_FAILED) {
 		perror(ERROR_PREFIX "mmap");
 		return PTS_UNRESOLVED;
@@ -82,5 +100,7 @@ int main(void)
 		}
 		return PTS_PASS;
 	}
+
+	close(fd);
 	return PTS_UNRESOLVED;
 }
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
