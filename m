Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CA860A2612
	for <ltp@archiver.kernel.org>; Thu, 19 Nov 2026 15:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=k2DmHL2X;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BRUXE+NP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1795100805; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=iO2jDNUGIjFckcP81Q1LE6F2nA1pxq1jwPBRQsWtImg=;
 b=k2DmHL2Xz9A6efmTl/yX667i0E7pcOn08hfpHENGuhjON4Kg6TYAjkMUrO1sSflfjNoEd
 0gqNzjLcK/W+rX5MTb6Bm7to9Kgoe0HHAISb941zBmK2cY+FhtO2lW30KIIbaYzqjJLRdaq
 5jb8IjeVWLw1/ACpVjg6dSV/Pe3jCgY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 064E33EA009
	for <ltp@archiver.kernel.org>; Thu, 19 Nov 2026 16:06:45 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 896B23E9293
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 16:06:26 +0100 (CET)
Received: from mail-oi1-x245.google.com (mail-oi1-x245.google.com
 [IPv6:2607:f8b0:4864:20::245])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0FEFC200B27
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 16:06:26 +0100 (CET)
Received: by mail-oi1-x245.google.com with SMTP id
 5614622812f47-4e937c5bd4fso1481399b6e.2
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 07:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795100785; x=1795705585; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2ZjODrPe+mmc2UuE8x5DduaWjspfWevJqUA65R1kXnk=;
 b=BRUXE+NPy39Gcv2/Pe5iXzveTYBW4U33XZJnDYVADnWXjF7RiGEbpMPhTe/9BVEA1O
 x42cALAZbrcIR9JqXw8AUQuNWLF+/obT3gpokRUHJm8fFHSbNYOz6XSnKEZAtHDTyFGz
 s/2lEzuQ+jUf9/M0CbXB4IbS+HSSY+a+vsfTuoEFU1H63SIP1dpB8l0BhsVMIACbYvb8
 lA4wj9eGdKJCu1SiCoQqJ5A3rXSOTxGJLmUB23usjJAj9M77H4loafpzL6PE2BplGgnF
 kKZ5W7L9eY5F/NvQUPbjNWa5gfHn9UvDEpP3ZLGenTS4EuHu/4IopawRzoyiJcgKdL66
 IF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795100785; x=1795705585;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2ZjODrPe+mmc2UuE8x5DduaWjspfWevJqUA65R1kXnk=;
 b=0HfbOO8mVGeOcZ4eTgIkE0EUs1RMJ5rjQK0PnU5CGv5U+u2VYbmEBOafo46tw7nUtG
 vCc4RnazJloeT4I12ssQLRfC5X3WUpehF4Uoi4Ua1U1odJnYCOoVasqWK731ZFNHrZrZ
 5l+Yg1drlKiqP/saviX51DZavd8YifdFOIWQP+KTzNg8DPOZhXBIxmbueth7UPjhshsB
 p+RGL57cFrRM3DqlRaUCv7gtqPYLuA2zHZkYu0lpXJX1RWX1P/WxfeT1EPdNFPtS18Ee
 ClDVShBdxod/ybUv4CJ58jNp0/rCy6UziMsi+epslJOiS6PQrtS9RDgAL9qP4JeR2q7r
 wL9A==
X-Gm-Message-State: APuU4Z/V5cnZQGx+WKOqmPpChryAzgoUioaMUWMSrudpJnatMqq/Ipx4
 lqR6+/hGgryT0HXh53wR1vrFvtWyAIsa4H8gWrFnnkRU5rcNaOV2EG3S/Xrd6cCCiRS+7Il++6y
 gXQ==
X-Received: from iobgl11.prod.google.com
 ([2002:a05:6602:4f0b:b0:9cd:a6f7:7b88])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:244e:b0:53c:5052:ea07
 with SMTP id 5614622812f47-57a06a105b2mr225906b6e.5.1795100784174; Thu, 19
 Nov 2026 07:06:24 -0800 (PST)
Date: Thu, 19 Nov 2026 15:06:19 +0000
In-Reply-To: <20261119103711.3002153-1-chrubis@suse.cz>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261119103711.3002153-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261119150619.449861-1-wakel@google.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sys_rtc01: Rewrite the RTC check
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: Wake Liu <wakel@google.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

On Thu, Nov 19, 2026 at 11:37:11AM +0100, Cyril Hrubis wrote:
> Instead of comparing system time against RTC, which proved to be
> unreliable we now sample the RTC since_epoch and compare it with
> CLOCK_MONOTONIC_RAW timer.

Thanks for reworking this! Dropping the system time comparison and timing
since_epoch transitions against CLOCK_MONOTONIC_RAW is much cleaner and
avoids all the STA_UNSYNC / CONFIG_RTC_SYSTOHC corner cases on our
systems.

Two small things I noticed while reviewing and testing the patch:

> +static void poll_rtc(struct rtc_dev *rtc)
> +{
> +	struct timespec start, end;
> +	struct rtc_edge edge;
> +	long long val;
> +
> +	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC_RAW, &start);
> +	val = TST_SYSFS_READ_LI(PATH_CLASS_RTC "/%s/since_epoch", rtc->name);
> +	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC_RAW, &end);

The kernel exports since_epoch as time64_t ("%lld") and val is already
long long, so this should use TST_SYSFS_READ_LLI() (and likewise in
read_rtc_snapshot() with a long long since_epoch). Otherwise on 32-bit
userspace an uninitialized or secondary RTC set past 2038 clamps "%ld"
to LONG_MAX on every read, making poll_rtc() see 0 transitions (and
mismatching 64-bit timegm() when _TIME_BITS=64).

>  static struct tst_test test = {
> +	.setup = setup,
>  	.test_all = do_test,
> +	.runtime = 5,
>  };

Since the test requires at least 2 transitions, could we also set
.min_runtime = 3 (or 4)? Without it, running with e.g.
LTP_RUNTIME_MUL=0.2 clamps runtime to 1s and fails with:

  sys_rtc01.c:261: TFAIL: rtc0: since_epoch did not advance (1 transitions seen)

With those two fixed, feel free to add:
Reviewed-by: Wake Liu <wakel@google.com>

Best regards,
Wake

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
