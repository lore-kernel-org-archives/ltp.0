Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD34DCA5FE2
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 06:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791181198; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=3p+tRNX1WyGNTaHqWKyWWZcPlKbNaoUxkvZyux15ubQ=;
 b=lJju5sG6t+jHm9q60IQ3zAY1NxT2Ef/uZC2por9OiZH+7oYP8NVo57IDX6kCXiZcUalgw
 7cPFzsybuJGCkc1CCNxSJkhXTU6CAiP9JWbsdf64ktSFRYX+/tWOXsBv4Wwu3TOLjzdPpdZ
 WgW18bwiBArl32/xPj0B0AlRETy7AkU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB86B3E4A5A
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 08:19:58 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D86A63E2C5C
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 08:19:38 +0200 (CEST)
Received: from mail-pg1-x546.google.com (mail-pg1-x546.google.com
 [IPv6:2607:f8b0:4864:20::546])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 268776003BE
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 08:19:38 +0200 (CEST)
Received: by mail-pg1-x546.google.com with SMTP id
 41be03b00d2f7-cc7695f6a30so1865746a12.0
 for <ltp@lists.linux.it>; Sun, 04 Oct 2026 23:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791181176; x=1791785976; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sTp3+c7Mbpx6pjZn4fRbgyVCUo03ftQojwj4sLOrud4=;
 b=qNuPx55798Sq+2QH94FFYH9LFW7QoBqt8ryyEFDxZVLbIb53b6B0xfywiVw64s+fCh
 aWNFWzXLp/3bWvqYeFKXsYP4Zsoe6lHP+1r10r5BRl0DyOCOzd3//S4WZ2E0jEdDeoxm
 7jvozaSJw64LZ6dFoxP+1pmwH63pE4t5xZHoKLfvnc9brZ3dU5z4Q99g0EGRJS6qR0dz
 olq8qbEk7FcRURP4xuqqLNXG5OncMyFdez4Q7XcZHgfD8yeGuBTN3w+n/+Lk6+LSHwp7
 JVvhJ3Ial1/CNABs8cqiGoUXzAxk11gft7uIJiUjyr65EYQJ4A2o4GrxrkYYUcVSgq0Z
 l4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791181176; x=1791785976;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sTp3+c7Mbpx6pjZn4fRbgyVCUo03ftQojwj4sLOrud4=;
 b=Z0bmqmhp8IxtcZDzUGp3H+MUDuckZHQfcgaMkMCeUl26xMhMDX0eGh41+uFz+DtzCI
 zw1u/lm0Ybt+uuL4KwAORcINXcAfQfSxiNQ8xDUv2oYng5OhSsUwfEMXZluERBKD+h3X
 H1wy151XJ7GOtA/rnx3kMMUG476S9oPWo4reBKoOCJF3ZNea6e+dwJnVTM6sKaN+h+wT
 JiOhjJNXoOOqnsrN15pforhMZw0zUtI/+yuy2yG2juJVbkTql6AZz/LVY7C6kyIpmZ9R
 pCtTUT7mstqfBmjvJB+PYVm83MeJXa6VSobBEbsnNvJSJFAgJYGFlWq4RTFrVmP1UGxF
 /IvA==
X-Gm-Message-State: AFuF++mgpbx0Np9uC8bUP0QqhkchmfyC0snD+NxBd2gJmJB6ZN86ulcY
 tLVl7TJL2OdUQY+uXXsuzzv4VJlIuRq+QoGvgcOKflCx2aLgFisH2jLUzqYA82UJt8isu7VEVNW
 LX0l7v8Io3eUP/hHUpFA14jMEOc4GO61wiNG+tpGzYktsVPM03fSfI7hONt0eJmvF4YLQZN6l9w
 OlFdqFLuyWNYbqiG3h7pE5Ju9A1A==
X-Received: from pgap124.prod.google.com ([2002:a63:4282:0:b0:cc7:c04f:b661])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:2787:20b0:3e0:da23:874d
 with SMTP id adf61e73a8af0-3e0da239388mr3441413637.55.1791181175904; Sun, 04
 Oct 2026 23:19:35 -0700 (PDT)
Date: Mon,  5 Oct 2026 06:19:33 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261005061933.4108985-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] pathconf01: Allow EINVAL where POSIX leaves support
 unspecified
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
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: Wake Liu <wakel@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

POSIX lists two EINVAL cases for pathconf(). It shall fail with EINVAL
when the value of name is not valid. It may also fail with EINVAL when
"the implementation does not support an association of the variable
name with the specified file".

The test always calls pathconf() on a directory. For a directory, POSIX
leaves it unspecified whether _PC_MAX_CANON, _PC_MAX_INPUT and
_PC_VDISABLE (note 2), _PC_ASYNC_IO, _PC_PRIO_IO and _PC_SYNC_IO
(note 8) and the _PC_REC_* names (note 10) are supported, so EINVAL is
allowed for them.

Bionic before Android 15 returns -1 and sets errno to EINVAL for
_PC_REC_INCR_XFER_SIZE and _PC_REC_MAX_XFER_SIZE, which makes the test
fail.

Report EINVAL as TCONF for these names. EINVAL for the other names is
still a failure.

Also print the name and errno on failure, so it is clear which name
failed.

Signed-off-by: Wake Liu <wakel@google.com>
---
 .../kernel/syscalls/pathconf/pathconf01.c     | 36 ++++++++++++-------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/pathconf/pathconf01.c b/testcases/kernel/syscalls/pathconf/pathconf01.c
index 5af45e417..635c356bc 100644
--- a/testcases/kernel/syscalls/pathconf/pathconf01.c
+++ b/testcases/kernel/syscalls/pathconf/pathconf01.c
@@ -19,24 +19,26 @@ static char *path;
 static struct tcase {
 	int value;
 	char *name;
+	/* POSIX leaves support for a directory unspecified */
+	int einval_ok;
 } tcases[] = {
 	{NAME_DESC(_PC_LINK_MAX)},
-	{NAME_DESC(_PC_MAX_CANON)},
-	{NAME_DESC(_PC_MAX_INPUT)},
+	{NAME_DESC(_PC_MAX_CANON), .einval_ok = 1},
+	{NAME_DESC(_PC_MAX_INPUT), .einval_ok = 1},
 	{NAME_DESC(_PC_NAME_MAX)},
 	{NAME_DESC(_PC_PATH_MAX)},
 	{NAME_DESC(_PC_PIPE_BUF)},
 	{NAME_DESC(_PC_CHOWN_RESTRICTED)},
 	{NAME_DESC(_PC_NO_TRUNC)},
-	{NAME_DESC(_PC_VDISABLE)},
-	{NAME_DESC(_PC_SYNC_IO)},
-	{NAME_DESC(_PC_ASYNC_IO)},
-	{NAME_DESC(_PC_PRIO_IO)},
+	{NAME_DESC(_PC_VDISABLE), .einval_ok = 1},
+	{NAME_DESC(_PC_SYNC_IO), .einval_ok = 1},
+	{NAME_DESC(_PC_ASYNC_IO), .einval_ok = 1},
+	{NAME_DESC(_PC_PRIO_IO), .einval_ok = 1},
 	{NAME_DESC(_PC_FILESIZEBITS)},
-	{NAME_DESC(_PC_REC_INCR_XFER_SIZE)},
-	{NAME_DESC(_PC_REC_MAX_XFER_SIZE)},
-	{NAME_DESC(_PC_REC_MIN_XFER_SIZE)},
-	{NAME_DESC(_PC_REC_XFER_ALIGN)},
+	{NAME_DESC(_PC_REC_INCR_XFER_SIZE), .einval_ok = 1},
+	{NAME_DESC(_PC_REC_MAX_XFER_SIZE), .einval_ok = 1},
+	{NAME_DESC(_PC_REC_MIN_XFER_SIZE), .einval_ok = 1},
+	{NAME_DESC(_PC_REC_XFER_ALIGN), .einval_ok = 1},
 };
 
 static void verify_pathconf(unsigned int i)
@@ -47,10 +49,18 @@ static void verify_pathconf(unsigned int i)
 
 	TEST(pathconf(path, tc->value));
 
-	if (TST_RET == -1 && errno != 0)
-		tst_res(TFAIL, "pathconf Failed, errno = %d", TST_ERR);
-	else
+	if (TST_RET != -1 || !TST_ERR) {
 		tst_res(TPASS, "pathconf(%s, %s)", path, tc->name);
+		return;
+	}
+
+	if (tc->einval_ok && TST_ERR == EINVAL) {
+		tst_res(TCONF, "pathconf(%s, %s) not supported for a directory",
+			path, tc->name);
+		return;
+	}
+
+	tst_res(TFAIL | TTERRNO, "pathconf(%s, %s)", path, tc->name);
 }
 
 static struct tst_test test = {
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
