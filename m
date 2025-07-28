Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9A9C83F17
	for <ltp@archiver.kernel.org>; Mon, 28 Jul 2025 21:27:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 400E03C9D4A
	for <ltp@archiver.kernel.org>; Mon, 28 Jul 2025 23:27:46 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E0AF23C06E9
 for <ltp@lists.linux.it>; Mon, 28 Jul 2025 23:27:28 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7DCA7140024E
 for <ltp@lists.linux.it>; Mon, 28 Jul 2025 23:27:28 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a575a988f9so2688957f8f.0
 for <ltp@lists.linux.it>; Mon, 28 Jul 2025 14:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753738048; x=1754342848; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ypQDijkGbFJg7Q/unBs7bnaBmNTHemmgu5HbzUQfkQg=;
 b=Rlk20AzZn/wd6XZjX5gJSe+2y4jm0I0Rb+nFesUVlzItZQ3Wl1QP02fIe4JlhrH93K
 1jh8SurNrTgOvgSTsPMid59ExP59fRGTm0FlPkkZq08KnQVrZL4ogGNcKve31OUrsw11
 9JEF9zPCMgXm8iUDIpdQwDSXo3ZpGkuoPCcEEK1Jbjj/dSGheWr6R1xw543JcjIdvSXJ
 LlZI3mt7s73XmLy6BnsPbir3mNZQcY5rtPILscGQPX4GR/Usva64ZAZm2U4uh5NsqEPr
 BpyvfC7hJmvWWkecaW+ykeRZL/KDgpF1kItTpX6/2IUCnawfgo4jkk5LEQM3tgMFUu/U
 0VpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753738048; x=1754342848;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ypQDijkGbFJg7Q/unBs7bnaBmNTHemmgu5HbzUQfkQg=;
 b=j7Rrr9uUfvOJdKyEUNO7YtvfNNhTRp63i3ywQp+e64w/QttzjikT1FRUtSC94oe3JO
 xY7UUfS58XTykKAooek63dT4XfqhWZyDGj3OSJfp3FiMnv8mG06RZtRVoty/nYbJxKk/
 1QexsOjOjZwudGG4mnb4HhMGuVAi+TAkIfBjA73BQgaYUyUO2wqi0b32wR71++EpBYWO
 abjlIE/Jr82UKnnG/sHs4Wezo4OHQCb+tc4aAl94pa6uHX7FkSCtstHl2ABZkmAzxyN3
 FsDIsQuODcS0TGqjkAhpBDyyNzdAw83f2EHcLlik0ZZuk9xx/gRWAlKQzZdNSxFeq8mV
 QS3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwWHHCRVg48n2fBJ20YBKzOt8Nzu1RGCIdVr7uHPIJrTcmqUShwss05igY5xZsupU1WPM=@lists.linux.it
X-Gm-Message-State: AOJu0YwpRAFNaKUGCLWukhWjeyxVFJu9maA6hs3ZZkh9YyrlAmgKu/qY
 1lwWrGaT7Jx98jzsbrYtruYlsZW5bYa7FBOYtxtWzB3EzL0JhkeU0Gpq
X-Gm-Gg: ASbGncs29Dv3mM7FMsdj1S09JkeILZzCm2epihrW19WntWhLCO2WXXvnJRC7vASlmk2
 BE0hdN51nJRvg85/hT9pWcHHoEHdx2TqZvA+LoFuS1s3A0uAM18o148oWnb4XOvRRhF5vD/6Rqx
 dqS1RYoT1wrL+gQk9ktehSnHP47GG8e+eD7FMbNzpxrASoKs85NRTe0aPyNOcQTjPhqSKMC09Tp
 z7h3XyKZ7ZjukgxLpURCmgHGy5/W+Zh3oo5N90aqUhE7aSkSgtx30gfd8P/Rr94rApiB506ms+2
 GAYmJwkYPgTNKDi5EP6CRq5dbnMtIUk6AWtWyP7juebjlNbzg53ZaA2+E8JnTvNplx/fpGJnl/J
 C0P1Uk3fkomtkRA2VD1CVo1PKyQ4=
X-Google-Smtp-Source: AGHT+IEqhTKCWGWGbD08eH1lCjQCtTylpLWZAr3+2og866lApWggqJBTy69T1w/l8aZRalq4lMnQZQ==
X-Received: by 2002:a05:6000:1ac5:b0:3b6:176c:2a13 with SMTP id
 ffacd0b85a97d-3b7765ebc62mr9100008f8f.15.1753738047713; 
 Mon, 28 Jul 2025 14:27:27 -0700 (PDT)
Received: from pevik (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705c4fa5sm174728075e9.26.2025.07.28.14.27.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 14:27:27 -0700 (PDT)
Date: Mon, 28 Jul 2025 23:27:24 +0200
From: Petr Vorel <petr.vorel@gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250728212724.GA28964@pevik>
References: <20250727205455.728650-1-pvorel@suse.cz>
 <aIdKQyofRxukwp0U@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aIdKQyofRxukwp0U@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] tlibio: Detect <aio.h> support
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

Hi all,

Li, Cyril, thanks for your review, merged.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
