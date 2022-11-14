Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3CDC4332F
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 22:58:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 521E93CD268
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 23:58:07 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DA8D3CAF94
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 23:57:54 +0100 (CET)
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch
 [185.70.40.134])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0074E200997
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 23:57:53 +0100 (CET)
Date: Mon, 14 Nov 2022 22:57:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
 s=protonmail3; t=1668466672; x=1668725872;
 bh=x+U5rIO//TS5F/TNTZBlpatluCRcjqHuQdl304rDxLc=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=V7ImDXg+OzrB3EaMJ2+wz14M5md8oGLToV2sZvltyI5WoGoYmWEi3+99HdtIY1nqp
 LO2bSL1y+vnhQBpjkfz6YAmRH/NwEY71Iu5Ew9KRQZ0+iMQa3W83Qt5jTEf9s7Bsl8
 vDb3nT7yWBSGGI8ejDjTZBY3850iKXalAeCQQ6Q9CiOgET+WNCzCg4Asz3xO1QkXzo
 YcUPJUKfLRt7QHeM4si+JpPl8Lr0pZzpcghL25gN7Fyov5VMxRCbveQRdxFhHJtWvM
 0qfM7VBdUw0r5RySMjgnWIlRQC9VYpvlr82mjHlor1R7cQzorKquHRt4gcysATRZnQ
 DAUyZovfeeDXA==
To: ltp@lists.linux.it
Message-ID: <20221114225616.54212-1-federico.bonfiglio@protonmail.ch>
Feedback-ID: 5346557:user:proton
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] sched_setscheduler: test SCHED_RESET_ON_FORK
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
From: Federico Bonfiglio via ltp <ltp@lists.linux.it>
Reply-To: Federico Bonfiglio <federico.bonfiglio@protonmail.ch>
Cc: Federico Bonfiglio <federico.bonfiglio@protonmail.ch>
Content-Type: multipart/mixed; boundary="===============1497799902=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1497799902==
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------aa81b65ec6e530be1a9e49ce88bee703ee5a1d98f177bb3a021efc7a818b7c5b"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------aa81b65ec6e530be1a9e49ce88bee703ee5a1d98f177bb3a021efc7a818b7c5b
Content-Type: multipart/mixed;
 boundary=fa3beb4eb25dff80ce69eb556a41813efc2f8001743fbfd6931cbefb532c
From: Federico Bonfiglio <federico.bonfiglio@protonmail.ch>
To: ltp@lists.linux.it
Cc: Federico Bonfiglio <federico.bonfiglio@protonmail.ch>
Subject: [PATCH v2] sched_setscheduler: test SCHED_RESET_ON_FORK
Date: Mon, 14 Nov 2022 23:56:16 +0100
Message-Id: <20221114225616.54212-1-federico.bonfiglio@protonmail.ch>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0

--fa3beb4eb25dff80ce69eb556a41813efc2f8001743fbfd6931cbefb532c
Content-Transfer-Encoding: 8bit
Content-Disposition: 
Content-Type: text/plain; charset=UTF-8

Signed-off-by: Federico Bonfiglio <federico.bonfiglio@protonmail.ch>
---
 runtest/syscalls                              |  1 +
 .../syscalls/sched_setscheduler/.gitignore    |  1 +
 .../sched_setscheduler/sched_setscheduler04.c | 73 +++++++++++++++++++
 3 files changed, 75 insertions(+)
 create mode 100644 testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 3dc6fa397..ff516af3d 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1204,6 +1204,7 @@ sched_getscheduler02 sched_getscheduler02
 sched_setscheduler01 sched_setscheduler01
 sched_setscheduler02 sched_setscheduler02
 sched_setscheduler03 sched_setscheduler03
+sched_setscheduler04 sched_setscheduler04

 sched_yield01 sched_yield01

diff --git a/testcases/kernel/syscalls/sched_setscheduler/.gitignore b/testcases/kernel/syscalls/sched_setscheduler/.gitignore
index aa8ad9695..1b8860d2c 100644
--- a/testcases/kernel/syscalls/sched_sets
cheduler/.gitignore
+++ b/testcases/kernel/syscalls/sched_setscheduler/.gitignore
@@ -1,3 +1,4 @@
 /sched_setscheduler01
 /sched_setscheduler02
 /sched_setscheduler03
+/sched_setscheduler04
diff --git a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler04.c b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler04.c
new file mode 100644
index 000000000..4a5d27f5b
--- /dev/null
+++ b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler04.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 Federico Bonfiglio <federico.bonfiglio@protonmail.ch>
+ */
+
+/*
+ * [Description]
+ *
+ * Testcases that test if sched_setscheduler with flag
+ * SCHED_RESET_ON_FORK restores children policy to
+ * SCHED_NORMAL.
+ *
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <sched.h>
+#include <linux/sched.h>
+
+#include "tst_test.h"
+#include "tst_sched.h"
+
+struct test_c
ase_t {
+	int policy;
+	char *desc;
+};
+
+static struct test_case_t cases[] = {
+	{
+		.policy = SCHED_FIFO,
+		.desc = "SCHED_FIFO"
+	},
+	{
+		.policy = SCHED_RR,
+		.desc = "SCHED_RR"
+	}
+};
+
+static void test_reset_on_fork(unsigned int i)
+{
+	struct sched_variant *tv = &sched_variants[tst_variant];
+	struct test_case_t *tc = &cases[i];
+
+	tst_res(TINFO, "Testing %s variant", tv->desc);
+	tst_res(TINFO, "Testing %s policy", tc->desc);
+
+	struct sched_param param = { .sched_priority = 1 };
+
+	tv->sched_setscheduler(getpid(), tc->policy | SCHED_RESET_ON_FORK, &param);
+
+	pid_t pid = SAFE_FORK();
+
+	if (!pid == 0) {
+		if (sched_getscheduler(pid) == SCHED_NORMAL)
+			tst_res(TPASS, "Policy reset to SCHED_NORMAL");
+		else
+			tst_res(TFAIL, "Policy NOT reset to SCHED_NORMAL");
+	}
+
+	tst_reap_children();
+}
+
+static struct tst_test test = {
+	.forks_child = 1,
+	.caps = (struct tst_cap[]) {
+	    TST_CAP(TST_CAP_REQ, CAP_SYS_NICE)

+	},
+	.test_variants = ARRAY_SIZE(sched_variants),
+	.tcnt = ARRAY_SIZE(cases),
+	.test = test_reset_on_fork
+};
+
--
2.38.1


--fa3beb4eb25dff80ce69eb556a41813efc2f8001743fbfd6931cbefb532c
Content-Transfer-Encoding: base64
Content-Disposition: attachment; name="publickey - Federico Bonfiglio -
 e96ee84c.asc"; filename="publickey - Federico Bonfiglio - e96ee84c.asc"
Content-Type: application/pgp-keys; name="publickey - Federico Bonfiglio -
 e96ee84c.asc"; filename="publickey - Federico Bonfiglio - e96ee84c.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tClZlcnNpb246IEdvcGVuUEdQIDIu
NC43CkNvbW1lbnQ6IGh0dHBzOi8vZ29wZW5wZ3Aub3JnCgp4c0ROQkdHZGZuMEJEQUMxY3Q1bDJi
RGR2eG83ZXMxTnlSMkFGbnFkU0dGYlM1ZjltZWc5azAyOTgzUHVwU2NDCkNPOHFmbzl3OXdIQjg4
TlQwNWNSNVlURTZQUEd0SGwwSWR5RDYrdy9taEtrc1JLNEhXNnl3TUlMUmtCWm95aS8KNnFabkho
WUQzRGZBajgvZmxUeE9zbGN3ZFlWcWJ5ckwzYUYxM2daOVVJYVpCV2t1QlI0ZFlvd2RmVXdMaEdT
NApBZUtDL2dUNUdPVUkxZDRFZUtBTk9xTk9JQUFqSFdXUU40QnNVcHZQQUowOVZocnJacDlXbWNE
b25iV3R2VW40CmwyNWRsbFFWTkswY2pydVRpYVJtQjlHUStLMkhYUm1BWDQ4cDZFNDJxWnBqd0VQ
eUI0VFRyY3FIK0gzcHg4Z2cKU041NWZvQzVKMGRhSDVSeHhhRHM1dTYxNGlEd04vL0FsQnhIbURh
WkxEMW1VdlEwMjRpYVdKUXdtV0Y0cVFOSgpTdlVYWjJkQ3RTQjA1MnpIZ3l0cDV3RjZtcVhNWXBS
dHJyQzBvTGVFcXVlT2tuejJPUElGR3NGUFI0RHhIMjVaClpBNDJGNkllUUMrVC9lWjBGUWJ5aDA5
SEtUQmxrejhlNzQzMW03L0plTkpDc0llQXBWTTdOUlU1TVBJYkJLelAKOG14MklhZkE2RnZYbEJz
QUVRRUFBYzAxUm1Wa1pYSnBZMjhnUW05dVptbG5iR2x2SUR4bVpXUmxjbWxqYnk1aQpiMjVtYVdk
c2FXOUFjSEp2ZEc5dWJXRnBiQzVqYUQ3Q3dTVUVFd0VJQURnV0lRVHBidWhNL0JjMGZoWDhJM0hX
CmRnVWRvd2NrSlFVQ1laMStmUUliQXdVTENRZ0hBZ1lWQ2drSUN3SUVGZ0lEQVFJZUFRSVhnQUFo
Q1JEV2RnVWQKb3dja0pSWWhCT2x1NkV6OEZ6UitGZndqY2RaMkJSMmpCeVFsd2JzTC8zd1BCemZC
T3d4dHVhWjk5L25OUEpDegpzOHNMSmlkMS9YNnpUSHNMZHZOUmJLTGxhWDJLRGx2VWRsY1UwN09k
U3Z5clg0bHVvdUl3c1oyUnNxamVyVWNFCmtXUzZBOHA4MnVScWlyUzdTT3U0bUlPSjRyMUZXZTNW
ZUx6Ty9TSUljUk5wL2IwNnRoNTVPRTZZc2ppdHRlM2sKM2w3d0FBaTJSYkNQdXJtZkNjRTFIVEYz
SGRDbG41a21mZzNoczBsQnhpRHFyVFJxai9aZmhhNGF1RHo5c2kyZgpjRDRNS3Q2UVMzYnNrOFVr
V2NudGFxUm9HdEsyaW11bGtEb0N0TmgvT1J1U2FLQlpHRmliclZySExMdzNGcFRrCmxFYlI3MFNu
WFhvMEZldUwxZFArYVczZkFRSzFTWURCRS9UOGgzekpQN05LZ3hGOUhRamlPYzBPNGlRS2tNVkEK
clhCQmFIRENrWnUxN2w5Y2hOK3g5N3lSZGt2RDVPS2wrYjh4ajBLR1dBL1BRc1hYaUp4REkrdFBt
eUp6QitENwpNTHpSSkUzRlltN1hRK0V1b3Jkeld4cTNhR1VQTHl6TkY3ZlpFZVk0ekIxNEFuMmRk
c1QySFErZUpxeEhWbG1BCkRDN0E2aHZ1ZXdjYWllOVFja0JnL1RMK0t2OG13elcrb2ljRkJlRDdF
czdBelFSaG5YNTlBUXdBN2p6cWRhOXkKSllKbkoyTlRST3F1MVgwMjhaeGp4ZWpDUlprMmt5MUo2
U1U0amwvc0ZLTHpINUNadm9rWXlFUEY4R2VCRkZ1cwpKK2tZTlhtaytkNnpxUnE1NngrRXVkUUZj
SE5iOW16cWJpNFhMdWlEc3dtVzZ5Slh4Ylg1NmsxNkxCUEdOeW5sCmpTRVZnTlRiQVZuendQeVVj
UC94WnRrSFpnOWMyZzdoQkVvN2o2NzBWUFZaQXd5cGFQaXVsOExrWVlTLzVWRi8KNkI0SEIwUW8z
VmtiSTluUEMyanFHejJ5UU5ncGlMdklvbExvT1NPeVUzS2ZKRWtvODlaQktJOGNLMGxNcUhzbApJ
V1IxQmZqWGVYWjBDdlEvNkVDeVlQZ1lqQUY1UEQ0Q25ZUDNBelhtVGZCakk0VEcyVmFpZ0tCNVRN
ZDRGUE95CmtPa0p4R3BQYmZhbXh3ZjJwNDBGdVFRM2ZZOFBnZU0vSjVyTDdqdlo0R2pKVXlTTmJi
ZFBxL0RKTTc2dE16YzYKUjdtVlJIRG56Qit1cHhSVmM0ZU1WZ0Zrc0x1alNZTVZmeGlKTElaMWpO
ZmNPVytNbGgzTVp4M2xlczNJWk9GQwo5OWwrWUxDNDZ4Sjk3VlAyREJWNlZUZkh3TlhRMHdTNWpV
bzFub09xbEtVbUpmWGlXVGVBeG5xckFCRUJBQUhDCndRMEVHQUVJQUNBV0lRVHBidWhNL0JjMGZo
WDhJM0hXZGdVZG93Y2tKUVVDWVoxK2ZRSWJEQUFoQ1JEV2RnVWQKb3dja0pSWWhCT2x1NkV6OEZ6
UitGZndqY2RaMkJSMmpCeVFsRjJzTUFKYmlpdXh1QWlPd3VTdjgxSlh0Vkp6YgowV3lYS1dJNmhu
UngvY1ZRdGQ1WE5rQm1WRjBzS05zRnFiNHZJRk9Ya0w1WkhsNGxrNE1CQ3Jnc1JDQ0NQTHpTCktE
Tk81ZkJWTk5CVVpGUFpHRW1iMDZGalBpM2xqYlE3Smx0SmtNRUxibllrRCtvYjIwM1k0Z1JTNFB2
dGxkQUgKVFRBZ2kyMTU5SHlYbC8wUjFZbmRETC8rU2UrSFdJcXhxeWx1SmtNeTB3U2ZFbkdVMU9p
REUrb1RHQ0UxUjhOQgpZalAxcHdrL0JKWU15TG9UekZVdW0vRVp4bWNwMDFSZS92bzBNWWErMnVr
bE1jTU05dVdJNUo4djFPczBqb0piCkgrN3dZcWhEenhHdldHLzhiazRxWXRpc0VNaW9sRmRPSGpC
Qk5TQnVJQmRScWJkSHlpYklZNmdOam94VnF3OEcKZC82b1R5QTM5NkZTaGVRQ0dkclgrU2lyUTBO
SitacWxyYzNCMUxzOCtERWg2Ni9ZT251NmpkbmFnMTVDQS8yLwpwajBkM0VkdGRxaGdiUHZsQjlv
WnZRTmdFSmkwQk5mRzdDZkdJQUltVDZYY2s3bUZrMTZRTzMvZllEdE8zWGdrCjNMeXFKeDAxWCtZ
Nmh6YlJmWlVjMGpwRTRYZnA0TWxDR1NKcWtyNm9XQT09Cj13NGN5Ci0tLS0tRU5EIFBHUCBQVUJM
SUMgS0VZIEJMT0NLLS0tLS0=
--fa3beb4eb25dff80ce69eb556a41813efc2f8001743fbfd6931cbefb532c--

--------aa81b65ec6e530be1a9e49ce88bee703ee5a1d98f177bb3a021efc7a818b7c5b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsDzBAEBCAAnBQJjcsfrCZDWdgUdowckJRYhBOlu6Ez8FzR+FfwjcdZ2BR2j
ByQlAAD6DAv8CCOhw87T+hspB4BkEHDZgLpKVGE2PfXCg/N8bIveKnT7R6C2
39+BsYv0547qZHWwSTX0ecnEnr1cOJOEfkJCm2ncZyabv1SJhDQN16Qg13m9
ceD1ZdRrwK4NrE7kU43OAhjWwfkYS+lhGZCC/dYxfPWHs7V/Vvp56iqh5vrE
GCQxYPZWlGrxkNkUBO8IDShaVilb31HIBwSv4RpmK3tp9SJq5J3BTODRi4Hz
PYvEF1Q4AGx9DN6V2T9ZTILteYk84ywiGzFezND15StcSQRafRIc2RJZkTCD
wwIYIWfl/7BHSE6jwm7qjQNot+mHVBcKYD37FnUtssqK5OuwqpdwZjIaHAWj
8wqEwAQ1/DFn994/40wCZpSwuzbrAM3SZTJkoS5oviqgiRyAS+VmVh03MQAa
qap/Tt6ipz71u40YkMiB/j7ZOatV54ReecXnheAiQ5gHEHDCctHVcViQ/y8Y
6nLPlCCGWBISIzrvWLQJYXrgnE92Ymd7kgTcywU71csb
=EZWn
-----END PGP SIGNATURE-----


--------aa81b65ec6e530be1a9e49ce88bee703ee5a1d98f177bb3a021efc7a818b7c5b--


--===============1497799902==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1497799902==--

