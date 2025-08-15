Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59963CA0ED1
	for <ltp@archiver.kernel.org>; Fri, 15 Aug 2025 07:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755243292; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=do88wWHANxgOnOMe7C4Hfly7vIbAetmwC/Oza/PFTxE=;
 b=M+KFV1Yma7/jsE2EjaOTq/mF+5yhwEWm9KBwDFqZ01oiqkt6FJnSS3YdlfhOg6ZBOzTqj
 zPby7AEnYva8LYR06R5cokuopgtJGdezd8VZ78a0Mo0WlyppdWZ6NcJKLRFSrCFw3ix8Fhv
 FfWutaRywOsBad9apnyOSIkai2cEAls=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0327F3CBF99
	for <ltp@archiver.kernel.org>; Fri, 15 Aug 2025 09:34:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D90DC3C3339
 for <ltp@lists.linux.it>; Fri, 15 Aug 2025 09:34:30 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 085661A00916
 for <ltp@lists.linux.it>; Fri, 15 Aug 2025 09:34:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755243267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6jr5+jJicmrLlQ9lu6zAAunR60c2EAiTGqLu9c0yJ2o=;
 b=FlypOJ0ozXhu1Z2iPyV+001mEnm9BscRH7UzQoz4Ttan+Q553OZaGaApRolfmWTfapzUqs
 qJX/gE9qacVZIlsyH2Sz7JYIGILbbk/46YykKFwtp6eM/sTDpcr7ydZVqvZst2o/aYm3fE
 cTEZWHfFrPKjO7RNOmc/mSwND7p/ANk=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-t3kLZzRwO1S8wWoyx5lsrw-1; Fri, 15 Aug 2025 03:34:25 -0400
X-MC-Unique: t3kLZzRwO1S8wWoyx5lsrw-1
X-Mimecast-MFC-AGG-ID: t3kLZzRwO1S8wWoyx5lsrw_1755243264
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b47175e6ddfso2738658a12.3
 for <ltp@lists.linux.it>; Fri, 15 Aug 2025 00:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755243264; x=1755848064;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6jr5+jJicmrLlQ9lu6zAAunR60c2EAiTGqLu9c0yJ2o=;
 b=sjBBeVrFY4V4NXnBcMeUd+KY2JAPOGV7ZKDL/nk97Uf/Cjgs+N2HHVLkDXUcXLBngD
 fEhbpDlgwCQgIIrWSTyhp2RyqWN7nEbvSLwV9fxX4DbUu8Y7nqtInRxtC49/OkpdKWfN
 /KpUHXmZjTGawkVPalBdfgaHAFaz2Qk02YCf7YOz0Y2sCU2XXRa2P24qqDIhT7ilqgdE
 KV7bf97522nFZDh5JKVXkmGM7DYWmAmi8KvsX6Ow8GmpKp9Z5Yci+13e11briN2d2ikG
 lGCdkDUkjcnxwKhvtWep01BuWspccdnivilF3BjIPTy0PuJ/kZexvq6WQCR/7wfTXldd
 /vOw==
X-Gm-Message-State: AOJu0YxXkvgXQBio2grYo71dm4SXHBDJsQvWXm2Nt5bnA0xwHEvj0uD+
 JT0f2vGyfkvszwBd/928vManmAUPPD7eGzzFJ7myUwVKOLLvXJwSkD2SiWK0CaAaBbQ1ps76TXH
 qeZfjq+jjzrnQjVOlFUZd6fHC2g6K3r7sygvET3+pEdXNkuIXuBzPtB2d7boH9wg2mY6/IC8Igy
 lb3a7Vfx8NiJosiceY91RCRwKIK8Y=
X-Gm-Gg: ASbGncuhdFwikuohKdQhaC4yY3S7eda8mCDAsCwHqjOUUcgbDf8dhdH86fZCWySkbOH
 AaUPMB9rS/ffy5u+X9s2BOYNWxuvPhL5iavXgcDqTkL0z1NXjQH71JOEi/U06zl2VHeMifboh0l
 SySBys5IpwyJA2AhDa935/yw==
X-Received: by 2002:a17:903:4b4c:b0:23f:f3e1:7363 with SMTP id
 d9443c01a7336-2446d73e7c9mr15307205ad.23.1755243264273; 
 Fri, 15 Aug 2025 00:34:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEadlRpAXd5rsKikVQKNX0/JTcInxWFtotdFW2I8kuGKlVWdgwbaoeM1YaK1BkWavoTonAI6VO3TZeFMEd69LM=
X-Received: by 2002:a17:903:4b4c:b0:23f:f3e1:7363 with SMTP id
 d9443c01a7336-2446d73e7c9mr15306965ad.23.1755243263891; Fri, 15 Aug 2025
 00:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250807062941.348971-1-pvorel@suse.cz>
 <20250807062941.348971-2-pvorel@suse.cz>
 <CAEemH2e1CbqCv8Bq4dJgBoRU2hJ72fPTsHJDYV8oLXRgs7SdAw@mail.gmail.com>
 <20250814131857.GB575710@pevik>
 <CAEemH2cLYOrZkHxj=EYcC3MYvB2cAEUhwF+jL9v6KZi2YvysNQ@mail.gmail.com>
 <20250815061405.GB32490@pevik>
In-Reply-To: <20250815061405.GB32490@pevik>
Date: Fri, 15 Aug 2025 15:34:11 +0800
X-Gm-Features: Ac12FXxTkfVlODHbijCq2bsi4eJXAyZdJ3W0lwUzxR7w81dfg7qe5QtKWP4Xvn8
Message-ID: <CAEemH2csV1oTUqVT4nG4r0YqjTexeymEUAqgp5LrtZuFKA=8sg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dxg6X16_agFFyn9qVz3k-HV6JNxwWCwYrkJuYLwvWB0_1755243264
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/2] modules.mk: Add FORCE_MODULES=1 to fail on
 error
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

Petr Vorel <pvorel@suse.cz> wrote:

> > Yes, but FORCE_MODULES=1 is still make sense, people may not like
> > to see the module's error stop the build every time.
>
> I guess you're talking about the 'make modules' exit code, right?
> NOTE: I don't expect this target would be run in production builds (e.g. rpm
> or other package creation), I want to add it to CI and use in manual debugging.
>
> With the change above we're implementing 2. I'm not sure what is the best.
> Failing on first error hides other errors, but it's easier to spot the error,
> therefore I tend to this variant.


Yes, we only need to add something (like " || exit $$? ") in the
top-level Makefile based on patch v4.

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
