Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A40C54ED1
	for <ltp@archiver.kernel.org>; Sat, 28 Jun 2025 11:33:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A58C3C9D27
	for <ltp@archiver.kernel.org>; Sat, 28 Jun 2025 13:33:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 594A83C9B85
 for <ltp@lists.linux.it>; Sat, 28 Jun 2025 13:33:39 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B76FA200061
 for <ltp@lists.linux.it>; Sat, 28 Jun 2025 13:33:38 +0200 (CEST)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ade5b8aab41so133476766b.0
 for <ltp@lists.linux.it>; Sat, 28 Jun 2025 04:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751110418; x=1751715218; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+kUnDhtTDGCWEzjkUyJJ9PTIjYYljoYBQoC7iSa9y8g=;
 b=IeykqqZPNDzL5J3utJ+MUxF7XAea3+mixBeBQFZM8ssJ3o7X/41BCP0P7fynT9GmVG
 mc1k3wXl7foX28JqhJn3awAbhRklVgxqeDj0JxZoZ5pg7ReirJ28GJWB0CYd9Fc/2BIW
 FkJADBSFgq1yrRrKnk7AWnYnkXBVUfbFVeVxfKjxiPfA+kFnxowTAOoZ/EwndSEbRGko
 hu6Do0mhlgTOJMgnRo4TW5ErX45T/z+DbpGDFgKG6jirk40OXqmOXreBrzABDbLTWaj0
 /ku7ogcwY+Wbvj5NvVKr2Tegsbx5zRSrh+8v4GvjTz/nhKXJLzaGOyIEQLBhG3muvsJ4
 z6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751110418; x=1751715218;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+kUnDhtTDGCWEzjkUyJJ9PTIjYYljoYBQoC7iSa9y8g=;
 b=QLcIK5Xd0yKEoB8sFQg4vh6tWHA1NfqWtbJjMSWLpjuV1FwO11/Ghi/25cqLbz5CI6
 WTdXcDSlU/hzxrI4herfSohma83e2a0Gqd3qHBD2QZ2Q246mfox167AZqSfxpdV8eoXT
 0JqWZm3NZ4J2HN3P2aPvbyh/tGK9NyNnpaprpfwA9mcbf86L9kPWHgfB7EMGvGI0wEER
 H3uEkGnd56nkHv1mFGXtJ6/nWdn6Kk1uso1OJ1NrydTQ/XIl2gg2PrsC5QdtwzpZDDyC
 7dW4A4XKXU2p7yXvJYw673TExyKXtKAHYTtHgU+BGCFV4DR6SJPXXMiDbhmaq+Uyl3F4
 6C6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWruXC5xbUW/NnaQvXhZfK7QMjWWYp2yIRKnvdwkDJusyDJTdXsP9VIGme+3rkHjSws0c=@lists.linux.it
X-Gm-Message-State: AOJu0Yz6f5LEpYMz2nVWJWweDMxGfIOiiFp0ugLjAVy5Ymx2xOdjkVFv
 +Y4EsGyRS97uIPwBpZO9TyzTPso2yLiLmMmp6qwp0opMPka7TOGpRxfg39gaS7Iv
X-Gm-Gg: ASbGncsu+LcLFqizY7LinTodjx6gNoVdrUxhrqBE4tQaOv848pB1VXJnUYl1WrdLud+
 36dmTl34LO9XGp3U0Kjh18Yw3LmeA3I6OKiPELhh5fG/WF2uZzLH4mFe2JJcnsa8AjIBOZPKjPT
 CZmECAmJoG3Da9HyvvLKpKyhnbrj5nw6iNsLFzUk5wl46DHxths/JEpx+2JPtxlWPCj1d0DtpJs
 EAczoLpzqZi34lO7V9KYu4ilNpRM0TNInCC5lv1jcKnyEP9GTqXdGdXmsc+GpwxsPh9OiiNznso
 lpS5mSOLgwvxPVBlWIOkvT/fhKygDaafJFhy8JiivbvyUG/8ri3b3D0VFDgUJ0yDEU527BRSAs0
 afzK3zBpnpjXzNH5FTIcFbVFDsW3vY8R7vJux0JctWmJXfJ9gfIiVrANK9FA=
X-Google-Smtp-Source: AGHT+IGXNwTD3P+ARmwrZ3CLDTC2ttTCbXZnIxzboQjFlY059Utc2rZi0xvOpfqumDaAVFYm5VdihQ==
X-Received: by 2002:a17:907:c881:b0:ae3:6659:180b with SMTP id
 a640c23a62f3a-ae3665919f1mr401664066b.29.1751110417628; 
 Sat, 28 Jun 2025 04:33:37 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl
 (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae353c011d1sm304324366b.95.2025.06.28.04.33.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Jun 2025 04:33:36 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Sat, 28 Jun 2025 13:33:34 +0200
Message-ID: <20250628113334.228198-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fanotify01: Fix regression on kernels < v6.8
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

There was a test regression in case the TMPDIR has a zero fsid.

Kernels < v6.8 do not allow setting inodes marks on such fs, while
kernels >= v6.8 do allow to set inode marks but on on a single fs.

Adjust the test expectation in those two different cases.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Link: https://lore.kernel.org/ltp/CA+G9fYtJO4DbiabJwpSamTPHjPzyrD3O6ZCwm2+CDEUA7f+ZYw@mail.gmail.com/
Fixes: db197b7b5 ("fanotify01: fix test failure when running with nfs TMPDIR")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Petr,

I reproduced this but with TMPDIR set to ntfs-3g mount path,
which has zero fsid link nfs.

Tested that fix works on new (upstream) and old v6.6 kernels.

Thanks,
Amir.

 testcases/kernel/syscalls/fanotify/fanotify01.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify01.c b/testcases/kernel/syscalls/fanotify/fanotify01.c
index f514dc1df..df50d84a1 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify01.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
@@ -75,6 +75,7 @@ static char fname[BUF_SIZE];
 static char buf[BUF_SIZE];
 static int fd_notify;
 static int fan_report_fid_unsupported;
+static int tmpfs_report_fid_unsupported;
 static int mount_mark_fid_unsupported;
 static int inode_mark_fid_xdev;
 static int filesystem_mark_unsupported;
@@ -335,9 +336,11 @@ pass:
 	 * When tested fs has zero fsid (e.g. fuse) and events are reported
 	 * with fsid+fid, watching different filesystems is not supported.
 	 */
-	ret = report_fid ? inode_mark_fid_xdev : 0;
-	TST_EXP_FD_OR_FAIL(fanotify_mark(fd_notify, FAN_MARK_ADD, FAN_CLOSE_WRITE,
-					 AT_FDCWD, "."), ret);
+	if (!tmpfs_report_fid_unsupported) {
+		ret = report_fid ? inode_mark_fid_xdev : 0;
+		TST_EXP_FD_OR_FAIL(fanotify_mark(fd_notify, FAN_MARK_ADD, FAN_CLOSE_WRITE,
+						 AT_FDCWD, "."), ret);
+	}
 
 	/* Remove mark to clear FAN_MARK_IGNORED_SURV_MODIFY */
 	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_REMOVE | mark->flag,
@@ -373,8 +376,11 @@ static void setup(void)
 		inode_mark_fid_xdev = EXDEV;
 	}
 
-	if (fanotify_flags_supported_on_fs(FAN_REPORT_FID, FAN_MARK_MOUNT, FAN_OPEN, ".")) {
-		inode_mark_fid_xdev = (errno == ENODEV) ? EXDEV : errno;
+	tmpfs_report_fid_unsupported = fanotify_init_flags_supported_on_fs(FAN_REPORT_FID, ".");
+	if (!tmpfs_report_fid_unsupported &&
+	    fanotify_flags_supported_on_fs(FAN_REPORT_FID, FAN_MARK_MOUNT, FAN_OPEN, ".") &&
+	    (errno == ENODEV || errno == EXDEV)) {
+		inode_mark_fid_xdev = EXDEV;
 		tst_res(TINFO | TERRNO, "TMPDIR does not support reporting events with fid from multi fs");
 	}
 }
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
