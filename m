Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDC6CD4F26
	for <ltp@archiver.kernel.org>; Fri, 26 Jun 2026 09:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782465794; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=TvMeVRmkzqMCwqpq7yZsYF9rjy5Z8YkdQWe0efWgptg=;
 b=PHtgMScg6zCZ6TnBMv0Z7DO1foQGoYwfIc6LwKmAE5Cp2lw5zXh4c7EH31iV7+c1SLrGv
 SZoVft+A8SEgqMBsD7j1KPfKddF28dZJ6dVZqIZeOLiaLbLTtNxdUfqJpZOxj1MO22+sS4g
 4Vp9lMwAHkDfxlWLqlJ3SLTaoBJJdyk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 160213CF91F
	for <ltp@archiver.kernel.org>; Fri, 26 Jun 2026 11:23:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 22A553CD6B2
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 11:22:55 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9A681600BA6
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 11:22:54 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4926d6b177eso1421085e9.1
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 02:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782465774; x=1783070574; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Mf7tiWXFYU/b4Arf2EmYttT3T7Bq84Hn0SY1gR4mfoY=;
 b=X4UBByxMvHcAn6ldAn1Zkmo5lts9TYkukei5nowH3Gej7Ge7E+Y+NdHyxM7R/2ePCw
 tr2V+MQRyqoFPvPDkjftfV8GGwf3j3MTvP6PDmNsJCWYQDBhaWeAdisS/gx47oMLRvaX
 CSgZBvWXBnuFj3anVjuWldzv6xTFD9bExpNvu13HHDhDQ9ivWyh6AaSwiAJb8C4t383g
 UmK5qq1OK8oyaNy3prhCruGezHJYsukfHEibWeLBKciLtNoXKsBtmQUJ8HTRaUad2p7Q
 KRjALj7APQ4+MH/7CyWs9a2HmtcEbcxxmVqXvfdLMsa6yfoQWKfain6brCSVem4T+/6f
 0t0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782465774; x=1783070574;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mf7tiWXFYU/b4Arf2EmYttT3T7Bq84Hn0SY1gR4mfoY=;
 b=MBhgp/wPji2VVzFq23Ci41atKzzZ5oQBV6u3t+yMBQIMXiiW4OP3U8kHzPZVWRJYP0
 Cl9oL+MwXAIetcU2wEza0bKEipwer6fO+A6C0KnIQrnONYZJpD5jrldhXtkWOlM1Iysh
 xLdcvcTokYtkSECeRnmWJn02sEJt+WagRhq5fuhx9B/4prmmzNoItqbws7WVPA4yf34q
 r6HM1gqtQPC870P4EuOAs2Mm1D3jKAlb+l+/EqvnlMoWhhL2Ot8ihyeT4/WRds7TxqgI
 aTswYakGK2Spa0AAqJ7H1K6zY8664Vb2/CwVM02zEiIozYcWGLQ+3p0Vvn0i++sc30bf
 zUIA==
X-Gm-Message-State: AOJu0YzPoY9ZxUFsaarih51zA9kp+BpeItF8TSsxd9tJH8EQ9Q6ZSOHr
 /Z8w/nMXyymgqz4KtGGUdKDdA+Nf7F6KQHXAxghMWB2kUIB8W0ixJy6MaCIat1R7L4dolA/+kNL
 80hDeC7Sm1Q==
X-Gm-Gg: AfdE7cnGgzz50AXNMIfT5lZwDPeWRyXCReGCQK26+HzCNrhxDeJAIsq8J/pQozoBUxM
 3hIWWUHeee5ZgNwxRfkHOpZAq7DoKqdms1gEDD1U9J5DUbsx0iX4R0hnkSz12pcJhOE9KGXw+rD
 ayymVtNf7HAkb78s/vjFoCQOT0bn7kxgJ44DMdQC+Tp5wTyts99WRKa7oDqHBq7RNVBYLh4kNIN
 YUVHEDl0OBvCf6PyCfEj7bgQ0twb8ejkX1hHF2Vuc36P2mjx+aAJ4r7LqS4s7+w0BQQn83F0cCh
 1sgqk4qAPdvO0UCCPSwGjBpl7j+bOriGPjwfk8xvcz5sq+NrjsZhl/Ruyl9rmNi9bEmUjTL+DOb
 xDpWLujWEa9whMoP92wFKpaMC3VWIJM4LyoqcGSijuV1dyIX4Q9d+wYnt8qraSnLKX2ummmQdkA
 054kFqUy6AqwC+erDJxznxuWn6byck8sOukcCWfQAMM/ufQUHeoSYps9TtKXvx9+GSFYNMHO1gM
 3wzQrNUsouxO/hTzoa9QZFJ
X-Received: by 2002:a05:600c:3f19:b0:490:bde3:d112 with SMTP id
 5b1f17b1804b1-49266884ab7mr88670075e9.30.1782465773880; 
 Fri, 26 Jun 2026 02:22:53 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4926c27fcdfsm36707115e9.1.2026.06.26.02.22.53
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 02:22:53 -0700 (PDT)
Message-ID: <6a3e44ed.3dabba3e.304ff2.667f@mx.google.com>
To: "Wei Gao via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <CAJs-1pX1F6+=G=XUBEOBaP9VM7RoCEeLLQuthtUG9HaZMguW-A@mail.gmail.com>
Date: Fri, 26 Jun 2026 09:22:53 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] set_mempolicy05: Require CONFIG_NUMA using
 .needs_kconfigs
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

Hi Wei,

this patch is duplicating what Avinesh was already fixing, so
I will wait for his feedback and reject this one.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
