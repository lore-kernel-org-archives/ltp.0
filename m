Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7926FF8867
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 07:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777447252; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=ZfVIS7w71fcJLgm0GVFPMonqu8QQVYJdXlPJ6YaQcc94R7gtG2Plyqq5vlkcppVjTXo1/
 pPpUiJLOcKVc9LUn+NU9lrTo6hIP6sxsEOp4wRC79MgYD3K0t8Cp+1XOCtdV4x34AEtjMWt
 hUBctokWbvvvvLk0nOtrHdIprnIM01c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA5B93E2511
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 09:20:52 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 62DFB3E2114
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 09:20:28 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 41873600FFB
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 09:20:28 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso106283615e9.2
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 00:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777447228; x=1778052028; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=ecTNAESOe9qqP/aJsLU+yTygxMUXf0unKlqPIiIqWDb9688NM1clZNg9G1Auu7nO08
 NY3+jnVmvzTzgphF1TE3vxvC7+D/xXzq7BVWYPcjTqoIHNFDR5LXKVGFADQYv9z7WoUl
 B4q9E/08KAntBb1oW29xaMSKX6OftIJshj6IGFIyHppT03pW+7QJNRRLn1urAaXi8ez+
 ivJ/q6u95Kx+tlZuC7jj40lRz8nJcROBQLKetYW+owCGlhb1V8HargQTDnexkg8xosXF
 3u6xqLPwltks2/6rp9AfZUsykz3/JG664cuNEHtDYRX1CJo4/UdhwPBUxkQFG60vRU41
 7fbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777447228; x=1778052028;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=hfmRjx7tunKQnX31qt2iRlHT0ZUX+dcx1uBBBJPHI8323l0DfMYmR1ZVYGWV6L7Clq
 zpUmUvP1wS98jRwaI+ao0MYKeM2JCbdLBo9L2GZVwaqCHXdqH+L9+a2ptuEofs1DaKd8
 GjahpDqFli+QULJkVOEs/hItWilgJa3obLupGN+YpsVyftDaSH2++xfG5WqRRtC1fXkh
 UA8fAqIEZXujSEGf660SIL6FTTOWXZDOvy1y0N8Q68Z1PEYvsv7GM/CzLoTwKqC8+8jP
 oARYql0kRyoA6rc+cb66SfCVynfW+Hu3aMaiGshhhkdMssjtJzVrUiXwUtaP2Ib8jrHI
 6luQ==
X-Gm-Message-State: AOJu0YxZEtlFO6o12QsbB0mNWmwJ74cjX/BUzHsUmd7m2MVAn//RZbr3
 +GZBqny7XmTod5294pCnxY+o5bYs2AwKVFk5s0VL6CyrV8lw9qq817vwiWPV5h90on4=
X-Gm-Gg: AeBDievTnkWi4GFPk4x+xJv/hdYRS2Oum+iCiF9W7mCgdTLZuLPuaHaJIvmYvJ/ySJw
 wbqO3F1jhJpYwsfvw/hNrfEbHEEF84tQ9Z7qETB5rZrpfhrJ9nzL7kkPr2cT6GgwDukqBLWD6tM
 GAAEosouBAVTgOrohMOtrr1QkXNce4yIUVyee+ia9sGOsqfpGiQa/EGrEPPMJZSgs+EhPJxtSo3
 RDOuhyF2XeHwp5ht3ZeU5Mq9QECUUCHvtebfTXqCaXJINrTfz5BDkimHF3dYN/LLEj6Lr71MQPO
 wMRR1VPzl6VURVkxOC3ZUZQiesnhUbBUpBlKvjhGmUxLviST9K6Ud+5DgHPK41QR913SJT8Oy6O
 48SuKYHA52bv4zgam9Qc0gd8RxjSwArMtry6MRyj2v3twZNypKuDWXYJT2PoTbRP4/1z6d0Ls+k
 SN+XynK45LtV05iHVdJwFu//3ZShYgvDsBXDR3aBjRn1fcvm7r/P2LC2fFC62L65cAlknnXHtTo
 lBv+N8+qIc/20p3YCePEbDUTesz+J4GswIsGGxjY1m7YydVHxRYxzml94ywYS1XM6m2Sww+R+mA
 Hk1JWFLq1uVk
X-Received: by 2002:a05:600c:15d1:b0:48a:55d8:7882 with SMTP id
 5b1f17b1804b1-48a7b8deca0mr21817975e9.9.1777447227625; 
 Wed, 29 Apr 2026 00:20:27 -0700 (PDT)
Received: from p200300ef2f4fc90003f4f7286cdeff7d.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b4216ed6sm4357052f8f.16.2026.04.29.00.20.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 00:20:27 -0700 (PDT)
Message-ID: <69f1b13b.df0a0220.205d8b.1407@mx.google.com>
To: "Sachin Sant" <sachinp@linux.ibm.com>
In-Reply-To: <20260428143614.69724-1-sachinp@linux.ibm.com>
Date: Wed, 29 Apr 2026 07:20:26 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/2] doc: generate CVE catalog documentation
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
