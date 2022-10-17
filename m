Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65457C4332F
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 07:49:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8BEF83CAFCC
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 09:49:34 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D9113C9179
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 09:49:23 +0200 (CEST)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4FE8B1A006F2
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 09:49:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1665992961; i=@fujitsu.com;
 bh=Tj1wbgztHy2YTa1Rpm/74K7AphUW20OtRUZKR4RmUB4=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=Pdp+nQjAsKvGn2omi9d86pDdjFiJGowf1KiRsNsz4HXsaCmf/cdNnbtMky6+pjR93
 ZKyPN6Z49AvnJ+ktP/y13ZQwNkUOcktoDvlXpJ6zSDdMX2MtBIOlZqoBiQabdwO3D0
 i99Vwp1NL24pM/hww17hgszzKYtpX/cUXL9u0rPnZat06XEFx5iof0Kjv4ns0otd/I
 FyiNRy3Vn5Ol1KQE2Swb8Q1G6EW97q3m2zNgpXbEm76DC4QB8h4cmSQmPLpahhs0fX
 i6lFwXtdyh5ggHTPMGfbEcxb2UIR37pHU0HDsb/q4nGhDH23JM7O/CbnpVsc5SrEDY
 PsFC1sSFuT1GQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRWlGSWpSXmKPExsViZ8ORqMvI6Zt
 s8MbM4vXhT4wW018cZbNY8X0HowOzx6ZVnWwe+36vY/U4s+AIewBzFGtmXlJ+RQJrxoLPc1gK
 nvJVXPszka2BcStPFyMXh5DAFkaJ708esUM4y5kknm6+yATh7GGUaD6+nLGLkZODTUBT4lnnA
 mYQW0RAVOLz9HNgNrNAiMSER3uYQGxhAQeJhh17WEBsFgFVifcX+8BqeAU8JA4fegU2R0JAQW
 LKw/dQcUGJkzOfsEDMkZA4+OIFM0SNosSljm9Q9RUSs2a1MUHYahJXz21insDIPwtJ+ywk7Qs
 YmVYxmhanFpWlFuma6iUVZaZnlOQmZuboJVbpJuqlluqWpxaX6BrpJZYX66UWF+sVV+Ym56To
 5aWWbGIEhmxKsVLfDsauZX/0DjFKcjApifLO+uuTLMSXlJ9SmZFYnBFfVJqTWnyIUYaDQ0mC9
 xBITrAoNT21Ii0zBxg/MGkJDh4lEV5HVt9kId7igsTc4sx0iNQpRkUpcV4XDqCEAEgiozQPrg
 0Ws5cYZaWEeRkZGBiEeApSi3IzS1DlXzGKczAqCfOKgkzhycwrgZv+CmgxE9DijP1eIItLEhF
 SUg1MPkp3XmfWvd/y5vTHN+EtUsv3n7y8S1D2yv3oZUZXMwJddku5Nud9vsLG7n34P+8TyeAr
 5UFtb2bOsOk5ldYbsGn2xBmROZsFH8gILTNf3z3leJ5DZ6dQSfLiOWLpB33/HCk394zSqjjem
 fvbRkH1yVyXia7Lfx2aYvDi7Z3lH+6/jMq5GCD+UvV+51PdMpHw5xo6zH/bl506PP/lS9fQ2q
 Tuvd8dVq7t/y7hzfPxrdYFpYu/ZKuP/S27v0Pmgmi2h/6uA8Zutx7nP77aX3zXmt2sZM97K3e
 feWd9N6x+d72t1aP5Qo6bh6/vJp7CJN0/d9XUk8/WP1CLXJ+alR2j4flTboqP0TeDuqWTzXxc
 lViKMxINtZiLihMBZOuzRVQDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-7.tower-565.messagelabs.com!1665992960!187652!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12201 invoked from network); 17 Oct 2022 07:49:21 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-7.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 17 Oct 2022 07:49:20 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id A9416100195;
 Mon, 17 Oct 2022 08:49:20 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 9CE0710018D;
 Mon, 17 Oct 2022 08:49:20 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Mon, 17 Oct 2022 08:49:18 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <chrubis@suse.cz>
Date: Mon, 17 Oct 2022 16:49:58 +0800
Message-ID: <1665996599-6420-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/2] tst_safe_file_at: Add SAFE_FSTATAT macro
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
Cc: brauner@kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/tst_safe_file_at.h |  7 +++++++
 lib/tst_safe_file_at.c     | 20 ++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/tst_safe_file_at.h b/include/tst_safe_file_at.h
index e253198e6..082a5acd9 100644
--- a/include/tst_safe_file_at.h
+++ b/include/tst_safe_file_at.h
@@ -29,6 +29,9 @@
 	safe_fchownat(__FILE__, __LINE__,				\
 			(dirfd), (path), (owner), (group), (flags))
 
+#define SAFE_FSTATAT(dirfd, path, statbuf, flags)			\
+	safe_fstatat(__FILE__, __LINE__, (dirfd), (path), (statbuf), (flags))
+
 const char *tst_decode_fd(const int fd)
 			  __attribute__((warn_unused_result));
 
@@ -67,4 +70,8 @@ int safe_fchownat(const char *const file, const int lineno,
 		  gid_t group, int flags)
 		  __attribute__ ((nonnull));
 
+int safe_fstatat(const char *const file, const int lineno,
+		 const int dirfd, const char *const path, struct stat *statbuf,
+		 int flags)
+		 __attribute__ ((nonnull));
 #endif
diff --git a/lib/tst_safe_file_at.c b/lib/tst_safe_file_at.c
index 6370a68e5..f530dc349 100644
--- a/lib/tst_safe_file_at.c
+++ b/lib/tst_safe_file_at.c
@@ -215,3 +215,23 @@ int safe_fchownat(const char *const file, const int lineno,
 
 	return rval;
 }
+
+int safe_fstatat(const char *const file, const int lineno,
+		 const int dirfd, const char *const path, struct stat *statbuf, int flags)
+{
+	int rval;
+
+	rval = fstatat(dirfd, path, statbuf, flags);
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			 "fstatat(%d<%s>, '%s', %p, %d) failed", dirfd,
+			 tst_decode_fd(dirfd), path, statbuf, flags);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			 "Invalid fstatat(%d<%s>, '%s', %p, %d) return value %d",
+			 dirfd, tst_decode_fd(dirfd), path, statbuf, flags, rval);
+	}
+
+	return rval;
+}
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
