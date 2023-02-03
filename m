Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073A0C636CC
	for <ltp@archiver.kernel.org>; Fri,  3 Feb 2023 10:06:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 16E013CC38A
	for <ltp@archiver.kernel.org>; Fri,  3 Feb 2023 11:06:30 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2993D3CB269
 for <ltp@lists.linux.it>; Fri,  3 Feb 2023 11:06:18 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5713C1000741
 for <ltp@lists.linux.it>; Fri,  3 Feb 2023 11:06:17 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6543E345B3;
 Fri,  3 Feb 2023 10:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1675418777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Ih1PdGef6juEuDEiZrh8SDGYMZEvw5btWvO4+g7ksZE=;
 b=L+V60ptdWOcWfOtgfgoijCRwfYGdB9DLerNBnFCGoq9WO2pCcBVURyrLXj/IZJ2KPIZknl
 5Zlu73V7F2Ro24v8KOPPPTV52rvTCzxlqhuN1g8rA8eq35ya7sHc4h+5mUA6DZUawUPHQQ
 koXkUUGXZO2YedxwQLMS/sKYKSjK2Mk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1675418777;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Ih1PdGef6juEuDEiZrh8SDGYMZEvw5btWvO4+g7ksZE=;
 b=Vxe+eeHtnRnHA9IeMPRtgqH8jr40AjMgcYfUwpNk3SvWKhCiEU7KUiDeKKye9bwDUkoRjm
 PxUw7eNEcY68NrBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1BD661358A;
 Fri,  3 Feb 2023 10:06:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id n19xBJnc3GMnKAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 03 Feb 2023 10:06:17 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  3 Feb 2023 11:06:12 +0100
Message-Id: <20230203100613.13395-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] arm64: dts: qcom: msm8992-lg-bullhead: Enable
 regulators
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
Cc: Jamie Douglass <jamiemdouglass@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>, Jeremy McNicoll <jeremymc@redhat.com>,
 Konrad Dybcio <konradybcio@gmail.com>, Andy Gross <agross@kernel.org>,
 Dominik Kobinski <dominikkobinski314@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Enable pm8994_s1, pm8994_l{26,29,30,32} regulators.
Use values from downstream kernel on bullhead rev 1.01.

NOTE: downstream kernel on angler rev 1.01 differences:
* pm8994_l29: regulator-min-microvolt = <2700000>
* pm8994_l{20,28,31}: use regulator-boot-on

Verification:
[    1.832460] s1: Bringing 0uV into 1025000-1025000uV
...
[    2.057667] l26: Bringing 0uV into 987500-987500uV
...
[    2.075722] l29: Bringing 0uV into 2800000-2800000uV
[    2.076604] l30: Bringing 0uV into 1800000-1800000uV
[    2.082431] l31: Bringing 0uV into 1262500-1262500uV
[    2.095767] l32: Bringing 0uV into 1800000-1800000uV

Fixes: f3b2c99e73be ("arm64: dts: Enable onboard SDHCI on msm8992")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../boot/dts/qcom/msm8992-lg-bullhead.dtsi    | 32 ++++++-------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi b/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi
index a100b05abf56..b8f2a01bcb96 100644
--- a/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi
@@ -89,8 +89,8 @@ pm8994_regulators: regulators-0 {
 		/* S1, S2, S6 and S12 are managed by RPMPD */
 
 		pm8994_s1: s1 {
-			regulator-min-microvolt = <800000>;
-			regulator-max-microvolt = <800000>;
+			regulator-min-microvolt = <1025000>;
+			regulator-max-microvolt = <1025000>;
 		};
 
 		pm8994_s2: s2 {
@@ -246,11 +246,8 @@ pm8994_l25: l25 {
 		};
 
 		pm8994_l26: l26 {
-			/*
-			 * TODO: value from downstream
-			 * regulator-min-microvolt = <987500>;
-			 * fails to apply
-			 */
+			regulator-min-microvolt = <987500>;
+			regulator-max-microvolt = <987500>;
 		};
 
 		pm8994_l27: l27 {
@@ -264,19 +261,13 @@ pm8994_l28: l28 {
 		};
 
 		pm8994_l29: l29 {
-			/*
-			 * TODO: Unsupported voltage range.
-			 * regulator-min-microvolt = <2800000>;
-			 * regulator-max-microvolt = <2800000>;
-			 */
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
 		};
 
 		pm8994_l30: l30 {
-			/*
-			 * TODO: get this verified
-			 * regulator-min-microvolt = <1800000>;
-			 * regulator-max-microvolt = <1800000>;
-			 */
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
 		};
 
 		pm8994_l31: l31 {
@@ -285,11 +276,8 @@ pm8994_l31: l31 {
 		};
 
 		pm8994_l32: l32 {
-			/*
-			 * TODO: get this verified
-			 * regulator-min-microvolt = <1800000>;
-			 * regulator-max-microvolt = <1800000>;
-			 */
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
 		};
 	};
 
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
