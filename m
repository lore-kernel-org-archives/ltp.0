Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824AAC3601E
	for <ltp@archiver.kernel.org>; Thu, 10 Apr 2025 05:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744263591; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=+Z8zFVRnoSLpisAOPd8g3w/ux/jb8uS9wkfZGy+fq7I=;
 b=HLrl30wzR1Tmx81hmmyXNidV6j2nNul7eFP1OP/kHKg8bMr6IvQp6ewEbWmaPejxa7FUX
 uIxSkEXqr+6AJrZ/wU19TY/b/Bzc274dU0fYZDYOVigAWqIkwlSnVjmUnYqlGmIVJkc+0z3
 uUTw1UNZwK62xbZnxgE6BrS7x1ZJ7fM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 14DF13CB45A
	for <ltp@archiver.kernel.org>; Thu, 10 Apr 2025 07:39:51 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 704543C193C
 for <ltp@lists.linux.it>; Thu, 10 Apr 2025 07:39:28 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5254B600954
 for <ltp@lists.linux.it>; Thu, 10 Apr 2025 07:39:27 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so3733165e9.1
 for <ltp@lists.linux.it>; Wed, 09 Apr 2025 22:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744263567; x=1744868367; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=f1e1HtbZZqjy6wcOZyG6Ec0MVJzCHdwSjAcbVFmN1CI=;
 b=NDjt9IAc4tuu5IQ0LL5aYhFxGOlYFgIxyNoSSdHJZn33IzpAbRXFbzES6vL1c61ZW0
 /MifrJudZcOoZgIE2Zp3gb1V7kMM1nSL9DGDJzKgBDUFwCJ3E2hs/Qz/QD/H0DGi5p1H
 oPUSW5vA/390AReFxBSni/dCeR8WnYQ+YMnroUTOgaPcbX2MTLGFhuAmv0hggD4GSvF9
 jXTot2ws9ymvEy4tF38YWl3lHdE6cwPEXJo76ZlbHvkEzSJ+WnSxXBqeF4fKsi4zs+4b
 ozXougjmuwGMFB2O7q6Di6uhZNq+rv+BF4+L1lZdZbqx67A/t6XZTXGest/4vOHX9dyT
 Wdlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744263567; x=1744868367;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f1e1HtbZZqjy6wcOZyG6Ec0MVJzCHdwSjAcbVFmN1CI=;
 b=LEgziJbp55ig2jIu3EoA55Z8ZyEdW2r2Q2Tj692uICod4PujHhMzdVGyfMI1XeTSVU
 1dK+DBAdib/LLoRcvqpFyA8/qc985ql00qHGWBWrOz/UV0sCr2EWIQWeNUDd3FU246oi
 w2ELmOtXzLJadcT1GC1k8fbPeURltfaq6R7TfUh7XRZ4IuU70yfbaaJDRgMDsDfBKtV4
 XXC2KOd1fT6e5faEQu1b8sWP1dB6+LwDmjevp7BH9L9z7Cu+o7ncJl4eoWnc9sNcOwVc
 gyNd51r+FBgAFzZpjZlzKGDibfcrj/XO9TkaeAG/tmUreY7PWWMAxjuBm+EAOIMR59Wj
 szkg==
X-Gm-Message-State: AOJu0YymNJyPKwcMewQyHYAxn88hY/5jeat2FjO6FMVvFf09Lz/o6nF5
 fZIghymHYiIKrIGrn+MhjBWHlKWq2CDfossJDhCVTz9n6oKT2+mr4iiPcoMsYw==
X-Gm-Gg: ASbGncun3kaXmqzwN4jx8bx3e7kp+3i6otZ9W8FrZ9/W+bE5J1Im0C/MvtR9s3ksQaw
 TXfcdPZK+dJAx2TFuN93OEdFg7TceiXaHTfVYqyBGiTGlC/OFW2cmiCFzm6gwBkreYmEVxdqwl3
 sdqCPr9ElSLXdiTlQl+z1AKmAE93SPQ4ul6RMrzN/6FGv938O+20eMvcum0fEYKoAT9B7c6IwMQ
 X4Xi3N6wYvzQvtXwSVzPMLwnsQYjSXOzt3pM7EHAcujJuk1Ew8v4AQ+D5dSJa3ZLpgJ2CtkUDzj
 w9okxpoWQwQ7tlVdj0eVZzur
X-Google-Smtp-Source: AGHT+IEI/iVfx6iAB65LkmsIKCA9zZFurFDJxoP6dVZXYviO/8BSc+wOBjpX12beC0JkohUvKLxacA==
X-Received: by 2002:a5d:59ad:0:b0:39c:13fa:3eb with SMTP id
 ffacd0b85a97d-39d8f4e43c0mr898196f8f.39.1744263566657; 
 Wed, 09 Apr 2025 22:39:26 -0700 (PDT)
Received: from wegao ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bb1e6aac6sm2441121b3a.179.2025.04.09.22.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 22:39:26 -0700 (PDT)
Date: Thu, 10 Apr 2025 01:39:22 -0400
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z/dZinuUeyrkfQhG@wegao>
References: <20240415114652.22687-1-wegao@suse.com>
 <20241212085058.29551-1-wegao@suse.com>
 <20241212085058.29551-2-wegao@suse.com>
 <20250227162717.GF3130282@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250227162717.GF3130282@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/2] tst_safe_macros.h: Add SAFE_STATVFS
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

On Thu, Feb 27, 2025 at 05:27:17PM +0100, Petr Vorel wrote:
> Hi Wei,
> 
> > +++ b/include/tst_safe_macros.h
> > @@ -429,6 +429,27 @@ static inline int safe_statfs(const char *file, const int lineno,
> >  #define SAFE_STATFS(path, buf) \
> >  	safe_statfs(__FILE__, __LINE__, (path), (buf))
> 
> > +static inline int safe_statvfs(const char *file, const int lineno,
> > +                              const char *path, struct statvfs *buf)
> > +{
> > +	int rval;
> > +
> > +	rval = statvfs(path, buf);
> > +
> > +	if (rval == -1) {
> > +		tst_brk_(file, lineno, TBROK | TERRNO,
> > +			"statvfs(%s,%p) failed", path, buf);
> > +	} else if (rval) {
> > +		tst_brk_(file, lineno, TBROK | TERRNO,
> > +			"Invalid statvfs(%s,%p) return value %d", path, buf,
> > +			rval);
> > +	}
> 
> @Wei We usually add only function signature to headers, the rest goes into
> lib/tst_safe_macros.c. The only exception are functions in
> include/tst_safe_macros_inline.h due off_t or structs which contain it, which is
> not this case.
> 
> Besides following ioctl_fiemap01.c it could be used also in libs/swap/libswap.c
> and lib/tst_fill_fs.c, where we don't even check return code. Not that many
> cases but probably useful.
> 
> FYI fstatvfs() with TBROK is used in fsync02.c not sure if to add it as well.
Sure, i can take a look once above patch merged, thanks for your information.
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
