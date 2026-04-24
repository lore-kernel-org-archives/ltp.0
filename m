Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E4FFE51F6
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 09:40:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4A8613E2D98
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 11:40:16 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C3EEE3E2D71
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 11:39:34 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F3DD31400DF4
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 11:39:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 16DF56A8A2;
 Fri, 24 Apr 2026 09:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777023572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zIglvZ1NvYAwgnwAw8J+b2UIYrhdI9V8xaKfwoE5Elw=;
 b=jJXqPZfdsJ3nKYAVMBuUz3Nz6gjf+XJZXq2EyFmrC/M/BaaPwnr/4bfNUYBZh04fBWlLG5
 FyDLVqtKsail/G/wUKghUzihXYuwpmX4HLrAP9h1zMWHDLpXYvZZvCgvDqqi5qDuzgpywl
 D6ybrlDIlPztHMzvM8VqvhS/o2/P+vY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777023572;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zIglvZ1NvYAwgnwAw8J+b2UIYrhdI9V8xaKfwoE5Elw=;
 b=+4+o3tiRRk5yxd+sTKQMflE89SSznjWsvrC2bMXhKxxbDNAvzcdNAy0R7XQVsRy7NZ2w5q
 xPVkUXbfyKE78HBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zbTzJcS1;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xy0DEudQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777023571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zIglvZ1NvYAwgnwAw8J+b2UIYrhdI9V8xaKfwoE5Elw=;
 b=zbTzJcS1Ae/AaVxXetlxNdjePvjL5Yuc4ELAarNF+8pp4nfIjT0apUB6JADWHFvuqxfDvz
 9PRDo17VYI9dBcYJ/hz/jBD8MlNjOwJzamUO+cQZr6rA1EXnCexEnvgUs+YsSphFjdImtY
 1rlY/8WQrcRQ9ZW2Pm9iZubkdnhhC6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777023571;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zIglvZ1NvYAwgnwAw8J+b2UIYrhdI9V8xaKfwoE5Elw=;
 b=xy0DEudQs2AL9SLoke22UnoUYMwqW8z5JCjia+8rCxnh2XpmPKgcfoRFfNK1cXt03B5jp+
 MG9YiQ+5Fp+IxcAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E0F20593A7;
 Fri, 24 Apr 2026 09:39:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AG56NVI662l0TQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 24 Apr 2026 09:39:30 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 24 Apr 2026 11:39:17 +0200
Message-ID: <20260424093919.500059-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424093919.500059-1-pvorel@suse.cz>
References: <20260424093919.500059-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:email,checkpatch.pl:url,include:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 16DF56A8A2
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/4] checkpatch: Update to use new features
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

Update checkpatch.pl to use new features:

596d45eb6a409 ("checkpatch: add option to not force /* */ for SPDX")
50fa4906c7465 ("checkpatch: allow passing config directory")

(Use latest next tree next-20260423 with applied 2 patches from Andrew
Morton's mm tree, which will be part of v7.1.)

https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/log/?h=mm-everything

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
NOTE: git hashes will probably change, I'll wait till it gets into
mainline (or at least into next tree) and update hashes before merge.

Kind regards,
Petr

 scripts/checkpatch.pl | 133 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 111 insertions(+), 22 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index c70fcfbb3c..0d18771f1b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -57,8 +57,12 @@ my %ignore_type = ();
 my @ignore = ();
 my $help = 0;
 my $configuration_file = ".checkpatch.conf";
+my $def_configuration_dirs_help = '.:$HOME:.scripts';
+(my $def_configuration_dirs = $def_configuration_dirs_help) =~ s/\$(\w+)/$ENV{$1}/g;
+my $env_config_dir = 'CHECKPATCH_CONFIG_DIR';
 my $max_line_length = 100;
 my $ignore_perl_version = 0;
+my $spdx_cxx_comments = 0;
 my $minimum_perl_version = 5.10.0;
 my $min_conf_desc_length = 4;
 my $spelling_file = "$D/spelling.txt";
@@ -135,6 +139,10 @@ Options:
                              file.  It's your fault if there's no backup or git
   --ignore-perl-version      override checking of perl version.  expect
                              runtime errors.
+  --spdx-cxx-comments        don't force C comments (/* */) for SPDX license
+                             (required by old toolchains), allow also C++
+                             comments (//).
+                             NOTE: it should *not* be used for Linux mainline.
   --codespell                Use the codespell dictionary for spelling/typos
                              (default:$codespellfile)
   --codespellfile            Use this codespell dictionary
@@ -146,6 +154,11 @@ Options:
   -h, --help, --version      display this help and exit
 
 When FILE is - read standard input.
+
+CONFIGURATION FILE
+Default configuration options can be stored in $configuration_file,
+search path: '$def_configuration_dirs_help' or in a directory specified by
+\$$env_config_dir environment variable (fallback to the default search path).
 EOM
 
 	exit($exitcode);
@@ -237,7 +250,7 @@ sub list_types {
 	exit($exitcode);
 }
 
-my $conf = which_conf($configuration_file);
+my $conf = which_conf($configuration_file, $env_config_dir, $def_configuration_dirs);
 if (-f $conf) {
 	my @conf_args;
 	open(my $conffile, '<', "$conf")
@@ -339,6 +352,7 @@ GetOptions(
 	'fix!'		=> \$fix,
 	'fix-inplace!'	=> \$fix_inplace,
 	'ignore-perl-version!' => \$ignore_perl_version,
+	'spdx-cxx-comments!' => \$spdx_cxx_comments,
 	'debug=s'	=> \%debug,
 	'test-only=s'	=> \$tst_only,
 	'codespell!'	=> \$codespell,
@@ -641,6 +655,7 @@ our $signature_tags = qr{(?xi:
 	Reviewed-by:|
 	Reported-by:|
 	Suggested-by:|
+	Assisted-by:|
 	To:|
 	Cc:
 )};
@@ -1102,7 +1117,9 @@ our $declaration_macros = qr{(?x:
 	(?:$Storage\s+)?(?:[A-Z_][A-Z0-9]*_){0,2}(?:DEFINE|DECLARE)(?:_[A-Z0-9]+){1,6}\s*\(|
 	(?:$Storage\s+)?[HLP]?LIST_HEAD\s*\(|
 	(?:SKCIPHER_REQUEST|SHASH_DESC|AHASH_REQUEST)_ON_STACK\s*\(|
-	(?:$Storage\s+)?(?:XA_STATE|XA_STATE_ORDER)\s*\(
+	(?:$Storage\s+)?(?:XA_STATE|XA_STATE_ORDER)\s*\(|
+	__cacheline_group_(?:begin|end)(?:_aligned)?\s*\(|
+	__dma_from_device_group_(?:begin|end)\s*\(
 )};
 
 our %allow_repeated_words = (
@@ -1528,9 +1545,15 @@ sub which {
 }
 
 sub which_conf {
-	my ($conf) = @_;
+	my ($conf, $env_key, $paths) = @_;
+	my $env_dir = $ENV{$env_key};
+
+	if (defined($env_dir) && $env_dir ne "") {
+		return "$env_dir/$conf" if (-e "$env_dir/$conf");
+		warn "$P: Can't find a readable $conf in '$env_dir', falling back to default search paths\n";
+	}
 
-	foreach my $path (split(/:/, ".:$ENV{HOME}:.scripts")) {
+	foreach my $path (split(/:/, $paths)) {
 		if (-e "$path/$conf") {
 			return "$path/$conf";
 		}
@@ -2926,7 +2949,7 @@ sub process {
 			}
 			$checklicenseline = 1;
 
-			if ($realfile !~ /^MAINTAINERS/) {
+			if ($realfile !~ /^(MAINTAINERS|dev\/null)/) {
 				my $last_binding_patch = $is_binding_patch;
 
 				$is_binding_patch = () = $realfile =~ m@^(?:Documentation/devicetree/|include/dt-bindings/)@;
@@ -3033,6 +3056,16 @@ sub process {
 			}
 		}
 
+# Check for invalid patch separator
+		if ($in_commit_log &&
+		    $line =~ /^---.+/) {
+			if (ERROR("BAD_COMMIT_SEPARATOR",
+				  "Invalid commit separator - some tools may have problems applying this\n" . $herecurr) &&
+			    $fix) {
+				$fixed[$fixlinenr] =~ s/-/=/g;
+			}
+		}
+
 # Check for patch separator
 		if ($line =~ /^---$/) {
 			$has_patch_separator = 1;
@@ -3093,6 +3126,15 @@ sub process {
 				}
 			}
 
+			# Assisted-by uses AGENT_NAME:MODEL_VERSION format, not email
+			if ($sign_off =~ /^Assisted-by:/i) {
+				if ($email !~ /^\S+:\S+/) {
+					WARN("BAD_SIGN_OFF",
+					     "Assisted-by expects 'AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]' format\n" . $herecurr);
+				}
+				next;
+			}
+
 			my ($email_name, $name_comment, $email_address, $comment) = parse_email($email);
 			my $suggested_email = format_email(($email_name, $name_comment, $email_address, $comment));
 			if ($suggested_email eq "") {
@@ -3779,26 +3821,33 @@ sub process {
 				$checklicenseline = 2;
 			} elsif ($rawline =~ /^\+/) {
 				my $comment = "";
-				if ($realfile =~ /\.(h|s|S)$/) {
-					$comment = '/*';
-				} elsif ($realfile =~ /\.(c|rs|dts|dtsi)$/) {
+				if ($realfile =~ /\.(c|rs|dts|dtsi)$/) {
 					$comment = '//';
 				} elsif (($checklicenseline == 2) || $realfile =~ /\.(sh|pl|py|awk|tc|yaml)$/) {
 					$comment = '#';
 				} elsif ($realfile =~ /\.rst$/) {
 					$comment = '..';
 				}
+				my $pattern = qr{\Q$comment\E};
+				if ($realfile =~ /\.(h|s|S)$/) {
+					$comment = '/*';
+					$pattern = qr{/\*};
+					if ($spdx_cxx_comments) {
+						$comment = '// or /*';
+						$pattern = qr{//|/\*};
+					}
+				}
 
 # check SPDX comment style for .[chsS] files
 				if ($realfile =~ /\.[chsS]$/ &&
 				    $rawline =~ /SPDX-License-Identifier:/ &&
-				    $rawline !~ m@^\+\s*\Q$comment\E\s*@) {
+				    $rawline !~ m@^\+\s*$pattern\s*@) {
 					WARN("SPDX_LICENSE_TAG",
 					     "Improper SPDX comment style for '$realfile', please use '$comment' instead\n" . $herecurr);
 				}
 
 				if ($comment !~ /^$/ &&
-				    $rawline !~ m@^\+\Q$comment\E SPDX-License-Identifier: @) {
+				    $rawline !~ m@^\+$pattern SPDX-License-Identifier: @) {
 					WARN("SPDX_LICENSE_TAG",
 					     "Missing or malformed SPDX-License-Identifier tag in line $checklicenseline\n" . $herecurr);
 				} elsif ($rawline =~ /(SPDX-License-Identifier: .*)/) {
@@ -3844,6 +3893,14 @@ sub process {
 			     "Misplaced SPDX-License-Identifier tag - use line $checklicenseline instead\n" . $herecurr);
 		}
 
+# check for disallowed SPDX file tags
+		if ($rawline =~ /\bSPDX-.*:/ &&
+		    $rawline !~ /\bSPDX-License-Identifier:/ &&
+		    $rawline !~ /\bSPDX-FileCopyrightText:/) {
+			WARN("SPDX_LICENSE_TAG",
+			     "Disallowed SPDX tag\n" . $herecurr);
+		}
+
 # line length limit (with some exclusions)
 #
 # There are a few types of lines that may extend beyond $max_line_length:
@@ -5648,9 +5705,7 @@ sub process {
 			my $comp = $3;
 			my $to = $4;
 			my $newcomp = $comp;
-
-			if ($const !~ /^\QTST_/ &&
-			    $lead !~ /(?:$Operators|\.)\s*$/ &&
+			if ($lead !~ /(?:$Operators|\.)\s*$/ &&
 			    $to !~ /^(?:Constant|[A-Z_][A-Z0-9_]*)$/ &&
 			    WARN("CONSTANT_COMPARISON",
 				 "Comparisons should place the constant on the right side of the test\n" . $herecurr) &&
@@ -6737,6 +6792,13 @@ sub process {
 			}
 		}
 
+# check for context_unsafe without a comment.
+		if ($line =~ /\bcontext_unsafe\b/ &&
+		    !ctx_has_comment($first_line, $linenr)) {
+			WARN("CONTEXT_UNSAFE",
+			     "context_unsafe without comment\n" . $herecurr);
+		}
+
 # check of hardware specific defines
 		if ($line =~ m@^.\s*\#\s*if.*\b(__i386__|__powerpc64__|__sun__|__s390x__)\b@ && $realfile !~ m@include/asm-@) {
 			CHK("ARCH_DEFINES",
@@ -7142,7 +7204,7 @@ sub process {
 				if ($count == 1 &&
 				    $format =~ /^"\%(?i:ll[udxi]|[udxi]ll|ll|[hl]h?[udxi]|[udxi][hl]h?|[hl]h?|[udxi])"$/) {
 					WARN("SSCANF_TO_KSTRTO",
-					     "Prefer tst_parse_<type> to single variable sscanf\n" . "$here\n$stat_real\n");
+					     "Prefer kstrto<type> to single variable sscanf\n" . "$here\n$stat_real\n");
 				}
 			}
 		}
@@ -7262,17 +7324,42 @@ sub process {
 			    "Prefer $3(sizeof(*$1)...) over $3($4...)\n" . $herecurr);
 		}
 
-# check for (kv|k)[mz]alloc with multiplies that could be kmalloc_array/kvmalloc_array/kvcalloc/kcalloc
+# check for (kv|k)[mz]alloc that could be kmalloc_obj/kvmalloc_obj/kzalloc_obj/kvzalloc_obj
+		if ($perl_version_ok &&
+		    defined $stat &&
+		    $stat =~ /^\+\s*($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*,/) {
+			my $oldfunc = $3;
+			my $a1 = $4;
+			my $newfunc = "kmalloc_obj";
+			$newfunc = "kvmalloc_obj" if ($oldfunc eq "kvmalloc");
+			$newfunc = "kvzalloc_obj" if ($oldfunc eq "kvzalloc");
+			$newfunc = "kzalloc_obj" if ($oldfunc eq "kzalloc");
+
+			if ($a1 =~ s/^sizeof\s*\S\(?([^\)]*)\)?$/$1/) {
+				my $cnt = statement_rawlines($stat);
+				my $herectx = get_stat_here($linenr, $cnt, $here);
+
+				if (WARN("ALLOC_WITH_SIZEOF",
+					 "Prefer $newfunc over $oldfunc with sizeof\n" . $herectx) &&
+				    $cnt == 1 &&
+				    $fix) {
+					$fixed[$fixlinenr] =~ s/\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*,/$1 = $newfunc($a1,/;
+				}
+			}
+		}
+
+
+# check for (kv|k)[mz]alloc with multiplies that could be kmalloc_objs/kvmalloc_objs/kzalloc_objs/kvzalloc_objs
 		if ($perl_version_ok &&
 		    defined $stat &&
 		    $stat =~ /^\+\s*($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)\s*,/) {
 			my $oldfunc = $3;
 			my $a1 = $4;
 			my $a2 = $10;
-			my $newfunc = "kmalloc_array";
-			$newfunc = "kvmalloc_array" if ($oldfunc eq "kvmalloc");
-			$newfunc = "kvcalloc" if ($oldfunc eq "kvzalloc");
-			$newfunc = "kcalloc" if ($oldfunc eq "kzalloc");
+			my $newfunc = "kmalloc_objs";
+			$newfunc = "kvmalloc_objs" if ($oldfunc eq "kvmalloc");
+			$newfunc = "kvzalloc_objs" if ($oldfunc eq "kvzalloc");
+			$newfunc = "kzalloc_objs" if ($oldfunc eq "kzalloc");
 			my $r1 = $a1;
 			my $r2 = $a2;
 			if ($a1 =~ /^sizeof\s*\S/) {
@@ -7288,7 +7375,9 @@ sub process {
 					 "Prefer $newfunc over $oldfunc with multiply\n" . $herectx) &&
 				    $cnt == 1 &&
 				    $fix) {
-					$fixed[$fixlinenr] =~ s/\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/$1 . ' = ' . "$newfunc(" . trim($r1) . ', ' . trim($r2)/e;
+					my $sized = trim($r2);
+					$sized =~ s/^sizeof\s*\S\(?([^\)]*)\)?$/$1/;
+					$fixed[$fixlinenr] =~ s/\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/$1 . ' = ' . "$newfunc(" . $sized . ', ' . trim($r1)/e;
 				}
 			}
 		}
@@ -7458,10 +7547,10 @@ sub process {
 		}
 
 # check for various structs that are normally const (ops, kgdb, device_tree)
-# and avoid what seem like struct definitions 'struct foo {'
+# and avoid what seem like struct definitions 'struct foo {' or forward declarations 'struct foo;'
 		if (defined($const_structs) &&
 		    $line !~ /\bconst\b/ &&
-		    $line =~ /\bstruct\s+($const_structs)\b(?!\s*\{)/) {
+		    $line =~ /\bstruct\s+($const_structs)\b(?!\s*[\{;])/) {
 			WARN("CONST_STRUCT",
 			     "struct $1 should normally be const\n" . $herecurr);
 		}
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
