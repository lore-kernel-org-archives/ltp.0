Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5049F606A319
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 06:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=jD/tuhcY;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Nx8SLb7t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792563086; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=MiRS9ApHH+Vnpkx1Muvj5rrjCQu5nHx7/3EfvaukFSI=;
 b=jD/tuhcYOpLKaKFqfc4NZFbU4eB2DR523jpQCW3dskcR3y8EJqPhV/ijOKVwgOTThfaJn
 WEyxKD7jgQ7qG2rk1xRV5H1SRZGpjcfxvuoAmZfEFwSpAdqdmy5tAcXSb2DdKC+sVKQ5X04
 X2JlVTz0sd015PZLfjqaj5JZhWADgqo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 030273E60E9
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 08:11:26 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 013FD3E2660
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 08:11:06 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0AB6D1A0092A
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 08:11:05 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso281121f8f.3
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 23:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792563065; x=1793167865; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ajBnL71mDHoqU9DUuC+MT6TGaevCfinZLm9lAZmUo5M=;
 b=Nx8SLb7tf6SJIW8rpxv1vS5vLnaFcdkcDxziyUs9GCAm/1tKKxwfM3Gf3m2hWet0qH
 nwIVlDv+8XbTC4NXcqIkaqbzyZwzbaIERagw5+2oc6+XwIrmu2QCeOgIQBOtd98twTZx
 gaigi7kLxEUSvYeSfJ0iU7xxUEH0er6wRBvCkGKhLn61ZdhtZHN6OG4wuKLkT2/QSH0V
 vKSU8Cp1owtJVajHc+5l6UC50B0avL8rChRhWk2cZ/04tyOMoIrvVbYFGCwfWqeVVyeP
 ldIucHjFeazdCPFG62ChFfDWbtX9PiLibNO3XpIEeKYkGQILioq4dwn0wDcJgMrDVPSu
 4Prw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792563065; x=1793167865;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ajBnL71mDHoqU9DUuC+MT6TGaevCfinZLm9lAZmUo5M=;
 b=MpD5aZbFYFVRdL/lqOKt4MumuaJ2kfsmMlF6lZhhXBqydgCTH1DOknC68JICMgS5ea
 Apw1fvOFG9rvM2rC4dDqry1B3Lghdr2M3uGsOLJa2wxjQqnBEOoZHJNd4AgPi5Ip7yEu
 U54q3hdZ5f51dL9nXSxkwXYmqTjG8ZYpR3PTi+ohanndzcLm1E5xuAcPYBHJhzOY5AJQ
 rRbgOedNEX0rOS/DEn6XuYv3ip5cdchKMNupXaI4n33SorO8psibqNXOqnf9OcxbUbOr
 gHwD5F5v2zNpZEe51uFshc/gXx4/qm4NQNSu2LNwZwwh6PstgRANKXsLcklE0cAzKpl0
 ufRA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwxHziv8SC3egpAJvil6plpP+I20Rc4PRcOHjZRBlMRulj1GeUYQJcuk/Ki1zyQE1gTKxA=@lists.linux.it
X-Gm-Message-State: AFq9FYLnza0I54tHVJOOacO7V6B2OToNiL+H7OEaOwE0LCREPIL0TDEJ
 u/pObkXJe1RTpbwPxHTmSmMnhphHlO2m1ScJXq4BRlvFOzGkZl7iwbpryM9C3R9aGw0=
X-Gm-Gg: AYBFou1plkUYT8ldERDze3sp4ZNqq5vLHKNLB15RNwJVTeNK526eTmsGaPCyTY3xGkJ
 hYuARld9K2Al8bRpdkxWyEGAcBbmUy1Mfz2w3U8FYKeXtmqBz7DXf//5hzxr4IeWBw8mEBMXI8d
 3+Ws8BN9e0SMLT7DRRwAHV2qoDFqRmljQMg1DDmSSzZTZpyGr4nVbgoRr072S2eE9TQj9WEGmWh
 fcEDRTG5HQI8y6hrdBMaEpMrAcfrsESQDoLFEJSENflBBdW3ZNWgZmW1liXvwON6C4629pL+miY
 ZYGtLuxMu35pHjH+7jesq2F3ZV8Mu0hC1naFX8MZFuxPniMRIziWXYzWkBoGO9p5Lm42c2iIB0v
 tV6Eri7QUW+CooQ9kMWf6MK5nFRpgSRR5J7JU4owIT6KQ0GI1jWLScphCsjL0pd3vbM0IYVz/sd
 Fqt5c82mMKDavW9G587XuZGyo/wdL8wl25pFZB6hnEPvFFmfEynECQSFjSAbgRej0glcRhkGmFO
 YXUa0wmOE/xlmtsJQSgYS4ovGHyTHCiA3Q3nA1rKl7+Dm0lUkSM7F4tCJjAl5aU0jTKpmtnmZFD
 BsZ5hBkOE1Es/Jm1sO45BcOnhtT/MFUsHlzsVbMUB1AlezYITPCwh9C8i09dQhONXEl88NreucI
 DuV8Q
X-Received: by 2002:a5d:480b:0:b0:48d:c186:dcc6 with SMTP id
 ffacd0b85a97d-48e264c49a5mr1102453f8f.57.1792563065289; 
 Tue, 20 Oct 2026 23:11:05 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e54sm3399906f8f.27.2026.10.20.23.11.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 23:11:05 -0700 (PDT)
Message-ID: <d7rm8UWo3R7KsAHmShS9oIyDEZ1qsD79XCNu@localhost.localdomain>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20261020201531.GA154402@pevik>
Date: Wed, 21 Oct 2026 06:11:04 +0000
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] build: Parallelize subdirectory recursion in
 generic_trunk_target
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

> >  include $(top_srcdir)/include/mk/generic_trunk_target.mk
> > +
> > +# libkerntest.a in lib/ must be built before syscalls and mem consumers
> > +syscalls-all mem-all: lib-all
> 
> I wonder if this can be autogenerated, because this was not needed before.
> 
> I'm ok with this explicit definition. Probably in the future we should move it
> to libs/ (using it as LTPLIBS), which will solve the dependency.
> 
> > diff --git a/testcases/network/rpc/Makefile b/testcases/network/rpc/Makefile
> > index 6ecb1a665..8d12bdf1e 100644
> > --- a/testcases/network/rpc/Makefile
> > +++ b/testcases/network/rpc/Makefile
> > @@ -9,3 +9,6 @@ include $(top_srcdir)/include/mk/env_pre.mk
> >  INSTALL_TARGETS		:= *.sh
> 
> >  include $(top_srcdir)/include/mk/generic_trunk_target.mk
> > +
> > +# librpc-tirpc.a in rpc-tirpc/ must be built before basic_tests
> > +basic_tests-all: rpc-tirpc-all
> 
> Also librpc-tirpc.a should be moved into libs/ (if we still keep this code and
> not move it to libtirpc project where it'd make more sense).

I'm also thinking about it. We should move all libraries in there.
Let's see what Cyril says.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
