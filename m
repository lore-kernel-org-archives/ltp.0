Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8AEAC433F5
	for <ltp@archiver.kernel.org>; Thu, 26 May 2022 11:01:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E4D2D3C0F83
	for <ltp@archiver.kernel.org>; Thu, 26 May 2022 13:01:55 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 004A43C0895
 for <ltp@lists.linux.it>; Sat, 21 May 2022 15:28:02 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3EEEF1A006ED
 for <ltp@lists.linux.it>; Sat, 21 May 2022 15:28:02 +0200 (CEST)
Received: by mail-ed1-x531.google.com with SMTP id i40so13718428eda.7
 for <ltp@lists.linux.it>; Sat, 21 May 2022 06:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=LHdEu4ZU995J7e7P8vZlHXvL8OmJCeK71/sGJQrVuPo=;
 b=YGzXm2ja70dmMogsNVgf04DjY5GuwS27UFL6sthf/CfjXsgLzziwSmyQBz1W8hep8q
 WMTHTsuRC9virxBC2cGqTX1MGkGSOJgVoVpxFJ9pfs2WaHJt9o75HxMoTYnke0DGVCz1
 oG3gwJGAr0e4cgWeQRV5rkiv4lyltN+cIbznvA7ZtXC3XAxLvMLiM3ybexoFm4mePr5G
 052MfnWJCDnTPq9ucEaWx5LuX2X5Ao8P/C7rr3dEhqYCBsCjgZYHyu/jwFFzouXvP2F2
 zI9sDy2vliTTyOIrVTLFZF7pk26kedney1JjSe49gVn1Snpu2p2ikdKsVZhPrNHgRpiG
 5QmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=LHdEu4ZU995J7e7P8vZlHXvL8OmJCeK71/sGJQrVuPo=;
 b=iB3XEke17eTzCtyMjaGoSmStKmHz0wyzPm1Q/UA3SvNZM+uy62wzOkmb6diiC1PbVl
 bcU7/TvFaJ3b/W7Ozp2PSPMk6ZD32BjYN8B3sSj2L5qPEV2tLyF7Dt50RX3ut8rKc7l0
 DgFJV0yycsiu08CGIIQrCZsevHLMaxoWGRGCJSsi+zRkjs3VHEHnEFflobmb+8DJnajM
 m+HyP0HoucdbLIAhMkzuofF0I6o19JWiw/cW1DR6oMMnfnHVRY1JTcfs6kCZt6zefn2r
 GAB90IlDui04kn4b6dBroebCRpXFL454jmyuNpcZ9Cr2A0jQNfozTy+ThwG5vQIOjc2X
 NfBA==
X-Gm-Message-State: AOAM530JJFZgT4cvLwNz0gwxEOY+p94Y77tewjn4ATAX2pQen4gzMszN
 fNkwpiUSBbBfoTLsxb3DYOQ=
X-Google-Smtp-Source: ABdhPJy3Yeg5Vy95815YTkSc6+BwO2tHNUyCBmBoUx7DISsQoCkJs2+QWRaPfyNDq7v+lFCaUuHOqA==
X-Received: by 2002:a05:6402:10cc:b0:428:90ee:2572 with SMTP id
 p12-20020a05640210cc00b0042890ee2572mr15723314edu.103.1653139681753; 
 Sat, 21 May 2022 06:28:01 -0700 (PDT)
Received: from mail (239.125-180-91.adsl-dyn.isp.belgacom.be. [91.180.125.239])
 by smtp.gmail.com with ESMTPSA id
 qz24-20020a170907681800b006fea43db5c1sm2039709ejc.21.2022.05.21.06.28.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 May 2022 06:28:01 -0700 (PDT)
Date: Sat, 21 May 2022 15:28:00 +0200
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <20220521132800.52xlazjqktxz27b5@mail>
References: <20220321112119.23308-1-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220321112119.23308-1-rpalethorpe@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 26 May 2022 13:01:46 +0200
Subject: Re: [LTP] [PATCH] sparse: Use offsetof macro to silence null ptr
 subtraction warning
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
Cc: linux-sparse@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Mar 21, 2022 at 11:21:19AM +0000, Richard Palethorpe wrote:
> Subtracting (char *)0 is undefined behavior. Newer compilers warn
> about this unless it is done in system headers.

Thanks you, pushed now.

-- Luc 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
