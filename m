Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6DDFF885D
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 08:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777365347; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=qmkEKaU9jBIWpNgQLv2ymI7snEP+At5xEtkTt8NCjZE=;
 b=KGzxtiLrnu9H2RAvvxX21HCWpU4NDkALoQy7J2NwM5DeJgC5ELT6ocJP9CZ2zxuWrG+OH
 TQpSCnKubBh6WAqjoDiebOWWnOLLLiRqBO2Rps20NLpQ5rbYJI0J51S5q3vNlWNOEwCAi9M
 H0fq3Ft0JGJVZPjOKj8QUVxLsDZl1IY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D93A3E49E2
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 10:35:47 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B416A3E2536
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 10:35:25 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0EA1A2009AF
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 10:35:25 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso115932325e9.1
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 01:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777365324; x=1777970124; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=RiBfynshLfdjsMT55ka6Y0pZSJuASJgg+X8E4sVCp6Y=;
 b=Xen4kj2+X3An+L52lDnSxRHYaOWgzjj+k0NU4vp9Fd4vf5KzlMyavMXpadnFNKF9v9
 JrPbwmSV4yYaqigH93nfqx7Xkjff4PBU4iOTocRRqIEGWe+RsKFoEesJvnp/Ij/1dBmx
 BcYDDFw8xhQ2Na/nHjApYwpW9+tmnjnwBYAA4owECXou9Znopkzb3+IQDMV5sFS8bR+E
 kIMU8j9apxKNLjnuOKCyJHyOaIa8cP5URkRkvYElUp4XJMQnfperFUKJbW03C7vHe0Y1
 NQW7kh9RKbh5qAnOHJEpMriV5bJk2h7NkEdfeJYPAsbVUS5W+MQiX6rVwkUemQdZQjNs
 VdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777365324; x=1777970124;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RiBfynshLfdjsMT55ka6Y0pZSJuASJgg+X8E4sVCp6Y=;
 b=sfcKJat/4Uwczs8eCUgpQyzPdVLNowXmOZDJuxv1bPTDdQ1MAVynA887p+LUqpAq12
 bu4pes/UNsHEvjOzG6AdK5GPNv1AxYx/+g0aiiYH7oOqs29t/gWaXFJDtEq0YUH51hZQ
 910/VVoSDM/5zgbZnyKTv1Op7ZYjTlmSg9hjgkb1w4i5JrRHoRSyiVPYCY+gK7kQG7w1
 5QDJrKn4ANLQnyNAh36jKoPE51Bn7bB48Ei/735ORce7a5l9Yl45ouuN4L657MnTC6O0
 PC6HjU8Ujg/m/K1bCdm7eKV29hcr9Oi6pfuaRcggjHbmZCSRrk1VdkdWaQFOz/fT7yBo
 4DDA==
X-Gm-Message-State: AOJu0YwvEdDDZH/+KH+B0qlntHKLR9R6SSYAm2j6i8GsE3Wy8U8qXk0/
 HhcmtJAaZC2C4KYOYmaFkXJExrfelbZmM+8+X8NAiq83lWMtBS1/Y3yYQOHXwtitcWHtJnMFHLX
 PpqpK1xc=
X-Gm-Gg: AeBDievo8ZUr5NOjhG5j2d3PWyGSf77gLwCL3ta2j7+hqcB2+nOPjWIEo285Cx1FT14
 IQOpK6ZcSUUfxnywB2pa58gkQ9bcomO5XRszWEH58lweO+0OKJaCxSp+aMCiTOwfnzo6x11Tgob
 ZSXcReh6SKVBtv+IaV3uZSebH/iQ+0NcjrHfnrZe7Sm4IhvcFWCgIDPnjVpM7O5w0KkLhhPZFC6
 adH1Ki/3y3TKcrAgvZSa1Qc222N9UGcLrscTAwnAXZHcye/rr8i2vOyzQ8jINlR3B1guoA+qCRf
 uCqv/+Lds2p/cG2uS1bPZGOY7cIrT/+9XNUrz95P9mVY+k6HqqUG+5N5pw8NS2cv1wqEc/xkOpZ
 9PyzX1DuJ80PvNzq4N5yFno0/wbolc87Gv+UZzBeJ8odke2x+yT0FDfzQDWCwvro2BMX8HJruxU
 H6X/cHQpBEZo4dKmAPRLqu+GA4eBa4xIZDKt7y8wm2NpLSrNXpx4ZX
X-Received: by 2002:a05:600c:3b96:b0:485:35d3:ce59 with SMTP id
 5b1f17b1804b1-48a77aefe5amr33374675e9.10.1777365324021; 
 Tue, 28 Apr 2026 01:35:24 -0700 (PDT)
Received: from localhost.localdomain ([37.162.207.96])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a77b29487sm37241435e9.13.2026.04.28.01.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 01:35:23 -0700 (PDT)
Message-ID: <69f0714b.050a0220.16df6e.a14d@mx.google.com>
To: "Martin Cermak via ltp" <ltp@lists.linux.it>
In-Reply-To: <20260423144431.ozcixhmhki3aeigw@lida.tpb.lab.eng.brq.redhat.com>
Date: Tue, 28 Apr 2026 08:35:20 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Valgrind-developers] [PATCH] Make userfaultfd0{1, 3,
 4} LTP tests valgrind compatible
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
Cc: valgrind-developers@lists.sourceforge.net, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

please re-send the new patch version so we can review it properly :-)

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
