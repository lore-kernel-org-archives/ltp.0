Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B27E8C8303C
	for <ltp@archiver.kernel.org>; Fri, 11 Jul 2025 10:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752230205; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=yDimy3yG3ZD/lEg0FgNjKzisu77YNy5N03t22vvQExU=;
 b=VgI3qRurTPK9/TxTrRMgTNC0JzKqHJ53o59fZrNfJdI5efeUhXCY10zYeXLeWsmzaAp1B
 Nd/++8RXmwHUY7rh5Yn9jShHbNJqaQqxv3A+8wyrXwxuqyQFIfyHbrj+BWj7iU8qQ6+kpO2
 wN3KabScNlzfeq5gcjUqnU9ulqEOwjk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE55D3CB22B
	for <ltp@archiver.kernel.org>; Fri, 11 Jul 2025 12:36:45 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1ACA33C006A
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 12:36:24 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4987A14004F4
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 12:36:23 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-450cb2ddd46so11340795e9.2
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 03:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752230182; x=1752834982; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NOrsLmYr2ShkZMelPkOS4YEiq7VXjfkYWx/T6eUzZWo=;
 b=EVXDYj+XWxWabUzLxtPqWPaeZx6Ys/Dvxlc5TlGfPkYxdCjd0gOrAS80SshjVVS9y4
 NZDb2urNObBB6sx17lt2UQy+UbVF/h6gY5VvakoJL+y/S14kulhBllhkAKCCZGMhOnMt
 xmPmHREFKvX0p0Ll6SHaDHygjciC8Cov2Zt/eGG8Tgi2ee7O+AkrOl2AtQYIxTMi2KMX
 vImY1AtkxwZ2GulWNmeA38cel/53n/04nI6mudyt2vEVfZY1oo+FHQgjza9Lzae7F/Bj
 jKmKGrIFkgKE0H4IPp9McDo/wsfuIvz/6jhe0VUQjsPafjU0KBdu5r9geHa+T54MkTEu
 3n0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752230182; x=1752834982;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NOrsLmYr2ShkZMelPkOS4YEiq7VXjfkYWx/T6eUzZWo=;
 b=WXodxg/e5+TPAdqXLPU6r/ymgVLPuIGDKusczX/0zIG7QLb+nSmNQjUc7HKp4rbqTi
 RrrlEQ7Tpl3S7PwMBFK7hRX82mFqVRwTxakJ8DzsBQL0l3QYtkukxJCUrGBisADxCGtR
 IMpHg8BRKbggPSTznHGaFhCB91qEaVJ+ZB5D2gtLQ6buH0ZIeqGj0ahQNuiD4oyHGMVF
 kQAswwZEPh9kpxBY7vZrcFcFhXlj00/Nc4HmiC/ufUQ1/4HCf5z+sua8pjL51cEb0tKE
 AeEctRf6Bais0UY02/wGMQwipEL1hpMKiQn3xTa4opXNrJK/8GYh7gG0/91GtGFvaS2m
 KIgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtCmz3QUxn7Re6UdCadaMoM3+Z/AO43ACeXOmT0x0AV0HwT5prBiujyfN3Rc9YyW7KvUE=@lists.linux.it
X-Gm-Message-State: AOJu0YxfjJz2sj0y50pOnuBIXVZ3MKtnzwoHzCzvyKuqE22M0XqIk9Ex
 Whr1+g3xxy8ZJHwAP71V41vy9mhtaJMMKrZ3ib6n8A2rWmn09j0a+6eBpnmB1tDPcvo=
X-Gm-Gg: ASbGncvXaW2Sk806R8ZR6uYKk3IX+ara400O4qKUopAMDUhd8LUTjD1K8hH9ZH8IXdj
 fHrfnGm1yp8IXrHHawrRIuNOGLEqdFYeS6cutSISNF3uzFGl3OcjSgtftUxa3/orNqKq1oac0ah
 I4I1i4NLBJ2QcXrtXXJt6RJkCfazP3gyCfvC2EOdcz2oJYWWxfNKEY0JGXMEikkTieaZ5K+aBsK
 Vg60D+Q7K9kNiUNa3HDQgCGfT45gVe0crjbWM5IRUYxMaVmu2bTCOFtblRop2uo8pzBvv2TWjrL
 eFj+v6A7tmwhun7MQrxrI0pDrBIDmWiDBGvrk+GUL3vstfeNdc9op9lAKybf7CmY5djftT1n+rW
 2yhXKb2wOHeI0C3qW5ch0kjKakTPTNwsrl6msB670uPMZJ2EGak2LRzqGuf4UJmCnkLWReXyTly
 3jj1Vh8+igLQlf+ZE393I50dkwbm70Mv7mW+3mjlEGc0FZdvXfWyNQei2N0sueVruwOWf7e3tT
X-Google-Smtp-Source: AGHT+IFSzv4Hc/5F6c/KXsTHxTsHcTceOejL+2Uwj3FJ8W0dSgE+lQDRBFoqEwVvMZk6oGOrJPHTtg==
X-Received: by 2002:a05:6000:4819:b0:3a4:e844:745d with SMTP id
 ffacd0b85a97d-3b5f18debb9mr2655994f8f.56.1752230182558; 
 Fri, 11 Jul 2025 03:36:22 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9e075e2sm5252124b3a.52.2025.07.11.03.36.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jul 2025 03:36:22 -0700 (PDT)
Message-ID: <2dbfe780-40b6-4b8a-9cb4-1517f3a8be7b@suse.com>
Date: Fri, 11 Jul 2025 12:36:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20250710082000.11641-1-akumar@suse.de>
 <12708664.O9o76ZdvQC@thinkpad>
 <581805f2-0633-4e94-9252-b1be2bd47112@suse.com> <aG-BOM0OEKrp-GHm@yuki.lan>
Content-Language: en-US
In-Reply-To: <aG-BOM0OEKrp-GHm@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cgroup_regression_test: Use unique names for
 hierarchies in each test
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
Cc: mkoutny@suse.com, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 7/10/25 11:00 AM, Cyril Hrubis wrote:
> Hi!
>>> I forgot to mention that I also tried to use
>>> tst_umount() helper routine, but that did not help as umount does not
>>> really report any failures here.
>> The solution doesn't really convince me. If it's true that a util-linux
>> upgrade to v2.41 is causing this issue, we should probably research why
>> this is happening in there and (eventually) fix it. Or, if it's not a
>> library bug, we should fix tst_umount() in order to recognize when a
>> cgroups folder hasn't been fully unmounted.
>>
>> @Cyril WDYT ?
> This indeed looks like a workaround for a bug either in the test or in
> the system.
>
Perhaps, by placing sync before every new test which is going to mount a 
new cgroup folder we fix the issue as well.
I'm wondering if we should dig into it a big deeper...

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
