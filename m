Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B961ACCA476
	for <ltp@archiver.kernel.org>; Mon, 13 Oct 2025 07:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1760342100; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=LQbaE+KGo7SEy+ctmDRHPHSiqaHBPj1qIdEvLjtFi0I=;
 b=ZZ6zE+4BB+f88NXze7Lc9g1QRxEIfhKHKeQHfHrNwumlD4cx7DqZ3wn/4YXQk9cDxSfGn
 GZAknTOQpQ04YOI+TQTVkVTe0GlPe3eY1NTVeS3GMEBLRpAnN6CzenNuVk3IMk8qm1yQbt+
 uABySEmocOFP/eJ7tum3XiWgNJ70zg0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6C593CEB73
	for <ltp@archiver.kernel.org>; Mon, 13 Oct 2025 09:55:00 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B3313C9AAD
 for <ltp@lists.linux.it>; Mon, 13 Oct 2025 09:54:40 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 28ACA140026C
 for <ltp@lists.linux.it>; Mon, 13 Oct 2025 09:54:39 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e29d65728so22520665e9.3
 for <ltp@lists.linux.it>; Mon, 13 Oct 2025 00:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1760342078; x=1760946878; darn=lists.linux.it;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mY4BsnNG35ODayRgNje9e7KLcIFrKvNruzpAJKh4+Kk=;
 b=K+iqpjPfJURoKrzkZo/KRYHoODQ9ErZfUauhA2aaV4TAHFn2juD/ZoC3pgrNVGxyS8
 /bp9Hf8y7PaQFT2Iz8hbUkz9moLAdKpMB8t46spLwqOx4ZOdUZf5lrXAC9H0OYdkg+AU
 MPSk4zXsbaV9nXY49x+448RNbfYlnXedw86M1uACqKqc7XT2+dwPpf4eYmw6dYjoKPbc
 YpQKGMP6AMbUo+NKVPYQux7nyvHhHfQxeGBVJOzV3vxqTR06X8fQW4cvtw9J/uQ7d2CN
 UheHWijonN/p0IdAUrzUOvJgfnCaJ6SYJVzO/wKC9NcJ7Vj3k0W0ZBo35y5pMCcGuUN7
 kK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760342078; x=1760946878;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mY4BsnNG35ODayRgNje9e7KLcIFrKvNruzpAJKh4+Kk=;
 b=aIhBexyS5LiB2zY88sNkifSUf4BpuvMFT0V+k9xQIOq15PxsPRuaVAJnFJpfk7Vubh
 dsleonNTUOfDbZtN08EmzC941b6iIdOIQY68Kb43fnKi1Cfvyh2U5eDEOAHWE/bIkR73
 vWzcs/omhh/pLLNk+p1fd3yqVGsm8ZjiTAvYtfOb8KgQbuopZwhZeB0cF3w1E5yu237F
 qdynYHbt+Q0RYwmJPmleylKcoxO8wpIJ8PRRy742gj0mh93/Yjj1JBp/l3BNIjuWT9kd
 MlPn9JaKujJ0Jb5KQt5gl384rkk46ilJH8Jpdv5hiXJ2c7XTcZP6GCqLpfsNTB95L6JJ
 mc1w==
X-Gm-Message-State: AOJu0YxNctlzKOPy/OVn7A6MYk5uE1CQz52nBEj1PX79tBKFxNFsu9Xg
 loG0F4IZnXGpbiLawiExdiMBSiAv9Gfaep+wQ8aHoOVVgOfpwOcpmHd0teibGUdQ8b0d2r+OE6X
 0dJxs1jw=
X-Gm-Gg: ASbGncsDyxPUMgwtNriHSwNwWRhEufRlULJlJSf6Tjosd8GT9qD+DU27J2YP3m90SLx
 9DvH3k3bRGJRvIPa281wHgTjPXjPVfRnFS6ODg3+zJPBxJQcNGtqpS+G4My5R5+QjQVgongLEX8
 V0L0Kt/PGyAF/I2lxP/pJD9YWBOUs2wvN4aKESscSive8lV2jDCq5RggIBbotCUSvrRWcsiDcdr
 5z6r79SrQPNOozoKEH8b5IbH+B4bEZCIcBln6ddYqSDHbzNqEKLKIwdjTLFvTtxiINcKjoPyq7E
 6cc188MOVAsZZ133w+RkFpMdbHyRorvYpExjdrbtFRC5j8oWtzTApzD5k1IzQbZ91FKuANK3GTY
 k0cUie7v/+Gn8VUHD167pSFnXiMnEuYi1KppCT2WnLyPh98T2gYVDFYGghPrdei1CxSgdmznj1G
 kgh4SsoDSFzw2/AOerlqZLi7MoqxRUrF2U9tt0KbBU/bRL4A==
X-Google-Smtp-Source: AGHT+IGc4vkLl7s5GgqUtNJKrQ5cWqfA6Nc9pKIx4ePy31pz9qduzio2UCnPR/+dZ7Lx64Ji+eDiWg==
X-Received: by 2002:a05:600c:1f84:b0:46e:4cd3:7d54 with SMTP id
 5b1f17b1804b1-46fa9aef45fmr137835865e9.18.1760342078378; 
 Mon, 13 Oct 2025 00:54:38 -0700 (PDT)
Received: from localhost
 (p200300ef2f176d00961bd2614569b9c8.dip0.t-ipconnect.de.
 [2003:ef:2f17:6d00:961b:d261:4569:b9c8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb49d03e2sm173442275e9.19.2025.10.13.00.54.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Oct 2025 00:54:37 -0700 (PDT)
Mime-Version: 1.0
Date: Mon, 13 Oct 2025 09:54:37 +0200
Message-Id: <DDH16Q9O1G6H.1CMGKFGB1XI4M@suse.com>
To: "Cyril Hrubis" <chrubis@suse.cz>, "Andrea Cervesato"
 <andrea.cervesato@suse.de>
X-Mailer: aerc 0.21.0
References: <20251007-xattrat-v2-0-bf458fa66358@suse.com>
 <20251007-xattrat-v2-9-bf458fa66358@suse.com> <aOYymT7OSXseISoS@yuki.lan>
In-Reply-To: <aOYymT7OSXseISoS@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 09/10] Add setxattrat01 test
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

Hi!

On Wed Oct 8, 2025 at 11:44 AM CEST, Cyril Hrubis wrote:
> Hi!
>> +/*\
>> + * [Description]
>> + *
>> + * Test if setxattrat() syscall is correctly following symlink, setting a
>> + * xattr on a file.
>> + *
>> + * [Algorithm]
>> + *
>> + * - create a file and the symlink pointing to it
>> + * - run setxattrat() on the symlink following the pointing file
>> + * - verify that file xattr has been set
>> + * - verify that symlink xattr has not been set
>
> Shouldn't this be a variant of a setxattr() test?
>
>> + * - run setxattrat() on the symlink with AT_SYMLINK_NOFOLLOW
>> + * - verify that file xattr has not been set
>> + * - verify that symlink xattr has been set
>> + */
>
> And this a variant of lsetxattr() test?

This is the exact reason why I'm not yet 100% sure about coverage for
setxattrat, since most of the tests can be just variants of other
existing tests and most of the time we have code duplication.

After thinking carefully about this patch-set, I'm not sure to proceed
anymore, since the kernel itself is using setxattrat() to implement
setxattr() and lsetxattr().

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
