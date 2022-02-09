Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33AE2C433EF
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 11:21:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A2B33C9BA3
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 12:20:59 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1922E3C0E63
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 12:20:50 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 78F931400BCD
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 12:20:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644405648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jfcJBioHw6f+OYQqfk2/h1hDy6skD5pX3V7hiAqeSiQ=;
 b=Doz2xsVEd3/23wEE1+KCsBVa9oflwzAzclVSVOZQpiRDiPdlj2ImZUJHjyVbj6esozD4Ne
 yMswAe/N0hEbnbT9uO6j5O/nMK5cUvTA6xVR/45ps5rg1sEHoD7Ri+rZHqy3JDE5owhKXR
 BRewCmA9hF93reDY59ie49Blp3AP924=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-461-yqyPKt03NDOCzMo99IW77A-1; Wed, 09 Feb 2022 06:20:42 -0500
X-MC-Unique: yqyPKt03NDOCzMo99IW77A-1
Received: by mail-oo1-f69.google.com with SMTP id
 n30-20020a4a611e000000b002e519f04f8cso1290438ooc.7
 for <ltp@lists.linux.it>; Wed, 09 Feb 2022 03:20:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jfcJBioHw6f+OYQqfk2/h1hDy6skD5pX3V7hiAqeSiQ=;
 b=rE0NvieFXukihZyzoWOOFywTL3UO3Po87tdEKg9C85DTekLBYcmkr6zBSL+MeinhLV
 KeDv5i4DiO24fpQvfLcymvsBuhnZVrsyP3DJ9Bvz6uQQYlHrlFyt9bdqSmlF8SdJ1FaY
 U5mUelLJmB8OOMiDFJv5iFfNd4VAfJNlEGUnLUxa5fJe0FVuohO7DSw7du58GPVHkZgx
 bYyh+aBbywVWqaPw6vIxrwrd2BFRlPlIOB8zVXUdgnq6BkXxp/t7zrkL5Ogb1I1vy2Im
 h3hsWFWDNRLH8kTt3kkKuBnnvVsdpYiU6l3Wg9S8cbSNeD/L9CmnAIAX6gYBPfbHxDyH
 rRXA==
X-Gm-Message-State: AOAM5323rUpmcddI579535mNYVME7iSxkfF055s3OmD8GdqlZ2GRJUzv
 iidO1lTpoOgqotB/AL8x8l3/7riQo2WaYmhVu3Mm6FZU3eGA86bPkd1xQDTBWsYtnXMf4kGUlZR
 hLYuD5D5MW2bN6iSUkGPjpL47wYY=
X-Received: by 2002:a9d:58ca:: with SMTP id s10mr651820oth.176.1644405641241; 
 Wed, 09 Feb 2022 03:20:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwlZkVCYfIZSWx10keRZGVfL1i5pHF6Rlhs3v6CoRy3rZ4Yj7RomFASLRxLTjir30VmaWopbb+keARvPIZYxGY=
X-Received: by 2002:a9d:58ca:: with SMTP id s10mr651816oth.176.1644405641033; 
 Wed, 09 Feb 2022 03:20:41 -0800 (PST)
MIME-Version: 1.0
References: <20220127094925.1619-1-andrea.cervesato@suse.de>
 <YgOXUL6S8yien+Xn@rei>
In-Reply-To: <YgOXUL6S8yien+Xn@rei>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 9 Feb 2022 12:20:24 +0100
Message-ID: <CAASaF6y3=gRaqxA8FnJ2DnA6sXhox7g1e40un6mvvrriDv2RvA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Rewrite process_vm_readv03.c test with new LTP
 API
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

On Wed, Feb 9, 2022 at 11:30 AM Cyril Hrubis <chrubis@suse.cz> wrote:
> > -static void gen_random_arr(int *arr, int arr_sz)
> > +static void create_data_size(int *arr, int arr_sz, int buffsize)
> >  {
> >       long bufsz_left, bufsz_single;
> >       int i;
> >
> > -     bufsz_left = bufsz;
> > +     bufsz_left = buffsize;
> >       for (i = 0; i < arr_sz - 1; i++) {
> > -             bufsz_single = rand() % (bufsz_left / 2) + 1;
> > +             bufsz_single = rand() % ((bufsz_left / 2) + 1);
>
> It was correct before you added the parenthesis, the + 1 was there to
> make sure we do not end up with an empty buffer if rand() returned
> multiple of bufsz_left/2.

I think that was to avoid the case you described below (modulo by zero),
zero iov_len appears allowed, so it may be interesting to let it be tested too.
(if bufsize and nriovecs allow such combination as you pointed out)

>
> Also I guess that this only works reasonably only for bufsize >
> 2^nriovecs otherwise you may end up doing modulo (%) operation by a
> zero which is undefined operation, I guess that the process would end up
> killed with SIGFPE.
>
> Looking at the code we actually depend on the fact that we have two
> iovec sets whose size is the same, and this of course works only if the
> buffer size is large enoug. This is actually quite complicated.
>
> I guess that we will have to change the code to make sure that bufz is
> not consumed until the very end, so maybe:
>
>         for (i = 0; i < arr_sz - 1; i++) {
>                 int mod = MAX(1, (bufz_left-arr_sz)/2);
>                 arr[i] = rand() % mod + 1
>                 bufz_left -= arr[i];
>         }
>
> With that we make sure that bufz_left is large enough as long as the
> bufsize >= arr_size (which is something that has to be so anyways).
>
> But thinking of it again, as long as we allow the iovec_len to be 0 your
> change is actually correct as malloc(0) returns a valid pointer on Linux
> (which is not generally guaranteed). But if we are going to use that
> version we should explicitly check the size == 0 when we allocate the
> iovec buffers and set the iov_base to NULL and iov_len to 0 in that
> case to make it clear that the buffers can have zero size.
>
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
