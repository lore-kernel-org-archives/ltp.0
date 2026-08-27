Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C68BC61DC4
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 14:04:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DEB423D74E4
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 16:04:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 137FE3C2861
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 16:04:08 +0200 (CEST)
Received: from mail-qk2-x01.google.com (mail-qk2-x01.google.com
 [IPv6:2607:f8b0:4864:34::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A652720004B
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 16:04:07 +0200 (CEST)
Received: by mail-qk2-x01.google.com with SMTP id
 af79cd13be357-92e56000adeso11610085a.0
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 07:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787839446; x=1788444246; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VLZy4NcHcME+GQtiPAicqp9UHTL6UU4vEF/ZmXu8MfA=;
 b=iw2FTTCta4INNAe3Vb9eV4FBcvCuQ5D7iQomgh0A+6M/pvOatxl/Zuol8B9o6F4/If
 SGqugyGhGC7qu3zTB25L5vvr4Y+v0gR/6UWoL0icqkDKG7N6b3S+/45aVmXmWBZ6cyEJ
 pChekUInx74DW6l1OTcsa/nE/EpJ/1Xo4VgQcIIorVd0vmcKUdxsWrLlE0t7RlXlJnVh
 WPe3A/tHyE+oFc4K1q3q5S5uMjDSpMCOGJsuFDASteI1AmjTwQRTsche6/FEnWlA33hP
 uKp+ZrQsBZsMVU1vJZGjQ0RvUPpr9KSN1QssNdyGf4VW0F1w158iLahIfcfsKpDM7fTf
 f4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787839446; x=1788444246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VLZy4NcHcME+GQtiPAicqp9UHTL6UU4vEF/ZmXu8MfA=;
 b=rlP04WigeZj0AOadzlNHoc11UhMaokpPr355pcOsWmBHqW3uMFC2jqOZ+Sthxwr5W9
 YXBGbUqMf2dYGiA5JadhWd5E6JDURtX5ath1OpiqHzucV9/OWufDLkO4MreaKYc6LRsn
 sIWwxTRfheC/4Zf+Sqv+tg6S+3JCRLXNfWC/9Sq1xSPoQwc8CZEZKHlkqslxgRbh1BQC
 sursr9ijbHp/byjVfIlP0wFvkZ4exdWmDeP3z+OI3g8DxCNo+D4+UG3VsG+TczfdSKly
 qIYL7+q2Xrg64EUxf/WfPMWLgMsdXLslzY8KzLh6evhOUSkS6W9d0Y0TKQsasztNJH3t
 vWcw==
X-Gm-Message-State: AFuF++ky++Zd3bIhr3TNNgXGSWKE2oOuERotojbvX1oMV47InfpbukkI
 4AqX2YTIS/+OoxAuPzHWyzVNwQc9rS8ptGBOx8YDhS8OOQA30M0imiElGVQe2qhw
X-Gm-Gg: AR+sD120I0kmQU1ioN7wGzf8XweGj4dNMeJxZADKIjuVA81/IwiXjPVzKVDxYUijl1I
 RUKTdNqQwgKoQe/lei9cvmvkS/35NhWwXXXMcLPTUHlwr4ceyhYPmyYin2+t2iYaZhgiUsRRbX6
 79R/R+CeEn/A9/nfx7XzJ9dxIl0I2UczaTI46dsrzliQGeiIWL/AGI36C51teh9s8kxYiB69uI4
 3aE4mfo9N3ZiQ2X1hhAnEiXoF00/sQBY5KJiXJbC7D4kqJBXQfELGG/us2gXnD6pY8Dc5N2V9tX
 iyCdyrmTDo9Jk9lbo9YRU5FHGNo1Tt8nDZkSoR3MiEnuq9O+vHhYDD7nmLijM3766iFJ2kN3ihW
 AoM02gSFYU4dNJoDlhpsF7z/NEA8hmw79xiog3cNEtIZGCH9lf4cEQuo2mkNFvD8PqjfHv9u95c
 ysAATon/tIgl7MdvgKM9g7oZMDXzobLkVKn5IFBcQVjkZiI9lVhAuWj8ngBCrrTL9QAefjqSi3o
 1KXDQ87CqbIQm+a4i5KKUuIakCRu08cojcEr7yxfCF6Rz7qopM7jfGhzlC/BxHiSgcTIl45atDi
 HXI=
X-Received: by 2002:a05:620a:1792:b0:939:614:4815 with SMTP id
 af79cd13be357-9390614539fmr391750185a.40.1787839446066; 
 Thu, 27 Aug 2026 07:04:06 -0700 (PDT)
Received: from
 runnervmgx7h7.erb3uqmdxmruvjrqbzwtgewnmd.bx.internal.cloudapp.net
 ([172.190.109.35]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9377e30f0a2sm455238585a.3.2026.08.27.07.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 07:04:05 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 27 Aug 2026 14:04:04 +0000
Message-ID: <20260827140404.4666-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827112157.1748734-3-chrubis@suse.cz>
References: <20260827112157.1748734-3-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Add tst_sysfs_assert
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

On Thu, 27 Aug 2026 13:21:27 +0200, Cyril Hrubis wrote:
> lib: Add tst_sysfs_assert

--- [PATCH 9/31] ---

> testcases: sysfs: Add sys_cpu_smt01

> 			tst_res(TPASS,
> 				"active is 0 while PATH_SYS_CPU_SMT control is '%s'", control);

> 			tst_res(TFAIL,
> 				"active is %ld while PATH_SYS_CPU_SMT control is '%s'",
> 				active, control);

PATH_SYS_CPU_SMT is inside a string literal here, so the preprocessor
will not expand it. The test output will print the macro name verbatim.
Other tst_res() calls in the same file correctly use string
concatenation, e.g.:

    tst_res(TCONF, PATH_SYS_CPU_SMT " is not available");

Could these two messages use the same concatenation pattern so that
they print the actual active and control paths?

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
