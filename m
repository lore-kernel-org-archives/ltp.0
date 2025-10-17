Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EF7CCD184
	for <ltp@archiver.kernel.org>; Fri, 17 Oct 2025 04:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1760676011; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=vFZjDsdZtUfQMBVJfT+kQbFLCoDPYRSotqw3+DGTS+4=;
 b=pjyjF3XxODKf3Wos1Nq72u+qJ1eQ2wZhUdfMKp7uJ69g6CJG19XdGX9h0uXaRsgYNe3ym
 PKQd795L8R+sYikz/sO4RBrlG1isijcQCUQ16+9ugo2/AU3TD06XhIHLGFWmg6eh/nkeCK1
 W/VX6vcnuZ1kDOXHEg55VVTXZU4BRNU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CEAC93CEE14
	for <ltp@archiver.kernel.org>; Fri, 17 Oct 2025 06:40:11 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 830103CE8F7
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 06:39:51 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9AF081A0106D
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 06:39:50 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3ecdf2b1751so795953f8f.0
 for <ltp@lists.linux.it>; Thu, 16 Oct 2025 21:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1760675990; x=1761280790; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Z9Iylmw3sL+xPzkU1lHq0G2lZjxHdS9FDzmpomaS7w0=;
 b=OTkQalUkv4C5/mRGhPBNuON1pwVowMXL62BPUXGbp+/1F8tpAYkuTuJkU0F+DaqRL3
 soG2dzp+JI/8gMLG/0el5amf5kqTFSGAir+NbbL/8AlHx79FmZQIxRfqynMrHHfi6GxJ
 QDH5S/wVhR139t6Ec2yy8mQd154sDJ0BpniWK55b0MClbrxfJbw4a/sErJ8vDJX25NWF
 HyJbI8sAC/X/wMQGAed9YOBi52TnOa4Imzmzcczz4t0z42D9+WpAzf85BlUQrJmyFc+U
 gByPZDO2iQZYxTF+FCINqfYR59SzXR6KL4sH7+kHPzjm8AWh9B40yy7Eth84t/u+ke+p
 9EOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760675990; x=1761280790;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z9Iylmw3sL+xPzkU1lHq0G2lZjxHdS9FDzmpomaS7w0=;
 b=QZqkk72FPfMU2aSR4tfRLAnhVXBqb+IPF03kwIB4ybq5SiyCDnaYHP11cyoObzab7g
 ZQdrO0uOkN1C/JW+HTrrmuKcRkP7ApeUSojWyOisq7FdkEzPasTEEtsslF5W796m55Bz
 m01yAPlTyEBmzf6oxo0NEnfeDfrwcmE/hJWfgB42eMicW1LgxEAHOK/PbyRleigaELlQ
 3tx/VT/rJkK+8vR0I62k8VN3Y8J6YqRCCgniLrT5FKQ8mwLrykWHOzeGWiY1L3FvgfNt
 l2w+gUcQtdtQeNcSAIqO78b8yPU4Ruovh2qzkgCla1zWWI5vjqjpcBZ7qntO4ZS/5O4Q
 zOsw==
X-Gm-Message-State: AOJu0YxjBGxKNw19+HPVvn6dCqrAACLEiiKko180zZ2dLxGPdg8K9BJ1
 mlH52gCW93IjiPO7+Mr5jAvA8HgNFxdsDFBrqGnQBwSpml7XLL3WU8nimpjhgML/kEuPCD0qWu8
 OGWw=
X-Gm-Gg: ASbGncsnR1dVdVdyJtQvJk0OngMnwIp6+Wo9KxBKA+HRd3k8m5Ku2ulta25LP2DpttM
 ZkXrduSVumndn+CivyngtuCLS4CCfEX/1QGQsqtkdrGf9nqmwxjLGThkOblIisvDWNp/WZjEJig
 OFBcFkB10NiPbkPYJDAJ46KFcGvz84QVdisTQTSIfPvvGprXBPYDmx0bdhuq4wt9vkflt0jmwmk
 qZzsiu4k0HvyU1Y1I4OF7SeAe6qgeyMPnHR3tJpwKsTdnC/x0ok2z3BvUh2mGmnBKsle0hu5wBN
 bh3RsTPaD0RaWbe/TO+kxUpj5fpdnAvCXJ+NSNuDwvF4UzcKOGq6I58IcG/RqH5dxpHl8F1Z/YA
 zAm3nK/BfNG7dx7oCZjXQSLouyi61CdQg2rEutmDOu3enf4o53XfrfZkauYQ+UcX2Fou7Jmsalx
 E=
X-Google-Smtp-Source: AGHT+IHsALedH/x1RtnVwp30TKIgPpoE7qcxHJZZES4qEBmBsF3xP0eNjzc5mPtzL/Fff9jSZf4XwA==
X-Received: by 2002:adf:e18d:0:b0:427:6c6:4e31 with SMTP id
 ffacd0b85a97d-42706c64e42mr471204f8f.22.1760675989838; 
 Thu, 16 Oct 2025 21:39:49 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144239f4sm60976845e9.2.2025.10.16.21.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 21:39:49 -0700 (PDT)
Date: Fri, 17 Oct 2025 04:39:48 +0000
To: ltp@lists.linux.it
Message-ID: <aPHIlMmB5VsMGbtM@localhost>
References: <20250526143551.1321709-1-wegao@suse.com>
 <20250603214503.3792293-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250603214503.3792293-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] fsconfig04.c: Check FSCONFIG_SET_PATH
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


CI failure not related to patch, restart of failing job helped, see 
https://github.com/coolgw/ltp/actions/runs/18487937913

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
