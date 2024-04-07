Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2C9CD128A
	for <ltp@archiver.kernel.org>; Sun,  7 Apr 2024 23:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1712532748; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=RWttqsfl7hBQTieg73xRFgpuzBN7aMRklOcNGP9l2b0=;
 b=cjX8yYEhYK8spt4u0G8Nk+prwEd9mA/yhBH7tcgySqdUHPk5JpwTGBMWU8jf6flteF+b5
 gax0Z9GlDwqGQ/AEIjqxGXtGoHazTFRT6SdnJkj0f7krckHYmp08vnbWeFqPy9CwoJ8O3rR
 md8AEAY6qOiqghfwmMRG/XyDhqUeS8A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E00D3CF430
	for <ltp@archiver.kernel.org>; Mon,  8 Apr 2024 01:32:28 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C92593C0F53
 for <ltp@lists.linux.it>; Mon,  8 Apr 2024 01:32:04 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1FA861400F95
 for <ltp@lists.linux.it>; Mon,  8 Apr 2024 01:32:03 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-34175878e3cso2865234f8f.0
 for <ltp@lists.linux.it>; Sun, 07 Apr 2024 16:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1712532722; x=1713137522; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WmiIX5c42gEylpCP0w7KS2gLaKBJvXviVxQUBH/2HnI=;
 b=P5T5h1QQZqsbanVkDCrDi36VXrzWZ98M2k0Fam8IvS+hhQmoIt0A6cLJxS10OGV5N9
 s2X5N69Ipm+Iuau796InkE8XWmQ31F+IYCtfcw/wMJqckQzUcu3ZpDiRI3HMAW+n4bXU
 2cimaOBxqMeCeV3R/veRIgmqCSqb0NYuHZ0cXJNZF0UgvJRFP7g5cKYzicb73vh4AZXG
 9gDZqYNEgMTkkiJQh/yGr9c1KTBcsG1nKvi3hSnJvTAe59us5gmG8KrP7PTYwyAN95WG
 pYXSLoPWZ/TKiKg57CwWo18DJL/NyOmxnRfXt7Lw7TlderprVxF2e9PuSiBEapwynhs2
 UQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712532722; x=1713137522;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WmiIX5c42gEylpCP0w7KS2gLaKBJvXviVxQUBH/2HnI=;
 b=M4WvlL9tY/DwcZ+BRz6sh+cTc/4PiNCiOnIEUyF8eWtay03djPWa5MIuLlODF993Tr
 KR1bHIlol1uT+cdJTYuseER3gTa84qznmDBWrdFzSupX8WaEMclOh4qQk5pebebO8HUv
 61WlV5xPpRtx8TLR356FxXeO/c6lK2XB5V/uI2bSms50aVcDBlu2b0eX77TGyFslBDsd
 hgh4s9Q+Uwo881VKH+rmxVXAsWQugLgLfx0vkIeDK963z3rxTx5i0L9DXttYaVj+aOWO
 kR1lbI+n047+bEWZMx9WPBuDFqBEF5YYsB53OpSV5eg01gd4e7ddZA57VQp4F+Aj29Ps
 XNww==
X-Forwarded-Encrypted: i=1;
 AJvYcCXx+rW1lTJuLwc5rOvYsJmKNdLr2kopkT6nistwZwUA8K9mrmno/QmxLOdogA8DRDcsl9iPLzjVnrSCGHqkHqTkz3A=
X-Gm-Message-State: AOJu0YydeANpb4Y19XeujyMnW7Ai/Rena10i2nTwuV5L8biUqHZpx6h2
 PyWeMOzhdw4bdpUJm0c69+f9Uo8dnX2MIm3j2lSADaqyLdpcjibpKEqkD+JsQw==
X-Google-Smtp-Source: AGHT+IEtYpW50yZkM6msopYclv7yPYhWSAx6kA020FarZDzL7CaXPKDoJGb7B4ON9aTQOtiy0lr6aA==
X-Received: by 2002:a5d:64ec:0:b0:341:7656:d358 with SMTP id
 g12-20020a5d64ec000000b003417656d358mr6192094wri.38.1712532722449; 
 Sun, 07 Apr 2024 16:32:02 -0700 (PDT)
Received: from wegao.79.199.227 ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 s26-20020adfa29a000000b00345660dafffsm3584049wra.80.2024.04.07.16.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Apr 2024 16:32:02 -0700 (PDT)
Date: Sun, 7 Apr 2024 19:31:55 -0400
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZhMs60JPS58+oqmK@wegao.79.199.227>
References: <20240327034923.30987-1-wegao@suse.com>
 <20240403032859.3826-1-wegao@suse.com>
 <20240403032859.3826-2-wegao@suse.com> <Zg6wV8Xb004kAqkK@yuki>
 <20240404160151.GE503552@pevik> <Zg-8HwWdC5eOZseY@yuki>
 <20240405102828.GA622461@pevik> <Zg_fLIQ9Fsv94H_Q@yuki>
 <20240405140325.GA637302@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240405140325.GA637302@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/3] lib: TST_EXP_{FAIL,PASS}_PTR_{NULL,VOID}
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

On Fri, Apr 05, 2024 at 04:03:25PM +0200, Petr Vorel wrote:
> Hi Cyril, Wei,
> 
> merged with the cleanup commit before.
> 
> > Hi!
> > Also is anybody going to work on the PASS variant? Looks like the huge*
> > tests would need that...
> 
> @Wei I suppose you plan to work on it. If not, please let us know.
Sure, i will work on this.
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
