Return-Path: <SRS0=1KVt=O3=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4414C433EF
	for <ltp@archiver.kernel.org>; Thu,  7 Oct 2021 14:22:46 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD3B460F3A
	for <ltp@archiver.kernel.org>; Thu,  7 Oct 2021 14:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CD3B460F3A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D4293C7A46
	for <ltp@archiver.kernel.org>; Thu,  7 Oct 2021 16:22:43 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 42C013C5FDF
 for <ltp@lists.linux.it>; Thu,  7 Oct 2021 16:22:33 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3B01C1A01112
 for <ltp@lists.linux.it>; Thu,  7 Oct 2021 16:22:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633616551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZGu99cBl1ll56RvZ2rfkQCbfg7Jfkrrme6f7VhYM7lQ=;
 b=Yw49MYA3HVKytq3lqR4x5LSUsEewDQW+zX2csltJnz4KPUumsdUcDvG0JvaJHkT1saGz+K
 hrSL/mpbKv1eHo3kH1UMQQoxgTBf8j05pDMxlWSrnuDYPrshz9hD8MvGlVbyIBEsp9drUl
 3+6eVMQwEyDby6/AYZi4oWdLnBYl6Aw=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-G-iIULjLPmWa7yCXzFDwQg-1; Thu, 07 Oct 2021 10:22:30 -0400
X-MC-Unique: G-iIULjLPmWa7yCXzFDwQg-1
Received: by mail-oi1-f199.google.com with SMTP id
 d28-20020a05680808fc00b00275c4c35f18so3538736oic.8
 for <ltp@lists.linux.it>; Thu, 07 Oct 2021 07:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZGu99cBl1ll56RvZ2rfkQCbfg7Jfkrrme6f7VhYM7lQ=;
 b=nuhUXnKWVhDPZkmVZHyDZlrHFD5qz9+1wFIXSCSN5A5jUbMctUeazuYMtWPx193ioq
 VXRm+vv3nn1IilzC796rKsOQB75e77Pc3zMe6eb1gKoTMU1cbgLCWgTCEOPjpts0wcpY
 X9fxFoKIaP7P4OrB4lUDoBOn+aRWeo1HDpc13V/gFfu1WtvvV36wFXn1XjLAkyYEhwOJ
 UzfS8aXOK1tTeHigojUjc8GoixiSsfyCj7rskXphUfeAQBC+7KH3Qn+hoW2g4StUX7Bq
 Qu4itejCIulEzXA/b9S34wJXcfHetaQyqmVXrPKLooS09P2TCXrA3qMwiDQBQ4ljm80U
 LNHw==
X-Gm-Message-State: AOAM533nwoDoLafvGAhhB5IlXV7V/rvdp5FSCD9Fld+fT+1iHqoFuhzU
 yY7qcJTBeZWZ4rhTcfM/H6QEf/4W/z3GU4XqbS8gQaoxi0tRCHKNXEYA7nMNQBF2uqEQTuRw6kq
 lDBa2KTPNBllNnT2GR9EQWkptYZs=
X-Received: by 2002:a9d:6d14:: with SMTP id o20mr3972724otp.57.1633616549810; 
 Thu, 07 Oct 2021 07:22:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6G5cArDXzorgMImS6V/13nmbBdv1eBXKaFQyavqB+lRYvJW/r1wX0TQCgJBs0367EISM/tXPNglVMi5RD+pA=
X-Received: by 2002:a9d:6d14:: with SMTP id o20mr3972697otp.57.1633616549553; 
 Thu, 07 Oct 2021 07:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <281d8fbf1a7df4d85aea6bbd3ff74982923309c5.1633527038.git.jstancek@redhat.com>
 <YV2zMeb3ILLRPNsL@yuki>
 <CAASaF6yhMEvy8zFOvNvZWFvEQG-_LpwpBc3WgACWOOROObV+zg@mail.gmail.com>
 <YV6aQ7vYLhy5FE3r@yuki>
In-Reply-To: <YV6aQ7vYLhy5FE3r@yuki>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 7 Oct 2021 16:22:13 +0200
Message-ID: <CAASaF6ydLc8=M-hrco964mBT4PhR0xfFf2XT5NWZ6ON2ih4fyg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] open_posix: remove pthread_kill/6-1
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

On Thu, Oct 7, 2021 at 8:56 AM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > > Shouldn't we just flip the YES to WON'T test in the coverage?
> > >
> >
> > I dropped it because it seemed pointless to keep around wrong assertions.
> > I don't have strong opinion here, I can change it to WON'T.
>
> Neither do I.
>
> Anyways, feel free to push with either change.
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Pushed.


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
