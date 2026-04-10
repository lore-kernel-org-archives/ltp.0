Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F30F44872
	for <ltp@archiver.kernel.org>; Fri, 10 Apr 2026 14:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1775830346; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=YPoOLOB1gprca3erDJB/a9CxaAqbT6niT2nQyQmWM0w=;
 b=DidCgiwLvMFpmTxfMlu5j8QtRRROZaYLAtCRfOL/lxYp2Qk2I8DI+hYsx8PUpVjX04iiP
 Bm4Caz2JWA5y4St/bP5AvO1Sr9a1tnwd7I2mR8A7SL/f6C33NerAaeZzPcNZhShgLfoda8f
 TMeAj1Ip9Nl2QytKF3skLUV76v7y6Rg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0BA0E3E203E
	for <ltp@archiver.kernel.org>; Fri, 10 Apr 2026 16:12:26 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DEA623E203E
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 16:12:03 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2D2911400246
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 16:12:03 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4887f49ec5aso25137155e9.1
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 07:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1775830322; x=1776435122; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LjUo9JOq3viJvLpTD1ICGPsyst/zYm4aXFwtKBw7eZo=;
 b=HjJCIMMl/Oy4nBvKb/qAUQNjuWv8IIakqXo9HaXEbbD5ZRoOSSh9pNvQBCXcjpEQo7
 pw44p+yH3JPZKUK74Y2ij0g/pYPNjcox0NvjW2fd+6pFWV34NEt7oE24m8BY6vYzkANT
 S4H7C3WkxTEMaB+sWVuh2dQ1S2KUA+dB+ARWJYJdZLQdvJSROfbrIMbZ+yv5olNpsfZi
 LaUX88EpdxS+8+gNgppivHqF1l3iii+eCHdF7DURR1v0GFzSJUhxht1eqLRXFkI4Wcwh
 KF7FUDGtjf5c6IoJpFKNFbXYIOrlGKBwVjwO6PSI0n+y7cvIHXJuDuZs7mE3GprRQTZ5
 MZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775830322; x=1776435122;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LjUo9JOq3viJvLpTD1ICGPsyst/zYm4aXFwtKBw7eZo=;
 b=s56ebBpTXYR2PVWilzDWtGXOMRhJah+nsqKVai16BVRDaZxqBnRnpVSf0ZX4nb4BM5
 zScBPdX8yIwHP+Ko/eGBsZa9XQ5f8mwkkda0np7QF0556+03GjOoHW6ndrM3CtMQaPE3
 3WXlKgAGan4o27FMURFfQA35qEiCmrMODTX2HGzMqRruYF+Zqlcecm+DNjLklPOmnEEP
 RdJEdxb+b/4UVCGWrgCm/9IvxVfbjnYgEkKJUf8IWABkKVKIuCfMEAosbnvFR8igVbIo
 EdKm0cFsFlU48GkKXmNVYZY7auFIhrwcIDsTIygzX4JNewrIbLArLCRj6YQnXnQvNeMh
 qD6Q==
X-Gm-Message-State: AOJu0YyTSB5p+OiwJApqIcoi3ZriZXNpuNr9lFMP+fbrimfYiZ7bEoBP
 Gk9MvEUH+flKbuQ15MSf7W/jxEO7L7msScUTAhOJsJWUOfB0Hvj58YDNg7RhIvmcGw==
X-Gm-Gg: AeBDieuSZFrztpo3Rd1odO8hpMWBxO0tfcNZF+Dbdp7XMDcOVcjaptCXgWueyjT3WEr
 uT4X63ZE+/ho94bQZTJ68D3+Vp8W1wDEH3ZlKHIlcxxLVqdMKkq4GZYNDjAhHw2PvKrzZIUPARk
 RBikjnxvQR76LMT/sb7rMfLl/KeUOCaRotjDiiDDkM29rCVPpi0977pZin8m1lATazPf+bSBGlq
 AJL/27reWyvoiE4vbxDoFvln07SAg+zycodt2KsJZivbBQcL1Ug0X4AEkQ1P91p7QiNTTeV0FNH
 p6QRVQtydQINOUywnQ1hNdyUeMJ6G4lKB1XACiVslnfnYb/APPlElVEmCeBOcchNTPhmHqe4aUD
 s6g01+W0U6TuiyZ+D3s+UG1/KQZht6tYIvxkEnt6P6DojWRovMGIrsL//0Im7n7iGZFdPBuuy7V
 BuaRmu7B2JnYGnC0ReRjCqOkquJZ6BHvhZ0RKeJGt6TDxzIQgG0fY=
X-Received: by 2002:a05:600c:820a:b0:488:b675:360f with SMTP id
 5b1f17b1804b1-488d6889a6bmr38974575e9.27.1775830321882; 
 Fri, 10 Apr 2026 07:12:01 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d67b128dsm35629175e9.2.2026.04.10.07.12.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 07:12:01 -0700 (PDT)
Date: Fri, 10 Apr 2026 14:12:00 +0000
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <adkFMHufCHMsp0u1@autotest-wegao.qe.prg2.suse.org>
References: <20260407092616.15563-1-wegao@suse.com>
 <69d8f7c2.5d0a0220.1f0e56.6472@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69d8f7c2.5d0a0220.1f0e56.6472@mx.google.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] shmctl03: Fix 32-bit compat mode failure by
 forcing limits
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
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Wei Gao via ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Apr 10, 2026 at 01:14:41PM +0000, Andrea Cervesato via ltp wrote:
> Hi Wei,
> 
> this review is pretty accurate. Please follow the suggestions here first:
> https://github.com/acerv/ltp-agent/actions/runs/24074831444

I will update the subject line and use INT_MAX/UINT_MAX as AI suggested.
But I'd prefer to keep TST_ASSERT_SATURATED_ULONG even without a current caller,
as it completes the logic for the helper function. The logic is clear enough
that an extra comment isn't needed also, if you are agree then i will sent next patch.

Thanks.

> 
> King regards,
> --
> Andrea Cervesato
> SUSE QE Automation Engineer Linux
> andrea.cervesato@suse.com
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
