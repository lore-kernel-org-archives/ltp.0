Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DECBC624A4
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 16:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788194314; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=bDrCVETLJhCYXNA5Xw68j3k99G0K8+I3BIlYOBhrWW0=;
 b=X8wd2mA7OpMVe3AIkpNiDXDvsz9IkpfYhOEtf+4RzY2691nDAtyjSRx05amDfWX/xpXLp
 0amTmOPJjO6gyatABFZeHvXMleXV6wvBQV2lz9pBrwMXf4rMcoP2mDD6KY1tMYZLAXimeKM
 8go/NUO1XvYxQEhhmxu/mc1kWKCEOQU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1BAD43E99B7
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 18:38:34 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C3323E1505
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 18:38:14 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 600FF1400C54
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 18:38:13 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-495437bb891so423015e9.1
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 09:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788194293; x=1788799093; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vK/6S1yPKjS1xeatDh7IoieGLW0C+rDHR8/ZvZ1Pb8c=;
 b=VnwIvHuz54fpieyK4DQyBHyvI4d9gT/szHfjixv6/3ci1mqw35D5qHhBS0/h2XgIZ7
 zdLhxDsiRft/zJB7p1H1gJ3Zj6licq9nwx+Hkqv5MlP4pYtHfZ5FnFHXEdAWjPQwsZDD
 NQrnos2UanFNUnBfGCMWVNZGPWdKGxAVf/2fwlIq2ojHQ+c5u7jKMtIqvxdcEWAW7bMw
 clP9rGgbD65VUIHotFNbIKODoRHDtkCgNP0FbBqROa9PHFcxnYeFIQqeAHZBbkF6DapS
 gae7rxbCyBbtazop2Q0WiFEGvO9Kaws/L6H+1N2vQG8xGCqZfdtIr9INjxxTP5yf/YrF
 fMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788194293; x=1788799093;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vK/6S1yPKjS1xeatDh7IoieGLW0C+rDHR8/ZvZ1Pb8c=;
 b=HP23LXNzs+f+H16q+4yEaWbwuuDRTo0oFOIXT3zcPU5YwS/1td3uLjdIMaiH8XOnBb
 7Ga/97DGjUtk/43kCigTLXcp1CjMO4KQ0wHV+obBQJU/E3Nyn0s6UX62lXGwnWn1IwXa
 9R6+hwDrEt66dDM7K1p5FCmSSEjxbjtaGX1g953bKWKA1oHSY3T7D/JCUnXpeieTVVEi
 +TXTFRc/rriGqH+6Jk//o9WSHI+3utCy6dFY32fulz5mEGEnZ8UAh6/CinGaLdHxr1Qp
 BZOU6YeyGdPJBWvuVfKkANZe/mI/CCbcNf3keIzDx0MFROtPDp852YBrHR3IjiAYX+oh
 9nwA==
X-Gm-Message-State: AFuF++lfa3Y02DPsDLOcQJB8P+61BY8X1TQ+JYQPdyZiNpRgHZrZGJJA
 ruGwfuEwDeiPJrqRSrx9DbakmtrZyJvW8Q9u15CMA0UIPLOAUvTDXHRM3Sj6oz8gwz0=
X-Gm-Gg: AR+sD10kYJb4qVP0N/n1VDEPVzzu+jnXTJlM3NL3L3yOd0w/SVn9CAf3INhgb+ay2lt
 1xZXPQDyyMxtbx5TJa3gQuAWRgJVeHH4q37sV1nXRmRN3rJm9jWufcHtRt5JGFjgOGQNKfGkz5g
 IXsDm+sf6lhBt9RgcxPr2xKsycrLqH/agk2YYPkJFO0sA7MT7ZWZ9sX1kDiT64XRNrzQ5OYawkZ
 6gr8FymUvpcKoL/g9LvPmWo5A+K5ff/aleJgvP1Dlzkq7xUq8nn8fj4fHcyv1AFu14zAxwQ2b6V
 Dc9w6E9Y2JsH3HbQx2x3SsVmLzwvTA9lUNX3TrOVtecOrFw1Tss2Xm1jQlPOL2r1aLggHV31Hnj
 dbsG22GBHcfSdWx/b3XmCaH00S29qtZnbYgslIaFBD3mYqRGKyznQRuDidSHz0a5efIEIqVZKEZ
 q6wJJfBfMqXyWl54+cHb8upHft43jwwzyjhyUhr0BhIvaquiALadnFJYoJg9vfYUvaP08gTxq3t
 uA8
X-Received: by 2002:a05:600c:1d02:b0:49b:e22:4ee4 with SMTP id
 5b1f17b1804b1-49cd538b513mr173871475e9.4.1788194292651; 
 Mon, 31 Aug 2026 09:38:12 -0700 (PDT)
Received: from ?IPV6:2a07:b241:1004:8300::1000? ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4843310ab41sm16085258f8f.7.2026.08.31.09.38.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 09:38:12 -0700 (PDT)
Message-ID: <dc0b87e0-3aec-49e4-8451-b7189420e654@suse.com>
Date: Mon, 31 Aug 2026 18:38:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20260819093210.24342-1-avinesh.kumar@suse.com>
 <20260819103310.39525-1-linuxtestproject.agent@gmail.com>
 <apVUR0360UHO0KMt@yuki.lan>
Content-Language: en-US
In-Reply-To: <apVUR0360UHO0KMt@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] openposix: timer_*/speculative: Skip untestable optional
 behavior on Linux
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

On 8/31/26 12:15 PM, Cyril Hrubis wrote:
> Hi!
>>> openposix: timer_*/speculative: Skip untestable optional behavior on Linux
>>
>>> +#ifdef __linux__
>>> +	printf("Linux does not implement this optional behavior\n");
>>> +	return PTS_UNSUPPORTED;
>>> +#else
>>
>> Could these branches be removed from all eleven tests? Linux 7.2 uses
>> scoped_timer_get_or_fail() to return -EINVAL for invalid timer IDs in
>> timer_gettime(), timer_getoverrun(), timer_settime(), and timer_delete().
>> The installed man pages document the same EINVAL result.
>>
>> More directly, every pre-patch test reports errno == EINVAL and returns
>> PTS_PASS when built and run on Linux. The platform check therefore replaces
>> working coverage with PTS_UNSUPPORTED, and the quoted runtime message is not
>> accurate.
> 
> That's the kernel part, apparently it's more complex in libc.
> 
> Libc has two types of timer_t values, either it's a directly kernel
> timer id (small int) or a pointer to a structure that holds the id.
> 
> The timer libc functions, before calling the kernel syscall, convert the
> libc timer id into kernel timer id with:
> 
> static inline kernel_timer_t
> timerid_to_kernel_timer (timer_t timerid)
> {
>    if (timer_is_sigev_thread (timerid))
>      return timerid_to_timer (timerid)->ktimerid;
>    else
>      return (kernel_timer_t) ((uintptr_t) timerid);
> }
> 
> The library does a bit of magic with the pointers:
> 
> https://codebrowser.dev/glibc/glibc/sysdeps/unix/sysv/linux/kernel-posix-timers.h.html
> 
> But overall it checks the MSB bit of the pointer to figure out if it's
> kernel timer id which should be passed verbatim, or a structure that
> needs to be dereferenced.
> 
> Looking at the timer_gettime/speculative/6-1.c we do pass a pointer to
> the stack (instead of the invalid value) which on 32bit may be an
> address with the MSB bit set. So this triggers undefined behavior, since
> glibc thinks it's a pointer to it's internal data structure, but the
> real pointer the glibc exports as the timer is bit-shifted. Hence we
> access random and possibly invalid address. With some luck that address
> is accesible and contains non-zero data and we end up passing invalid
> timer ID to the kernel, but when I straced the test, the value was
> pretty much random.
> 

I was also trying to understand the sign bit usage and bit shifting
magic in this glibc code, causing this issue. Thanks for explaining
this clearly. I have send revised patch -
https://lore.kernel.org/ltp/20260831163310.137399-1-avinesh.kumar@suse.com/T/#u


Regards,
Avinesh

> With that in mind, we can fix the test with passing the BOGUSID instead
> of random stack pointer:
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c
> index d09c2f709..c35dd816f 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c
> @@ -21,8 +21,7 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
>   {
>          timer_t tid;
>          struct itimerspec its;
> -       int tval = BOGUSTID;
> -       tid = (timer_t) & tval;
> +       tid = (timer_t) BOGUSTID;
>          if (timer_gettime(tid, &its) == -1) {
>                  if (EINVAL == errno) {
>                          printf("fcn returned -1 and errno==EINVAL\n");
> 



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
