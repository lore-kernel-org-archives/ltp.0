Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724A8CCA470
	for <ltp@archiver.kernel.org>; Wed,  8 Oct 2025 10:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1759920077; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=U+5xpnvg5MwzGcr+p9a7gG1Jrm3VsByRtS9/nZ3JZcE=;
 b=bB3svn1jljhSa2rl3Gxg+rIw56GQbHo7PKOxbQUd/gez2+6yyyYUWCORJIuMdD0sqET0O
 t6LrX4UUkSANL250lLTNgIi9oYOf3ih3IH3dYBAMBn/d8nUQ7JCB5ypMFIZFl7BHWXT3Fc9
 DlH92Ga7oM5zXUd8X0eNSmy9odSotnw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B9CF63CE6F2
	for <ltp@archiver.kernel.org>; Wed,  8 Oct 2025 12:41:17 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 56B4C3C86AE
 for <ltp@lists.linux.it>; Wed,  8 Oct 2025 12:40:56 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 35A4D1A009A4
 for <ltp@lists.linux.it>; Wed,  8 Oct 2025 12:40:56 +0200 (CEST)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b4539dddd99so1124058366b.1
 for <ltp@lists.linux.it>; Wed, 08 Oct 2025 03:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1759920055; x=1760524855; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MIc+MUq1c+gloqSXZzVewWZHYNnJOzsGhhKkYsehPLU=;
 b=VYl/7knDe1AYyxgz7DoIgIKH9HpxbabeUGZBosBXetUtt+RkJmBGE54bGI0kadYByZ
 B3LSewYeosymC0auh5Rqu8kMpQIxtuntlYHNQn53+Wnu8M7oy2aOGOS+f/wxOLjX7bR2
 c6KNH3V6JPSPPgynmkzdt76U4Q397qsiOfizbgbCst3EsNmWOTGX6a19ccxviEQGUuDX
 khfVgCfsUx1Qbz5JM1w+LaKx8MpMaTnqxi1xabrweXLnh+711ZX2NbwG873cIip/+lnJ
 cpi6De0DINx3jsTRc5bQHIc8wPT3PXWGHYB9LGR+MmcuFPU3OQH2VONEw8hnpZY8QJsO
 ggFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759920055; x=1760524855;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MIc+MUq1c+gloqSXZzVewWZHYNnJOzsGhhKkYsehPLU=;
 b=E4y/4ypdLyVeaWAo09R/SX8LHP0nStvtB8nwCIPBE3Vkfwq4QUc6xam/yHF13oNGj9
 7aC07wX32jVAIgcgRRu2+5cBpNpa1qa2WWAi5cBteOuaM/Ll/z99CiSf4twDUpRbo2Qd
 lB50dVh1WQAKSCGXIN8w0pJK9WYAAJf0kqWBUuNjl9+0vhs08BuH6vVy0ktDRXMK1wEN
 Tt3+wppAUB33nXk7fbVu5FfzUPgNgejv6KWRDYw8w5qsACf09cqDNW6aFLns1RPeGDXY
 eVR/yth4848loJxmILEoQqjB0PCtfKVM6ZmxDiVpNKvr0O8OzRMo0E68cvkdLTxaH/g5
 fSuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRt234HgQFaoWuTieojPyUiNMt6L1z0BS687jLlX4SbJO+7H/TYdZO9McB9BkcQTK6+0k=@lists.linux.it
X-Gm-Message-State: AOJu0YwHkFQatEa5A3csAq3dFLr0G7KpPM8kxPFdGGBDab0KrJ2rRObu
 +O/wRsnurbCKB7aqqPWXJ3DjvUuaSnBpGaw8QArgTVfg0Fir1jOfpbZYEWN5qkBcQHU=
X-Gm-Gg: ASbGncu1gEO7xhkFw+pLUsvDb7o/Pp8FNzzG/B8Paxx3T0bFogN/0HO83sZ8WmKYJPV
 1ggFqmDuEilYPdCgiNb2UaFWTLgDyHY8dJrqqLP3uROkW7k4ZSMQEZ53C35XolK8Le/h+Nmf+i9
 ySHxSBrLqNuLhsTJcVWrXThJPLZV6JBOkSNVYutltLv2fpXTa/U4HiKX4pL0yfVopFM0pGQXTHJ
 BZ4A46iY/wRFxwN6UQdsjooE666VNq62XuXcd785X+qDoRUFH454cRKNo7+jfZO1r8eyZZcd/EL
 /JZ6ZpgQOFfpX2R6TLZbMLugY/2pOKgdRN1AvRTrkShTJcFwSLbZFj76q+Kr6rtqOVbCWOv6LGW
 TrutFW6Q6j0HhyR8dz8sMlicBT5jfVhwmvNIatak9Q0uDw38ZubC3IPLwrfo3CpDoAkFp0Vs+i1
 jJvCGvCAFd4o4PpzFiPY8B1WEhgLJ2s080Ohihj2KQ
X-Google-Smtp-Source: AGHT+IHMphxDjStzDEOgW+2Xfe/g4MRWqf3nZzi1jOLSUsvVw8h6vWYbyJCbtkRXOcKXAwZw/lqO1w==
X-Received: by 2002:a17:907:3daa:b0:b46:31be:e8f0 with SMTP id
 a640c23a62f3a-b50a9c5b3c8mr357276466b.3.1759920055315; 
 Wed, 08 Oct 2025 03:40:55 -0700 (PDT)
Received: from localhost
 (p200300ef2f176d00961bd2614569b9c8.dip0.t-ipconnect.de.
 [2003:ef:2f17:6d00:961b:d261:4569:b9c8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b48652a9ff0sm1624676966b.5.2025.10.08.03.40.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Oct 2025 03:40:54 -0700 (PDT)
Mime-Version: 1.0
Date: Wed, 08 Oct 2025 12:40:54 +0200
Message-Id: <DDCVLBLAGO0H.3TXR2BW8Z5D5N@suse.com>
To: "Cyril Hrubis" <chrubis@suse.cz>, "Andrea Cervesato"
 <andrea.cervesato@suse.com>
X-Mailer: aerc 0.21.0
References: <20251007-xattrat-v2-0-bf458fa66358@suse.com>
 <20251007-xattrat-v2-3-bf458fa66358@suse.com> <aOUHqfyqp8IVne7S@yuki.lan>
 <DDC49J0CRCSN.3K67TAS5U4VES@suse.com> <aOUlNrZj7O0yFDBP@yuki.lan>
In-Reply-To: <aOUlNrZj7O0yFDBP@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 03/10] setxattr01: add setxattrat variant
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On Tue Oct 7, 2025 at 4:35 PM CEST, Cyril Hrubis wrote:
> Hi!
>> > Can we please, in a subsequent patch, convert this part to our standard
>> > approach where we check for the availability in the test setup and
>> > expect the syscalls to be present if kernel is new enough?
>> 
>> What do you think it's the best way? Some of these tests have multiple
>> syscalls related to *xattrat and in this test in particular we are
>> testing 2 syscalls.
>
> The same what we do for the rest of the syscalls, introduce a
> setxattrat_supported() helper into a shared header that would call
> tst_brk(TCONF, "") if kernel is older than the version the syscall was
> added to and we got ENOSYS.
>
> We actually have to handle a few cases here:
>
> For setxattrat:
>   - ENOSYS -> kernel too old
>   - EOPNOTSUPP -> filesystem does not support extended attributes
>                   (e.g. vfat)
>
> And as for filesystem support, it looks like TMPFS has
> CONFIG_TMPFS_XATTR option so it could be enabled or disabled, however
> they should be supported for native Linux filesystems such as ext, btrfs
> or xfs.
>
> And we have to handle EOPNOTSUPP for setxattr() as well, so the test
> setup would look like:
>
> 	if (tst_variant)
> 		setxattrat_supported();
> 	else
> 		setxattr_supported();

The problem I have with this approach is that the whole kernel
implementation of setxattr() is based on setxattrat() and this test is
just moving through the same code. I would like to give a bare minimum
attention. At the same time, we need to test a syscall by calling it
with the right data, on files, that is something we are already doing
during the test. For instance, we don't have a "foo" run and we are just
going around setup() which is really slow only for filesystems testing.
In general, letting the syscall to fail inside test won't get much time.

>
> At the moment the ENOSYS branch would be covered by the fallback
> function since it calls tst_syscall() but once the function gets added
> to libc the check would no longer happen, so we need to eventually
> handle the ENOSYS in the foo_supported() function as well.
>
>> Maybe the best way would be to check for HAVE_FUNC_* declarations in
>> this case, but then fallback function would fail anyway.
>
> No this does not work, the only way how to find out if a syscall is
> supported is to call it and check the return value.




-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
