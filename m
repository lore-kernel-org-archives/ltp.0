Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19E6606A32E
	for <ltp@archiver.kernel.org>; Thu, 12 Nov 2026 10:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=R6dUt1f4;
	dkim=fail reason="signature verification failed" (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=omHGrbve
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794478880; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=g0mMp/E+jHm5G88OQKYU+bS2h3qhudz5iEtdeb0L1dk=;
 b=R6dUt1f4q3F8Sf75kxceQzKC5L4c2IvjFn3+EEPOOZNOfZ+iAKU//tSJqpQNgbICrKURh
 Gf1Q9HvoXO4gLqwet1gXHfPnDBsz6lvKb20r0Ym0ZD6WEDsKV9mWA+oJKna3d7nOJU8pYBr
 0v4494jn+1DLLvVm2tx+2r73ZW2rcOA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 99CCA3EA098
	for <ltp@archiver.kernel.org>; Thu, 12 Nov 2026 11:21:20 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C1FDA3E94DA
 for <ltp@lists.linux.it>; Thu, 12 Nov 2026 11:21:00 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C7C711A00CAB
 for <ltp@lists.linux.it>; Thu, 12 Nov 2026 11:20:59 +0100 (CET)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AF4893FB76
 for <ltp@lists.linux.it>; Thu, 12 Nov 2026 10:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1794478858;
 bh=Ak7pHWMRWO233TPonobhPJG+xYZOwWVAccWpgLWLBgE=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=omHGrbvenqvC+lL7j7tilquIILh4f8ccWq/yFBg3k3KJI0CAj6xFsWAcOo2EURjxF
 sBxJG3tnaLG2dXJR+aDqZ07Wb/+uLaDFVfq1xAibRAZLyDVbrQ6x7Os9Y9IhrHqL2q
 vvrUEAIorqMFARiMZv/hCTEhkqoQDliWRcpfXowrCcQ445Ztw1THGMpDtknl3aOuTB
 Yo3NXfx8rCOdysZjkxF0azNzWTUD2T03o3ykSEU5jYk17UX91/bOQrurj+6AbKlLKd
 boookIww9K0lftT31Sqj8BLXuCWTWcK9zwI8cGGj25DVJal1I5bVksQFPK9kvemAVK
 sAlxtTQKQOtnlZla7+volmIoy+g2g1R8Gd2wupW1dJuHCVEgVCr1J0FCWJJdSfclUO
 Bu8SSPriVSYtFlJE0fFWX5cSpkU3E5UeNeWhVJbUfrKieOKr9N1AU5Oovdqw2e9f8Z
 cb/shLAPM8Y24AIhMqOp/iHDey4elRFy2GK/xgrnelNQtrJCvW3Zbgl3hLwXSqwiP7
 wrM91TuOm8AOwao2Er7j35nnP1vvhtv/C4/0P8E0fRlZ8ZHAKKzb4Tlk0Q6eu6Ss90
 A+aVpoETnBToR4Ebr03GI917PoyHanbOqIwIO3Lbo3xwO0BEEU2O/I793i9BKGiAS4
 JsheTIQbwtbRXUXRn0YMz4CY=
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-89e96c03cd0so3749971b3a.1
 for <ltp@lists.linux.it>; Thu, 12 Nov 2026 02:20:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794478856; x=1795083656;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ak7pHWMRWO233TPonobhPJG+xYZOwWVAccWpgLWLBgE=;
 b=o4yaljMPKmp4P2YCRfqLXlyfK5yNaKS37nz01ULk3kkRuYUQjJ0Ve00/zdICX/gqTk
 3idjoxGygDgzhQBCkcNGF2HxgOewXMHPS5ZG/FpxyPZVCC43UzE9ZrN9/fl5rYUxKcPn
 5B+PsL9KwaOWtcApC4Pk20zQX/rUC4aHwijQrdsjzM4biR1eLvY5HVUUZ9oI9KIi1fWG
 zQ+fEx1jdQtIAE7F6oI1wft/EcJHeLtaXCUbwPHdH1cXsftZcghHcAFVbpEk3RrgTYCm
 2QlzyvQ3Upcwev7dakrzIKKsveTq4wIazVx7o2fyZN6ZLwXea4fyXk7v0OWVWFvfQ3DW
 vs3g==
X-Gm-Message-State: APuU4Z/mwp7nW+MXYMyNP63sN5M9oSXrKXTnVQMgNF3wqB/ZXioUBGOm
 p8zuZbQWQDCW6NDKZw03+lTN6NaBxvi7cideXdjFe3iWx5+BmiaD6F07vQi3JVwTXfC3vDJG0pi
 tZmt/+EO+z9UuP8b99bjUCPi6m05Ns91Nc7G3n8CY3D/ztFf+5i0y3s9uYggfdQS+5VcGv14NzM
 DGzjI=
X-Gm-Gg: AYBFou2fgJvVsIHXOOHO9HH4gW9tUmc99v0TIYNYfkOwFtCUtRiYfFt6jWGkV5e77Yh
 r0JmqjzQN6ddOWfJqjIdgXKBhrVXPW2uIInjFjPxMkC4JCpfy/+lPwe3e6wq/Uv9YII9jYujr+h
 B/NsGSv9CZgVTt4VcCNySxgKxXOSaeFzKZL+57Nl9K6flAtmpwQwsgjsnqZOUUKX+tphdN0IRTI
 +GD2tXffTCans89h1M/2UP+uTCSDqm3oUyYAWPqSgXx79GJQU+rM31tLaq7Wq2JBZAbOGAp9H2H
 tGm6SG61U1OWtmxLMYepGOEf9C+Hnf5nMbZCQFVJFxQ3iIs6MbCquNPWEqJ1yVT+YgOz/kOM11n
 T03ovSd8iIQ6f1wFxr1GdS1K+PCqyfULOf9c6D4tWr6hjO8zaagLD97lnKD0=
X-Received: by 2002:aa7:8884:0:b0:898:f575:7bd0 with SMTP id
 d2e1a72fcca58-8bc1cb715bdmr5212051b3a.22.1794478856463; 
 Thu, 12 Nov 2026 02:20:56 -0800 (PST)
X-Received: by 2002:aa7:8884:0:b0:898:f575:7bd0 with SMTP id
 d2e1a72fcca58-8bc1cb715bdmr5212026b3a.22.1794478856040; 
 Thu, 12 Nov 2026 02:20:56 -0800 (PST)
Received: from ZBook.gateway ([123.208.39.53])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baaa2a6c51sm3259468b3a.14.2026.11.12.02.20.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 02:20:55 -0800 (PST)
To: ltp@lists.linux.it
Date: Thu, 12 Nov 2026 21:20:49 +1100
Message-ID: <20261112102050.76434-1-changwei.zou@canonical.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v10 0/1] cpuset_memory_spread: rewrite as a C test
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

cpuset.memory_spread_page exists only in the cgroup v1 cpuset controller, so
the test checks for the control file in setup() and is skipped (TCONF) when
cpuset is mounted on the unified (v2) hierarchy. The patch also registers
cpuset.memory_spread_page in the LTP cgroup library's cpuset file table so
it can be driven through the SAFE_CG_* helpers.

Tested on a 2-node NUMA machine with a v1 cpuset hierarchy: all six subtests
pass.

Changes in v10 (addresses Petr's v9 review):
  - Drop .needs_cgroup_ver = TST_CG_V1; the setup() SAFE_CG_HAS() check on
    cpuset.memory_spread_page already skips (TCONF) on a v2 hierarchy.
  - Restore TST_TEST_TCONF(NUMA_ERROR_MSG) (the v7 switch to a literal
    string was wrong).

v9:
https://lore.kernel.org/ltp/20261105005506.76889-1-changwei.zou@canonical.com/

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
 .../cpuset_memory_spread01.c                  | 213 +++++++++++
 .../cpuset_memory_spread_testset.sh           | 362 ------------------
 7 files changed, 222 insertions(+), 491 deletions(-)
 delete mode 100644 testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_mem_hog.c
 create mode 100644 testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread01.c
 delete mode 100755 testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
