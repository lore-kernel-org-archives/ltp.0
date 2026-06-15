Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C55CD98C7
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 12:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781525262; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=C+dDVU4oNYP+78S/TBGEXnrHUlxSOJBet8+PoyJvu30=;
 b=QPi9cstlxfArAG0YiFLTLiRWfV9wu0ecl8jWc50RFHYu+asJUIe9PbIF3GxPjzXz8ZqHT
 QnYj+YxhStxyG6FqlQVwqQ5CrtRtsuV6eTels4QJDT+SfoEEbxts5pMl2CAykXBy/BsYjG0
 0gWqASvz5G2xkFXgPs9iWvd0Tcxty2M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4FF653E5C70
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 14:07:42 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2BF653CD509
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 14:07:20 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 39E76600ABE
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 14:07:18 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-45eec22fab7so1385157f8f.3
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 05:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781525237; x=1782130037; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=8bpFcJFg4jViId3apR8mNEn6rmlFiYOHrb19KHCggW4=;
 b=U7J8TCWBg+6/M+2NN3honuxFX1vOhvZ+xqXLd6OeV10nUMURCdcbdSPyivqxy0Xp72
 +zrdun1y3wf10psNBuNSl/5SYC66FNS5EUBRVzlMsCDr/HC0piM9O38o3KPOLo1UJUc1
 094CmAkf6PQjDrS60vLrEY2arceZzWzg7ZD6Wo/FIl3PJD++m+FFY6JsA3WElYFh/Hec
 N9rkKTE6mG/bXj4aNLG9SaqgpjG4AQs6sMedWJjbC0wmgXZ9YX+w/Te4oM3tt6fTSFlo
 47j81oefNoiVvhW7Sip9nt9oIM2pLvQJKF2YgTtqCNMVKt4XHzq+gskaC072xHdWQO9f
 mcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781525237; x=1782130037;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8bpFcJFg4jViId3apR8mNEn6rmlFiYOHrb19KHCggW4=;
 b=Up3vqyb/RUc51uTRComeW7kIupL9WCU7+yy4Rs/szlKaVnYQLLqVAmcB8QG4Y34OdJ
 lgOcv99S/FN+uNJpVThdB/0z3ic/KyPnzIySIcPYGJdlMh6ZcdIScDfPDwom66gPfyWp
 Ra7XFdvSC6SB+mAPznb0FGaGTXCqNdvCDdWrlyuGfr1cezHHSv2SudihJxIYojA9AyP+
 GdAeHyvAKGmFgRS9VG13tbs243BS3SyqfrsYDKdwyBI3FOssDKpnvLZZmUybNt54PR+8
 6DvgEL60TRd40yIov3GbcrutuElvX6c2mL8w608+I4z4Wf/Ey5vXAIdhygJ753EaQJA3
 PBWw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+DTlZsI6mCecGsIRhDiOCx/rU0i4nlGWcKz1/sftzjtebNd6gFFmndG/XPZUiEC9+X2GI=@lists.linux.it
X-Gm-Message-State: AOJu0Yx56vaNWILRY1CxtpGZah46tImy7rAhpvt6vwvv+7PaDpIfiMH7
 JoXa7zd9ru4Gll6+RbZZyXmTb8Ncj20NESbQdEQkefi3wPYlry+YcVL5AII9qCc5Y9hcl7x8fA2
 B0V05Z70Eug==
X-Gm-Gg: Acq92OEJrePMKhOAoJJ9bjHwI4l/Pibeefs1wtGkv7zYn8QUxYvqV5L3sHXehgvjR+V
 SI43/llMxu+IZ26RGtsptiaRWCIMO3FwphN9XazDnCqkb5UP1QxfwWLvFACvUFQbDIKTUiMCCYu
 7HWwi7mlpouTvhkrvoKFbX08rdxLjNpGXKQRAHFq9h6Go3eTbHtA2dez8IIqGqbCWM7Re5k8xAg
 4ganuPITUoF9SYnMZCO8bbaYj6gWWjTCgG2RB/Ay8b81NmylexkW/7vlChu87p3e41fQzyG87sF
 iW18IXxxt4lt+hTlhv2ZezBTKRZ5reChoQY/n/eEbzrFDlUVTTKDIC5pa1MdNCiOrHLgL02V3kH
 8pwzERB05pKki60IikDUsgQGvDGEx31O2emL/6tN0RJd9aKE6Q905948pcc9Ls099mJ79Qimwsw
 cnadRa3wsV7b0ZplQ1dg5pfO/VlmtYpWftlu+frkX5fgo+aB6c/ozWRra3WniBwzXh0MCzd80a
X-Received: by 2002:a05:600c:46c4:b0:490:bad7:3634 with SMTP id
 5b1f17b1804b1-490ec4fb506mr183451705e9.19.1781525237199; 
 Mon, 15 Jun 2026 05:07:17 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492203bfb27sm279247665e9.11.2026.06.15.05.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 05:07:16 -0700 (PDT)
Message-ID: <6a2feaf4.87c5160c.17b01.f450@mx.google.com>
To: "Sachin Sant" <sachinp@linux.ibm.com>
In-Reply-To: <b8dd71d1-5ce6-4fe1-9cb9-ccdc62058f7a@linux.ibm.com>
Date: Mon, 15 Jun 2026 12:07:16 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fs/acl: Add ACL_USER_OBJ permission test
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
Cc: ltp@lists.linux.it, linuxtestproject.agent@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On 15/06/26 2:34 pm, Andrea Cervesato wrote:
> > Also, please don't define SAFE_* macros inside the tests, their
> > are part of the core library and they should not be defined out
> > of it. Instead, use inline functions.
> I think you are referring to SAFE_TRY_UNLINK/RMDIR implemented in acl_lib.h

Yes

> 
> Apart from acl tests no other test use it today. In future there may be
> additional users.
> Would it make sense to move them to lib/safe_macros (tst_safe_macros)?

No, it's better to keep them inside the tests. The SAFE_* functions are
meant to be as atomic as possible.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
