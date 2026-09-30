Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD35CA5FBA
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 11:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1790767572; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=MmqSZewOEbZafkp7iH6aLAlNDvVy1XJaGPpNN7oPoIU=;
 b=q5KiQmjYAJtRW8pAl0fSxUKIzopv3SfQQu4sGb23EvbdlBOMsQScdNlh/ABWCTynXnkh3
 JNUG9RL0dOqXSe7vfg9XEx1j9YE1uuiFdNijBsT0adzHkQ5llchF4AddwCV5IpLd4TumKfI
 V9ddWZCHuiKvimov59NjnbvijJQqAh0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BBDC03E568E
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 13:26:12 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C4D8C3C1CAC
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 13:25:52 +0200 (CEST)
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C145C1A0070E
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 13:25:51 +0200 (CEST)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-485ac898fa4so4166694f8f.0
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 04:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1790767551; x=1791372351; darn=lists.linux.it;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=io9kON6DXJ/5ip82VJlVyQ8JDkSfc+nAACZyjiL3ack=;
 b=duHu5N+cpVBEzNWbrB7zkznoEodGNvTWBuXSMyovdAL2Hq2awpbYfrM9Qo/vEekOiA
 VWWJ0XixSVPSnNzeIXcK5jYi4ktWXm2wjjpZJfQoOYea0f57mT083C7rF0WQ0j0wNDuA
 hDveru7WPybomPNmBIq4M2rozWpPinY6Qfrw96u9rG8VwpzOLiFOOhI+wUNIfAbTaqVy
 BMYe4JtCGQOLilrlog4iFB6miwCff7hbYg96lf0VDFs0RqMCceAzW7xk0wlfC6FBJKv2
 TuSbAwoZyMqls6v2l5XA+gE5fKKw78uNGBvbdVeYD5C8LJ2VyJGctXd7eDul9uBtU3aj
 Gp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790767551; x=1791372351;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=io9kON6DXJ/5ip82VJlVyQ8JDkSfc+nAACZyjiL3ack=;
 b=wETr2CDyh942z+S4hP+1yAeiQQv5IRV75gklBIpV81fZbiqQZVOUPJkaCqAWXt11t5
 LqB5b93NmDDBIvNDiZQTK7yEDkiDk9UduyW7xx7an9AlF8NbRgfTsmsfW8QJYFX3S/eo
 hyz2hYG0cT3grU3zqBps847MGQXSpKyydoxHY4w8baOjG7B9hGCTt3hZiO7Gc5GtJ4OE
 NOViQtM/q3mXt16tkVQOsp1LesZMyvRunHbFcLRPEBtvPCHAW4cOMlk1xDo0po8sRqbD
 SdeBa48Nlk1jyhpU3hJ8xk6r5BS/MRnsVG5Dw5UbgaKQMNmkkSji+XTTHQJ9JdoGZeIH
 mlGA==
X-Gm-Message-State: AFq9FYKOg/7qOM+PkpU6FTAXGJWoUb0rsI0CZXS2FcMo2ybxqMzf2kGI
 CAE7agVplrxqN81m+5k4pJEvbMT4rv3WgzCLReCxdMJapY4sFURk1deBPHtLXSbYEYcd9EIT+mb
 oUh8=
X-Gm-Gg: AYBFou138EvbjZWXVoT0o/zS/fARv0JVy1SkZSqu5l/IvNe5/arF2SkwyzxhJrjCAXm
 3EMfAvLO5vTaQiCbORM4la7nKSrqyqUM+dEzXJs7mPw68IiF+2BiSDYzcEnurK3jhtPcEq0JC1S
 vHi4FPHQgPCmMyM5kNDNQCCL2ACU0dgNGdWPPTwV4PSIOh9myisO/kWaGphVswT46rgbzZr5LDs
 MQTGVwsu5UuSABeU+QwXly9VI+YxbxVcqOjx61nYTEUXmyRpCp+QjM85ATQAHqYgjA8PN17LPVq
 wB2/FvyzhtGc9ciFbRWZesiyvigeAYHmNa4uaKhgcXbXSYAiDSMHolPH6VfDYhf83B64NjRnI7D
 lnevu2UD1+Ywcvtaib3b3k05kD0BYGfsd6sCbVjpOEkGvK9ijcWdzmnquzSHNvAFiQUp9o+2yZl
 g8wn1+7SqYdNy+PVWBxungnVv/1H7rOsJIIDS/QjqazC5rKdyH3qLGN5qsSIwrCnw4dTRN1WOHb
 +49UhL0RdU8yeegIewHLsAjPz3EFE65at0jfzjMhzkVcOkjue3rBsgKF8IQ56FlJ1jfp5b47A==
X-Received: by 2002:a05:6000:40ca:b0:48a:f571:7b50 with SMTP id
 ffacd0b85a97d-48b024d7284mr2157965f8f.27.1790767551098; 
 Wed, 30 Sep 2026 04:25:51 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029fc420sm2743928f8f.28.2026.09.30.04.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 04:25:50 -0700 (PDT)
Date: Wed, 30 Sep 2026 11:25:49 +0000
To: linuxtestproject.agent@gmail.com
Message-ID: <arzxvXvTYIKR0Dly@autotest-wegao.qe.prg2.suse.org>
References: <20260930035332.3360-2-wegao@suse.com>
 <20260930081114.8885-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260930081114.8885-1-linuxtestproject.agent@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] memcontrol: Add bind_to_current_cpu() helper
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Sep 30, 2026 at 08:11:14AM +0000, linuxtestproject.agent@gmail.com wrote:
> Hi Wei,
> 
> On Wed Sep 30 03:53:14 2026 +0000, Wei Gao via ltp wrote:
> > memcontrol: Add bind_to_current_cpu() helper
> 
> --- [PATCH 1/2] ---
> 
> > Add bind_to_current_cpu() to memcontrol_common.h to allow memcg tests
> > to bind the test process to a single CPU.
> 
> The commit message only restates what changed. Explain why memcg tests
> need to bind to a single CPU (e.g. to prevent multi-CPU per-CPU memcg stock
> charge accumulation from causing reclaim variance in hierarchical tests).
> 
The reason is in PATCH 2/2.

> > +static inline void bind_to_current_cpu(void)
> > +{
> > +	int cpu = sched_getcpu();
> > +	size_t mask_size;
> > +	cpu_set_t *mask;
> 
> Include <sched.h> in memcontrol_common.h. The function uses sched_getcpu(),
> cpu_set_t, CPU_ALLOC(), and sched_setaffinity(), but currently relies on
> indirect inclusion via tst_test.h.
@Andrea Maybe we need update AI rules? 
> 
> Verdict - Needs revision
> 
> Pre-existing issues:
> - memcontrol03.c:209: sleep(1) is used in a polling loop. Polling loops
>   should use exponential backoff or checkpoint synchronization.
> - memcontrol03.c:241, memcontrol04.c:240: fd validity is checked with
>   fd > -1 instead of the LTP convention fd != -1.
> 
> ---
> Note:
> 
> The agent can sometimes produce false positives although often its
> findings are genuine. If you find issues with the review, please
> comment this email or ignore the suggestions.
> 
> Regards,
> LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
