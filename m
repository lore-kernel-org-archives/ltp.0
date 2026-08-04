Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69CE2C55172
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 07:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785829213; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=uDRw+81qFFOu7AJk8bDmaAha95lX0zuB115E97AnmdI=;
 b=ahKeqRSMGif+CvX0JAaleqlVkKzWR0HHWfFDq1cZ+Lte0RR0olP5U0vXe1XIuVWrCQC/j
 6P6El3oCLVfirT0Zjf131EzNZgwXDo85MeWJkqd2cLj1YMmkf0R/GoJ7tlJ71pRqcSTuVIb
 JQDkSJ915WvxrwctmwLwv9yTu4zRrUY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 917EC3E2E5A
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 09:40:13 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 767793E01E7
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 09:39:54 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4194D1400346
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 09:39:53 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-471eeac43bfso4020721f8f.3
 for <ltp@lists.linux.it>; Tue, 04 Aug 2026 00:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785829192; x=1786433992; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=py2qWg9f0H2FPX6r5VVFWT3e3wr9jdL279qz4/xXHQE=;
 b=OLKyxySxwUpqz9Zxp4iajmA4+OKlEgCA+H9p2GIOJPeCO8H5iQ3y0U4bjELcXuHtlx
 /if5l7F1XCYQmKlCu8CmHAZQDlSLKlHxGisPRntJ76hZet3WUPg+LZ+K481f7RGdYHII
 H9g6+hYBsI2LCsiGGUTCh79CQc8uAsG7alPN5oTot0+5emHub81lYWevZt+KROfltvUI
 Gc6+bk5UOMIVE6ij/onZn/fRF2RH4EN+BEYiM9XUvC5duVSKHp8TMsluh4YbdThioHNO
 b+FulkcbE2uTl6+KEiy+vBJGLicXZIBjbkKTurbJJybGl43Q2G+GC6JOhf+TRL9x1xeU
 63MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785829192; x=1786433992;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=py2qWg9f0H2FPX6r5VVFWT3e3wr9jdL279qz4/xXHQE=;
 b=lZOjqxRRnPmCNEOu6DFsjEbvWqVDoPuW7sx0/3Q2eBNt6OEuYj03zWRlLRW+cMLRbm
 1WPAxX9mtwD4ytfTbHa4RyfaDUe6zHV6OI7ohlISIK7TjCJODE5vOkIbaiDkc5vctGyq
 2tBtk5/Q5ZMFavHSbzs/cHU5iN8a0zJtCzxh0dm/VuaypvZTNaLLMl2HHJzX6ZpSAy19
 XIx0d8xjd6ciaGTQc8aANEmZL2oMZqX+OI0v28f3ROvqcW8P7gblw7r0Ovb+CXPnyWy9
 PwfhfQNkHWjscR3aswKDTyqTsfG6BpNgwVmTiWy+nWPiNDv3FcOfK5OUHxg27yv3zOzT
 fauQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqgr/i7W14Zvk2b2qUlt0UUMukevlLU8AzK2C2F9SVok8wpgldCRbr2t7QDBPLNICl2G+8=@lists.linux.it
X-Gm-Message-State: AOJu0Yw0mhOYsoLDLxTuxlbqiHL0jZb1wuHyYkIV6qLvaYO2te3CvpGv
 Prkdo16EomjBE5K1JtgF2jGZsYWQBTJ/0XmuheS4HLEjtE5CyLvYxsool0bxUzN3V90=
X-Gm-Gg: AR+sD12XZKAMlHiX5qrZdhW7cxV0CQa3GTKNeSYZEhLEevKdMTsUMmgK5Fq8jR44LXD
 /HazjiL6FstR6+cAplgNlaYS1hx+yO/L2uFzmowyMcHJ6KBWLRi4NEXIuhIe2U0NbNqFNrzgMK2
 tYZW3gw9EV+QBeEQFisJLd4hKYn4zFop1GD6eVa5nR7iM5jPTtBt4wNRKxc3Cqba6jeFTx+YMiU
 5frErvQnePlgxtXE02KHyq9ld+6sDeDq6BqHE10URfuHXV7KROq4fS/QlwfN3iAKw9XPq9pJZ09
 G/5s9hkFu5lJTKlPkxD2pQTDZwBHCdbT35gqBxBXVGYG3pxQhs2Z2DiGTbgnmYDQEiNQdKorJd8
 Hkxz0lT86x2IbO6SZD8es4ZNHDar/57U7j3mNiRcwOdnd6TuuOpJB+WTVRAOvPTvLp3xvK9wncQ
 rlJU39Rxf/oWS64Q5Lw2TddfZ5lFksSYV+NzTELg+uBnwabusMhJN+gQdn5r9jhwjp9ib6bNqTZ
 cS5wrP1brcHcHf6gFDDS1ryCdXM1uw+rDVkI/an68icqvYS0obNcsIQY7t8CXZgrgL5Wcs=
X-Received: by 2002:a05:6000:2086:b0:47f:5ec2:d54 with SMTP id
 ffacd0b85a97d-47fd729e7c3mr34268349f8f.5.1785829191049; 
 Tue, 04 Aug 2026 00:39:51 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fe742936csm10372936f8f.31.2026.08.04.00.39.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 00:39:50 -0700 (PDT)
Message-ID: <6a719746.c69142e7.53fee.2bc3@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260803143824.9095-1-linuxtestproject.agent@gmail.com>
Date: Tue, 04 Aug 2026 07:39:50 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi/prctl: add more fallback definitions
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

> > +#if !(HAVE_STRUCT_PRCTL_MM_MAP) && !defined(PR_SET_MM_MAP)
> 
> Could this struct guard depend only on HAVE_STRUCT_PRCTL_MM_MAP?
> 
> PR_SET_MM_MAP is defined immediately above, so !defined(PR_SET_MM_MAP) is
> always false here. Systems missing struct prctl_mm_map therefore skip the
> fallback even when HAVE_STRUCT_PRCTL_MM_MAP is false, and the second patch
> cannot compile there.

I'm having issues with this, since it seems struct prctl_mm_map gate it not
enough to ensure fallback is not replicating the original one.

> > +	SAFE_PRCTL(PR_SET_MM, PR_SET_MM_MAP_SIZE, (unsigned long)&sz, 0, 0);
> 
> Could this test set .min_kver = "3.18", or report TCONF when this operation
> is unavailable?

We don't support this kernel. Agent is going really deep with this, so I
guess I need to add a rule to avoid checking for versions below 4.4.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
