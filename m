Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1902C433EF
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 11:32:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 963143C9272
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 12:32:49 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B879D3C0E02
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 12:32:39 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CE68A1001293
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 12:32:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1640086357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mx+Ii3CUkd9chjnZJuMlvr+I6d6CTnX/Y/WgIKq+E1U=;
 b=g6RkuyFQXAjkH2fQ2PYPqBqzlx2IB2qdQ1d8s6yPITIJWfMWPxHQYrP1vr+CzDZ2RxaE44
 Hd2hGHyAeghaaH8/oBEcWg9GQ1c4dHIJRAjUIDURMSsiUIiQSeWeO27LRUIoks3gc/Fy/x
 Z/OiTmJ7Nsy/q1a9na4p7rNeJSQ+vuw=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606--4-o9o5_ON2vFCXUBll1zA-1; Tue, 21 Dec 2021 06:32:36 -0500
X-MC-Unique: -4-o9o5_ON2vFCXUBll1zA-1
Received: by mail-yb1-f199.google.com with SMTP id
 q123-20020a252a81000000b00609e97bb74bso4346886ybq.5
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 03:32:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Mx+Ii3CUkd9chjnZJuMlvr+I6d6CTnX/Y/WgIKq+E1U=;
 b=mGxzlUlBTEIZg2LrwoN1uyoTGAcem7Dnq3XjwGULHUabujYcpvttG4C3f5DT1dg7xr
 K99SuAflQohK6lHBTywnBjJwle2JEsVlVUbKT+hf1lJfNQZ2oam0BW3ZGVYbRFh7g1Es
 nIfe7z76RINt02ZCX2IbuPFrTK1WRXAFGZUcFO/gZFoEz4SRRyuUGgTUa5ahQnMBktnz
 ja1aJaj1k9KeUOzo0xN/9QUZoVNDL4//UNo4vVZymQ8H39oqBI3v3mUm+pqhYj1XxWlq
 t8O4RrPMrQ8Rl2iiwLHFHd3MJktk+QLOlTxgYnlofQnt8jMhJdzfUn35RCyskl9F/SYs
 W5Lg==
X-Gm-Message-State: AOAM5319ceGuizxe8xSONXzryRf183A5b6CjlvBmK0AyFuBSp+921l4A
 cGebLvT6JwO2AeeTkO3CEW4VlUfDAQnrzqfIKj2FeYluL/rE60O88x9nF3rIyrJv7Aqg9URk5bK
 HmjMOg00CIAlH2xR8qPs1kE5H2Fs=
X-Received: by 2002:a25:ce94:: with SMTP id x142mr3897232ybe.145.1640086355834; 
 Tue, 21 Dec 2021 03:32:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy7NoVw4A2HGK2WxbrdetLVxCEoDQiK2Ds6MGfjEfZLhzLG85mQIcd+wCj+8xMT3Ozn2a8N+n/V3Ifp7oJQZ78=
X-Received: by 2002:a25:ce94:: with SMTP id x142mr3897208ybe.145.1640086355617; 
 Tue, 21 Dec 2021 03:32:35 -0800 (PST)
MIME-Version: 1.0
References: <20211220095416.583323-1-liwang@redhat.com>
 <YcDMnDRgsac/q8D9@pevik>
 <CAEemH2d6PPi94q3PhMyR1Js_Rqr1dpfvch=ex3HpuHfQKJYTnw@mail.gmail.com>
 <YcGb5abUqe8PNKoM@yuki>
 <CAEemH2dDEM30-fM89LDZq1E7YN8rf44doGgnkPXuce0ttP67OA@mail.gmail.com>
 <YcGlb4NoDGSP4ZkU@yuki>
 <CAEemH2fFY_TuCEqoR9ogqUBA5mFjY-FX+tDufYs39uN0JJ9gvQ@mail.gmail.com>
 <YcGuIJql99Row3o9@yuki> <YcGwDKmi+iQuw3fS@pevik>
In-Reply-To: <YcGwDKmi+iQuw3fS@pevik>
From: Li Wang <liwang@redhat.com>
Date: Tue, 21 Dec 2021 19:32:23 +0800
Message-ID: <CAEemH2fGRTnoXhC3M0TeC54hTx3=wn4kS5oyemOVHXGEuFwAjQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/3] lib: add functions to adjust oom score
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr, Cyril,

On Tue, Dec 21, 2021 at 6:44 PM Petr Vorel <pvorel@suse.cz> wrote:

> > > +       if (access("/proc/self/oom_score_adj", F_OK) == -1) {
> > > +               tst_res(TINFO, "Warning: oom_score_adj does not exist,
> > > +                               skipping the adjustement");
>
> > I'm not sure about the "Warning:" in this message, I would just dully
> > informed the user that the interface is not available.
>
> I'd also prefer not having to print "Warning:" in TINFO message
> (I know TWARN exit non-zero).

Okay, I deleted that keyword and pushed patchset.

Thanks a lot for your both review.

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
