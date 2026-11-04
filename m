Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27E6606A329
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 07:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=KUaAmd4g;
	dkim=fail reason="signature verification failed" (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=SqbamBJA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1793776780; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=ENqEk9rvxg3Wfu1cHS3Vr+D0LSNd9CbHCEbsHB7r82A=;
 b=KUaAmd4gqeTwKNnE1E8cOS6qbsr231K73LiyNaD0AicOEMFk00emw3rzYygz+OfFUqd5n
 MAo/pGxll6N3FMMhPjJF4KF6cmcRIFKrB9HLVCQiXZjf1JARRO1N1739SOROHSvkEe83qFe
 xuvSlNyxDK4XhO6Ye5TnYlA8sji0LlU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2505F3CAEC4
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 08:19:40 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8190A3CABB3
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 08:19:18 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 38FD31000965
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 08:19:17 +0100 (CET)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 622C53F2A0
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 07:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1793776757;
 bh=WZWp/B6G5sbr8OLAeA+nNPK32C1td9X3z4G3x5TGV/M=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=SqbamBJAQ9tfr5+zZaMIH8d/KMPR6NPnTKhvaoXg9Q+Ln37FIJyw5UbI8VHxuRKOQ
 L2KD9GuWeLCvD4OcPIeKEgR6mIxMgcRv3ywlyR3IvC8rS//spTfGRvQ96orfD+bscj
 /XM6yS05kJbUKdHfnogjODm197U5JD2yGYzNj8aq7Tvs70Kj0RPrmVD5FZysKm3+Ui
 W0NGCbWpW6Q1C0QzSTAbTTaHKzZX57J/XsRIR8So/kz2ewO3/pGlN3rGwXWv5Oa/En
 EkUwynp6qBfkfnRLvCV5CgUYp823MdC9hT6ZvnMafAv9iq+pwfJKLsusGSZT1oORuQ
 fjuOh5s5L2i+XkRg0FHfLLPKrDIvskgNf8QjDes+0XRmt/Utqo+1T84tBpBJhie91g
 P30gRQJYKgYPRi3GKfBh/vOVLtF/csuOHqmtSegVOLRWte3w58EvXcIDihXRZcc0WA
 fiK85qOEMhrXy7fgwugbSyZRFSUjyeBC0G0ZyScvefyAFXsa8j1xBfUWNlTr0nTiNe
 8EgjNN+5xDSVyPiZt8hAUKWSvwmb/V8L+AH2fnzeaGubtNY8IyGhjB/B0cnAn5/RbI
 uTiC8TUkxOm1PvHmSNqBR5MbmITl+nkqhOLJ/nA1V4+vYiPMxm1FFluJjcgEAuBezG
 Ise97RUc/FCPvq6abY3GyKEE=
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cd6969473a4so297347a12.0
 for <ltp@lists.linux.it>; Tue, 03 Nov 2026 23:19:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793776756; x=1794381556;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WZWp/B6G5sbr8OLAeA+nNPK32C1td9X3z4G3x5TGV/M=;
 b=QmC1xKtzfHm9v30Ccxx1CDqzFclaLobBWqpuckGWv9kmxlSuEUNoXjOQ8BDOI/1f6M
 pPQ2aIxz8C0VuLNflVRjw555qPPmV49csA0ZBl+VsaSKzrrNsVgnHQOEJQRVRoQf3uHK
 55t8zfjiC3/KqOMTmT6XNcb8TJSJOxV5RZWD8nkCHX65WJM7EkK4qUR7+3zC0SiMFxoT
 xF+RtGEx7HcF0G2x23TgUbYnSnEc822Ut0zpXCLrlSwz2ZRybU1jETWK1eEEPpUt9Hlm
 QCBl/tPO/bxB2lljFpud+i7wqubKuQRMo7ZM/BiSwXCJ0P1NAy5DJJExfbhA1xg+QVgt
 AnhA==
X-Gm-Message-State: APuU4Z83VfCEHLG++LZfvIep1SwE6S7+wqukKYZfL1steEK9FQ10tRpj
 6OanWUptRLL2ByfrwEd6BACRIOaL5X/mM63wH4sazA69Z+dASW8BU4pCHgPhSHma0mILODxIjkO
 sbpHgPpIB8UCKKwTJNwQ/HAcjMn10i+K9meKBG6c33itarZviNMsxKOpk4tJM88jMi+lR/+DGto
 toAfs=
X-Gm-Gg: AYBFou2zSG+q/x5ArqB5PrxS1ejYAOBtWbR0+S8+MEGf9C+MkfHF9SOCHWemCZsk31h
 K5i3bspPgH9QIfoejGm/Mr9UnlFraLATdiwwtzmTuq/LkoYkvEOx3zF7JhQFVELv9yhriJo2TfC
 1WG1e65qM/ZfjHSTkBKhESWewCKXIb2EUuaZFT9LSSuJzupUgKNaBLva17cxCZgCWjguKPSYs6M
 KQv5vvKSpHrz8t41zESt+76vw+o8LcutDkeef7qQB0ILLlNvtBeJLYYOv8ljTBkIBmN9aFKwbCZ
 553FgMT3NXyEQ5wR1h9ifQ9vFIc/4uwLwlHA/1d7WVCH84++nRj3ffkt/iM0oMz++JEq06Hx56o
 x382zEURExrWA8JfIZghENl6Qi4L5U+XDAXWQqRCSMmJLFVLARl5hHcJ3gEs=
X-Received: by 2002:a05:6a21:a88:b0:3e2:8a3b:98 with SMTP id
 adf61e73a8af0-3e928953953mr12239574637.27.1793776755820; 
 Tue, 03 Nov 2026 23:19:15 -0800 (PST)
X-Received: by 2002:a05:6a21:a88:b0:3e2:8a3b:98 with SMTP id
 adf61e73a8af0-3e928953953mr12239554637.27.1793776755410; 
 Tue, 03 Nov 2026 23:19:15 -0800 (PST)
Received: from ZBook.gateway ([123.208.39.53])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb469282cbsm641400a12.14.2026.11.03.23.19.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 23:19:14 -0800 (PST)
To: ltp@lists.linux.it
Date: Wed,  4 Nov 2026 18:19:07 +1100
Message-ID: <20261104071908.128726-1-changwei.zou@canonical.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 0/1] cpuset_memory_spread: rewrite as a C test
 using the LTP cgroup library
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Changwei Zou via ltp <ltp@lists.linux.it>
Reply-To: Changwei Zou <changwei.zou@canonical.com>
Cc: Changwei Zou <changwei.zou@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The cpuset_memory_spread test (from 2009) was split between a shell script
that mounted /dev/cpuset by hand and a C helper (cpuset_mem_hog) driven over
a FIFO and SIGUSR1/SIGUSR2. It checked the cpuset.memory_spread_page policy
by comparing the global per-node FilePages counters in
/sys/devices/system/node/nodeX/meminfo, which also account for unrelated
page-cache activity, so on large or busy NUMA machines the empirical
thresholds became unreliable and the test failed spuriously.

This series rewrites it as a single C test on the new LTP test API and the
LTP cgroup library (tst_cgroup.h), dropping the shell script, the
FIFO/signal handshake and the manual /dev/cpuset management. It now accounts
for only DATAFILE's own page-cache pages via move_pages(2) (NULL node array,
so nothing is migrated), so unrelated page-cache activity can no longer
perturb the result.

cpuset.memory_spread_page only exists in the cgroup v1 cpuset controller, so
the test requires a v1 cpuset hierarchy (.needs_cgroup_ver = TST_CG_V1) and
is skipped (TCONF) on a unified (v2) hierarchy. The patch also registers
cpuset.memory_spread_page in the LTP cgroup library's cpuset file table so
it can be driven through the SAFE_CG_* helpers.

Tested on a 2-node NUMA machine with a v1 cpuset hierarchy: all six subtests
pass.

Changes in v8 (addresses the v7 review):
  - Doc comment: use :manpage:`move_pages(2)` instead of ``move_pages()``.
  - Drop the local node_cpus() helper; bind the task's CPUs with the
    existing write_node_cpusets() from numa_helper.h.
  - Read DATAFILE with SAFE_READ() instead of a raw read() loop.
  - Replace the repeated do_spread_test() calls in .test_all with a
    struct tcase array driven via .test + .tcnt. CPUs now stay on the
    local node for every case and only cpuset.mems varies, restoring the
    original non-local memory-node allocation check (cases 3 and 4).
  - Check tst_fill_file()'s return value and TBROK on failure.
  - Pass a literal string to TST_TEST_TCONF() without leading indentation.

v7:
https://lore.kernel.org/ltp/20261104002400.56841-1-changwei.zou@canonical.com/

v6:
https://lore.kernel.org/ltp/20260905125041.27985-1-changwei.zou@canonical.com/

Changwei Zou (1):
  cpuset_memory_spread: rewrite as a C test using the LTP cgroup library

 lib/tst_cgroup.c                              |   1 +
 runtest/controllers                           |   2 +-
 .../kernel/controllers/cpuset/.gitignore      |   2 +-
 .../cpuset/cpuset_memory_spread_test/Makefile |   2 +-
 .../cpuset_mem_hog.c                          | 126 ------
 .../cpuset_memory_spread01.c                  | 355 +++++++++++++++++
 .../cpuset_memory_spread_testset.sh           | 362 ------------------
 7 files changed, 359 insertions(+), 491 deletions(-)
 delete mode 100644 testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_mem_hog.c
 create mode 100644 testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread01.c
 delete mode 100755 testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
