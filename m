Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C518EB48EC
	for <ltp@archiver.kernel.org>; Thu, 12 Feb 2026 09:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770886901; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=DZrSlaSbJHm+C04Ic9qhx9fFyWrPc4ZRJlQE9Ukly8w=;
 b=fTzAKd7Fztals+hqvzBVVVi7IOIH0AW93B+Be3Y4F7fiKbmawgVNoWhRKaqxbeAz3sQKZ
 sEU3rmDEsacKe39SNVafKph/5xrmGK+McCKkRUQYkXYzKIID2oOHpw9SpZaqo9Y9g4hpFrl
 2wL5j104SWm2QDrr5KEojSpXltncr88=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 92D693CF1A7
	for <ltp@archiver.kernel.org>; Thu, 12 Feb 2026 10:01:41 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2EC963C4F59
 for <ltp@lists.linux.it>; Thu, 12 Feb 2026 10:01:17 +0100 (CET)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EFA471A003C3
 for <ltp@lists.linux.it>; Thu, 12 Feb 2026 10:01:15 +0100 (CET)
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-4801d7c72a5so48861465e9.0
 for <ltp@lists.linux.it>; Thu, 12 Feb 2026 01:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1770886875; x=1771491675; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eOB2zg41iTrO5AF2FykLcqcrlEGGPFweAzuVTJPXE88=;
 b=cggBaNcrBEhHg/9ixytH2wLDNnpSAdPsROld2sz75EfRO180Uj3PFEt1mYiO6//T72
 dt8vl1FiSldRfSRIuOQqq/JmAQqzUEywiHyiWFA0TB+54V7dHWZB3F6Dt38ycWbpNYSS
 1pw++HWvPLT+yvpCsHgXu5sEaNxN12RCsBcic3AYyPG+/T8QvmDcbzQ6lGQtm4x9V9fa
 6prMSgMW2xTnrWANNve+ChyV4h2d5UPJIXSgNRyyDW8JwIHb2Oenw1k6L4Y2CGyuqldG
 L5GnctlAOhoagDLajR2aourN3akpcjBXc0plfxAazRy6/wVEqX/4rduRRs1kECwL+uNV
 zE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770886875; x=1771491675;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eOB2zg41iTrO5AF2FykLcqcrlEGGPFweAzuVTJPXE88=;
 b=vcroN4pgzJvHLFNflgpW0wS9HwlpzMvc1L4juhyrTU60nuxJ+65YdsN2Ms1jJ7Yoz9
 LALfYbTByyMK0DjUvQrvvzMRnoCKK8VhsTXI+KGF9ckEQUQYyUwMdVBR0vjK7zsz7UUP
 zktQoI9ScYXYjV5Im3tXl97hsN/Iz4bSVCbs8JxSnAS1zNEMxgCPhmAGu7W4ocalTvOb
 I14s1qTUfSImR1/nOTKmBLqEAKZR7MjjRuomyGxFXGCCzbaQN8j4hh7DGzD2BeWeZMx/
 AOxpUin8CV0QMCzwZp8CdYr0KILh43oMiG+viOCeuBcBfZFBnNIK94gNsBcAODt6alvf
 lQng==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG+vI4K4b6uX1H81EOSS7xkbn1/XwwdpNawoTlTtzfl9bb0IZp/vAPXWwwtoDfpevwAqI=@lists.linux.it
X-Gm-Message-State: AOJu0Yyaym9up15Nh5swKcOuNsuAOZnxZ5I96TdcTVb+Q2R/WKlfC1H1
 78UQ0h9a8xe/bNbCIYXPjPNJZeONkKWCas4LuSdap/3P1giHKJnB/CTzsQYNDK7rFds=
X-Gm-Gg: AZuq6aLDylnjdVsdE3PMql25VwEIFDmK1KJUukJL+2VNxESzne+0g48t9S4znNppi9A
 FApLs9ZiQqgCeh8ykPwEbYF+2hzoOfxSXNoo3R2q0SpjkrCRO/S4DPWEfV2Pgkhz92HN4KMWPIe
 hZVfLYH/OnhnRz91BYSmJqG5j/jxIOKXIAUgk/4cNhn2JGY15LL2AA70FhAq+KUtSO2rrBpSE30
 tMsdIbnB4daFjkscJuNvuvzGwcco1t4me0xby8PF9L7R4aHG20avDk0IIzO0RxRdtBKxA2HU14E
 4gv1cXYBU3eeSgz97BUkuT6EziomlD+F59wxyK1+mIO8G0vgcRpZUjPhgkBqzcFIEb+reaJbR9o
 vn35S2dXZzJlszy8fid3sG6s355Kjv43KIkipwsFSuI9F77l5pDSxe/nRQrd/cPQSMNCFA0iYPY
 M2IruJ6a1RsIpvwxqgaiQ2s36C98wS5sEywwkelLe4XQ==
X-Received: by 2002:a05:600c:540f:b0:47e:e20e:bba3 with SMTP id
 5b1f17b1804b1-483656aba84mr31674205e9.7.1770886875076; 
 Thu, 12 Feb 2026 01:01:15 -0800 (PST)
Received: from localhost ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835ba69255sm37087445e9.10.2026.02.12.01.01.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 01:01:14 -0800 (PST)
Mime-Version: 1.0
Date: Thu, 12 Feb 2026 10:01:13 +0100
Message-Id: <DGCV06VWH5W4.2S96MUIO5X4ZL@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, "Andrea Cervesato"
 <andrea.cervesato@suse.de>
X-Mailer: aerc 0.18.2
References: <20260211-fix_doc_build-v1-1-42897785e0c7@suse.com>
 <aYyrcqnGWKhsIUej@yuki.lan> <20260212084804.GA5659@pevik>
In-Reply-To: <20260212084804.GA5659@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] doc: fix documentation build with latest
 setuptools
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu Feb 12, 2026 at 9:48 AM CET, Petr Vorel wrote:
> Hi Andrea,
>
> > Hi!
> > > Force setuptools to version 81.0.0, which is the last one where linuxdoc
> > > still can be installed. Also, from python 3.12 setuptools is not
> > > available anymore when creating a new virtualenv, so we need to force
> > > its installation to ensure that documentation will be built.
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> +1, higher setuptools version is probably better as it's still working on the
> oldest distros (than 68 version I added in my patchset). IMHO it'd be good to
> add (before merge) a comment to requirements.txt that it's just a temporary
> workaround (once linuxdoc is released I'd upgrade it and remove the dependency).
>
> Kind regards,
> Petr

It's not a workaround, we need it because python 3.12 removed it from
virtualenv. It explained in the git commit message in my patch.

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
