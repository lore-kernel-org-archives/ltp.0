Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D2CFF886F
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 06:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777357530; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=YXOMaVLnQgYBkAZcP3N0ogpr4tKLVN62g4sP4ACYrNc=;
 b=NarWOmkgXe2CVVtS+GRpX4yfnZeKSFeA6o5nSr1FNn2hJjyZpZm8CHPjUijrJ/0L2Hbsd
 xsPBoHDjfC066gsIIC/rnraGcv7RUOxHfsODqEyKhzFYS+lGwJJnE5pSzxb9qyW7EHZhBKv
 iSIOK/rRpEE4MEZfKdudqyHs81APpS4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF2B73E2533
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 08:25:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B31593E211D
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 08:25:07 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 10AA660095C
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 08:25:07 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43d03db7f87so7475054f8f.3
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 23:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777357506; x=1777962306; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=e7spXKJPgIcFsCj5Wrvl5FpOGcIuzvTiT5a5nT8kNEI=;
 b=CNvrh9DwOBYBwmdf7nz3B0D0kCYxkEf0s3NwhNqSlK2NNitQiY19pz1twf8QxevO2w
 Hx9jIIRscilaSk3xQP8V6KPwxSTP7tNbgkYn/wjaao1OFfTbDyU5pG0+o3QNp4p+Chne
 9FGLbtGupLqpMR0FpeQTKFO405fnFsT1XXSpRKU0IxHdnu/WRqhagHaWfEEBJxDDvgRB
 ZF42201qvvJFu/rCPTPokFaqZq4u9jMDgv8FmcIZ/bExSCZgh9W8ySM7CBcnZi4D7iyo
 esw1K1ImGJh7EjIxTv7N9B72Y2hf7AvnzE2GxzvhMn37tRQSilu1DBfW8UewNUEZmXgi
 c5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777357506; x=1777962306;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e7spXKJPgIcFsCj5Wrvl5FpOGcIuzvTiT5a5nT8kNEI=;
 b=JhiSzc5gcN0vOfl+DKlaY+782e2QBcePPIaIpsTqxh9mjPgOhCk5SOnUaFSB/+8M+F
 A/w9WRh7BKtS0I6A0LA5bGJK+MwKeCCI87UoaWYVk+i00y3bXCnRqdbLH8P1NenBAMrh
 T4mfkbTzN5FDfkFUevuTcutt+OCVLl9toFpUdzhpJPs1vNqqadeF37Bm6BJJjGtcQ+vm
 Ru1V6GHg/g7ISqgnDxCyuXL+cVuW5R5NuJc6F/TVfYnNxi7guvecRuSVLD4D83CLV5TD
 d+44AaOd3rzDnC05qQJN/jP9tN5l8VDUBK5lgAY0s7BDOutt70Xrv5aUou5U1eDmdpSI
 ejtg==
X-Gm-Message-State: AOJu0YzcBD8rMBNsAVLcbf94vSaFDPqAZhbVz5LSOnsmswIJp5kupXir
 g10wncYGeaGV4wV8uj4JP6mYuWUqmPRimt9Vi1Tetxt819fnBjqZfPZ/rQJiAafauubWDiUt9zO
 RyA8jb14=
X-Gm-Gg: AeBDievJk0g/SH5MNWXlxdyfx6ZjbKfVyEaS3S9TJOwIKtG9wVhc4+13lnWSW242tNf
 GxDMsVergBTxVXRrQdH/4LhUaRBsHgwxremikhnVhBTs4lPNXgx5ZgtIfwOuYHgSYjR9YmKVRK5
 +MZFGO2q9aZIzJpSaW1IZnx5cdQnAupnzjnRzFJOUbnCJH+O/+x5dOoEW0Ff+DqUnId+Pk1Z7bk
 FagGYgdFlCS7jF9ni4oL7yJANbN8/mMHYf4BaiWWxORI6w0aLV9YGDt4NPYdnrM6LAT39/aYoyA
 x2KBAMVHsAlMBoZLFefxF7yx+WXIZPYYzKPmQpz+gKyRiDPZVZJu/ks8mJjjj7k8MjE6u3g8cgB
 RVLgaLxah2vLcL1KDJ2otlIQJv9OT1QJMjOvnwVcC2nmVsGJrj23AoGMoCf55R/xbUhjLi+XIRl
 +0vKy8+gogbO5tLkvF0NhIyt5K/dz06Zdn4Hzd9L/XoFEhaiiMWDRquw==
X-Received: by 2002:a05:6000:250c:b0:43d:184:8aa2 with SMTP id
 ffacd0b85a97d-44647dd17ddmr2969011f8f.16.1777357506332; 
 Mon, 27 Apr 2026 23:25:06 -0700 (PDT)
Received: from localhost.localdomain ([37.162.109.164])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463fa89038sm3886727f8f.26.2026.04.27.23.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 23:25:05 -0700 (PDT)
Message-ID: <69f052c1.df0a0220.1908ad.d806@mx.google.com>
To: "Martin Doucha" <mdoucha@suse.cz>
In-Reply-To: <20260427150139.31685-1-mdoucha@suse.cz>
Date: Tue, 28 Apr 2026 06:25:03 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lapi/io_uring: Add IORING_OP_READ/WRITE
 constants
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
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

LGTM

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
