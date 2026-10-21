Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DADE606A319
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 09:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=d695zJPQ
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 56FB43C930F
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 11:00:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F25243C265A
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 10:59:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 616D9100098E
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 10:59:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792573184; x=1824109184;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=WQJWGkuyHXhoRX+QeeYoXE3UN69mplqO9D09wVPTEb0=;
 b=d695zJPQCA04rptAHkrQHSl65ECQMu2MMW6izYt4RTynNWPSqYEq80wz
 ZR/9hr5Ze0hQVJjbFgU899UyANp9maGFTfB5QwHMFXzVJVpJ7VinXHNa2
 9hKaq4yKbeFtpUv7d9HllhtFHW72q65C0egS1TZrZvmV6I5ms3ifnec7f
 tacO3rkFpLjuoPgjMoPHXsHN5bvnoq3RRcbkf6Wvh0DEUZlSHaM+Pplg0
 QOvPEcrbAuHL9KBkzxGZxNZqDpN38hHTF0/fmpkV+d4sy5uNVhQxbSLoq
 duKEA1bzgRpFnHG7MN7UvlSpkQvutsEDgYMpCFg5y5M2lKoIh2vVQhB3c w==;
X-CSE-ConnectionGUID: 1qHdaNWnTRiSuzoAfHY1SA==
X-CSE-MsgGUID: gTetfPwUTymiAE4YBgDjTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1167128"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1167128"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 01:59:40 -0700
X-CSE-ConnectionGUID: U3YmYOTSR62y3BMt1Qn8pQ==
X-CSE-MsgGUID: h/xTKdLWTFSZINLTHUt63g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3033327"
Received: from pkubaj-desk.igk.intel.com (HELO intel.com) ([10.237.142.111])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 01:59:39 -0700
From: Piotr Kubaj <piotr.kubaj@intel.com>
To: ltp@lists.linux.it
Date: Wed, 21 Oct 2026 10:59:29 +0200
Message-ID: <20261021085932.20557-1-piotr.kubaj@intel.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/3] pmc_core: cover the PkgC LTR blocker counters
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: helena.anna.dubel@intel.com, tomasz.ossowski@intel.com,
 rafael.j.wysocki@intel.com, daniel.niestepski@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The intel_pmc_core driver gained a pkgc_ltr_blocker_show debugfs file in
kernel commit 38c79dd63b72 ("platform/x86/intel/pmc: Enable PkgC LTR
blocking counter"), released in v7.2. It reports, per source, how many
times an LTR posted by that source blocked a package C-state entry.

1/3 adds tst_test.needs_debugfs: the library mounts debugfs for the test
    if needed, unmounts it afterwards if it did, and the flag implies
    needs_root.
2/3 checks the file's format and that no counter advances faster than
    the package could have attempted entries over the interval.
3/3 checks that the counters stop while every CPU is kept busy.

Both tests bound what they accept in time rather than against a
hardcoded counter list, because the counter set is platform specific.

v4 was tested on Nova Lake running 7.3.0-rc1 and 7.3.0-rc3. v5 was run on
7.3.0-rc7 on a system where intel_pmc_core does not bind: the self-test
with debugfs mounted, unmounted and unprivileged, both tests on their
TCONF path, and their TPASS and TFAIL paths against fake counter files.
Not yet re-run against the real counter file.

v4 -> v5:
- lib: needs_debugfs implies needs_root; kernel-doc comment for
  TST_DEBUGFS_PATH.
- tst_needs_debugfs.c: drop .needs_kconfigs, which TBROKs in the CI
  containers where no kernel config is readable, and the implied
  .needs_root.
- pkgc_ltr_blocker_show.c: a malformed first sample ends the test with
  one TFAIL summary instead of re-reporting every line on each retry and
  still finishing with TPASS. Fix the TST_RETRY_FN_EXP_BACKOFF() comment.
  Drop .needs_root.
- ltr_counter.c: when the load window runs out, report only counters that
  changed within the final quiet window. Document that the windows are
  sized for the Nova Lake refresh cadence. Drop .needs_root.
- Found by the LTP AI reviewer's v4 run. Rebased onto current master.

v3 -> v4:
- ltr_counter.c: count a spinner only once its fork() succeeded, so a
  failing fork() does not leave the cleanup signalling pid 0. Found by
  the LTP AI reviewer's v2 run, whose mail did not reach the list.
- Rebased onto current master.

v2 -> v3:
- Rebased; the .needs_debugfs row moved next to .needs_cpu_vendor in the
  API table.
- ltr_counter.c: dropped <sched.h> and <signal.h>, the API headers pull
  both in.

Piotr Kubaj (3):
  lib: add tst_test.needs_debugfs flag
  pmc_core: add test for pkgc_ltr_blocker_show
  pmc_core: add ltr_counter test

 doc/developers/writing_tests.rst              |   3 +
 include/tst_fs.h                              |   6 +
 include/tst_test.h                            |   8 +
 lib/newlib_tests/.gitignore                   |   1 +
 lib/newlib_tests/runtest.sh                   |   1 +
 lib/newlib_tests/tst_needs_debugfs.c          |  32 ++
 lib/tst_test.c                                |  38 ++
 metadata/metaparse.c                          |   1 +
 runtest/power_management_tests                |   2 +
 testcases/kernel/power_management/.gitignore  |   2 +
 .../kernel/power_management/ltr_counter.c     | 377 ++++++++++++++++++
 .../power_management/pkgc_ltr_blocker_show.c  | 311 +++++++++++++++
 12 files changed, 782 insertions(+)
 create mode 100644 lib/newlib_tests/tst_needs_debugfs.c
 create mode 100644 testcases/kernel/power_management/ltr_counter.c
 create mode 100644 testcases/kernel/power_management/pkgc_ltr_blocker_show.c


base-commit: 121876b3da3ff59b0dd17b4798b2e4699ba431d1
-- 
2.47.3

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
