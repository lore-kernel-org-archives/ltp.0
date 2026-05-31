Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E471CD4F54
	for <ltp@archiver.kernel.org>; Sun, 31 May 2026 00:08:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7CEC03CFC0D
	for <ltp@archiver.kernel.org>; Sun, 31 May 2026 02:08:43 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 620C73CC04D
 for <ltp@lists.linux.it>; Sun, 31 May 2026 02:08:26 +0200 (CEST)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B9E48600474
 for <ltp@lists.linux.it>; Sun, 31 May 2026 02:08:25 +0200 (CEST)
Received: by mail-qt1-x841.google.com with SMTP id
 d75a77b69052e-5174a1da4b2so1906341cf.2
 for <ltp@lists.linux.it>; Sat, 30 May 2026 17:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780186104; x=1780790904; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K0p1xL94XVUyfNLypIrV0NXSZ29d+gTQ0wMUhl50p3g=;
 b=KivGJfhW/6ZUBfEEU1OLXKHQ8euSa+Kxy4vdoqUs3QicSXjxqyFoIMgF8u09tYG/62
 TZMzByh012vfYn4oPGYEL8UtXdPt7fMJImPp+AANgPxWHCrIib7K6ZYsOxr5noFIJS5H
 t6qki2xBMYlCSU1PCxFp+4Q6FNwpv6Jc5+FUpKX+mjU1K1FcCHVlK88bVQE7lI8H/UgO
 PR8/QSOMBLXOskTM+F+KimjAzYtwIp/Rqo8NKZDcs66ERLi424mojvBqiKysQsLr2zGy
 Mc5Eoou+1f7QXsIlQ3UIZOiCObLEJ9hFkxPvwnXTQlppZeKG5OItTcklPkBdHD2qi3qi
 RsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780186104; x=1780790904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K0p1xL94XVUyfNLypIrV0NXSZ29d+gTQ0wMUhl50p3g=;
 b=OVQKbBvoCc5k6DFWe6PSAiFnxum93TjpkFg6g7RJzCljgQm4hElvbcqkJa5dXfyZc2
 xolRaov+8d5nn1yL4qm6XvG+VoUnVf4XafXQeuuFOyPLguhS3e8l5AmMmHre9++rY3bZ
 /0FsXmkM/BTh/syxPGgsvUKZxmuExlPin75gABRgucROwG1CQpt/tN+kQCFG1dJ3ZWx0
 GoQA0/g20jjyGxOH9ba0P+7YcyTS5oPr9jNyg+tLBezXVpRR1qZI5syBThBHFGOZ87ZM
 C+0aM/QQCd6tv64e8/w98hg0hkeHVkg6Y5Mit+txgt2lJcfEHINu7GRzYgA5GsALgv44
 y4Rw==
X-Gm-Message-State: AOJu0YyTwgkC+o2oZdtn69M1/p3GwmdvieUxpd/pN5seIxEJK3ZATxs/
 a9xfic0FUN6NzfKrYLI1sg1Z4p4LogRA9J6C6Aua5CBXx/qFRSHiFKm3
X-Gm-Gg: Acq92OG0KSHg+Huw4VPFjCtyLr1KPUxYwrnn2gqo5sE8pEg8EzZrgId1Ooy3iXGiI7o
 1nlLSItY8gE3/CujkgHBXW19Cp/N+HcyMW+aIWcKMnN0FunU/akP4Me1dodAmhQQLbmEnqzn3BR
 x6S7HVGK02fxAciCxpK1OfHtkW8k/ZKdwO2rWiSsw4NURK52gyWpZ/JdjdWj2kBO6SNZ33Wal+T
 HS6wj0Lu9RGul+dHoBRtWl0UNuIasthtRxQDqWIlR3ZytTjYMEFoJpIzzoT92u3zzUUKbZgH5ne
 Gv3eUDXtCzzNpHU5Lfn9bm9qcPeV92lIL18Qz1bZ3rgR75YD/OlBueS2997pOKOTt3TfDvyz4kN
 O0Bk/KhR+nurjEqWgWeqv4i0cXvjwd03ZL/H7EEOTT/bu2f0VTjsyvY9a0FEGlxa5z6cftVZcq4
 O9nA6lc7dE9ETnsHOBUtYaVwv9161Jaoxd6aatI2jBZMu6nNbzHfM37XWSIArRDn70qhf84DKp6
 SUEFyb1B2vcirvsUXDS4hbVb2u+a1KV2yh5aFuKwmxp5gVSe4U=
X-Received: by 2002:a05:622a:411a:b0:50d:9c60:fe2a with SMTP id
 d75a77b69052e-5173a61b9c8mr78971811cf.1.1780186103935; 
 Sat, 30 May 2026 17:08:23 -0700 (PDT)
Received: from
 runnervm3jyl0.vuofcnqkcubu3oy5yogz5ckase.bx.internal.cloudapp.net
 ([172.178.118.80]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51741de5b6esm21047481cf.30.2026.05.30.17.08.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 17:08:22 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pradeep Susarla <pradeep.susarla@gmail.com>
Date: Sun, 31 May 2026 00:08:21 +0000
Message-ID: <20260531000822.4114-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260530234123.1718-1-pradeep.susarla@inmarsat.com>
References: <20260530234123.1718-1-pradeep.susarla@inmarsat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugetlb: Migrate library and numa helpers to libs/
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

Hi Pradeep,

On Sun, 31 May 2026 00:41:23 +0100, Pradeep Susarla wrote:
> hugetlb: Migrate library and numa helpers to libs/
>
> Consolidate two test helpers into the global libs/ location, following
> the tse_ (extended, non-core library) naming adopted for libs/ (tst_ =
> core lib/, tse_ = extended libs/, tso_ = legacy):
>
> hugetlb library:
>   testcases/kernel/mem/hugetlb/lib/hugetlb.h -> include/tse_hugetlb.h
>   testcases/kernel/mem/hugetlb/lib/hugetlb.c -> libs/hugetlb/tse_hugetlb.c
> [...]
> write_node_cpusets():
>   Moved from testcases/kernel/lib/numa_cpuset.c (libkerntest.a) into
>   libs/numa/tse_numa.c (libltpnuma.a)

The patch bundles two independent migrations: the hugetlb library
(lib/hugetlb.c/h -> libs/hugetlb/) and write_node_cpusets()
(numa_cpuset.c -> libs/numa/). The two changes touch completely separate
test suites (hugetlb vs ksm/oom) and have no dependency on each other.
An intermediate state with only the hugetlb migration applied is
perfectly coherent.

Could these be split into two commits, one per migration, per the
"one logical change per patch" rule?

Pre-existing issues noticed in the surrounding code (not introduced
by this patch):

- libs/numa/tse_numa.c in gather_node_cpus() -- the trailing-comma
  removal `cpus[strlen(cpus) - 1] = '\0'` is reached unconditionally
  after the loop. If no CPUs are found (all offline or the node has
  none), cpus[] remains empty, strlen(cpus) returns 0, and the
  subtraction wraps to SIZE_MAX, writing outside the buffer. The guard
  in write_node_cpusets() checks strlen(cpus) only after
  gather_node_cpus() has already returned, so the write happens first.
  This was present in the original numa_cpuset.c before the move.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
