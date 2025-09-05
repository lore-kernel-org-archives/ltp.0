Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46965CA1015
	for <ltp@archiver.kernel.org>; Fri,  5 Sep 2025 08:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1757059889; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=b0PxqXU+8hGpwTcjO1xPaOGxOLVZmNJ5fPAcBZdeKoo=;
 b=AHxFavYAhXr0ZcXCW8AP27FHenT04YexkamZKeYFVsUXOZftZv8gnAp2wwJl+Ul4V+6y+
 YzUZcXn0QDtm9pRfmfRbqrg4qBIsTBhbiQtzzMp1cAMirsNIwGXd2wan628ZNmOPaumJoPZ
 fSuxrwJN6Jv27aS2rJJ6h/jWQcvqvSY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 57A333CD4DC
	for <ltp@archiver.kernel.org>; Fri,  5 Sep 2025 10:11:29 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D6953CD1B1
 for <ltp@lists.linux.it>; Fri,  5 Sep 2025 10:11:07 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 55D16600A44
 for <ltp@lists.linux.it>; Fri,  5 Sep 2025 10:11:06 +0200 (CEST)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b04679375f6so305042766b.2
 for <ltp@lists.linux.it>; Fri, 05 Sep 2025 01:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1757059866; x=1757664666; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=l+uj/SltNBNQGzZ74csPHxe9q5WMH0BpfO3JNtb9eX8=;
 b=FsTXcnfRIUK7tcvUpL0PJ29PuRf56VGpO/PFsuw9MAFpVXWe9iOg4fP3nqHbNtfVys
 ngK9XpUr670Qajl3m4dzfYBVJsXniAb2e0FdHVY+ZlHPm5d3w0vhUmfs/oF9U/EZ/vFw
 Y4w0V0yi2+8OHZFlZ/t61Vgb3gaF8IwJshKNF+6hfnNkZcjIjjPq6eRRXNgsPb2IDn1P
 tOPutsL9GFPhgbr3+cVIh5TYZLWhMntzoouRvlQuaeLEwgNTjbp3WikXtSCSJ2kaMCPV
 NwC0BReWZ1Q4xvNHd/Rfl0A4jPdlbwlSWUs1UE26H7rAwBHb/ePUj0pzUOMUFB8pyRNV
 x1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757059866; x=1757664666;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l+uj/SltNBNQGzZ74csPHxe9q5WMH0BpfO3JNtb9eX8=;
 b=N6xZd1uXXR4rCaMjuY9eSBI1cDQKbayo8NF1zHAfDsl5rmXAtZ7G/+LJ8RcWrid/OP
 b4Sw8+vCNiJuOcCLzFbkXla6JFzzjVaWfOu+AwY/7vJfBlhexWmg3HcnCjEjz8Sk1u+R
 o2jCUkRRdgsaVAnSc955za0UJ/oeFqY8/+gY+ke/q5QRUvpLB63wHvmSHDRpB9jv9uL+
 WhjPq+4mM2RX4giDS0qN2lm+jT5fKCKDlfOjshpUSWGiF4QISLLkNaTR2bPTxT8jydpW
 eqJVtBU3rBxYL9eqacZqmR7RJIz9DxI1L/92bAJcXSFT29LWDf8gu3F05wFt6JippOT2
 qc6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHkqsfHWBzUm2uWb7wtXzfyzi5bAAgd8y5pVPBnOFpVMXVYeYliQKNO9UwumcbGVDBCTU=@lists.linux.it
X-Gm-Message-State: AOJu0YyjXEcvEe7edLkRhqdwmyPqBy7Bfw1cu1v56QbuGySBlRqWgbJw
 iGkYgt3NLqR5ueRhYYxIOjnPODiXn0oyHW1DmzIxdWEkcR06Ns56eLCGDZyZren30Q==
X-Gm-Gg: ASbGnctsqFGis/QTj0/hxZhlwcTQ9yFQxgsvC0gCfwFDZWD711W6dWnzG2n80ArmR5B
 ecJPOvu4+/p9FYGsQOE/TrzRjxAFCm8bh1MT/B6bsbiBT5oAoa6lN5Je4bAq+3zw9iqv+c3+Slj
 QIhEgJ0Nfmwg+uUCckiK0NuufgjKnMZEeuzroWa07zTXZrkRrIP8YoGnTmhTGO9aIixGdZQv24I
 PldwD0kFcdFWQm5aHnrj3OfvB9QerGBmw4Ea22QPrg4ErfCjv6BmpjR7nFy+aUI6f6tdmJ6KpTq
 23gyzkALKtxG/xAe/kcegYVUNIsvD7GNLWseDn06GTk+Unn3gYbs0GSkahDI+RXWZUiSjkACZRZ
 eZ3l4+e4iW1UuCoIn9K0/omeC5enkxWV7WIZOW3hHJxs=
X-Google-Smtp-Source: AGHT+IHeaTiY9Vs/3cZBvxsYpy3FwGsAjDFOWyEJlXHyuGo9u3iXR/obO+T6lZ76aHRWf1Hn2Z2Gzw==
X-Received: by 2002:a17:907:94c9:b0:b04:2f81:5c35 with SMTP id
 a640c23a62f3a-b042f817f8cmr1687672666b.34.1757059865516; 
 Fri, 05 Sep 2025 01:11:05 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b046e6c630fsm544101766b.55.2025.09.05.01.11.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 01:11:05 -0700 (PDT)
Date: Fri, 5 Sep 2025 08:11:03 +0000
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aLqbF1Hyp8fEh54j@localhost>
References: <ZQF5J0UJ25_QLwcQ@yuki> <aLpGnKpwkgF-rxIM@localhost>
 <b76eda70-8f2f-4e17-a15b-655f1271d306@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b76eda70-8f2f-4e17-a15b-655f1271d306@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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

On Fri, Sep 05, 2025 at 08:22:30AM +0200, Andrea Cervesato wrote:
> Hi Wei,
> 
> On 9/5/25 4:10 AM, Wei Gao via ltp wrote:
> > On Wed, Sep 13, 2023 at 10:56:07AM +0200, Cyril Hrubis wrote:
> > > Hi!
> > > As usuall we are supposed the release LTP at the end of the month. In
> > > order to get at least two weeks of pre-release testing I would like to
> > > freeze the git starting next week. I will try to review and merge as
> > > much as possible till the end of this week. If there is anything that
> > > you think should go into the release let me know so that I can have a
> > > look.
> > I would like add fix for current openqa failed case cpuset02. Futher
> > more fix is simple and should not trigger side effect.
> > https://patchwork.ozlabs.org/project/ltp/cover/20250904015920.7432-1-wegao@suse.com/
> > > -- 
> > > Cyril Hrubis
> > > chrubis@suse.cz
> > > 
> > > -- 
> > > Mailing list info: https://lists.linux.it/listinfo/ltp
> 
> This is an old release topic. Please check the emails from 2025.
Sorry for wrong email thread, will use latest.
> 
> - Andrea
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
