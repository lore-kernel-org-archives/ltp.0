Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E003C5DF82
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 06:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787205857; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=uD0bPJNZSk98uiEyQBPMZijzXu8xtX2JqWrwo1tkNWE=;
 b=Wa3QhEcomVpegfqrRhQFkBihX2qOvt76Vt8gB/hWYzaZWukbrrMk6cr8pN1VhqGvxU1yU
 ctqmmwmMnkhB8pN1H+b7YyxDJtf76ratFVIOyPNmu7GJ2KFT0Y3fjsd6ALTTnJkV0nX3eVZ
 by624B4DN1tSX1M9LtZ1olHDRoaubrk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 31F2E3CDFF9
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 08:04:17 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 04DDA3C6EDD
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 08:03:55 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5EA621A00619
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 08:03:54 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4799b3f7c83so1231889f8f.2
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 23:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787205834; x=1787810634; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PJFvSQKD7iq8SlqEjbnLiXiZV6Gotu7ryE28krD6zN8=;
 b=c5TmSlm141NaJB0af53jReUmmen8AgLj1/Mey6i1za1m7eS5C0qA1ZtZfmcxVn3qjc
 79Y7KohJbILNP/4+mQrqI0X5GTktJZvHB45baNpwv2MvUGM90z4GMmTH3yMmFwYO6YLm
 cJWMY39qPaURtUMAj40DAvA4+oZq0Z7jXWfsaVsQkjdXKeytmmuPQZu6gEFRHbX4pL5T
 psZ08QJiHqav6EgKJg+ALPI0Zyw+7vGzN6OpDsG7dvO/9VGTZgjMIq/k2Oz31O06rfzD
 FpaNHuj76WaLbdvZVt54cYBFKYAMIQzSgyXuhd/chP2wxGfdAhyafPcJWt1PW3VpoG7P
 JsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787205834; x=1787810634;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PJFvSQKD7iq8SlqEjbnLiXiZV6Gotu7ryE28krD6zN8=;
 b=MwVzJ/rLBNtAY6Svp9d1fhlTNxrCFRY6vqRbGgG9kBm87TixOTJRaxJhsbQO+FwbLo
 YPsXWt13mYjTtaEpTWnnWLJnw6O/mUl/jbc2zPvXqM+TSG0V5wuwbuwbKWBlSouuXk+f
 t1kGqAFuYu/iFiTApxjktB/tHFNdqSDbt0OYOjs/weonxnEp8DCLB+eaKb3qTR2blbMX
 KDcyAqi02uvOFvvkRWOJNzamU9T0cQFof44AYtA+fE79hWPUIMeMr1zD7O7nTgFfLHVV
 atKb5kNT2CF+MD/TuR3cx4Pqq9K2lRgrzQahvyZJyiVcA22g+Cbg08sav+aBbep5g1si
 /VIA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpel0jQCeA51cwLuSw3GAnqCk/PJW1D/Zu+hR7Qhdp6NnIeMWcSi+RyTSaFB+pqhyAYAeY=@lists.linux.it
X-Gm-Message-State: AFuF++mIO8AUMrHydcpBkKyCzeqlgp9apSSpNTUr9145iXLXKQoba8NC
 Shfh2u1/w5+5X5fiDMBfHvIVxi0bC352CbT2I3obSBfcarvvr5bLleXwhNuWvpCM7XU=
X-Gm-Gg: AR+sD11lHkWhWDgv4pC80n/H96+cfn1cu5XSvljqVDX1Nm2LdCeDrSulRPNByn1Iwl8
 CgJICLq/fxGNmUStJAlzjpcenxE5dmjrZooymAoSAMQ578gM5LSs88QhaTk7rl4uzyPbmhaHTei
 AyRbWgZbQ1ObkmXyQyXRt2npNoKtsjW1x+2lgD8Lt0aO+X/fECY1BghYv9DdOXs1X72L5Ot+Fdy
 pl0Z0UtL6/XInVW7Pwk9aG+qhu5p1hbvR0UC2icuwr9VTcET/qPktFv7qWzX33ZPlTSA7pESDS4
 HUG4r988p4i46UO+Onwydi2gkz6eqTbg7pvUTV1KcyQQoMKMxSWh7ZQyyiaBwSU0CQKJS7pMzeB
 1zYyxGDd9lMykTm2MMfLWlEYzNXzemVJgC0a8nWUKu/RI08vIy4XJ3w/RXqESA8DjJ7ZHTiw+Up
 oSwtJB92x0zQdRw9dN4BAIoYPgpCOgGuz1p6aTZkA3VDxEBVVqWJPG09Q2YdKgmp6I+iChk7E=
X-Received: by 2002:a05:6000:25f3:b0:47f:9283:1fb3 with SMTP id
 ffacd0b85a97d-482b1e1c22emr19743985f8f.0.1787205833502; 
 Wed, 19 Aug 2026 23:03:53 -0700 (PDT)
Received: from 192.168.1.121 ([176.206.179.213])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441c85sm12050220f8f.1.2026.08.19.23.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 23:03:53 -0700 (PDT)
Message-ID: <6a8698c9.b2781ae3.314387.b64e@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260819222746.4120-1-linuxtestproject.agent@gmail.com>
Date: Thu, 20 Aug 2026 06:03:52 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls: add v7.3 syscall numbers
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > /* Roots of kernel internal pseudo filesystems, usable as fd sentinels */
> > #ifndef FD_PIDFS_ROOT
> > # define FD_PIDFS_ROOT		-10002
> 
> Could these new public macros use kernel-doc comments? Public macros added
> under include/lapi must be documented in syntax recognized by linuxdoc.

Not needed.

> 
> --- [PATCH 4/16] ---
> 
> > fchroot01: test fchroot() with a directory fd
> 
> Could the subject carry the "[STAGING]" prefix? Linux 7.2 is the latest
> stable release, while this test targets fchroot() from the 7.3 development
> cycle and is placed in runtest/staging.

This is correct for all the patches.

> > #define UPWARDS "../../../../../../../../../.."
> 
> Could this walk continue until the inode stops changing instead? LTP accepts
> any absolute TMPDIR, so a path more than ten components deep leaves this
> lookup at an intermediate directory and fails the root inode comparison on a
> correct kernel.

Hard to happen but correct.

> > 		SAFE_STAT(".", &st);
> > 		TST_EXP_EXPR(st.st_dev == realcwd.st_dev &&
> > 			st.st_ino == realcwd.st_ino,
> 
> Should this compare "." with realroot instead? mntns_install() resolves the
> target namespace's "/" and assigns it to both fs->root and fs->pwd; it does
> not restore the previous working directory. Unless the test starts in "/",
> this comparison fails on a correct kernel.

I need to verify.

> > static void setup(void)
> > {
> > 	ltpuser = SAFE_GETPWNAM("nobody");
> > }
> 
> Could setup query PR_GET_NO_NEW_PRIVS and return TCONF when it is already
> set? The bit is inherited and cannot be cleared, so such a launcher makes
> this test exercise the allowed-entry path and report a kernel failure.

Need to verify.

> 
> --- [PATCH 14/16] ---
> 
> > fchroot11: test failfs entry with no_new_privs
> 
> Could the subject carry the "[STAGING]" prefix? Linux 7.2 is the latest
> stable release, while this test targets fchroot() and failfs from the 7.3
> development cycle and is placed in runtest/staging.
> 
> > 	TST_EXP_FAIL(unshare(CLONE_NEWUSER), EPERM,
> > 		"user namespace creation blocked by the failfs root");
> 
> Could a separate unprivileged child first prove that user-namespace creation
> works, with TCONF when the environment blocks it? Runtime policy, seccomp, or
> an LSM can return EPERM even with CONFIG_USER_NS=y, making this assertion pass
> without testing the failfs restriction.

Will try.

Will send a v2.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
