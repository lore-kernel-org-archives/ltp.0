Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE8AD5E146
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 12:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765887609; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=qNBKiTwqGCkClnkWwdVL0joYdErR/wuZDLomT2Odd1I=;
 b=OZpHrTDGT5535x1vlMguiXkzUB6+YQjhMt2Rye5QO7IAVEEgzFwQxKsRmPYNMTZ3Dv5Uy
 efxkQJpyohEBiAIunF8IPJNSQZC5VMcxDLqmJJR+s1WzcnGHPm8jH9ntpa6KlQP9mjPeppT
 frkawA0MT+SCI+iHIoptwQv1abPQPQI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 51E823D035C
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 13:20:09 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D33E3D0322
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 13:19:44 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0102B1400B78
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 13:19:42 +0100 (CET)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47775fb6c56so35958685e9.1
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 04:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1765887582; x=1766492382; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RU2VoeXt8wps9aPbXsLROwr6XVmY8ATO69nQO41we3g=;
 b=TQAqvKoyJUeb666g5q8N+Qcq/scMfTebPAPiszIgBrnjWl/71DA/Cy4SQLfD/H4OYZ
 f14qUCWp4NmGrhq7sREoLvOIe86I3w8Z3E/aMOFTfgtz6750yxp6ficMuZroJ7FUr5DA
 dhMyrzTv+d3//ERSY605AUf8+a2lRj7ikpuWDWWNI2OcdHK/oZn00WuQeujtu7gbEIOM
 y8kWGSNZRDAJ6C5yZyn35X+kpB2ntCX5hDpV/RMPrFiM7b5Z/ilRZM0h3lZXyGi2t+Iy
 IIzkn03ZMF3zXsF3NL0HipWHSYDqO9176kvjd8c0XP7upcBtBRQWDxiA1k/bb+eagFeX
 Ygrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765887582; x=1766492382;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RU2VoeXt8wps9aPbXsLROwr6XVmY8ATO69nQO41we3g=;
 b=LD/zyug26I4ellPWuj6GhjnOM/rbortkyfWfqObN/Kd6YQrIk/GP+v96OnZzbunafk
 fUurb5buRs9dPg1VHs1EEcqbKAml3JZdsaj3nyTnvzui0JFpLBJsnj0A0yifoWXMBEe7
 Ag50+q67esd8M0D8MpvWr2QZslDIvSwK3ib6VNt9dpgNgTtiwmTQdSOZpMKDrr9GPd4Z
 jfmIXTuWbscSvkFLKpt5N6RbbxB+YI2qFqg5UmEzBM7+TAln1gc8JJ3PaTlSSZ+pz/Lh
 Sp9AXEP7uaqYtZsfFl14kujeHXEb/P5XBOMiMsjVyiUHd47lYM7hvgHXnSnMZ9pcoIsh
 lidQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFROxROOgVlN2IUuIzWDvhix26DJUC3fQvyVYSd+WnN3ruUrpojIw35xbuxLrH1QIVdqk=@lists.linux.it
X-Gm-Message-State: AOJu0YxM2e+F4ZSafmRufxYfEQT2CTR44X/7PvpsNJKWg0YQy+yiXQ4R
 oBOmxE5A6+md6lMp52mCSRSbRYWCJvVWgJSaF5KRoCqzrXFhtGZJ/Vm9OwWhXWE1Wk22kxMNjI3
 3inLYjX8=
X-Gm-Gg: AY/fxX5LqfMGu5KyCbwbW7IU00/uWbkpl5wh1fwy3P9ECvlwbyvoan3yosoxvpvM//E
 6gSfcRbygs+s2yRyxeuvCuTxdQAnLtNOd2DFyZhmvErnCuei93/euhwUN2KS8v2aTBgno9BvFBT
 vDbPRj+xqLqF3+rxi3bTiTWF8qHx7G6ZjyFGfFHwfS2NxrgqBIUymFcFIV3lcVI/DnyC3mCP1qp
 DkfvTLRKPz/ysTB9CTSGItZLaE0dCT+3oaozCwMw9IHmEiikoWK0sz6IrJpWo8XefOcp+1JwzLl
 FCEDnG0xbCv+938HjdvO9BKbVFk2NiCVmKrJ2clKsjKe2zfTAi3wFk0KZ0VGDSNBra6OllfH4db
 NlhZe1iUQqikGLgOq/p2K5RnpC4pxI4uDVw5j8iDi69HfW/pjvWem9+2zlrX6/2UUd6DN0fdnZB
 k+Nn2emvoxvpcIGVNt/ag=
X-Google-Smtp-Source: AGHT+IFS8gnPxNhFc/e03lK8p7e6C+NzWHmHw/O/9W++tY43CmsAll/S2SlCxFYeaJJJ6vl5jR0CKA==
X-Received: by 2002:a05:600c:4751:b0:479:3a87:2090 with SMTP id
 5b1f17b1804b1-47a8f916cfbmr134575245e9.37.1765887582287; 
 Tue, 16 Dec 2025 04:19:42 -0800 (PST)
Received: from localhost ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f4f2e8esm241518975e9.9.2025.12.16.04.19.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Dec 2025 04:19:42 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 16 Dec 2025 13:19:41 +0100
Message-Id: <DEZMWJMK4KV0.47URP2UHSTZR@suse.com>
To: "Martin Doucha" <mdoucha@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20251212104025.15924-1-mdoucha@suse.cz>
 <DEZMS4NATYN0.1UPLQVTAALHVA@suse.com>
 <b4bb06e0-290e-45c0-8a82-194b91256b2b@suse.cz>
In-Reply-To: <b4bb06e0-290e-45c0-8a82-194b91256b2b@suse.cz>
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

On Tue Dec 16, 2025 at 1:16 PM CET, Martin Doucha wrote:
> On 12/16/25 13:13, Andrea Cervesato wrote:
> > In general the code looks good, but the sentence "Some kernels have a
> > race condition during loop device release" sounds like a kernel bug
> > that we are working around with this feature. I know probably this
> > is not the case, but if I read the sentence this is what I guess.
>
> Yes, this is a kernel bug and yes, we are working around it. But the 
> workaround is not there to hide it, it's there to flag the bug in the 
> appropriate test which triggered it and prevent other unrelated tests 
> from failing. Think of it as extra thorough post-test environment cleanup.

Ok thanks, now it's more clear. It would be nice to add this comment to
the commit message.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
