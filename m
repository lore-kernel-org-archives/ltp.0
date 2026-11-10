Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F264E606A321
	for <ltp@archiver.kernel.org>; Tue, 10 Nov 2026 13:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=lVAxywn/;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Y9XQUx/t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794319148; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=XcFtSxYyqUyoEWZMpD5IfawWfWrcCl2/9fS/KOCndgk=;
 b=lVAxywn/9AMMMDBr5CbPB0KIq+cElTNIJ0uj1tRKuCaBDfulTyYMXAUkuhgdx3Q6F3Efi
 rRfIund1ad5O+yXe5x7k5ezlEtSZd2EwpapHSSbLqMjPQt5bOhR99m8MuFFpWLYVbtew9kf
 TlEXrYmc8xBAB1y71gIbCp+yZKMbyjM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A17E13EA159
	for <ltp@archiver.kernel.org>; Tue, 10 Nov 2026 14:59:08 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 486043CA9FE
 for <ltp@lists.linux.it>; Tue, 10 Nov 2026 14:58:48 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BC7C8200051
 for <ltp@lists.linux.it>; Tue, 10 Nov 2026 14:58:47 +0100 (CET)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-490a0e72588so1108541f8f.3
 for <ltp@lists.linux.it>; Tue, 10 Nov 2026 05:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1794319127; x=1794923927; darn=lists.linux.it;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7fqqc4dVgof8DSD318wktCPIJyhAWp3IKMisE18WRvs=;
 b=Y9XQUx/t3R779129o0yS5KEui+lbzojTm2+suyv8JGM6JPTBnILlmjkX1LY1+Bpdvz
 ROvWk+jyEcfOE0GCBCUH9UBMHLePsTjomI0vT70Ll9ThUqHrhBi040RBYJVim8QLqq+v
 XclYSgJMuQYbthqpbv2lbfJxTIDPnToJSqChSWFulX3wgrqxrp7/5Zvob/S/RgDTe7oI
 egb2545I48jozEWdV2ySLCPxHDohvp2Jgv6yoW4FkJfy5b4qh8HH746i1c9/0OFJCVUs
 sZzkUGlZ87dmMKrWgLIfCu51E5MP53DBzZrNPS7PwYBntEjYmBtQYPNGPmPMVSEyTmx5
 i4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794319127; x=1794923927;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7fqqc4dVgof8DSD318wktCPIJyhAWp3IKMisE18WRvs=;
 b=geQLCqH7QK36o29635M0c7GY6oxG+/215Xz1M9oCmafaHefGhtD0+JgRQvAoYzr0vj
 89/NYmhLID+gu5mtYcvNd6JbnsYoUHXQMvToLN3wV4KdWFewBlR4aDuB/c/UKBOsV4is
 pm3ehs54CAAFNZVTmSwZMX6CYtjOPyPQvgA+HMmYZQ6pJxlKdYq6mAv6GxWO6wJGgT5V
 kpWqTyk0TXpWgVe6yZAyMMYegsh+QQzseLwxIT6/h+zDYeHtgpq534u+hLAP+4pw63Rw
 C8qH2cudAMF41xdY8e2sC4W/Xc6jcdHfQ2PJyKYGptJwXkWaN1Vo7kul1eNpK/tAt/Qo
 Hk4g==
X-Gm-Message-State: APuU4Z9n79neuLmlwGXYwJj1n7hR29fqcoS5+kdb1Tk0KFkrUd5SwArv
 NETgI4Prw+4Bk1M0wqIR4M37jsOPQUOVwwjqtXz3h26uP4ZiLI0hV93vrb2z/Yb+BA==
X-Gm-Gg: AYBFou2ruwzRnkRCzKJ0gs7zF6FuMZfdP2/iYkQKHhD1lqoqygVQrDqplXSMQar/995
 nRBAn/kDSusViFWvocX6JQbPap2SOz9qKY1hvqcy/Zi5R85Am5T962si2sAfbmiq66KuqHd1Ifi
 3zsdbvHvH7GiNKTPguMdSoNsYb1tkdAcQldWWtr/8L6zvnQ6/sXvdjTnaZAX3Z8P4HXvbPkxEB3
 qsceJJhCdUUI9izCuxSMJP3rAxMB4mXEh9VskiiJdkob2Zl3eLWG+vWzzd4cxs3SXS5sononcKv
 pMZZfxU1oexBRzHOqV+F9XBxi50V6/USURysiXKe6UIvdC1mHBU67IopG276iJsOc/0ZR4tm2cr
 Nw/jv+Ryuq1BHZBErfSDb5f0YgofWU8/uRwBXmHTMTfcu/XC92n05AjfgC0hYUNKm2+XlgCRDGj
 E73NL0G9hUPy7WfJBKXVnxZFyZpukz1ex1NB54eBEogx9ZVAY8CvNH3peB09J2c8xIfYUzdvrM7
 wDv0nu+C8eLXc4/6cOWZOkVg1Xh3tpi2/29FE1YbJQRGET2GSyiERcEZkMzs+2bZlui39uGpSMO
 1uH4wJFkAOCJDKLRY5sSTQ3hyoqCefqTUpCRiRQE/By6dmisfzQ7lkq7Zvi+11ee6TdsP/yEIcn
 qjBg/oUuh8O6ESvbYvYeEDHslqXhk
X-Received: by 2002:a05:6000:15d4:b0:48e:68d5:81a6 with SMTP id
 ffacd0b85a97d-4982f59465bmr4121378f8f.34.1794319127089; 
 Tue, 10 Nov 2026 05:58:47 -0800 (PST)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498361f674fsm5130740f8f.33.2026.11.10.05.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 05:58:46 -0800 (PST)
Date: Tue, 10 Nov 2026 13:58:45 +0000
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <avMjFSy6ARu4feXS@autotest-wegao.qe.prg2.suse.org>
References: <20260929022340.524-1-wegao@suse.com>
 <20260930035332.3360-1-wegao@suse.com>
 <20260930035332.3360-2-wegao@suse.com> <autSV7Dh55A_Vz5Q@yuki.lan>
 <avEngNz6aHO73w7W@autotest-wegao.qe.prg2.suse.org>
 <avMFJRfnpw3hbArp@yuki.lan>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <avMFJRfnpw3hbArp@yuki.lan>
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] memcontrol: Add bind_to_current_cpu()
 helper
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Nov 10, 2026 at 12:51:01PM +0100, Cyril Hrubis wrote:
> Hi!
> > > We have this piece of code in getrusage03.c as well, so I suppose that
> > > we should add this to the include/tst_cpu.h in order to make the
> > > function available for all tests.
> > getrusage03.c does not have any CPU binding operation, i guess you mean 
> > perf_event_open02.c which contains the exact identical bind_to_current_cpu() 
> > function?
> 
> It's called pin_to_current_cpu() in getrusage03.c
Thanks, will send next patch.
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
