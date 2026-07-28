Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E653C53219
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 07:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785223076; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=c6s9jveQDaRLmrwWXVx7taIfASXc8eyIg/3HhT8tg0k=;
 b=aR7i10/+W4MDbQJkR6PYEbPDqpG4iL2TDPwurAgXrC9Kx5A2fGKrB9qoTOL7IHvxqerHX
 f7wKZgVK032XmIJow+Q5MXtRhyhMNCS66lp4UqpJReinrQxC3HJgcTPB+qmiXLzK8XBAx4O
 +0cx82GeFv7WH2DNFjbBaR8zcHsFtVQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2187E3E5239
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 09:17:56 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 815393E4EE9
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 09:17:34 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 07DE11000941
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 09:17:34 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-47f96c5b722so1960269f8f.0
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 00:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785223053; x=1785827853; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zxTv51hqjclRin7ZHl12YSmGk57C/o9s9ZlI0sLfAfU=;
 b=YVcTYehsyj1jZnYcoaJsfwVmUQPfrdrMoh4uEWndO0riAG0UbEe2xJF5E/A77rK1uD
 HDeMFV8ZFhux5KaKXPv/IvYIOBmNGSmsAC4CWCFWFJ1zlH7+vpKsndHw7kWKcyt3RG4Z
 51uTsg82ozz33sAPhKxRzWq7uG8rQb63evQBP3AEBN5MEVCTWTZzYSAVaA7c5srB2gFb
 2ruQB6lTwDdmbLwAqeeYx58+zi4jRjTY6Dk40C8+em/4sRbbAQ1D4B11TAiJEF1ejori
 ZOoM1z1onFSNX2bSjBn69PVdMhy90CH1+gDxMZbhetNR5TbfgGxAJQ1i7w6NEX+lsXTh
 5TwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785223053; x=1785827853;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zxTv51hqjclRin7ZHl12YSmGk57C/o9s9ZlI0sLfAfU=;
 b=PK91VSuhH2uJnX9bUXXTrVA5vbi4NCuB2b3Lk4vv6P7P7SI2U0j0NPXdpZ0gVhZIDF
 qWUqxb7KBPYogD6Ic4/hmPd/s+HwLfhSbGCBfzVAo2ij9kcnZV3ohrKLEyyO0GaiAtiL
 zoFyVig9a/C+GFPkA3e0BjTLBsd+YlsII1BsJJxDR52oXMpLa2CLzpnYM5B98Xvyzudt
 sUHNIqeEFeaFjk6fl+rohWfyPMZ4Ro7JvTASsOkfUESHG7ItVBl/jf7G7aLj2/WYlxz1
 9JCBHqbSyLnd/dGgavnUI/iUMz+LFkHImKAxyZdw5hwABIz1A+uNdLQI+2pzrVpQRlHP
 MssQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpsk13K/o4G0e8KbKBCOXfbfN7GdVeYd1So2SKtvHtrBPzVxen41YuoYW1fnVgs/U4D6tk=@lists.linux.it
X-Gm-Message-State: AOJu0YzsKQodqR7EJdB4ZB6neLqytKZuJzZxGoVocDUrDf+TovD6ffcn
 7X6K7dGPUkZndmPQF/WYU0Nnq6mdoNI9sCfLpW7bFReRBUOdUAg4qePYBI93tTNvRWU=
X-Gm-Gg: AR+sD11cDWUWleerczVfrZ/hIRzCDmUrOUkxdS6TFd31EzYqUDwPQAAa3GejyaerB2M
 tiTx4V4nNQt7fUp3buN1Na/zkIuFGyEP1Cr2EPU6evW1BGlG53699X8dzZ0wfgSITGj1ivU80Uy
 Z/AORS+Fl9Zd2KDCxqIC8+qswTEVLJKtx7Argxn7bMNN6wWz2q0Mh96rXDAgde/vxGl35r2iuFO
 pRsWnzPPvJzd0X/ANNZU5FstT6tXN+LWkAYn8YTPogrfGZjppbWmEdjpX8SZ+hwa1uLZkaG/NYJ
 ospCzvZDmM11KLrEBJkcG51BdQTnJWHRy7IFM/Pmorp/iXBAWCEwtGiBh98d3geXbHCQ1i+Jinv
 YH/w1s1UC5VvxYuQf6t1rD1ynRNhZQepLoAQjVV8hLox9jniUt2Crhq84LDMbHaoXGaFRA/GjVN
 b+ezv5EWksVCZiaHnT9qseQZaaYA==
X-Received: by 2002:a05:6000:3110:b0:47f:56f7:7a57 with SMTP id
 ffacd0b85a97d-47fb1f13877mr1158943f8f.28.1785223052993; 
 Tue, 28 Jul 2026 00:17:32 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bb5a46sm55006129f8f.9.2026.07.28.00.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 00:17:32 -0700 (PDT)
Message-ID: <6a68578c.53cb9477.64730.32f1@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.com>
In-Reply-To: <6a6207ef.8c9cee7f.1e6be1.04d9@mx.google.com>
Date: Tue, 28 Jul 2026 07:17:31 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add test for CVE 2026-53362
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

Merged, Thanks!

With suggested changes

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
