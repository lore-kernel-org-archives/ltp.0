Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FBECD98CF
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 10:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781606663; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=XTsqx1/HKBKhJoE0+M3BmZorFLWavsJ1roF1h1rSB+53aoGgu2arP/0EcJRFxgeahDYI8
 LbHYZZ3Ip3fgnchr6eIhK+Mh2U46gEFEzjc4FojuIn2tEDlufF0NnZOTF/H/gZxUtQWQR3/
 J65RbY41CpfXvudxSQZ1nlC7ZlBAwPg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E1DD3E5997
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 12:44:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8958F3C581E
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 12:44:01 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B3E15600D7D
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 12:44:00 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-490acbb0f89so28449795e9.0
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 03:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781606640; x=1782211440; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=Jz/w1qqc8hwlsmjznn8ZqSdnaSiu1GIyEtThyRLYdSRJEVun68gVIsrYVrjCQ5iWrZ
 GSQULuiHDRP5GetiSxMnbG5K86ES8+JCaaZp48q0Zw5jjNKwxrVUYRsaDYnDQ72tyZ87
 e3W5TVQir7jYEmaclB+A9nagK/0hwqK3Qo/sOIuyyHYkz+ZeULomoWTlFgBVKWkDMo6s
 pWfu34ML7naudNTGgMNFvrey3FCHA+q+k6SSMaDE+4i/EkuHIqusTYye2uWSyBd0ceUe
 Aq2RmWJvvkzljHn9No2fpv2gKc+t0ji84AsQJ/iZ8kvwQv6LDMC2gSmPzER2LiiGuBl/
 Fqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781606640; x=1782211440;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=O+649PYI8urG2nXXhq//r76Uc8X5psLI+hnA5mU7lhJaf+30s1AoXXpza3DB2ZlCPl
 VVFRffEGoeccxlrDFtU23kTU9FXg2VAaiL2kmQtavCakKZZ5SoHDuvM4Z4uEYpMqc0rq
 fUFDFyl01VzV6d822IWc9mfagt917TWoAT6X1sjZ2jkLV9DagWBni1lVNkz3HDSs6JkS
 LUFUOBJpyghD3EAEXR6UR5jBMUVWSdkx73WnA7pZ7cP5VHVnFNER2aiZMHCo/Vkr8jcX
 vKLjbI87Mx1Pa7YrbrtYEAKBkpFGw3KNGt0F3Tb6W2D1AhYq5y2d9VxWGATdTRDU57KN
 EwEw==
X-Gm-Message-State: AOJu0Yxicm75PnI4wbcNUVuV7nxEyU/K9aiQlTTlwb50vGiQLLbBcMwu
 /Knuqkya2QFaJeWBdF5gFSYK4GZIEuweYM90FZmHF8pMI9hkzL2ZqCUm+tRJwGMtYpQIQG897WA
 vZNrE72+2cQ==
X-Gm-Gg: Acq92OFKoUqj9IZjGhEbq22/1tFQ3JFnQ719W13tsKHpXx4Om+f4Sn5zAMDDpbgruHX
 UeOiZjNFaar6hRi4x0gfwIXyhNacEoOcn7ZwSlibnC9jjIhZGc3nUUGR1ttC31WdEizQIXf3CjK
 M9wTRYNZR5dtIweWEgg2U2dZRdxe9TOfOpHT5Du6l5khrzjVQlZ1ZO95Ugy4NOr3HKqv+egJ/Vj
 /Q+qMSvDGzW2WSbnxBuyv/5Ajy5gSY+Yoe6ii5Wp9FmPukC/mLJUTbO72HweCbZUkgmL9e79Wki
 rACsHiaTl0XLs1txYZoI4dF2DA5UlKkYtkWj0FZEL/Hnn4pWFnymXgALocmSAslRh82sAx0Q3Rg
 ajYWoPSLkHaLB7jJ0bP972by/Y58eZL1D9+owha3PLYLyCCOA5lkJyfZdNynIHbZ+utZthxiDco
 /M9VPUUIBNqv/7I7eiWKjkaxsw1FAaMAWyPCdP5fYb6jCn+HpF8mrfbXoJuHSoeCngjAfSafMF
X-Received: by 2002:a05:600c:a06:b0:490:b645:3213 with SMTP id
 5b1f17b1804b1-4922011dfb9mr204798025e9.19.1781606639988; 
 Tue, 16 Jun 2026 03:43:59 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa3a8efsm69808665e9.2.2026.06.16.03.43.59
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:43:59 -0700 (PDT)
Message-ID: <6a3128ef.117c96fe.e6619.6d69@mx.google.com>
To: "Avinesh Kumar via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260616092300.177787-1-avinesh.kumar@suse.com>
Date: Tue, 16 Jun 2026 10:43:59 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_security.sh: Fix bug in tst_disable_selinux()
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

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
