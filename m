Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B25C531D0
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 08:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785400036; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=b7xEDXRsyXFCQr2e7puKsPY4ty1cP8MhhBMBSIE50fh2YC0A/amS4hOyrAANG8eGTR33n
 BeAhwPktlOjvhqrDThqwNeEenOBfzh6D/qZB7FNkdCB4m73VaTAxcTpXqrYGBxtGam3BNpo
 wxe1CDnQ7gWfvFhgAxs5/7N9mIaP+Y8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 26A443E7225
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 10:27:16 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 236DC3E2BCE
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 10:26:55 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 50EFD140004A
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 10:26:55 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-47f7027ca11so1201425f8f.3
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 01:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785400014; x=1786004814; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=Tw7qDdvbumfSNJpuJFRvV8SrZkiHToZL++MTP5OTlmo+HCf0Trb1bmhD1DRP5XjiPU
 iJWFXLlSguHRzMNsn+q+jVoqHe1VGd1D69Ncl1vl5SJeojxNpUczZ0eujTqN5x1No0Lr
 5wRJ0mjvv/FczIyl8DW6tGmJexxyo5te23axof4ZwB8xrIfWfgwJzZllyIfgSxiK6O5+
 ayzH94BffCAbIqp5E5EnoRUCS2ISkOxh0S6uynY9DB+Kk0xt00PFhhk8BRxfSP8jCECi
 3B9BGmI1h+kQ8GwwTvfL2MNnL7cQxTxutFYD7hEOBau/f/MQhvgnf+376bcnER0XNesN
 J7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785400014; x=1786004814;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=H03eXSYt33i0UmWyUR17hYmrqQ3v0og4ZTQZRytM8RFoBrh9jh2EV042VJA058M6ZT
 nKBc+/lvRW7j/R47UAztczHektqVp4+V1vlexNsRGodIV6+mEnoHxELZgXuyuapiW++O
 puSc5ht3R9e3z1nD44nPNZ0PYuaVGOrwPxK8pa7HzchF+opeF5iPgX+88bOTEGGa59+9
 CAR4CaX9T0KSq3EuOAXyjj8Rt9UqY2YdFCvHbwBQQziS2HWebxK/W/cPbMfCcS6LE81e
 SO/PszVRCUnEl3iy2TbfctXNQsJswK+Ws72QJcvY4PTQ6T0A7WjoMPrP0D6YX4Qj5MCA
 JaJA==
X-Gm-Message-State: AOJu0Yw+egCYKfYT59PfjK0LEjac+/mRlaH+CcqrmQoMvEW7WjRz3TT6
 kDsGxkCDNbVX/6viIs+HXovPynd9gzDPxxlNtHYU6hrxQk6P57pcNyZIV9UAD9FeS7Y=
X-Gm-Gg: AR+sD12xJ3dSLtHKkWdYlTuNG8tfbhf5bR48vOpcen3opx+h76dw6TjE9KqG6ciGJr0
 xLO3xqq0ZTj4o/7WusRyGcEJeVYCJQLR+XCJ9pyw4C8Ruk0usosBnzdEwgpgRm6yvYKL14Frw6r
 uBtMBnu7vGEKZK8hVKEQ9u+XUDobOqyBploMEfC2ZJdTaOIyUg/kpPBM5SlHoXdbXBbSjimp9ep
 ehAr8LZ5Jx424pLxpyYn0RiJQ9N5zvLHHjEphiWzOHoA/UYMp/MVwngbHDDokirZPnbFlDv0Ui3
 rfHZjt/UzNdENKX8HTbJ6vYcGmiJQrcKRUulYBQ0u7jWrtsl1I1nddAJFyzYqjL1isoxvNyS4x7
 gp2NPKphtTEw4EXYm1D5HJIDaUemd/I8+fmlNQq3mZPznmiXPMWbBD4NvItY64VldCE+IjAYUmM
 U/vZf3nShxMiJTpR+68Ox3zAgsaSbnWcFEzMLjrST6Idvzrdlm3bwqdfBC+PnXWIn8gVcsev9zb
 7PyQkaNJnWy07oNx4pKLZtd6T5aS2l6NL2bb0ur4Nt6wafhH994pjGdOT4z52xpEbCutMM=
X-Received: by 2002:a05:6000:70e:b0:47f:964b:6329 with SMTP id
 ffacd0b85a97d-47fc8559061mr2137835f8f.53.1785400014613; 
 Thu, 30 Jul 2026 01:26:54 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc88e424fsm6159614f8f.14.2026.07.30.01.26.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 01:26:54 -0700 (PDT)
Message-ID: <6a6b0ace.bdd87efd.2b39d1.1a13@mx.google.com>
To: "Li Wang" <li.wang@linux.dev>
In-Reply-To: <20260730074120.180101-2-li.wang@linux.dev>
Date: Thu, 30 Jul 2026 08:26:53 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] mailmap: enable liwang@hygon.cn address
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
Cc: ltp@lists.linux.it, Li Wang <liwang@hygon.cn>
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
