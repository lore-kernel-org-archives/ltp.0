Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E72C5B572
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 20:45:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 25EA53C06B9
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 22:45:02 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C1E43C70A4
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 22:44:44 +0200 (CEST)
Received: from mail-pj2-x0b.google.com (mail-pj2-x0b.google.com
 [IPv6:2607:f8b0:4864:39::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7230D10007F6
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 22:44:44 +0200 (CEST)
Received: by mail-pj2-x0b.google.com with SMTP id
 98e67ed59e1d1-38dbe53179bso93016a91.0
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 13:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786653883; x=1787258683; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5EtFWYPywf+TsJfomHzDoC8elMjl5fCbHsau9NnEXMQ=;
 b=LKmgojoD1L7WkumOS0uPrj6TNcSjdgfBsdCDjtFzQ2MruLEBezQRAwMLK0YOqOxMvb
 FFAhMYDH/GJGb3uXXw3xKYZe9eUdaDqVffn0MCGB/TJY2pEhiR5cMbuOrSz/vGhc6hr1
 YHpmc5kmZpBp7PNsGhmzNDhJG/Pn0i2iYIGTbZ+tLxXFugkiaaW+YNJrMOhLJo1+0zC6
 /9WTg7J6Qxd92Npb6X1dAG+E6061N9Lg6m2/poFxX344fsENmRDWTJYYAbeLOXC0Vpl5
 ToEpLEJyfUuVIEN1oCjUMMSJScxpXR29jthfNLxEAvR1alPfyFTYtwQfK5HTgOJhbX8c
 VVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786653883; x=1787258683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5EtFWYPywf+TsJfomHzDoC8elMjl5fCbHsau9NnEXMQ=;
 b=EjYRJg5+EezR6IWaEPKGy+S/SigWuQPoIDs2Z1Rhb2wo7L+6Ec5IYEpSosy0XLppDP
 RTc2rev1ZbGGxCgDIYULoSAfhcu3uNe6wxburqF2WuXuKVhsA5KYtRsgy75s57GKrja7
 ODQmNCDDS5ZqCqjnmLu8zTdS3PzY+dWRrrdoI4nbPyikIQxu4AlV2URR7x9gpX5W9ebS
 EGcaw6tw3bbwTEDrDkGUnnkiSOiUZA42giUSswj7Eb8qNb3Z5XFsImhBmx0GEjLongS2
 H823oOA21ILzHwyMe8DXvrQKRNo38MHmCF31YNP2T5LcUczgVmAOvB1vxkD4/pgzQewp
 tSKA==
X-Gm-Message-State: AOJu0YyhW3yRzOrKL2ldDVtB6sHUyowJTW3DyVDW/Ah7xRGrQA0rSxXD
 noADAg/arAWDe8b6sGNOKJub+YrgNROvi47+VYqHTcKPX01bFSqX2UUz
X-Gm-Gg: AR+sD11tphCFHLbHPH/d5EVxJxR2JPdXvNAMJ01+0JLtjgtX/xUcLprwwpaSQnM7e63
 b7hrLXnX7DZ9Tn07JavuLLOc3+a6XPKCmQiu03MIfQhIA0caWUt25AjqFPWPIhmblvs7oAEuOLe
 kiviUve3qiOVdsE7UfSl/ciiYRwEfDvZl39RWZnTE+Lo388gaEOUm8FFHSDsE48Us07gRAyxTBM
 FF74FkW9Z/XaYw/F/ZYG1grM3BQlKLObD2q+JG1Wf+fTP6kR3xKAciP66MxejeR61kxnp27F5nh
 DiZovdhOXmioj6Sk+0LlXvz9qiRlqwWW9RdLXylzTOMWkTSFkYrXNMBJXSi1ShIyC87CtwTIarm
 LKE4Wep4wpMaHZk0k8JQsxLCvMDaWK2DO9WFGM7qUvrZD0AdjbfUyZ1du3uUsMnIciKM7AZ/nLo
 X4KQFtgoz8gbdVbrR9Z9FxUfSwM8QfkdWgIuLubEQok4PvYCPWbx6fVUsWpETFT0kxOoBxZ3LkQ
 YklSHSYI+bBzV2UTt8alyQ2oJATaUSB6TEZoCZ7o0s4MdMH6LEHeVZN9V66vFCYr/dvb+aFVT+q
 BDHxW8dfZKrh
X-Received: by 2002:a05:6a21:7a9b:b0:3c3:9fc4:3ff5 with SMTP id
 adf61e73a8af0-3cc71d4508cmr553422637.29.1786653882794; 
 Thu, 13 Aug 2026 13:44:42 -0700 (PDT)
Received: from
 runnervmvrwv9.5yvi33z0yeoehpnbutyr4hiofa.dx.internal.cloudapp.net
 ([52.159.139.244]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31ebfc37202sm10200562eec.20.2026.08.13.13.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 13:44:42 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Thu, 13 Aug 2026 20:44:41 +0000
Message-ID: <20260813204441.8919-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813195418.3083880-1-pavrampu@linux.ibm.com>
References: <20260813195418.3083880-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] memcg/memcontrol05: add cgroup v2 task migration charge
 accounting test
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

Hi Pavithra,

On Fri, Aug 14, 2026, Pavithra wrote:
> memcg/memcontrol05: add cgroup v2 task migration charge accounting test

> static void cleanup(void)
> {
> 	if (group_a)
> 		group_a = tst_cg_group_rm(group_a);
> 	if (group_b)
> 		group_b = tst_cg_group_rm(group_b);
> }

Could cleanup first release and reap a worker that may still be blocked on
WORKER_RESUME or WORKER_EXIT?

Any SAFE_* failure after SAFE_FORK() enters cleanup while the worker is still
in one of these cgroups. tst_cg_group_rm() then fails to remove the populated
cgroup. After the framework kills the worker, tst_cg_cleanup() still cannot
remove the test cgroup because the child cgroup directories remain. Tracking
whether the worker was started and waking or terminating and reaping it here,
as memcontrol03/04 do, would allow the cgroups to be removed on fatal paths.

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
