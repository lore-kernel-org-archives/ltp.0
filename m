Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCF3C44508
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 17:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784048493; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=a8RNkJhpBTMOTjYmv5sd8An7qJhv5jpIfHscmlLN4e4=;
 b=EUBCWnjP5Wu3qTcWeoXsyLoIrEsdy1+ZwduMuWRee1pWfYs99x9aaiN5audNW0yeUS0qv
 /eKvTO0e/mnwEW1BYxtO34b5pknimm5OzV09T8mHAaieC8JdIG28oRGqNQ5lWKf7HtZ7FLn
 quGwMuuQllcauRXSHo42eOHhOGwkrng=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD66C3E968E
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 19:01:33 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A1A8C3E56E7
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 18:28:39 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1887A60080D
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 18:28:38 +0200 (CEST)
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 709ED3F608
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 16:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1784046518;
 bh=hS5wu5nuPJr9dxw19SClndeK0hAp3zz2eVa/yh1vzWE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=EUQVDIPRRYkajLE2CPcKoqR5DXZrlJhBLSEv2uWC+VbBURvPVr7wvWqgzK6F9LQ4C
 MtJLgzl/yJw/aBGkWvR/lbtMUyvZBB2ZUk1pojir3HG978RPXuzNNrrgGOC4OQ2NYp
 0h6QBV8D/hGLD4gtZeqR4UzsJwhEoqXxb3hssRMNUg9TI9sS4VQt6L4QucWa5hoX3e
 5SywV29YZxZdKSIg91CDfIC4Cs38Zx477Z6r0zX+V+4k+oRATyjeBNrb2esrgNewaq
 gEgssKd27aSYV+zAot8caMvbRoLdeANI2IKNI8ki6rEHkoXLYL4jT+0FkerESggSIu
 8CmB37R8PgirMx98I1zz9JuDi43pDFHmxOf4q6uRli39YD2J0/AZvzCa42WBkP0Hfd
 pmKRGcuLgMzlRHC5r+dCdLth5DA6R2571j+XX5SFc6dmh2GUjmQON5cE7VaigPDbpR
 /1RDxEU/otf6MxLi3jKoejt3FaaQYMykGdkKSWKTnTOZNmrXI77RxvnHtTgj8kpITB
 zjIWGmGYZ6yMtfaLKV/cleSXQoMlyykMhh1e3ByHywgPZxFNE21E7RhBQ34JH1mjO4
 iSn3QliZGyVna3R5mV5d2ZA4DB8EWQRGs1docKDA8zPpXblO21Yy9E0XWEJs/IgpHQ
 oJSU77C6DRIRPkU3t6ts2jpA=
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e8004d60eso230942685a.1
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 09:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784046517; x=1784651317;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hS5wu5nuPJr9dxw19SClndeK0hAp3zz2eVa/yh1vzWE=;
 b=p63B1ybK4CGMDIfameR+oqgN/pfc4IVgVD2LeYhbJKxArMEQDvayL9VjxQYhNsbuYV
 KKaijEWm2OHREHXoP0+tXGzHJoVYD3eoG/V7C53zImG2dpFYd3AX8Jk+cfAJQEQ/kAWi
 OxjZcrj4RBYrD+SN3hV3MWXWOPObgYCoAouiA2FTmyH2RXcxcDXKayBajYcZAfjOJAJO
 nEFQES61ZadxMrfUoxFE41vexsflAQcUHHzxpi03Ey02g1sH46cx38n8/irozf88D5Or
 A9FVmTXAoa8B08Qdi3rgUoBGTujM5FcjmBRIYkUs+pYV8FxiwA/N5ppeyXFjQ+a2npCv
 IYrA==
X-Gm-Message-State: AOJu0YyBHZENwiB5lP2AcCtGcWXGqM8CivXz3yg4z0YBJXrqO44mJy3D
 j/rYccl2t1hsnJhA94TqusNDhCbJT2vYh0GEZnG8yXtP7CdYEWmbs4wlPVWQqIa8jOAUdO9M+r8
 CpxwhVDzeixWZjGEJ+tdKAf+4kuyf+qcNsL6RETZKipft3Gru/wzlnHU7QH36OW9s4RwO3gXb1N
 sZ
X-Gm-Gg: AfdE7clFh/zDs2zAmguydrXh/usLi1eHDciBio2FukXB1NBNZTdlUnaIxAB127se4wn
 faNSYLnidewR1f7kzaFvcgHWCJrI/EI4QMkJgajeZ3zBw8StJ3I33C6oTRrw9zi9MW7dRtdS1bw
 jv0as6Uiv8ZUHDD4uJB5N90AfDoXaFP+S17cw2M5R+S0DZcnkW5W9jHh75Xyd9rnZ3EvQHPR0Fa
 H3XRnsr1BnFOG4FwzhtyF/9wTTxiMbITxhnbfNpVjaskTfPqUdImci9rGQSV3qUGy9X4HW3Gec9
 uPZc4qRcwBTjileTumPDzLHqXg4QO/hPqJ3Ou7MOKgS2oo9uNlZh6B0wVjHuignm7Dg+bcCEHNz
 ChvEkUhh5gGg/F8kS9s1I5+SF7B7TXaZ6wuRtchit51tMluNSBeFwDpC888mYx2GTrfQwjbCw0A
 ==
X-Received: by 2002:a05:620a:6e82:20b0:92e:f690:56cf with SMTP id
 af79cd13be357-92ef6905832mr1015700885a.59.1784046517409; 
 Tue, 14 Jul 2026 09:28:37 -0700 (PDT)
X-Received: by 2002:a05:620a:6e82:20b0:92e:f690:56cf with SMTP id
 af79cd13be357-92ef6905832mr1015695285a.59.1784046516638; 
 Tue, 14 Jul 2026 09:28:36 -0700 (PDT)
Received: from framework.cable.rcn.com ([130.44.166.248])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92ee5b4c834sm1481529085a.1.2026.07.14.09.28.36
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 09:28:36 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 14 Jul 2026 12:28:34 -0400
Message-ID: <20260714162834.47191-1-benjamin.wheeler@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 14 Jul 2026 19:01:13 +0200
Subject: [LTP] [PATCH v1 1/1] cpuhotplug03.sh: Poll for CPU migration
 instead of sleeping
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
From: Benjamin Wheeler via ltp <ltp@lists.linux.it>
Reply-To: Benjamin Wheeler <benjamin.wheeler@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The test onlined the target CPU, slept a fixed one second and then
checked once whether the scheduler had migrated a cpuhotplug_do_spin_loop
process onto it. A blind sleep is both racy (the migration may not have
happened yet on a busy or slow system) and wasteful (it always waits the
full second even when the migration is immediate).

Replace the sleep and single check with tst_retry(), which retries the
check a few times until a process is seen on the onlined CPU. The
migration check is factored out into a check_cpu_migrated() helper.

tst_retry() is the retry helper available in the legacy shell test API
(test.sh) that this test uses; TST_RETRY_FUNC() only exists in the new
API (tst_test.sh), so it is not usable here without converting the whole
test, which is out of scope for this change.

The TBROK vs TFAIL distinction is preserved: if no spin loop processes
are running at all it is reported as a broken test (TBROK), whereas
processes running but none migrating to the onlined CPU remains a
genuine failure (TFAIL).

Signed-off-by: Benjamin Wheeler <benjamin.wheeler@canonical.com>
---
 .../cpu_hotplug/functional/cpuhotplug03.sh    | 43 ++++++++++++-------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
index 3a461e30c..1577f3e6e 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
@@ -50,6 +50,20 @@ do_clean()
 	set_all_cpu_states "$cpu_states"
 }

+# check_cpu_migrated()
+#
+#  Returns 0 if at least one cpuhotplug_do_spin_loop process is running
+#  on CPU_TO_TEST, non-zero otherwise.
+#  Since procps v3.3.15, we need to accurately select command name by -C
+#  option, because procps cannot truncate normal command name to 15
+#  characters by default.
+check_cpu_migrated()
+{
+	ps -o psr -o command --no-headers -C cpuhotplug_do_s \
+		| sed -e "s/^ *//" | cut -d' ' -f 1 \
+		| grep -q "^${CPU_TO_TEST}$"
+}
+
 while getopts c:l: OPTION; do
 case $OPTION in
 	c)
@@ -120,21 +134,18 @@ until [ $LOOP_COUNT -gt $HOTPLUG03_LOOPS ]; do
 		tst_brkm TBROK "CPU${CPU_TO_TEST} cannot be onlined"
 	fi

-	sleep 1
-
-	# Verify at least one process has migrated to the new CPU
-	# Since procps v3.3.15, we need to accurately select command name
-	# by -C option, because procps cannot trucate normal command name
-	# to 15 characters by default).
-	ps -o psr -o command --no-headers -C cpuhotplug_do_s
-	if [ $? -ne 0 ]; then
-		tst_brkm TBROK "No cpuhotplug_do_spin_loop processes \
-			found on any processor"
-	fi
-	NUM=`ps -o psr -o command --no-headers -C cpuhotplug_do_s \
-		| sed -e "s/^ *//" | cut -d' ' -f 1 | grep "^${CPU_TO_TEST}$" \
-		| wc -l`
-	if [ $NUM -lt 1 ]; then
+	# Verify at least one process has migrated to the new CPU.
+	# Retry the check in a loop instead of blindly sleeping, since the
+	# scheduler may take a while to migrate a task to the freshly
+	# onlined CPU.
+	if ! tst_retry "check_cpu_migrated"; then
+		# Distinguish a broken workload (no spin loop processes running
+		# at all) from a genuine failure (processes running, but none
+		# migrated to the onlined CPU).
+		if ! ps --no-headers -C cpuhotplug_do_s >/dev/null; then
+			tst_brkm TBROK "No cpuhotplug_do_spin_loop processes \
+				found on any processor"
+		fi
 		tst_resm TFAIL "No cpuhotplug_do_spin_loop processes found on \
 			CPU${CPU_TO_TEST}"
 		tst_exit
@@ -145,7 +156,7 @@ until [ $LOOP_COUNT -gt $HOTPLUG03_LOOPS ]; do
 	LOOP_COUNT=$((LOOP_COUNT+1))
 done

-tst_resm TPASS "$NUM cpuhotplug_do_spin_loop processes found on \
+tst_resm TPASS "cpuhotplug_do_spin_loop process(es) migrated to \
 	CPU${CPU_TO_TEST}"

 tst_exit
--
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
