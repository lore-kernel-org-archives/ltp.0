Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46158CA0EE8
	for <ltp@archiver.kernel.org>; Wed, 17 Sep 2025 11:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1758109003; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Za7mrVstAqFgKYyX03w+UN7Q/6iWfYGLTsY82nityRU=;
 b=E1a8UrpuEk8y1h2iU2eRlErc7jCMi3/uUbeG2bxU7u3gfxknl65TZ0ikB29LRNdvtk8Mh
 pQyLwnP9Lt6cQdWogWsEnac5Z/ZmAYCa050GVJKV+Gp2pq1rOZ0GXmNgz9sacn4b0v7pqrB
 TJqWR3wylFRhnWZqfvFL9nxadk3CNzI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC6133CDC18
	for <ltp@archiver.kernel.org>; Wed, 17 Sep 2025 13:36:43 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B78BF3CD427
 for <ltp@lists.linux.it>; Wed, 17 Sep 2025 13:36:22 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D34D66008C5
 for <ltp@lists.linux.it>; Wed, 17 Sep 2025 13:36:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758108980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NlvQZpHTg9dzoed3qFbAIUC80uV4D+CH7v7Nqd2Lyc4=;
 b=YpeAnSeynhC0VQmMkVodwftKF7aa6cJmaHkznAf81Fii9zFM93EF1t7h7o4a8Oeb2W8tAz
 JgPOHLtRxTPc6G5Pf8CXqS1lfZWfQrHlDVT7bYln4BLbv2twQLaWmQ3rXPuOFZTDgQdcsk
 kM9zfI0JEGvrF50kS3ZDkONEhfVFEkw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-rn8OcpICNAynEffqdIMPBQ-1; Wed, 17 Sep 2025 07:36:18 -0400
X-MC-Unique: rn8OcpICNAynEffqdIMPBQ-1
X-Mimecast-MFC-AGG-ID: rn8OcpICNAynEffqdIMPBQ_1758108977
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45cb612d362so40858895e9.3
 for <ltp@lists.linux.it>; Wed, 17 Sep 2025 04:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758108977; x=1758713777;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NlvQZpHTg9dzoed3qFbAIUC80uV4D+CH7v7Nqd2Lyc4=;
 b=wmO6QfIUoXu8nElfT/fZgS1SnmC0cWU4a0wsdR670/0Ib1JO1lyy/AmmtSSIEA6ws3
 Z/SAHBkg7equGvuAVgqDaXmqr0obZoyKbZ48opk6awKlPOW944JAndS5Q3qJ/1EpzZUg
 km2nruZE/dmQyRsoX0DgD4eNfUgNKY/i8MNWX83HVRKOK0DaQvDyb4cVBjLORoySGZ8X
 tfzqNquxSPvQdIoiwjogP1T1wrLNVi6LILzIRskTbzSvNZ1QpVr6twO3pbSNVkMlJ0A6
 rNb/1yqzh7TxChBO901oLomYe0rcuIEPngHsrKES6pgqgUdWKHXMxAmHqQD0swC/fEqv
 7uqA==
X-Gm-Message-State: AOJu0Yw+8qr0RVTRtT/BQE/ghyRADTNsFW71VGisjqBY+vxPJmAmbUe1
 9Fa3v4fwotAoK/Xh/dPClQPgZdrBb5Pv/rt9pipYelY6l88LefI1T+TWAkI8roY4f22gtc/UUr7
 kPtPMLc+bRBJJWgVYAoDtB4OD0lH4S6GFmQDONXU1nMty3hfLOhMk
X-Gm-Gg: ASbGncvfq2xOMHRptcq6C8QpVkrOMZcIyIWSI9aPgiMM2uP3INe9kIyJHhXKrrILVpt
 cmLBUP4Upzz+7yWk3d9O9bb/4x89YChdrrX6TDd6bm9f38r0S8GaJNJZc+o+DsxMmHLeWkqEtHL
 fqfuAh7zoebw7x5KF/TZeNHdq01uyl2rGwe1rgIFp7vDMiqDcaeEUkNBP8RQ/pbMxLnUPHZhioU
 nVEHOe9P6EV9Bvp7EgaPlf0lduljAGc5ayg/SMaGY/TV/5zFXr2iubEERVSuu9A0ySkErRL731l
 7pCR3BL23abUjCXB4dp8lShuqwB6yqH8CaHl8HGfQGY3nAN6X2VyzMUYMw==
X-Received: by 2002:a05:600c:310f:b0:458:bd31:2c27 with SMTP id
 5b1f17b1804b1-46205adf774mr16870335e9.23.1758108977183; 
 Wed, 17 Sep 2025 04:36:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTGGpC5rRb3jGHrRP/f50bGZlpGavW0fPInQUV2pnuN609b+mSKjDJ0U8JVoQSGT+SOxKx/g==
X-Received: by 2002:a05:600c:310f:b0:458:bd31:2c27 with SMTP id
 5b1f17b1804b1-46205adf774mr16870005e9.23.1758108976768; 
 Wed, 17 Sep 2025 04:36:16 -0700 (PDT)
Received: from lida.tpb.lab.eng.brq.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ecdb77fba4sm4636823f8f.1.2025.09.17.04.36.16
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 Sep 2025 04:36:16 -0700 (PDT)
Date: Wed, 17 Sep 2025 13:36:14 +0200
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20250917113614.dolw4fzlbl5k54jv@lida.tpb.lab.eng.brq.redhat.com>
References: <20250917090712.5tbidlr7yvqvikj7@lida.tpb.lab.eng.brq.redhat.com>
 <20250917103717.GB336745@pevik>
 <20250917111319.wgfpjmkicmv2rjti@lida.tpb.lab.eng.brq.redhat.com>
 <20250917113013.GA340479@pevik>
MIME-Version: 1.0
In-Reply-To: <20250917113013.GA340479@pevik>
User-Agent: NeoMutt/20180716
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xm8P2Qkj8Jr9-ZRc_Vo8uvoO8hYU4ZBDZSZ5oL-4zVk_1758108977
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Proposal for new LTP config knob: LTP_QUIET
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

On  Wed  2025-09-17  13:30 , Petr Vorel wrote:
> > On  Wed  2025-09-17  12:37 , Petr Vorel wrote:
> > > Hi Martin,
> 
> > > > Hi folks,
> 
> > > > some time back, LTP_REPRODUCIBLE_OUTPUT was introduced in LTP.
> > > > I'd like to propose a new, related LTP knob for our Valgrind
> > > > test automation purposes: LTP_QUIET.  See attached patch.
> 
> > > > LTP_QUIET is supposed to suppress certain types of test output
> > > > messages, such as: TCONF, TWARN, TINFO, and TDEBUG.  This would
> > > > help us keep our test logs briefer, while still keeping the
> > > > information we need in the logs.
> 
> > > > Please, consider merging upstream.
> 
> > > Thanks for contributing this. So the point is to have only the final summary
> > > printed, right? (summary of TCONF/TWARN/TBROK/...).
> 
> > > I'm ok for merging this + to introduce the same for shell API (tst_test.sh),
> > > although you in valgrind don't use it.  And we could even introduce '-q' getopt
> > > (easier for manual debugging).
> 
> > > Do we then want to keep the "reproducible output" part? Or should it quiet
> > > replace it?
> 
> > Hi Petr,  you are right that these two knobs (LTP_QUIET and
> > LTP_REPRODUCIBLE_OUTPUT) partly overlap.  In my proposal, LTP_QUIET
> > doesn't silence everything.  It does silence TCONF, TWARN, TINFO,
> > and TDEBUG messages.  But it keeps TPASS, TFAIL, and TBROK.
> 
> Ah, correct (I was wrong). If there were users who need to separate these (i.e.
> using just single of these) I would keep it separate. But IMHO you valgrind
> folks are the only ones who use it, therefore feel free to modify it to fix your
> needs. OTOH, if you're ok to using 2 variables, I guess we are ok to have both.
> Let's see what others think (Andrea already acked).
> 
> > Suppressing everything except the final summary seemed too
> > aggressive to me initially.  But as we speak, it would work for
> > Valgrind testing purposes just fine.
> 
> If you compare whole output mismatch in Summary would catch a difference.
> 
> OTOH you're right that it's safer to keep at least TFAIL and TBROK.
> I'd personally add also TWARN (not that many messages).

Right.  Agreed re TWARN.

> 
> Kind regards,
> Petr
> 
> > > @Cyril, if you agree, do we dare to have it before the release?
> 
> 


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
