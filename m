Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8EBD37E2A
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 13:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768397816; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=oPgvcnytiaA3sSd1jDgBTl0PpHXZM15vhxwbzBG+lPQ=;
 b=QZs9XyoePFPZcvO4o1onUl1mfF5Qd4VMyO4Gxmc1+Bf/62yXnjVW3LrKMLa5whEvBMeK8
 6l2LfB+NBGg6GxpE3Hg/9Jb52Hf0bvnAPvtNkzIg3nYB7zXfJ/Oqvm6maHNNV3ORvLFmdJO
 FrA4X5gXT8PxY8A14/wz1Zc4I5dZAng=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 358E13C9B9E
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 14:36:56 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4C79F3C9A42
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 14:36:34 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4DCFA200B22
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 14:36:33 +0100 (CET)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47d3ffa5f33so39597495e9.2
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 05:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1768397793; x=1769002593; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H9qLw4PdM7mTGWpyV7cai96bjI27ETt5mo0erpNneGo=;
 b=RUMLZk6E/5jBmMT0ceVvxRzHdPezoy3o/s1Go0pCWChn55HqjxwsIgP85YSYYKnJMC
 gTFZUigb63mN3kJ0EofgEDRcvITZkMAAngXM8ITk7OLqarGk2AFUlPBAc7u1i9bfslAU
 9Ow8/KI8qtkPcoxV59upVlBi/jDWSof0gUoFdjg0+R2g6feRHb7zYXo5MqMu7ncj2Y4w
 FoW3dU+AC5PMp6+p+lks4XvHfLYurUbcoVG2L49uZF6+Qp7UhAX/pNDpP2KeLkOM+QpD
 HmpZ8y9qExrCMIJS3cIZtwhuzD9UX4hV5e4yNGXud2VA6p4ay1MKhWLF7OQofuAL3KdJ
 LchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768397793; x=1769002593;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H9qLw4PdM7mTGWpyV7cai96bjI27ETt5mo0erpNneGo=;
 b=H78hPlRC4hntH7tLzX7Boi03pvWQCJSyWe5Y0yrfyOdutXeiPxxMeGABW6MvRbvPs5
 0olUORB40LT1VLBUShApCiDDVOpez/Jr827HqW6ZrztfSrPiC/KHjQKgM9VJCZxp6JnC
 kyQHN5m2ZcwAoIYIvI5oL3bPoMH5H8GLpkT4D77Ff9ODEIZEM65rlgUpmc4zodAVCgFo
 OiHltuiwHTZVASj7yAJElk2X1hzn47Ylp6pagGLqVK+pjB1IHV8HqlsCCP+rsmoE99tx
 jYPn84yD2CLsLDWxlwKAuTkwtL8jF7J6Vo9lZOBria8W713TEpy2MiJRy3oU/Tn6vrHd
 uMAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa3DvgcyKaEIvB1r3GijiazHjVdjfV2LV1oQBGzK8mhwJIKjHoFQ8cMhvedqrOKV07BVs=@lists.linux.it
X-Gm-Message-State: AOJu0YxOEj0xtrymXhs+3r1NEo3zpuE1TpYRyq+14//bb1ni+q0e54nU
 0sdaABjPCeA0HwrwmffKEXnbakZWSjNngh/HE4gvXYUG/DTjIme+nfZAreZ0yLyxPdc=
X-Gm-Gg: AY/fxX52zFAMXp12/U5lc7gwvS7yBK3JzWfGPyXIbXjBkIwtGsot3rTvh9siPY/wJhc
 D5fw8PF9ura8f6kJ/Z8D7uuI9jy0byHzzIDNz36woLcHo497A/omHKuWhNS14Swrr3322lykL63
 g0kZVWah6T7FElaGbLl2nl0C1/3yD5yhetoGxwUDIjvGqI6AP3V2po8yCBob0bCByaA/1FIVpyS
 MdbhlAPvOyJ+jFzfIUz2kvntynJ1ib32xf4OJoi5TzhapIE2r1ohJjiZhUhgLTFLvm5aN9bU1kR
 rIBG8pw/PyWN8365IvRDq67I57IqOqbjFiGt1Pw62ouXoXA6VJ3AMoPwPT7RkpOGuhnUYAO3PMR
 WBHMZGsUnj05RHUqfAkp42vZdER7hqKvwIt2t5WUd/QYtuGDo27zXLx2Urx+uEbNq2R7S1/H+MP
 DUoUinD4gJcKFvMyH4MncDttZrM70g+JGLb1Sm7Wq91ZbBrT/VPDcNr3AFHI/G0425MN25EYrU7
 OVj
X-Received: by 2002:a05:600c:8b58:b0:46e:506b:20c5 with SMTP id
 5b1f17b1804b1-47ee33a0e65mr32724515e9.26.1768397792632; 
 Wed, 14 Jan 2026 05:36:32 -0800 (PST)
Received: from localhost
 (p200300ff0f0b7b017e458f16f8082810.dip0.t-ipconnect.de.
 [2003:ff:f0b:7b01:7e45:8f16:f808:2810])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee57feabbsm29585535e9.9.2026.01.14.05.36.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 05:36:32 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 14 Jan 2026 14:36:31 +0100
Message-Id: <DFOCP67N3URJ.1JRGHBYX4VFJF@suse.com>
To: "Li Wang" <liwang@redhat.com>, "Jan Stancek" <jstancek@redhat.com>
X-Mailer: aerc 0.18.2
References: <20260109023914.45555-1-liwang@redhat.com>
 <DFMMND84JK0B.27NIM2SX4YYGR@suse.com>
 <CAEemH2c-Maht3X7Qu5Shv+amXVWJaU2NKsCYdzNE2t9jnoWbzw@mail.gmail.com>
 <20260113115148.GA314748@pevik>
 <CAASaF6xrnNY5gpURDqgxQBWvQ5BqzXQN07NTkVbFae0bKB5PZg@mail.gmail.com>
 <DFNI6KO750G6.13XP4I5MYH1HQ@suse.com>
 <CAEemH2d6=vmEKKf65WuAGRhfU4FE8mBf-dAzNWLmgYtFO3WA6Q@mail.gmail.com>
 <DFOAT97WU1QS.V5X9ZUZ9J6U4@suse.com>
 <CAEemH2c_HQ1pb0-HF_gMJHsQFde50pjmZ+au120zdhQt7x=rFA@mail.gmail.com>
In-Reply-To: <CAEemH2c_HQ1pb0-HF_gMJHsQFde50pjmZ+au120zdhQt7x=rFA@mail.gmail.com>
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: Pradeep Susarla <pradeep.susarla@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed Jan 14, 2026 at 1:47 PM CET, Li Wang wrote:
> > > Perhaps we can use a lightweight name for the extra libs/:
> > >
> > > est_*: extra test library
> > > xst_*: extened test library
> > > lst_*: ltp test library
> > >
> >
> > Otherwise we can have `tst_` tag for all libraries inside LTP, but
> > divide them into categories according to their meaning:
> >
> > - tst_*: test library
> > - tst_lib_*: libraries inside LTP
> > - tst_old_*: old test libraries
>
> It might not be good (too long) to use tst_lib_ in the function names,
> which not easy to distinguish from tst_.
>
> To combine with ltpx_ suggestion, I guess we could use:
>
> tst_*: core test library
> etst_*: non-core (extended) test library
> otst_*: old test library
>
> The reason I'm not using the word "ltp" is that it's too broad,
> we're better off naming it around *tst*.

I guess we reached a point where 5 engineers found 7 different
solutions. For me it's all good as long as we keep the "tst" tag to make
sure we know we are importing LTP stuff :-)


-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
