Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E961CA5FFE
	for <ltp@archiver.kernel.org>; Tue,  6 Oct 2026 02:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791252299; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Z0TNn5esSAMTjvi8LnI9kB3VDBcaEK0Os94IGpbQ3y0=;
 b=p8aA22v2RbKYZxg+HKT74w//9MWUhsBo0SNMa0x5Tou+DPmSTxcL1+y+xhWZ48mgntEzx
 QDFtuEZkovBuQR4vHY3RlT/Bzm1n5OiRmRB0c9YVn/jnmAb1oPNgeV/w2+Bulp8WHJNQexk
 a9lv89ilnRX/Sw3iOt7Gflv5n3tgLzs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 569653E9E94
	for <ltp@archiver.kernel.org>; Tue,  6 Oct 2026 04:04:59 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 914413EA967
 for <ltp@lists.linux.it>; Tue,  6 Oct 2026 04:04:17 +0200 (CEST)
Received: from Atcsqr.andestech.com (atcsqr.andestech.com [220.128.198.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E544D1A007FD
 for <ltp@lists.linux.it>; Tue,  6 Oct 2026 04:04:16 +0200 (CEST)
Received: from mail.andestech.com (atcpcs55.andestech.com [10.0.1.155])
 by Atcsqr.andestech.com with ESMTPS id 696247em006193
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Tue, 6 Oct 2026 10:04:07 +0800 (+08)
 (envelope-from cyyang772@andestech.com)
Received: from ATCPCS34.andestech.com (10.0.1.134) by atcpcs55.andestech.com
 (10.0.1.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.43; Tue, 6 Oct
 2026 10:04:07 +0800
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Oct
 2026 10:04:07 +0800
To: <ltp@lists.linux.it>
Date: Tue, 6 Oct 2026 10:03:31 +0800
Message-ID: <20261006020331.3791608-3-cyyang772@andestech.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006020331.3791608-1-cyyang772@andestech.com>
References: <20261006020331.3791608-1-cyyang772@andestech.com>
MIME-Version: 1.0
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs55.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 696247em006193
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] Update old API call sites of SAFE_READ() to use
 the enum values
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
From: Victor Cheng-Yen Yang via ltp <ltp@lists.linux.it>
Reply-To: Victor Cheng-Yen Yang <cyyang772@andestech.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Victor Cheng-Yen Yang <cyyang772@andestech.com>

The old test.h API shares safe_read() with the new one, so the same
SAFE_READ_ANY / SAFE_READ_ALL constants apply there. Convert the old API
callers for the same reason as the new API ones: the intent of every
call site becomes visible without looking up the prototype.

No functional change.

Signed-off-by: Victor Cheng-Yen Yang <cyyang772@andestech.com>
---
 lib/tests/tst_safe_macros.c                       | 4 ++--
 testcases/kernel/syscalls/fcntl/fcntl11.c         | 4 ++--
 testcases/kernel/syscalls/fcntl/fcntl31.c         | 2 +-
 testcases/kernel/syscalls/linkat/linkat01.c       | 3 ++-
 testcases/kernel/syscalls/openat/openat03.c       | 2 +-
 testcases/kernel/syscalls/renameat2/renameat202.c | 2 +-
 testcases/kernel/syscalls/symlinkat/symlinkat01.c | 3 ++-
 testcases/kernel/syscalls/umount2/umount2_01.c    | 2 +-
 8 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/lib/tests/tst_safe_macros.c b/lib/tests/tst_safe_macros.c
index 59b9b49bb..241ac0daa 100644
--- a/lib/tests/tst_safe_macros.c
+++ b/lib/tests/tst_safe_macros.c
@@ -27,9 +27,9 @@ int main(int argc LTP_ATTRIBUTE_UNUSED, char **argv)
 	printf("%s\n", SAFE_BASENAME(NULL, *argv));
 	printf("%s\n", SAFE_DIRNAME(NULL, *argv));
 	fd = SAFE_OPEN(cleanup, __FILE__ "~", O_RDWR);
-	SAFE_READ(cleanup, 0, fd, buf, 9);
+	SAFE_READ(cleanup, SAFE_READ_ANY, fd, buf, 9);
 	printf("buf: %s\n", buf);
-	SAFE_READ(cleanup, 1, fd, buf, 9);
+	SAFE_READ(cleanup, SAFE_READ_ALL, fd, buf, 9);
 	printf("buf: %s\n", buf);
 	SAFE_WRITE(cleanup, SAFE_WRITE_ANY, -1, buf, 9);
 	SAFE_WRITE(NULL, SAFE_WRITE_ANY, fd, buf, 9);
diff --git a/testcases/kernel/syscalls/fcntl/fcntl11.c b/testcases/kernel/syscalls/fcntl/fcntl11.c
index 083055dd5..bf46f38d1 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl11.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl11.c
@@ -208,7 +208,7 @@ void parent_put(struct flock *l)
 
 void parent_get(struct flock *l)
 {
-	SAFE_READ(cleanup, 1, child_pipe[0], l, sizeof(*l));
+	SAFE_READ(cleanup, SAFE_READ_ALL, child_pipe[0], l, sizeof(*l));
 }
 
 void child_put(struct flock *l)
@@ -218,7 +218,7 @@ void child_put(struct flock *l)
 
 void child_get(struct flock *l)
 {
-	SAFE_READ(NULL, 1, parent_pipe[0], l, sizeof(*l));
+	SAFE_READ(NULL, SAFE_READ_ALL, parent_pipe[0], l, sizeof(*l));
 	if (l->l_type == (short)STOP)
 		exit(0);
 }
diff --git a/testcases/kernel/syscalls/fcntl/fcntl31.c b/testcases/kernel/syscalls/fcntl/fcntl31.c
index 2aab4a91c..2a74b7478 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl31.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl31.c
@@ -344,7 +344,7 @@ static void check_io_signal(char *des)
 				 "signal mechanism work abnormally");
 		}
 
-		SAFE_READ(cleanup, 1, test_fd, &c, 1);
+		SAFE_READ(cleanup, SAFE_READ_ALL, test_fd, &c, 1);
 		wait(NULL);
 	}
 }
diff --git a/testcases/kernel/syscalls/linkat/linkat01.c b/testcases/kernel/syscalls/linkat/linkat01.c
index fa2065bbb..c3851874d 100644
--- a/testcases/kernel/syscalls/linkat/linkat01.c
+++ b/testcases/kernel/syscalls/linkat/linkat01.c
@@ -249,7 +249,8 @@ static void mylinkat_test(struct test_struct *desc)
 
 			fd = SAFE_OPEN(cleanup, desc->referencefn2,
 				       O_RDONLY);
-			SAFE_READ(cleanup, 1, fd, &vnum, sizeof(vnum));
+			SAFE_READ(cleanup, SAFE_READ_ALL, fd, &vnum,
+				  sizeof(vnum));
 			SAFE_CLOSE(cleanup, fd);
 
 			if (tnum == vnum)
diff --git a/testcases/kernel/syscalls/openat/openat03.c b/testcases/kernel/syscalls/openat/openat03.c
index 712e85745..2406f9c58 100644
--- a/testcases/kernel/syscalls/openat/openat03.c
+++ b/testcases/kernel/syscalls/openat/openat03.c
@@ -129,7 +129,7 @@ static void read_file(int fd)
 	SAFE_LSEEK(cleanup, fd, 0, SEEK_SET);
 
 	for (i = 0; i < blocks_num; ++i) {
-		SAFE_READ(cleanup, 0, fd, tmp, size);
+		SAFE_READ(cleanup, SAFE_READ_ANY, fd, tmp, size);
 		if (memcmp(buf, tmp, size))
 			tst_brkm(TFAIL, cleanup, "got unexepected data");
 	}
diff --git a/testcases/kernel/syscalls/renameat2/renameat202.c b/testcases/kernel/syscalls/renameat2/renameat202.c
index a635206f7..d5def6e83 100644
--- a/testcases/kernel/syscalls/renameat2/renameat202.c
+++ b/testcases/kernel/syscalls/renameat2/renameat202.c
@@ -141,7 +141,7 @@ static void renameat2_verify(void)
 
 	SAFE_STAT(cleanup, emptyfile, &st);
 
-	readn = SAFE_READ(cleanup, 0, fd, str, BUFSIZ);
+	readn = SAFE_READ(cleanup, SAFE_READ_ANY, fd, str, BUFSIZ);
 
 	if (close(fd) < 0)
 		tst_brkm(TERRNO | TFAIL, cleanup, "close fd failed");
diff --git a/testcases/kernel/syscalls/symlinkat/symlinkat01.c b/testcases/kernel/syscalls/symlinkat/symlinkat01.c
index 565e4d923..285e75d8c 100644
--- a/testcases/kernel/syscalls/symlinkat/symlinkat01.c
+++ b/testcases/kernel/syscalls/symlinkat/symlinkat01.c
@@ -181,7 +181,8 @@ static void mysymlinkat_test(struct test_struct *desc)
 			SAFE_CLOSE(cleanup, fd);
 
 			fd = SAFE_OPEN(cleanup, desc->referencefn2, O_RDONLY);
-			SAFE_READ(cleanup, 1, fd, &vnum, sizeof(vnum));
+			SAFE_READ(cleanup, SAFE_READ_ALL, fd, &vnum,
+				  sizeof(vnum));
 			SAFE_CLOSE(cleanup, fd);
 
 			if (tnum == vnum)
diff --git a/testcases/kernel/syscalls/umount2/umount2_01.c b/testcases/kernel/syscalls/umount2/umount2_01.c
index c6496e306..9e0732461 100644
--- a/testcases/kernel/syscalls/umount2/umount2_01.c
+++ b/testcases/kernel/syscalls/umount2/umount2_01.c
@@ -128,7 +128,7 @@ static void umount2_verify(void)
 
 	memset(buf, 0, sizeof(buf));
 
-	SAFE_READ(cleanup, 1, fd, buf, strlen(str));
+	SAFE_READ(cleanup, SAFE_READ_ALL, fd, buf, strlen(str));
 
 	if (strcmp(str, buf)) {
 		tst_resm(TFAIL, "umount2(2) MNT_DETACH flag "
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
