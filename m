Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C76C47258
	for <ltp@archiver.kernel.org>; Thu, 25 Jan 2024 11:05:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F4703CE852
	for <ltp@archiver.kernel.org>; Thu, 25 Jan 2024 12:05:31 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 91AB33C080E
 for <ltp@lists.linux.it>; Thu, 25 Jan 2024 12:05:16 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 16927100156E
 for <ltp@lists.linux.it>; Thu, 25 Jan 2024 12:05:16 +0100 (CET)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40e8d3b29f2so77233745e9.1
 for <ltp@lists.linux.it>; Thu, 25 Jan 2024 03:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706180715; x=1706785515; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+4uCyOpRfWGQAt0MV9OVbbK1UIO299KSlF8B0ACiK08=;
 b=cH1zoC8mE4ebINa7xTXyeBy1QKVtN4SDcfkEsWQqRsHBv9qZSEAdIcACfS+ed5KT2E
 J3C7loP2aL35Zhjh0+HP0vYUk2IUtJ9PLWTAPIwC/Smc8eDnFAgfTTPqjhhRw6xXzXqm
 3o26meDhh67m2Y5wIDhAFvyM5yYmYqpetXwILDSWr3SoFlCXEFxgFOy/6/NXEFBmHtDy
 jOMw51Z+6+kRJQuqGBFV+ITm5vHqQHKOlOoQlhs2aFWoE15AoV2OpKDVSOOANpoKoY0R
 RiWiJI7bc9n+wRtZaS7SfTBnPFidrI45l6qEmXu/tGGRk2Tsw+phElaDTRlQq6JMG1nd
 l4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706180715; x=1706785515;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+4uCyOpRfWGQAt0MV9OVbbK1UIO299KSlF8B0ACiK08=;
 b=c3+SbSfvysA7ySEWx7obWkpKusw6Gh1v39RhvWZWUE/P1TRPjDoC7ehCa1Rm+UMxnc
 APJSsV7pGVXz6PRQRkiola8i398V2t3obdaUvVRVWqkpe6LWkRc84z/Mb8gaH8THaaYQ
 Qnmzdcep3FPOSziGYK6ElPi/elDEAcqN4RmEahEq/9GSPGdwckkeWwLFExhBC+pLX0QW
 ANFPi2recGZu+9UzTw4cpteVs8eK7BjJqr2dpeOzeAXxNAfn6lACjt1UZp09t9iQBP19
 TDWBTmq8L7yDgi45feCFAVdfD3kVKv/A73CJCt+Kyn5rFgNgW6aAg6qFw8HcQd+jasYB
 Jjug==
X-Gm-Message-State: AOJu0YwiUcG+1km9KknfaT9drNwXz42rYn6VsFssvFLOkiv9u7g8DjM8
 p28B6iGSqeWr0tX59hHC33Zbbg6nGo8JctFo3ojy8EicfaJQxYoMumoC8PFr
X-Google-Smtp-Source: AGHT+IFrT/BHwzZQ7b+GkkPVyYoo2QEqKruX909D7cAwNrPy/nrrH9uRFTa3+T18+B9m8tLwfVKAtw==
X-Received: by 2002:a05:600c:202:b0:40e:8a4d:55a8 with SMTP id
 2-20020a05600c020200b0040e8a4d55a8mr300205wmi.185.1706180715045; 
 Thu, 25 Jan 2024 03:05:15 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
 by smtp.gmail.com with ESMTPSA id
 m17-20020a05600c4f5100b0040d87100733sm2218918wmq.39.2024.01.25.03.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 03:05:14 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 25 Jan 2024 13:05:10 +0200
Message-Id: <20240125110510.751445-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fanotify01: Test setting two marks on different
 filesystems
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

When tested fs has zero fsid (e.g. fuse) and events are reported
with fsid+fid, watching different filesystems with the same group is
not supported.

Try to setup a bogus mark on test tmp dir, in addition to the mark
on the tested filesystem, to check if marks on different filesystems
are supported.

Run on all filesystem to test both fs with zero fsid (e.g. fuse) and
fs with valid fsid.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Petr,

The fanotify tests changes that you already picked from my github [1]
have to do with fixing new test failures in v6.7 and v6.8-rc1, dues to
the fact that each of those kernel versions added new filesystems that
support fanotify events with fid+fsid.

This is the only change to test new functionality in v6.8-rc1, namely,
that for fs with zero fsid (e.g. fuse), an fanotify group can watch a
single fs instance.

To fix the problem that you reported with this test on exfat [2],
I needed to make a distiction between the fs that do not support mount
mark with fid due to having zero fsid (e.g. fuse) and those fs that
do not support decoding fid (e.g. exfat).

It is not urgent to merge this change to the upcoming code freeze -
it's up to you, but since I already tested it I am posting it now.

Thanks,
Amir.

[1] https://github.com/amir73il/ltp/commits/fanotify_fsid/
[2] https://lore.kernel.org/ltp/CAOQ4uxh1VwoMK_ssjdcxo_sk4cw0pD_FcXZ6Lb2=XHLf21kGAw@mail.gmail.com/T/#mf15d751e8f77a497ee4387b0791219e800cde7ea

 testcases/kernel/syscalls/fanotify/fanotify.h |  6 +++++-
 .../kernel/syscalls/fanotify/fanotify01.c     | 19 +++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index e0d178bcc..554940a7e 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -166,20 +166,23 @@ static inline int fanotify_flags_supported_on_fs(unsigned int init_flags,
 {
 	int fd;
 	int rval = 0;
+	int err = 0;
 
 	fd = fanotify_init(init_flags, O_RDONLY);
-
 	if (fd < 0) {
+		err = errno;
 		if (errno == ENOSYS)
 			tst_brk(TCONF, "fanotify not configured in kernel");
 		if (errno != EINVAL)
 			tst_brk(TBROK | TERRNO,
 				"fanotify_init(%x, O_RDONLY) failed",
 				init_flags);
+		errno = err;
 		return -1;
 	}
 
 	if (fname && fanotify_mark(fd, FAN_MARK_ADD | mark_flags, event_flags, AT_FDCWD, fname) < 0) {
+		err = errno;
 		if (errno == ENODEV || errno == EOPNOTSUPP || errno == EXDEV) {
 			rval = strcmp(fname, OVL_MNT) ? -2 : -3;
 		} else if (errno != EINVAL) {
@@ -194,6 +197,7 @@ static inline int fanotify_flags_supported_on_fs(unsigned int init_flags,
 
 	SAFE_CLOSE(fd);
 
+	errno = err;
 	return rval;
 }
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify01.c b/testcases/kernel/syscalls/fanotify/fanotify01.c
index e4398f236..ba09f309d 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify01.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
@@ -77,6 +77,7 @@ static char buf[BUF_SIZE];
 static int fd_notify;
 static int fan_report_fid_unsupported;
 static int mount_mark_fid_unsupported;
+static int inode_mark_fid_xdev;
 static int filesystem_mark_unsupported;
 
 static unsigned long long event_set[EVENT_MAX];
@@ -328,6 +329,17 @@ pass:
 
 	}
 
+
+	/*
+	 * Try to setup a bogus mark on test tmp dir, to check if marks on
+	 * different filesystems are supported.
+	 * When tested fs has zero fsid (e.g. fuse) and events are reported
+	 * with fsid+fid, watching different filesystems is not supported.
+	 */
+	ret = report_fid ? inode_mark_fid_xdev : 0;
+	TST_EXP_FD_OR_FAIL(fanotify_mark(fd_notify, FAN_MARK_ADD, FAN_CLOSE_WRITE,
+					 AT_FDCWD, "."), ret);
+
 	/* Remove mark to clear FAN_MARK_IGNORED_SURV_MODIFY */
 	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_REMOVE | mark->flag,
 			  FAN_ACCESS | FAN_MODIFY | FAN_CLOSE | FAN_OPEN,
@@ -352,6 +364,12 @@ static void setup(void)
 	mount_mark_fid_unsupported = fanotify_flags_supported_on_fs(FAN_REPORT_FID,
 								    FAN_MARK_MOUNT,
 								    FAN_OPEN, fname);
+	/* When mount mark is not supported due to zero fsid, multi fs inode marks are not supported */
+	if (mount_mark_fid_unsupported && errno == ENODEV) {
+		tst_res(TINFO, "filesystem %s does not support reporting events with fid from multi fs",
+				tst_device->fs_type);
+		inode_mark_fid_xdev = EXDEV;
+	}
 }
 
 static void cleanup(void)
@@ -368,6 +386,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.mount_device = 1,
 	.mntpoint = MOUNT_PATH,
+	.all_filesystems = 1,
 };
 
 #else
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
