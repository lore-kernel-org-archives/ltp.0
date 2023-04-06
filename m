Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5737CC76196
	for <ltp@archiver.kernel.org>; Thu,  6 Apr 2023 05:41:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 583E83CC726
	for <ltp@archiver.kernel.org>; Thu,  6 Apr 2023 07:41:39 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 531973CC72F
 for <ltp@lists.linux.it>; Thu,  6 Apr 2023 07:41:21 +0200 (CEST)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A0800200340
 for <ltp@lists.linux.it>; Thu,  6 Apr 2023 07:41:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1680759679; i=@fujitsu.com;
 bh=9DxWK2tbYyu5/brN8GelV3mERG5UOKb+6PysFuVVIj4=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=TCE0AJgH7N2MaapyXJGFx9c2RDAfK+uLMwXrGr/zgA07Y8lLWbvbbGdCbGbmL8mZ2
 VKHphTEch1PEXL360Cs9ir/Yy3u9NyANDJ6QFdf12kAvTEQmTuWunZ72NBSoNKWndT
 hv696gg4DqJPIetiAFAfCDT2iJip3DicVoaAreZwCU983CpWpmiVRhaGZwzu+UNxu4
 5hNmSBjjpFyKq8EB5SZ3zYZtRx9G7GJvX4lWcLImSA+SD+E9Y38ZuSjhmHUHj1+RC/
 pjOOMb/3HuFR0p6XGXAMSgwKNR+cI1Z9Dxlj9eIrXebSt45rCzjJIR7/gx6eSv04ys
 IUiX3ZpSanPPg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRWlGSWpSXmKPExsViZ8MxSbcuWi/
 F4PVeRYu1e/4wW6z4voPRgclj06pONo99v9exBjBFsWbmJeVXJLBm9H67y1ZwR7hifs9d5gbG
 /wJdjFwcQgJbGCUe3X3JDuEsZ5L4OOczI4Szh1HiyL9LTF2MnBxsApoSzzoXMIPYIgISEh0Nb
 9lBbGYBO4k7i5uA4hwcwgJuEnunuIGEWQRUJHbOOcwKYvMKeEhsPP0KrFxCQEFiysP3YOWcAp
 4S396Wg4SFBAolXu14xAxRLihxcuYTFojpEhIHX7xghmhVkmhrvcIKYVdINE4/xARhq0lcPbe
 JeQKj4Cwk7bOQtC9gZFrFaFqcWlSWWqRrppdUlJmeUZKbmJmjl1ilm6iXWqpbnlpcomuol1he
 rJdaXKxXXJmbnJOil5dasokRGMwpxQw3djDO6furd4hRkoNJSZR3ropOihBfUn5KZUZicUZ8U
 WlOavEhRhkODiUJ3l1ReilCgkWp6akVaZk5wMiCSUtw8CiJ8C70A0rzFhck5hZnpkOkTjEqSo
 nzXgbpEwBJZJTmwbXBovkSo6yUMC8jAwODEE9BalFuZgmq/CtGcQ5GJWHeapApPJl5JXDTXwE
 tZgJabOuvA7K4JBEhJdXAxH3ZMmTFluXtzZ7vt2l+uMRyy5b/8peC6qPzrfTPSv07Gt13NPa2
 Z6zb+1dxG1QUYxPWiDF91G81qtu6kTfCr0PTw9VZn7VLJ+b+wnMNdYXuh/s77Ra/D1+ySTRRS
 iU8tV5mh3bpPsnmC01TX+0Jam5ICzyWtyD757oD0ruWx1us2sdZ0LYjV7HT2NqqzK+0TflSSr
 2DpvKcnxuWJ/67dvHa6/CX0zKlyzVFPz9/0jE5LbB7oZ3KatsY8Y+9PtlKiXMTObrsPLy1Lj7
 5cyhlk8gUlxXP0+5sMFw+9+U5PtOWXb9s3iWW9t34p1Uwt8at4Fq8bmiHjsfDZo98ptSr3nfT
 AqqNVl7+Pr288L8SS3FGoqEWc1FxIgBX+KgBYQMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-11.tower-591.messagelabs.com!1680759678!124118!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12261 invoked from network); 6 Apr 2023 05:41:18 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-11.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 6 Apr 2023 05:41:18 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 2A47F10034F;
 Thu,  6 Apr 2023 06:41:18 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121
 [10.183.43.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 1DB141000D7;
 Thu,  6 Apr 2023 06:41:18 +0100 (BST)
Received: from localhost.localdomain (10.167.215.131) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Thu, 6 Apr 2023 06:41:16 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Thu, 6 Apr 2023 13:40:22 +0800
Message-ID: <1680759622-8738-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1680759622-8738-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <20230404215918.GA1893@sol.localdomain>
 <1680759622-8738-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.215.131]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 4/4] lapi/stat.h: Remove deprecated STATX_ALL macro
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

Since kernel 5.10-rc1 commit 581701b7efd6 ("uapi: deprecate STATX_ALL"),
this flag has been mark as deprecated.

Kernel should keep this macro for compatibility, but ltp doesn't think
about it. So remove it.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/lapi/stat.h                       | 4 ----
 testcases/kernel/syscalls/statx/statx06.c | 4 ++--
 testcases/kernel/syscalls/statx/statx07.c | 6 +++---
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/include/lapi/stat.h b/include/lapi/stat.h
index c2db8a589..7c9a7a00c 100644
--- a/include/lapi/stat.h
+++ b/include/lapi/stat.h
@@ -188,10 +188,6 @@ static inline int statx(int dirfd, const char *pathname, unsigned int flags,
 # define STATX_DIOALIGN		0x00002000U
 #endif
 
-#ifndef STATX_ALL
-# define STATX_ALL		0x00000fffU
-#endif
-
 #ifndef STATX__RESERVED
 # define STATX__RESERVED	0x80000000U
 #endif
diff --git a/testcases/kernel/syscalls/statx/statx06.c b/testcases/kernel/syscalls/statx/statx06.c
index ce82b905b..60e736c5a 100644
--- a/testcases/kernel/syscalls/statx/statx06.c
+++ b/testcases/kernel/syscalls/statx/statx06.c
@@ -111,10 +111,10 @@ static void test_statx(unsigned int test_nr)
 	clock_wait_tick();
 	SAFE_CLOCK_GETTIME(CLOCK_REALTIME_COARSE, &after_time);
 
-	TEST(statx(AT_FDCWD, TEST_FILE, 0, STATX_ALL, &buff));
+	TEST(statx(AT_FDCWD, TEST_FILE, 0, STATX_BASIC_STATS | STATX_BTIME, &buff));
 	if (TST_RET != 0) {
 		tst_brk(TFAIL | TTERRNO,
-			"statx(AT_FDCWD, %s, 0, STATX_ALL, &buff)",
+			"statx(AT_FDCWD, %s, 0, STATX_BASIC_STATS | STATX_BTIME, &buff)",
 			TEST_FILE);
 	}
 
diff --git a/testcases/kernel/syscalls/statx/statx07.c b/testcases/kernel/syscalls/statx/statx07.c
index b13c11f72..c798c7a10 100644
--- a/testcases/kernel/syscalls/statx/statx07.c
+++ b/testcases/kernel/syscalls/statx/statx07.c
@@ -62,15 +62,15 @@ static int get_mode(char *file_name, int flag_type, char *flag_name)
 {
 	struct statx buf;
 
-	TEST(statx(AT_FDCWD, file_name, flag_type, STATX_ALL, &buf));
+	TEST(statx(AT_FDCWD, file_name, flag_type, STATX_BASIC_STATS | STATX_BTIME, &buf));
 
 	if (TST_RET == -1) {
 		tst_brk(TFAIL | TST_ERR,
-			"statx(AT_FDCWD, %s, %s, STATX_ALL, &buf)",
+			"statx(AT_FDCWD, %s, %s, STATX_BASIC_STATS | STATX_BTIME, &buf)",
 			file_name, flag_name);
 	}
 
-	tst_res(TINFO, "statx(AT_FDCWD, %s, %s, STATX_ALL, &buf) = %o",
+	tst_res(TINFO, "statx(AT_FDCWD, %s, %s, STATX_BASIC_STATS | STATX_BTIME, &buf) = %o",
 		file_name, flag_name, buf.stx_mode);
 
 	return buf.stx_mode;
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
