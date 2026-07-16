Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D999C4450A
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 13:15:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C7B2B3E5668
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 15:15:37 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 30C103E1C23
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 15:15:21 +0200 (CEST)
Received: from mail-qk2-x02.google.com (mail-qk2-x02.google.com
 [IPv6:2607:f8b0:4864:34::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6F21A1400DA9
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 15:15:21 +0200 (CEST)
Received: by mail-qk2-x02.google.com with SMTP id
 af79cd13be357-92e58c462aeso324761585a.1
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 06:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784207720; x=1784812520; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lLhjSRRO8VC0jswcOD0yhAoI9UmRiTC7vtJOYc9X03I=;
 b=ih0nEbBWh/BK7rkbI7cqoVmGEVX9LOgjs88e28USIrckHFFgSPeiBRa0j+k+JmSM9b
 Fp+Ps9RAREXsMK5urvRq7YVy0p7JZLAmJq1WtT21DcEf+hwGsIL5TBzDFOLtgWZM/dYc
 bfkUHhsR3Ia9EM6Yvj1E861PhJGk0DaICgcTr6sjNUFjSYJsAHf5RFa90ZDF1/gsgzwl
 Mgr7HOEGBiF6r6y35aX78MPdvUlQheCMsOa7U5DLHXpaT8iSlyNms/tLuXPWE+EjD9sB
 PA1qnBl9x/xaPCqi65C+9aHx3QMF8Q8jxOBiQI1/9QvAvecDXfLAap5Eloe1zax3Ldtr
 D9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784207720; x=1784812520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lLhjSRRO8VC0jswcOD0yhAoI9UmRiTC7vtJOYc9X03I=;
 b=h1+rAPpqSoyekYhLTGBfRxYTV50v2iDdZ5uDZTQdSU0Af07279LKDyd+p+GvVdps8X
 0zm6Tn1qlmFIU251C9cPBNrtEumE6zcFAQPTeP5JuAnyBgwcAmqcfyOiurLvsW7IQSgy
 itIX5phgLVdqOM4T1ShIEJAXKNWtk5013j/961ZFMPDlnIMNg8mggaltg9aQMKeCiitR
 tM+zPlCdQuYFIVYi++Sr46uR0j83ssVfE5Guu9/UltekYRYPuX6qLYTe7i7TCDambqaO
 oZ0cEeX75QsMidBuXtmwFRZQ6UBa6aK8wViHlvS9//LWX8p0FVCiDrWJxt3QpQutrHHb
 7/0A==
X-Gm-Message-State: AOJu0YzYfQdLzTMvkyOeSMy6IVgdcNJvcsJTDGSZhiaBW9ib+51U7D2v
 rD/eRGHiRB0OM4uACAmsr9xe22egUxOgM9Y/iNg3UodddYPh1Rd98T/A
X-Gm-Gg: AfdE7cnRINw5hDiLnLFwMc6WA4tjbXIY1KWCK1BfkHX1kOBk+2m2Gnf+Gr1kOIqBrwP
 CzIrvQqtmMkRNRJN1CMg4hcX74cs1J3LzG6Gym/I58+2Mwyz+LMzLdWt4XDQCqSPnPFyMInMNhC
 a5+3dpyq0EQLNmR6OJu+WlTyYF0nwzLe91DOdw52rwrstmetOxYg1IvCZnDT20OveXMTlCjZG9D
 i+226nrywuDJQQX4W+VkqHK7HO16BXO/8g7itSuVoG1cGW8KkxvzBODRC8iLLlakHXStSumI/75
 AsG2wDmaQ0Z8gHVFDkOB7ua18zXOXii8KMT7jklvRqGEdpafhSfpeO+qlE4uiQi1dFBnmYfkctr
 LJfSOdxKPdL0jTVO9yrVN/4QNXIC4UOcHQD09B7oFFU6bFdpeb9a+ii+qpLui5GTd2jf/VLlpcO
 XyV5hF3Sv0yF8L59AlBq+4fOCA5a1r84iLGbXxxz29kHjP95e3wp74kXGA5G9PVEJfyyZQYaZyx
 qTOCNsLhdRz0oUd
X-Received: by 2002:a05:620a:31a5:b0:92e:c117:9ea9 with SMTP id
 af79cd13be357-930962f47d7mr730429885a.87.1784207719836; 
 Thu, 16 Jul 2026 06:15:19 -0700 (PDT)
Received: from
 runnervm3jd5f.khaltgvq52gehclg14nj1z4fne.ex.internal.cloudapp.net
 ([52.162.9.246]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ffd80fd492sm239639736d6.34.2026.07.16.06.15.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:15:19 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 16 Jul 2026 13:15:18 +0000
Message-ID: <20260716131518.4741-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716-rewrite_inode_testing_suite-v1-1-b6fee6f0d0ba@suse.com>
References: <20260716-rewrite_inode_testing_suite-v1-1-b6fee6f0d0ba@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] inode: convert to new API and merge into a single test
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

Hi Andrea,

On Thu, 16 Jul 2026 11:43:52 +0200, Andrea Cervesato wrote:
> inode: convert to new API and merge into a single test

> +CPPFLAGS			+= -DLINUX

The rewritten inode01.c has no #ifdef LINUX guards, and inode02.c is
deleted. This CPPFLAGS line in the Makefile is now dead and should be
removed in this patch.

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
