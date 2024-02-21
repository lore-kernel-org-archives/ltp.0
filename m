Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F21C48BF6
	for <ltp@archiver.kernel.org>; Wed, 21 Feb 2024 07:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708499850; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=3X9RQ7gzEGZzgrhVnKW01AxWoWpc6EUDMhOpfPrq8Lc=;
 b=TZfeoq2ycmGau3iJPp/d/aLY0Ed3GEumfA8raZ8AGTzU3gMzunvHJ+3HepDIjv7lsH2zH
 D5FP7zvng+msWaA6O/e5OLChcjGrr7rIDDpBYsetki67U/paQzu6xYXToAulQCLVMHnfgva
 4qHgisIyxKkdyXuBHZ84SdmwXx2PgMk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E33FA3CF19D
	for <ltp@archiver.kernel.org>; Wed, 21 Feb 2024 08:17:30 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F1B253CF1AE
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 08:16:58 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5F41D1000C1A
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 08:16:58 +0100 (CET)
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2d23a5a7c18so33925541fa.2
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 23:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1708499817; x=1709104617; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=naAs/dYVQmevTSvDz+3o+NE2Si9Z7LzarOSpYcBqiGQ=;
 b=X1iUE34h+5TsGn266qAWC6Dy/an/EoMHXAhpcQ/Xsi7xz1pj6FiVwzjHASUW0XDQTb
 +0tppVQ++LZtd0pH+Uk2E4v0x7mlaLGVnhdmdsj7ETZehNM/AvcWWQZaPMl8PLlNFIU6
 J4gtPS7b9Z4diX3nl2S8AmzsJHdr0Wx3Bq+nLSXuO6Hq2f4eQ4pM4S0C6XnIR0IS6JPY
 yhS0KxTr+pTNsdg1FAu6JkAecSBQBS4g9sFEqpPuc5dgBnwLq1cbQEMfYFHTx3TTGrNW
 d/SPE/Mo5+JDc30pWhSPDcKiyCkk4Hi/kszHO7d3AlISo6tYn+K81fNAdUlg/p3/vJAd
 FVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708499817; x=1709104617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=naAs/dYVQmevTSvDz+3o+NE2Si9Z7LzarOSpYcBqiGQ=;
 b=aEhtOR2fKTJxIHmS75kKyF0/s0X9kHidp2M8G6lHupk965uY8wItV6CIRc3H91PkWt
 JJNHZx61PjVHYprUAtmq1aHzqaDBOHWyecOpVpCllyrS+M2igsgWtstoVl40dYS7Fc2j
 yVuMiIH+W7nALFyp+OYHRkpDY0LcpbjiWPdhg8gGCFOJKYCVTiLHF9EQaVNWWiAlTGT0
 KNp3jEvpg2oy+C3kH/6ZAXNr8jCmz9KIlVGAyJb2gNvPnhZLRNKEMIGQig4B4XHhL/4Q
 Y8GS3pmdKjL3EJzqSn+CeFm6KzzrWTmS32Ppj/GWL4t8xVFk1fkwwETb3UF0iGD7gnyN
 ZmEA==
X-Gm-Message-State: AOJu0YzAHn7EW+ekCXBt//vLPgKaL0gzwRTsrh6o32niU/Ts9ox4E9MG
 gzUEvfht6y7U5NN3Y1lYXp/4ZKxZli+6+u0la1emfIydtZruiJ2gblTwcn5IKsLJXS9Yo3WjKsE
 =
X-Google-Smtp-Source: AGHT+IEy8mU4eLkEnNQJljuNYAiZ9z8/lLD7jOTGMMtw2h7Ad2XEctYtIOlJGfP6Q6gZswVqr2YuPw==
X-Received: by 2002:a2e:a4b8:0:b0:2d2:3d31:220f with SMTP id
 g24-20020a2ea4b8000000b002d23d31220fmr3840784ljm.25.1708499817121; 
 Tue, 20 Feb 2024 23:16:57 -0800 (PST)
Received: from localhost ([223.72.38.233]) by smtp.gmail.com with ESMTPSA id
 q13-20020a056a00088d00b006e05c801748sm8046037pfj.199.2024.02.20.23.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 23:16:56 -0800 (PST)
To: ltp@lists.linux.it
Date: Wed, 21 Feb 2024 02:16:34 -0500
Message-Id: <20240221071635.17239-2-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240221071635.17239-1-wegao@suse.com>
References: <20240219134845.22171-1-wegao@suse.com>
 <20240221071635.17239-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] cgroup_core01.c: Set system default umaks to
 0022
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

When system's default umask is 0077, this will trigger issues for LTP case.

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

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/controllers/cgroup/cgroup_core01.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/controllers/cgroup/cgroup_core01.c b/testcases/kernel/controllers/cgroup/cgroup_core01.c
index 2e695deed..80d13a9c5 100644
--- a/testcases/kernel/controllers/cgroup/cgroup_core01.c
+++ b/testcases/kernel/controllers/cgroup/cgroup_core01.c
@@ -76,6 +76,8 @@ static void setup(void)
 {
 	struct passwd *pw;
 
+	umask(0022);
+
 	pw = SAFE_GETPWNAM("nobody");
 	nobody_uid = pw->pw_uid;
 	save_uid = geteuid();
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
