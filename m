Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DBBC47258
	for <ltp@archiver.kernel.org>; Sun, 28 Jan 2024 18:15:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 095E43CE181
	for <ltp@archiver.kernel.org>; Sun, 28 Jan 2024 19:15:51 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1348B3C0644
 for <ltp@lists.linux.it>; Sun, 28 Jan 2024 19:15:35 +0100 (CET)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3F54F1001164
 for <ltp@lists.linux.it>; Sun, 28 Jan 2024 19:15:35 +0100 (CET)
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5cddc5455aeso1153569a12.1
 for <ltp@lists.linux.it>; Sun, 28 Jan 2024 10:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706465733; x=1707070533; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=E1i5P4fiaGHjQznCRkHVqjEWLkd9273/vHW9AZdmJ2I=;
 b=RRuOUlKYoVI9rZUQfpp4sp0RZUKMDeuWZQ889w/OxS57mvwIAjUAyJ25wchf6oQ7Ti
 93pndgRgK76iji7/8Nv7m7sRUSyAZYNx6ndd5ZovP0gpUBIuGash8veTb6jYeaRMZ4bN
 N0MU4UY+7a2Fr9V3EPGbNKOnrRWBDpJDCz3YxkhuQZ9u42W45vy85OsJdTiRwzHoQDHK
 0NZuFysnpnhDKdAjn00I3YWUcW5kyheTUeZh3y9PykrMzkaYgoIp8u+m2zRM4RywlbHh
 JyyI9qi/inoBYYPYmjPyNFUv6eCNqE06Z+YN0EzO2lPUX+28Kic74s9ZwPP/LYaxYfiC
 31lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706465733; x=1707070533;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E1i5P4fiaGHjQznCRkHVqjEWLkd9273/vHW9AZdmJ2I=;
 b=vwfG6HGvAGkYeJBJCHQKlR0ozil0ECMXFsddzuXI5hxWZ+6J4GdcePZWS7vZcPKH8s
 g1WQPo4ST/LQyE4LK79HokhfRHr0+pmDrImujLN6bGlQtWAHdQ1qYfjTdmDsKxeFGXF4
 X5+U8i4SUnvqDFxAaoBr8L5yrf17IDofV69PpJvune1hkxhCHfg2g8UiXBupbuYcPYWT
 /UVekkeFFVl3XrvbI0uhC2zMzNoHPhQLl33yjo6N4yrahlmy/n/2aqjmCUwvCVoNNA1x
 mXmIsDcMhWxUZB5KmBnUA84R3O0OMi0kLP6rro8JLyo6TXCPCJGbaWbY/J5558416l7L
 DFIQ==
X-Gm-Message-State: AOJu0Ywjb+sJIo7lbaAGIY8UU8msRcLrCuoYMlQ7P8JKhyLArcHicmSL
 g2R9R59kUz4FLtfHCTeZnp7Trh2gCY0VvPFoSUFSgye+dYv1nYYZvzy3UFPc
X-Google-Smtp-Source: AGHT+IHJTTXZURglcHZTwnLskGavxsQynTaoRI09dlrmtDSr8gwh0VPOLpo7aUQKFQ+rvzQtoG8R7Q==
X-Received: by 2002:a17:903:1206:b0:1d7:133e:5c09 with SMTP id
 l6-20020a170903120600b001d7133e5c09mr1780454plh.22.1706465732883; 
 Sun, 28 Jan 2024 10:15:32 -0800 (PST)
Received: from localhost.localdomain ([106.51.191.124])
 by smtp.gmail.com with ESMTPSA id
 r24-20020a170902be1800b001d7233dc459sm3889140pls.76.2024.01.28.10.15.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jan 2024 10:15:32 -0800 (PST)
From: Subramanya Swamy <subramanya.swamy.linux@gmail.com>
To: ltp@lists.linux.it
Date: Sun, 28 Jan 2024 13:15:23 -0500
Message-ID: <20240128181526.5395-1-subramanya.swamy.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] isofs.sh:Run test on genisoimage,
 xorriso &mksisofs if not symlinks
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
Cc: Subramanya Swamy <subramanya.swamy.linux@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

    1)mkisofs, genisoimage and xorriso tools are present as separate
    tools in some distros while in others they are symlinks to one
    another. Tests are skipped on symlinks.

    2)mkisofs supports only -hfs option
      genisoimage supports both -hfs & -hfsplus options
      xorrisofs supports only -hfsplus option

Co-Authored-By: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Subramanya Swamy <subramanya.swamy.linux@gmail.com>
---
 testcases/kernel/fs/iso9660/isofs.sh | 41 ++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/fs/iso9660/isofs.sh b/testcases/kernel/fs/iso9660/isofs.sh
index dfa4ac73d..9aa853e67 100755
--- a/testcases/kernel/fs/iso9660/isofs.sh
+++ b/testcases/kernel/fs/iso9660/isofs.sh
@@ -13,18 +13,16 @@ TST_NEEDS_CMDS="mount umount"
 TST_NEEDS_TMPDIR=1
 TST_SETUP=setup
 TST_TESTFUNC=do_test
+TST_CNT=3
 
 MAX_DEPTH=3
 MAX_DIRS=4
 
 setup()
 {
-	if tst_cmd_available mkisofs; then
-		MKISOFS_CMD="mkisofs"
-	elif tst_cmd_available genisoimage; then
-		MKISOFS_CMD="genisoimage"
-	else
-		tst_brk TCONF "please install mkisofs or genisoimage"
+	if !(tst_cmd_available mkisofs \
+		|| tst_cmd_available genisoimage || tst_cmd_available xorrisofs);then
+			tst_brk TCONF "please install mkisofs / genisoimage / xorriso"
 	fi
 }
 
@@ -46,6 +44,29 @@ gen_fs_tree()
 
 do_test()
 {
+        case $1 in
+        1) MKISOFS_CMD="mkisofs"
+	   HFSOPT="-hfs -D"
+	   GREPOPT="mkisofs";;
+        2) MKISOFS_CMD="genisoimage"
+	   HFSOPT="-hfsplus -D -hfs -D"
+	   GREPOPT="genisoimage";;
+        3) MKISOFS_CMD="xorrisofs"
+	   HFSOPT="-hfsplus -D"
+	   GREPOPT="xorriso";;
+        esac
+
+
+        if ! tst_cmd_available $MKISOFS_CMD; then
+                tst_res TCONF "Missing '$MKISOFS_CMD'"
+                return
+        fi
+
+        if ! $MKISOFS_CMD 2>&1 | head -n 2 |grep -q "$GREPOPT"; then
+                tst_res TCONF "'$MKISOFS_CMD' is a symlink to another tool"
+                return
+        fi
+
 	local mnt_point="$PWD/mnt"
 	local make_file_sys_dir="$PWD/files"
 	local mkisofs_opt mount_opt
@@ -62,14 +83,16 @@ do_test()
 	for mkisofs_opt in \
 		" " \
 		"-J" \
-		"-hfs -D" \
+		${HFSOPT} \
 		" -R " \
 		"-R -J" \
 		"-f -l -D -J -allow-leading-dots -R" \
-		"-allow-lowercase -allow-multidot -iso-level 3 -f -l -D -J -allow-leading-dots -R"
+		"-allow-lowercase -allow-multidot -iso-level 3 -f -l -D -J \
+			-allow-leading-dots -R"
 	do
 		rm -f isofs.iso
-		EXPECT_PASS $MKISOFS_CMD -o isofs.iso -quiet $mkisofs_opt $make_file_sys_dir 2\> /dev/null \
+		EXPECT_PASS $MKISOFS_CMD -o isofs.iso \
+			-quiet $mkisofs_opt $make_file_sys_dir 2\> /dev/null \
 			|| continue
 
 		for mount_opt in \
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
