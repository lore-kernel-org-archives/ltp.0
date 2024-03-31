Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B296C6FD1F
	for <ltp@archiver.kernel.org>; Sun, 31 Mar 2024 02:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1711851349; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=dk5o+cJ3/XCNraBIJUVmbs9TF6zNnQ0Mkq/5wf9zdWU=;
 b=Xa29vtC0Y4Zd7jsLwq3fy9Yt1zOHc2ED7gsSLCluReqqoNXgFHaWMTKZ0dNa6LVA5ehqp
 4b6OJ5zfu1L043yXkJi8fHXxVgtQWLWT+cJJvg+YyhaM2Mj+raNP8JaBxJxPRnQjbVb/GRU
 vR+f0AP++IWmfy3CiL/67fwDrzdZkqc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 387BB3C760E
	for <ltp@archiver.kernel.org>; Sun, 31 Mar 2024 04:15:49 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 61A1D3C0185
 for <ltp@lists.linux.it>; Sun, 31 Mar 2024 04:15:27 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1CC04600F56
 for <ltp@lists.linux.it>; Sun, 31 Mar 2024 04:15:27 +0200 (CEST)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a4715d4c2cbso402986566b.1
 for <ltp@lists.linux.it>; Sat, 30 Mar 2024 19:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1711851326; x=1712456126; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZZCXvPBYNRKtW/NyPvGy93hG/Bg/JMDylPo4t32vm38=;
 b=dOs9sBxNNh18AtTVU04h1mSdE4Vmtk4RIkO9TjeCinYZ2EN5pJeg95glXKXFKpY+vE
 UdNCEuCyJzT1TCtTVW9JVY3OP7AMe031i8wLz6juGJ1BumtgSzeWTOBKTdVSgR+Auqbd
 CJVuafbQO05AqlwA6MZqwsk3dCDjLvQjSnxH0/GhMubzI8QY3BqcAGEs4LicVZLgSMhN
 b6uQl8GW5KQbeJMJg9UHt6r99zjkvpppfdqzvFLv+TM46BUKH2BrJI7xCOE1HEfNTYG5
 SfP0mMKt0EOXpVivSv/SV3DrSLbeMVcSWxbht2Ml5yP8Hsy9SKvVCRDZvqTSqVveGX5u
 YFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711851326; x=1712456126;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZZCXvPBYNRKtW/NyPvGy93hG/Bg/JMDylPo4t32vm38=;
 b=RkFpB5HFXQvoBE2TuT833XwqbO5LlZfYG5KxfL7uiXDG926/P2mlNp8MFgFOGo1E1W
 YHa/dRwlZiPWYC5pkuVV/FDu7bLsLiNr0clGf1VAc+oF+izAcnN3tcLiiEtsspBLGpnB
 Xc/lbmofYeK5k53qrglqj+op4S2t+lGOKKyAe+rRs3MsqAvlvtKGzdwSvBmCjBUva58r
 GRgCjkdmY/VntSCGd5gm4MHUMEU+IF+c/d+/XVP9VNbhJc4auIsFNKBMpoS9wBgoZMJc
 qVGk0i6iTr3LOL8cyuOiF6oDhgqiEoR8yNfbsYOuALsHggT5C43V7YZvcUEn1xhIrf5P
 dkPA==
X-Gm-Message-State: AOJu0YwgyDTIL/vUh/FrRN3gXwHwzRuhEByqp8GH75a7N8Rq/xjTro8u
 SaY9//WvbXsawCgMKsp4KQmlHrYSm+pJng0uGerNhBZWjjQpKLqfTdUSbgRbcg==
X-Google-Smtp-Source: AGHT+IHuF083jASzv+PUmZIdJSyJ1Q+EKUNUeh+EIbCwvQqLUjYTbfXxiRktI/12ANRHqwzFxvgP+Q==
X-Received: by 2002:a17:906:2699:b0:a4d:fc83:70e1 with SMTP id
 t25-20020a170906269900b00a4dfc8370e1mr3696196ejc.56.1711851326477; 
 Sat, 30 Mar 2024 19:15:26 -0700 (PDT)
Received: from wegao.26.237.218 ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 i10-20020a170906698a00b00a465fd3977esm3720899ejr.143.2024.03.30.19.15.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Mar 2024 19:15:26 -0700 (PDT)
Date: Sat, 30 Mar 2024 22:15:20 -0400
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZgjHOCJ7nXXaZ170@wegao.26.237.218>
References: <20231018054357.29035-1-wegao@suse.com>
 <20240118073215.10026-1-wegao@suse.com>
 <20240228170729.GA1618063@pevik> <ZgZ7swC75rxF9hFq@wegao.21.28.32>
 <20240329213239.GA159482@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240329213239.GA159482@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] ioctl_fiemap01: New test for fiemap ioctl()
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

On Fri, Mar 29, 2024 at 10:32:39PM +0100, Petr Vorel wrote:
> Hi Wei,
> 
> ...
> > > > +	fiemap->fm_flags =  -1;
> > > > +	TST_EXP_FAIL(ioctl(fd, FS_IOC_FIEMAP, fiemap), EBADR);
> 
> > > I get on Tumbleweed with 6.8.0-rc4-1.g9b23bf2-default EOPNOTSUPP:
> > > ioctl_fiemap01.c:52: TFAIL: ioctl(fd, FS_IOC_FIEMAP, fiemap) expected EBADR: EOPNOTSUPP (95)
> > > What is the missing dependency for FS_IOC_FIEMAP? Or is there wrong fiemap use
> > > which causes that?
> > Thanks for your test and i also reproduce this issue.
> > This is caused by Tumbleweed mount tmpfs on /tmp and tmpfs seems not support fiemap action.
> > tmpfs on /tmp type tmpfs (rw,nosuid,nodev,size=494452k,nr_inodes=1048576,inode64)
> 
> +1. You probably knows that you need .skip_filesystems, which works even
> .all_filesystems is not set.
> 
> 	.skip_filesystems = (const char *const []) {
> 		"tmpfs",
> 		NULL
> 	},
> 
> But actually when this is filesystem dependent, I guess .all_filesystems = 1
> would make sense, right?
> 
> > I will sent new patch for cover all supported filesystem.
> 
> I suppose you agree :).
Sure!
New draft patch will try to cover all filesystem.

The new patch has one more thing need improve, you suggest print_extens
only on failure, when i start using TST_EXP_EXPR i can not get return result.
Any suggestion or example code handle this in clean way or we can keep 
current implementation?
NOTE: print_extens currently control by TDEBUG.

Thanks a lot :)

> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
