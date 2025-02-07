Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12ECCC02194
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 10:58:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 978903C937D
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 11:58:06 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 298B53C936C
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 11:56:06 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D2EB01BC24EC
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 11:56:04 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5E1851F449;
 Fri,  7 Feb 2025 10:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738925764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7WpaRPOiYIvx0+m1sWA/x6fY7cvFbKxqNw5eBqBYeFA=;
 b=VIxo3vqpQCnd8ISuWD/oyeitCYPgaVuvGWAk0kWaT+/j1AKaNtmbk2cZVaPmPjtM33YNZY
 aQApfevR2ZWKdIj1nySthxyjPnqiyWjsz0FAFkK3sR90EVGqJLE1LoIG5rrvXRMLAmljot
 Vax2nR7xPGAIbWXYb8W5E1O9cn1Tlf4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738925764;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7WpaRPOiYIvx0+m1sWA/x6fY7cvFbKxqNw5eBqBYeFA=;
 b=T0edP+eTDo/s5cGGgbv1oXmFg1G5PTBQHxu5KzBseYoIxduxPI+KkiOIuVXX9R22ZW0Uvb
 jVUNuEHxFuyCQPBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738925764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7WpaRPOiYIvx0+m1sWA/x6fY7cvFbKxqNw5eBqBYeFA=;
 b=VIxo3vqpQCnd8ISuWD/oyeitCYPgaVuvGWAk0kWaT+/j1AKaNtmbk2cZVaPmPjtM33YNZY
 aQApfevR2ZWKdIj1nySthxyjPnqiyWjsz0FAFkK3sR90EVGqJLE1LoIG5rrvXRMLAmljot
 Vax2nR7xPGAIbWXYb8W5E1O9cn1Tlf4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738925764;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7WpaRPOiYIvx0+m1sWA/x6fY7cvFbKxqNw5eBqBYeFA=;
 b=T0edP+eTDo/s5cGGgbv1oXmFg1G5PTBQHxu5KzBseYoIxduxPI+KkiOIuVXX9R22ZW0Uvb
 jVUNuEHxFuyCQPBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1FB1213AC0;
 Fri,  7 Feb 2025 10:56:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gM1WBsTmpWddeQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 07 Feb 2025 10:56:04 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  7 Feb 2025 11:55:51 +0100
Message-ID: <20250207105551.1736356-7-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250207105551.1736356-1-pvorel@suse.cz>
References: <20250207105551.1736356-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 6/6] docparse: Remove
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

Test catalog is generating via sphinx (see 1bf344a3db), unused code for
generating test catalog documentation ("docparse") is removed.

Remove whole docparse/ directory (docparse/testinfo.pl + docs), m4
custom scripts and vendored m4/ax_prog_perl_modules.m4, update
configure.ac and metadata/Makefile.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 configure.ac               |  32 ---
 docparse/.gitignore        |   5 -
 docparse/Makefile          |  69 -----
 docparse/testinfo.pl       | 526 -------------------------------------
 m4/ax_prog_perl_modules.m4 |  77 ------
 m4/ltp-docparse.m4         | 118 ---------
 metadata/Makefile          |   9 -
 7 files changed, 836 deletions(-)
 delete mode 100644 docparse/.gitignore
 delete mode 100644 docparse/Makefile
 delete mode 100755 docparse/testinfo.pl
 delete mode 100644 m4/ax_prog_perl_modules.m4
 delete mode 100644 m4/ltp-docparse.m4

diff --git a/configure.ac b/configure.ac
index 672880bfc7..344b2ae2c8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -266,33 +266,6 @@ else
     AC_SUBST([WITH_BASH],["no"])
 fi
 
-# metadata
-AC_ARG_ENABLE([metadata],
-  [AS_HELP_STRING([--disable-metadata],
-	[Disable metadata generation (both HTML and PDF, default no)])],
-  [], [enable_metadata=yes]
-)
-AC_ARG_ENABLE([metadata_html],
-  [AS_HELP_STRING([--disable-metadata-html],
-	[Disable metadata HTML generation (default no)])],
-  [], [enable_metadata_html=yes]
-)
-
-AC_ARG_ENABLE([metadata_pdf],
-  [AS_HELP_STRING([--enable-metadata-pdf],
-	[Enable metadata PDF generation (default no)])],
-  [], [enable_metadata_pdf=no]
-)
-
-AC_ARG_WITH([metadata_generator],
-  [AS_HELP_STRING([--with-metadata-generator=asciidoc|asciidoctor],
-	[Specify metadata generator to use (default autodetect)])],
-  [with_metadata_generator=$withval],
-  [with_metadata_generator=detect]
-)
-
-LTP_DOCPARSE
-
 # Expect
 AC_ARG_WITH([expect],
   [AS_HELP_STRING([--with-expect],
@@ -467,11 +440,6 @@ libmnl: ${have_libmnl:-yes}
 libnuma: ${have_libnuma:-no} (headers: ${have_numa_headers:-yes}, v2 headers: ${have_numa_headers_v2:-no})
 libtirpc: ${have_libtirpc:-no}
 glibc SUN-RPC: ${have_rpc_glibc:-no}
-
-METADATA
-metadata generator: $with_metadata_generator
-HTML metadata: $with_metadata_html
-PDF metadata: $with_metadata_pdf
 EOF
 
 if test "x$with_realtime_testsuite" = xyes; then
diff --git a/docparse/.gitignore b/docparse/.gitignore
deleted file mode 100644
index d786a4762b..0000000000
--- a/docparse/.gitignore
+++ /dev/null
@@ -1,5 +0,0 @@
-/*.txt
-/docbook-xsl.css
-/metadata.html
-/metadata.pdf
-/metadata.chunked/
diff --git a/docparse/Makefile b/docparse/Makefile
deleted file mode 100644
index 20851fba63..0000000000
--- a/docparse/Makefile
+++ /dev/null
@@ -1,69 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2019 Cyril Hrubis <chrubis@suse.cz>
-# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
-
-top_srcdir		?= ..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-include $(top_srcdir)/include/mk/functions.mk
-
-ifeq ($(METADATA_GENERATOR),asciidoctor)
-METADATA_GENERATOR_CMD := asciidoctor
-METADATA_GENERATOR_PARAMS := -d book metadata.txt
-METADATA_GENERATOR_PARAMS_HTML := -b xhtml
-METADATA_GENERATOR_PARAMS_PDF := -b pdf -r asciidoctor-pdf
-else ifeq ($(METADATA_GENERATOR),asciidoc)
-METADATA_GENERATOR_CMD := a2x
-METADATA_GENERATOR_PARAMS := --xsltproc-opts "--stringparam toc.section.depth 1" -d book -L  --resource="$(PWD)" metadata.txt
-METADATA_GENERATOR_PARAMS_HTML := -f xhtml
-METADATA_GENERATOR_PARAMS_PDF := -f pdf
-METADATA_GENERATOR_PARAMS_HTML_CHUNKED := -f chunked
-else ifeq ($(METADATA_GENERATOR),)
-$(error 'METADATA_GENERATOR' not configured, run ./configure in the root directory)
-else
-$(error '$(METADATA_GENERATOR)' not supported, only asciidoctor and asciidoc are supported)
-endif
-
-ifdef VERBOSE
-METADATA_GENERATOR_PARAMS += -v
-endif
-
-CLEAN_TARGETS		:= *.css *.js *.txt
-
-ifeq ($(WITH_METADATA_HTML),yes)
-MAKE_TARGETS		+= metadata.html
-ifneq ($(METADATA_GENERATOR_PARAMS_HTML_CHUNKED),)
-MAKE_TARGETS		+= metadata.chunked
-endif
-endif
-
-ifeq ($(WITH_METADATA_PDF),yes)
-MAKE_TARGETS		+= metadata.pdf
-endif
-
-INSTALL_DIR = metadata
-INSTALL_TARGETS = *.css *.js
-
-ifndef METADATA_GENERATOR
-METADATA_GENERATOR := asciidoctor
-endif
-
-txt: ${abs_top_builddir}/metadata/ltp.json
-	$(abs_srcdir)/testinfo.pl $<
-
-ifeq ($(WITH_METADATA_HTML),yes)
-metadata.html: txt
-	$(METADATA_GENERATOR_CMD) $(METADATA_GENERATOR_PARAMS) $(METADATA_GENERATOR_PARAMS_HTML)
-
-ifneq ($(METADATA_GENERATOR_PARAMS_HTML_CHUNKED),)
-metadata.chunked: txt
-	$(METADATA_GENERATOR_CMD) $(METADATA_GENERATOR_PARAMS) $(METADATA_GENERATOR_PARAMS_HTML_CHUNKED)
-endif
-endif
-
-ifeq ($(WITH_METADATA_PDF),yes)
-metadata.pdf: txt
-	$(METADATA_GENERATOR_CMD) $(METADATA_GENERATOR_PARAMS) $(METADATA_GENERATOR_PARAMS_PDF)
-endif
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/docparse/testinfo.pl b/docparse/testinfo.pl
deleted file mode 100755
index 487b7d5f22..0000000000
--- a/docparse/testinfo.pl
+++ /dev/null
@@ -1,526 +0,0 @@
-#!/usr/bin/perl
-# SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2019 Cyril Hrubis <chrubis@suse.cz>
-# Copyright (c) 2020-2021 Petr Vorel <pvorel@suse.cz>
-
-use strict;
-use warnings;
-
-use JSON qw(decode_json);
-use Cwd qw(abs_path);
-use File::Basename qw(dirname);
-
-use constant OUTDIR => dirname(abs_path($0));
-
-# tags which expect git tree, also need constant for URL
-our @TAGS_GIT = ("linux-git", "linux-stable-git", "glibc-git", "musl-git");
-
-# tags should map these in lib/tst_test.c
-use constant LINUX_GIT_URL => "https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=";
-use constant LINUX_STABLE_GIT_URL => "https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=";
-use constant GLIBC_GIT_URL => "https://sourceware.org/git/?p=glibc.git;a=commit;h=";
-use constant MUSL_GIT_URL => "https://git.musl-libc.org/cgit/musl/commit/src/linux/clone.c?id=";
-use constant CVE_DB_URL => "https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-";
-
-sub load_json
-{
-	my ($fname, $mode) = @_;
-	local $/;
-
-	open(my $fh, '<', $fname) or die("Can't open $fname $!");
-
-	return <$fh>;
-}
-
-sub log_info
-{
-	my $msg = shift;
-	print STDERR "INFO: $msg\n";
-}
-
-sub log_warn
-{
-	my $msg = shift;
-	print STDERR "WARN: $msg\n";
-}
-
-sub print_asciidoc_page
-{
-	my ($fh, $json, $title, $content) = @_;
-
-	print $fh <<EOL;
-// -*- mode:doc; -*-
-// vim: set syntax=asciidoc:
-
-$title
-
-$content
-EOL
-}
-
-sub tag_url {
-	my ($tag, $value, $scm_url_base) = @_;
-
-	if ($tag eq "fname") {
-		return $scm_url_base . $value;
-	}
-
-	if ($tag eq "CVE") {
-		return CVE_DB_URL . $value;
-	}
-
-	# *_GIT_URL
-	my $key = tag2env($tag) . "_URL";
-	if (defined($constant::declared{"main::$key"})) {
-		return eval("main::$key") . $value;
-	}
-
-	if ('known-fail') {
-		return '';
-	}
-
-	die("unknown constant '$key' for tag $tag, define it!");
-}
-
-sub bold
-{
-	return "*$_[0]*";
-}
-
-sub code
-{
-	return "+$_[0]+";
-}
-
-sub hr
-{
-	return "\n\n'''\n\n";
-}
-
-sub html_a
-{
-	my ($url, $text) = @_;
-
-	# escape: ] |
-	$text =~ s/([]|])/\\$1/g;
-
-	return "$url\[$text\]";
-}
-
-sub h1
-{
-	return "== $_[0]\n";
-}
-
-sub h2
-{
-	return "=== $_[0]\n";
-}
-
-sub h3
-{
-	return "==== $_[0]\n";
-}
-
-sub label
-{
-	return "[[$_[0]]]\n";
-}
-
-sub paragraph
-{
-	return "$_[0]\n\n";
-}
-
-sub reference
-{
-	my ($link, %args) = @_;
-
-	$args{text} //= $link;
-	$args{delimiter} //= "";
-
-	return "xref:$link\[$args{text}\]$args{delimiter}\n";
-}
-
-sub table
-{
-	return "|===\n";
-}
-
-sub table_escape
-{
-	my $out = $_[0];
-
-	$out =~ s/\|/\\|/g;
-	return $out;
-}
-
-sub print_defined
-{
-	my ($key, $val, $val2) = @_;
-
-	if (defined($val)) {
-		return paragraph(bold($key) . ": " . $val . (defined($val2) ? " $val2" : ""));
-	}
-}
-
-sub content_about
-{
-	my $json = shift;
-	my $content;
-
-	$content .= print_defined("URL", $json->{'testsuite'}->{'url'});
-	$content .= print_defined("Version", $json->{'testsuite'}->{'version'});
-	$content .= print_defined("Default timeout", $json->{'defaults'}->{'timeout'}, "seconds");
-
-	return $content;
-}
-
-sub uniq {
-	my %seen;
-	grep !$seen{$_}++, @_;
-}
-
-sub get_test_names
-{
-	my @names = @{$_[0]};
-	my ($letter, $prev_letter);
-	my $content;
-
-	for my $name (sort @names) {
-		$letter = substr($name, 0, 1);
-		if (defined($prev_letter) && $letter ne $prev_letter) {
-			$content .= "\n";
-		}
-
-		$content .= reference($name, delimiter => " ");
-		$prev_letter = $letter;
-	}
-	$content .= "\n";
-
-	return $content;
-}
-
-sub get_test_letters
-{
-	my @names = @{$_[0]};
-	my $letter;
-	my $prev_letter = "";
-	my $content;
-
-	for (@names) {
-		$_ = substr($_, 0, 1);
-	}
-	@names = uniq(@names);
-
-	for my $letter (@names) {
-		$content .= reference($letter);
-	}
-	$content .= "\n";
-
-	return $content;
-}
-
-sub tag2title
-{
-	my $tag = shift;
-	return code(".$tag");
-}
-
-sub get_filters
-{
-	my $json = shift;
-	my %data;
-
-	while (my ($k, $v) = each %{$json->{'tests'}}) {
-		for my $j (keys %{$v}) {
-			next if ($j eq 'fname' || $j eq 'doc');
-			$data{$j} = () unless (defined($data{$j}));
-
-			if ($j eq 'tags') {
-				for my $tags (@{$v}{'tags'}) {
-					for my $tag (@$tags) {
-						my $k2 = $$tag[0];
-						my $v2 = $$tag[1];
-						$data{$j}{$k2} = () unless (defined($data{$j}{$k2}));
-						push @{$data{$j}{$k2}}, $k unless grep{$_ eq $k} @{$data{$j}{$k2}};
-					}
-				}
-			} else {
-				push @{$data{$j}}, $k unless grep{$_ eq $k} @{$data{$j}};
-			}
-		}
-	}
-	return \%data;
-}
-
-sub content_filter
-{
-	my $k = $_[0];
-	my $title = $_[1];
-	my $desc = $_[2];
-	my $h = $_[3];
-	my ($letter, $prev_letter, $content);
-
-	$content = label($k);
-	$content .= $title;
-	$content .= paragraph("Tests containing $desc flag.");
-
-	$content .= get_test_names(\@{$h});
-
-	return $content;
-}
-
-sub content_filters
-{
-	my $json = shift;
-	my $data = get_filters($json);
-	my %h = %$data;
-	my $content;
-
-	for my $k (sort keys %$data) {
-		my $title = tag2title($k);
-		if (ref($h{$k}) eq 'HASH') {
-			$content .= label($k);
-			$content .= h2($title);
-			for my $k2 (sort keys %{$h{$k}}) {
-				my $title2 = code($k2);
-				$content .= content_filter($k2, h3($title2), "$title $title2", $h{$k}{$k2});
-			}
-		} else {
-			$content .= content_filter($k, h2($title), $title, \@{$h{$k}});
-		}
-	}
-
-	return $content;
-}
-
-sub tag2env
-{
-	my $tag = shift;
-	$tag =~ s/-/_/g;
-	return uc($tag);
-}
-
-sub detect_git
-{
-	my %data;
-
-	for my $tag (@TAGS_GIT) {
-		my $env = tag2env($tag);
-
-		unless (defined $ENV{$env} && $ENV{$env}) {
-			log_warn("git repository $tag not defined. Define it in \$$env");
-			next;
-		}
-
-		unless (-d $ENV{$env}) {
-			log_warn("\$$env does not exit ('$ENV{$env}')");
-			next;
-		}
-
-		if (system("which git >/dev/null")) {
-			log_warn("git not in \$PATH ('$ENV{'PATH'}')");
-			next;
-		}
-
-		chdir($ENV{$env});
-		if (!system("git log -1 > /dev/null")) {
-			log_info("using '$ENV{$env}' as $env repository");
-			$data{$tag} = $ENV{$env};
-		} else {
-			log_warn("git failed, git not installed or \$$env is not a git repository? ('$ENV{$env}')");
-		}
-		chdir(OUTDIR);
-	}
-
-	return \%data;
-}
-
-sub content_all_tests
-{
-	my $json = shift;
-	my @names = sort keys %{$json->{'tests'}};
-	my $letters = paragraph(get_test_letters(\@names));
-	my $git_url = detect_git();
-	my $tmp = undef;
-	my $printed = "";
-	my $content;
-
-	$content .= paragraph("Total $#names tests.");
-	$content .= $letters;
-	$content .= get_test_names(\@names);
-
-	for my $name (@names) {
-		my $letter = substr($name, 0, 1);
-
-		if ($printed ne $letter) {
-			$content .= label($letter);
-			$content .= h2($letter);
-			$printed = $letter;
-		}
-
-		$content .= hr() if (defined($tmp));
-		$content .= label($name);
-		$content .= h3($name);
-		$content .= $letters;
-
-		if (defined($json->{'testsuite'}->{'scm_url_base'}) &&
-			defined($json->{'tests'}{$name}{fname})) {
-			$content .= paragraph(html_a(tag_url("fname", $json->{'tests'}{$name}{fname},
-					$json->{'testsuite'}->{'scm_url_base'}), "source"));
-		}
-
-		if (defined $json->{'tests'}{$name}{doc}) {
-			for my $doc (@{$json->{'tests'}{$name}{doc}}) {
-
-				# fix formatting for asciidoc [DOCUMENTATION] => *Documentation*
-				if ($doc =~ s/^\[(.*)\]$/$1/) {
-					$doc = paragraph(bold(ucfirst(lc($doc))));
-				}
-
-				$content .= "$doc\n";
-			}
-			$content .= "\n";
-		}
-
-		if ($json->{'tests'}{$name}{timeout}) {
-			if ($json->{'tests'}{$name}{timeout} eq -1) {
-				$content .= paragraph("Test timeout is disabled");
-			} else {
-				$content .= paragraph("Test timeout is $json->{'tests'}{$name}{timeout} seconds");
-			}
-		} else {
-			$content .= paragraph("Test timeout defaults to $json->{'defaults'}->{'timeout'} seconds");
-		}
-
-		my $tmp2 = undef;
-		for my $k (sort keys %{$json->{'tests'}{$name}}) {
-			my $v = $json->{'tests'}{$name}{$k};
-			next if ($k eq "tags" || $k eq "fname" || $k eq "doc");
-			if (!defined($tmp2)) {
-				$content .= table . "|Key|Value\n\n"
-			}
-
-			$content .= "|" . reference($k, text => tag2title($k)) . "\n|";
-
-			if (ref($v) eq 'ARRAY') {
-				# two dimensional array
-				if (ref(@$v[0]) eq 'ARRAY') {
-					for my $v2 (@$v) {
-						# convert NULL to "NULL" string to be printed
-						for my $v3 (@$v2) {
-							$v3 = "NULL" if (!defined $v3);
-						}
-						$content .= paragraph(table_escape(join(', ', @$v2)));
-					}
-				} else {
-					# one dimensional array
-					$content .= table_escape(join(', ', @$v));
-				}
-			} else {
-				# plain content
-				$content .= table_escape($v);
-			}
-
-			$content .= "\n";
-
-			$tmp2 = 1;
-		}
-		if (defined($tmp2)) {
-			$content .= table . "\n";
-		}
-
-		$tmp2 = undef;
-		my %commits;
-		my @sorted_tags = sort { $a->[0] cmp $b->[0] } @{$json->{'tests'}{$name}{tags} // []};
-
-		for my $tag (@sorted_tags) {
-			if (!defined($tmp2)) {
-				$content .= table . "|Tag|Info\n"
-			}
-			my $k = @$tag[0];
-			my $v = @$tag[1];
-			my $url;
-
-			if (defined($$git_url{$k})) {
-				$commits{$k} = () unless (defined($commits{$k}));
-				unless (defined($commits{$k}{$v})) {
-					chdir($$git_url{$k});
-					$commits{$k}{$v} = `git log --pretty=format:'%s' -1 $v`;
-					chdir(OUTDIR);
-				}
-				$v .= ' ("' . $commits{$k}{$v} . '")';
-			}
-
-			$url = tag_url($k, @$tag[1]);
-			if ($url) {
-				$v = html_a($url, $v);
-			}
-
-			# tag value value can be split into more lines if too long
-			# i.e. URL in known-fail
-			for (@$tag[2 .. $#$tag]) {
-				$v .= " $_";
-			}
-
-			$content .= "\n|" . reference($k) . "\n|$v\n";
-			$tmp2 = 1;
-		}
-		if (defined($tmp2)) {
-			$content .= table . "\n";
-		}
-
-		$tmp = 1;
-	}
-
-	return $content;
-}
-
-
-my $json = decode_json(load_json($ARGV[0]));
-
-my $config = [
-    {
-		file => "about.txt",
-		title => h2("About $json->{'testsuite'}->{'name'}"),
-		content => \&content_about,
-    },
-    {
-		file => "filters.txt",
-		title => h1("Test filtered by used flags"),
-		content => \&content_filters,
-    },
-    {
-		file => "all-tests.txt",
-		title => h1("All tests"),
-		content => \&content_all_tests,
-    },
-];
-
-sub print_asciidoc_main
-{
-	my $config = shift;
-	my $file = "metadata.txt";
-	my $content;
-
-	open(my $fh, '>', $file) or die("Can't open $file $!");
-
-	$content = <<EOL;
-:doctype: inline
-:sectanchors:
-:toc:
-
-EOL
-	for my $c (@{$config}) {
-		$content .= "include::$c->{'file'}\[\]\n";
-	}
-	print_asciidoc_page($fh, $json, h1($json->{'testsuite'}->{'short_name'} . " test catalog"), $content);
-}
-
-for my $c (@{$config}) {
-	open(my $fh, '>', $c->{'file'}) or die("Can't open $c->{'file'} $!");
-	print_asciidoc_page($fh, $json, $c->{'title'}, $c->{'content'}->($json));
-}
-
-print_asciidoc_main($config);
diff --git a/m4/ax_prog_perl_modules.m4 b/m4/ax_prog_perl_modules.m4
deleted file mode 100644
index 70b3230ebd..0000000000
--- a/m4/ax_prog_perl_modules.m4
+++ /dev/null
@@ -1,77 +0,0 @@
-# ===========================================================================
-#   https://www.gnu.org/software/autoconf-archive/ax_prog_perl_modules.html
-# ===========================================================================
-#
-# SYNOPSIS
-#
-#   AX_PROG_PERL_MODULES([MODULES], [ACTION-IF-TRUE], [ACTION-IF-FALSE])
-#
-# DESCRIPTION
-#
-#   Checks to see if the given perl modules are available. If true the shell
-#   commands in ACTION-IF-TRUE are executed. If not the shell commands in
-#   ACTION-IF-FALSE are run. Note if $PERL is not set (for example by
-#   calling AC_CHECK_PROG, or AC_PATH_PROG), AC_CHECK_PROG(PERL, perl, perl)
-#   will be run.
-#
-#   MODULES is a space separated list of module names. To check for a
-#   minimum version of a module, append the version number to the module
-#   name, separated by an equals sign.
-#
-#   Example:
-#
-#     AX_PROG_PERL_MODULES( Text::Wrap Net::LDAP=1.0.3, ,
-#                           AC_MSG_WARN(Need some Perl modules)
-#
-# LICENSE
-#
-#   Copyright (c) 2009 Dean Povey <povey@wedgetail.com>
-#
-#   Copying and distribution of this file, with or without modification, are
-#   permitted in any medium without royalty provided the copyright notice
-#   and this notice are preserved. This file is offered as-is, without any
-#   warranty.
-
-#serial 8
-
-AU_ALIAS([AC_PROG_PERL_MODULES], [AX_PROG_PERL_MODULES])
-AC_DEFUN([AX_PROG_PERL_MODULES],[dnl
-
-m4_define([ax_perl_modules])
-m4_foreach([ax_perl_module], m4_split(m4_normalize([$1])),
-	  [
-	   m4_append([ax_perl_modules],
-		     [']m4_bpatsubst(ax_perl_module,=,[ ])[' ])
-          ])
-
-# Make sure we have perl
-if test -z "$PERL"; then
-AC_CHECK_PROG(PERL,perl,perl)
-fi
-
-if test "x$PERL" != x; then
-  ax_perl_modules_failed=0
-  for ax_perl_module in ax_perl_modules; do
-    AC_MSG_CHECKING(for perl module $ax_perl_module)
-
-    # Would be nice to log result here, but can't rely on autoconf internals
-    $PERL -e "use $ax_perl_module; exit" > /dev/null 2>&1
-    if test $? -ne 0; then
-      AC_MSG_RESULT(no);
-      ax_perl_modules_failed=1
-   else
-      AC_MSG_RESULT(ok);
-    fi
-  done
-
-  # Run optional shell commands
-  if test "$ax_perl_modules_failed" = 0; then
-    :
-    $2
-  else
-    :
-    $3
-  fi
-else
-  AC_MSG_WARN(could not find perl)
-fi])dnl
diff --git a/m4/ltp-docparse.m4 b/m4/ltp-docparse.m4
deleted file mode 100644
index 9514e5e1e9..0000000000
--- a/m4/ltp-docparse.m4
+++ /dev/null
@@ -1,118 +0,0 @@
-dnl SPDX-License-Identifier: GPL-2.0-or-later
-dnl Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
-
-AC_DEFUN([LTP_CHECK_METADATA_GENERATOR_ASCIIDOCTOR], [
-	AC_MSG_NOTICE(checking asciidoctor as metadata generator)
-	AC_PATH_TOOL(asciidoctor, "asciidoctor")
-	metadata_generator_html=$asciidoctor
-	# pdf requires both asciidoctor and asciidoctor-pdf
-	if test "x$metadata_generator_html" != x; then
-		AC_PATH_TOOL(asciidoctor_pdf, "asciidoctor-pdf")
-		metadata_generator_pdf=$asciidoctor_pdf
-	fi
-])
-
-AC_DEFUN([LTP_CHECK_METADATA_GENERATOR_ASCIIDOC], [
-	AC_MSG_NOTICE(checking asciidoc as metadata generator)
-	AC_PATH_TOOL(a2x, "a2x")
-	if test "x$a2x" != x; then
-		version="`$a2x --version | cut -d ' ' -f2 `"
-		AX_COMPARE_VERSION([$version], lt, 9, [
-		AC_MSG_WARN([a2x unsupported version: $version. Use a2x >= 9])
-		a2x=
-		])
-	fi
-	metadata_generator_html=$a2x
-	# pdf requires both asciidoc and dblatex
-	if test "x$metadata_generator_html" != x; then
-		AC_PATH_TOOL(dblatex, "dblatex")
-		metadata_generator_pdf=$dblatex
-	fi
-])
-
-AC_DEFUN([LTP_DOCPARSE], [
-with_metadata=no
-with_metadata_html=no
-with_metadata_pdf=no
-
-if test "x$enable_metadata" != xyes; then
-	enable_metadata_html=no
-	enable_metadata_pdf=no
-	with_metadata_generator=none
-fi
-
-if test "x$enable_metadata_html" = xyes -o "x$enable_metadata_pdf" = xyes; then
-	AX_PROG_PERL_MODULES(Cwd File::Basename JSON LWP::Simple)
-fi
-
-if test "x$ax_perl_modules_failed" = x0; then
-	if test "x$with_metadata_generator" = xasciidoctor -o "x$with_metadata_generator" = xdetect; then
-		LTP_CHECK_METADATA_GENERATOR_ASCIIDOCTOR
-	elif test "x$with_metadata_generator" = xasciidoc; then
-		LTP_CHECK_METADATA_GENERATOR_ASCIIDOC
-	else
-		AC_MSG_ERROR([invalid metadata generator '$with_metadata_generator', use --with-metadata-generator=asciidoc|asciidoctor])
-	fi
-
-	# autodetection: check also Asciidoc
-	if test "x$with_metadata_generator" = xdetect; then
-		with_metadata_generator='asciidoctor'
-		# problems with Asciidoctor: (html enabled && not found) || (pdf enabled && not found) => try Asciidoc
-		if test "x$enable_metadata_html" = xyes -a "x$metadata_generator_html" = x ||
-			test "x$enable_metadata_pdf" = xyes -a "x$metadata_generator_pdf" = x; then
-			backup_html="$metadata_generator_html"
-			backup_pdf="$metadata_generator_pdf"
-			AC_MSG_NOTICE(missing some dependencies for Asciidoctor => trying Asciidoc)
-			with_metadata_generator='asciidoc'
-			LTP_CHECK_METADATA_GENERATOR_ASCIIDOC
-			# prefer Asciidoctor if it's not worse than Asciidoc
-			# (html not enabled || asciidoctor html found || asciidoc html not found) && (pdf ...)
-			if test "x$enable_metadata_html" != xyes -o "x$backup_html" != x -o "x$metadata_generator_html" = x &&
-				test "x$enable_metadata_pdf" != xyes -o "x$backup_pdf" != x -o "x$metadata_generator_pdf" = x; then
-				with_metadata_generator='asciidoctor'
-				metadata_generator_html="$backup_html"
-				metadata_generator_pdf="$backup_pdf"
-			fi
-		fi
-		if test "x$metadata_generator_html" != x -o "x$metadata_generator_pdf" != x; then
-			AC_MSG_NOTICE(choosing $with_metadata_generator for metadata generation)
-		fi
-	fi
-
-	if test "x$enable_metadata_html" = xno; then
-		AC_MSG_NOTICE(HTML metadata generation disabled)
-	elif test "x$metadata_generator_html" != x; then
-		with_metadata_html=yes
-	fi
-
-	if test "x$enable_metadata_pdf" = xno; then
-		AC_MSG_NOTICE(PDF metadata generation disabled)
-	elif test "x$metadata_generator_pdf" != x; then
-		with_metadata_pdf=yes
-	fi
-fi
-
-reason="metadata generation skipped due missing suitable generator"
-hint="specify correct generator with --with-metadata-generator=asciidoc|asciidoctor or use --disable-metadata|--disable-metadata-html|--disable-metadata-pdf"
-
-if test -z "$ax_perl_modules_failed"; then
-	AC_MSG_NOTICE(metadata generation disabled)
-elif test "x$ax_perl_modules_failed" = x1; then
-	AC_MSG_WARN(metadata generation skipped due missing required Perl modules)
-elif test "x$with_metadata_html" = xno -a "x$with_metadata_pdf" = xno; then
-	AC_MSG_WARN([$reason, $hint])
-else
-	with_metadata=yes
-	AC_SUBST(METADATA_GENERATOR, $with_metadata_generator)
-	if test "x$with_metadata_html" = xno -a "x$enable_metadata_html" = xyes; then
-		AC_MSG_WARN([HTML $reason, $hint])
-	fi
-	if test "x$with_metadata_pdf" = xno -a "x$enable_metadata_pdf" = xyes; then
-		AC_MSG_WARN([PDF $reason, $hint])
-	fi
-fi
-
-AC_SUBST(WITH_METADATA, $with_metadata)
-AC_SUBST(WITH_METADATA_HTML, $with_metadata_html)
-AC_SUBST(WITH_METADATA_PDF, $with_metadata_pdf)
-])
diff --git a/metadata/Makefile b/metadata/Makefile
index 522af42705..b4f9f89384 100644
--- a/metadata/Makefile
+++ b/metadata/Makefile
@@ -14,15 +14,6 @@ INSTALL_DIR		= metadata
 
 ltp.json: metaparse
 	$(abs_srcdir)/parse.sh > ltp.json
-ifeq ($(WITH_METADATA),yes)
-	mkdir -p $(abs_top_builddir)/docparse
-	$(MAKE) -C $(abs_top_builddir)/docparse/ -f $(abs_top_srcdir)/docparse/Makefile
-endif
-
-ifeq ($(WITH_METADATA),yes)
-install:
-	$(MAKE) -C $(abs_top_builddir)/docparse/ -f $(abs_top_srcdir)/docparse/Makefile install
-endif
 
 test:
 	$(MAKE) -C $(abs_srcdir)/tests/ test
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
