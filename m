Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B334CF6BF4
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 08:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767773332; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=AeZL/lHqSBexYkBP40yJ0ia+6BNykeXDlAiMvqWPu9A=;
 b=ZxLEq9LXd/C9bFAOXCAzDaVTgMVwTAyDeDzaw46P/YhyGHdxyA2Vx2i7k1EMltakHRHPt
 ZYe88hHiyOJOvxWw9OOPJn09ahH+BMh5TNeFFKavGBPg8p7cBZ3YbQR9Jho9re97+zrArmJ
 Hd1/G4c15mnDziHkVwpzD8lj7T39q9c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CCA143C2D44
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 09:08:52 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 816693C2CC4
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 09:08:27 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4A87D60073F
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 09:08:27 +0100 (CET)
Received: from localhost.localdomain (2.general.phlin.uk.vpn [10.172.194.39])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 21D06409DF; 
 Wed,  7 Jan 2026 08:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767773306;
 bh=ZIDy6oFp6NryoiDpf1DJmLPqrSXDtK7bV9+1wky5aQg=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=dbzenfskR+HhICkjpsWEbsGIOxZ+bDtnSZ5jKxIHWyC/tFlTjac7+Bo6DRja14Ys2
 M8Spv7x9l+m7hhaTm1IuTKOPKkmn9LRvFPD3vb/3CCqWLfMlScyzuFeJVzQhPq1xZ4
 LF64vmi7rmoNN9GlE6f6J+pTvwsIgXHYkThRMd3EjacjKydLhRIIQx+mlDn5VrSpGl
 CWkWovMX6LydtsyD6y7hRfBZERVChVQ7wO/lCrGprgM64HI1Ml0TetlOAJ08mgEafk
 dr2z6RrotbszKGnHbCGWYzNjr7WzcG3aZ/7QveZbT8ddP22tTelLv7L4TkqueEv5Ip
 veVY99TYSdKcXJMTonCeZTuOn+5upLMHf4HMsXvgsXe3+gcNXuOXqMmkSEcc+nWtub
 R8z6dPQ5tg0e924xT3pGo8Jf7I/fuP+6DaphwOkmwJI7Rrwr1iGBtyFwNdbNmqg8OF
 4FO9ZxgPgR7Nr4NdQMWnuABd7jII0OKyracUu7/eARP539NklVJfWpOkxFE7uHXznG
 Qp37b8a9SjZ1q71tRdUDYXFXJHd66tHB859u/l0XVXYMrYnAU9dRaY/KkntFilf0D2
 O/FR5OZ8UYmYkTCz5cUfXxOzyVSzFdazkWpwdbsQQGAgQV5ieNTCNk+kiJ6bVB5/jW
 Z6O1x4tPy+GdYNxln72+hSMA=
To: ltp@lists.linux.it
Date: Wed,  7 Jan 2026 16:06:59 +0800
Message-ID: <20260107080659.342698-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tst_security.c: fix lsm parsing failure due to
 uninitialized buffer
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
From: Po-Hsu Lin via ltp <ltp@lists.linux.it>
Reply-To: Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc: po-hsu.lin@canonical.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The tst_lsm_enabled() function reads /sys/kernel/security/lsm into an
uninitialized local stack buffer. The dirty stack might cause incorrect
parsing results for the last LSM and make string comparison to fail.

This issue was found on Ubuntu Noble 6.8.0-93.95 ppc64el, where apparmor
is the last LSM in the list:

  $ od -c /sys/kernel/security/lsm
  0000000   l   o   c   k   d   o   w   n   ,   c   a   p   a   b   i   l
  0000020   i   t   y   ,   l   a   n   d   l   o   c   k   ,   y   a   m
  0000040   a   ,   a   p   p   a   r   m   o   r
  0000052

But this issue makes it fail to parse the apparmor string correctly, and
leads to a lsm_get_self_attr02 test failure.

This can be reproduced by poisioning the memory with a non-null character,
along with the "selinux", "apparmor", or "smack" to be the last LSM in the
list.

Test will pass after zeroing out the buffer before reading.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 lib/tst_security.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/tst_security.c b/lib/tst_security.c
index c51527135..00be4d72e 100644
--- a/lib/tst_security.c
+++ b/lib/tst_security.c
@@ -39,6 +39,8 @@ int tst_lsm_enabled(const char *name)
 	if (access(LSM_SYS_FILE, F_OK))
 		tst_brk(TCONF, "%s file is not present", LSM_SYS_FILE);
 
+	memset(data, 0, BUFSIZ);
+
 	fd = SAFE_OPEN(LSM_SYS_FILE, O_RDONLY);
 	SAFE_READ(0, fd, data, BUFSIZ);
 	SAFE_CLOSE(fd);
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
