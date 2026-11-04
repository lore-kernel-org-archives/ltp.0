Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB82B606A31B
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 22:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Ddymy+Sr
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C7BC43CD3B4
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 23:51:38 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8525B3CD3B0
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 23:50:57 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E07B32000E8
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 23:50:56 +0100 (CET)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6ae14ee2d0bso251595a12.2
 for <ltp@lists.linux.it>; Wed, 04 Nov 2026 14:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793832656; x=1794437456; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f2DQ73s0lwLF2TlY7tDZoEy0DZQqMlL5vV0rwlStejo=;
 b=Ddymy+SrKqy0JIy1Uxg7ly9EE18SDHaDSZTqpFnNCkg+myxaQMi5OCgqoAwKbhBsTr
 sXHaII1vuJ1Fn23TXP2Rj3JtPe+K64Y2yV0e3vwH9j0Iuu+1EiVTfXCfD9/TP4cBe9Fv
 ECkPg2FgK/Hov2a4bfeBSnj+gi2qixyVIPo8aLvHzrZ/pK9ZQtIgWqu+xUB1TSuzOe+G
 hImO5E8wfo7ke09RlEGu3lfWHFtA5XOmnrMiC9d8b8Gjjo6QGwXk+AHP9SbXOY4GCsDC
 Wikaqs7WtBog5d9jYWFwXvSEHJiMLaOwPQprikM+SFjVSFjcV/FcCtlCPNzaQ8W3PGKg
 cavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793832656; x=1794437456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=f2DQ73s0lwLF2TlY7tDZoEy0DZQqMlL5vV0rwlStejo=;
 b=Ttr/aX+WOsyB1bDkqxPtK/aJuCcVpJeiuRU4c9wNU3f2c0A3dBd8tZRHKi934+u2k1
 q58oRtf2JTf1GqxBGiH6x27dRZF/n+3Z2raEcj3jTse5uY6WoTTl1kIe3dNZ0pr9sOfx
 ndyOJtZosIE0dY8v/25HffK2L4equzw46nluleCZbpYYon0aZp07pHCeg6cV1E03E5k7
 YVnqCLcMbU9pW2mLb3/cenX61krX2eNaf1CjL0t1Cous/YYygAw3joTpkT/DMBRLd5U/
 kW9GsR3ntxG6L6pLTMnPYtBfRo2zzrPniTCla0tMqqu9Ss0DQYVOkwWjog/rjKIwk1hU
 LhvQ==
X-Gm-Message-State: APuU4Z+b3XGXfIFQH/zNSN7lt4Ym280ut7v8qHrYZSf46V4+w9+VJzd6
 MQ5ei5BUHYbD6DNDUmqlLEWWMeRfLK79uS9XrhbbeeZXsnnJAwco8uCs+80JaMqeZTnGnBeX6ln
 aQ1hc
X-Gm-Gg: AYBFou3a6zqhU2W37r1nlwYcxyRzFEWS4iptT850Xi/WVtkUUkdGRyFH+21VqA4Pa55
 qfQvc4lTQVfEtvijwbVYR62sPzWqqNHYUZkEQx08xXuU8bolXv/lP14L2CjYpVgwLlDs/nF8RSO
 W0Dek/f1Wc0ImrBvzkHo/tSQPJjQD45TZrhWP2n0IOVP6+IdBVOOBVS3803GjQReIZDzuCKF9uN
 q2Ry7mSrmoX3PXJnv742prgCV/pQmHjy7JWGfDbX1NWiT3DuyKAwMvJn/pyvB3BefjJ8MSR0jRE
 PqDMd3zjoKFdAJ5UvZakhtZSoYcRs03GUaxtPcQT7ZfEdWPHgY5gDg7D+7i292qvXBqlUVSIn4t
 loPrPZujmxxEcgDMXlfGzGoDuFEHdi+B5QdYMgVSjqzJeXCaSY5sQ116mGScYwivrJQJBug2IWd
 VVI+f12Hq3khxWDYljg/zy3DXpXwnIT7jpcOLWvKqmSINId6jWRTYJ0bZb2gQvwSA3aWHKsUJ3P
 6lHHoi2+kRAIyhn+dWZ+S5YWXir9AwNfSl1Xa6wXTX2uGBMDEBCp316zaZxfsF/lFAAJ/Gb9l91
 6oIwmVqr5TElz53aTsxUDp9ITBAKN2/93Q8S5u9iR+SyMfjnb3D2KqwHetwBClOznuvYg9IG7tJ
 EwlLHeVLVLg==
X-Received: by 2002:a17:906:2741:b0:c40:5ee3:8694 with SMTP id
 a640c23a62f3a-c4ca7ab087dmr1449711266b.4.1793832656238; 
 Wed, 04 Nov 2026 14:50:56 -0800 (PST)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d0e466be0sm115207266b.54.2026.11.04.14.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 14:50:55 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: ltp@lists.linux.it,
	pvorel@suse.cz
Date: Wed,  4 Nov 2026 23:50:51 +0100
Message-ID: <20261104225051.402911-3-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104225051.402911-1-anders.roxell@linaro.org>
References: <20261104225051.402911-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] openposix: Add runtest files for kirk
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

The list of tests comes from the installed run.sh files, so it is the
same list that run.sh runs. Old tests left in DESTDIR from an earlier
install do not end up in the runtest files.

The wrapper also maps PTS_UNSUPPORTED and PTS_UNTESTED to TCONF.
Without it kirk reports them as TWARN and TFAIL.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 testcases/open_posix_testsuite/Makefile       | 11 +++++-
 testcases/open_posix_testsuite/bin/Makefile   |  6 ++-
 .../open_posix_testsuite/bin/openposix_run.sh | 29 ++++++++++++++
 .../include/mk/config.mk.in                   |  3 ++
 .../scripts/generate-runtest.sh               | 38 +++++++++++++++++++
 5 files changed, 85 insertions(+), 2 deletions(-)
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
index 000000000000..da743d3c1edb
--- /dev/null
+++ b/testcases/open_posix_testsuite/scripts/generate-runtest.sh
@@ -0,0 +1,38 @@
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
+		base=${test_name%.*}
+		args=
+		[ -f "$dir/$base.args" ] && read -r args < "$dir/$base.args"
+		echo "$base openposix_run.sh ${testdir_rel:+$testdir_rel/}$dir/$test_name${args:+ $args}"
+	done
+done
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
