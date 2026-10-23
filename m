Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B18606A321
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 12:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Tss0Eaa8
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DFB063D25F8
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 14:35:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 036CF3D25F8
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 14:34:49 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6139C6029EF
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 14:34:48 +0200 (CEST)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c4021bc8ce6so11858866b.0
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 05:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792758888; x=1793363688; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G/08ja8iBv/prH9ONKSWE5mRQG61BgpI6czGgp/oSDI=;
 b=Tss0Eaa8g1dZSfnnSBnNn/8Ss1YccOiQw6O9/qiVO2hcoJXvj4Gic7HDgxWnEhhcz3
 Dbdsv3OdOoLIRdvEY9z5BcJ3cBhZPukwnjYw/78goJ8Ns3qBAeqyCWRgTa2pIyaj9jP9
 EP4qAoBzsEH37TbmnpJ+Rm+NTUKp9shM5YY0sDmgzRPYr5/OZnYrbot8m8fdv80x/V9+
 Cq93bpDQJsmf3xHnvsAOv7WR6nylcrHDCcaWlH5+eUQuMiiDOFx+WJrq6J2cPYwfU95/
 hJ+ZHtOkB8LA9BicL4eYc63UQ/BL3Jpp7+eHOlj/Rh8KFVqhVBpO9Zk88IyctAcyF9bo
 7kHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792758888; x=1793363688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=G/08ja8iBv/prH9ONKSWE5mRQG61BgpI6czGgp/oSDI=;
 b=AXPK/OyCsyCpVRWggje4HSgNlhz4qFWORMg56ITqPeK+k6E6uRTFTkA6H4Eer8Mvuw
 mkV4V4v1haKB89EJB24AnctYUieg5HZ6hXBu9G/YJ64DP0VKGMXv4cAwNzULeUPRjuQs
 aUDMf+mc3qFoKt2bvqaVN0Gh+O3buJjrSfM9s1QonDPdyCxe75BDX1rK5wZBSbIHuazU
 XkYwYdCOzPY+MKFmHgwT7M/+ki/pC4S278vir8a4q0r8MiXHWfQaEReEClSI9Y83zosT
 n6SGYFKWbAxd003B0omSBbRnyLqyeEW0ep1Zpz/Bl2Rrdb1dYqq+B64rOooJlsB36Eo5
 i3IQ==
X-Gm-Message-State: AFq9FYJVB9lx+f2tsOvMISVkwOxgxdiq8CUzGrQ06wC5wbnrRHGiNcTa
 lICZcq0uiM1iEJIPvfCEjoVV0XDn5hh5VD19dK2gLV4CyWaz0NslxBk7nhGbRpGd/femC5CF0Od
 4KM8u
X-Gm-Gg: AYBFou2mO1HdNYnvsQ8/QVspSd3p+YMhLcpA/gcY0n+rJKAAh6nncbT6OumweO82Krw
 zEgcobAeoty6sJujtc5dvaYhihkwsDB1wwPzv8quDkmi4l/AeAlId/f2udevn1li152uXzuti82
 rSHWuvrfLIZrvaR9biIAiTmty2AtloevP9DxUz/AUXoFc5b0ULCoc3prfw6N7Ror6xeQwzBl/QI
 CoVHytHyzQJTBPt4t8fd4nf6u1CqJFeJ/TZa1mYQStIQ9bYvOv4ohIftTUzt4P0XxOh2ilNgVTm
 g52K3diEmEugWB1DO2bsRxqYHU5VvjT9ML0fr8MXcs2iF6yhyDS5wxYFiM2wyGeYESl3trIK3dm
 Nk6UpKpK3zlxvuDb3WVlT6yGA6axc/pybWu3/xwabdSSMywl7CKwKyJMRBp2tg1+DM6Qmps2IwO
 t6gt4oRC20dYmCqFXfcLJCT4byoYIcKc8soE8LimTMWKOsbu7CvFWVOHJajDuHD71h3U+HJj8QE
 9Px9Zw7CXTEfVUxAwPJC9EGl7QW4IdgEvkhmtudeOVBX+Dm4iNCOoTFfrhGL4S+xPBLNjCqJV2E
 sZ6GaMxzQBbbn/A=
X-Received: by 2002:a17:906:f83:b0:c41:8e21:4d62 with SMTP id
 a640c23a62f3a-c46a8ef95d4mr308880466b.1.1792758887747; 
 Fri, 23 Oct 2026 05:34:47 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46aec23061sm55538666b.69.2026.10.23.05.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 05:34:47 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: ltp@lists.linux.it,
	pvorel@suse.cz
Date: Fri, 23 Oct 2026 14:34:36 +0200
Message-ID: <20261023123436.1274448-3-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023123436.1274448-1-anders.roxell@linaro.org>
References: <20261023123436.1274448-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] openposix: Add runtest files for kirk
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

LTP has no runtest files for the Open POSIX tests, so kirk can not run
them. They are only run with run.sh, which prints its own summary.

Generate a runtest file for each suite at install time. The speculative
tests are left out, like in run.sh, and the arguments from a test's
.args file go on its runtest line. Each line calls a small wrapper,
openposix_run.sh, which runs the test from its own directory like
run-tests.sh does.

The wrapper also maps PTS_UNSUPPORTED and PTS_UNTESTED to TCONF.
Without it kirk reports them as TWARN and TFAIL.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 testcases/open_posix_testsuite/Makefile       | 13 ++++++++-
 testcases/open_posix_testsuite/bin/Makefile   |  6 +++-
 .../open_posix_testsuite/bin/openposix_run.sh | 29 +++++++++++++++++++
 .../include/mk/config.mk.in                   |  3 ++
 .../scripts/generate-runtest.sh               | 29 +++++++++++++++++++
 5 files changed, 78 insertions(+), 2 deletions(-)
 create mode 100755 testcases/open_posix_testsuite/bin/openposix_run.sh
 create mode 100755 testcases/open_posix_testsuite/scripts/generate-runtest.sh

diff --git a/testcases/open_posix_testsuite/Makefile b/testcases/open_posix_testsuite/Makefile
index 4bead182170d..db141ba3cd8b 100644
--- a/testcases/open_posix_testsuite/Makefile
+++ b/testcases/open_posix_testsuite/Makefile
@@ -74,7 +74,7 @@ generate-makefiles: distclean-makefiles
 		$(top_srcdir)/scripts/generate-makefiles.sh

 .PHONY: install
-install: bin-install conformance-install functional-install stress-install
+install: bin-install conformance-install functional-install stress-install runtest-install

 .PHONY: test
 test: conformance-test functional-test stress-test
@@ -119,6 +119,17 @@ stress-test:
 	@rm -f `if echo "$(LOGFILE)" | grep -q '^/'; then echo "$(LOGFILE)"; else echo "\`pwd\`/$(LOGFILE)"; fi`.$@
 	@$(TEST_MAKE) -C stress test

+RUNTEST_SUITES=		conformance functional stress
+
+.PHONY: runtest-install
+runtest-install: $(addsuffix -install,$(RUNTEST_SUITES))
+	@mkdir -p $(DESTDIR)/$(runtestdir)
+	@set -e; for suite in $(RUNTEST_SUITES); do \
+		$(top_srcdir)/scripts/generate-runtest.sh \
+			$(DESTDIR)/$(testdir) "$(testdir_rel)" $$suite \
+			> $(DESTDIR)/$(runtestdir)/openposix-$$suite; \
+	done
+
 # Tools build and install targets.
 .PHONY: bin-install
 bin-install:
diff --git a/testcases/open_posix_testsuite/bin/Makefile b/testcases/open_posix_testsuite/bin/Makefile
index 262a6567c5b6..5dfff99effcb 100644
--- a/testcases/open_posix_testsuite/bin/Makefile
+++ b/testcases/open_posix_testsuite/bin/Makefile
@@ -16,7 +16,7 @@ clean:
 	@rm -f t0.val

 .PHONY: install
-install: clean $(DESTDIR)/$(bindir) $(DESTDIR)/$(testdir_bin)
+install: clean $(DESTDIR)/$(bindir) $(DESTDIR)/$(testdir_bin) $(DESTDIR)/$(ltp_bindir)
 	set -e; for file in $(INSTALL_BIN_TARGETS); do           \
 		install -m 00755 $$file $(DESTDIR)/$(bindir)/$$file; \
 	done
@@ -27,9 +27,13 @@ install: clean $(DESTDIR)/$(bindir) $(DESTDIR)/$(testdir_bin)
 		install -m 00755 $$file $(DESTDIR)/$(testdir_bin)/$$file; \
 	done

+	install -m 00755 openposix_run.sh $(DESTDIR)/$(ltp_bindir)/

 $(DESTDIR)/$(bindir):
 	mkdir -p $@

 $(DESTDIR)/$(testdir_bin):
 	mkdir -p $@
+
+$(DESTDIR)/$(ltp_bindir):
+	mkdir -p $@
diff --git a/testcases/open_posix_testsuite/bin/openposix_run.sh b/testcases/open_posix_testsuite/bin/openposix_run.sh
new file mode 100755
index 000000000000..43c52a38d956
--- /dev/null
+++ b/testcases/open_posix_testsuite/bin/openposix_run.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2026 Linaro Limited
+
+LTPROOT=${LTPROOT:-$(cd "$(dirname "$0")/../.." && pwd)}
+
+if [ $# -lt 1 ]; then
+	echo "Usage: $(basename "$0") <test path relative to LTPROOT> [args]" >&2
+	exit 2
+fi
+
+test_path=$LTPROOT/$1
+test_file=${test_path##*/}
+shift
+
+if [ ! -x "$test_path" ]; then
+	echo "$test_path is missing or not executable" >&2
+	exit 2
+fi
+
+cd "${test_path%/*}" || exit 2
+
+./"$test_file" "$@"
+ret=$?
+
+case $ret in
+4|5) exit 32 ;;
+*) exit $ret ;;
+esac
diff --git a/testcases/open_posix_testsuite/include/mk/config.mk.in b/testcases/open_posix_testsuite/include/mk/config.mk.in
index 20422e0f1047..fae80116bbf7 100644
--- a/testcases/open_posix_testsuite/include/mk/config.mk.in
+++ b/testcases/open_posix_testsuite/include/mk/config.mk.in
@@ -14,4 +14,7 @@ testdir_rel := @testdir@
 testdir     := ${prefix}/${testdir_rel}
 testdir_bin := ${testdir}/bin

+ltp_bindir  := ${prefix}/testcases/bin
+runtestdir  := ${prefix}/runtest
+
 CFLAGS  += -std=c99 -D_POSIX_C_SOURCE=200809L -D_XOPEN_SOURCE=700 -Wall -Wextra
diff --git a/testcases/open_posix_testsuite/scripts/generate-runtest.sh b/testcases/open_posix_testsuite/scripts/generate-runtest.sh
new file mode 100755
index 000000000000..e561a7adcf21
--- /dev/null
+++ b/testcases/open_posix_testsuite/scripts/generate-runtest.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2026 Linaro Limited
+
+if [ $# -ne 3 ]; then
+	echo "Usage: $(basename "$0") <installed testdir> <testdir relative to LTPROOT> <suite>" >&2
+	exit 1
+fi
+
+installed_testdir=$1
+testdir_rel=$2
+suite=$3
+
+cd "$installed_testdir" || exit 1
+
+if [ ! -d "$suite" ]; then
+	echo "$installed_testdir/$suite does not exist" >&2
+	exit 1
+fi
+
+find "$suite" -name speculative -prune -o -type f \
+	\( -name '*.run-test' -o -name '*.sh' ! -name run.sh \) -print | sort | \
+while read -r test_path; do
+	test_name=${test_path##*/}
+	args_file=${test_path%/*}/${test_name%%.*}.args
+	args=
+	[ -f "$args_file" ] && read -r args < "$args_file"
+	echo "${test_name%.*} openposix_run.sh ${testdir_rel:+$testdir_rel/}$test_path${args:+ $args}"
+done
--
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
