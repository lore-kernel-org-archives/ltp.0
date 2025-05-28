Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1126BC5AD49
	for <ltp@archiver.kernel.org>; Wed, 28 May 2025 23:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1748474302; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=QxSnKLZjUmjZgX+oWEASJGSrPEjpSBUKqITcDyg1+j8=;
 b=mp5vnGHC4K5Dwy9yv03v6HRjH1cEIV+aDS47yMp3gZNSNS1pWMKimgQwZ4EoI9cmhWNLo
 LuRdyRFQns7fFXl7GWUOLCoBwzsEeQUmL+1tcVsk2HxZ8cFck7YHj7Y+rbRHRRUiLQrWzIs
 vzfmkHK3hlGqv/jICFJ3Z13CWjGmuxE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D4773C7AE2
	for <ltp@archiver.kernel.org>; Thu, 29 May 2025 01:18:22 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8BA333C7438
 for <ltp@lists.linux.it>; Thu, 29 May 2025 01:18:00 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9FEDA1000473
 for <ltp@lists.linux.it>; Thu, 29 May 2025 01:17:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748474277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aVPPdbtd41nygMqH6TNCnlhNtIGGTA/xFvx5yDkCIdw=;
 b=GoNe76am3wLF4MPN4fTFnzsSG2Hm5QkN+lpcoMXz21nGh90O8EM9RAihxVzsqTBa0e1cPH
 a8XqKqbooVTVWDAt6hvsPX6kF0AL0feLBWvs8RgL8/9Tr14LbV/oQ7yYRJVHCT7lQwZSSO
 vyyECDWrdyoH9lvjyvulghk9hMp58x0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-e2dvFnOfMWC0u8TeyPxtxg-1; Wed, 28 May 2025 19:17:54 -0400
X-MC-Unique: e2dvFnOfMWC0u8TeyPxtxg-1
X-Mimecast-MFC-AGG-ID: e2dvFnOfMWC0u8TeyPxtxg_1748474273
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-311ae2b6647so203849a91.0
 for <ltp@lists.linux.it>; Wed, 28 May 2025 16:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748474273; x=1749079073;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aVPPdbtd41nygMqH6TNCnlhNtIGGTA/xFvx5yDkCIdw=;
 b=kXCNfRF4zV26THAy/A6XpKlhcrdukBCFwy2sEPK6ATEcpyeL/6wLEAKaLFHyf5A2i/
 6iBA7Hj4Adm34DEJ+j084LoA09b+kykWCUoy78NsLUdvbSI1ENzX1BaRggJJ3iq/sYpp
 xq/jSK8o33ypFeIFxjpVne8ANEcdtUuCjMTTBc458Y761ntKnSh4YyTWFxRI53oeKrYU
 qQrTIh7sXF6OozMx0oVnnI2NqtGRW07N3cBF1WfOAr4/JTrDzQwEqX9HqGAiFbL/96s2
 2euQeK81x0izCQJ4vqp0Iat7rkVjk/dfsX2vU0m1QBzN1/AoVczpOSVYvBnc1UvG9d8i
 gKhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEQ5vjqsveQyz3IRKmwJPY5pYpMKiRRvjmv4kUDcAB+Ab0+17wmfqrdqetS2LJVVu5pCc=@lists.linux.it
X-Gm-Message-State: AOJu0Yy6yqv5N3jyPEBgdXGPrjJZznqrwz+aGbYdOxfBxWjpxEw12+5E
 mygpCBleql+BhGnafAlLsVk4gChxu/KUM6qU3yiQT25n5N5urceJKkJ24kXFXMFGhRHAS+mOSrU
 fjmDUqL+Yk7jEsS9ZEu6FvRCbGi1dOmlz9iFYz+5K+1VBEA2/rcUITNQRTO9t06L74S0AQ6iIQl
 2tQzFbgfcG3p+f5dJfeXTo0lepjD0=
X-Gm-Gg: ASbGncuL02Kw51E1prsZQjV5XW4ldThEpcgV2uZbSJt8Mss9cBHn3DveM598LpeC+IM
 aTEKAPP6QbkBO48RF5fmtXjCpxfoJFI7DetEyNCevadzOnIwOOJV9G+WwikF7SwbY1vBwYA==
X-Received: by 2002:a17:90b:224d:b0:311:f684:d3cf with SMTP id
 98e67ed59e1d1-311f684d56amr4712546a91.35.1748474272826; 
 Wed, 28 May 2025 16:17:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMA7SKDBjygJRjeWuSodbna+vgXEdMrCFKmUXSqfefuN+cS2ISExOayV/gO2FOV3LFuo+9cScJyl44ZiBfnp0=
X-Received: by 2002:a17:90b:224d:b0:311:f684:d3cf with SMTP id
 98e67ed59e1d1-311f684d56amr4712524a91.35.1748474272565; Wed, 28 May 2025
 16:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250527094415.4760-1-andrea.cervesato@suse.de>
 <CAEemH2eGQP6k1cSDH42c=ZXLHtXdekDh5H_nWSr0o1_=j1i8ug@mail.gmail.com>
 <81a131e7-acef-4aa4-b1f2-97dc30c45983@suse.com> <aDcNer6dHSI2bveR@yuki.lan>
In-Reply-To: <aDcNer6dHSI2bveR@yuki.lan>
Date: Thu, 29 May 2025 07:17:39 +0800
X-Gm-Features: AX0GCFt_SqBr-Qmtq5W5mbbYFLnoAOPJLU_AsyCh0KeFPLfnnIpoON-NJzz33yI
Message-ID: <CAEemH2dSAfRiDwVLnHRLQ6=7wUCM=sBU11Y06kjhmj=iXvuEJw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TA3oib9wwlewu1tRePxCLYfXoF3_S2-qotJ0tr_tGyY_1748474273
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] kirk: version 2.1
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

Cyril Hrubis <chrubis@suse.cz> wrote:

> > thanks! I guess we can add it to the kirk project under "tools" folder.
> > Feel free to send a PR in the kirk project.

https://github.com/linux-test-project/kirk/pull/53

> So are we going to wait for the PR to get merged before we update the
> submodule or do we merge this patch? I'm fine with either one, but I
> have to tag the release on Friday.

No, we don't need to wait for this PR merge before release.

Unless someone also desperately needs Kirk to produce traditional
logs to be compatible with a legacy system (like our's Beaker).

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
