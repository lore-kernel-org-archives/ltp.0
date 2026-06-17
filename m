Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C933FCD98F0
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 11:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781696843; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=c//pxyynNL9q2R5puxscT6wrFe0sDS5HWIzjaevD8W0i16QogrNKa2wFDNlvwYLAkQZTJ
 y5XMZCl+bsi382xH8qc//diW1eoiiqkjITduqzL2Q/TVm/wHSGl7mjL+X6QyfeBe9YZuYlq
 cdvAUfrqsFrwsT2BSuPEB34pCPqogPk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F50D3E5933
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 13:47:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B04F3E18BA
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 13:47:04 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C448A600925
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 13:47:03 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-49222b6e871so41124705e9.3
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 04:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781696823; x=1782301623; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=GclR7dIvWJIQeQpDX/LpXTvUx8e5u21cPDpBQvfP5tshmTPMifwFLCt4yGX22QO26p
 YGzgPLNufElg8YmKwhiWLyBymIqf2/6Nol2pRFrAjz6Jx3yNPfZKLFfQkwp5Ci/sniqF
 a51+gScYSad7/eRJLtFl9tI0jGSj0XPtKsKAXpse5pieUk68rLM5Kt0P2FpRtrpAIJFl
 j4TMX6FP6eGYfrQOXNNQrRM00eqUFScbozNNIbRTu4yLUkzP420ZK4bl4BK6/ZuAV561
 b3nXOVu9/AUExRB1Uad3q90XRMRq9UfQZV5O5bLw8yf4Q7IGgyyNAJRxrXxKbHf1EPNu
 xvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781696823; x=1782301623;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=IYFvJVs3PzoHLsd0oDzZNn9vjzDnr/9do9O29UaX7wDyb+QGwnGsVxU3jsDl+uwUn7
 AtaGw83zZiEL5o8ZoYgusJnrLC/pGqY4M3XV1KxKW/dN3pd0Ja3beXGBUXYdeYr4RR9B
 0xb4zABNHMTRVbpmV43YRIDwJlkX399DnCiRQBHP8yyZ9m7r8nYn9mesamJ01MSMEYmu
 i7jNSVT1ADR/eItF2LR4YdvCANGoY8PnYk9UpWZqNWhYZK/7MzInUTiBCcgpPBHTaYNH
 CWGT43/2rGtchxL8EyiTNLUbccX7SWQrdXFkEBr+n/6M7hw/EPWcktBXwCr76u5mGhj7
 /sBg==
X-Gm-Message-State: AOJu0YweRS1bjn3zXWndDyTEGaTK1yhaqyZLRiuDWgA38f+wGxzNbjVD
 InHDzGzfHkkc7+F5Fx/tCqUVLmklkBNsJMhLtJ5Ma2/l1QDYAgmcGT5KJXMXIBCrrlXZh3c1RFV
 el/JY4Lw=
X-Gm-Gg: Acq92OE0ksh7fvUkBMtvjCRsryDVO82Zl1Dx3NVrm1zspVKjI7Cy6ZZ6FCt70GdDMWY
 OfP73x5pCTAX+HP/WU62E3Lokr97yWGflJW+Lv7iNKyAoVPE2gdREh99qASGGPFthJNlSL4Halj
 TcLAcSlFLiIcxRYi6ttamnv/XFi+3roWKKG9VGz6QAfjBCAkQNTaH7usUiizK8OT4JIFyrgUNC4
 WpuGfwwDjbEnqv/6AWq2Tz6Vqq70j3ZoQ92Z0zP/2xSCM2BbpL+XGLsuZWwCOs6EIwAtfdnlS0t
 l56nzLX6tywtgWgcjB1toiqKNRkdE245dq2SDxIdNDEZX2rXLbjEDyNwdRCxIs4P+QXj81nPJ9c
 +YNXWOet2DVUEOwyDqRr0KfTKaPsCq/WXSITKQTtZO2A1GJAS8e9ZSf6+l5+K8RPhIvv/lxiBns
 i6cKI9iVXJG3fQ59c240FBz93P+7vwzhud42nVUyh6Q+5JIkepftogtB4IgoMGiw==
X-Received: by 2002:a05:600d:644d:20b0:490:9ea0:c11f with SMTP id
 5b1f17b1804b1-49234100b3bmr35508025e9.5.1781696823131; 
 Wed, 17 Jun 2026 04:47:03 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2c3fcfsm47817978f8f.26.2026.06.17.04.47.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 04:47:02 -0700 (PDT)
Message-ID: <6a328936.05603459.3d8ad6.61a7@mx.google.com>
To: "Hongtao Zhang via ltp" <ltp@lists.linux.it>
In-Reply-To: <20260417022949.2881047-1-zhanghongtao35@huawei.com>
Date: Wed, 17 Jun 2026 11:47:01 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tpci: Unbind/rebind driver in
 test_assign_resources()
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
Cc: bhelgaas@google.com, liuyongqiang13@huawei.com, ltp@lists.linux.it,
 krzysztof.kozlowski@canonical.com
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
