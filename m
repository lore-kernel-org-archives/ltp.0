Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB043C4332F
	for <ltp@archiver.kernel.org>; Sat,  5 Nov 2022 18:32:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 504883CE023
	for <ltp@archiver.kernel.org>; Sat,  5 Nov 2022 19:32:49 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 174EE3C0EF2
 for <ltp@lists.linux.it>; Sat,  5 Nov 2022 19:32:38 +0100 (CET)
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3191C1000367
 for <ltp@lists.linux.it>; Sat,  5 Nov 2022 19:32:37 +0100 (CET)
Date: Sat, 05 Nov 2022 18:32:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
 s=protonmail3; t=1667673156; x=1667932356;
 bh=L6wLxu237MAsoPIoRaoxdtngdzPncxI+BuOv02OBD4w=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=TRGfvytKCX0lVUW07kSrz5co0rFgNLjrttuFibaQCNi1rMJ4DBTHjFD11QqKhzQL2
 u8hNRckgDCR8InYiXtyna0RzIArXm8ST9QYarnhU08GX0JouY2AkszOwsFbDGiI7cS
 1Xy8Sgdz+8IoXNJOMCR2uh8sMUL85tJpRhmWtIoShMIGKW4HJbZo2JWa8aHDzMSt/X
 4IeGfhINxPmcctWNnVVfpJzOC93QUfl9Co8AV5+1+PLVVGZc1k2DuZKo6ivmsY+XrD
 EsuoChx7JnvT9MVQ10l540DWAijurYQQij2W0VgAKx7ZiO0xGiLWL1YXCyNpvT82yp
 gR7J2f0q3reGQ==
To: ltp@lists.linux.it
Message-ID: <20221105183213.36684-1-federico.bonfiglio@protonmail.ch>
Feedback-ID: 5346557:user:proton
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] sched_setscheduler: test SCHED_RESET_ON_FORK
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
Content-Type: multipart/mixed; boundary="===============0340550544=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0340550544==
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------fcea5b6887b4d5d051a37e9c33a6fee160fe18c519f8c5d431f01e55303c8897"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------fcea5b6887b4d5d051a37e9c33a6fee160fe18c519f8c5d431f01e55303c8897
Content-Type: multipart/mixed;
 boundary=06051ca2b8ebb88f8a5fb61834d5401fe06199b9c2b4f6b4da70b1c34881
From: Federico Bonfiglio <federico.bonfiglio@protonmail.ch>
To: ltp@lists.linux.it
Cc: Federico Bonfiglio <federico.bonfiglio@protonmail.ch>
Subject: [PATCH v1] sched_setscheduler: test SCHED_RESET_ON_FORK
Date: Sat,  5 Nov 2022 19:32:13 +0100
Message-Id: <20221105183213.36684-1-federico.bonfiglio@protonmail.ch>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0

--06051ca2b8ebb88f8a5fb61834d5401fe06199b9c2b4f6b4da70b1c34881
Content-Transfer-Encoding: 8bit
Content-Disposition: 
Content-Type: text/plain; charset=UTF-8

---
 runtest/syscalls                              |  1 +
 .../syscalls/sched_setscheduler/.gitignore    |  1 +
 .../sched_setscheduler/sched_setscheduler04.c | 71 +++++++++++++++++++
 3 files changed, 73 insertions(+)
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
--- a/testcases/kernel/syscalls/sched_setscheduler/.gitignore
+++ b/testcases/kernel/syscalls/sched_setschedule
r/.gitignore
@@ -1,3 +1,4 @@
 /sched_setscheduler01
 /sched_setscheduler02
 /sched_setscheduler03
+/sched_setscheduler04
diff --git a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler04.c b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler04.c
new file mode 100644
index 000000000..f2643f001
--- /dev/null
+++ b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler04.c
@@ -0,0 +1,71 @@
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
+struct test_case_t {
+	int policy;
+	char *desc;
+};
+
+static struct test_cas
e_t cases[] = {
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
+	.needs_root = 1,
+	.test_variants = ARRAY_SIZE(sched_variants),
+	.tcnt = ARRAY_SIZE(cases),
+	.test = test_reset_on_fork
+};
+
--
2.3
8.0


--06051ca2b8ebb88f8a5fb61834d5401fe06199b9c2b4f6b4da70b1c34881
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
--06051ca2b8ebb88f8a5fb61834d5401fe06199b9c2b4f6b4da70b1c34881--

--------fcea5b6887b4d5d051a37e9c33a6fee160fe18c519f8c5d431f01e55303c8897
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsDzBAEBCAAnBQJjZqw2CZDWdgUdowckJRYhBOlu6Ez8FzR+FfwjcdZ2BR2j
ByQlAAAaoQv/S3hiXaf/Enf41SZ2LJr7QzGRMV8VbRXgLoQ5PZSxE11U3pwo
tr5cL7V5HtD5enXX8W9NC8OLmFQ0osRQwIznnVlgv8LrwS9VN+bpjEQsz6pj
xfCu/f9gQHAHrEcKFjosUivqwKckwI2yYfgeIbr6qkPnLFz6AyqyW+AzmGIX
GKxjTfqvgXpoVktECKJzSb/+rQyj9+pY9BsxpI4G1hWVKOjI11h3UGPq9Kc7
2EqDB/kpAr3ttTQiCy2y0QtH6vmdvnMr7TJ9TnJDtJ25rvOAeocl78NFMD5E
CdsHBZHOc5A1U+2AmG0BsBeNFkEWzO4T5wEcEQaGHbQoyAS70yFDemVojKJs
fKRBqD9wYuxhceMpr3duq0D0e1YFJ/qzd6hl1uTW4hdCUyCK9Z3YWTx8RajM
1ufYmM1Sn1/xhsQtlyRyFzG9gzooO/OEJul510R7gTjdEdlMtFXRnIJJgs2M
1EN870ENW55PZcq/7CX4cQ5LNrUeq1arpNwSPH/+Xqfy
=o5/8
-----END PGP SIGNATURE-----


--------fcea5b6887b4d5d051a37e9c33a6fee160fe18c519f8c5d431f01e55303c8897--


--===============0340550544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0340550544==--

