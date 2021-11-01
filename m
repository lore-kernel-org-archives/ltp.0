Return-Path: <SRS0=CSve=PU=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727D6C4321E
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 14:59:32 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5AC761242
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 14:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C5AC761242
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D69E3C710E
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 15:54:07 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8621D3C70F5
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 15:52:52 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8761B200B8E
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 15:52:51 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2EEC61FD74
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 14:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635778371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z1pvb0o0Bg+6aVBEY1BSDedou+tECVQ8PiCRG5VHRYo=;
 b=0+RzgBqYuJv35jC0sbhgSoA7+M2xH9RsgaIDpRAqtnDXItmt/+9R+ELc6TrEcAtAkP6Kn6
 3lcJanYtwsGUTqKxn0OMXjq3iJDXDknqBUFjXThcGEnvetZLloZxXvVm9w50YW6FuDZmuo
 76cR3Tp4nseJUvvuMpsYwVIPd8FV7uc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635778371;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z1pvb0o0Bg+6aVBEY1BSDedou+tECVQ8PiCRG5VHRYo=;
 b=g6esZDXBlnrhKDCRhp3khQ2Hz3Vv1xeu9GJSNrMxSl1QqbyS5eE9aFtfF9DSnwuHa0g+ye
 v7+AI4EGwJVprbDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D4D313522
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 14:52:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id S8fJBUP/f2HGLQAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 01 Nov 2021 14:52:51 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  1 Nov 2021 15:53:41 +0100
Message-Id: <20211101145342.7166-7-chrubis@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211101145342.7166-1-chrubis@suse.cz>
References: <20211101145342.7166-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 6/7] docparse: Group data to 'testsuite' and
 'defaults'
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

Group all data belonging to testsuite info to 'testsuite' object and
move default timeout to 'defaults' object. This makes the JSON structure
a bit cleaner and easier to understand.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 docparse/parse.sh    | 16 ++++++++++------
 docparse/testinfo.pl | 16 ++++++++--------
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/docparse/parse.sh b/docparse/parse.sh
index 2ace34fa0..52d9a5cbf 100755
--- a/docparse/parse.sh
+++ b/docparse/parse.sh
@@ -15,12 +15,16 @@ if [ -d .git ]; then
 fi
 
 echo '{'
-echo ' "testsuite": "Linux Test Project",'
-echo ' "testsuite_short": "LTP",'
-echo ' "url": "https://github.com/linux-test-project/ltp/",'
-echo ' "scm_url_base": "https://github.com/linux-test-project/ltp/tree/master/",'
-echo ' "timeout": 300,'
-echo " \"version\": \"$version\","
+echo ' "testsuite": {'
+echo '  "name": "Linux Test Project",'
+echo '  "short_name": "LTP",'
+echo '  "url": "https://github.com/linux-test-project/ltp/",'
+echo '  "scm_url_base": "https://github.com/linux-test-project/ltp/tree/master/",'
+echo "  \"version\": \"$version\""
+echo ' },'
+echo ' "defaults": {'
+echo '  "timeout": 300'
+echo ' },'
 echo ' "tests": {'
 
 first=1
diff --git a/docparse/testinfo.pl b/docparse/testinfo.pl
index c11064c05..891619532 100755
--- a/docparse/testinfo.pl
+++ b/docparse/testinfo.pl
@@ -164,9 +164,9 @@ sub content_about
 	my $json = shift;
 	my $content;
 
-	$content .= print_defined("URL", $json->{'url'});
-	$content .= print_defined("Version", $json->{'version'});
-	$content .= print_defined("Default timeout", $json->{'timeout'}, "seconds");
+	$content .= print_defined("URL", $json->{'testsuite'}->{'url'});
+	$content .= print_defined("Version", $json->{'testsuite'}->{'version'});
+	$content .= print_defined("Default timeout", $json->{'defaults'}->{'timeout'}, "seconds");
 
 	return $content;
 }
@@ -360,10 +360,10 @@ sub content_all_tests
 		$content .= h3($name);
 		$content .= $letters;
 
-		if (defined($json->{'scm_url_base'}) &&
+		if (defined($json->{'testsuite'}->{'scm_url_base'}) &&
 			defined($json->{'tests'}{$name}{fname})) {
 			$content .= paragraph(html_a(tag_url("fname", $json->{'tests'}{$name}{fname},
-					$json->{'scm_url_base'}), "source"));
+					$json->{'testsuite'}->{'scm_url_base'}), "source"));
 		}
 
 		if (defined $json->{'tests'}{$name}{doc}) {
@@ -386,7 +386,7 @@ sub content_all_tests
 				$content .= paragraph("Test timeout is $json->{'tests'}{$name}{timeout} seconds");
 			}
 		} else {
-			$content .= paragraph("Test timeout defaults to $json->{'timeout'} seconds");
+			$content .= paragraph("Test timeout defaults to $json->{'defaults'}->{'timeout'} seconds");
 		}
 
 		my $tmp2 = undef;
@@ -463,7 +463,7 @@ my $json = decode_json(load_json($ARGV[0]));
 my $config = [
     {
 		file => "about.txt",
-		title => h2("About $json->{'testsuite'}"),
+		title => h2("About $json->{'testsuite'}->{'name'}"),
 		content => \&content_about,
     },
     {
@@ -495,7 +495,7 @@ EOL
 	for my $c (@{$config}) {
 		$content .= "include::$c->{'file'}\[\]\n";
 	}
-	print_asciidoc_page($fh, $json, h1($json->{'testsuite_short'} . " test catalog"), $content);
+	print_asciidoc_page($fh, $json, h1($json->{'testsuite'}->{'short_name'} . " test catalog"), $content);
 }
 
 for my $c (@{$config}) {
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
