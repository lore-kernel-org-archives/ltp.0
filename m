Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA3CC79F89
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 12:11:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 10E343E950E
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 14:11:36 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C56DD3C6135
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 14:11:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3E430200968
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 14:11:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788783079; x=1820319079;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=NnwoRigdOwOoDBaiBF+MeY4mfNDvt8Y8VQIGeitwPQ4=;
 b=jfsjtMAN2XhV7da6/F/bsyN6CCfZbtYhMHnHv6OonaLXovFf/LQvNQTk
 op99Hsh8nYinfRa4jMVFhRb11jF/9wFDk33V25UoXNHw1q9iER2aH4Q/Z
 CUQw2dYvucT3SKHWKypjVe2Xyoi6V50zfUJPAhPCoMBK4vgnWQhbbg7Gu
 M3R+RlO88wC476+vH1/q4sPYwRyMfzZyTKISAJGfelkmuEXKPwkG0sdCS
 ipN3NdDkKEctxabOt2EN7Uw6ydDndojfcbGV70sS2ayJ5fnZDnphbAJ4b
 QViKata3Qs1Rouar2/VGrlMKt66oeFzmOccVMaUEGWF9T1LmPTBPPRnE2 g==;
X-CSE-ConnectionGUID: JtFsskHBTSWoKFBiVuXVtQ==
X-CSE-MsgGUID: fg25a9woS36OP1AfQWIDHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="99519134"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="99519134"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 05:11:17 -0700
X-CSE-ConnectionGUID: U1VQjLM6SsSwRyqQZunLcA==
X-CSE-MsgGUID: fa6oTrpLQKeOSBVvTTDFvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="268116300"
Received: from pkubaj-desk.igk.intel.com (HELO intel.com) ([10.237.142.111])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 05:11:14 -0700
From: Piotr Kubaj <piotr.kubaj@intel.com>
To: ltp@lists.linux.it
Date: Mon,  7 Sep 2026 14:10:43 +0200
Message-ID: <20260907121045.357509-2-piotr.kubaj@intel.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/3] pmc_core: cover the PkgC LTR blocker counters
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

Tested on Nova Lake running 7.3.0-rc1, with debugfs both mounted and
unmounted beforehand, and in the latter case the mount state is restored
after the run. The TFAIL and TCONF paths were exercised against fake
counter files.

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
 .../kernel/power_management/ltr_counter.c     | 358 ++++++++++++++++++
 .../power_management/pkgc_ltr_blocker_show.c  | 294 ++++++++++++++
 12 files changed, 746 insertions(+)
 create mode 100644 lib/newlib_tests/tst_needs_debugfs.c
 create mode 100644 testcases/kernel/power_management/ltr_counter.c
 create mode 100644 testcases/kernel/power_management/pkgc_ltr_blocker_show.c


base-commit: 463b33ad464b6840d0a1df5d41939e50d55d542c
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
