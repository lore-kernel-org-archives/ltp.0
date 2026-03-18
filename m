Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED94103E177
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 13:27:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 10FF53E57EA
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 14:27:22 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A874F3E6096
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 14:26:46 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B6EA11000DE7
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 14:26:44 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0DFF25BD6B;
 Wed, 18 Mar 2026 13:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773840404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uecwWHt2+ONM87rtk3LLcsol8UZVZA7mx1EAJfCdlX4=;
 b=CPOOsX23wOL+3C3GJgsGavOYj/O/RjweqHNCPR24yj1I34oNcxRlgd4yoGsw8exNlS3uQ/
 MjYFF9k1MePN9Fq0OxB5DCQaLu+RLcIfWrKLky8FJoad1sFbUf1lRnDexucQOVWNhg1pk1
 VPn3ihmbYBjytUXh/9TZV+4f3CHo8vE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773840404;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uecwWHt2+ONM87rtk3LLcsol8UZVZA7mx1EAJfCdlX4=;
 b=aCwgGSrFrU2Dv2u8D9jHdTw8AIpn8wU7e4+fdwSYgaJ4bzhJwF+FuixIeuTdTZT8oMboFl
 KlgfXH9+u7O6i/Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773840404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uecwWHt2+ONM87rtk3LLcsol8UZVZA7mx1EAJfCdlX4=;
 b=CPOOsX23wOL+3C3GJgsGavOYj/O/RjweqHNCPR24yj1I34oNcxRlgd4yoGsw8exNlS3uQ/
 MjYFF9k1MePN9Fq0OxB5DCQaLu+RLcIfWrKLky8FJoad1sFbUf1lRnDexucQOVWNhg1pk1
 VPn3ihmbYBjytUXh/9TZV+4f3CHo8vE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773840404;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uecwWHt2+ONM87rtk3LLcsol8UZVZA7mx1EAJfCdlX4=;
 b=aCwgGSrFrU2Dv2u8D9jHdTw8AIpn8wU7e4+fdwSYgaJ4bzhJwF+FuixIeuTdTZT8oMboFl
 KlgfXH9+u7O6i/Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3F3A4273B;
 Wed, 18 Mar 2026 13:26:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yC3MLhOouml3HwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 18 Mar 2026 13:26:43 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 18 Mar 2026 14:26:39 +0100
Message-ID: <20260318132639.18818-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260318132639.18818-1-pvorel@suse.cz>
References: <20260318132639.18818-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.993]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] power_management: Remove runpwtests0[125].sh
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
Cc: automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

These tests use power-aware scheduling sysfs, which were removed in
8e7fbcbc22c12 ("sched: Remove stale power aware scheduling remnants and dysfunctional knobs")
in kernel 3.5:

/sys/devices/system/cpu/sched_mc_power_savings
/sys/devices/system/cpu/sched_smt_power_savings

runpwtests05.sh was disabled since 2015 anyway.
Remove also pm_sched_domain.py and pm_get_sched_values.c (used only by
runpwtests05.sh) and .gitignore (contained only removed
pm_get_sched_values).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/power_management_tests                |  3 -
 testcases/kernel/power_management/.gitignore  |  1 -
 .../power_management/pm_get_sched_values.c    | 36 ---------
 .../kernel/power_management/runpwtests01.sh   | 71 -----------------
 .../kernel/power_management/runpwtests02.sh   | 68 -----------------
 .../kernel/power_management/runpwtests05.sh   | 76 -------------------
 6 files changed, 255 deletions(-)
 delete mode 100644 testcases/kernel/power_management/.gitignore
 delete mode 100644 testcases/kernel/power_management/pm_get_sched_values.c
 delete mode 100755 testcases/kernel/power_management/runpwtests01.sh
 delete mode 100755 testcases/kernel/power_management/runpwtests02.sh
 delete mode 100755 testcases/kernel/power_management/runpwtests05.sh

diff --git a/runtest/power_management_tests b/runtest/power_management_tests
index 884e615cd8..b670da6ecf 100644
--- a/runtest/power_management_tests
+++ b/runtest/power_management_tests
@@ -1,7 +1,4 @@
 #POWER_MANAGEMENT
-runpwtests01 runpwtests01.sh
-runpwtests02 runpwtests02.sh
 runpwtests03 runpwtests03.sh
 runpwtests04 runpwtests04.sh
-#runpwtests05 runpwtests05.sh
 runpwtests06 runpwtests06.sh
diff --git a/testcases/kernel/power_management/.gitignore b/testcases/kernel/power_management/.gitignore
deleted file mode 100644
index 0c2a3ed4bd..0000000000
--- a/testcases/kernel/power_management/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-pm_get_sched_values
diff --git a/testcases/kernel/power_management/pm_get_sched_values.c b/testcases/kernel/power_management/pm_get_sched_values.c
deleted file mode 100644
index e75c5852e5..0000000000
--- a/testcases/kernel/power_management/pm_get_sched_values.c
+++ /dev/null
@@ -1,36 +0,0 @@
-/************************************************************************
-* Copyright (c) International Business Machines Corp., 2008
-* This program is free software; you can redistribute it and/or modify
-* it under the terms of the GNU General Public License as published by
-* the Free Software Foundation; either version 2 of the License, or
-* (at your option) any later version.
-*
-* This program is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
-* the GNU General Public License for more details.
-* You should have received a copy of the GNU General Public License
-* along with this program; if not, write to the Free Software
-* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-*
-***************************************************************************/
-#include <stdio.h>
-#include "test.h"
-
-const char *TCID = "pm_get_sched_values";
-
-int main(int argc, char **argv)
-{
-	char *param;
-	if (argc == 0)
-		return 1;
-	else {
-		param = argv[1];
-		if (strcmp(param, "sched_mc") == 0)
-			return 2;
-		if (strcmp(param, "sched_smt") == 0)
-			return 2;
-	}
-
-	return 1;
-}
diff --git a/testcases/kernel/power_management/runpwtests01.sh b/testcases/kernel/power_management/runpwtests01.sh
deleted file mode 100755
index 2caf9eab51..0000000000
--- a/testcases/kernel/power_management/runpwtests01.sh
+++ /dev/null
@@ -1,71 +0,0 @@
-#! /bin/sh
-#
-# Copyright (c) International Business Machines  Corp., 2001
-# Author: Nageswara R Sastry <nasastry@in.ibm.com>
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software Foundation,
-# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-export TCID="Power_Management01"
-export TST_TOTAL=1
-
-. test.sh
-. pm_include.sh
-
-test_sched_mc() {
-	get_kernel_version
-	get_valid_input $kernel_version
-
-	invalid_input="3 4 5 6 7 8 a abcefg x1999 xffff -1 -00000
-	2000000000000000000000000000000000000000000000000000000000000000000
-	ox324 -0xfffffffffffffffffffff"
-	test_file="/sys/devices/system/cpu/sched_mc_power_savings"
-	if [ ! -f ${test_file} ] ; then
-		tst_brkm TBROK "MISSING_FILE: missing file ${test_file}"
-	fi
-
-	RC=0
-	echo "${0}: ---Valid test cases---"
-	check_input "${valid_input}" valid $test_file
-	RC=$?
-	echo "${0}: ---Invalid test cases---"
-	check_input "${invalid_input}" invalid $test_file
-	RC=$(( RC | $? ))
-	return $RC
-}
-
-# Checking test environment
-check_arch
-
-# Checking sched_mc sysfs interface
-multi_socket=$(is_multi_socket)
-multi_core=$(is_multi_core)
-if [ ! -f /sys/devices/system/cpu/sched_mc_power_savings ] ; then
-	tst_brkm TCONF "Required kernel configuration for SCHED_MC" \
-		"NOT set"
-else
-	if [ $multi_socket -ne 0 -a $multi_core -ne 0 ] ; then
-		tst_brkm TCONF "sched_mc_power_savings interface in system" \
-			"which is not a multi socket &(/) multi core"
-	fi
-fi
-
-if test_sched_mc ; then
-	tst_resm TPASS "SCHED_MC sysfs tests"
-else
-	tst_resm TFAIL "SCHED_MC sysfs tests"
-fi
-
-tst_exit
diff --git a/testcases/kernel/power_management/runpwtests02.sh b/testcases/kernel/power_management/runpwtests02.sh
deleted file mode 100755
index 805befb033..0000000000
--- a/testcases/kernel/power_management/runpwtests02.sh
+++ /dev/null
@@ -1,68 +0,0 @@
-#! /bin/sh
-#
-# Copyright (c) International Business Machines  Corp., 2001
-# Author: Nageswara R Sastry <nasastry@in.ibm.com>
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software Foundation,
-# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-export TCID="Power_Management02"
-export TST_TOTAL=1
-
-. test.sh
-. pm_include.sh
-
-test_sched_smt() {
-	get_kernel_version
-	get_valid_input $kernel_version
-
-	invalid_input="3 4 5 6 7 8 a abcefg x1999 xffff -1 -00000
-	2000000000000000000000000000000000000000000000000000000000000000000000
-	ox324 -0xfffffffffffffffffffff"
-	test_file="/sys/devices/system/cpu/sched_smt_power_savings"
-	if [ ! -f ${test_file} ] ; then
-		tst_brkm TBROK "MISSING_FILE: missing file ${test_file}"
-	fi
-
-	echo "${0}: ---Valid test cases---"
-	check_input "${valid_input}" valid $test_file
-	RC=$?
-	echo "${0}: ---Invalid test cases---"
-	check_input "${invalid_input}" invalid $test_file
-	RC=$(( RC | $? ))
-	return $RC
-}
-
-# Checking test environment
-check_arch
-
-# Check sched_smt_power_savings interface on HT machines
-hyper_threaded=$(is_hyper_threaded)
-if [ ! -f /sys/devices/system/cpu/sched_smt_power_savings ] ; then
-	tst_brkm TCONF "Required kernel configuration for SCHED_SMT NOT set"
-else
-	if [ $hyper_threaded -ne 0 ]; then
-		tst_brkm TCONF "sched_smt_power_saving interface in system" \
-			"not hyper-threaded"
-	fi
-fi
-
-if test_sched_smt ; then
-	tst_resm TPASS "SCHED_SMT sysfs test"
-else
-	tst_resm TFAIL "SCHED_SMT sysfs test"
-fi
-
-tst_exit
diff --git a/testcases/kernel/power_management/runpwtests05.sh b/testcases/kernel/power_management/runpwtests05.sh
deleted file mode 100755
index 03b6752bf3..0000000000
--- a/testcases/kernel/power_management/runpwtests05.sh
+++ /dev/null
@@ -1,76 +0,0 @@
-#! /bin/sh
-#
-# Copyright (c) International Business Machines  Corp., 2001
-# Author: Nageswara R Sastry <nasastry@in.ibm.com>
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software Foundation,
-# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-export TCID="Power_Management05"
-export TST_TOTAL=2
-
-. test.sh
-. pm_include.sh
-
-# Checking test environment
-check_arch
-
-max_sched_mc=2
-max_sched_smt=2
-
-tst_require_cmds python3
-
-if ! grep sched_debug -qw /proc/cmdline ; then
-	tst_brkm TCONF "Kernel cmdline parameter 'sched_debug' needed," \
-		"CPU Consolidation test cannot run"
-fi
-
-hyper_threaded=$(is_hyper_threaded)
-if [ ! -f /sys/devices/system/cpu/sched_mc_power_savings \
-	-o $hyper_threaded -ne 0 ] ; then
-	tst_brkm TCONF "Required kernel configuration for SCHED_MC" \
-		"NOT set, or sched_mc_power_savings interface in system" \
-		"which is not hyper-threaded"
-fi
-
-# sched_domain test
-echo "max sched mc $max_sched_mc"
-RC=0
-for sched_mc in `seq 0 $max_sched_mc`; do
-	pm_sched_domain.py -c $sched_mc; ret=$?
-	analyze_sched_domain_result $sched_mc $ret; RC=$?
-done
-if [ $RC -eq 0 ]; then
-	tst_resm TPASS "Sched_domain test for sched_mc"
-else
-	tst_resm TFAIL "Sched_domain test for sched_mc"
-fi
-
-# Testcase to validate sched_domain tree
-RC=0
-for sched_mc in `seq 0 $max_sched_mc`; do
-	pm_get_sched_values sched_smt; max_sched_smt=$?
-	for sched_smt in `seq 0 $max_sched_smt`; do
-		pm_sched_domain.py -c $sched_mc -t $sched_smt; ret=$?
-		analyze_sched_domain_result $sched_mc $ret $sched_smt; RC=$?
-	done
-done
-if [ $RC -eq 0 ]; then
-	tst_resm TPASS "Sched_domain test for sched_mc & sched_smt"
-else
-	tst_resm TFAIL "Sched_domain test for sched_mc & sched_smt"
-fi
-
-tst_exit
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
