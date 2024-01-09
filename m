Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1199FC46CD2
	for <ltp@archiver.kernel.org>; Tue,  9 Jan 2024 14:19:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D088F3CE4FF
	for <ltp@archiver.kernel.org>; Tue,  9 Jan 2024 15:19:51 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 89BF83C8B4F
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 15:19:37 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BBBDE1A01968
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 15:19:36 +0100 (CET)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40d5aefcc2fso33961915e9.0
 for <ltp@lists.linux.it>; Tue, 09 Jan 2024 06:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704809976; x=1705414776; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S2OfOZN3tlr63/tjOOoYfkc4EJYf3pI1JhWCXU8pt3g=;
 b=iavDmr60yU2Vf4+vtIp/RNhueVyzUdXwnSJ1I7srSEcu/a2W8ZlxWeg/CPHbjG015D
 ficJ8G9W0InNZAodWSQXi4PrMnxuUokCArzRecu+6xhqXVo5z4KR/0QR6DtgeHawQLSD
 WRY+5RpA+EzXmVhMFWgoQQ/FBXErdT1AlN1h5I/ON+rOPA4W2tVRLl7qAzTANgXetJiE
 Sw82v19fU687bTxWSgQaS99lha2zLM1DQqThd2Z5KtMZl+bEWyb8pABvDwKjav1RDSlZ
 JhLnBDXorDKNXMqugdaaJier0+kmwOeluSCwdQGsANVcCsbVR93HuJe2rFeGl1JzvjaO
 QIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704809976; x=1705414776;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S2OfOZN3tlr63/tjOOoYfkc4EJYf3pI1JhWCXU8pt3g=;
 b=eK3JU5xjln76rE+7ZjCsjU94tHcVVX3pmD0XXfoBpfYO3MXVII5Bcr6wMEbP3fQP5J
 LsqpuL8bMM/KdPNjLkOTWK3ZkkPOSxCgpXLZ/M6jolOZOeJlBNPb38MzBmBZLl8bp44R
 3MKki37LllT2IZ4MEuEOaokG/YkA6JSVQa8P4r6jHAXWG+ZIYOILCaOEEI/pilAEuAVw
 67l41rS3o3RgGMbYWboTdT3Biq3UmgvrbBnOM/sldn+8nbX/3wEle9sC5rqhpUVaWnpJ
 398l81Z71Pv+4k2U+3sUYBF9IMrOshE+14aG3JTVF+YkwBRH/JCz9pnyiW8GE7ZNpRFl
 yYlQ==
X-Gm-Message-State: AOJu0YzkNvzJkJbAQSW9gYJO1pTsvB2ElguuYwTrPuuV9Wed5uKfuSf4
 3NmHdciUykv/kn9KfK+ckLQ=
X-Google-Smtp-Source: AGHT+IHnk5WNPpCWMt5lraG5SpN4WagB7mhM89Rds7s+7Z2E9kqVf26S5icFZbeSrhuPCwNrQdWcyQ==
X-Received: by 2002:a05:600c:2215:b0:40e:46b6:c29d with SMTP id
 z21-20020a05600c221500b0040e46b6c29dmr1670589wml.101.1704809975931; 
 Tue, 09 Jan 2024 06:19:35 -0800 (PST)
Received: from pevik (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 h6-20020a05600c314600b0040d3db8186fsm3813728wmo.5.2024.01.09.06.19.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 06:19:35 -0800 (PST)
Date: Tue, 9 Jan 2024 15:19:33 +0100
From: Petr Vorel <petr.vorel@gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240109141933.GA1641093@pevik>
References: <20240109124742.21085-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240109124742.21085-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] kirk 1.2 version
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
Reply-To: Petr Vorel <petr.vorel@gmail.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

merged, thank you!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
