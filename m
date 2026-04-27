Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E00FF8860
	for <ltp@archiver.kernel.org>; Mon, 27 Apr 2026 13:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777298274; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=AW6Te2sVuC5z2PyAnF2speL5wzeL9pisHIuqu3m+uDg=;
 b=XF4KSkPgx/A9jnc1KTgx2KJT8qGqOYWoSfXp7P3YDbRFBrVFHmxQ9zn1tIuJoKxnl3BjT
 H/jAxe6Uw/CNfg7g2RJ6I06LGXmCPtfg0Hy2xKz3ggHV8HY52BSnU4A1XZ7dSyuYlK57T9b
 OMQ96s1+FxOeOKueytD5LNfXJUseqZA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C67533E1604
	for <ltp@archiver.kernel.org>; Mon, 27 Apr 2026 15:57:54 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E3C43D2269
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 15:57:32 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C7258600211
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 15:57:31 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48909558b3aso102997465e9.0
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 06:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777298251; x=1777903051; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=V0TaIKLt2UcSOpC5+w/3/jLqoCewF7OgHKoRcvCeGRw=;
 b=ZcptoQPtl1KiHMWRJCbtasitlTYZaO5cagt9F3xt4O1NvcYlwZQYuu0WlT0togRv2M
 eqj2tKh3WoJaKzun2HveMn/mHt24RoGZsWfNwmtwPvakiy+/BXlxFOzo+HcVROA2U6db
 4aS6wtB79RL2mPV1rT+VK8975xOSt1ndfSKwSfiGGtjo4HckQwoETkna+t+DuHfJHbMb
 uZMsGTaMKINv7bhKawevWODymVdnOjDIjLErEGPybjJHkoBmrKdDunSwPJRk0ip6JsGX
 yDDBqVCPAu/oDewjYaBR4tptV1Vz3QvI/WcEd14FNrPnTh45+u8f//wf7uVBNN6AmKty
 +GMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777298251; x=1777903051;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V0TaIKLt2UcSOpC5+w/3/jLqoCewF7OgHKoRcvCeGRw=;
 b=ZtZ/zbN5JF9B4Obd1l6FtPJ92QuNBCw+vcXC/2I9xjz41zBABCnG7drmGttgFUAKie
 NcDJMhEKAxH24XKM2NSuh59nQN9bjnh+U0rvyMJHLiCJumsZrqOxrYMlZkMdKm2TH0Ok
 1FY23O9kmmiH9UmJqcLLn0jpG01PWb3Lhbi8/nC+cutayoOfm80cyGQVxBnVoUyQopZY
 KIsSZ+l1bhKBsBhOXMKXMFF1X+hJ2kILeAYweNFVsNfMx/Wnqjl0RoHJDSWLM8ntyXLX
 /RuE/m81iX1awGWXVveMcWZVbJQdpru3Y+IQFUjWRlgvKQ/QGff4cR1jYOopuHHERxHf
 7SDA==
X-Gm-Message-State: AOJu0Yx681pl/Z4fDpk+mXYXr1QtSqyOEeY7QoGafDix0V7D60F+dZkH
 D9+hWl1e7NPBcSIrQwnLShhStjFNYNjUjk24AJorBTGiWJyiIg6aZqVkxiuOsPd1hQSNCYWneJ4
 yb1k=
X-Gm-Gg: AeBDiesGeZgs6gGOaLkyvXG5dGaOR1/iBTMhhgjoCQg9Y2dnkFpp0CeT5yG597JPHH3
 FC5MurJMilvesynEbBv02jW/7JFKA4wFaYlFtaxtub6lAZcrJLXr5pNwNWFXEOn4src2MUawt+4
 dGwmSO29m1Hj/C2CnhKKjg9Z8k6w43tbqe6T1wso70K6jVasofEEW0u0hKoqLbwjqW6uv4V+it5
 26EkWRp9q8KtsvS2bbpB+gGyGm+lzUBOFvfi5wQEgfrE4c0t75IoM0xlXyT5hP1Ts062Ehmg9Yn
 NLvVKMRsMHcQBdndnrvuEQBy/83KwK7EEQcBZ7y+UPynUW5oJJLc2Nsg+6CgfogxX007hvIpimq
 ZPkKj8jKLosy2DwAAaLx5tpit4UbS6S+IkstdlhD86/wMtyZZghrys57aPu34uvAhpXx65SPS2n
 eAVbNjmmTa/lQv80rVJjxEvpHlhpIC4Rlxpo064QL3Cex4WKyNup4=
X-Received: by 2002:a05:600c:620d:b0:489:1d23:4524 with SMTP id
 5b1f17b1804b1-4891d23468bmr477989625e9.5.1777298250873; 
 Mon, 27 Apr 2026 06:57:30 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb7ac6aasm253592015e9.25.2026.04.27.06.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 06:57:30 -0700 (PDT)
Date: Mon, 27 Apr 2026 13:57:28 +0000
To: ltp@lists.linux.it
Message-ID: <ae9rSG-1RT1wIcCc@autotest-wegao.qe.prg2.suse.org>
References: <20260427115941.31945-1-wegao@suse.com>
 <ae9V2BKpMIFi3nnK@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ae9V2BKpMIFi3nnK@linux.dev>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mmapstress06: TCONF on systems without swap
 space
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


> Hi Wei,
> 
> Wei Gao via ltp wrote:
> 
> > mmapstress06 is designed to stress the mfile_swap kernel primitive, which
> > manages shared anonymous memory. On architectures with large pages (like
> > 64KB on ppc64le), the test's hardcoded request for 32769 pages results
> > in a ~2GB mapping. So in suse test system configured with 2GB of RAM and
> > no swap space, the test will fails with following information:
> > 
> > mmapstress06: errno = 12; large mmap failed
> > for this test to run, it needs a mmap space of
> > 32769 pages
> > 
> > The failure occurs because the 2GB request cannot be fulfilled within
> > the 2GB RAM limit without swap backing. Since the test specifically
> > intends to exercise swap-related logic (mfile_swap), it should be skipped
> > with TCONF when the system lacks swap space.
> 
> Since we do have MAKE_SWAPFILE_SIZE macros, I guess we could create
> a dedicated swap-file for the testing on those system?
Sorry forget mention this failure happen in our Immutable/Transactional 
systems test (default disable swap), i am not sure enable swap force do 
test is make sense or not.

@Petr Should we skip this test for transactional system?

> 
> And, it'd be appreciated if you can convert it into new LTP API.
No problem from my side.
> 
> -- 
> Regards,
> Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
