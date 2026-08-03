Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8AD7C55175
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 10:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785752112; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=ZYqiI3xvIt40GFg7CbADwffQzW7kmnitCFE9dW3L2pc=;
 b=DF08v8Sww5L1k926ionohNzvJc7j4JbfuVsP3MXga5DKLxuSFO5Ja/sggeKykA4eY0p71
 csy0x85vg/1JkDqNDImSDapAlQYFsbw/LnydOczisj+cgiSIA8uvL50jn69pEQAgSJ3F4eb
 4iRX2OQ8VeSQc4Q4Gqrq7TJPzJw4J+A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D2BCF3E25E5
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 12:15:12 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F5493CC870
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 12:14:53 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DFB0510005D4
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 12:14:52 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4957eefd361so12902465e9.1
 for <ltp@lists.linux.it>; Mon, 03 Aug 2026 03:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785752092; x=1786356892; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jBCVOdOk6oSr/97juJtKGo+GVRzXTme6dhxxGQdBysM=;
 b=MdIcIVcbCjsvEx3nZa/OKY4QPLdOtsOPfSRlZyNyuuD5C4VJyX4Bg2DQE7u36L0vr9
 Wgs6dzzBiXevdnxAmzbQW146KRBypNhGHG5/N3aN1SbzZ202OOEF1jFOe1ksjNpjVscr
 hbj82Fdo28Mukct8TyEZWFthRh1I3MdSttv/achkQYpbh0p6tz4vsyWwRjkNc8K7a9VO
 rp56vuG4RyjXMJDgA2ZZMa7Fene+whSk3y7RYSSi0CEtxB54A2UsLIjteLIkLzU7GfOF
 uscWaj7Qd03L3f14fZ7gFLasxoeeXMTu/LRA1LRpBnopIycfsZ8D4+YPSDfxEsrXT0HY
 11vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785752092; x=1786356892;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jBCVOdOk6oSr/97juJtKGo+GVRzXTme6dhxxGQdBysM=;
 b=AQq/HZqoLcUpctkOdMLeK/Svca12zs0T96cgckcqWL0qHsssKxfBrptn1J8MLsfRO0
 uvnbaYDAthjXW8v/R9wSVVOQoz/wQNHMgOGZHuAiDuy0sqnD3xp9e3OqUcO23cl5KJe/
 KCzsykRNYqS7g0cA2PUCW2syKUXwM9r6IdIFW8pJjwatzdbv57i3fnBZZwLGC/HlZY8G
 g0NpXDXV8hYrdHnHcy+1mMP41XaMKNWD6RpPQ+aBOZUAin1hzXA9i7gqrnl+GhBoat5P
 OyGbY8mFVGua7plLRi3cY6+cz8IG5/9gwBjcGo36I9bJ8RkwJ6YqxUvzTcjLAR57SBjz
 Q/uA==
X-Gm-Message-State: AOJu0Yyi6rY7x2q7hsSbqobYNA9VFV2L8i1AUCzV5ZMhgJV++/Hc3Tzz
 GWko+nok6mIbZi6+TT2YcMn0lwpcWQ8NelQSAZuMaKH2RLMM92Z/uqQr0h759ptXI5c=
X-Gm-Gg: AR+sD12P8btU70ZU0K/GVlvrixwNqDhMApA9G4FGpJDjymWz8QKcfqfPlhGcXwWLRaW
 RSjrp+lQ+xF613KliPbm9s4SmwK5VR4m7l373KLLRKnLp138Hejsg2Q/Bz8v8YhN5DkZJpI9IOX
 hKMYkllUrcN1DD++9TPJ6vYYd8zlyRjmMm40AcJGTUvkRvJJyBVN0wM9pTF4BuLfQDlu5x1P6RX
 p8A1zhbQfYBX9oNBR1c0/En8+OVrii9w/y01vZ1dxovWqvk8lX4sK6Qv6kalqkso1gappe9b3DN
 ickW+TH6hapARPPcWT3sMAOssN7jXD1/M0HjfEZLQG/nxCfgSGlwyxkDgn7+BaBT4e4EC5vrQ1P
 K/9dusFCn9t6v92nC/nBWXr6Lfn3V8euQc7OyZv0amJwR1a91GNkFEznY3hXB5iVIggbMwt726Z
 vyBhKCkoYaL+Q/Y6KNuELxrQVyap56OtAT/ckR08oY2v6ceq2ovnKun/WpXI5tAgcl+EQbuwIDW
 vyUdQANn/U9g5+Vu1MhbIgoIreS8PB6wPyfszcH7LdmC2PcU75aia1XydViFQrxvZsHfGY=
X-Received: by 2002:a05:600c:4454:b0:493:bd2a:93bb with SMTP id
 5b1f17b1804b1-4980c64b6cdmr210720755e9.3.1785752092211; 
 Mon, 03 Aug 2026 03:14:52 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4980878dcb4sm354990405e9.13.2026.08.03.03.14.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 03:14:51 -0700 (PDT)
Message-ID: <6a706a1b.48c5cbf4.13db.1515@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260803094445.GA217746@pevik>
Date: Mon, 03 Aug 2026 10:14:50 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] Switch to patchwork.kernel.org
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

> And (how ironically) atm patchwork.kernel.org respond really slowly for me,
> patchwork.ozlabs.org does :). I suppose that should be just temporarily.

sigh, this is annoying.. I really hope it's just a moment.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
