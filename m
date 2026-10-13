Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B129CC6B03
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 12:06:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 19E143EA838
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 14:06:39 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C9F43E6A6C
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 14:05:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EEC8F14002B0
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 14:05:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791893155; x=1823429155;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=McRDztEIZcqv8ZLfuetVRdY/L25KoIHHnPOQh7UnFtM=;
 b=Iro8mDtXm8xbmol1c5JvVNfNkAMz/U+OpELh93tP5jLgIUTyfZTqfbpn
 MfYXZMSjfP6UpPDu/2JSzdNuQPZIy12aB6tPjJLwr7+TBXVExo+wPmoM2
 DG5xnEDgOJtalnQnGXnfN8pttrLmZLDRbZW8xI99XDq+yb6yf6mth1iJF
 QxlUUQPh9GLk7LQBpBQaz+qIjsYP1sXVWcTJ9OXQw6mpzdhL2p/qPNLaD
 /Uvx1oD6xafUUQW3/tuoolCXTns8YUPC91tncocUszUHIOGghnZM+VRvp
 49WXV+436cADUTowtZJWisewOpHs1peI4zJiMANuAMryOTIRiBzUo6Th/ A==;
X-CSE-ConnectionGUID: /+dnXF89QnegGRc/yfMqiQ==
X-CSE-MsgGUID: 6lmW0hoVR8CKGB6N+PdLKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="488996"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="488996"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 05:05:51 -0700
X-CSE-ConnectionGUID: OwpcATgnRJiXzSZWrs3Vlw==
X-CSE-MsgGUID: q+U24EBLSNKUOSGxcRw3Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1150912"
Received: from pkubaj-desk.igk.intel.com (HELO intel.com) ([10.237.142.111])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 05:05:49 -0700
From: Piotr Kubaj <piotr.kubaj@intel.com>
To: ltp@lists.linux.it
Date: Tue, 13 Oct 2026 14:04:38 +0200
Message-ID: <20261013120441.206263-1-piotr.kubaj@intel.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/3] pmc_core: cover the PkgC LTR blocker counters
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
Cc: helena.anna.dubel@intel.com, tomasz.ossowski@intel.com,
 rafael.j.wysocki@intel.com, daniel.niestepski@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The intel_pmc_core driver gained a pkgc_ltr_blocker_show debugfs file in
kernel commit 38c79dd63b72 ("platform/x86/intel/pmc: Enable PkgC LTR
blocking counter"), first released in v7.2, and nothing covers it yet.
It reports, per source, how many times an LTR posted by that source
blocked a package C-state entry.

Both tests added here need debugfs mounted, so the first patch moves the
mount handling into the test library instead of open coding it twice.

1/3 adds tst_test.needs_debugfs: the library mounts debugfs at
    /sys/kernel/debug during setup unless it is mounted there already,
    reports TCONF if it cannot, and unmounts it afterwards only if it did
    the mount. A lib/newlib_tests self-test covers both cases. Tests
    reading any other debugfs file can use it as well.

2/3 checks what the file says: every line is a PKGC_PREVENT_LTR_<SOURCE>
    token followed by one u32 value, the file reads to EOF rather than
    erroring out mid-way, the counter set is stable across two reads, and
    no counter advances by more entries than the package could have
    attempted over the interval.

3/3 checks the invariant behind the counters: a package C-state entry is
    only attempted once every CPU in the package is idle, so counters
    that keep advancing with every CPU busy are not counting blocked
    entries. The test proves the counters are alive while idling first,
    so that a counter stuck at a constant value cannot pass for free.

Both tests bound what they accept in time rather than against a hardcoded
counter list, because the counter set is platform specific. That is what
catches a telemetry region read at the wrong offset, which overshoots the
bounds by orders of magnitude.

Tested on Nova Lake running 7.3.0-rc1, and re-run on 7.3.0-rc3, with
debugfs both mounted and unmounted beforehand, and in the latter case
the mount state is restored after the run. The TFAIL and TCONF paths
were exercised against fake counter files.

v3 -> v4:
- ltr_counter.c: count a spinner only once its fork() has succeeded. The
  pid count was set before the first fork(), so a fork() failing half way
  through left the cleanup walking slots that were never written, and a
  zeroed slot means kill() signalling the whole process group. Found by
  the LTP AI reviewer's v2 run, whose mail did not reach the list.
- Rebased onto current master, no conflicts.

v2 -> v3:
- Rebased, with the .needs_debugfs row in the C and shell API comparison
  table moving next to the .needs_cpu_vendor row added meanwhile.
- ltr_counter.c: dropped the <sched.h> and <signal.h> includes, the test
  API headers already pull both in.

Piotr Kubaj (3):
  lib: add tst_test.needs_debugfs flag
  pmc_core: add test for pkgc_ltr_blocker_show
  pmc_core: add ltr_counter test

 doc/developers/writing_tests.rst              |   3 +
 include/tst_fs.h                              |   4 +
 include/tst_test.h                            |   8 +
 lib/newlib_tests/.gitignore                   |   1 +
 lib/newlib_tests/runtest.sh                   |   1 +
 lib/newlib_tests/tst_needs_debugfs.c          |  37 ++
 lib/tst_test.c                                |  35 ++
 metadata/metaparse.c                          |   1 +
 runtest/power_management_tests                |   2 +
 testcases/kernel/power_management/.gitignore  |   2 +
 .../kernel/power_management/ltr_counter.c     | 364 ++++++++++++++++++
 .../power_management/pkgc_ltr_blocker_show.c  | 294 ++++++++++++++
 12 files changed, 752 insertions(+)
 create mode 100644 lib/newlib_tests/tst_needs_debugfs.c
 create mode 100644 testcases/kernel/power_management/ltr_counter.c
 create mode 100644 testcases/kernel/power_management/pkgc_ltr_blocker_show.c


base-commit: a91cacb7cfd0e966d061f30bfb96c212d37ab210
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
