From: Eric Biggers <ebiggers@kernel.org>
Date: Thu,  6 Dec 2018 10:18:14 -0800
Subject: [LTP] [PATCH 3/3] crypto/crypto_user01.c: new test for information
	leak bug
In-Reply-To: <20181206181814.85583-1-ebiggers@kernel.org>
References: <20181206181814.85583-1-ebiggers@kernel.org>
Message-ID: <20181206181814.85583-4-ebiggers@kernel.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Eric Biggers <ebiggers@google.com>

Test for a bug in the crypto user configuration API (NETLINK_CRYPTO)
that leaked uninitialized memory to userspace.  This bug was assigned
CVE-2018-19854, and it was also a re-introduction of CVE-2013-2547.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 runtest/crypto                          |   1 +
 runtest/cve                             |   2 +
 testcases/kernel/crypto/.gitignore      |   1 +
 testcases/kernel/crypto/crypto_user01.c | 208 ++++++++++++++++++++++++
 4 files changed, 212 insertions(+)
 create mode 100644 testcases/kernel/crypto/crypto_user01.c

diff --git a/runtest/crypto b/runtest/crypto
index e5ba61e5e..cdbc44cc8 100644
--- a/runtest/crypto
+++ b/runtest/crypto
@@ -1 +1,2 @@
 pcrypt_aead01 pcrypt_aead01
+crypto_user01 crypto_user01
diff --git a/runtest/cve b/runtest/cve
index c4ba74186..78a5d8db2 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -3,6 +3,7 @@ cve-2011-0999 thp01 -I 120
 cve-2011-2183 ksm05 -I 10
 cve-2011-2496 vma03
 cve-2012-0957 uname04
+cve-2013-2547 crypto_user01
 cve-2014-0196 cve-2014-0196
 cve-2015-0235 gethostbyname_r01
 cve-2015-7550 keyctl02
@@ -36,3 +37,4 @@ cve-2017-17053 cve-2017-17053
 cve-2017-18075 pcrypt_aead01
 cve-2018-5803 sctp_big_chunk
 cve-2018-1000001 realpath01
+cve-2018-19854 crypto_user01
diff --git a/testcases/kernel/crypto/.gitignore b/testcases/kernel/crypto/.gitignore
index fafe5c972..759592fbd 100644
--- a/testcases/kernel/crypto/.gitignore
+++ b/testcases/kernel/crypto/.gitignore
@@ -1 +1,2 @@
 pcrypt_aead01
+crypto_user01
diff --git a/testcases/kernel/crypto/crypto_user01.c b/testcases/kernel/crypto/crypto_user01.c
new file mode 100644
index 000000000..b648fcbdc
--- /dev/null
+++ b/testcases/kernel/crypto/crypto_user01.c
@@ -0,0 +1,208 @@
+/*
+ * Copyright 2018 Google LLC
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program, if not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * Regression test for commit f43f39958beb ("crypto: user - fix leaking
+ * uninitialized memory to userspace"), or CVE-2018-19854; it was also a
+ * re-introduction of CVE-2013-2547.  This bug caused uninitialized kernel stack
+ * memory to be leaked in some string fields in the replies to CRYPTO_MSG_GETALG
+ * messages over NETLINK_CRYPTO.  To try to detect the bug, this test dumps all
+ * algorithms using NLM_F_DUMP mode and checks all string fields for unexpected
+ * nonzero bytes.
+ */
+
+#include <stdlib.h>
+#include <linux/rtnetlink.h>
+
+#include "tst_test.h"
+#include "tst_crypto.h"
+#include "tst_netlink.h"
+
+static struct tst_crypto_session ses = TST_CRYPTO_SESSION_INIT;
+
+static void setup(void)
+{
+	tst_crypto_open(&ses);
+}
+
+static void __check_for_leaks(const char *name, const char *value, size_t vlen)
+{
+	size_t i;
+
+	for (i = strnlen(value, vlen); i < vlen; i++) {
+		if (value[i] != '\0')
+			tst_brk(TFAIL, "information leak in field '%s'", name);
+	}
+}
+
+#define check_for_leaks(name, field)  \
+	__check_for_leaks(name, field, sizeof(field))
+
+static void validate_one_alg(const struct nlmsghdr *nh)
+{
+	const struct crypto_user_alg *alg = NLMSG_DATA(nh);
+	const struct rtattr *rta = (void *)alg + NLMSG_ALIGN(sizeof(*alg));
+	const struct rtattr *tb[CRYPTOCFGA_MAX + 1] = { 0 };
+	size_t remaining = NLMSG_PAYLOAD(nh, sizeof(*alg));
+
+	check_for_leaks("crypto_user_alg::cru_name", alg->cru_name);
+	check_for_leaks("crypto_user_alg::cru_driver_name",
+			alg->cru_driver_name);
+	check_for_leaks("crypto_user_alg::cru_module_name",
+			alg->cru_module_name);
+
+	while (RTA_OK(rta, remaining)) {
+		if (rta->rta_type < CRYPTOCFGA_MAX && !tb[rta->rta_type])
+			tb[rta->rta_type] = rta;
+		rta = RTA_NEXT(rta, remaining);
+	}
+
+	rta = tb[CRYPTOCFGA_REPORT_LARVAL];
+	if (rta) {
+		const struct crypto_report_larval *p = RTA_DATA(rta);
+
+		check_for_leaks("crypto_report_larval::type", p->type);
+	}
+
+	rta = tb[CRYPTOCFGA_REPORT_HASH];
+	if (rta) {
+		const struct crypto_report_hash *p = RTA_DATA(rta);
+
+		check_for_leaks("crypto_report_hash::type", p->type);
+	}
+
+	rta = tb[CRYPTOCFGA_REPORT_BLKCIPHER];
+	if (rta) {
+		const struct crypto_report_blkcipher *p = RTA_DATA(rta);
+
+		check_for_leaks("crypto_report_blkcipher::type", p->type);
+		check_for_leaks("crypto_report_blkcipher::geniv", p->geniv);
+	}
+
+	rta = tb[CRYPTOCFGA_REPORT_AEAD];
+	if (rta) {
+		const struct crypto_report_aead *p = RTA_DATA(rta);
+
+		check_for_leaks("crypto_report_aead::type", p->type);
+		check_for_leaks("crypto_report_aead::geniv", p->geniv);
+	}
+
+	rta = tb[CRYPTOCFGA_REPORT_COMPRESS];
+	if (rta) {
+		const struct crypto_report_comp *p = RTA_DATA(rta);
+
+		check_for_leaks("crypto_report_comp::type", p->type);
+	}
+
+	rta = tb[CRYPTOCFGA_REPORT_RNG];
+	if (rta) {
+		const struct crypto_report_rng *p = RTA_DATA(rta);
+
+		check_for_leaks("crypto_report_rng::type", p->type);
+	}
+
+	rta = tb[CRYPTOCFGA_REPORT_CIPHER];
+	if (rta) {
+		const struct crypto_report_cipher *p = RTA_DATA(rta);
+
+		check_for_leaks("crypto_report_cipher::type", p->type);
+	}
+
+	rta = tb[CRYPTOCFGA_REPORT_AKCIPHER];
+	if (rta) {
+		const struct crypto_report_akcipher *p = RTA_DATA(rta);
+
+		check_for_leaks("crypto_report_akcipher::type", p->type);
+	}
+
+	rta = tb[CRYPTOCFGA_REPORT_KPP];
+	if (rta) {
+		const struct crypto_report_kpp *p = RTA_DATA(rta);
+
+		check_for_leaks("crypto_report_kpp::type", p->type);
+	}
+
+	rta = tb[CRYPTOCFGA_REPORT_ACOMP];
+	if (rta) {
+		const struct crypto_report_acomp *p = RTA_DATA(rta);
+
+		check_for_leaks("crypto_report_acomp::type", p->type);
+	}
+}
+
+static void validate_alg_list(const void *buf, size_t remaining)
+{
+	const struct nlmsghdr *nh;
+
+	for (nh = buf; NLMSG_OK(nh, remaining);
+	     nh = NLMSG_NEXT(nh, remaining)) {
+		if (nh->nlmsg_seq != ses.seq_num) {
+			tst_brk(TBROK,
+				"Message out of sequence; type=0%hx, seq_num=%u (not %u)",
+				nh->nlmsg_type, nh->nlmsg_seq, ses.seq_num);
+		}
+		if (nh->nlmsg_type == NLMSG_DONE)
+			return;
+		if (nh->nlmsg_type != CRYPTO_MSG_GETALG) {
+			tst_brk(TBROK,
+				"Unexpected message type; type=0x%hx, seq_num=%u",
+				nh->nlmsg_type, nh->nlmsg_seq);
+		}
+		validate_one_alg(nh);
+	}
+}
+
+static void run(void)
+{
+	struct crypto_user_alg payload = { 0 };
+	struct nlmsghdr nh = {
+		.nlmsg_len = sizeof(payload),
+		.nlmsg_type = CRYPTO_MSG_GETALG,
+		.nlmsg_flags = NLM_F_REQUEST | NLM_F_DUMP,
+		.nlmsg_seq = ++(ses.seq_num),
+		.nlmsg_pid = 0,
+	};
+	/*
+	 * Due to an apparent kernel bug, this API cannot be used incrementally,
+	 * so we just use a large recvmsg() buffer.  This is good enough since
+	 * we don't necessarily have to check every algorithm for this test to
+	 * be effective...
+	 */
+	const size_t bufsize = 1048576;
+	void *buf = SAFE_MALLOC(bufsize);
+	size_t res;
+
+	SAFE_NETLINK_SEND(ses.fd, &nh, &payload);
+
+	res = SAFE_NETLINK_RECV(ses.fd, buf, bufsize);
+
+	validate_alg_list(buf, res);
+
+	free(buf);
+	tst_res(TPASS, "No information leaks found");
+}
+
+static void cleanup(void)
+{
+	tst_crypto_close(&ses);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.cleanup = cleanup,
+};
-- 
2.20.0.rc1.387.gf8505762e3-goog

