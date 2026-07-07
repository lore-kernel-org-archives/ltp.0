Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F020C43458
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 16:37:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA1C03E5DD5
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 18:37:11 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EEAB03CFBB1
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 18:36:50 +0200 (CEST)
Received: from mail-qv2-x01.google.com (mail-qv2-x01.google.com
 [IPv6:2607:f8b0:4864:33::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5F12910007DC
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 18:36:50 +0200 (CEST)
Received: by mail-qv2-x01.google.com with SMTP id
 6a1803df08f44-8db16576206so1327756d6.1
 for <ltp@lists.linux.it>; Tue, 07 Jul 2026 09:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783442209; x=1784047009; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gXksbrBhDgwLMiUPrYSG00oqmU1NZJHrGmTe2v4f8b8=;
 b=ESajlv3n0/5DhG0t4zAfbcRlvtLosYe/hkeKfcaezdbjn2Ix7ZNzxvM7o9w4gNzoyj
 CTzPI6I1kRw8zkew07YFD9Br8Y57z1rwIm0rlY+CUtW0jY5aVzXesM96y3l+Z1iq0MhK
 oOd26FL1ZL4Yxd6WwJAUb8Q1gChtZIfbeZYCzKUdeI/7TQTyMCw0hkPFgYNAIZ51X45E
 lMbSpsLyuREXQiwK65iJDxj5+bDCyroomW4MCHPnBGD+S3lawlfrg2viowGBxhgAe1ZU
 3wWhXrpemVEoF5WGg0xN/pcd7YFdAwBr6+s5IzGuqEmnfJDcOVIHfNZDCibp1jnu1lPF
 Q3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783442209; x=1784047009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gXksbrBhDgwLMiUPrYSG00oqmU1NZJHrGmTe2v4f8b8=;
 b=OiB/oi7Q3rMM/wz6C4iW359hYqsVR+Yogt1dRzomANsawK4o9kC5MrB84OJnshqgIh
 iK15VNwPb0VXUA6SaQZa8Z3krVKo19PX/kUGLXS2ESMD3mMCQ8h9cVI/OK3iNg1F7loG
 xUYtNfauxVpRIB5+GcRDEy5vnnYM4cPXmCZvNhFyuiPwzVplmn37cX9qiJkebeObhih9
 NnVvbkCUPcYsB9MgKG68RksyBpWiBu1uoYpDqywMEhE09se59uPIeeFB8y6ip9FUqZkl
 1xPHigVePXEl+mENNWwO7VXhDC6Ka2zzvFIMj18vUqt9Ma69suU7gwJdZ1bmBqiGsL/S
 yyBA==
X-Gm-Message-State: AOJu0Yxb3Mw6uSJMW7+DLLbs0sgJOwvkUMMZ71FdJpgHvF27oko1P8OO
 Lrpf7dB6vngnXu/3E9VcJlGfDQsgzH9+JbKCyH8wLFtZqmbhjdPoyq0f
X-Gm-Gg: AfdE7ckYWu/DJPHc6GGTtgUT/hVF07xoG0VzarokFMh3o4M6iXQa7MSG53vBBge7mgr
 1ZxjnD22/Vf5Sh3IEU8VhQ1gLiQtfQ+eE5lW1BpyhWMazQaA7YnIpQ1TgehkfWIb8CtF70Ed/Qz
 4NDSBRGI1TW4dZ9fmLNO0bnbucZCFVhpOOb3x9hM4GM4HziwoRxKda9+V6TeYkGmNqyQKnT5Bwr
 cnU009CYaaF94b8SD9vhjNDn4zjV/GwqjKBJV/A41qjJ3g/kPR3de2Jopv6GmV7OzBEI7z+hIt1
 0S5P7wc6x2EsF+zP1dxZVsE3jw725SnpcxY2bvvOYpxhRm23nFYAGcnXetL2+5qnEqVwV9l51qr
 hQQQA/tQfchBfvTiSsXSeLr42X8OYlj3oHxjhUlFXr+SFlF0SPkmxvkbgVvm4zUDma4VK/CLoBi
 dOfDHIictwiD26uFFLXOApzKAT90kupwQMmenEeZP+7lZwjGKzQnYf1FkyLjneuyIf7ljCntB+P
 fr5MBRZnxJ5IZevZfb+xBvIki1UxW4=
X-Received: by 2002:a05:620a:19a9:b0:92b:3203:ea70 with SMTP id
 af79cd13be357-92ec0c79ee3mr329680985a.12.1783442209059; 
 Tue, 07 Jul 2026 09:36:49 -0700 (PDT)
Received: from
 runnervmkkn4f.tuhdi32ki0sehjc0brvip54rwg.bx.internal.cloudapp.net
 ([172.203.207.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e90ccdd5csm1241437785a.36.2026.07.07.09.36.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 09:36:48 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jinseok Kim <always.starving0@gmail.com>
Date: Tue,  7 Jul 2026 16:36:48 +0000
Message-ID: <20260707163648.4043-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707150920.6489-1-always.starving0@gmail.com>
References: <20260707150920.6489-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] power_management: rewrite runpwtests04.sh in C
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Jinseok,

On Wed, 8 Jul 2026, Jinseok Kim wrote:
> power_management: rewrite runpwtests04.sh in C

> The new implementation preserves the original test semantics while
> removing shell dependencies.

The original shell test only checked current_governor_ro and
current_driver for readability. The new test also covers
available_governors, current_governor (read), and adds a write
rejection check against current_governor. That is an extension,
not a preservation of semantics. Please update the commit message
body to reflect what is actually added.

> +static void verify_cpuidle(unsigned int i)
> +{
> +	int ret;
> +	char path[PATH_MAX];
> +	char buf[32];
> +
> +	snprintf(path, sizeof(path), "%s/%s", CPUIDLE_PATH, tcases[i].name);
> +
> +	if (tcases[i].is_writable)
> +		fd = open(path, O_RDWR);
> +	else
> +		fd = open(path, O_RDONLY);

open() is a tested subject here -- its return code drives the
TCONF/TFAIL decision. Bare syscalls that are the subject of the
test must be wrapped in TEST(), not called directly. The same
applies to read() and write() below.

> +	ret = read(fd, buf, sizeof(buf));
> +
> +	if (ret < 0)
> +		tst_res(TFAIL | TERRNO, "%s read() failed", path);
> +	else if (ret == 0)
> +		tst_res(TFAIL, "%s read() returned 0", path);
> +	else
> +		tst_res(TPASS, "%s read() successfully", path);

read() is the primary subject of this test and must be wrapped in
TEST() so that TST_RET and TST_ERR are populated.

> +	if (tcases[i].is_writable) {
> +		if (write(fd, "invalid_governor", 16) < 0) {

Same for write().

> +static struct tst_test test = {
> +	.cleanup = cleanup,
> +	.needs_root = 1,

The doc comment only mentions readability. It does not explain why
root is required. Ground Rule 4 requires the reason to appear in
the /*\ ... */ block. Root is needed here for writing to
current_governor and for the save_restore of that path; please
document that.

> + * Verify that selected cpuidle sysfs files are readable.

The test also verifies that writing an invalid governor name to
current_governor is rejected with EINVAL. The description should
cover both aspects.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
