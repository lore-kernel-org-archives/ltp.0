Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07863C0219D
	for <ltp@archiver.kernel.org>; Thu, 13 Feb 2025 13:38:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 76A943C9A89
	for <ltp@archiver.kernel.org>; Thu, 13 Feb 2025 14:38:33 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 435823C974A
 for <ltp@lists.linux.it>; Thu, 13 Feb 2025 14:37:36 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6B3E96170C6
 for <ltp@lists.linux.it>; Thu, 13 Feb 2025 14:37:36 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9BE472259E;
 Thu, 13 Feb 2025 13:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739453855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iRrezzggemKBquPNQY3fjDnuGbTyFlCg04rNjYVwi7s=;
 b=lP0dnuHtqiymbgo1aj/TTNnZnFMBLtJaw8sMSFSS+qqNTp572bDBmwkMRoZtyaOrQ8aJll
 KNwqoifh0fqUyvAX6bhMPrjEEW9MJxxUP9VKhTT4XCTe8w5HGyjOEyCo5v1Y9r+pJbymkw
 MsUNwRu72cyePS1tSpiwI4uycNg5srI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739453855;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iRrezzggemKBquPNQY3fjDnuGbTyFlCg04rNjYVwi7s=;
 b=a1F5M6eFPHJ7afL7wh/TgRVu1y0TfT32/mZsjtArUXuXd+Equ+NL3vfSpRrRuL5+6wTuJj
 DDzqk7UJ0lI70VAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739453855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iRrezzggemKBquPNQY3fjDnuGbTyFlCg04rNjYVwi7s=;
 b=lP0dnuHtqiymbgo1aj/TTNnZnFMBLtJaw8sMSFSS+qqNTp572bDBmwkMRoZtyaOrQ8aJll
 KNwqoifh0fqUyvAX6bhMPrjEEW9MJxxUP9VKhTT4XCTe8w5HGyjOEyCo5v1Y9r+pJbymkw
 MsUNwRu72cyePS1tSpiwI4uycNg5srI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739453855;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iRrezzggemKBquPNQY3fjDnuGbTyFlCg04rNjYVwi7s=;
 b=a1F5M6eFPHJ7afL7wh/TgRVu1y0TfT32/mZsjtArUXuXd+Equ+NL3vfSpRrRuL5+6wTuJj
 DDzqk7UJ0lI70VAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6348813874;
 Thu, 13 Feb 2025 13:37:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0FmSFp/1rWdSVgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 13 Feb 2025 13:37:35 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu, 13 Feb 2025 14:37:29 +0100
Message-ID: <20250213133730.27999-3-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250213133730.27999-1-andrea.cervesato@suse.de>
References: <20250213133730.27999-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.01 / 50.00]; BAYES_HAM(-2.21)[96.27%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo,suse.com:email];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 2/2] options: add new --run-pattern
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Andrea Cervesato <andrea.cervesato@suse.com>

Add the --run-pattern|-S option to filter tests based on a specific
string pattern. This option accepts a list of strings, allowing users
to specify multiple patterns. A common usage example is as follows:

    kirk --run-pattern sendfile madvice

Each string is compared against the labels defined in the runtest file,
and only tests containing the specified patterns will be executed.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 libkirk/main.py               |  8 +++++-
 libkirk/session.py            | 54 ++++++++++++++++++++++++++++++++---
 libkirk/tests/test_session.py | 13 +++++++++
 3 files changed, 70 insertions(+), 5 deletions(-)

diff --git a/libkirk/main.py b/libkirk/main.py
index 4c86c8b..6780e43 100644
--- a/libkirk/main.py
+++ b/libkirk/main.py
@@ -304,6 +304,7 @@ def _start_session(
             await session.run(
                 command=args.run_command,
                 suites=args.run_suite,
+                pattern=args.run_pattern,
                 report_path=args.json_report,
                 restore=restore_dir,
             )
@@ -414,6 +415,11 @@ def run(cmd_args: list = None) -> None:
         "-r",
         nargs="*",
         help="List of suites to run")
+    parser.add_argument(
+        "--run-pattern",
+        "-S",
+        nargs="*",
+        help="Filter tests using a pattern string")
     parser.add_argument(
         "--run-command",
         "-c",
@@ -465,7 +471,7 @@ def run(cmd_args: list = None) -> None:
     if args.json_report and os.path.exists(args.json_report):
         parser.error(f"JSON report file already exists: {args.json_report}")
 
-    if not args.run_suite and not args.run_command:
+    if not args.run_suite and not args.run_command and not args.run_pattern:
         parser.error("--run-suite/--run-command are required")
 
     if args.skip_file and not os.path.isfile(args.skip_file):
diff --git a/libkirk/session.py b/libkirk/session.py
index 53f07cf..2f27790 100644
--- a/libkirk/session.py
+++ b/libkirk/session.py
@@ -14,6 +14,7 @@ import libkirk.events
 from libkirk import KirkException
 from libkirk.sut import SUT
 from libkirk.sut import IOBuffer
+from libkirk.data import Suite
 from libkirk.results import TestResults
 from libkirk.export import JSONExporter
 from libkirk.scheduler import SuiteScheduler
@@ -186,16 +187,16 @@ class Session:
         await libkirk.events.fire("sut_stop", self._sut.name)
         await self._sut.stop(iobuffer=RedirectSUTStdout(self._sut, False))
 
-    async def _read_suites(self, suites: list, restore: str) -> list:
+    async def _get_suites_objects(self, names: list) -> list:
         """
-        Read suites and return a list of Suite objects.
+        Return suites objects by giving their names.
         """
         coros = []
-        for suite in suites:
+        for suite in names:
             coros.append(self._framework.find_suite(self._sut, suite))
 
         if not coros:
-            raise KirkException(f"Can't find suites: {suites}")
+            raise KirkException(f"Can't find suites: {names}")
 
         suites_obj = await asyncio.gather(*coros, return_exceptions=True)
         for suite in suites_obj:
@@ -205,6 +206,42 @@ class Session:
             if not suite:
                 raise KirkException("Can't find suite objects")
 
+        return suites_obj
+
+    async def _filter_tests(self, pattern: str) -> list:
+        """
+        Read all tests from all the testing suites which are matching the
+        pattern string.
+        """
+        if not pattern:
+            raise ValueError("pattern string is empty")
+
+        suites = await self._framework.get_suites(self._sut)
+        if not suites:
+            return []
+
+        suites_obj = await self._get_suites_objects(suites)
+
+        suites = []
+        for patt in pattern:
+            tests = []
+
+            for suite in suites_obj:
+                for test in suite.tests:
+                    if patt in test.name:
+                        tests.append(test)
+
+            suite = Suite(patt, tests)
+            suites.append(suite)
+
+        return suites
+
+    async def _read_suites(self, suites: list, restore: str) -> list:
+        """
+        Read suites and return a list of Suite objects.
+        """
+        suites_obj = await self._get_suites_objects(suites)
+
         restored = self._read_restored_session(restore)
         if restored:
             await libkirk.events.fire("session_restore", restore)
@@ -286,10 +323,13 @@ class Session:
             await libkirk.events.fire("session_stopped")
             self._stop = False
 
+    # consider changing the arguments handling if new ones must be added
+    # pylint: disable=too-many-positional-arguments
     async def run(
             self,
             command: str = None,
             suites: list = None,
+            pattern: str = None,
             report_path: str = None,
             restore: str = None) -> None:
         """
@@ -298,6 +338,8 @@ class Session:
         :type command: str
         :param suites: list of suites to execute
         :type suites: list
+        :param pattern: string pattern to match tests
+        :types pattern: str
         :param report_path: JSON report path
         :type report_path: str
         :param restore: temporary directory generated by a previous session
@@ -317,6 +359,10 @@ class Session:
                 if command:
                     await self._exec_command(command)
 
+                if pattern:
+                    suites_obj = await self._filter_tests(pattern)
+                    await self._scheduler.schedule(suites_obj)
+
                 if suites:
                     suites_obj = await self._read_suites(suites, restore)
                     await self._scheduler.schedule(suites_obj)
diff --git a/libkirk/tests/test_session.py b/libkirk/tests/test_session.py
index 983eb93..44ae2b4 100644
--- a/libkirk/tests/test_session.py
+++ b/libkirk/tests/test_session.py
@@ -44,6 +44,19 @@ class _TestSession:
         """
         await session.run(suites=["suite01", "suite02"])
 
+    async def test_run_pattern(self, tmpdir, session):
+        """
+        Test run method when executing tests filtered out with a pattern.
+        """
+        report = str(tmpdir / "report.json")
+        await session.run(
+            pattern=["test01", "test02"],
+            report_path=report)
+
+        with open(report, "r", encoding="utf-8") as report_file:
+            report_data = json.loads(report_file.read())
+            assert len(report_data["results"]) == 8
+
     async def test_run_report(self, tmpdir, session):
         """
         Test run method when executing suites, generating a report.
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
