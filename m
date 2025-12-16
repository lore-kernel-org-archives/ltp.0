Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD51D5E144
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 12:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765887262; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=dOtVfUYimmhn9dlGlH9QJVCkpWT0hANmn36e5atQ1IY=;
 b=Uhg1cCjomEX4cekS6F2zaEqlEyOW6Y/LmbBcF3Q0zmkyTE8UcfENjyPiNJDuuL7/txeXq
 sbm6ek1xMIpZ9AV9Oei9GmtDJeYOsCm1tiSexsaY1Z1BTY90vcC4GWER4pxVYqL3lecAoa0
 xdcJZpJjzIWvugd0AeM8L1RcCEaitdM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC1013D0360
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 13:14:22 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED5B13D0343
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 13:13:58 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 423571400991
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 13:13:57 +0100 (CET)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-640aa1445c3so7581476a12.1
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 04:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1765887237; x=1766492037; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UDYBhjXDs3h+Qm2BhIVMY4RsvN2JCQHSYjQKCErIvoM=;
 b=KpH88BDWMPGs9SKKYp1fV71NHr54lJvtU3Bq7DPX+hZGP+VcT37x7dpI+yFDL/K+IB
 MWyL4WGr7i+4DWWKo7+/CHNDdPSyvULiwQrMF/w+wnSM1OzTWelfAq/z4IxcV8yKIqgn
 OYllmOSuMbeL1gGobHobr/WgNkc3WDKMm+l9u/0WIvVZB0KPRyChiAUPcB4fJN7v2lXA
 d8evJEa/LOvzp00gE2sMxQ4kMDceq/Twv58JG4W1SXSU5G0Y/RqIeLE4flA5qIrowdpC
 1mde9dG9Ixx0ChkfXuR8uIhvrZsqksDjh8pUSw5gT2bTIOan2vrT+o/ZbguHl6DKOkWm
 Qdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765887237; x=1766492037;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UDYBhjXDs3h+Qm2BhIVMY4RsvN2JCQHSYjQKCErIvoM=;
 b=uZzFlWhk5a+nS8lwr53/ni5GEV3D4QvhwUrstONdD8Xp094XYT0wfuoujAFZEhYS3u
 tpuFyuO67l3hzgVDHqqKb1RWgceesR3kNHmCpTWXPclyeEdYzajk7k7V9XfLi2UWrNsh
 +4gVEC3YgVsIeqYxDEfGdZ1ghtYeCrqRa971oX87I6zvS/zdYZRUtmEdtJyb7OIi2OUn
 hAf0HhogpgcF9SNjOXUKqQzw2awHyJHWQu3HKysgY77JSX0zfMqDGURpwGq4VBNCrB+W
 9o3Tndb9grHtHgP0i+iYBE3b+laZPQGrxF9kB7BF8UGPf9Uc0ZemIJnhg678XIe03IwX
 mpBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5PSaflN5XunpUpyUpB1pjBMH3NHOdt+xyTYxB9zMFoBL2RacBeC3WGqCTIYQUz84liT8=@lists.linux.it
X-Gm-Message-State: AOJu0YxIS2hCI9PF4FTnLgAKS4rHGKsPezp9KdUz8HmN6zVdpQmkFTmh
 dJtfM7PeF8D7WZwUFoUEXTC84w5TIYfSZJSfrbf4cScQNNR8zcFcoMmns3aZrAGcZIw=
X-Gm-Gg: AY/fxX4E/9jZtaJDdCBbUvFVO0BVRssYP9Osk0SlB3ohRky7WoG6FiDCQWU5hInCDvC
 1mNHOgNH4VRENanN+3vL4Ew/Jh0J/8ATdE3/dPgc2Ge2AoaAH99Q35WaQLERHVLcYUc6dBygpih
 2NlL6ZuLbg8uIT5dQ8V1GDZaqsKgUCFXgMaIrQrNOENlfvMLCNUTSjw7baA79shx40Suw7dnBy5
 PQIaUHHD9/WwUy6kxD/UkDlb5RzUbToZx8NrvZigGv+WkvQPBo56rT3v7fi08REBc8tzw6ksGFO
 d9DYboILnFneMkBvOqlioXik3XPdH6EqpGHsPaQwCQtZ5gMAtS9ly97edwMqfjJHMqofRCkZdiT
 C8o7owpvk3xvxtDgwai4f1gwrhlgxNCGxiS1I6bI2v4YNWmzN0s3BR5I6OOpojYPuZSLbErjp7z
 6f1teljiiYizM/Zr0JlzE=
X-Google-Smtp-Source: AGHT+IHv8lhvY8P+9BDBO1oInM0/ObCqgBbZ+1hT9WLNUWU9VVwtLNGGg1RFSRUhpu84UuLZ+007Lg==
X-Received: by 2002:a05:6402:13ce:b0:649:9254:67ae with SMTP id
 4fb4d7f45d1cf-6499b15f4b8mr14520284a12.2.1765887236573; 
 Tue, 16 Dec 2025 04:13:56 -0800 (PST)
Received: from localhost ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-649820516e9sm15723386a12.10.2025.12.16.04.13.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Dec 2025 04:13:56 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 16 Dec 2025 13:13:55 +0100
Message-Id: <DEZMS4NATYN0.1UPLQVTAALHVA@suse.com>
To: "Martin Doucha" <mdoucha@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20251212104025.15924-1-mdoucha@suse.cz>
In-Reply-To: <20251212104025.15924-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_detach_device: Clear leftover partitions
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On Fri Dec 12, 2025 at 11:40 AM CET, Martin Doucha wrote:
> Some kernels have a race condition during loop device release
> which results in partitions being left over on unattached device.
> The partitions then cause mkfs.vfat failures in later tests.
>
> Check for loop device partitions after detaching it and clear them
> if necessary.

In general the code looks good, but the sentence "Some kernels have a
race condition during loop device release" sounds like a kernel bug
that we are working around with this feature. I know probably this
is not the case, but if I read the sentence this is what I guess.


-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
