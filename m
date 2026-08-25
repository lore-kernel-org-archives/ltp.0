Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C2AC61DBE
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 11:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787656590; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=py+3EWQDn3/ElV+8wbNfPVSkbQStYWLq0Hjgfgl0xW8=;
 b=TzP6iFbjtwCoPf4Cl5xx9O+9VXDHVw10CQSI6XGCqkkAxEB4xJvKGvj+MRCfPNEyQO84s
 Qn5MIzACF9UVMLh7A5NnxfIshQ6dYP6mUGTqsSfv5JGSt4RxdgWzVqAImOwKLBQ150dKceB
 orjSI3n2VhhzkqJfcecLTO/GbNoFqCg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D74923C5E50
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 13:16:30 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 536F93C244F
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 13:16:10 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8B0961A00804
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 13:16:09 +0200 (CEST)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c15ca7a7ca9so530179366b.0
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 04:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787656569; x=1788261369; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UDqSFSMAvOR3ETxCifNwyfPXFrbA7OAyF6Qx3esbcHs=;
 b=ATyJ7DD+MaTqst+Q2vdc9ZRU2obBDnyg2nZ4i1BIZ4i5svVgD/0h2VZKasZ1HeO52Q
 Q5grXcBmIytP4QYLRIUX87E6CYdiZp/ZP0+//0F+PxzEO0HeWMpoJbsfPq3izPqyn/t8
 7gpw/6fPvuRdc2IpaMTHy0NKggdtqsLQlEpvBAq7bXLzgYMPx+bwVpABnSnY17Vec6Dn
 UqME8cO71pkp7btniO+PrdmQMFYTx/KYUTp6X5rRqcUI+lLe7hRXLuXGe9nKeOKzV6M9
 CsMFdeFiK9GYwd5Ayco+o71ICKqNW+7i5RPJWccnKQW6FAuf+7y8XoBX0k6g0XDq559f
 /g3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787656569; x=1788261369;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UDqSFSMAvOR3ETxCifNwyfPXFrbA7OAyF6Qx3esbcHs=;
 b=GxWyb9GWHkGstBfm2K1cP//kqnBQBXja9kFzfi5VZ9SzADEcULxnfOOXf1t/EaHJZ+
 zkpvTv5v6oYBvp4syp/spZ61RKorn5mt0uuSYxFlRKWOU6w9DXuBRc67Jj8+aaqFolKT
 zGZCuwrC2P9sYBzfSGeNnD9nVEyHF0v/aJTHaK3ev0NrBQ4w7/3gjPvKRC4EqpwbsJdm
 eK1YuAGYxDzfXOaSeFY93PxSAhjnVP2GFMB6CWff1N5R6Wmw2u5bIoMzvIrGjzIWmoLK
 P2uu0a1UTdf9rhs/bh5gmdaAnhcX9UijB9fegMS457ZLtZNKZoJz3I3L08R2J1oT/TsR
 yENg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrlq+dcFwMzHCMxyWsij60oB9qylQIe8NLM2n6Q/KAnTNr29L4MSOnOBWbTCCTPpfdcXlw=@lists.linux.it
X-Gm-Message-State: AFuF++l6H90YdEJLXiHaO8HC4HUNtm2q+PF69h/kgyybuQPTcFqpsBN0
 nHZlhYbqVuZ49iLUc/3KmXzLyqyRKfp6+nmuUKsNJYNfd2YPAR+cRIuu3vch+r2l1g0=
X-Gm-Gg: AR+sD13mA7H/Oeo+ycpcPGzVyF80CUzRzjdFX+BFTtqnuqbRqC+/Xbv4zNMY4VE+Zek
 i2fxE+1IMslRkLYrnPKWpHj/b7NMCLWr/Jun1ZFYauZh8cPubenEy9iiBhKtxRZYG1luJdgYUc7
 64wtwyNVf0ZJ/rsODGB1B0pbLGKDzwp1rKUsMyZ2V+XHTUOAVbMoP0SivXwkVfA7CYAXJZPYyge
 K8CtqH4noQlWVQFlamwtIHB5jq6v6Sxn7d2CbhN97tVv4NJXn48XeBrA03tKdJ+uKL/Egc/y9DV
 oVOJ1GZKLPuj6SExXEg7lP0og2bdrDhlE/viibc/IehSRFiCUvZjCDtfMPfUNmguGCdJ9t6GDcl
 v21CD6rHEt4OVnE+k6YMuDg6qpjR818LF6wJqkLHzHv8s/prgvY4are7JJ2N/cWI1YHGNli+vnb
 Mt5qTrD5o+Waz6Pg04nMtLik1H6+KcO3jEU/A4ZUNs8bpIQWMZd/E31JL8Iwy+beVabRozUtJ61
 PmnxmNSOD8ONWGXKeR3fNqBWEhNX/ip2BkL6m10lBUHp0A=
X-Received: by 2002:a05:6938:a08e:10b0:c21:7584:fc58 with SMTP id
 a640c23a62f3a-c24e5b5531emr459935066b.12.1787656568841; 
 Tue, 25 Aug 2026 04:16:08 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24d8375776sm675462766b.31.2026.08.25.04.16.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 04:16:08 -0700 (PDT)
Message-ID: <6a8d7978.544c37d8.59786.e134@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260818192956.8788-1-linuxtestproject.agent@gmail.com>
Date: Tue, 25 Aug 2026 11:16:07 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] mem/hugetlb: use SAFE_SHMGET() and fix checkpatch
 warnings in hugeshmget
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
Cc: Samir Mulani <samir@linux.ibm.com>, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Samir,

> Could the checkpatch-only changes be moved to a separate patch? The
> SAFE_SHMGET() conversion is a behavioral API cleanup, while hugeshmget03
> contains only independent message-formatting changes. LTP requires each
> patch to contain one logical change.

This agent review is actually accurate. Please split the patch in two, so
SAFE_SHMGET() and checkpatch cleanup are separated.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
