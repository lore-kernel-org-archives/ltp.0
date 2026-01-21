Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155E4CA5FBA
	for <ltp@archiver.kernel.org>; Wed, 21 Jan 2026 04:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768968900; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=R+eX2/QsWK1sYvtwX1/ZI7Pm8NaX+PiPPGdYqX7KCPI=;
 b=gg+rGiiVHlgNG3ynZiDg1Wz56QWbO+M4TJ2PeEY+H1FXfm3j2U8eiT0m9RbggpaqIJKpX
 TznSlSSXfD6myw4Sr/A788StCDTSGq27hq/9YYyNdoZufKUqwF6iKP19pYygpvrTdNkBM7o
 wNDnHUk8bBBeaTATa+w7+EmF3/b+Fws=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8357C3CB0D2
	for <ltp@archiver.kernel.org>; Wed, 21 Jan 2026 05:15:00 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B0F13C99DA
 for <ltp@lists.linux.it>; Wed, 21 Jan 2026 05:14:37 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6597E1000403
 for <ltp@lists.linux.it>; Wed, 21 Jan 2026 05:14:37 +0100 (CET)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4359a316d89so198904f8f.0
 for <ltp@lists.linux.it>; Tue, 20 Jan 2026 20:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1768968877; x=1769573677; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3AofvspUHCWuZnwBYeM/tBP6Y4ww0Q6MC3fu/+4k4nA=;
 b=eXoB/kzkfNLTtxeB9O04lPwdWMHxD8OSaXSHmXD/w+A/7H0L7DVbQAybdeBtt5cdTu
 KAqiMok45aYK1ysEvD9GFtafrIRwtXCsmfX95Nf56XE7U8OLeKAvvAQQO3563pMWJaBG
 +QOO+zFEoVGesfC5K0OnGzCeXbIMjoEalzoNNlgse2rUogcK6LhOl8jJbeOW8dJ1rrSN
 3lirwXt0qqK+90yc5y56uHhXFGmQA+Kc5b4KTLASXRJcimpCw+fMMhyLlck8jIWabk5F
 rQ7zke5rOZFEoUC9PeEEmJyiNJfF24l6YiLt/IXIkQoa0SAQ0baBlgVOvJAZUQFWvKGS
 GqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768968877; x=1769573677;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3AofvspUHCWuZnwBYeM/tBP6Y4ww0Q6MC3fu/+4k4nA=;
 b=OeCxYbK1ZM3UqNTy0yIakyQnZAMPrZwvyc6FYvuJiKnE24P0tslNtsqlfpxXrXui11
 bukasIgeKqN3mV+xxT3CW9Tux7rGsfJsKqhlleRKpSiPt8v0df0uiTI31gvf5SO5kma2
 gC4+Qaz6LccQgSo9XDw2i5NtROfOA1VqutnHm2Ch1v/oAwt3741wi9Tul2ubUq4KfMRh
 oeNVygslRPtfh5PE9YcUPi3iOaIzXN4W/sC1R7e1h0y4HDx+ItphGOcf1zYO7ZtlNAeY
 u7hx2kAv7Xovtl7CMQmU6QnxNn7ydyr+Yitg/o+/Hnh5v045j1NIUYBNH1lkngZ7V2J3
 vzWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxN8pUpW6e4SUNcWdvYZelOfPMI6caUqOXw0XZ/f6PXjTsXEJvsXX76wB+qfBgMtOrAf4=@lists.linux.it
X-Gm-Message-State: AOJu0Yzx1aPQxAskSq2UBMMqAxfM90O9hOZAs4EJVcyf2CnU4+KCcbGd
 5mMG4o28ze6LwG/0cZfGgb65XZ5SbDflRA8WbE8SND/1a+TAqkXVPfEGwsEVyPzjQA==
X-Gm-Gg: AZuq6aJHRwQiYg6nGndknXwbtZnInxA7dOsI5sXlu8uRPa1GJ/c0opeVydCOHQIcMI9
 JDIVLT7lRAJCXYi/pximVhQ2Y13D9aCEG789/U0/eLYyi6wL7pIeukePXvrdWK6+iAmmalPbId9
 O+MfoTdPJQINi6UGGpdepDKia3pNO8ItenrWFdaV0wcQv0FlA73UaBtlk5SZELij4DMgeAScJkY
 hK5y6XhDm2+mJJd0YQBFairg9vIFvGW5J7AoMdWvtvi7AMhrBeI//1Gr9H9dbgy0kVo1gddFYXa
 dh7SEKMwGCguWhPNYZJsgbIji4vZ+mrafSgNnH4vDNkEdDXfATOZmu2OcXJmD6FnEb3EQoxw7FF
 O80aLd68vmHnVEtrVvhZ5y5uE5/rdMiwG4VfqHC5CC7Byv1eEcSY4kJlcnLO7bWTOO82tekBJ3O
 vI8H7jdqulr32fA22wlCB0pBkuEgQD
X-Received: by 2002:a5d:64c3:0:b0:432:8504:befd with SMTP id
 ffacd0b85a97d-4358ff56818mr6138514f8f.32.1768968876770; 
 Tue, 20 Jan 2026 20:14:36 -0800 (PST)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996dadbsm33169509f8f.21.2026.01.20.20.14.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 20:14:36 -0800 (PST)
Date: Wed, 21 Jan 2026 04:14:34 +0000
To: Li Wang <liwang@redhat.com>
Message-ID: <aXBSqvZ8OVP39wd9@autotest-wegao.qe.prg2.suse.org>
References: <aWmqFAzdtsR0t5aJ@autotest-wegao.qe.prg2.suse.org>
 <20260116070708.GA556902@pevik>
 <CAEemH2foRNfQZt2mFRdR364=xB8db_qjd36pM_ce+EKpJOAhkg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2foRNfQZt2mFRdR364=xB8db_qjd36pM_ce+EKpJOAhkg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] clone10.c failed on 32bit compilation
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Jan 20, 2026 at 09:13:25PM +0800, Li Wang wrote:
> Petr Vorel <pvorel@suse.cz> wrote:
> 
> > FYI the patch is invalid. It should have been:
> >
> > diff --git include/lapi/tls.h include/lapi/tls.h
> > index a067872e0f..eee77899e8 100644
> > --- include/lapi/tls.h
> > +++ include/lapi/tls.h
> > @@ -64,7 +64,7 @@ static inline void init_tls(void)
> >         tls_ptr = allocate_tls_area();
> >         tls_desc = SAFE_MALLOC(sizeof(*tls_desc));
> >         memset(tls_desc, 0, sizeof(*tls_desc));
> > -       tls_desc->entry_number = -1;
> > +       tls_desc->entry_number = 13;
> >         tls_desc->base_addr = (unsigned long)tls_ptr;
> >         tls_desc->limit = TLS_SIZE;
> >         tls_desc->seg_32bit = 1;
> > @@ -72,7 +72,7 @@ static inline void init_tls(void)
> >         tls_desc->read_exec_only = 0;
> >         tls_desc->limit_in_pages = 0;
> >         tls_desc->seg_not_present = 0;
> > -       tls_desc->useable = 1;
> > +       tls_ptr = tls_desc;
> 
> @Wei, @Petr, did you get it to work after trying the above diff?
> Which kernel did you use?
6.19.0-rc5-gb71e635feefc , above diff can not work, just some try.

> 
> Unfortunately, neither of these methods (including Wei's method) works
> properly on my kernel-6.19.0-rc2 platform.
> 
> And no matter what method I try, the child process still cannot switch
> to the new TLS. More details see I posted in the pre-thread.
Yes, i guess we are still blocking on i386 scenario. But we can rewrite
parent TLS's base_addr instead of switch new TLS, this way is correct
base current kernel's logic but still need further implementation.
> 
> 
> -- 
> Regards,
> Li Wang
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
