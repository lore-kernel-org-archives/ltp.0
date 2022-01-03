Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088B2C433EF
	for <ltp@archiver.kernel.org>; Mon,  3 Jan 2022 15:31:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D35533C9055
	for <ltp@archiver.kernel.org>; Mon,  3 Jan 2022 16:31:10 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 213823C292E
 for <ltp@lists.linux.it>; Mon,  3 Jan 2022 16:31:01 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B098960087A
 for <ltp@lists.linux.it>; Mon,  3 Jan 2022 16:31:00 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DCD99210FD;
 Mon,  3 Jan 2022 15:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641223859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=tHJyvaHiGN/HayqNWy5U8+8PMTJxOigsYkcVUmiq1Po=;
 b=ENb6f7yUtiUgUreyWcMa842P3aP8vtx3FX6CvdWChjf9Ul4WAJjv1U0bC0Pi3vrltwKCC6
 RIfRzD/v6jq3PXERcSCyiYJGIEumBRhEKdXsPaNAljzmD8cqBuEobtgqxiP8Phg0wZt1fk
 s9bPpGLdr66PnFxH7Xke1lSzZCRhTpk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641223859;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=tHJyvaHiGN/HayqNWy5U8+8PMTJxOigsYkcVUmiq1Po=;
 b=UvF/QrK09RkaBiVj5e4LvTDic4dRNBH3MGkv4soRaIOPywVmWfIrArip3C0CjFgFNujXwW
 l2HDQMXPmXMmBqDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 93AAF13AED;
 Mon,  3 Jan 2022 15:30:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MO5AIrMW02HcdAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 03 Jan 2022 15:30:59 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  3 Jan 2022 16:30:53 +0100
Message-Id: <20220103153053.20935-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] lib: Add known-fail test tag
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

to save test reviewers time.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
changes v1->v2:
* fix docparse/testinfo.pl

 doc/c-test-api.txt   |  1 +
 docparse/testinfo.pl | 11 ++++++++++-
 lib/tst_test.c       |  8 ++++++--
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index 6481531cf2..f8ee4de0d1 100644
--- a/doc/c-test-api.txt
+++ b/doc/c-test-api.txt
@@ -2259,6 +2259,7 @@ struct tst_test test = {
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "9392a27d88b9"},
 		{"linux-git", "ff002b30181d"},
+		{"known-fail", "ustat() is known to fail with EINVAL on Btrfs"},
 		{"linux-stable-git", "c4a23c852e80"},
 		{"CVE", "2020-29373"},
 		{}
diff --git a/docparse/testinfo.pl b/docparse/testinfo.pl
index 891619532f..8712a530f8 100755
--- a/docparse/testinfo.pl
+++ b/docparse/testinfo.pl
@@ -74,6 +74,10 @@ sub tag_url {
 		return eval("main::$key") . $value;
 	}
 
+	if ('known-fail') {
+		return '';
+	}
+
 	die("unknown constant '$key' for tag $tag, define it!");
 }
 
@@ -432,6 +436,7 @@ sub content_all_tests
 			}
 			my $k = @$tag[0];
 			my $v = @$tag[1];
+			my $url;
 
 			if (defined($$git_url{$k})) {
 				$commits{$k} = () unless (defined($commits{$k}));
@@ -443,7 +448,11 @@ sub content_all_tests
 				$v .= ' ("' . $commits{$k}{$v} . '")';
 			}
 
-			$v = html_a(tag_url($k, @$tag[1]), $v);
+			$url = tag_url($k, @$tag[1]);
+			if ($url) {
+				$v = html_a($url, $v);
+			}
+
 			$content .= "\n|" . reference($k) . "\n|$v\n";
 			$tmp2 = 1;
 		}
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 23fc0ebf48..901b363704 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -762,10 +762,13 @@ static void print_failure_hint(const char *tag, const char *hint,
 				hint_printed = 1;
 				fprintf(stderr, "\n");
 				print_colored("HINT: ");
-				fprintf(stderr, "You _MAY_ be %s, see:\n\n", hint);
+				fprintf(stderr, "You _MAY_ be %s:\n\n", hint);
 			}
 
-			fprintf(stderr, "%s%s\n", url, tags[i].value);
+			if (url)
+				fprintf(stderr, "%s%s\n", url, tags[i].value);
+			else
+				fprintf(stderr, "%s\n", tags[i].value);
 		}
 	}
 }
@@ -778,6 +781,7 @@ static void print_failure_hints(void)
 					   LINUX_STABLE_GIT_URL);
 	print_failure_hint("glibc-git", "missing glibc fixes", GLIBC_GIT_URL);
 	print_failure_hint("CVE", "vulnerable to CVE(s)", CVE_DB_URL);
+	print_failure_hint("known-fail", "hit by known kernel failures", NULL);
 }
 
 static void do_exit(int ret)
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
