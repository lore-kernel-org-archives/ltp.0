Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B32C48BC3
	for <ltp@archiver.kernel.org>; Wed, 21 Feb 2024 08:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708505032; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=MNynsiiU0a+FsujgZlWXMq69zx4AUGXlUHRC8ohPDz0=;
 b=OSZW7PGBFvPsZP0RkTy6dNxH96Ma76AB0cz/e9YTEiUQ940aWLUQveQK2Zaekbo8SZFus
 HQpb/9yqWk/iEt1lRO9bPlcQlu8P/6sLOr3kHyzVpUtMyuz64rlx6K3Ukot09cyVAiH0mmj
 5T+aAtoyTB1hoA88WB65czeDaGctcRk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 117373D0356
	for <ltp@archiver.kernel.org>; Wed, 21 Feb 2024 09:43:52 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C781A3CF3BE
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 09:43:14 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2C24E60968C
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 09:43:14 +0100 (CET)
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2d240d8baf6so4072441fa.3
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 00:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1708504993; x=1709109793; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gIcj4UjvvVNMuWIkbsqPe7ofjOBdlOUsN15FyWcZjLY=;
 b=PGlqBssm0gj37mZZX1Kzbflbwvp/PrBYpGwF4+aBCLa9Q3dzaq3rxAxGkbx5/+X/M3
 WiO0cjAn+8U2ujIgu2aOr/q/G7cUFXvg6ZAXuqMSWEX19B8ALjxVqOetSEbyqsfnjEfs
 T0c0cizQCNS56/mODrjeTXoNvPmAUX1f24T5XfzF6xXIlCn/0DZxWem1uMKSpaciqgzl
 B5fpj711c819yh55b3v1Wnehna8GvvORF/NnMA76U6rxAK1e/eb0iGLdp7zwxPu4+Pzk
 aikhEIhFCD+6dtP1+R9uYzCFtNJsqj3vwF4N5liGeFiy6f429OhytpegxVoxy2QSZISL
 eIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708504993; x=1709109793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gIcj4UjvvVNMuWIkbsqPe7ofjOBdlOUsN15FyWcZjLY=;
 b=r9Ng9Og6QB4wC9+9tAmFmHs2kbUY3SDgv8qkQAKkebIpd9Kb6LYdq4PBsNQT1Mdd34
 XGHaTNnV9BrDxNlP3IYvQNoSErha0dsa1FJucDwkHpm/neNIw15hfjQ/QE5FbMM/2C+g
 bUFmwwnZmLlWQdCLfly6ejywC7gjpPl3l9Tf35fJxS+lfja3+mUU/9D4ex5TlTCKfr4V
 /Ku/KswsBhhGm1eO1q/AgIj1NAb+dLQcHEYeFsgUh6gfEr2HTfrnS2E2sjLSOlkEr1Y2
 XzBGj+gq4qPwazx3xjV5g78TN+gOdSU1CcUnRY1kwI6CAw2GQxoa+L+gYzrGBoKoLuHs
 wSRQ==
X-Gm-Message-State: AOJu0YyjbHSjhWTGWd91kR67rki00Xhy2i9Wi6P6DJo3su1GdtJ1Xd9D
 3nvM9L7HwhcGlOW2Cx6kO5cCls5LOXFR0h58unClO7su1+8sj40J0SzTCiVmWzQHfn3L4veCzV4
 =
X-Google-Smtp-Source: AGHT+IHpMqIm0r09tr4XujxSRJFcLO2qBPDrk4/OUTigFapMIHuGmkJjnC9SEEpW5tIS+Kx3j2mCkg==
X-Received: by 2002:a2e:81ce:0:b0:2d2:2fb7:b2f9 with SMTP id
 s14-20020a2e81ce000000b002d22fb7b2f9mr6877361ljg.2.1708504992970; 
 Wed, 21 Feb 2024 00:43:12 -0800 (PST)
Received: from localhost ([223.72.38.233]) by smtp.gmail.com with ESMTPSA id
 h7-20020a170902748700b001d9ef367c85sm7498512pll.104.2024.02.21.00.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 00:43:12 -0800 (PST)
To: ltp@lists.linux.it
Date: Wed, 21 Feb 2024 03:42:55 -0500
Message-Id: <20240221084256.32661-2-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240221084256.32661-1-wegao@suse.com>
References: <20240221071635.17239-1-wegao@suse.com>
 <20240221084256.32661-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/2] cgroup_core01.c: Set system default umaks to 0
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
index 2e695deed..ad08c74a9 100644
--- a/testcases/kernel/controllers/cgroup/cgroup_core01.c
+++ b/testcases/kernel/controllers/cgroup/cgroup_core01.c
@@ -76,6 +76,8 @@ static void setup(void)
 {
 	struct passwd *pw;
 
+	umask(0);
+
 	pw = SAFE_GETPWNAM("nobody");
 	nobody_uid = pw->pw_uid;
 	save_uid = geteuid();
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
