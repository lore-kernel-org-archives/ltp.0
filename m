Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F151E6748D
	for <ltp@archiver.kernel.org>; Mon, 22 Dec 2025 08:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1766393756; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=8GyzGz8tEq7lfmLlPKvN53TpdSKJdOOlZaM6zmqrR7s=;
 b=pzy+pFNqOet5A3dq3RcdoZfw6e0iJ1W/nTYLJZTihUYXg7im2fCfbMZkwh794qsrszhnX
 NpSwZ81roTXv0J3gcW08ogOJDrRdYpsu+vayahlqQmxKG6fZ89SCx/XAqyNKILZGAuXJ5IQ
 wOnepaHy0/ibMnk5Y4mTiO66qY5i19k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A28273D053A
	for <ltp@archiver.kernel.org>; Mon, 22 Dec 2025 09:55:56 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C4063D0390
 for <ltp@lists.linux.it>; Mon, 22 Dec 2025 09:55:31 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 253B31A00661
 for <ltp@lists.linux.it>; Mon, 22 Dec 2025 09:55:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766393727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tMbHTGZ8gYSXDibk4yaf+26HjJ2sCuCLh5Hua7WcmM0=;
 b=ZmpvUZ/FQ5Ol0e943AjAfD+v0/9gu4iD9lHDv2huQh760Z2vB2kKOLQumyKPwH4KfKDP9T
 CVAYGfUHeZK3/zqGL2oA7NEClElC7CCUsx6EHDPTlFSqM0HxkgEcp+UBSejc4amnw14ADY
 +zndZMcQgMZ7dcc34fKI1DvD/CU1KrA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-aza2VH6TOVeBG8ZUfNpI7A-1; Mon, 22 Dec 2025 03:55:25 -0500
X-MC-Unique: aza2VH6TOVeBG8ZUfNpI7A-1
X-Mimecast-MFC-AGG-ID: aza2VH6TOVeBG8ZUfNpI7A_1766393724
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-34c6e05af3bso8092213a91.3
 for <ltp@lists.linux.it>; Mon, 22 Dec 2025 00:55:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766393724; x=1766998524;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tMbHTGZ8gYSXDibk4yaf+26HjJ2sCuCLh5Hua7WcmM0=;
 b=sPi6426UdzBqHUblxMV3Vl/Y9cdQ8ndMMpFF0vifGMvd2Sr4syDtp35bjhwplsIqe9
 +u67f35dT8965rilwh6K1yivB3IohbnV6dQZYRG+WiaxIkCVkRVfyuUyt/PTQIDX2d1t
 9BO78HoUHqzH1ffYfH3JCT50Pt9PDgsE058cSGCfhg84+1i5dagxjn7RIxRIwp+t2zzF
 QRL/uzDPjhuzbB4ajP8MmxKETHKS0jF57H/4NX7qeVncx50sVqCx063Q7EzQFfvxgsWb
 FmHmK4xcLsNEGjtExRAFT2mH60GoVvoKB681R0W4Vj4ihdpwpNbNJpASYOTPb5ErC/BZ
 GgTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsULReMHgzvGHbpC8zU5kABdbc2mtD0kSwdpPhndYCdEylpoVTgtJ5fBxrprOo7hI+Llg=@lists.linux.it
X-Gm-Message-State: AOJu0YyFSQc5LY3x+JIJXqAfBDDuDL8Av+pZfbUp0pMrmMb1pagppavA
 cNW/gQgdqcRH1Jxr0aQBDonb4aY0fEmHwcGfYvWXc4B/m5z4gwsCCUe7+V1b1XO+IJVmQ8/j9xh
 wLL7waAKDn8EmVmuqV9+U4zrd8Tdqa+sH0zeGq9UToRBJ/63eTOWiEwutqqZtM51LosFXjigAIL
 CVbqax6ual+HWXjVxi8hXAwYx6YWU=
X-Gm-Gg: AY/fxX6MQbH6z26zEK6FL9wgBLtimf3LyqYE81LtXJjSCqQH53XOJ0D4zUD/m1Ak47C
 mRlMVWW8fj6WCA0pZUpmhXjXO4B8R9dDC5Vennp/xU/Hj7xasxQw+BBxt6DlVYSdtbNYULcQhVO
 fKgB04bWTqMqZ4CNtmtcK/AxzuVZjHmH9CMXeP07sUbbxIADJ8jIuyX6czyHczz5/xVrM=
X-Received: by 2002:a05:701b:2615:b0:11e:354:32cb with SMTP id
 a92af1059eb24-12172300658mr11612974c88.49.1766393724311; 
 Mon, 22 Dec 2025 00:55:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXM0e+vsEaIIsIjLYGd2jRbIBHp4TSst6V0dU7H1nZQSQvY8PHqIkecQ2PLYrid5M0e8dBKKjP9A0N2/oxlFo=
X-Received: by 2002:a05:701b:2615:b0:11e:354:32cb with SMTP id
 a92af1059eb24-12172300658mr11612950c88.49.1766393723795; Mon, 22 Dec 2025
 00:55:23 -0800 (PST)
MIME-Version: 1.0
References: <20251219094219.151887-1-pvorel@suse.cz>
 <aUUteQjVmMx1R_X9@yuki.lan>
 <20251219140216.GA247368@pevik> <20251219144102.GA325483@pevik>
 <CAEemH2f2nhCBzxw-5u5qGnDS9BcogD-KWOd+mrOoLvmJ0XPR9w@mail.gmail.com>
 <CAEemH2dts8FsEAM7gfKQjSv3ohkVehy9fXSf09_bqLfoDnUf1g@mail.gmail.com>
 <20251222075958.GA69608@pevik>
In-Reply-To: <20251222075958.GA69608@pevik>
Date: Mon, 22 Dec 2025 16:55:11 +0800
X-Gm-Features: AQt7F2od4PKhdLpaf5YTy9ebOFsZarApSYnSKcXZRz-XRnwCalFOnSFg-8ucY3g
Message-ID: <CAEemH2cXNAj3x04i2Q1C0bA9tLjownte68Ojtp=60gajDWEsTA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LDnh7OYl5KoTFbZ2GvLHCG6Xi0HpgeoCpKCKZt5c3_o_1766393724
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/1] swapon03: Try to swapon() as many files
 until it fails
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Petr Vorel <pvorel@suse.cz> wrote:

> > Or, naming it as is_swapfile_supported().
>
> Thanks a lot for a great summary. Could we merge the above with just tst_brk()?
> Or you'd prefer tst_res() and break?

Yes, merge with tst_brk() sounds good.

> And I'll do cleanup in beginning of January?

Sure, I am fine with that delay; it's not a high-priority issue.

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
