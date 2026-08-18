Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9198DC5DF70
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 07:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787039524; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=pcPcK1HccrMEqJULArFNwB9uXTAxSxQO0jYG4y7CFBk=;
 b=oWI/ydUstg0dcFVKU2gMLQMChpRs8iYloSViVvXH6txpaCPaZy9EvohbkYxlcuSxhyn58
 aXXDq8HGuqRstGu67cj28+37yrBKz5uedKRCxptav7I+4PnQhFlakKOZh+pIsL7Ye9DkuqH
 lsKNjE8gz4C5YUt+oKmVUlYTZDc5NQY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C6E1D3CC17D
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 09:52:04 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF3E13CBE7F
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 09:51:44 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3593F600697
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 09:51:44 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-476a130c138so4467096f8f.0
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 00:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787039503; x=1787644303; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TlfWFa5g2jP4kP6wN+pvPxCGk6MNIX2YkeHWy1ah0lo=;
 b=BgcJX6mORJHr/lmfQswj/trfmVsbtEPU4wB+9ZpxirqrXgWuA4zJ/xggCNkRUFzsTl
 AZetnA8+tF4V1wBhbiP58znsb2KdCExU1yiFsNZhmSCL4p/tVX0ZKy/i4QVTFVsNUTty
 Z3ZMPCDp24fWHuJ4GPtY+vmQ8zG58Pj8CKJ5K3j1WTQGVE3S3PdwPI5QJEAHrxI1Ld0V
 CtAUx6Sgu1rHPHlqYB0BNGN/YajrsT1vW1MOGaZOMglEYJLj7pOrU+40/Eio3K9Q0N7/
 h1niapJAJ4vU14VWVQ3+2cv1/D3g5QZckYUDTXOgf/jTbTxNbim2P/X5ljvYPNWIWSfj
 NPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787039503; x=1787644303;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TlfWFa5g2jP4kP6wN+pvPxCGk6MNIX2YkeHWy1ah0lo=;
 b=YhlRESGF20sYfgwPvAYMrEzS1lec8EZ87ewtH21nGy0T1RsE87mm/F0gDzS6qGVbwl
 tN6J9IzSelyKKMNWRgK+tkKC3k5tfe+XPUwJC7gj4PVucztow0S1tzOPCyaKta9H9c+3
 fKFXEtfpesCt/WFNb/koRg3CG74ItROTUp1rMVVbjKeIMhF0C4C0gOhOKF0hJufk222j
 pIXyAnCoKlDFtAhI7CE3at79tyiWXeED5DbgGXt5VwMgrRHiIo7UCNueyPHmB7FNDdW7
 6bAypp+wyl/r/5WyWr9Z+jnWs157ORwT6mCtopaRoOD3jCOdTONmhxngm9TLjGMhUgRw
 vKlg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq7aR1GsWBYqBdAj2eans3+uMMbwDbKiKVS1KhehOLeWG8MicGKn69F+Ith6dx2LBodilU=@lists.linux.it
X-Gm-Message-State: AOJu0Yy98KISw0bnIP5IWkJthTSVXA8c4hUj0ZpntknFaKzqf+bYJYRa
 OAGGBFYl/NScEnK2AokFK7Eao2PGKjCJ/Yg9W28JuEJsxVU5JcaSUuwGUdAr/mMDuNzLbu6Vuf1
 x4DzOs38=
X-Gm-Gg: AR+sD13B75V/pmh7lDnumWYl/mHgyb2cOWJHMDEr0j1lS+lxYsnpubmJKaQXEWWTcV1
 IGMEetbmhFAOMSDttEVdEVRRWZt80cja6CjT1vl10zU/HpmeecyqN/EGOP6MqMHq0av+wx3b4KO
 t3GzdC9nievM8BbDLc1x9ureZpp3b7tsyO8YRkj39zCWlQ4OXXACoj8x1hMSGY6WR9IqLwQoqm9
 OoJauAKIg19pV41XTYNddV9xlvEwXxamskZu8XRZHZ3jA8BkA2BMYuhUJzytS1jwlzKzaQRZXpU
 B056ol97V4ewokVXrOaTfOZU8f68k8vexoD2bNwukAZAoWidcw99UiTINo1B8PTO7ihPRLRzc5j
 RLb08KJvBfC2Rn4wJX6MF120MBum4OPYPH1ykSH0l6lkUanIT+sV2jQfDZfjctKnF1KmxRfar16
 WEJnRD4jYfSqRV6OfQYfd8GBvsrZB4RLooubKqWPeqvG9Dk6yuBIf6DZlHTMw2hJfkttrNPM/x5
 fm809ojEw==
X-Received: by 2002:a5d:5e85:0:b0:47f:91eb:342 with SMTP id
 ffacd0b85a97d-4816071addfmr48027672f8f.13.1787039503400; 
 Tue, 18 Aug 2026 00:51:43 -0700 (PDT)
Received: from 192.168.1.121 ([176.206.179.213])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a3b51asm9935617f8f.11.2026.08.18.00.51.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 00:51:43 -0700 (PDT)
Message-ID: <6a840f0f.eb04e794.373edf.fbff@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260814130528.8519-1-linuxtestproject.agent@gmail.com>
Date: Tue, 18 Aug 2026 07:51:41 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] struct tst_fs: Add flag for checking filesystem mount
 support in kernel
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
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

> Hi Martin,
> 
> On Fri, 14 Aug 2026, Martin Doucha wrote:
> > struct tst_fs: Add flag for checking filesystem mount support in kernel
> 
> --- [PATCH 1/3] ---
> 
> > -	       const void *data, int *is_fuse);
> > +	       const void *data, int *is_fuse, unsigned int check_support);
> 
> Could safe_mount() and SAFE_MOUNT2() gain kernel-doc comments that describe
> the new check_support argument and the resulting TCONF behavior? These are
> modified public APIs in include/ and lib/.

This is actually correct, rather than adding only docs in the struct,
it would be good to add the doc also in the function documentation.

The rest LGTM

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
