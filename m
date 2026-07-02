Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4322AC43327
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 12:45:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DBF4B3E4A20
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 14:45:09 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0FCF63C9F78
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 14:44:55 +0200 (CEST)
Received: from mail-pj2-x02.google.com (mail-pj2-x02.google.com
 [IPv6:2607:f8b0:4864:39::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C36BF600658
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 14:44:54 +0200 (CEST)
Received: by mail-pj2-x02.google.com with SMTP id
 d9443c01a7336-2c9f52ad059so10329685ad.1
 for <ltp@lists.linux.it>; Thu, 02 Jul 2026 05:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782996292; x=1783601092; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=myKT/VgK8Xb+oJi9EypX0THw/JYHHp9lpb0SM57XxAg=;
 b=LfebaPi2V1nC2C60Klqeqiyj1mCC3Ds7ZVspfVGyRuYCKinSrsG6Q6DDNDztOepedk
 NShR5Uy+7h1vBgaZPzgis7j55Kq0WINyf54ishE7WSh94hfAE2UH9YVn7jgUsz/H7gZJ
 288KoqZVDLfM5QBLsm9gnX+rh6d52dAmCP2kviCxHQZvt8jU47tLG11eieDNbnXOIIaz
 iyRbW5Y+ZWGyttXuHp9tD/jfJPA13MtWU2nJ73YcI3euqsKxbLg+2Ww+4G23Vq7IecrT
 73+ClwWtlxsioK1q89dVPF1IU+plK6DCS44olfPfdNTr5BXnBWxLx0i7xy9McQCm9PWB
 mMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782996292; x=1783601092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=myKT/VgK8Xb+oJi9EypX0THw/JYHHp9lpb0SM57XxAg=;
 b=fKDG/L7WgRHfNUyay3wjDEflFGUh/lqX8bvMVPIb1IZvHBoYyZG2yqj1ywIX1duKkH
 8Mgu+2MA9fn7bkaZYVPUcki1Fgp7SOcdG0bnMkDfPBECChV7dV1SXbNMRwoJB6BOcQXf
 bCIn2CKgffU1Z07KZ9zjUFbQxyX1LnKpLvZAbcAMen/xJDxJDuVLIIVvTVb+LpsWjbdw
 CeXxO/KF+e08TsW+uI/H8UhGa6YLPQSzChzDWUEh2q4sMKONdcgpverz3f7wMvF5GvQR
 VdW1N059VTd/jyEOWuz/FU2sQyYgJofr4sQNe3+t06LVHMtGaRR0YE1xf4H+64oIeTUa
 w3iw==
X-Gm-Message-State: AOJu0YwwQBfjUxuf3Y7M39ukhvV12WbgsFtLixeXwI17+cCvMdFqXfdE
 Lduh7MPvHnPM1U7joRJ7rRrd1Ciiqry6QjTIlnsfDe9bkxpx5oEA2V2r
X-Gm-Gg: AfdE7cmLsKpfRSWrsjwkhxRrCIZTY6IH3jNNbLqQXQdJ1pAWpfAuRDjGRSo/bqShxBX
 LmL3PVYFdcl5enbMQcIHUm2zSEckL9q/LOrRKihgmCFtUw2L/l8URuJUXBSVyYkgz+rIqMOYQDn
 4fl/rOjt6HSP4ZspxOy1D4Mzr/8ZxiW2NkqKhSOdaLS+BJd/f3VIZBvW1k2YezfU7RG3tlvInHU
 sUEWTM2xazSy/cIOCdy3UpEb4Vs4zcEgU4YYNXvSGo9MBLlnk+nRHtIrIapqRTMGHxhS/IzyweQ
 EKWQ6+jHg4nQvPLyqAUx0O2TUzkJefEpN3VeIXSvZKWQmytYab7zVtJI+3g9rYeQIVYaE5v/EZI
 wxTtyRVULJ7WGRaDtNNW5nZQjf+XX4bqUmpitb4oxlbw1J/OYkc92+i1KCoLMlPLjn/CETrnmwD
 1ucFVXcIvCJEGN792iZsxuzZ+R+UGTNP8eR5eKro9a9ghB6hqErkAdRSshIlSBqyc8fejno38Q5
 wJhifbRgiSLiI6XhoFl44leS0PAXwU=
X-Received: by 2002:a05:6a21:2212:b0:398:6ea8:21d2 with SMTP id
 adf61e73a8af0-3bfed1c58fdmr7650157637.19.1782996292368; 
 Thu, 02 Jul 2026 05:44:52 -0700 (PDT)
Received: from
 runnervmmklqx.dyirjykxpvjepimzttocctglgg.yx.internal.cloudapp.net
 ([172.215.223.208]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0bbd2362sm9893092eec.20.2026.07.02.05.44.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 05:44:52 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Thu,  2 Jul 2026 12:44:50 +0000
Message-ID: <20260702124450.4541-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260404121120.1611032-1-pavrampu@linux.ibm.com>
References: <20260404121120.1611032-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Migrating the libhugetlbfs/testcases/quota.c - v2
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

On Sat Apr  4 17:41:20 2026 +0530, Pavithra wrote:
> Migrating the libhugetlbfs/testcases/quota.c - v2

> Migrating the libhugetlbfs/testcases/quota.c - v2

The "- v2" suffix is a patch-revision marker that must be stripped from
the final commit subject before merging.

The subject should also follow the LTP convention of naming the
subsystem and what is being added, for example:

  hugetlb/hugemmap: add hugemmap33 to test hugetlbfs quota accounting

> +/*\
> + * Test hugetlbfs quota accounting with filesystem size limits.
> + *
> + * The number of global huge pages available to a mounted hugetlbfs
> + * filesystem can be limited using a quota mechanism by setting the
> + * size attribute at mount time. Older kernels did not properly handle
> + * quota accounting in a number of cases (e.g., for MAP_PRIVATE pages,
> + * and with MAP_SHARED reservation).
> + *
> + * This test replays some scenarios on a privately mounted filesystem
> + * with quota to check for regressions in hugetlbfs quota accounting.
> + */

Ground Rule 4 requires that when a test sets .needs_root = 1, the
reason must be stated in the doc comment.  The test mounts a second
hugetlbfs instance with a quota limit in setup(), which requires
CAP_SYS_ADMIN, but the description block is silent on this.

A sentence like the following should be added:

  Root is required to mount the quota-limited hugetlbfs instance.

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
