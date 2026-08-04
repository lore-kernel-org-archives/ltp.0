Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D219DC55184
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 13:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785851525; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=R6CN6aZEQJ7vlNEX0+JpZ0PFHu2cEXSgqaycAbfE1RBiblefy3tTJgbP5om+OFO8HJkkL
 Uij0ExcIzxi/XQbvLZggOHudztwaMSzSS3UAXc5mHDLTHVMOTmJR+YZg8dI6MSrbnqfmRXQ
 KVECvA4o6RBh6zEiHkzNTbW/SmV7cFE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CCD703E7185
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 15:52:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D3A63E18B3
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 15:51:43 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4BF081000610
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 15:51:41 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49556f97a9dso21585325e9.1
 for <ltp@lists.linux.it>; Tue, 04 Aug 2026 06:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785851501; x=1786456301; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=fp14J/AHYwiSfPDhZwsqvULJyYh833rWDYpjsEjo+Ed4JdDvAp/gF8aRH4h6Ec+HIn
 6GERD/X5268O9xDlxODfM+hFyukgsEh2/Rd+/HSyDVbQo/Qi4ILbyqFIyj+hFw1670Eu
 VyELFQtE4xlAdeHanLfp2K9rM4I8ghNhpS0c2xaPz3dtPvC7i9fiSSRo9dXpFArxjQwt
 ITdVjHHyYm0f0p3c0VYKgQp+6gM08hPtxmAVNIj7SXIV6ctJTvVeh8Igby1dR4Av9/UQ
 qOY0jrMN1nJ4TGB7hJHr0j/fmm9nq1G2IJthyGk5XnM3BWigY+9CBpXv/bTkaWOn7VN0
 KQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785851501; x=1786456301;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=CR/IGNM5rUJFWz17p8viPo374K3R7GLhzPq2rSleTq/9ow6FqVKCA0vdPLPfxWTvEb
 G8ghIJIjO3So8lBSeGbS0Aa02uXm9iTdpn+Adw2oDuKzSO9t6EDWHAZyKBG6MsEzCZ0L
 nfe0n/mxUJhYN23l1K6hrgxiqPPqSaFh2fdLnAAJbjKe5qQDZMAit6S8kqy+daYxjIQU
 /4yfUwyTi15zI2g3ewkchU8hUNOyXK/P5qXMuya3EIxTAYbINAnvwIZw7XYsLhxz3oQQ
 fUgAptjSUkC9u+YWTtkB5lrrAlkMPCx70Fu0rj41hUSBmeROfaWIik4KyCIfVEU+w8w2
 /G+w==
X-Gm-Message-State: AOJu0YwNekV5BH1FudYtiVRsHIjSgLSoizLv9pD/EFRiWELUsJiQoKuh
 RLjrcxNATqoawtzsdH1SxZ3I4tKnEQT2dNM2hcgpDVaL+Cc9jeX6gyeMC0roJD9R5meK/mZE8J1
 uZHwhw48=
X-Gm-Gg: AR+sD13nmYE1epqwUsOytqlfMyMcPkANiGQCxoW1hor9dbWrFuQ3RgpXRMtOB8CRI7N
 uvkHaDgbzSnWi3XvVdGByB0w04wiCKlz5/Qwd7ay/WdzcLpOu+4+Nsyn+VZi7RnBAV1eQbtLC+V
 2gIuVsFhyYCyex4a/IT+6zFIoACXO7wGgjbWvZG0dTe4Y6VnfKbk29UFwXN66SzN5/1jtATMnIv
 WCVPMkwWg/v7M6BzePbvbOnn0ph+/1hJAKKRppeMblu9bZGpUf0Amlecimq+V4ZPywCFiAU2/wU
 5qZKK43nstKTa3V5IhIdJuuObxKyVfAd8O/CCwAM66lz/YyRfF4IsoWt32mvOAI+a/2fKyPXq4N
 b/Q6rVvtkVamqPCdYGMmPjhofr/vbzHy7mdkh/kWIKRjVemyI9yCyMFh5BsJP2bOHq18owmiI3d
 fg7jDWI67em7ObaDV29+W2gMr0A4IhanjvnkuYLVMA9oL8Yc8fVhBYB6Q9NBWsY6lhW44SFQFCw
 VOZ3FXxw/ejjdm0LOUcFM41fLHqiTkYQ5twL08L9AF/ylaT7JSkYmUKFCRpdmIAHczFGtMFfAiy
 +MzISm+ZxHZe+gOMGP5G8piwrFFSDP1Q9kfEcw==
X-Received: by 2002:a05:600c:6989:b0:495:6338:1453 with SMTP id
 5b1f17b1804b1-4980c680bd5mr388856405e9.16.1785851500639; 
 Tue, 04 Aug 2026 06:51:40 -0700 (PDT)
Received: from p200300ef2f11090032755c67e6ad8da4.dip0.t-ipconnect.de
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41cfde0sm40547488f8f.3.2026.08.04.06.51.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 06:51:40 -0700 (PDT)
Message-ID: <6a71ee6c.3c943127.1c122.10f9@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260804132857.552304-1-chrubis@suse.cz>
Date: Tue, 04 Aug 2026 13:51:39 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_res(): Fix TDEBUG | TERRNO
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
