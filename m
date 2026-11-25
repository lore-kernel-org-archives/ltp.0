Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691C7606A31E
	for <ltp@archiver.kernel.org>; Wed, 25 Nov 2026 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pKAMFDbX
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1DDE03EAC2E
	for <ltp@archiver.kernel.org>; Wed, 25 Nov 2026 22:10:31 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C8753EA95C
 for <ltp@lists.linux.it>; Wed, 25 Nov 2026 22:09:40 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0B9D5600964
 for <ltp@lists.linux.it>; Wed, 25 Nov 2026 22:09:40 +0100 (CET)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c5187b42a2dso48204066b.3
 for <ltp@lists.linux.it>; Wed, 25 Nov 2026 13:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795640979; x=1796245779; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AZv0Tng18TDfZ7kV0Qxgb/RRjK2vgUBsPq2Rx/Lc8sE=;
 b=pKAMFDbX+g/0SGTK4y+twDZ0GBjK/bq1KrBEqFnko7DiDuNLtZqw/1cMyKFCZnwDdu
 3me9mmC5zKM5LUrd5pYOrtyd7VFCN2ldgB69TedxfrqBiGcMDAUoF+HpEwgx6KnSxqN4
 H0SSoOO37UlTZRYCCgiPKtT8sGWW5KMEyCB8PSjF9K/mU2lgPTvmlvKfDeMVWFzlpYrd
 bDxJbdKZvIDDpEDgiO2vZfiau9c/gzcQ+JJQ7JB9/7MfbzlwH5Mdadnnf/2SSc9Olduw
 v7v4kurDACfcJUCU6otyvWVO40yRZYBQnmwEW+vMXyIdmq/WYv4Exd71KP5maiET5VIw
 W8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795640979; x=1796245779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AZv0Tng18TDfZ7kV0Qxgb/RRjK2vgUBsPq2Rx/Lc8sE=;
 b=lRrKms+uGSum2JS5k9zzmZmEK7nMIje6aU0zUq2K9IpSAbEAxt+GisnRcVNoIU0sI7
 SnlQXQo/6VMMtxQsrexGp5H7T7URcEz0tsnXRZJL398Vw8KOyfbD+WYcg4c1bkSMBALj
 Hlxp4rEmGsfiEMY0StKw7W9z/i67e4/66Hv76GMrB5dcFOCcgkMk1qIY0cNNUN8Ix7jx
 NTH/iNDy9vRWP2mEWOul9XR5zSBPwuoLoQYrCK/yU1bJyUWNI/MLf1Ts+uiwGa1faMQJ
 mZnkR9IAFd5k1ERsoqB1KH1tkY87O83Uri3nGpW2gpBNYEb6UC7YGg48sgOgWZtIh78x
 k4gw==
X-Gm-Message-State: APuU4Z+l+etM1/2AAZqJpwErSgyec7dsaLtm3j9YpwOBai568KGMG5zW
 s8pdh2ViOZyv4ON0G5rPgXrLEMZAmT/UIzRwyLzZtZUq4dNLj8KP+p23i9zgRQmbcHF3Rwepqqk
 VGU0q
X-Gm-Gg: AZFdTZdSzsS3Vb73s+lNc3BnCJxxFNqY8Xcl+1Wuf3tjCEnk7HoXhk1mdGyyo1p7t3X
 Un23XMjOPNWKnpOCHoRkcnssHwh0LULl8gMWDcGkacrBUQsNCZKBQ/L0L1Ed5H+8jvX5m9IIpsp
 fJwxCkKJy1DZp+sLvNgKVaEUgyG9Wprk4oy5/eJxOoGST4VXoB1695YdBvGqdzBlOIK0t/td1km
 2lneveO8aUExgsYizCnreKbdHjnpJ9fWFrs4c+maElaFxPd2dJphi+0cfn1VX8fxeNz+QpY3roG
 WDxSAAt9MsDAXXbvK2utWkif2CCDKo5nQUQjs+hcls73f5WWe77v89h62SPF3LEVcPgxB1VUWSH
 j45ASGIF1ham5WEdu1HMIqWMsTkiTgzd+kQI0nQLmGum9pcvKtn894VHuLOG7i2v5H8hWo4KewJ
 xjqaivle38V27pgRkb3wBLyHm2rQAMIBFJypMsOyHA+iBBG7XXRXxojP0HDsEql7a0msFlSG3Ck
 sPrY2RnmHzWBxtfXe/0lK9cxes5Fyxa290BaNXrFzPi5W51/AaeZFR+Oyep5PlLtQ0X8tvUZmmC
 4bMghoAtSs3sZiFwn5DA/f+O1GCY36fYSzvet+5TPzbihj0i5qUv65tgbnYMYWrJZlDaR7ucjqi
 vMYFVgD1x/Q==
X-Received: by 2002:a17:906:68d5:b0:c51:4fd:1aef with SMTP id
 a640c23a62f3a-c513a50ab80mr1540355066b.2.1795640979371; 
 Wed, 25 Nov 2026 13:09:39 -0800 (PST)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513afc5396sm685527066b.58.2026.11.25.13.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 13:09:39 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: ltp@lists.linux.it,
	pvorel@suse.cz
Date: Wed, 25 Nov 2026 22:09:33 +0100
Message-ID: <20261125210933.2913177-5-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125210933.2913177-1-anders.roxell@linaro.org>
References: <20261125210933.2913177-1-anders.roxell@linaro.org>
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
Subject: [LTP] [PATCH v3 4/4] openposix: Add runtest files for kirk
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

Kirk can not run the Open POSIX tests, because they have no runtest
files.

Generate one for each suite at install time. The list comes from the
installed run.sh files, so old test binaries left in DESTDIR are not
listed. The speculative tests are left out like in run.sh, and a run.sh
without a run-tests.sh line fails the install.

Each line calls openposix_run.sh. It runs the test from its own
directory and maps PTS_UNSUPPORTED and PTS_UNTESTED to TCONF, so kirk
does not report them as TWARN and TFAIL.

A removed test directory is still listed, because its old run.sh stays
in DESTDIR.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 testcases/open_posix_testsuite/Makefile       | 11 +++++-
 testcases/open_posix_testsuite/bin/Makefile   |  6 +++-
 .../open_posix_testsuite/bin/openposix_run.sh | 29 +++++++++++++++
 .../include/mk/config.mk.in                   |  3 ++
 .../scripts/generate-runtest.sh               | 35 +++++++++++++++++++
 5 files changed, 82 insertions(+), 2 deletions(-)
 create mode 100755 testcases/open_posix_testsuite/bin/openposix_run.sh
 create mode 100755 testcases/open_posix_testsuite/scripts/generate-runtest.sh

diff --git a/testcases/open_posix_testsuite/Makefile b/testcases/open_posix_testsuite/Makefile
index 4bead182170d..ce41643686d5 100644
--- a/testcases/open_posix_testsuite/Makefile
+++ b/testcases/open_posix_testsuite/Makefile
@@ -74,7 +74,7 @@ generate-makefiles: distclean-makefiles
 		$(top_srcdir)/scripts/generate-makefiles.sh
 
 .PHONY: install
-install: bin-install conformance-install functional-install stress-install
+install: bin-install conformance-install functional-install stress-install runtest-install
 
 .PHONY: test
 test: conformance-test functional-test stress-test
@@ -119,6 +119,15 @@ stress-test:
 	@rm -f `if echo "$(LOGFILE)" | grep -q '^/'; then echo "$(LOGFILE)"; else echo "\`pwd\`/$(LOGFILE)"; fi`.$@
 	@$(TEST_MAKE) -C stress test
 
+.PHONY: runtest-install
+runtest-install: $(addsuffix -install,$(SUBDIRS))
+	@mkdir -p $(DESTDIR)/$(runtestdir)
+	@set -e; for suite in $(SUBDIRS); do \
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
index 000000000000..d523fa483bb6
--- /dev/null
+++ b/testcases/open_posix_testsuite/scripts/generate-runtest.sh
@@ -0,0 +1,35 @@
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
+run_tests_line='^[^ ]*/run-tests\.sh [^ ]* '
+
+find "$suite" -name speculative -prune -o -name run.sh -print | sort | \
+while read -r run_sh; do
+	if ! grep -q "$run_tests_line" "$run_sh"; then
+		echo "$run_sh has no run-tests.sh line" >&2
+		exit 1
+	fi
+	dir=${run_sh%/run.sh}
+	tests=$(sed -n "s,$run_tests_line,,p" "$run_sh")
+	for test_name in $tests; do
+		[ -f "$dir/$test_name" ] || continue
+		echo "${test_name%.*} openposix_run.sh ${testdir_rel:+$testdir_rel/}$dir/$test_name"
+	done
+done
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
