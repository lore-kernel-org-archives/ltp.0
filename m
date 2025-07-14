Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F90C83F1B
	for <ltp@archiver.kernel.org>; Mon, 14 Jul 2025 07:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752478378; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=cgnvze5eVV1bpvxJc45xvp0atnfdv2fj79eOEFSZi5Q=;
 b=NCmXKP9E2RSFCxdf5eCUL7NT31ZucARlsTis6AJLJJ7mkoLGg5diXL/nHqIRXmxzMJjs7
 xSgmjoywA9A9ihDJJTOtF4qPxlo5cSWqPWxSOhcrPovLmCqo9iok+pJPZvOgty0sd4gXzz1
 0c1DbQ+hC7W9BgB2qZ5+VIfMO7JDV4s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D33443CB534
	for <ltp@archiver.kernel.org>; Mon, 14 Jul 2025 09:32:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0681C3C103A
 for <ltp@lists.linux.it>; Mon, 14 Jul 2025 09:32:37 +0200 (CEST)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CA32A2009D9
 for <ltp@lists.linux.it>; Mon, 14 Jul 2025 09:32:36 +0200 (CEST)
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-3a522224582so1970173f8f.3
 for <ltp@lists.linux.it>; Mon, 14 Jul 2025 00:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752478356; x=1753083156; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IExCcQyQ5Y+Qyz0mENzQWFSAvD/YIPyddp9QKbuYQPE=;
 b=g9SHosJ6lodgVfVep1spO7WGXWlHssTuu6qV8pk4R884wF7QFu4h2jdBGLnRg+0kjM
 0njik5+r2LznmSO24gGtW52s/A0SsVI0zMaaQFOJ9OK4j9PIJ8YkyYzAuZpFp4pkE1Nw
 eWX3p4muyJkn8DoJ1Q3PlqwXYSvdnYukSJ7hNbhd0BlkjtDkElu7rRkKEVD7DRlHHZB4
 yt7OQtCeXzZzvc7leDN2wS54YMAbthcsqs4w0EQbwAOjt4u/WlNkJ6KY9BNg2LHbW0SD
 Y/1KXmVyteXFO/ge2AAFwAziH+fr/9WthT8W0r/9MQ7d4a8bqYFz/UuYUiMz3uJ9NaHO
 AnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752478356; x=1753083156;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IExCcQyQ5Y+Qyz0mENzQWFSAvD/YIPyddp9QKbuYQPE=;
 b=hUzGMyQiMuWijgAf5upf0cJMB83QfLrM2BpXxDz1NWl6yVENh8QeetB30MhqbL2zxs
 Q0BlIsC/8jcZGvOtgjQyGmzx2b9vnriSBQz2zwdaMVQRgjWi84HSa8RNdpC/9Y097U/w
 aTkq2HMPsKu+bhG11HA6et2IxwFljqtmb88+4u9JmuBYB1g9dF51aoH6YLVFFYkrSXLg
 7+lRKnXaJ+Im/aIaFVA442uRQFUXsr/2nvBnuB6GGmzbNJnrPNLaAlzkSr/oHRk1O4BD
 ujOq3tbgoHbK+VKPpFh6u3zeFfggxYpfad4NqV5XD+cuSZ8ZLkAVADhv+K9IiIVJWmWC
 J4Og==
X-Gm-Message-State: AOJu0Yy+Mi0wp8gvYbOfEy2XR38iRSBxh3Y6CEtWkZUSIeqt/zTvjZ4k
 +PM4INPWuwHK5q+wKZmzHzVLn+CKqj3SB5YA5cSjywiziaYG7Wie47s/fHYttWvXlas=
X-Gm-Gg: ASbGnctZV/0p5opd1DzM67T5oR75zQ5BKKVxnKXjDPbu4/cRH7pJ+dl+bKe4nwbh8gS
 eAV9h4L6IZS7mvgLoqpvm7xjKZ94NuwdtrpBlAQBUyMocvYSMx0TAFsEItlS73cR3kxFeYjBmjZ
 YjRMo+VCx+ohdNj0jKo1gUH5MZjNKjEx8d9sPa9Cu5XwvPjc3kozpO2ralQrgh8hhTMakwqIPV4
 NixX3tLN85lkuntEdvfsrT9EF50Vdaz8NDXp84FnaQHHGXH9AT+AYf+gkR8i89pNTTTSa2Y90OK
 gOpM4mCZW78LylIAuafps2REqTvi9+jSQ5jMzyYAm797w2+MuI8A+XNE7OnF+XwsNX5KfNqEpW8
 ij3j72f64i/1woqLW7Salfm/uDcplx3EhfVuPEIX+tiYThZ7T5k+9AxXfkIWsiPCQwJg0YTi621
 sbRaBlWvtRP5ZtmIpXS3mIFeHT6wXiW9HRcHIaG3nLloxzTIlCUYaihD8PMtBhHA==
X-Google-Smtp-Source: AGHT+IHYVm8wXx2IBqNPmwYHWwd6rrFHjsDjcnwjx9sIqDZefvR8gzXc7PymTnOitZehLTE3fZRQPQ==
X-Received: by 2002:a05:6000:288a:b0:3a3:7ba5:9618 with SMTP id
 ffacd0b85a97d-3b5f35784femr7181082f8f.29.1752478356157; 
 Mon, 14 Jul 2025 00:32:36 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de4285fcasm85636265ad.5.2025.07.14.00.32.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 00:32:35 -0700 (PDT)
Message-ID: <6995b29c-54df-421c-a649-e4b9db119cfb@suse.com>
Date: Mon, 14 Jul 2025 09:32:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zorro Lang <zlang@redhat.com>
References: <20250708055950.m25zfqyfr4n4qkcm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <c5247046-97ab-4d21-aacc-e4018ed4a366@suse.com>
 <20250713152142.2pe2sfgq4s2bd5xv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
In-Reply-To: <20250713152142.2pe2sfgq4s2bd5xv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Bug report] kirk can't run ltp's fs_readonly
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

Hi!

On 7/13/25 5:21 PM, Zorro Lang wrote:
> On Tue, Jul 08, 2025 at 10:59:22AM +0200, Andrea Cervesato wrote:
>> Hi!
>>
>> fixed by https://github.com/linux-test-project/kirk/pull/61
> Hmm... Looks like a regression from this change. After updating kirk to
> this fix/commit, old issues disappeared, but I started to hit some gf*
> fails (from runtest/fs), e.g.
>
> gf12 fails as:
>
> mkfifo: cannot create fifo '$': File exists
> mkfifo: cannot create fifo 'TMPDIR/gffifo17': No such file or directory
> growfiles(gf12): 147154 growfiles.c/1453: open($, 0102, 0777) returned -1, errno:21 Is a directory
> growfiles(gf12): 147154 growfiles.c/1765: 1 Hit max errors value of 1
> gf12        1  TFAIL  :  growfiles.c:134: Test failed
>
> gf19 fails as:
> growfiles(gf19): 147261 growfiles.c/1453: open(,, 02, 0777) returned -1, errno:2 No such file or directory
> growfiles(gf19): 147261 growfiles.c/1765: 1 Hit max errors value of 1
> gf19        1  TFAIL  :  growfiles.c:134: Test failed
>
> gf20 fails as:
> growfiles(gf20): 147275 growfiles.c/1453: open($, 0102, 0777) returned -1, errno:21 Is a directory
> growfiles(gf20): 147275 growfiles.c/1765: 1 Hit max errors value of 1
> gf20        1  TFAIL  :  growfiles.c:134: Test failed
>
>> - Andrea
>>
Thanks, I will check what's going on. It seems $ symbol is separated for 
some reason. I will fix it ASAP.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
