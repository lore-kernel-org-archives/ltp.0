Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0ED2F8A146
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 10:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776334409; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=5ShQAVTL4JQszrnH4x0FTtyZysXy/uBGx4mXgAbTrRM=;
 b=DX1n0DjBrF/bbmG3q6rQqe+w20kzNqJCKCLhPGyuuMfd0Q0DxdbTBlrdabG7MCGHZtOgJ
 2W9qJMRfAXM7zcLvs6f/6NQsRhIh1M0X+n99gtE0bXfDg6BM4f5Xp3JzOCcze5Fj6l5kKV3
 SO+zrSZmC031gA5IUgjTaWw5PebmspE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5684C3E2DEF
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 12:13:29 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E926E3D87C1
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 12:13:01 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5E93620096B
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 12:13:01 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488c21c636dso47695615e9.2
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 03:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1776334381; x=1776939181; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=yiDk5iQSRZsfgzdH8+26kVffPT3/yRgFqRnUtJTr2XE=;
 b=aZdX3XAsUYFg2znZRGDtAzQFcunTNgFIAjs53qy86CY7kQeE3S8DYnsD8PMIdbctgk
 R9v5w08fVaKf5zNTR6hYFgkcnxZz63fLJcfizBJ71GioEd2zeNDEw5nP+WPBlBK5pOGl
 lT6pTiI9ffTtpGgLa0NS3fhxqfp4j8IfjWVeh1yqHBr7Ih6YUVX1835oiZVTtLHahoBO
 Sh9ANtwUCRO8gQAnu1mcSUelVlxFNl709es3yDYs5hXyxYImcud0lTb8CY40JYf6vPhr
 WawOpkgcgyBX3qSZV9PAS2g7NSKq0bX7bPhDvCS5iWjkF/9Fo+2OcD14R0X7AMz1la2s
 ckvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776334381; x=1776939181;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yiDk5iQSRZsfgzdH8+26kVffPT3/yRgFqRnUtJTr2XE=;
 b=Qs99cV6muiDtnZrd1yd0a+a/NXyab3S7dsiUkPynJCKKu8QEgNSpnM+wfj4Hh1rZOg
 nPrBalEqimNvgf+B51VXoTIlhyc3OCOYJ9Vul9gWNukvxJPCnZSIUmCfJjZ2dWqsUsf5
 M/wgUYHAB+unIU3f9jfXEJfWDD/m/XXWO35kN0Hlot8kSm0hwKAhBhieikRybu4T0K+l
 8VEhbhsmusrtiz9iRD+8j7oxQF6ruBiYdwl+Z6ixE9tCNCYs8bDtY77vRtR4cxZozE4F
 wCMzyxMUfkIuZQOKvaEQXbmP8thxnDflWeQxyws/+xG3o11mnLYjqb9SS3YSQsA8aBYy
 tzqw==
X-Gm-Message-State: AOJu0YygYSfd/QUf5ymqFdT0oz+TBaSL62DehqtXuhL9duHSyywzrhg3
 58Z6u+fuE4Vxt0BEl7gITgin3zKPbOFAv2o4arHc2Tx9A3nGu88WBFhj2GVmjPjCAZo=
X-Gm-Gg: AeBDievq8L62aSOYTFw1h+nP1ZRFR/nQfvqM+uvgs7v5nEHOsL+AWgvxOOyHEm2Uyiy
 Opr6ecUjKrIjhbYyDSF6T8PHCSlotx/sbzOroL/OaoQdIkakdMCPoFKeZF7anFWGT1BrVs7BYWR
 NVLBo6K7sf5Hgsg6JqAvHeV2+5HLq/IhqFt+vl/puzrml7/mBGP+lSDGkUbw53/8GKluEJaLB66
 Daqijz+cGXW/y8gvK4XBtOwXHWy1eQDcVx7vqTgz43VEEd7niddaTsVE3g1gDlRLbCFvGejvvQ6
 fCFv1aQ5FFwx9UcOo8KHajrmrB5fTjC5t6TvetMOFE1srbKAfkHm3oHNOQL+HRYNJqnb5Ihbja2
 e2JpV62yemWR735mnOgJWc8hktzpA/04iLeSNjMJPs9p3A+Go8GZvqdW6oDBWl/+0TvSQPzLifx
 Wvkceu7B2G6ujEfWk8pdpSv6KKdBROn4Ert0SZAMDmetZIfdtZdOb1BgMaHrOM2+ijJRIArsRm5
 zBN9VkG4nbZnNAgWuD3sBNDRkRznpbFp1eE3CaRhbfKGiQvb8RV/wr6CLLcHMMgOQ+w190psu2r
 pg==
X-Received: by 2002:a05:600c:5397:b0:488:b8bc:6a32 with SMTP id
 5b1f17b1804b1-488d68a4765mr351275585e9.23.1776334380668; 
 Thu, 16 Apr 2026 03:13:00 -0700 (PDT)
Received: from p200300ef2f4fc900d2fcf9d9441b64ba.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5813665sm43679105e9.2.2026.04.16.03.12.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 03:13:00 -0700 (PDT)
Message-ID: <69e0b62c.050a0220.2631f9.3cc5@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260414-ci_fix_missing_builds-v1-1-c5aee6b80507@suse.com>
Date: Thu, 16 Apr 2026 10:12:59 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] patchwork: Use last successful run timestamp to
 avoid missing patches
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Ping, this is quite important because the current CI is failing
quite a lot.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
