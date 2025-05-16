Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DA1C3ABC9
	for <ltp@archiver.kernel.org>; Fri, 16 May 2025 20:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747427411; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=0dicXnLc9FReDwmYwmb0LU69oyUPVXciWndcHzU+vs8=;
 b=NsHdMn/1Pi3922t7ompEoj33DcTyMBL+d5xJEL3ZcbUBca8CUFb1uynFHLKI/AO+syoRX
 oJo3VQZLd2AxpqigRQ6ZBboOelRULO5IRjd6BZYgr8PNs0igAWtfxyv+PSmLmIli+npBGNp
 uG+zovIWb9ip0kI6ESnwFKQgYeENy1U=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E28AA3CC5C3
	for <ltp@archiver.kernel.org>; Fri, 16 May 2025 22:30:11 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B24F53C8CE1
 for <ltp@lists.linux.it>; Fri, 16 May 2025 22:29:50 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7A9C4601F66
 for <ltp@lists.linux.it>; Fri, 16 May 2025 22:29:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747427387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Iwdh+ZfSOsxIgeAuVN954U4f5azWhjFM9TKR/61+4uk=;
 b=SyLoBXr6iTBfrmf37utb3S741WNQ6Z8hTgpa+gBtjSR5JS65lB4kFxSZRxVmA7DxqgOrw7
 MwkCIf5tcMsmg62IFpJC7i74lobS0yE5wSmVjLs7yeTe2wW7+8C7+CDr3wENw7IrB8Jzhw
 O22o+mkcCT3uWlPQ7Rt1n/TP8ho35Ag=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-whW8HRkxN_q4aAmNc7AXxQ-1; Fri, 16 May 2025 16:29:44 -0400
X-MC-Unique: whW8HRkxN_q4aAmNc7AXxQ-1
X-Mimecast-MFC-AGG-ID: whW8HRkxN_q4aAmNc7AXxQ_1747427383
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a0af6219a5so1466275f8f.1
 for <ltp@lists.linux.it>; Fri, 16 May 2025 13:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747427383; x=1748032183;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iwdh+ZfSOsxIgeAuVN954U4f5azWhjFM9TKR/61+4uk=;
 b=oF0XoztfsNHFPsFRdvumMOU+39OM5ozvmSTzytoU73fqD5wAH5Aj8aJEPS9AKcQrZD
 uPXSdyPh3oIjNf5hD2P4plLoLdmKGeyR/fQsF3nrp5LQE7Nf4Njv0vMSiihV1EgD0DhU
 b15cOJoHQXV9SOToq8Fh5aqmtNCOU6UxY/u785NZeYxWzJEabq5G3KaHvqFAP9pfIvSw
 J5HPoDU+tgsxOiFdmDqbf1aBZY08u+DYjk6kj6tLu2nX+xvRZgpmGleCT/nV9A0/HdVX
 vBWAHjosAkTJ9KdGQMJXpNaNroy6aEOmh8f5miChDitHoFcMl+yT5/a983tNEpPKqQRt
 aAZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXcOQBIlz5NDPmHl9u1wcn7y8RkWsUD/6mNEDEGETWEWs9bcF7R+gpthFGE0roQz1kaE4=@lists.linux.it
X-Gm-Message-State: AOJu0Yw4ivvWPKr7gt49QERP4rDGegMNXVjl6yu4NT6TIc/tucJS576d
 BSCPJiSaRX4UmeS0dlWHnD+pcGLRqZzWWxOc4m5oiee/85+qKBSWgtr6f6j5B8/4hoDiFyKN9gr
 FcsyJt++G/p48y5sABKc8VoAhoIFQi+a9oJxowthvynkGjaIcwHdK
X-Gm-Gg: ASbGncvBJu9gkhLMUr6DAGX2M8JYbsAbf67xdvkM6ZqVSFMEYX+LPliyHJDivMkWE+J
 6+lXFDlTayn/Gp50gG8GC2x8Mj2ILnJugjouwM5fuoCcGW4XK/UfCFvW2qxEEQa+MM06qxJ3nOi
 e2S3sIsZkAS4gbntIN1YJpu3B3RoDqnD907/L8bz5K0ZUzUoOI0gRwaJovje1WHD9hUf4MvwKeP
 87DVSvPftxrpVqxf0oHMBn9wee7f0rBrcGaANIMluRyi+IkyCHWYO0PCvwfUJTbCQhXeyEdwmHQ
 GDv+Lhz79Bo9JAOonmo83APAezvssA==
X-Received: by 2002:a05:6000:4007:b0:3a1:f653:26a with SMTP id
 ffacd0b85a97d-3a3511d8222mr8511796f8f.16.1747427382989; 
 Fri, 16 May 2025 13:29:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnKZHULeOpxPRRKj5eGsyYMLLidiqkT9AZbkRLRraWEQpNX6Idf5kp85CzZwD1UQeEADozpQ==
X-Received: by 2002:a05:6000:4007:b0:3a1:f653:26a with SMTP id
 ffacd0b85a97d-3a3511d8222mr8511785f8f.16.1747427382610; 
 Fri, 16 May 2025 13:29:42 -0700 (PDT)
Received: from lida.tpb.lab.eng.brq.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-443206e87eesm13280665e9.1.2025.05.16.13.29.41
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 16 May 2025 13:29:41 -0700 (PDT)
Date: Fri, 16 May 2025 22:29:39 +0200
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250516202939.3ovq3hmqe6jf435v@lida.tpb.lab.eng.brq.redhat.com>
References: <20250509092813.12860-1-chrubis@suse.cz>
 <20250512180605.GA337908@pevik> <aCXDKh_biyimb32N@yuki.lan>
MIME-Version: 1.0
In-Reply-To: <aCXDKh_biyimb32N@yuki.lan>
User-Agent: NeoMutt/20180716
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ErYU3vHLW4eNCz1oRPTftqZUmEeHKpVfEMueoCpDpsk_1747427383
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib: tst_test: Add reproducible output.
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
From: Martin Cermak via ltp <ltp@lists.linux.it>
Reply-To: Martin Cermak <mcermak@redhat.com>
Cc: valgrind-developers@lists.sourceforge.net, Mark Wielaard <mark@klomp.org>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On  Thu  2025-05-15  12:34 , Cyril Hrubis wrote:
> Hi!
> > LTP_COLORIZE_OUTPUT allows more complicated setup (y/1 always, n/0: never),
> > but any value here enables the feature (e.g. LTP_COLORIZE_OUTPUT=0).
> > This would be nice to unify, but I'm ok to ignore it as it's before release.
> 
> We also have LTP_ENABLE_DEBUG that has the same values so let's keep the
> API the same. I've send v3 with this and the docs changes.
> 
> > > +
> > >  	assert_test_fn();
> > 
> > >  	TCID = tid = get_tid(argv);
> > 
> > Adding docs (+ sort variables while at it).
> 
> I've only added the docs for LTP_REPRODUCIBLE_OUTPUT in v3, the sorting
> should go in a separate patch. We also miss at least TST_ENABLE_DEBUG in
> the output of -h switch as well.

Thank-you, guys.  I've added a preparation to the valgrind-ltp tester:

https://sourceware.org/git/?p=valgrind.git;a=blob;f=auxprogs/ltp-tester.sh;h=036f196ce21ae6cc692de205ab49774638cfb925;hb=5894abc5fa9de30c6b4dde453bff3ac1034aa330#l19

Once the new version of LTP ships, we can try dropping our workarounds.

Cheers,
Martin


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
