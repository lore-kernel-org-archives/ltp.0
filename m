Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D05D5E15E
	for <ltp@archiver.kernel.org>; Fri,  8 Nov 2024 11:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1731064947; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=kLIOlYKX01T3VSL+jCWaWt5o44BegqDD2SE24JG5XC0=;
 b=TlQE4+Yq3rMYoI7RYuCpUzA/zxIqd3GODEuLpmf9BQGgnf3rGqr+iEaNDSxV/k+2R7yGQ
 Kqrxna/Yv5BfhKbI5JOabj2sWbzh9yy0uxB1ZeDbo0C1F/YgXKSN1UUrecSzuX2xlBgNnP3
 rwzP3DW/H3rfUIgSa+rdDmQQDQBj6YE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 529533D48E7
	for <ltp@archiver.kernel.org>; Fri,  8 Nov 2024 12:22:27 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 270FA3D4672
 for <ltp@lists.linux.it>; Fri,  8 Nov 2024 12:22:07 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BB8B51BC2512
 for <ltp@lists.linux.it>; Fri,  8 Nov 2024 12:22:05 +0100 (CET)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5cedea84d77so2871244a12.1
 for <ltp@lists.linux.it>; Fri, 08 Nov 2024 03:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1731064925; x=1731669725; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dAJbhVL1o3l8Tw0LZN/Vt/yb5angOsJxYfZxE6ECD8Y=;
 b=Wqdd4KF0QVlLcT7ZmHBmPa4bi6I5Lg8Arlwhk+Hb3P084d0c1hMWlDbDE/23n8Ddc0
 xs9gjObVner3Jv8SEVjuIADENnYeBujE7A2lI7/TWWurr+rm5FuVvlLYqGxTFH/J0yQV
 93FrIOhrJEPavGSnQEfyyxDCJ204kSjiaLnJrhagN2o/lNTCF6tBOd7QQsAuCygKgjUa
 RzAOIO+Fs/KRPSyjpPEOul3GRGMwhzP+hQ5yjCgMGZeI7QdRhUxzVbfbbMIPdp52nqmg
 QJOTdkooWlbZV0cssn7MEJfrWO9XNCFHcXUtP9g+ohj/P00OYsxKKYEJid9PO7LE7JWV
 vIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731064925; x=1731669725;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dAJbhVL1o3l8Tw0LZN/Vt/yb5angOsJxYfZxE6ECD8Y=;
 b=FMb2xskyE+Z59MvsPwoNmCkHkIB7pW37m75cPMQdfkyGbaJgfaY+YtaluPaLrTULp/
 WZz1/HUL4zT6SZQ4aR98nn1KHQpLjcyqaDva1T9Nkh/4ORRS3+9BArnr9zMqFrh5/JQQ
 m8S6stLDpHuzhK1jFDcGrWps+v0c0S9n8KJIGVBAmnY6qDICi2FHlpK6gvsBKhFYUXAH
 ULxvmhIDRlf9JZf697puDe4SW55+xnikW3QFjuFIrmY4Xq3YN6wn9HqYHpyyimKm3Xxb
 M8Z+CbTi0R08ZQa0c2Gdj/u+ncSbb8NdGsDYsFwqLIOJIxKN9Om6gHHJzcz3nKJ/Y/6u
 EGMA==
X-Gm-Message-State: AOJu0YwDxj1HY3tl7/epM5ajdk/qVz/m29stK3WfCuZX21iWTPDoYcgI
 ybVebGC6ci974s/lk4MI21LMmV7Rhoa0Oa+BFMQRNvDZXAmC7uEiMs60OIm3xg==
X-Google-Smtp-Source: AGHT+IGaU96NIGMMzeepsezzsVeyPSA7tiIpMSCAh2QqRb2ESH7KUlyrsA4Ic8wmnwu6v6DKnMJAeg==
X-Received: by 2002:a17:907:72c3:b0:a9e:c947:d5e5 with SMTP id
 a640c23a62f3a-a9eeff445b3mr220136466b.28.1731064925116; 
 Fri, 08 Nov 2024 03:22:05 -0800 (PST)
Received: from wegao ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0dc57f4sm220395866b.129.2024.11.08.03.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 03:22:04 -0800 (PST)
Date: Fri, 8 Nov 2024 06:21:59 -0500
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Zy30Vzk/14/GaEVk@wegao>
References: <20241108053710.8639-1-wegao@suse.com> <Zy3fh5YZeJ5djPt3@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zy3fh5YZeJ5djPt3@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] tst_cgroup.c: Force tst_cg_scan only scan
 specific cgroup version if needs_ver exist
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

On Fri, Nov 08, 2024 at 10:53:11AM +0100, Cyril Hrubis wrote:
> Hi!
> > tst_cgroup.c will scan cgroup mount point and check system's cgroup support status, both
> > cgroupv1 and cgroupv2, if your case only need check cgroupv1(such as needs_cgroup_ver = TST_CG_V1)
> > but your system contain cgroupv2 mount point, then TCONF will happen tell you your system already
> > mount cgroupv2, so test case will be skipped.
> 
> I do not get what happens here. What is the exact test output that does
> not work for you?

If you add .needs_cgroup_ver = TST_CG_V1 in cpuset02.c and running on sle-micro you will hit
https://github.com/linux-test-project/ltp/blob/6408294d83682635393e36c14bbd6ebd94fead94/lib/tst_cgroup.c#L892

Since sle-micro platform already create cgroupv2 mount point, the tst_cg_scan will get cgroupv2 info and
will not call cgroup_mount_v1.

> 
> We have tst_cg_require() which attempts to mount either v1 or v2 as
> described in options. However a controller can be mouted either in v1 or
> v2 but not in both, so skipping the scan will not solve anything.
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
