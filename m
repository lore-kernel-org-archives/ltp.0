Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9572ED68BE8
	for <ltp@archiver.kernel.org>; Thu, 18 Dec 2025 08:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1766045952; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=mPxMzDPA8lTDloATHLFdPO3HbrIMna4cROh6jhuvJVQ=;
 b=gCnLYdGhNdDxHAByV7qyR5k5fNclvqsyqmdINWDHiM0cnxeB/3rZOfJGKzhti4ir381+c
 qgRJJcq45grMH92Fjc/I2WuyJys0nd7NC6wRfwl9eeCv4Erpsvxy7XrZH2L4WGoRPDCjpSX
 0d/MyZ+Tm5pZTXQgpdTZ50FMyIZ+Vow=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B7023D0489
	for <ltp@archiver.kernel.org>; Thu, 18 Dec 2025 09:19:12 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6497F3CECF2
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 09:18:47 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9CE4E1A0064C
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 09:18:45 +0100 (CET)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-640ca678745so564060a12.2
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 00:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1766045925; x=1766650725; darn=lists.linux.it;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xxNxObTUrGKK1q5CCvfnjU46ODV4Jzm/14dXJ5ktYko=;
 b=JDm/ol7g18dA90n5R1i0tjjLCfOUgoT89IqooNs4K67WuQe5HSYNEePd+jrUEgvZTJ
 TfB5LPh/OO2zQleixSGErmM7lkGI+mKboI5LYI2yzOshtdzWqDn5aYLGVSTtdYgynKM2
 +B5EtQ4vBh8MuieI2dCpIk7ebgvqrJTCYm7+V4Mk6ddfvbtNTY9bTcqRKegR3t9v7rLr
 jvRHsE4Wggkfxjtmf5TdCvfGPyKburlMOEhjNdySX8sitA1XFN9cVFsJwCrSh+w93RSi
 nnCfluZYyNH5jvx3raCUUDHosxZIsbeIoZo+bGe/55biMJEVd35OO18TIU+KvwmJRdni
 FUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766045925; x=1766650725;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xxNxObTUrGKK1q5CCvfnjU46ODV4Jzm/14dXJ5ktYko=;
 b=Han7EdChtr5ie8Rq/zdBPanCUonUZ6OYGADBZPyh7JzsTrqreCo643LPDkrDRLNJqz
 L+2nMtq1UDa+6KGXBzVLzUldoYtSdt7OIlP/XjXmwc7nI5CCoeotLrlsaJSRssGBIFru
 Zp29XffF5JS3GXxAjS5aPAS5wfh7wbgFTw17UBT3ArXsuUbq9goapmzKFETTFvmL9KvR
 CBdH01gkCW6lvyTtEdCp4vRWYDVYuTNCxZEit2p+fOHA0LEPZv2AgXUgUfY5N9aC2Y1y
 f8UnVZR5UTkjy4UZ5td2OcWTACK0RbxgZ7B8Wwx/oKsS6wVKqiX5+VbY7XyVc3ZU7RAc
 u9aA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjLHba6P59XthX8WIBYmH7gkhGZmMiT3TzcUcic72Wxit4f+Fgp9ppbKgL7Qiu73Zw3Js=@lists.linux.it
X-Gm-Message-State: AOJu0Yxy+bAVLb4wwLEbWF4EiGRupQj2TxBQY/j+y1pAbwbQ5R5eepfX
 AftKxpoY/wIEMiYTRVaBSb9S2R9wCyq9fopFR3MN4LCj1GH4rZWV4ZCxLaIUbze5vQQ=
X-Gm-Gg: AY/fxX5IaI6TKerMU0BuukxkGvDKqgXqsmd9Alt9A8SZLmRjjwrgBOX81afyILenchL
 Yhbacx4dEmUroT4C2DQLRNr+sihDZ3jV8rBr/16Ies0L7WD6G8lH1Af443W2DqFTRi1ssukytu8
 qpKEyeEjv5le2mEet67HqzwyCo6D541SaiNUN+W/9f4914IKHEt5UsCT+gPcPVgYA+9V9Jo7TyM
 5PZfjrf6eJdWJmW4c1Aw5UX8OlcnEg//PI+lMu3M58dD4I/pasjT0iUPcBg3TNwttq7d1TJZQj8
 lWPdquQSsZVYunQBHq3wQ4fePs6LWgt24TeEt28bYzb5zaBBz1/YQN2SGKXJOET0bwF8BXNTxiN
 TQ6Cbp9HCxppr7bjA5+9qfz73YjiXpqpPTvKOIZwdN6jAlQ4ZY6WdHIOxzY1Fmp4z09GdDHu6cf
 KLaaxnCS1XQrgH5KJbXtmnWF+q0rlicQ==
X-Google-Smtp-Source: AGHT+IESJn8OlnKryU+P4r6NXmPZsqzFNd8UwKAntjX1Hpa35C1IILRcPWQQtPmHh9gaHJZOf2Dxng==
X-Received: by 2002:a05:6402:510e:b0:64b:345f:13a3 with SMTP id
 4fb4d7f45d1cf-64b345f14bdmr6857897a12.26.1766045924976; 
 Thu, 18 Dec 2025 00:18:44 -0800 (PST)
Received: from localhost ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64b585d4a85sm1764500a12.12.2025.12.18.00.18.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 00:18:44 -0800 (PST)
Mime-Version: 1.0
Date: Thu, 18 Dec 2025 09:18:43 +0100
Message-Id: <DF171554SNRA.2CKR0Q3FLG2TU@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>
X-Mailer: aerc 0.18.2
References: <20251209211629.95436-1-terry.tritton@linaro.org>
 <20251215155330.GC272695@pevik> <DEYWYH3VLMDA.R2SSTA8T80LU@suse.com>
 <20251215161353.GA282302@pevik> <DEYXGZU8IXPQ.2N0IS65HUZ0LI@suse.com>
 <20251215165247.GC282302@pevik>
In-Reply-To: <20251215165247.GC282302@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ioctl_pidfd02-06: Add CONFIG_USER_NS and
 CONFIG_PID_NS to needs_kconfigs
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
Cc: ltp@lists.linux.it, Terry Tritton <terry.tritton@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On Mon Dec 15, 2025 at 5:52 PM CET, Petr Vorel wrote:
> > > And https://www.man7.org/linux/man-pages/man7/user_namespaces.7.html.
>
> > > Yeah, I understand that. The dependency of CLONE_NEWUSER/CLONE_NEWPID is also
> > > visible in kernel sources (e.g. fs/nsfs.c). But my question was different:
> > > Do we now prefer everything kind of document with .needs_kconfigs, even it's
> > > possible to detect it otherwise? (speed of parsing kconfig, kind of hard request
> > > for kconfig being available even we can figure the support otherwise).
>
> > I believe we shouldn't see this as black/white but use this feature when
> > it's really needed. This is the case.
>
> Sure, .needs_kconfigs is used when test request some functionality based on
> kconfig.  But many tests use /proc or /sys based detection (e.g. ioctl_ns06.c)
> or based on certain errno, see include/lapi/syscalls.h or
> testcases/kernel/syscalls/fanotify/fanotify.h) because these were
> added before LTP supported kconfig. Later, when kconfig was added it was
> considering as a last resort (when there was no way to detect dependency
> otherwise).
>
> Have we decide to move everything into kconfig?
>
> I'm not sure myself.  needs_kconfigs is simpler and obvious, but it requires
> kernel config.  I suppose the speed of parsing config is not an issue.
>
> It'd be nice to mention the resolution (preferred vs. only if no other way to
> detect the support) into
> https://linux-test-project.readthedocs.io/en/latest/developers/writing_tests.html

Feel free to add this comment, but for me it's obvious that if a
feature can't be present in the kernel due to kconfigs we should check
kconfig :-)

>
> or into upcommig doc/developers/ground_rules.rst
> https://patchwork.ozlabs.org/project/ltp/patch/20251215124404.16395-2-chrubis@suse.cz/
>
> Kind regards,
> Petr
>
> > > And if we decide for forcing kconfig, we should update ioctl_ns06.c, which does
> > > /proc based detection (i.e. to use the same approach).
>
> > I didn't check this, but I'm pretty sure we should go all around and
> > verify many other tests with the same issue. We should do it in this
> > patch-set or on a searate one.
>
>
> > > Kind regards,
> > > Petr

So what we do with the patch? Should we merge it?

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
