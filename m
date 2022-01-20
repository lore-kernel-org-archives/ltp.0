Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D49F1C433EF
	for <ltp@archiver.kernel.org>; Thu, 20 Jan 2022 07:30:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9EA6D3C96A5
	for <ltp@archiver.kernel.org>; Thu, 20 Jan 2022 08:30:57 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE2DD3C2AE3
 for <ltp@lists.linux.it>; Thu, 20 Jan 2022 08:30:48 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D2C6B600956
 for <ltp@lists.linux.it>; Thu, 20 Jan 2022 08:30:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642663846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=81q61CP5WsxOxSVt8r8Ru29dTj2QjLiBH/w/+2zma2E=;
 b=XkX818WNsKNlCTLFxeEbmMx06KZ23L9x8QjoWCzBJvyf0L0wTWaz+OruIwRtX074pA9YLD
 jb0OAobJbcTG/9W2OFMpixadwOWFbYnpcBkGlAmanQI2RKW5g64xzD5sKaeNia5w07g58G
 VXQafExZ9TGSyGL4JZGeUNKX0WE6nBY=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-170-BXkLutveMcClyLo1lIsDkw-1; Thu, 20 Jan 2022 02:30:40 -0500
X-MC-Unique: BXkLutveMcClyLo1lIsDkw-1
Received: by mail-yb1-f197.google.com with SMTP id
 g7-20020a25bdc7000000b00611c616bc76so10073201ybk.5
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 23:30:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=81q61CP5WsxOxSVt8r8Ru29dTj2QjLiBH/w/+2zma2E=;
 b=z7gHUgkdWKW9W8S46Dndv9KBOiSqc+Cu0kgbT0wX8YdG9fKHa9Hr0uES4WQ5H+bEZx
 BmJ11//zCrL6yH1mCJUvAMWXA4E5r8iWOQCA/3mtRfm5K3m9uDrEavnnNOfTb7K/EJMG
 y/TkhMzHU3c6z/sKftS0ghTZCS4J2/5JN12saGoLSWOm8nIpRgsW8hSli6YieOrDXI1i
 HHo8OKrGHCVzYuJBruEKZkwRZKybP1BBKiYi9BszQEAKMAkJfU/d27W3m+un+EqJPpfO
 bRUzic1KeJ3VmXcwDCz8WDx4xO0+zB9HKV3fXgOW8CZ/c+gKq/D2s5/ZnlhIsvmw1bfI
 3V8w==
X-Gm-Message-State: AOAM533Sb4rgc06U5G04k2YR040cVFaTl/pvpw3+Ny5HnuZA7UfWoyLl
 Wk2Fx29XnmpCccknq6WE73SKLYhjShD5OLM8kYBwSVCkyxUnSQBzFsRGXz67mrgOvN/5LmGXFjN
 87ZEOgGPxwhpJwSS7RFsEAMz4OSc=
X-Received: by 2002:a25:388a:: with SMTP id
 f132mr46072137yba.102.1642663839568; 
 Wed, 19 Jan 2022 23:30:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzwYUZ5uf1+vkPWj4cyaw5tS5QwWPMKylRXxzXxMfTllN86IW05PjQ/gAgZSgtl0Tj4Cz09h07Y92DFGM7dM78=
X-Received: by 2002:a25:388a:: with SMTP id
 f132mr46072118yba.102.1642663839399; 
 Wed, 19 Jan 2022 23:30:39 -0800 (PST)
MIME-Version: 1.0
References: <20220119111533.8356-1-mdoucha@suse.cz> <YegzzrFYKI+0DIis@yuki>
 <CAEemH2cfr9rcrmqXbS+M+ohyP1rU1BNzZX-H=st8Z3P_WL=A+w@mail.gmail.com>
In-Reply-To: <CAEemH2cfr9rcrmqXbS+M+ohyP1rU1BNzZX-H=st8Z3P_WL=A+w@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 20 Jan 2022 15:30:26 +0800
Message-ID: <CAEemH2cdLrRWJYJkGwBY6HcuyWvp830nK36xES8qhZRggq7yuA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Rewrite statx04 test
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

On Thu, Jan 20, 2022 at 3:18 PM Li Wang <liwang@redhat.com> wrote:
>
> Cyril Hrubis <chrubis@suse.cz> wrote:
>
> > > +     /* STATX_ATTR_COMPRESSED not supported on XFS */
> > > +     if (!strcmp(tst_device->fs_type, "xfs"))
> > > +             expected_mask &= ~STATX_ATTR_COMPRESSED;
>
> ...
> > > +     .skip_filesystems = (const char *const[]) {
> > > +             "fuse",
> > > +             NULL
> > > +     },
> > >       .tags = (const struct tst_tag[]) {
> > >               {"linux-git", "93bc420ed41d"},
> > >               {"linux-git", "99652ea56a41"},
> > >               {"linux-git", "04a87e347282"},
> > >               {"linux-git", "5f955f26f3d4"},
> > > +             {"known-fail", "STATX_ATTR_COMPRESSED is not implemented on XFS (strict mode)"},
>
> I'm wondering if it has necessary to add the known-fail tags here
> since we have already done XFS filtering in setup().

Sorry, let me pull back my question, seems I neglected there is a 'strict mode'.

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
