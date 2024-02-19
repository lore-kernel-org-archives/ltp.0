Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2136FC48BF8
	for <ltp@archiver.kernel.org>; Mon, 19 Feb 2024 13:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708350561; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=FSxXoZqUUID5HZEH6m5/pGdF1vf8Q5aUXs9NKse/1UA=;
 b=PcYuEbblOHEPPAOtLNIwjFiUcm22am+7gNEPpKsgfyp1PPJy9NaAhyV98xW8K4oGT2PK3
 Cf6l/PEDWp1RD9SZw6GNljBzZi6GrinYy6r9tes/Mo3NXdppquSeSmT3jXNiWs20Z6tedWb
 TCqyvXalpoOSVq7lhaKgWDclHulEnaQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C89A43D13A9
	for <ltp@archiver.kernel.org>; Mon, 19 Feb 2024 14:49:21 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1648D3C0706
 for <ltp@lists.linux.it>; Mon, 19 Feb 2024 14:49:01 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D20F960070E
 for <ltp@lists.linux.it>; Mon, 19 Feb 2024 14:48:59 +0100 (CET)
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2d240d8baf6so6419281fa.3
 for <ltp@lists.linux.it>; Mon, 19 Feb 2024 05:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1708350538; x=1708955338; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x45hMgQm/krwBOLsgLY6/m34D301rFfLgvcAF6eZfd0=;
 b=DxK1AxAznxEMHQn0WtR7C29bbnqb/487+igqyUkSAkaqllvhJHw4MG15n2zxT0yRC9
 O5KPzNYDo1F80s48mcsPcsdDW029WeZlTP9doTDWHXNR8a/Jr3/QdPeWtnqKLXRc0pH8
 nfg6bfr9ai4sjnqI1a1d/cknzxoz9aUQFKcCi9rf0QEt/1aMRDQdy79ttDEkyOzjdmJq
 NdCYw/gv67Dj36WLaJGTRVgRJwBR+XauE3oKjMEgqQFlFyxi5ysjPQUPThJShDaiCOmY
 TqiiynNRHuIX8mHs6x4CzBFwhgiFOBCqYxfO1K86ke2QFizq7mKYZeZUXRRTGGLXmT18
 FPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708350538; x=1708955338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x45hMgQm/krwBOLsgLY6/m34D301rFfLgvcAF6eZfd0=;
 b=l8OPWh3zANdkdnBoW9ewlzDDxNzfrbxKgVKnsxOHHFZM5AFNqIgawE//MiqQ+7WG7X
 zMD6FCKEtafzl5C+mTB7ybX3PkD3ZnhlpmBDQO79q0rMkaC51jIvpbym8jc3aDRyKm49
 SYWAGRCp0lVoyecudNQhQLmAWa7NkR26BdL4owHbxy+SrsptIJg6a4fJgVt2EZeHkeKB
 1C60sjJn/HE1JqhlbS2r8kbqjhUvAsErREOS8loFynNABiYQzgZ5PhZMxfP1NzFnZiRM
 YrHUNbsjJkM6XoHmqezFr++6I62/nPIHDHSvCVP8OuUX2BSubwNQefo5QDTAY9btMjnP
 8v/g==
X-Gm-Message-State: AOJu0YyOHPOY8kjLG21cQDWq1n2NNFe/eZvjjYG8hdvI2yAdpWk5LPol
 5yUAl6nSlGOT/2YacBpf8J7vT2dUPZ0GrOwQm7iQLSzr7yut63CTB104g7rSkG9/RAMhw3z7I/w
 =
X-Google-Smtp-Source: AGHT+IGW2qj829SfLo/NS09Zt75bx24A31wJ/rmBWFRGDXByOfLZE6n6feHNB2zTkGhWK3uWroP06g==
X-Received: by 2002:a2e:be9f:0:b0:2d2:2ea3:a397 with SMTP id
 a31-20020a2ebe9f000000b002d22ea3a397mr4503064ljr.40.1708350538242; 
 Mon, 19 Feb 2024 05:48:58 -0800 (PST)
Received: from localhost ([223.72.38.233]) by smtp.gmail.com with ESMTPSA id
 fd10-20020a056a002e8a00b006e10bfd6a94sm4823716pfb.128.2024.02.19.05.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 05:48:57 -0800 (PST)
To: ltp@lists.linux.it
Date: Mon, 19 Feb 2024 08:48:45 -0500
Message-Id: <20240219134845.22171-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231204002623.17302-1-wegao@suse.com>
References: <20231204002623.17302-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] tst_test.c: Set system default umaks to 0022
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

Some system's default umask is 0077, this will trigger issues for LTP case.

Example 1:
cgroup_core01.c will report following error msg:
cgroup_core01.c:50: TBROK: openat(21</sys/fs/cgroup/memory/ltp/test-3519/child_b>, 'tasks', 2, 0): EACCES (13)

Detail reason:
Code:
cg_child_a = tst_cg_group_mk(tst_cg, "child_a");
cg_child_b = tst_cg_group_mk(tst_cg, "child_b");

Result:
wegao:/sys/fs/cgroup # ll ltp/test-25304/
drwx------ 2 root root 0 Feb 10 10:37 child_a   <<<<<< group and other has no any permission
drwx------ 2 root root 0 Feb 10 10:38 child_b

Code:
SAFE_CG_FCHOWN(cg_child_a, "cgroup.procs",  nobody_uid, -1);
SAFE_CG_FCHOWN(cg_child_b, "cgroup.procs",  nobody_uid, -1);

Result:
wegao:/sys/fs/cgroup # ll ltp/test-26388/child_a/
total 0
-rw-r--r-- 1 nobody root 0 Feb 10 10:44 cgroup.procs  <<<<<<

Code:
SAFE_SETEUID(nobody_uid); <<<< after switch to nobody then can not access child_{a,b} or any file
under child_{a,b}

Result:
nobody@wegao:/sys/fs/cgroup/ltp/test-26730> ll child_a/  <<< nobody has no permission on child_a
ls: cannot open directory 'child_a/': Permission denied

Code:
loops = SAFE_CG_OPEN(cg_child_b, "cgroup.procs", O_RDWR, fds);
Result:
cgroup_core01.c:76: TBROK: openat(9</sys/fs/cgroup/ltp/test-26388/child_b>, 'cgroup.procs', 2, 0): EACCES (13)

Example 2:
chdir01
chdir01.c:107: TFAIL: nobody: chdir("testfile") returned unexpected error: EACCES (13)

Reason:
susetest:/tmp/LTP_chd5JtblL/mntpoint # mount | grep loop0
/dev/loop0 on /tmp/LTP_chd5JtblL/mntpoint type vfat (rw,relatime,fmask=0077,dmask=0077,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro)
/dev/loop0 on /var/tmp/LTP_chd5JtblL/mntpoint type vfat (rw,relatime,fmask=0077,dmask=0077,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro)

susetest:/tmp/LTP_chd5JtblL # ll
total 307216
drwx------ 4 root root     16384 Dec 31  1969 mntpoint <<<< nobody has no permission on mount directory
-rw------- 1 root root 314572800 Feb 19 04:51 test_dev.img

susetest:/tmp/LTP_chd5JtblL/mntpoint # ll
total 16
-rwx------ 1 root root    0 Feb 19 04:53 aa
drwx------ 2 root root 8192 Feb 19 04:50 keep_out
drwx------ 2 root root 8192 Feb 19 04:50 subdir
-rwx------ 1 root root    0 Feb 19 04:50 testfile <<<< nobody has no permission on testfile

Signed-off-by: Wei Gao <wegao@suse.com>
---
 lib/tst_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index edb42f7f4..e03fd93e7 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1174,6 +1174,8 @@ static void do_setup(int argc, char *argv[])
 {
 	char *tdebug_env = getenv("LTP_ENABLE_DEBUG");
 
+	umask(0022);
+
 	if (!tst_test)
 		tst_brk(TBROK, "No tests to run");
 
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
