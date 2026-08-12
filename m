Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD09C5B572
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 12:26:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 69D853E6CA7
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 14:26:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C2623E2104
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 13:27:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DA382600728
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 13:27:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786534067; x=1818070067;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=622vYd2yiiH3mvgv5FZwmRtuAXq9cCs7RbhzuhqT55M=;
 b=IapIFs+lgORg8dnpOcZLyzYxsv8W9DZzzTFImsWPuoyf/T2CZwDyThaC
 xR+AjkItH+9ECNB8ooCHTvfoq5NMfeJaDHL+FA79uX2+mbB7ajTyQS2+U
 8yOgQdEiQq6uS1ghBIouYPAdzuIH0kyUFHO18QS+r0P6cH+lE6y2Smu9X
 v6QqHe+TZi76qjax/C5o8/8I5DqGGmRiih+GKzupwn5FR69YtDt6k4+Qy
 zApr2lp518tusKsYSQWjDVnPodxOtXoH8jAc0szhUIdBuW02gozR4VOtL
 C2UKbP4e7YwIv+c7mn0wiO99NQSiGQTZfuoOb4rlT79mW6D+2rsrLyfyf Q==;
X-CSE-ConnectionGUID: /Ue6uEgETjqD1qSicxagCw==
X-CSE-MsgGUID: yRloNaGZQPm49IuaqeHw+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="90762449"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="90762449"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 04:27:45 -0700
X-CSE-ConnectionGUID: rQxHBLuaStW7/pMEh0fgVg==
X-CSE-MsgGUID: fQz5qxAYQL2ay7Qf4JJpTg==
X-ExtLoop1: 1
Received: from igk-lkp-server01.igk.intel.com (HELO igk-lkp-server01)
 ([10.211.93.152])
 by fmviesa003.fm.intel.com with ESMTP; 12 Aug 2026 04:27:43 -0700
Received: from [10.245.245.190] (helo=frankran-MOBL)
 by igk-lkp-server01 with esmtp (Exim 4.96)
 (envelope-from <frank.ranner@intel.com>) id 1wu77V-007wLL-1d;
 Wed, 12 Aug 2026 13:27:41 +0200
From: Frank Ranner <frank.ranner@intel.com>
To: ltp@lists.linux.it
Date: Wed, 12 Aug 2026 13:27:37 +0200
Message-ID: <20260812112737.2222475-1-frank.ranner@intel.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 12 Aug 2026 14:25:49 +0200
Subject: [LTP] [PATCH ltp] testcases/kernel/crypto/crypto_user02.c: try
 non-generic hmac names first
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
Cc: Frank Ranner <frank.ranner@intel.com>, Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Probe plain hmac(<hash>) driver names before the legacy *-generic
variants when selecting a viable algorithm for crypto_user02.

Newer kernels commonly expose non-generic algorithm names while
no longer registering the *-generic aliases, which made the current
candidate list fall through to TCONF even when usable algorithms
were present.

Keeping both forms preserves compatibility with older kernels while
avoiding kernel-version checks in the testcase logic.

Signed-off-by: Frank Ranner <frank.ranner@intel.com>
---
 testcases/kernel/crypto/crypto_user02.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/testcases/kernel/crypto/crypto_user02.c b/testcases/kernel/crypto/crypto_user02.c
index 88ae800aa..c08d35c84 100644
--- a/testcases/kernel/crypto/crypto_user02.c
+++ b/testcases/kernel/crypto/crypto_user02.c
@@ -35,6 +35,20 @@
  * The first algorithm, that fullfils the criteria is used for the test.
  */
 static const char * const ALGORITHM_CANDIDATES[] = {
+	"hmac(sha1)",
+	"hmac(sha224)",
+	"hmac(sha256)",
+	"hmac(sha384)",
+	"hmac(md5)",
+	"hmac(sm3)",
+	"hmac(sha512)",
+	"hmac(rmd160)",
+	"hmac(sha3-224)",
+	"hmac(sha3-256)",
+	"hmac(sha3-384)",
+	"hmac(sha3-512)",
+	"hmac(streebog256)",
+	"hmac(streebog512)",
 	"hmac(sha1-generic)",
 	"hmac(sha224-generic)",
 	"hmac(sha256-generic)",
-- 
2.53.0

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
