Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65EA8C433EF
	for <ltp@archiver.kernel.org>; Thu,  7 Jul 2022 09:45:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 91E9E3C934D
	for <ltp@archiver.kernel.org>; Thu,  7 Jul 2022 11:45:21 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F7213C071B
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 11:45:10 +0200 (CEST)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 135706007A9
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 11:45:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1657187109; i=@fujitsu.com;
 bh=Nwg2HdOtQgIW3VdwNo6FOLVjVCuICyg/X2CYjAF55Bk=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=lar4t0SWTe+i0zInJBJEIysAtXXCbC+mKLQOvuO1OylUKm1dESanIdMKs6O6iKCXy
 7rPZNn2y6+5i0bVFNjLxmBAqrODM191F336Cxi6KaXybmYj0LHVsM55OR2e/P2ItMI
 lmfA8KcHI6N3ZVSRyhZtbOfYofqWrWKw50tcNd3s9UxPFzdwsrNNCj+Y8Y1JvYEY7B
 hVQRotJR/2ApaZ2fMnQ8Mehz6RYbA5Rv5SFzIHzuXurEb1NYmRZ2U6p0ZSpJLZkxDA
 6OiuY51VyRtbjDnTgHZZDKZ8mXCU0nttAG4SDg5RWl47aMjsWASMD9NT4Ut47j4Y0z
 bYI14YdQTj2SA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRWlGSWpSXmKPExsViZ8ORpKuy+li
 Swfb9BhYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8b57x8YCy4oVPTO+8zewLhLpouRk0NI4BSj
 xLH9/l2MXED2HiaJa9eXsEE4uxkl5r5bywZSxSagKfGscwEziC0iICHR0fCWHcRmFlCXWD7pF
 xOILSygI/Hx/x2wGhYBFYl/296B2bwCHhLT3t4DmyMhoCAx5eF7qLigxMmZT1gg5khIHHzxgh
 miRlHiUsc3Rgi7QuL14UtQcTWJq+c2MU9g5J+FpH0WkvYFjEyrGK2SijLTM0pyEzNzdA0NDHQ
 NDU11jY11zU30Eqt0E/VSS3XLU4tLdI30EsuL9VKLi/WKK3OTc1L08lJLNjECgzKlWNFrB+Or
 FT/1DjFKcjApifIyLz+WJMSXlJ9SmZFYnBFfVJqTWnyIUYaDQ0mCt2glUE6wKDU9tSItMwcYI
 TBpCQ4eJRHeklVAad7igsTc4sx0iNQpRnuOhf1X9zJzTJ39bz8zx3IwOfNr2wFmIZa8/LxUKX
 He+SBtAiBtGaV5cENhEX2JUVZKmJeRgYFBiKcgtSg3swRV/hWjOAejkjBvM8gUnsy8Erjdr4D
 OYgI6a1n+EZCzShIRUlINTA4fOVf3aZ6Qqrfcfixv7j+OA7eyCm1VTrUze99Q/r1kt3dVr9pk
 nyK3i+9am64mTizkn6KQkz1db9JzZeGjXtM3b+Rp21DQWpZ05/iJDfLbj28tFz314NnC1c0T1
 De+1kj7IZzOKpYT9/GEqstDpl/rdfMrS1j3eB/JUsq5kVr2Mc7iz46XKrc6znY7XW8W+Dvvyt
 EJj8Iklq70U3N+7CdiviBeOynatEfqB4t7QrC4tGM4x9S/2nbrHzMt3sbjvfHy2auR257d+Pk
 7z1JccOakZavZhV9cmFiryuAwdUrJ1IroF40qV9f0rry4SoVxkcvFVfFzWHg43asbEqYGOTA3
 f3m0QvvY25zFZRtLXymxFGckGmoxFxUnAgD8/kuBYwMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-17.tower-565.messagelabs.com!1657187108!100147!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 18789 invoked from network); 7 Jul 2022 09:45:08 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
 by server-17.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 7 Jul 2022 09:45:08 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 7A3E31B3
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 10:45:08 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 6EF9F7C
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 10:45:08 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 7 Jul 2022 10:45:06 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Thu, 7 Jul 2022 18:46:00 +0800
Message-ID: <1657190760-2272-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] security/dirtyc0w: fix typo
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

s/dirtyc0w/dirtycow/

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/cve                                                 | 2 +-
 runtest/syscalls                                            | 2 +-
 testcases/kernel/security/dirtyc0w/.gitignore               | 2 --
 testcases/kernel/security/dirtycow/.gitignore               | 2 ++
 testcases/kernel/security/{dirtyc0w => dirtycow}/Makefile   | 2 +-
 .../security/{dirtyc0w/dirtyc0w.c => dirtycow/dirtycow.c}   | 6 +++---
 .../dirtyc0w_child.c => dirtycow/dirtycow_child.c}          | 0
 7 files changed, 8 insertions(+), 8 deletions(-)
 delete mode 100644 testcases/kernel/security/dirtyc0w/.gitignore
 create mode 100644 testcases/kernel/security/dirtycow/.gitignore
 rename testcases/kernel/security/{dirtyc0w => dirtycow}/Makefile (86%)
 rename testcases/kernel/security/{dirtyc0w/dirtyc0w.c => dirtycow/dirtycow.c} (94%)
 rename testcases/kernel/security/{dirtyc0w/dirtyc0w_child.c => dirtycow/dirtycow_child.c} (100%)

diff --git a/runtest/cve b/runtest/cve
index 9ab6dc282..3727f58c3 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -9,7 +9,7 @@ cve-2015-7550 keyctl02
 cve-2016-4470 keyctl01.sh
 cve-2015-3290 cve-2015-3290
 cve-2016-4997 setsockopt03
-cve-2016-5195 dirtyc0w
+cve-2016-5195 dirtycow
 cve-2016-7042 cve-2016-7042
 cve-2016-7117 cve-2016-7117
 cve-2016-8655 setsockopt06
diff --git a/runtest/syscalls b/runtest/syscalls
index efef18136..111ef6f90 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1034,7 +1034,7 @@ process_vm_writev01 process_vm01 -w
 process_vm_writev02 process_vm_writev02
 
 prot_hsymlinks prot_hsymlinks
-dirtyc0w dirtyc0w
+dirtycow dirtycow
 dirtypipe dirtypipe
 
 pselect01 pselect01
diff --git a/testcases/kernel/security/dirtyc0w/.gitignore b/testcases/kernel/security/dirtyc0w/.gitignore
deleted file mode 100644
index 7700d91a3..000000000
--- a/testcases/kernel/security/dirtyc0w/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-dirtyc0w
-dirtyc0w_child
diff --git a/testcases/kernel/security/dirtycow/.gitignore b/testcases/kernel/security/dirtycow/.gitignore
new file mode 100644
index 000000000..ad36ce53c
--- /dev/null
+++ b/testcases/kernel/security/dirtycow/.gitignore
@@ -0,0 +1,2 @@
+dirtycow
+dirtycow_child
diff --git a/testcases/kernel/security/dirtyc0w/Makefile b/testcases/kernel/security/dirtycow/Makefile
similarity index 86%
rename from testcases/kernel/security/dirtyc0w/Makefile
rename to testcases/kernel/security/dirtycow/Makefile
index bf26d9eb6..07759a0e3 100644
--- a/testcases/kernel/security/dirtyc0w/Makefile
+++ b/testcases/kernel/security/dirtycow/Makefile
@@ -4,5 +4,5 @@
 top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
-dirtyc0w_child: CFLAGS+=-pthread
+dirtycow_child: CFLAGS+=-pthread
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/security/dirtyc0w/dirtyc0w.c b/testcases/kernel/security/dirtycow/dirtycow.c
similarity index 94%
rename from testcases/kernel/security/dirtyc0w/dirtyc0w.c
rename to testcases/kernel/security/dirtycow/dirtycow.c
index 7924285a7..881e376c5 100644
--- a/testcases/kernel/security/dirtyc0w/dirtyc0w.c
+++ b/testcases/kernel/security/dirtycow/dirtycow.c
@@ -55,7 +55,7 @@ static void setup(void)
 	nobody_gid = pw->pw_gid;
 }
 
-void dirtyc0w_test(void)
+void dirtycow_test(void)
 {
 	int i, fd, pid, fail = 0;
 	char c;
@@ -70,7 +70,7 @@ void dirtyc0w_test(void)
 	if (!pid) {
 		SAFE_SETGID(nobody_gid);
 		SAFE_SETUID(nobody_uid);
-		SAFE_EXECLP("dirtyc0w_child", "dirtyc0w_child", NULL);
+		SAFE_EXECLP("dirtycow_child", "dirtycow_child", NULL);
 	}
 
 	TST_CHECKPOINT_WAIT(0);
@@ -100,7 +100,7 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.needs_root = 1,
 	.setup = setup,
-	.test_all = dirtyc0w_test,
+	.test_all = dirtycow_test,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "4ceb5db9757a"},
 		{"linux-git", "19be0eaffa3a"},
diff --git a/testcases/kernel/security/dirtyc0w/dirtyc0w_child.c b/testcases/kernel/security/dirtycow/dirtycow_child.c
similarity index 100%
rename from testcases/kernel/security/dirtyc0w/dirtyc0w_child.c
rename to testcases/kernel/security/dirtycow/dirtycow_child.c
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
