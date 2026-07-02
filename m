Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7559AC43327
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 12:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782994502; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=ncg1VKHOZ+hEMRzbz9o6hW6eE4LqGqVGTf5Egl+iO61bxT7n4sLiECNvMsKtPM6sxzhDD
 /ujtNHa/8P9vVCsjMo+JV0VlXFcy36VXEhi2ixN/8hzyg/H5C7VfizTWpDasg3pw10payTD
 78AwcOYToHQD24TvXeSG/EBIBmzhfZY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B66873E4A2A
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 14:15:02 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3ADA63E2325
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 14:14:43 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C83A6600069
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 14:14:42 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-493b1710405so9574145e9.2
 for <ltp@lists.linux.it>; Thu, 02 Jul 2026 05:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782994482; x=1783599282; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=MY+TFiA9oia1sK4QcMjZGI8QJgzInKZrCv3zdtY5eXR0mOIo5erlqzFNPEmyQwjPJ1
 9EhGHfPfdrgU2s8Ecv6z3L8aK7VXO6w9xUOWfbfvPftcaw6RhrnBl3+nkozFY0kRhaCh
 uQ+agEbIqoEte8ib1WVBZczydqKqPiUmsSbZ1rthatPmdgCXlBOz7jvhHX85pi6etVW3
 3L3MLfPBrxSSgkomeXRGe2W2bw0G8xTlUmP4RxEBy3ASWZlst8Rn0purMSUW2RY5jS/W
 VAsg/GAuH03IfQONWK35ONmDe56un4+N7NsCRMAGOOwNY5Kg4Ypy82WVskGC12aW0FnE
 Bq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782994482; x=1783599282;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=DOqXS6HwDloBfj1/FOARl6F7fz8U08meHatQR0vF3Of/gUsXZ3bxlOU9ffEHOYQ2lg
 3C3P1tkLj19OxYepfywOWCy4NY5vzF078PbiKcZs0/M4nJ87EDtwAmXZ9IpVXGZ1UY5F
 azCsN++3wvaTohp/Fr3TPyExjpuGIv6wWg39fuZeGjSL8aN01yJfVj5p/BCByW2BdQF9
 tFZ+/cfj752tY2DfDyXWwsSGY2YY2FynSFZyXjpJR0ujnu3ScYBtQBczF/98FrLz4nlr
 wyiyGVrFu2riiTG+UcVFN46IX7SNmp5ptdvhcv2Ui/MtdN1lG4kMhLQ4lK+TfnXw38li
 +MZg==
X-Gm-Message-State: AOJu0Yw0kCKQMJhrW7PdXXzrDcPcHQ66Kkew1iHh3bcxe7YKi5EexiWe
 GaRnxcwTQDtPkJVtvdj5LWw44vvaFM0k7C5EGrOOsrvOFhNATlxlz2dkbcLiacAUCTCPOxIPJl4
 5fXGqlFlIrg==
X-Gm-Gg: AfdE7cmmzP5D+sGOg2hWUSJ68+PzwS4F2xjpwUnC3uQFmkTNWwlBw1VSNlq9zjVcOgi
 4BygwAsIe1llr7BOlB2JmHHORsfxR01LRc1t+ZFhT0FwJ65QAKJtbmu7sYBH/BWv/Jzi8d/rYMc
 CEr9idD4pT79S5+jz6BJATfEBTEdJ3YMJqZ3g9aF+fVqArdhmGgpba2LO/eYYpe8ZXUvO1eCR9o
 Vpyi71xLH4LfQ/s5q3c1L0e7GM2cUF2fv00pgZ/DG8MuzxoVupVY0kSW3FC0Ke2qUhrKmhi/hCS
 1mZUHiVSXNmSpf9ktpywp/khy/Tj2e7LWi8XqCeBZBRjEf+rEUbxd7yXqd9M1n0kMakfr5SaU9p
 8KXLNf6JM+clOXOKvBgW1wHeHpZa8Dsnx+WMGc0viba1KRyrAtvZPU5/a4ti3LrJu188zK5hums
 Ucf5XG5cEAmHtuBNIltwaz0bi/0K/6mlEERyD7us+JSMX4LqRy1tIq7sKUmhstUg==
X-Received: by 2002:a05:600c:5296:b0:492:6efc:7c60 with SMTP id
 5b1f17b1804b1-493c2b99781mr79444915e9.28.1782994482117; 
 Thu, 02 Jul 2026 05:14:42 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bfe7427dsm78096165e9.2.2026.07.02.05.14.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 05:14:41 -0700 (PDT)
Message-ID: <6a465631.cdeae0b1.16d994.50af@mx.google.com>
To: "Wake Liu" <wakel@google.com>
In-Reply-To: <20260702042505.389515-1-wakel@google.com>
Date: Thu, 02 Jul 2026 12:14:40 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/lsm_list_modules02: Log unrecognized LSM
 IDs with TINFO instead of TBROK
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
Cc: Wake Liu <wakel@google.com>, r.kothari@samsung.corp-partner.google.com,
 ltp@lists.linux.it
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
