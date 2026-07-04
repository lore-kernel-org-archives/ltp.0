Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 206DAC43458
	for <ltp@archiver.kernel.org>; Sat,  4 Jul 2026 07:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783151443; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RvQS3My5HwSq2K5RttU8VnbzNNhVP7yiLmG8soZhaH0=;
 b=Fa9R4L50Ph7ezi2Vi9leZvWoTBZmiz/ICf4lbUQBPCpETdku58Nazs1tKvJIe1qTtsjF9
 dzQ5wYsgfQGx3bIywj1dT/e0YGM7nMky01ruYCfMS4Yn+bau7TgO+QUCJ4uOhwCHXpVG7Yu
 98Oo8xua+7X2bmp/0VvRZZhfsS1ys0M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B6923E2E4C
	for <ltp@archiver.kernel.org>; Sat,  4 Jul 2026 09:50:43 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E87403E1C7C
 for <ltp@lists.linux.it>; Sat,  4 Jul 2026 09:50:21 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4C29A201165
 for <ltp@lists.linux.it>; Sat,  4 Jul 2026 09:50:21 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-471eeac43bfso1398289f8f.3
 for <ltp@lists.linux.it>; Sat, 04 Jul 2026 00:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783151421; x=1783756221; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=8GVwV1sO7VZBtiponH8PccPB7hEljwNU+jPZDZ7ZMHs=;
 b=BdrFvsail4gn/lvrqyyA+ekXzt1lwfJPsHXg2qI6PmB9zY28udYRnOlF4QtxuN1Pe2
 xP/acUqsndGdG2DwimhfVlziyCF5sPLr+PmZClYXq6iirG62k5SQBlrvvQ4S4Uspv/Bb
 z0i86thcWatnl/qpTUkXTjUrUURcyX26gK7xA7jWz1Ec5wF8UjMGojhLIKGnoODelKQL
 FeClSUO5ESkVAgjK3RfEAABEF6/yD8qRzy1ykqNAoN2X6cyY/ufCjpGWmy7aDrywKzo2
 QUW4bN1E+Xt4F+rdb4dYO06S+/2Fp7kT4WqccFVnnpUjMcgfmhJmgklFxL4Af1A+gD8W
 X77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783151421; x=1783756221;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8GVwV1sO7VZBtiponH8PccPB7hEljwNU+jPZDZ7ZMHs=;
 b=B9kMERsQO5ywBREja+VDcLpwW82VTz1hwQC/W5Wmv1GIG/jxJ8Rw+KzO4wBeIN3HMP
 AE5/vOdid9a2MC7nHvCYw1a1K4cSp/Jv+Gr21l+u6lKwaNqIKiMS0XI38eUALJcGcHOe
 iGR1zgu9Ypw4UI5IpUJEg/EqmhvK1LHodad7y1EXiz3JSpXKivekExXqb0bEJTvxHkdG
 gNpWGb/A1NZMlGcUh8DWlyEy0HeLvRjYlQvBwmU+8cAjzeNwgSi6DRRLAGcGoqx1/0Oj
 WDtaHzWQmZcymdjVlH+5v3yINuuRBBsBMQxfX4fEN0vWeteCGGBEH+8pKbobHRUGVR+u
 G7qA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/qPq2rMLRseyGJiZkH502bKGLhM3HgGbxVuRsru1W0hu4Ydak3WLL50OgbmNrq5+PBNY4=@lists.linux.it
X-Gm-Message-State: AOJu0Yzi5eg8V/gxgMj8xAOufdUvtDXBiIUZOGBlqEo82wqSTkn7wDPV
 bjY+cv/Peu4KjqU8zeltX38DepTf2Z1nc4U61ZzrzdU8wMATY6SZkulPklSPXRbwi2s=
X-Gm-Gg: AfdE7clsojIWd/vCaej+hQO8Ze3VZ9w2NZVRz2g2HOYncANhWo0HO/r/r1omGzZDk1/
 eA6hHSxgVY7LIugV5B2F+r9wCOFGtO6IZNV+bYT0rNEKIXaN0NIdQE3A5lUO4TF7UbXSqs2NYbd
 LrYC4jOJpRSu91c3xH4vFyAz452ZVGynDebn/zXLc8kdjsKl33VwFZ56brSi3p9RhGF/vpY8KK7
 oRjqVYFVzvCeJSlSm3avYM0oVYLwX957jMacZkjcHCpVks4GtUWgdkWtwxhwBGd6WTcUVfIKHFS
 KrGF97AC91iiKoA/DiDOS+4sPwLLAPAZwoH6UuX6LUtLMewr1ix8nySNk3Gnx6ySZl+Wgo7Vh1t
 VmhxEuqgKQ3XrbBjvjRuSM2WBVmZFnGnCGYJaArw8AWmwFK2nXBmIP/3kbFULo3JXUqoFqnu/L6
 Q09muaE9gnLosEd+GTlo3YQPZH0HGeFn01FQBnJNDKR6XSlfLFeUefO7pQajCVTPc6RocEY9E89
 ju1Os+wvnhtxzCZc7+59V18
X-Received: by 2002:a05:600c:524b:b0:492:40e2:358d with SMTP id
 5b1f17b1804b1-493d11de9bcmr24832395e9.16.1783151420588; 
 Sat, 04 Jul 2026 00:50:20 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493cce12c40sm178679735e9.13.2026.07.04.00.50.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 00:50:20 -0700 (PDT)
Message-ID: <6a48bb3c.bc1d6770.394c18.b078@mx.google.com>
To: "Li Wang" <li.wang@linux.dev>
In-Reply-To: <aki2AjzuU7_ayxrZ@linux.dev>
Date: Sat, 04 Jul 2026 07:50:19 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] memcg_stress: survive OOM by targeting the
 stressors
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

> I agree with the underlying goal, keep the driver alive and let the
> stressors absorb the OOM pressure, but I'd like to suggest a different
> way that mirrors what we already do in the C harness, and that fixes
> this at the lib level rather than in the individual test.
> 
> In lib/tst_test.c we don't raise the score of the stress/test processes.
> Instead we protect the harness and then explicitly drop that protection
> in the child before it runs the actual test:
> 
> $ grep -A 8 -B 9 tst_enable_oom_protection lib/tst_test.c
> 
> void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
> {
> 	unsigned int test_variants = 1;
> 	struct utsname uval;
> 
> 	tst_test = self;
> 
> 	do_setup(argc, argv);
> 	tst_enable_oom_protection(context->lib_pid);
> 
> 	SAFE_SIGNAL(SIGALRM, alarm_handler);
> 	SAFE_SIGNAL(SIGUSR1, heartbeat_handler);
> 
> 	tst_res(TINFO, "LTP version: "LTP_VERSION);
> 
> 	uname(&uval);
> 	tst_res(TINFO, "Tested kernel: %s %s %s", uval.release, uval.version, uval.machine);
> 
> $ grep -A 8 -B 9 tst_disable_oom_protection lib/tst_test.c
> 	alarm(context->overall_time);
> 
> 	show_failure_hints = 1;
> 
> 	test_pid = fork();
> 	if (test_pid < 0)
> 		tst_brk(TBROK | TERRNO, "fork()");
> 
> 	if (!test_pid) {
> 		tst_disable_oom_protection(0);
> 		SAFE_SIGNAL(SIGALRM, SIG_DFL);
> 		SAFE_SIGNAL(SIGUSR1, SIG_DFL);
> 		SAFE_SIGNAL(SIGTERM, SIG_DFL);
> 		SAFE_SIGNAL(SIGINT, SIG_DFL);
> 		SAFE_SETPGID(0, 0);
> 		testrun();
> 	}
> 
> The important detail is that oom_score_adj is inherited across fork.
> So the model is: the library process sets itself to -1000, and child
> resets itself back to 0 before doing any real work. The harness survives,
> the workload stays a normal OOM candidate.
> 
> What do you think about doing this in the shell lib so all shell
> tests benefit, rather than only memcg_stress?

this patch was sent with a wrong assumption indeed. As you can see
from the log, the OOM message is wrong and I pasted the wrong example :)

But this raised a good point that I think you spotted quite well. It
would be nice to implement this indeed, since shell tests are often
causing issues when it comes to containers or stressing the memory.

I will leave to @Petr the last word because he's more expert than me
on the shell tests.

Thanks,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
