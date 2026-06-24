Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16B1CDB47F
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 08:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782290510; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=5Qwyc2Jd8d62cBova8mJXZrAWYlVbMWSM9iQbmPZ9Nk=;
 b=nU2M3RYbWDLpetbM4vE+BE+wfbqhhvpFeH7JyJRA+izMjdiUF2ujiAKS4RSZ/L4z8dl0K
 LgOtoYK63H+1bzaN5CMWoy51HzJ7N+TwOdMufD4p49bem2pvCgzD/xeJCHYgnsjZpZJR3ow
 UQkotnhKf1pnISD1L+jOeBk2bplT4JQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 41D143E5335
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 10:41:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1072F3E2003
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 10:41:28 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 603171A0091B
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 10:41:28 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-490b8ac62baso17432755e9.0
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 01:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782290488; x=1782895288; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=JNeAK5TzgXnaEZlT4RhCDmUmdeEsH+TeI6kF9vyyKPQ=;
 b=DXxh4SDvjQ81gtg6+d8vzHirayPWbjm5/Hq4ZiGmWioZqZ7EIJtIKY3QC+1zLQsdFf
 fGCByPrvR3Z5+dv1NN2RMMYSJa4CgY6BXEGDQ4yubuKn4jmwC9yVDPkVE9a8M3DNn+Vh
 lGStuO531q+BSaAttByZDDmNHbcnQ1iX2n375rpMA28vD4+/amR8dP6UXpe3HiKqgvLw
 MzkNm1bnWREBTNTZLUasccBgKYzvhhwYO/5G7lpZvy28IdpoUbIGqUVs625LtoQ0FHCA
 9y7lfJDSHANbZ3aOmRU8wpesuD08Lq0mkrWTCo+ZkKrjKJiJ4mVVBCVg6BJMuTDmei3z
 K71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782290488; x=1782895288;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JNeAK5TzgXnaEZlT4RhCDmUmdeEsH+TeI6kF9vyyKPQ=;
 b=qubBmtB1Yu7n2WhPnwedTM/9TgL5NRTItQEb5FSvhwHx+SmxN4A5jG3eu0OoPcbWfc
 gZwKWCKVh4KGplRN7K3bxtoa6MLMmk38vIKEq7mcd5aOlbRMM+mMetT2fGxu7/MLo0Ts
 mFjd0wUdW7M4PyxmxDiG4GXWWU1Vj4BGs8XeXlya3WTgXXKQYifsnxpv0b9XbTOw7D5m
 BXJgYr8RVwae91UzCeAezrRazXfhOdoH+TOMdiNGnpELYlMzexHh1m24nQornwqqXWx5
 k9C/el7H9o+RLlzDih8sOrTD4GFSBci4USjD5IKdVJ30UesGLVfTNV7AbzHt5NY+7rRa
 /fuA==
X-Gm-Message-State: AOJu0Yx2K3CC6Ie5L7O7I3q8gcdwye4oVpno+wBO38VuwgH2rEoQVqhy
 g/LKABmswu76Cy+gddcZq+7IPQUNAfiggjD3ubgf1gDgZWt5La9gV4XVtoPW0cOAHAKojYGTZCO
 aFv6Yg+MBwA==
X-Gm-Gg: AfdE7ckM8MZZhaL9qDe+LvczwWVNeJF5jRNKrQObnEr78oCSKouMGPsjnSdd0bPa6w8
 XzPfLD+X3+/5FZqbSYY5VpHO3/H+tCJDtff4wlUpckrK9JgA+kg2rPid8mLOHU7SXAdSchcrnv1
 nR1y9FA6qQMmWR9IGnuzfJzeHeQsAY7l4bAu7OHHBFh2NkZJJpJ56MIMOF9w/AJdkhuk2Hsf1+v
 LWCVKyaMNrXO25DSMwB78yt4eCuCZPlVvkwL8jnmd3yBsGW47CdBzvwprSMdHSs6gs93o3pwnAa
 1xq/OkYLQJazMbOJoUYztXd3pK68PwXI793ojm3z17zB0gPIteW+wly+4Bq/X2lK54Hu2zl2fi6
 eVjWOdcvPdGMVQyRxXdNhy/IuyguMopNt+/nnoFh7XycIq5CpEd6lqzwxC6+Y/OwWHMj4jCF9PG
 dU+YAe2Blxk3MfvbaqAYD6c7R4Zn4K6VpJ+qR5GH/yrSWwe8uFnhTrq3jsObFCZ7WVgNX2pyyUV
 MzEMrwTy/IipfQJsKghnk4JYwRznUwV9+RCerf+kwpLDanZ4l603K5hB4E9d/dJ1eI=
X-Received: by 2002:a05:600c:4443:b0:490:b4a8:e031 with SMTP id
 5b1f17b1804b1-4925a09d65emr98579895e9.4.1782290487631; 
 Wed, 24 Jun 2026 01:41:27 -0700 (PDT)
Received: from p200300ef2f13eb007ed17b715703ca11.dip0.t-ipconnect.de
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4924944faa8sm345122315e9.13.2026.06.24.01.41.27
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 01:41:27 -0700 (PDT)
Message-ID: <6a3b9837.ff344046.2fa080.bca7@mx.google.com>
To: "Avinesh Kumar via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260623163144.83028-1-avinesh.kumar@suse.com>
Date: Wed, 24 Jun 2026 08:41:26 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sendfile09: skip on native 32-bit kernels
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

Hi Avinesh,

> +	if (tst_kernel_bits() == 32)
> +		tst_brk(TCONF, "Test is only supported on 64-bit kernels");

Why not .needs_abi_bits == 64?

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
