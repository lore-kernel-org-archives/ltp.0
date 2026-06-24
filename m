Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BA6CDB479
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 08:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782289880; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=mzAghOXMSydb89USJQjBnEZoHZUmswVWQFVVpghZlYYD1e/XVISOfNVT2gDOgCiS68pqa
 QctsYyVnwhqLp0ylEe05HulIo1McNn6sQooP3f5iSakUsh2dkhpYa28LluN/gUoesdTGOJK
 fr2t415iONe7ObB2/3grmy3mXHmW+no=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 000013E533D
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 10:31:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ABF783E2A81
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 10:30:59 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DD3B11A0091F
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 10:30:58 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-490c0c92cffso5050575e9.2
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 01:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782289858; x=1782894658; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=U+2anhic8gb9qLimv4cKq13FAS/RzcI6/Bm5kglJ/Pnud45a2M9pO++6algsrQoK5A
 ggL1mAI+ApIYwZnm2GR17WxuHSuZGiCPP9KrqJ2IH53xydC0SfnFnizEUA8rB5lSLiFy
 D26LyAlumEV4WeHjqpHhEHRa+BItd/Lkwv7AD8INaW7c6/ltzit/AlRsY2VJC9mqNgXN
 TXEwaFePmM5FjG3xbD+UtP2OiEuoDXNKGiwHIG2I6VpR7JQdAlXNx2jm66wx09wxdIqB
 wmWBt5VP4cPC/r2RcgXrPt11J734PhHv9wRtlerd6tC83c+yeQ0d684gd0oIjNM7ExDL
 a7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782289858; x=1782894658;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=iuaBCKYpz48T2P7yZGp8/EbDvynSTxgRe9G4H+4dXy+Zb9Sn5Wq0vE/SxDRCewdf/n
 9c1ODbdxk46eot7Tkq4Oj5S9JS0Vrhh7kexrt5yqHHcAZFtlQVEDbfZmc0Naf+qLkAre
 t8Ad3mi3L4dXZtuEMZwcC+Yh2T1uS5ACG9mYztr2yLWCtZBoGnlW0AKxaGiMyW8MmlYP
 bmBupOi4Iy7u/2/dlgldty80nipbvNhWOeDQEzjMky142+cbALbPvehwc0kv3btD2k4L
 oYDB0Zrd2b8mmkeWzLUAa3mt5k+PXnVu/1oNZB37HPRjjISnvOzn5FW5qLf8B+Xsm9iO
 TFfA==
X-Gm-Message-State: AOJu0YwXXebust2urkXzdU7pVjE+vIkXRuxxvFlxhxsnrA0Ai+880cfj
 sKjV95gT1XthxvtQMJMj9Ok8OlWG96PMsu8lRMA2YJViHal0LhS1rqeT6qHejbvFs4wN3w0j7bJ
 8tl3coWqdYw==
X-Gm-Gg: AfdE7cleA1db+tgkR1n7mV9PRqRirnwAHEYFc4gHMpn7Gc4U+sNkP7dcSBArVln9WPE
 2fLRdLV8EWrcs3ZmJmXPElybkECPg0nDcpJFyibolBd8x0rnCtS3MKnikVDDQVdDRQB5dQdG5He
 V4pGouiEjGxIjTwPKhWGz1Wxw/bGl3dxpKgDiMuv7CGeq6WHwFY6zqQG6fGqT2SjweTh9xFzTGR
 H1albp+hIpBGEtZeGjd6y1v9dc5Y5Ks2a/5WM3I6KvlO0JtsGob+FVxs8Kdwj8CUfTnbd0i3/8P
 Kl6/NdKaeZ/PTq+w/X4TF0ROZM522/nAeKuYp6EkeOqXMWkzhBahoempFLPErR2IKHldHMVPAtv
 /GwzJMQI5/ehO8BaMRXys/xl4LAiTryUDlgBWbUwPBcCBlNAtg4lK30SUBE4uL4jZbZbvu1dVgx
 0ws5N4xHG60qGFEf6Js5fP7YdK5ZCg241Liy3slzqijkwqGoSgHouwzDxafxfI9yz3UgeerNwKB
 sXPTTXMfQWHDZfd0W44qQGMpu2kMgOl3SxY0soM2NRxYAy3BwN4zeUd/I5LFnrpAAA=
X-Received: by 2002:a05:600c:190b:b0:490:bc46:1a58 with SMTP id
 5b1f17b1804b1-49260873583mr29612325e9.18.1782289857998; 
 Wed, 24 Jun 2026 01:30:57 -0700 (PDT)
Received: from p200300ef2f13eb007ed17b715703ca11.dip0.t-ipconnect.de
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49260915286sm87342545e9.1.2026.06.24.01.30.56
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 01:30:57 -0700 (PDT)
Message-ID: <6a3b95c1.3dabba3e.214b61.0347@mx.google.com>
To: "Avinesh Kumar via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260623200336.116104-1-avinesh.kumar@suse.com>
Date: Wed, 24 Jun 2026 08:30:56 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] swapping01.c: use .needs_abi_bits = 64
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
