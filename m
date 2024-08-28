Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1608CC5472D
	for <ltp@archiver.kernel.org>; Wed, 28 Aug 2024 05:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1724822729; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=6krqtlZgS/fCdKODZ0CHpPaUqs5bcaRh4PYv1IHtE5I=;
 b=RnLXGg08BLRngrQM9eCYA+pKKYMOWtq19OsbMDoGPfj+e1h8/xrXfG4Eez03Y+JbWfpxR
 OAQoZDRzlqVZwflyp8hoyHMQj3aixW/xFtiP1riJFw4/cgXpdqOEdWI+NL9q9jT9d83ye3R
 urKFME+IPREOJMelFIIMIFWIGYRAt4s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C991E3D2777
	for <ltp@archiver.kernel.org>; Wed, 28 Aug 2024 07:25:29 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BCE1C3D273C
 for <ltp@lists.linux.it>; Wed, 28 Aug 2024 07:25:09 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4BD6314060A9
 for <ltp@lists.linux.it>; Wed, 28 Aug 2024 07:25:08 +0200 (CEST)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a7aa086b077so563745566b.0
 for <ltp@lists.linux.it>; Tue, 27 Aug 2024 22:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1724822707; x=1725427507; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Fch4J+q3s4pbjvpvQvicDHm3PwvrE7hbw9ySPVmVDp0=;
 b=a/EcYvib+MFABJDJ5G336RZbc4N11WbiTEJyrOglvlGIc6Or1k1NA5F3Fyk3n2+4lg
 /BgeCCP0uKZcj5z157q7BITyY944CO0dkUD8rlbvIf+DR8Gy8WWjg3H34FLNlDhaiVSC
 XKK4xXFkwLFk59WsOGxIBkUNpF+I/shFJfBUpHNwGqWDMcwK27mBJskMUHIPZzRmZBHT
 3mzviI9iuhiHBbZKy/xBk1fiqZi8Te0KRGzWPLjAdsG7d3ZTYaYbeN1I6IiW2VJMnw/h
 j6YQVXdtIqSu67qQhNXgP1LgWLVvi0krObeau1ycXt8Hf1s+OlbKNJxzFE6rNljbDrpt
 vcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724822707; x=1725427507;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fch4J+q3s4pbjvpvQvicDHm3PwvrE7hbw9ySPVmVDp0=;
 b=eXeGPsBnUexIQRWoEVOLdx7XcWlfgndTQY5RltqZF12sU2H2ehJQZHbuxmLGROo0nn
 61Ocgro362cbtYelrZB0ZI3bsKKvtV/GswECxrfjwC2HBrOZlV5/71IJAoWXiRERvoHu
 h9ZwUUKfN2kSMWNsd/5mZvoTOspOWkbVM+in81yrHa6AnSTYqHOql2RkT4Um/YxmwzOt
 A8GND26eU1DkwDOZHKaZZjmSs+d1izAsJf62+EdWcZq70oOK7Rvj/VgyY66Trjd3JH6x
 1sl3LybVZkLMknGasqdGMLaoaYgwKQokr1hRWp3ccg1F6s/gXdMh/isUsaCXPdGLlP+p
 fn1g==
X-Gm-Message-State: AOJu0Yze8tKCctKaEOPDcvUDpGr/+dxWlThmPtDfHz6nfWYbhBRtAAPc
 HX6Dw9sJ0SZdwRGXZz+sm7c/gUif7HGW5JLvDB221vusV0jgC3bi/DQ/aIoSTaimfl2FI5mrrTX
 QJw==
X-Google-Smtp-Source: AGHT+IHVirNI2ibAkgXFdWF1P90ult+LoC9a/gvA8tzfYSuiYyglMwvqv4FEssyX6JF04aoqjnJI/A==
X-Received: by 2002:a17:907:9447:b0:a86:700f:93c1 with SMTP id
 a640c23a62f3a-a86a54de4f2mr1093107866b.60.1724822706814; 
 Tue, 27 Aug 2024 22:25:06 -0700 (PDT)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a86e582d448sm191503566b.126.2024.08.27.22.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 22:25:06 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 28 Aug 2024 01:25:00 -0400
Message-Id: <20240828052500.2395-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] isofs.sh: Create group and user before check mount
 option
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/fs/iso9660/isofs.sh | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/fs/iso9660/isofs.sh b/testcases/kernel/fs/iso9660/isofs.sh
index d1a362d97..7ec314d1e 100755
--- a/testcases/kernel/fs/iso9660/isofs.sh
+++ b/testcases/kernel/fs/iso9660/isofs.sh
@@ -13,10 +13,27 @@ TST_NEEDS_CMDS="mount umount"
 TST_NEEDS_TMPDIR=1
 TST_TESTFUNC=do_test
 TST_CNT=3
+TST_SETUP="setup"
+TST_CLEANUP="cleanup"
 
 MAX_DEPTH=3
 MAX_DIRS=4
 
+test_group="abc"
+
+setup()
+{
+	if ! getent group $test_group > /dev/null; then
+		useradd -U $test_group
+	fi
+}
+
+cleanup()
+{
+	userdel -f $test_group
+	groupdel -f $test_group
+}
+
 gen_fs_tree()
 {
 	local cur_path="$1"
@@ -69,6 +86,7 @@ do_test()
 	mkdir -p $make_file_sys_dir
 	gen_fs_tree "$make_file_sys_dir" 1
 
+
 	# Make ISO9660 file system with different options.
 	# Mount the ISO9660 file system with different mount options.
 	for mkisofs_opt in \
@@ -92,8 +110,8 @@ do_test()
 			"loop,block=512,unhide" \
 			"loop,block=1024,cruft" \
 			"loop,block=2048,nocompress" \
-			"loop,check=strict,map=off,gid=bin,uid=bin" \
-			"loop,check=strict,map=acorn,gid=bin,uid=bin" \
+			"loop,block=2048,nocompress" \ "loop,check=strict,map=off,gid=$test_group,uid=$test_group" \
+			"loop,check=strict,map=acorn,gid=$test_group,uid=$test_group" \
 			"loop,check=relaxed,map=normal" \
 			"loop,block=512,unhide,session=2"
 		do
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
