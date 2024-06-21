Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C75C2BA1A
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 09:13:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C7C043D0F1C
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 11:12:59 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 602013D0E3B
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 11:12:43 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 52B551BB958F
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 11:12:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718961161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6nE2+cA4LTX9zVcmhctUdr6wIJLEeG4+eEhnkPTZvDo=;
 b=Rx4Gel4Z/Rs7xzhzBDRW6qep5o4Z4TM+456Jh31oMFoHzAISmttUntRaje74bTxZWboZ91
 O7TihPxKBgNAH6FHprqzZSYIMzyx1KyKIcLBX8HxACism8eCUv/xiBdFIAPnghxB4XAixM
 FkGweomkUJYZftYTQkIdQLhx8nejxhk=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-fbCLlOc2MJiiZ17O8LETiw-1; Fri, 21 Jun 2024 05:12:37 -0400
X-MC-Unique: fbCLlOc2MJiiZ17O8LETiw-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5e4df21f22dso1492030a12.0
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 02:12:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718961157; x=1719565957;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6nE2+cA4LTX9zVcmhctUdr6wIJLEeG4+eEhnkPTZvDo=;
 b=PdjrVcXmryXZafNQ4/xlirgrcSgwtQJ3mHKDyv7Pje9ADHewenCR9q06p5X0dtG+0X
 hxomgPHcGz47rkj9n4CdvCtTVYrPRj7J5OwrqshsHYO8Zw9GScsA7ljYA3yT2qe1CXkG
 vXg5MraqeRr72nfqMjWYu09896Rmxnlqbe3NQ8SzbXzZnWYqUAOzOyy/6OUahf4WC1sT
 uVb4tN42xtVnfm47d86Oo5W2CAekZB/bIKWaLFWVWP/6LAbSX7X8z6oZPAeWEEYieE9t
 NGGg9k9Ocp6yagz/iZejkwp9FE4V5seoHWAQVUG+u084ZqgAq6QGthKJC9k3+gxuSnK0
 9l2Q==
X-Gm-Message-State: AOJu0Ywz3je3mPM/QQuUH2CYI8LOGOQhEZb7cOCo6QsaHHo0XbCyOJpx
 2uvyPHd9PmHG7CtQPlff9+7S/skugF0Tv684yL0r3ACMYFsbptreBy5Oiuf3soZz88w3WMheK/n
 71gdnDTQUyGHLls6R6EJATKgg7gEV2QwgPE+W/h5NZkXz7d9Y2tTLsYNPJL4TTcylWCqvSCEPfR
 K4H4u8K+x2z00yY17dbRXi0Aw=
X-Received: by 2002:a17:90a:ce15:b0:2c7:cd4f:d765 with SMTP id
 98e67ed59e1d1-2c7cd4fd841mr8552514a91.21.1718961156587; 
 Fri, 21 Jun 2024 02:12:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQnhC2SCgkt/Qb4FMdAkoOia8lFZOJ/V7x15UH4pB8o0m/OmiiesZ+PMNDyahiWGMcjV+rNfHarAMmmE4F3hI=
X-Received: by 2002:a17:90a:ce15:b0:2c7:cd4f:d765 with SMTP id
 98e67ed59e1d1-2c7cd4fd841mr8552492a91.21.1718961156237; Fri, 21 Jun 2024
 02:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240620021635.489505-1-liwang@redhat.com>
 <CAEemH2ctF+3AEZkm4Y+KkcTUgYGM4XD24pkfwdJo=6ynQ-Wgxg@mail.gmail.com>
 <20240620052100.GC537887@pevik>
 <CAEemH2fd-b-apt-ifnAMDcq5ogCD1FJm+rHpq6R_6D9yvxuDbA@mail.gmail.com>
In-Reply-To: <CAEemH2fd-b-apt-ifnAMDcq5ogCD1FJm+rHpq6R_6D9yvxuDbA@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 21 Jun 2024 17:12:23 +0800
Message-ID: <CAEemH2dv-LfYvEtD=1F+4wQkXwwvLwVZ8O=sd-VpBicOZhDYog@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] tst_kconfig: Avoid reporting buffer overflow
 when parsing /proc/cmdline
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi All,

Li Wang <liwang@redhat.com> wrote:


> > > diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
>> > > index e16ca1400..8eb1b803f 100644
>> > > --- a/lib/tst_kconfig.c
>> > > +++ b/lib/tst_kconfig.c
>> > > @@ -569,7 +569,7 @@ char tst_kconfig_get(const char *confname)
>>
>> > >  void tst_kcmdline_parse(struct tst_kcmdline_var params[], size_t
>> > > params_len)
>> > >  {
>> > > -       char buf[128], line[512];
>> > > +       char buf[256], line[512];
>>
>>
>> > Petr, if you are still worried, feel free to enlarge them to char
>> > 'buf[512], line[2048];' during merge :).
>>
>> Li, I'm ok with 256 :).
>> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>>
>
> Thanks.
>
>
>> -                               tst_res(TWARN, "Buffer overflowed while
>> parsing /proc/cmdline");
>> +                               tst_res(TINFO, "Buffer overflowed while
>> parsing /proc/cmdline");
>>
>>
>
>> But I wonder if we should keep TWARN. Or at least add
>> +                               tst_res(TINFO, "WARNING: Buffer
>> overflowed while parsing /proc/cmdline");
>>
>
> +1, I'd merge like this if Cyril has no more comments.
>

I dared to merge this patch to avoid annoying our engineers with this
little WARNING issue.
Thanks!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
