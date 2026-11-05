Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB411606A326
	for <ltp@archiver.kernel.org>; Thu,  5 Nov 2026 00:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=VE/I/RfV;
	dkim=fail reason="signature verification failed" (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=Re2TTD94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1793840138; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=sBiNzOlZRY6XLDYJ7iuMnDkrx3K5xrLdPlrmx3/baTk=;
 b=VE/I/RfVHRX87t7r8nrKu2dz3lanbW8viCEdUyho4UnG47cbqCzdHu9PqLFwC7slis1dF
 VYOWavzBl5nxeqFw+h1n6bOL8XG/LnxIhmpwiHUKhoO/qU/1XD1trUvRg0ujofld6iHOUG8
 eBjrzkkLY9VX86TxALQX+Vf289Iq82s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3BA7A3CD79F
	for <ltp@archiver.kernel.org>; Thu,  5 Nov 2026 01:55:38 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 736B53C67A2
 for <ltp@lists.linux.it>; Thu,  5 Nov 2026 01:55:18 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B0CF3600946
 for <ltp@lists.linux.it>; Thu,  5 Nov 2026 01:55:17 +0100 (CET)
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C5CE63F71C
 for <ltp@lists.linux.it>; Thu,  5 Nov 2026 00:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1793840116;
 bh=a61O0iJ5HP+lDnh/K6ksOdZYDMhnSpGYkWSVJdCpYzY=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Re2TTD94jguKma9Vs1ANRXMlVTV93GLEtusJ0y58HXOtdvBNKH2Fo3ib4zSLyusFN
 o38LB59o1Px4uleL71/zUZ0wiDDcCSILzedGmINcJ84SGuZaJ+N4eAXheP5aBGLLCf
 FRFIGS0IgEu1knGVrmmK2St+5XDx6pLWJ6haR0jpT6A4t/V5Bifp88IAh3zpXe5GFA
 sgTNV4JdiefEOaa5i+JgvHSv6lMMtvccHPDKQ2NiDrigtgGnTZFsKFD0wP3qdzpGCv
 p0uKnVA9RVZoDjZCUzF3mIsFYP9B824B6+ndgpG0z8d+Xh7t7VHv9u0jx8fgcx0v9G
 FkEaOBgmAgiOMrn+qjY4U7A0vEx0woSsJxm838WbrIfeuOadr/DS1OfIS36uAHWwbe
 upsKkSmej/yOHdTYcVe/8b0EZMDagiMU21lKFQovVstqco/cJJ40/6TFINaT/fatUf
 kD+p0tVk6WaI7gCKYiLxKO/DiA9v0KroJySinDAU0OS9L/YzjSMl762aocaWqcHpLF
 pGSY6qi290Le0+QTL1sT1MsrKTmzzQqd1VqbQQFXbinrnt3rey003tXPobK4RSYaKq
 xzmZ3XqLD8UUZVN9OJIY/3HDx/8X9CzlQBaXrgSei9OpZwG3sjtOPR4k9nfLiuw0Du
 Pkoq4izeK4CPwJ8bqeVSAx1Y=
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f1e62510cso336750885a.1
 for <ltp@lists.linux.it>; Wed, 04 Nov 2026 16:55:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793840116; x=1794444916;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a61O0iJ5HP+lDnh/K6ksOdZYDMhnSpGYkWSVJdCpYzY=;
 b=tx9G95YtclPZXR5xJ4Mgpi6H8tK7ED5dNYNUPqsg/6+6rKrKsIr69ussd5fRXWCfUm
 uDTFI5TwiWNd8caOOkznxRTFAjWP8TVnNJSM0LOZkQGCXDzOXz5ig+fCrLY9Jd+yNAuX
 l7+P8q5aUmd4qvkbZkbk5herGKu/WeFUJmn+HuopLlWeElYaXPc67LaciBd0ojwxdXVe
 t8GnSIen6XOY0Lz68oBYMG2V46MgEocs09suz+HbTh8EI7UTWGEDTCVSojPGxxkiJhqt
 epGHRSpvc6MQf+ywXgMjRiWPZxSp50q+zcvpgqnPQaqTmJCrmobtsCbiz0siDAH3C97Z
 6TTw==
X-Gm-Message-State: APuU4Z/Fl91Y5VXuwAJTJN0yJuyT1e+t0g0bSk0TC93jrLLo8JOHMg0a
 Fq9rnKHcxpf9+PYhWeSGaWOTcwybQSu4C1qt8noHFrm8Pu26pab/R0Rv+leA0cj8B38BwCiqEB8
 5HtlX9aeEAWrZkMmE9XsqAT6jGHXMwlu8bceDJLBXVmjDux5E/y1HY25M40Fr8b1778raVcdhn2
 /bSqs=
X-Gm-Gg: AYBFou1LKLL6E5K0JhbD+9tyI8EhiY8Hmvl5JmkcPTG5xamTisDTbtm2sHROg2VXn5T
 9TNDr2I6k0JwXyr/U5ou/MLZX4W9Ni/xxj7ltnaQ8TTlZUZdK57FcwW0Jfjv/32BsmltbTaxygV
 FEf7iIrMqFUqwdNndIshqFCDvO3ah057z3MsdLDWRWTCXFsEgn8R1qX+/9h8ClWQbFSR84GIM24
 FG7UOupwqpstNQ7Fp0JLDDf7Mx8eqtIJj3aT84ba0Cgp7gLP3TKqoUsaQgMkic5pgij6MRUQFbK
 qB5GhRAXr0XZaLVIQszBGk/tl17azYX/BiGEze2YpNBvW38yXE1UOUtbBidcDwXjylRO72e+uE9
 Iy8KiqUoFGaCdYoO6sdiF2XCcTTeqZUsJZeXeCjcWH2OWjXJHTw==
X-Received: by 2002:a05:620a:4487:b0:93e:c12c:9b77 with SMTP id
 af79cd13be357-94421841ae1mr2990380585a.82.1793840115706; 
 Wed, 04 Nov 2026 16:55:15 -0800 (PST)
X-Received: by 2002:a05:620a:4487:b0:93e:c12c:9b77 with SMTP id
 af79cd13be357-94421841ae1mr2990377785a.82.1793840115194; 
 Wed, 04 Nov 2026 16:55:15 -0800 (PST)
Received: from ZBook.gateway ([2001:67c:1560:8007::aac:c224])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-945d468fbe9sm340229185a.3.2026.11.04.16.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 16:55:14 -0800 (PST)
To: ltp@lists.linux.it
Date: Thu,  5 Nov 2026 11:55:04 +1100
Message-ID: <20261105005506.76889-1-changwei.zou@canonical.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v9 0/1] cpuset_memory_spread: rewrite as a C test
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

This series rewrites it as a single C test on the new LTP test API, the LTP
cgroup library (tst_cgroup.h) and the NUMA helpers from tse_numa.h, dropping
the shell script, the FIFO/signal handshake and the manual /dev/cpuset
management.

For each case the test pins itself to the local node, sets cpuset.mems and
cpuset.memory_spread_page, faults a file-backed shared mapping and uses
tse_nodemap_count_pages() (get_mempolicy(2)) to learn the NUMA node of each
of the mapping's pages. Only the test mapping's own pages are counted, so
unrelated page-cache activity can no longer perturb the result.

cpuset.memory_spread_page only exists in the cgroup v1 cpuset controller, so
the test requires a v1 cpuset hierarchy (.needs_cgroup_ver = TST_CG_V1) and
is skipped (TCONF) on a unified (v2) hierarchy. The patch also registers
cpuset.memory_spread_page in the LTP cgroup library's cpuset file table so
it can be driven through the SAFE_CG_* helpers.

Tested on a 2-node NUMA machine with a v1 cpuset hierarchy: all six subtests
pass.

Changes in v9 (addresses Cyril's v8 review):
  - Use tse_numa.h instead of the deprecated numa_helper.h: node discovery
    and per-node free-memory filtering via tse_get_nodemap(), and page
    accounting via tse_numa_map()/tse_numa_fault()/tse_nodemap_count_pages().
    This also drops the move_pages(2) syscall (counting now uses
    get_mempolicy(2)) and the write_node_cpusets() dependency; the task is
    pinned to the local node with numa_run_on_node().
  - struct tcase: use const char *mems / const char *expect instead of
    int[2] arrays with a -1 sentinel.
  - Move the tmpfs/ramfs explanation out of the struct into the top-level
    test doc comment.
  - Makefile: link libltpnuma (LTPLIBS = numa) instead of pulling in the
    kernel test lib.

v8:
https://lore.kernel.org/ltp/20261104071908.128726-1-changwei.zou@canonical.com/

v7:
https://lore.kernel.org/ltp/20261104002400.56841-1-changwei.zou@canonical.com/

Changwei Zou (1):
  cpuset_memory_spread: rewrite as a C test using the LTP cgroup library

 lib/tst_cgroup.c                              |   1 +
 runtest/controllers                           |   2 +-
 .../kernel/controllers/cpuset/.gitignore      |   2 +-
 .../cpuset/cpuset_memory_spread_test/Makefile |   7 +-
 .../cpuset_mem_hog.c                          | 126 ------
 .../cpuset_memory_spread01.c                  | 214 +++++++++++
 .../cpuset_memory_spread_testset.sh           | 362 ------------------
 7 files changed, 223 insertions(+), 491 deletions(-)
 delete mode 100644 testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_mem_hog.c
 create mode 100644 testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread01.c
 delete mode 100755 testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
