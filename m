Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 141A2C87FCA
	for <ltp@archiver.kernel.org>; Fri,  1 Aug 2025 13:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754054284; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=C2/dFDeKisT3gS8K/89NST37IydzCZgUs6BQlF8eP2A=;
 b=Kup8DCqzaAWl9nFrImFNs421VJgyCsYR3mE4zmVvOMhoXi3EXyGcEWYPEWIw9w/S7JLLJ
 rQWlohX0w6hAxrW92pwi94VlhpAUwCxjwQnjC85qcxsTLOZZI0e+Y/wmfvRckH/omhUbNfV
 /rSclwRM20qIJMG+yH43S7DBKz7qtOo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 456413CCE98
	for <ltp@archiver.kernel.org>; Fri,  1 Aug 2025 15:18:04 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E0423CCDAF
 for <ltp@lists.linux.it>; Fri,  1 Aug 2025 15:17:42 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7C1241400F36
 for <ltp@lists.linux.it>; Fri,  1 Aug 2025 15:17:41 +0200 (CEST)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-615d1865b2dso923798a12.0
 for <ltp@lists.linux.it>; Fri, 01 Aug 2025 06:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1754054261; x=1754659061; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z+ZOhBIBeBWTOI8walUWPbV5byFYRpnVy6JR03CFDc0=;
 b=S69QUf1JasS2X1Ee0axlOKlKA/eHa4k+o1aU8c3tRfv1bMls5yBXb5aoNRaUYahCVP
 Bk7dLD8cUJoHJ226EKsotSpDtYZ+6edaVb8B8XtRAcxDIJdnrUoRCSMCZChQNW4PAaY/
 G8YNYKURkDHhX0jSWHD21X4FXVWzD5u07yiQv0rS70MbA0kFCPF2pyO4oHqNvIE7MBib
 Ym+qo0PcRSpLp9PTnAB5nctlXMWXAmQlhb4dYfSzblyJ31fX3cM5Uh/AluPau8+cGSPg
 0f6nz3JjvJGNFLUtARkJYF9dm9t3iS7PpT6jSkx/aqs+0u5MlAg4le6IB+KsxmlH0sLQ
 pURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754054261; x=1754659061;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z+ZOhBIBeBWTOI8walUWPbV5byFYRpnVy6JR03CFDc0=;
 b=JVezBdCYECdwTeu159bkWJvM73NzvfrFS+DrT+UOXgIA4JluYgtcejWNuL3hYvtaEV
 89D5ecf54xFwiUwklfAuIi5B+7FM3xQEvBpeFEtDGsEFn3vXiA/xcxfcXLM68ZMC69Bw
 dfhNF9dn9pJmtZ0zkZP+dcUtFtYo13NrFbSjl/r9Geh74ycl4vHfgjyBD1Ncq+erd6tj
 p6neUrE6xyLXgxd3bocyQqXYsqS8qkCV7xUE805SqKXAnwecgH6tHaabECWQIVikS0Cu
 RiStlDHpGa5xlbR+fbAKzq2FED3uQAUFl8LAOl+woHrSsCmAfstZlheA5qqt81IXzlhB
 q8VQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWf/USbpv/oSkMCunOxV7WfPBNZki6miuQtrtX1LX6yFyzLY2AmAHkuDaSkA6T8D7j6Aeo=@lists.linux.it
X-Gm-Message-State: AOJu0Yz+2NDe23nedaEtWvGWdKmWTwAn4QlhnUS31OVBMtWyHoOiRVn4
 Lnu4FjziWOG+1OJ0H6xj681BDvqKtizil3kyep53IBhW3Zy43BhDr1BbvovyUH2tQnE=
X-Gm-Gg: ASbGncvszfg/UgRRjm2wVWsyXVlGkYPO783AuABXnN5i7YUaM7bXwK1WlAyDzkCHab/
 kvj2LoUvKMg86M6Jdmv29efBFMsmUUEfS45Cx/Ejj5azy29bdg3gHfPMU/CnchG4Iz++XNS5AE6
 Z9AUCct/goemPE/qFVq9Rk6bAbdIRjZ4zPTFm3Cu9KCObkmwFH6gqB7V7HhiYD7REZFAAiXEOzI
 zAUNC1pIKIiSG5acEVaw1FjtFWxRTyc8ZbNLR8GN9H7QAx70aMO5A9Zn7H/CLDjlW8W4erNhDFw
 dgA9Z+sQnxbklnOhUKOgrhVWA16W1vgcQlzOP6KcSSnwj2nYjWZCDKV8UtwPIJkbFcPaN7hK/Mw
 inGL27LnA2gReRS8g+OTnyPvr39ipWejobQ==
X-Google-Smtp-Source: AGHT+IH1909VImaxa12wB/rDrzQKVeIfYHYZiuDzZ4vHUOQFWRxnsZjNsMg2QUMZx5f9Vt3XCdrekw==
X-Received: by 2002:a05:6402:5210:b0:615:aa7d:de69 with SMTP id
 4fb4d7f45d1cf-615aa7de39amr6507128a12.22.1754054260732; 
 Fri, 01 Aug 2025 06:17:40 -0700 (PDT)
Received: from [192.168.1.91] ([151.71.164.197])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-615a8f00247sm2798210a12.9.2025.08.01.06.17.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Aug 2025 06:17:40 -0700 (PDT)
Message-ID: <33bb23db-b6f3-4566-918d-64400427a21e@suse.com>
Date: Fri, 1 Aug 2025 15:17:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20250717-clock_nanosleep05-v4-0-78bc62df960f@suse.com>
 <20250717-clock_nanosleep05-v4-2-78bc62df960f@suse.com>
 <aIjUY9_MhWC3KMaN@yuki.lan> <b0a34ad9-9e59-4d46-b202-2eada747b791@suse.com>
 <aIy16j72Yke0W69n@yuki.lan>
Content-Language: en-US
In-Reply-To: <aIy16j72Yke0W69n@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/2] Add clock_settime04 test
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


On 8/1/25 2:41 PM, Cyril Hrubis wrote:
> Hi!
>>> Here as well, SAFE_CLOCK_GETTIME() uses struct timespec as defined by
>>> libc, so we have to either use syscall that corresponds to the
>>> begin->type (tv->clock_gettime), or covert the value from
>>> SAFE_CLOCK_GETTIME() into the right type. I guess that it would look
>>> like:
>> Why not just going back to the original idea in v1, where we are using
>> the clock_gettime/settime corresponding to the right libc?
> Actually the v4 was quite close to what I had in my mind, the corrected
> code looks like:
>
> // SPDX-License-Identifier: GPL-2.0-or-later
> /*
>   * Copyright (c) 2025 Andrea Cervesato <andrea.cervesato@suse.com>
>   */
>
> /*\
>   * Verify that changing the value of the CLOCK_REALTIME clock via
>   * clock_settime() shall have no effect on a thread that is blocked on
>   * absolute/relative clock_nanosleep().
>   */
>
> #include "tst_test.h"
> #include "tst_timer.h"
> #include "tst_safe_clocks.h"
> #include "time64_variants.h"
>
> #define SEC_TO_US(x)     (x * 1000 * 1000)
>
> #define CHILD_SLEEP_US SEC_TO_US(5)
> #define PARENT_SLEEP_S 2
> #define DELTA_US SEC_TO_US(1)
>
> static struct tst_ts *sleep_child;
>
> static struct time64_variants variants[] = {
> 	{
> 		.clock_nanosleep = libc_clock_nanosleep,
> 		.ts_type = TST_LIBC_TIMESPEC,
> 		.desc = "vDSO or syscall with libc spec"
> 	},
>
> #if (__NR_clock_nanosleep != __LTP__NR_INVALID_SYSCALL)
> 	{
> 		.clock_nanosleep = sys_clock_nanosleep,
> 		.ts_type = TST_KERN_OLD_TIMESPEC,
> 		.desc = "syscall with old kernel spec"
> 	},
> #endif
>
> #if (__NR_clock_nanosleep_time64 != __LTP__NR_INVALID_SYSCALL)
> 	{
> 		.clock_nanosleep = sys_clock_nanosleep64,
> 		.ts_type = TST_KERN_TIMESPEC,
> 		.desc = "syscall time64 with kernel spec"
> 	},
> #endif
> };
>
> static void child_nanosleep(struct time64_variants *tv, const int flags)
> {
> 	long long delta;
> 	struct timespec begin, end;
>
> 	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC, &begin);
>
> 	if (flags & TIMER_ABSTIME) {
> 		tst_res(TINFO, "Using absolute time sleep");
>
> 		tst_ts_set_sec(sleep_child, begin.tv_sec);
> 		tst_ts_set_nsec(sleep_child, begin.tv_nsec);
>
> 		*sleep_child = tst_ts_add_us(*sleep_child, CHILD_SLEEP_US);
> 	} else {
> 		tst_res(TINFO, "Using relative time sleep");
>
> 		*sleep_child = tst_ts_from_us(sleep_child->type, CHILD_SLEEP_US);
> 	}
>
> 	TEST(tv->clock_nanosleep(CLOCK_REALTIME, flags, tst_ts_get(sleep_child), NULL));
> 	if (TST_RET)
> 		tst_brk(TBROK | TERRNO, "clock_nanosleep() error");
>
> 	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC, &end);
>
> 	if (tst_timespec_lt(end, begin)) {
> 		tst_res(TFAIL, "clock_settime() didn't sleep enough. "
> 			"begin: %lld ms >= end: %lld ms",
> 			tst_timespec_to_ms(begin),
> 			tst_timespec_to_ms(end));
> 		return;
> 	}
>
> 	delta = tst_timespec_abs_diff_us(begin, end);
> 	if (!(flags & TIMER_ABSTIME))
> 		delta -= CHILD_SLEEP_US;
>
> 	if (delta > DELTA_US) {
> 		tst_res(TFAIL, "parent clock_settime() affected child sleep. "
> 			"begin: %lld ms, end: %lld ms",
> 			tst_timespec_to_ms(begin),
> 			tst_timespec_to_ms(end));
> 		return;
> 	}
>
> 	tst_res(TPASS, "parent clock_settime() didn't affect child sleep "
> 		"(delta time: %lld us)", delta);
> }
>
> static void run(unsigned int tc_index)
> {
> 	struct time64_variants *tv = &variants[tst_variant];
> 	struct timespec begin;
> 	struct timespec sleep_parent = {
> 		.tv_sec = PARENT_SLEEP_S,
> 	};
>
> 	if (!SAFE_FORK()) {
> 		child_nanosleep(tv, tc_index ? TIMER_ABSTIME : 0);
> 		exit(0);
> 	}
>
> 	SAFE_CLOCK_GETTIME(CLOCK_REALTIME, &begin);
> 	SAFE_CLOCK_NANOSLEEP(CLOCK_REALTIME, 0, &sleep_parent, NULL);
> 	SAFE_CLOCK_SETTIME(CLOCK_REALTIME, &begin);
> }
>
> static void setup(void)
> {
> 	sleep_child->type = variants[tst_variant].ts_type;
>
> 	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
> }
>
> static struct tst_test test = {
> 	.test = run,
> 	.setup = setup,
> 	.tcnt = 2,
> 	.needs_root = 1,
> 	.forks_child = 1,
> 	.restore_wallclock = 1,
> 	.test_variants = ARRAY_SIZE(variants),
> 	.bufs = (struct tst_buffers []) {
> 		{&sleep_child, .size = sizeof(struct tst_ts)},
> 		{},
> 	}
> };

Ok feel free to push with Co-developed.

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

Thanks,
- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
