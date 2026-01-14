Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A546FD29FF9
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 12:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768394916; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=yMhcW5XA5M5YY4XQYLJ+q2ny+j0R0dOAuMCf5ccx5Dw=;
 b=Or57K3v/w8o443X8ys9/wVrDM9NrsuPl6cQSqCABWXWJnGl95OMEFdsEYvCh0EjYt0/Il
 mfkQXKurhQggBNRnrzbw6s96icdWDzFxTESLsia3zlYWQxf9lWWMjYDC9tRHG94+hC50Fx2
 pjvZ3FyYGTJUrupa86M6EX7GAH6EmvA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2CFEF3C99D6
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 13:48:36 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C19693C00FE
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 13:48:12 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 73199200AEE
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 13:48:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768394889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zbv+3V+4XpoS6PKxFEk8cOr5KuFo0X9BBXM0YRK9KO8=;
 b=c+BiCCUrTbPPydoVPiUmyU0IlF6CVrd7WQd+PRPM50kYukBlC9VOWatHm35r45d0ycRMn5
 +F5axRIxH+J4oz2cEMXU5NKoTGlO7EUumZmAqEaaJN6kF/EQwUBt5A5MEEQayaGxYScrxV
 gAcBUh9qHQ9WGzIaV2+pjLrX1ljFFzA=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-HFkV6y9WM3WVc0mKaJOBig-1; Wed, 14 Jan 2026 07:48:08 -0500
X-MC-Unique: HFkV6y9WM3WVc0mKaJOBig-1
X-Mimecast-MFC-AGG-ID: HFkV6y9WM3WVc0mKaJOBig_1768394887
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2ae26a77b76so9800521eec.0
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 04:48:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768394887; x=1768999687;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zbv+3V+4XpoS6PKxFEk8cOr5KuFo0X9BBXM0YRK9KO8=;
 b=psftPuFOUNWMdN4Ppa5ip5dOijPqFHZrb+H3utfFWW+yk81NUfZ8mxAZREyjMAXSGW
 DGOHP8bHFMtmgWaCupa1W0kKLSzUHgs3a87cl55Bev4h/zwcfFj2onJ2UE7ZdTP0MHQb
 vT+dmwM8Lci6sfvbPMou/KkdNntYxRJpYwrJCQFKHZk8QNFYopMsBqvNMZPp2JWiflkR
 XJ/e8npxJdW5WnJlk7uaYS+RPX18sfYyvvewnG+bmPzcJAbJlgXHqqyFYnCL3zZblfPv
 7A7qWkevZXX9n2I20d2rqCYS66MXkHc5AHvYo9h5Rb+Cw7yDqCFV4Y08pmH1VkjKtX9Y
 j2dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIN59Njx55vE33PWN3PDEZqsWjqXnJ6JyNneAN/Ie73Z2j6cSuOek5RvPKll8dCvYqu1g=@lists.linux.it
X-Gm-Message-State: AOJu0YzWD/fKNx/L3xBzCoxb2NekV8oOB7QPaZXWZqau3zTyIIbisrMF
 8n4j6yAd1hWkeTLKqDpuzAXDotIXT4p4Xxf3B/uZTVHv1KDFtXKzKUlEd32ROglKZH4WJmo5UYG
 DKHWM9l/WgsrD3uvlMP3vKb4msvDBxAmjqoO4U6f8wv48MR1KjcDVzRyM3dajjHnfMJDmKYELGB
 tOpIIyoBjfm92FWYKqjcsHUUjgrc8=
X-Gm-Gg: AY/fxX5vhz0g1CReV/1tEUfLiW4eLZYhVC1ykSy/rP5QDSFz8X+uby9qSwXAojG1tj/
 yd9iiiEkW8LVlKjQWBqyh+1Xg21dEqRDo4Dtl5ZfCeknSeEoPtSKSSttGsg4VM6JTIY7GTE2g5a
 tnc5NgD0o8FQvt/g8Icrxod7LLAi5+hhNAxG5jaDQHALKwrlS09bO0R0uG57FCX1oempg=
X-Received: by 2002:a05:7300:8c2a:b0:2a4:3593:c7c5 with SMTP id
 5a478bee46e88-2b486b72e4cmr3344169eec.5.1768394887164; 
 Wed, 14 Jan 2026 04:48:07 -0800 (PST)
X-Received: by 2002:a05:7300:8c2a:b0:2a4:3593:c7c5 with SMTP id
 5a478bee46e88-2b486b72e4cmr3344141eec.5.1768394886726; Wed, 14 Jan 2026
 04:48:06 -0800 (PST)
MIME-Version: 1.0
References: <20260109023914.45555-1-liwang@redhat.com>
 <DFMMND84JK0B.27NIM2SX4YYGR@suse.com>
 <CAEemH2c-Maht3X7Qu5Shv+amXVWJaU2NKsCYdzNE2t9jnoWbzw@mail.gmail.com>
 <20260113115148.GA314748@pevik>
 <CAASaF6xrnNY5gpURDqgxQBWvQ5BqzXQN07NTkVbFae0bKB5PZg@mail.gmail.com>
 <DFNI6KO750G6.13XP4I5MYH1HQ@suse.com>
 <CAEemH2d6=vmEKKf65WuAGRhfU4FE8mBf-dAzNWLmgYtFO3WA6Q@mail.gmail.com>
 <DFOAT97WU1QS.V5X9ZUZ9J6U4@suse.com>
In-Reply-To: <DFOAT97WU1QS.V5X9ZUZ9J6U4@suse.com>
Date: Wed, 14 Jan 2026 20:47:54 +0800
X-Gm-Features: AZwV_QhZ0ag_oI3r-GE7XdzDh3lulsLOIsUIvuP9ir0mjtJA8vBz8LyMrAiAjSA
Message-ID: <CAEemH2c_HQ1pb0-HF_gMJHsQFde50pjmZ+au120zdhQt7x=rFA@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>,
 Jan Stancek <jstancek@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oNUQm5PefIEurNJz30u_XKVW4ojLuyYPl5m9nKXaYM0_1768394887
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] libs: adopt lib* prefix instead of tst_* for libs/
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
Cc: Pradeep Susarla <pradeep.susarla@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > Perhaps we can use a lightweight name for the extra libs/:
> >
> > est_*: extra test library
> > xst_*: extened test library
> > lst_*: ltp test library
> >
>
> Otherwise we can have `tst_` tag for all libraries inside LTP, but
> divide them into categories according to their meaning:
>
> - tst_*: test library
> - tst_lib_*: libraries inside LTP
> - tst_old_*: old test libraries

It might not be good (too long) to use tst_lib_ in the function names,
which not easy to distinguish from tst_.

To combine with ltpx_ suggestion, I guess we could use:

tst_*: core test library
etst_*: non-core (extended) test library
otst_*: old test library

The reason I'm not using the word "ltp" is that it's too broad,
we're better off naming it around *tst*.

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
