Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA71CC79F8B
	for <ltp@archiver.kernel.org>; Mon,  5 Jan 2026 13:04:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 469EB3C2909
	for <ltp@archiver.kernel.org>; Mon,  5 Jan 2026 14:04:35 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B3B33C184E
 for <ltp@lists.linux.it>; Mon,  5 Jan 2026 14:04:06 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8C8FC2001B6
 for <ltp@lists.linux.it>; Mon,  5 Jan 2026 14:04:04 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 48AE333740;
 Mon,  5 Jan 2026 13:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767618243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ZRF+1UZlZ19/Li0LBEDO/6Bor2k16aCf5ju0ZHWSrE=;
 b=Oq+U739yfAA2sdlA+IZhZZ+E9moQmyqPmXASr9JzkfOeQn3PiRW7+GOnHQDFEAHpmMn0hx
 hBywsNpMn7FLKEPB+ga/XEfE2GN8oi8k9umuUd112novnMRMP9YXjcxtn88KtufLE+AvWO
 1NpSOHfNbuqRt7Da+/RSjBG+FjFgmDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767618243;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ZRF+1UZlZ19/Li0LBEDO/6Bor2k16aCf5ju0ZHWSrE=;
 b=5X/mSdealEASWwaKEGAeI95xdsQ6dqn3/73cFVis1SVR67OMdshjILcVMtRfOET2TS9oZ8
 Aj0iKv6wwEHn3ZBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767618243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ZRF+1UZlZ19/Li0LBEDO/6Bor2k16aCf5ju0ZHWSrE=;
 b=Oq+U739yfAA2sdlA+IZhZZ+E9moQmyqPmXASr9JzkfOeQn3PiRW7+GOnHQDFEAHpmMn0hx
 hBywsNpMn7FLKEPB+ga/XEfE2GN8oi8k9umuUd112novnMRMP9YXjcxtn88KtufLE+AvWO
 1NpSOHfNbuqRt7Da+/RSjBG+FjFgmDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767618243;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ZRF+1UZlZ19/Li0LBEDO/6Bor2k16aCf5ju0ZHWSrE=;
 b=5X/mSdealEASWwaKEGAeI95xdsQ6dqn3/73cFVis1SVR67OMdshjILcVMtRfOET2TS9oZ8
 Aj0iKv6wwEHn3ZBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D79623EA65;
 Mon,  5 Jan 2026 13:04:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IO/OMMK2W2k7cwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 05 Jan 2026 13:04:02 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  5 Jan 2026 14:03:59 +0100
Message-ID: <20260105130359.647879-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105130359.647879-1-pvorel@suse.cz>
References: <20260105130359.647879-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.988]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_FIVE(0.00)[5];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] checkpatch.pl: spelling.txt: Update to
 next-20260105
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

Update checkpatch.pl to next-20260105 (6.19-rc4).
checkpatch.pl last change:
e55c2e2871 ("checkpatch: Deprecate rcu_read_{,un}lock_trace()")

spelling.txt last change:
53f433891e ("scripts/spelling.txt: add notifer||notifier to spelling.txt")

This is required at least for getting checkpatch.pl fix:
d6bb39519aafe ("checkpatch: really skip LONG_LINE_* when LONG_LINE is ignored")

Apply also our LTP changes:
27a08ddba1 ("scripts/checkpatch.pl: Replace kstrto with tst_parse_")
76d0c09aa1 ("scripts/checkpatch.pl: Ignore TST_* in constant checks")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
NOTE: I'd still update even we accept LONG_LINE.

 scripts/checkpatch.pl | 580 +++++++++++++++++++++++++++++++++---------
 scripts/spelling.txt  | 196 +++++++++++++-
 2 files changed, 657 insertions(+), 119 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 21d9c9fe30..c70fcfbb3c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1,5 +1,5 @@
 #!/usr/bin/env perl
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: GPL-2.0
 #
 # (c) 2001, Dave Jones. (the file handling bit)
 # (c) 2005, Joel Schopp <jschopp@austin.ibm.com> (the ugly bit)
@@ -28,6 +28,7 @@ my %verbose_messages = ();
 my %verbose_emitted = ();
 my $tree = 1;
 my $chk_signoff = 1;
+my $chk_fixes_tag = 1;
 my $chk_patch = 1;
 my $tst_only;
 my $emacs = 0;
@@ -63,6 +64,7 @@ my $min_conf_desc_length = 4;
 my $spelling_file = "$D/spelling.txt";
 my $codespell = 0;
 my $codespellfile = "/usr/share/codespell/dictionary.txt";
+my $user_codespellfile = "";
 my $conststructsfile = "$D/const_structs.checkpatch";
 my $docsfile = "$D/../Documentation/dev-tools/checkpatch.rst";
 my $typedefsfile;
@@ -73,6 +75,8 @@ my $git_command ='export LANGUAGE=en_US.UTF-8; git';
 my $tabsize = 8;
 my ${CONFIG_} = "CONFIG_";
 
+my %maybe_linker_symbol; # for externs in c exceptions, when seen in *vmlinux.lds.h
+
 sub help {
 	my ($exitcode) = @_;
 
@@ -85,6 +89,7 @@ Options:
   -v, --verbose              verbose mode
   --no-tree                  run without a kernel tree
   --no-signoff               do not check for 'Signed-off-by' line
+  --no-fixes-tag             do not check for 'Fixes:' tag
   --patch                    treat FILE as patchfile (default)
   --emacs                    emacs compile window format
   --terse                    one line per report
@@ -108,7 +113,8 @@ Options:
   --max-line-length=n        set the maximum line length, (default $max_line_length)
                              if exceeded, warn on patches
                              requires --strict for use with --file
-  --min-conf-desc-length=n   set the min description length, if shorter, warn
+  --min-conf-desc-length=n   set the minimum description length for config symbols
+                             in lines, if shorter, warn (default $min_conf_desc_length)
   --tab-size=n               set the number of spaces for tab (default $tabsize)
   --root=PATH                PATH to the kernel tree root
   --no-summary               suppress the per-file summary
@@ -130,7 +136,7 @@ Options:
   --ignore-perl-version      override checking of perl version.  expect
                              runtime errors.
   --codespell                Use the codespell dictionary for spelling/typos
-                             (default:/usr/share/codespell/dictionary.txt)
+                             (default:$codespellfile)
   --codespellfile            Use this codespell dictionary
   --typedefsfile             Read additional types from this file
   --color[=WHEN]             Use colors 'always', 'never', or only when output
@@ -145,6 +151,24 @@ EOM
 	exit($exitcode);
 }
 
+my $DO_WHILE_0_ADVICE = q{
+   do {} while (0) advice is over-stated in a few situations:
+
+   The more obvious case is macros, like MODULE_PARM_DESC, invoked at
+   file-scope, where C disallows code (it must be in functions).  See
+   $exceptions if you have one to add by name.
+
+   More troublesome is declarative macros used at top of new scope,
+   like DECLARE_PER_CPU.  These might just compile with a do-while-0
+   wrapper, but would be incorrect.  Most of these are handled by
+   detecting struct,union,etc declaration primitives in $exceptions.
+
+   Theres also macros called inside an if (block), which "return" an
+   expression.  These cannot do-while, and need a ({}) wrapper.
+
+   Enjoy this qualification while we work to improve our heuristics.
+};
+
 sub uniq {
 	my %seen;
 	return grep { !$seen{$_}++ } @_;
@@ -292,6 +316,7 @@ GetOptions(
 	'v|verbose!'	=> \$verbose,
 	'tree!'		=> \$tree,
 	'signoff!'	=> \$chk_signoff,
+	'fixes-tag!'	=> \$chk_fixes_tag,
 	'patch!'	=> \$chk_patch,
 	'emacs!'	=> \$emacs,
 	'terse!'	=> \$terse,
@@ -317,7 +342,7 @@ GetOptions(
 	'debug=s'	=> \%debug,
 	'test-only=s'	=> \$tst_only,
 	'codespell!'	=> \$codespell,
-	'codespellfile=s'	=> \$codespellfile,
+	'codespellfile=s'	=> \$user_codespellfile,
 	'typedefsfile=s'	=> \$typedefsfile,
 	'color=s'	=> \$color,
 	'no-color'	=> \$color,	#keep old behaviors of -nocolor
@@ -325,9 +350,32 @@ GetOptions(
 	'kconfig-prefix=s'	=> \${CONFIG_},
 	'h|help'	=> \$help,
 	'version'	=> \$help
-) or help(1);
+) or $help = 2;
+
+if ($user_codespellfile) {
+	# Use the user provided codespell file unconditionally
+	$codespellfile = $user_codespellfile;
+} elsif (!(-f $codespellfile)) {
+	# If /usr/share/codespell/dictionary.txt is not present, try to find it
+	# under codespell's install directory: <codespell_root>/data/dictionary.txt
+	if (($codespell || $help) && which("python3") ne "") {
+		my $python_codespell_dict = << "EOF";
+
+import os.path as op
+import codespell_lib
+codespell_dir = op.dirname(codespell_lib.__file__)
+codespell_file = op.join(codespell_dir, 'data', 'dictionary.txt')
+print(codespell_file, end='')
+EOF
+
+		my $codespell_dict = `python3 -c "$python_codespell_dict" 2> /dev/null`;
+		$codespellfile = $codespell_dict if (-f $codespell_dict);
+	}
+}
 
-help(0) if ($help);
+# $help is 1 if either -h, --help or --version is passed as option - exitcode: 0
+# $help is 2 if invalid option is passed - exitcode: 1
+help($help - 1) if ($help);
 
 die "$P: --git cannot be used with --file or --fix\n" if ($git && ($file || $fix));
 die "$P: --verbose cannot be used with --terse\n" if ($verbose && $terse);
@@ -486,6 +534,7 @@ our $Attribute	= qr{
 			__ro_after_init|
 			__kprobes|
 			$InitAttribute|
+			__aligned\s*\(.*\)|
 			____cacheline_aligned|
 			____cacheline_aligned_in_smp|
 			____cacheline_internodealigned_in_smp|
@@ -552,10 +601,14 @@ our $typeKernelTypedefs = qr{(?x:
 	(?:__)?(?:u|s|be|le)(?:8|16|32|64)|
 	atomic_t
 )};
+our $typeStdioTypedefs = qr{(?x:
+	FILE
+)};
 our $typeTypedefs = qr{(?x:
 	$typeC99Typedefs\b|
 	$typeOtherOSTypedefs\b|
-	$typeKernelTypedefs\b
+	$typeKernelTypedefs\b|
+	$typeStdioTypedefs\b
 )};
 
 our $zero_initializer = qr{(?:(?:0[xX])?0+$Int_type?|NULL|false)\b};
@@ -592,6 +645,22 @@ our $signature_tags = qr{(?xi:
 	Cc:
 )};
 
+our @link_tags = qw(Link Closes);
+
+#Create a search and print patterns for all these strings to be used directly below
+our $link_tags_search = "";
+our $link_tags_print = "";
+foreach my $entry (@link_tags) {
+	if ($link_tags_search ne "") {
+		$link_tags_search .= '|';
+		$link_tags_print .= ' or ';
+	}
+	$entry .= ':';
+	$link_tags_search .= $entry;
+	$link_tags_print .= "'$entry'";
+}
+$link_tags_search = "(?:${link_tags_search})";
+
 our $tracing_logging_tags = qr{(?xi:
 	[=-]*> |
 	<[=-]* |
@@ -616,6 +685,9 @@ our $tracing_logging_tags = qr{(?xi:
 	[\.\!:\s]*
 )};
 
+# Device ID types like found in include/linux/mod_devicetable.h.
+our $dev_id_types = qr{\b[a-z]\w*_device_id\b};
+
 sub edit_distance_min {
 	my (@arr) = @_;
 	my $len = scalar @arr;
@@ -674,6 +746,17 @@ sub find_standard_signature {
 	return "";
 }
 
+our $obsolete_archives = qr{(?xi:
+	\Qfreedesktop.org/archives/dri-devel\E |
+	\Qlists.infradead.org\E |
+	\Qlkml.org\E |
+	\Qmail-archive.com\E |
+	\Qmailman.alsa-project.org/pipermail\E |
+	\Qmarc.info\E |
+	\Qozlabs.org/pipermail\E |
+	\Qspinics.net\E
+)};
+
 our @typeListMisordered = (
 	qr{char\s+(?:un)?signed},
 	qr{int\s+(?:(?:un)?signed\s+)?short\s},
@@ -773,16 +856,16 @@ foreach my $entry (@mode_permission_funcs) {
 $mode_perms_search = "(?:${mode_perms_search})";
 
 our %deprecated_apis = (
-	"synchronize_rcu_bh"			=> "synchronize_rcu",
-	"synchronize_rcu_bh_expedited"		=> "synchronize_rcu_expedited",
-	"call_rcu_bh"				=> "call_rcu",
-	"rcu_barrier_bh"			=> "rcu_barrier",
-	"synchronize_sched"			=> "synchronize_rcu",
-	"synchronize_sched_expedited"		=> "synchronize_rcu_expedited",
-	"call_rcu_sched"			=> "call_rcu",
-	"rcu_barrier_sched"			=> "rcu_barrier",
-	"get_state_synchronize_sched"		=> "get_state_synchronize_rcu",
-	"cond_synchronize_sched"		=> "cond_synchronize_rcu",
+	"kmap"					=> "kmap_local_page",
+	"kunmap"				=> "kunmap_local",
+	"kmap_atomic"				=> "kmap_local_page",
+	"kunmap_atomic"				=> "kunmap_local",
+	#These should be enough to drive away new IDR users
+	"DEFINE_IDR"				=> "DEFINE_XARRAY",
+	"idr_init"				=> "xa_init",
+	"idr_init_base"				=> "xa_init_flags",
+	"rcu_read_lock_trace"			=> "rcu_read_lock_tasks_trace",
+	"rcu_read_unlock_trace"			=> "rcu_read_unlock_tasks_trace",
 );
 
 #Create a search pattern for all these strings to speed up a loop below
@@ -1018,7 +1101,8 @@ our $FuncArg = qr{$Typecast{0,1}($LvalOrFunc|$Constant|$String)};
 our $declaration_macros = qr{(?x:
 	(?:$Storage\s+)?(?:[A-Z_][A-Z0-9]*_){0,2}(?:DEFINE|DECLARE)(?:_[A-Z0-9]+){1,6}\s*\(|
 	(?:$Storage\s+)?[HLP]?LIST_HEAD\s*\(|
-	(?:SKCIPHER_REQUEST|SHASH_DESC|AHASH_REQUEST)_ON_STACK\s*\(
+	(?:SKCIPHER_REQUEST|SHASH_DESC|AHASH_REQUEST)_ON_STACK\s*\(|
+	(?:$Storage\s+)?(?:XA_STATE|XA_STATE_ORDER)\s*\(
 )};
 
 our %allow_repeated_words = (
@@ -1194,6 +1278,7 @@ sub git_commit_info {
 }
 
 $chk_signoff = 0 if ($file);
+$chk_fixes_tag = 0 if ($file);
 
 my @rawlines = ();
 my @lines = ();
@@ -2557,6 +2642,11 @@ sub exclude_global_initialisers {
 		$realfile =~ m@/bpf/.*\.bpf\.c$@;
 }
 
+sub is_userspace {
+    my ($realfile) = @_;
+    return ($realfile =~ m@^tools/@ || $realfile =~ m@^scripts/@);
+}
+
 sub process {
 	my $filename = shift;
 
@@ -2573,6 +2663,9 @@ sub process {
 
 	our $clean = 1;
 	my $signoff = 0;
+	my $fixes_tag = 0;
+	my $is_revert = 0;
+	my $needs_fixes_tag = "";
 	my $author = '';
 	my $authorsignoff = 0;
 	my $author_sob = '';
@@ -2805,7 +2898,7 @@ sub process {
 
 			if ($realfile =~ m@^include/asm/@) {
 				ERROR("MODIFIED_INCLUDE_ASM",
-				      "do not modify files in include/asm, change architecture specific files in include/asm-<architecture>\n" . "$here$rawline\n");
+				      "do not modify files in include/asm, change architecture specific files in arch/<architecture>/include/asm\n" . "$here$rawline\n");
 			}
 			$found_file = 1;
 		}
@@ -3100,17 +3193,79 @@ sub process {
 			if ($sign_off =~ /^co-developed-by:$/i) {
 				if ($email eq $author) {
 					WARN("BAD_SIGN_OFF",
-					      "Co-developed-by: should not be used to attribute nominal patch author '$author'\n" . "$here\n" . $rawline);
+					      "Co-developed-by: should not be used to attribute nominal patch author '$author'\n" . $herecurr);
 				}
 				if (!defined $lines[$linenr]) {
 					WARN("BAD_SIGN_OFF",
-					     "Co-developed-by: must be immediately followed by Signed-off-by:\n" . "$here\n" . $rawline);
-				} elsif ($rawlines[$linenr] !~ /^\s*signed-off-by:\s*(.*)/i) {
+					     "Co-developed-by: must be immediately followed by Signed-off-by:\n" . $herecurr);
+				} elsif ($rawlines[$linenr] !~ /^signed-off-by:\s*(.*)/i) {
 					WARN("BAD_SIGN_OFF",
-					     "Co-developed-by: must be immediately followed by Signed-off-by:\n" . "$here\n" . $rawline . "\n" .$rawlines[$linenr]);
+					     "Co-developed-by: must be immediately followed by Signed-off-by:\n" . $herecurr . $rawlines[$linenr] . "\n");
 				} elsif ($1 ne $email) {
 					WARN("BAD_SIGN_OFF",
-					     "Co-developed-by and Signed-off-by: name/email do not match \n" . "$here\n" . $rawline . "\n" .$rawlines[$linenr]);
+					     "Co-developed-by and Signed-off-by: name/email do not match\n" . $herecurr . $rawlines[$linenr] . "\n");
+				}
+			}
+
+# check if Reported-by: is followed by a Closes: tag
+			if ($sign_off =~ /^reported(?:|-and-tested)-by:$/i) {
+				if (!defined $lines[$linenr]) {
+					WARN("BAD_REPORTED_BY_LINK",
+					     "Reported-by: should be immediately followed by Closes: with a URL to the report\n" . $herecurr . "\n");
+				} elsif ($rawlines[$linenr] !~ /^closes:\s*/i) {
+					WARN("BAD_REPORTED_BY_LINK",
+					     "Reported-by: should be immediately followed by Closes: with a URL to the report\n" . $herecurr . $rawlines[$linenr] . "\n");
+				}
+			}
+		}
+
+# These indicate a bug fix
+		if (!$in_header_lines && !$is_patch &&
+			$line =~ /^This reverts commit/) {
+			$is_revert = 1;
+		}
+
+		if (!$in_header_lines && !$is_patch &&
+		    $line =~ /((?:(?:BUG: K.|UB)SAN: |Call Trace:|stable\@|syzkaller))/) {
+			$needs_fixes_tag = $1;
+		}
+
+# Check Fixes: styles is correct
+		if (!$in_header_lines &&
+		    $line =~ /^\s*(fixes:?)\s*(?:commit\s*)?([0-9a-f]{5,40})(?:\s*($balanced_parens))?/i) {
+			my $tag = $1;
+			my $orig_commit = $2;
+			my $title;
+			my $title_has_quotes = 0;
+			$fixes_tag = 1;
+			if (defined $3) {
+				# Always strip leading/trailing parens then double quotes if existing
+				$title = substr($3, 1, -1);
+				if ($title =~ /^".*"$/) {
+					$title = substr($title, 1, -1);
+					$title_has_quotes = 1;
+				}
+			} else {
+				$title = "commit title"
+			}
+
+
+			my $tag_case = not ($tag eq "Fixes:");
+			my $tag_space = not ($line =~ /^fixes:? [0-9a-f]{5,40} ($balanced_parens)/i);
+
+			my $id_length = not ($orig_commit =~ /^[0-9a-f]{12,40}$/i);
+			my $id_case = not ($orig_commit !~ /[A-F]/);
+
+			my $id = "0123456789ab";
+			my ($cid, $ctitle) = git_commit_info($orig_commit, $id,
+							     $title);
+
+			if (defined($cid) && ($ctitle ne $title || $tag_case || $tag_space || $id_length || $id_case || !$title_has_quotes)) {
+				my $fixed = "Fixes: $cid (\"$ctitle\")";
+				if (WARN("BAD_FIXES_TAG",
+				     "Please use correct Fixes: style 'Fixes: <12+ chars of sha1> (\"<title line>\")' - ie: '$fixed'\n" . $herecurr) &&
+				    $fix) {
+					$fixed[$fixlinenr] = $fixed;
 				}
 			}
 		}
@@ -3148,13 +3303,13 @@ sub process {
 		    length($line) > 75 &&
 		    !($line =~ /^\s*[a-zA-Z0-9_\/\.]+\s+\|\s+\d+/ ||
 					# file delta changes
-		      $line =~ /^\s*(?:[\w\.\-]+\/)++[\w\.\-]+:/ ||
+		      $line =~ /^\s*(?:[\w\.\-\+]*\/)++[\w\.\-\+]+:/ ||
 					# filename then :
-		      $line =~ /^\s*(?:Fixes:|Link:|$signature_tags)/i ||
-					# A Fixes: or Link: line or signature tag line
+		      $line =~ /^\s*(?:Fixes:|https?:|$link_tags_search|$signature_tags)/i ||
+					# A Fixes:, link or signature tag line
 		      $commit_log_possible_stack_dump)) {
 			WARN("COMMIT_LOG_LONG_LINE",
-			     "Possible unwrapped commit description (prefer a maximum 75 chars per line)\n" . $herecurr);
+			     "Prefer a maximum 75 chars per line (possible unwrapped commit description?)\n" . $herecurr);
 			$commit_log_long_line = 1;
 		}
 
@@ -3164,6 +3319,29 @@ sub process {
 			$commit_log_possible_stack_dump = 0;
 		}
 
+# Check for odd tags before a URI/URL
+		if ($in_commit_log &&
+		    $line =~ /^\s*(\w+:)\s*http/ && $1 !~ /^$link_tags_search$/) {
+			if ($1 =~ /^v(?:ersion)?\d+/i) {
+				WARN("COMMIT_LOG_VERSIONING",
+				     "Patch version information should be after the --- line\n" . $herecurr);
+			} else {
+				WARN("COMMIT_LOG_USE_LINK",
+				     "Unknown link reference '$1', use $link_tags_print instead\n" . $herecurr);
+			}
+		}
+
+# Check for misuse of the link tags
+		if ($in_commit_log &&
+		    $line =~ /^\s*(\w+:)\s*(\S+)/) {
+			my $tag = $1;
+			my $value = $2;
+			if ($tag =~ /^$link_tags_search$/ && $value !~ m{^https?://}) {
+				WARN("COMMIT_LOG_WRONG_LINK",
+				     "'$tag' should be followed by a public http(s) link\n" . $herecurr);
+			}
+		}
+
 # Check for lines starting with a #
 		if ($in_commit_log && $line =~ /^#/) {
 			if (WARN("COMMIT_COMMENT_SYMBOL",
@@ -3173,6 +3351,13 @@ sub process {
 			}
 		}
 
+# Check for auto-generated unhandled placeholder text (mostly for cover letters)
+		if (($in_commit_log || $in_header_lines) &&
+		    $rawline =~ /(?:SUBJECT|BLURB) HERE/) {
+			ERROR("PLACEHOLDER_USE",
+			      "Placeholder text detected\n" . $herecurr);
+		}
+
 # Check for git id commit length and improperly formed commit descriptions
 # A correctly formed commit description is:
 #    commit <SHA-1 hash length 12+ chars> ("Complete commit subject")
@@ -3249,6 +3434,12 @@ sub process {
 			$last_git_commit_id_linenr = $linenr if ($line =~ /\bcommit\s*$/i);
 		}
 
+# Check for mailing list archives other than lore.kernel.org
+		if ($rawline =~ m{http.*\b$obsolete_archives}) {
+			WARN("PREFER_LORE_ARCHIVE",
+			     "Use lore.kernel.org archive links when possible - see https://lore.kernel.org/lists.html\n" . $herecurr);
+		}
+
 # Check for added, moved or deleted files
 		if (!$reported_maintainer_file && !$in_commit_log &&
 		    ($line =~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||
@@ -3330,9 +3521,10 @@ sub process {
 # Check for various typo / spelling mistakes
 		if (defined($misspellings) &&
 		    ($in_commit_log || $line =~ /^(?:\+|Subject:)/i)) {
-			while ($rawline =~ /(?:^|[^\w\-'`])($misspellings)(?:[^\w\-'`]|$)/gi) {
+			my $rawline_utf8 = decode("utf8", $rawline);
+			while ($rawline_utf8 =~ /(?:^|[^\w\-'`])($misspellings)(?:[^\w\-'`]|$)/gi) {
 				my $typo = $1;
-				my $blank = copy_spacing($rawline);
+				my $blank = copy_spacing($rawline_utf8);
 				my $ptr = substr($blank, 0, $-[1]) . "^" x length($typo);
 				my $hereptr = "$hereline$ptr\n";
 				my $typo_fix = $spelling_fix{lc($typo)};
@@ -3455,47 +3647,47 @@ sub process {
 		    # Kconfig supports named choices), so use a word boundary
 		    # (\b) rather than a whitespace character (\s)
 		    $line =~ /^\+\s*(?:config|menuconfig|choice)\b/) {
-			my $length = 0;
-			my $cnt = $realcnt;
-			my $ln = $linenr + 1;
-			my $f;
-			my $is_start = 0;
-			my $is_end = 0;
-			for (; $cnt > 0 && defined $lines[$ln - 1]; $ln++) {
-				$f = $lines[$ln - 1];
-				$cnt-- if ($lines[$ln - 1] !~ /^-/);
-				$is_end = $lines[$ln - 1] =~ /^\+/;
+			my $ln = $linenr;
+			my $needs_help = 0;
+			my $has_help = 0;
+			my $help_length = 0;
+			while (defined $lines[$ln]) {
+				my $f = $lines[$ln++];
 
 				next if ($f =~ /^-/);
-				last if (!$file && $f =~ /^\@\@/);
+				last if ($f !~ /^[\+ ]/);	# !patch context
 
-				if ($lines[$ln - 1] =~ /^\+\s*(?:bool|tristate|prompt)\s*["']/) {
-					$is_start = 1;
-				} elsif ($lines[$ln - 1] =~ /^\+\s*(?:---)?help(?:---)?$/) {
-					$length = -1;
+				if ($f =~ /^\+\s*(?:bool|tristate|prompt)\s*["']/) {
+					$needs_help = 1;
+					next;
+				}
+				if ($f =~ /^\+\s*help\s*$/) {
+					$has_help = 1;
+					next;
 				}
 
-				$f =~ s/^.//;
-				$f =~ s/#.*//;
-				$f =~ s/^\s+//;
-				next if ($f =~ /^$/);
+				$f =~ s/^.//;	# strip patch context [+ ]
+				$f =~ s/#.*//;	# strip # directives
+				$f =~ s/^\s+//;	# strip leading blanks
+				next if ($f =~ /^$/);	# skip blank lines
 
+				# At the end of this Kconfig block:
 				# This only checks context lines in the patch
 				# and so hopefully shouldn't trigger false
 				# positives, even though some of these are
 				# common words in help texts
-				if ($f =~ /^\s*(?:config|menuconfig|choice|endchoice|
-						  if|endif|menu|endmenu|source)\b/x) {
-					$is_end = 1;
+				if ($f =~ /^(?:config|menuconfig|choice|endchoice|
+					       if|endif|menu|endmenu|source)\b/x) {
 					last;
 				}
-				$length++;
+				$help_length++ if ($has_help);
 			}
-			if ($is_start && $is_end && $length < $min_conf_desc_length) {
+			if ($needs_help &&
+			    $help_length < $min_conf_desc_length) {
+				my $stat_real = get_stat_real($linenr, $ln - 1);
 				WARN("CONFIG_DESCRIPTION",
-				     "please write a paragraph that describes the config symbol fully\n" . $herecurr);
+				     "please write a help paragraph that fully describes the config symbol with at least $min_conf_desc_length lines\n" . "$here\n$stat_real\n");
 			}
-			#print "is_start<$is_start> is_end<$is_end> length<$length>\n";
 		}
 
 # check MAINTAINERS entries
@@ -3538,20 +3730,6 @@ sub process {
 			}
 		}
 
-		if (($realfile =~ /Makefile.*/ || $realfile =~ /Kbuild.*/) &&
-		    ($line =~ /\+(EXTRA_[A-Z]+FLAGS).*/)) {
-			my $flag = $1;
-			my $replacement = {
-				'EXTRA_AFLAGS' =>   'asflags-y',
-				'EXTRA_CFLAGS' =>   'ccflags-y',
-				'EXTRA_CPPFLAGS' => 'cppflags-y',
-				'EXTRA_LDFLAGS' =>  'ldflags-y',
-			};
-
-			WARN("DEPRECATED_VARIABLE",
-			     "Use of $flag is deprecated, please use \`$replacement->{$flag} instead.\n" . $herecurr) if ($replacement->{$flag});
-		}
-
 # check for DT compatible documentation
 		if (defined $root &&
 			(($realfile =~ /\.dtsi?$/ && $line =~ /^\+\s*compatible\s*=\s*\"/) ||
@@ -3583,6 +3761,18 @@ sub process {
 			}
 		}
 
+# Check for RGMII phy-mode with delay on PCB
+		if ($realfile =~ /\.(dts|dtsi|dtso)$/ &&
+		    $line =~ /^\+\s*(phy-mode|phy-connection-type)\s*=\s*"/ &&
+		    !ctx_has_comment($first_line, $linenr)) {
+			my $prop = $1;
+			my $mode = get_quoted_string($line, $rawline);
+			if ($mode =~ /^"rgmii(?:|-rxid|-txid)"$/) {
+				WARN("UNCOMMENTED_RGMII_MODE",
+				     "$prop $mode without comment -- delays on the PCB should be described, otherwise use \"rgmii-id\"\n" . $herecurr);
+			}
+		}
+
 # check for using SPDX license tag at beginning of files
 		if ($realline == $checklicenseline) {
 			if ($rawline =~ /^[ \+]\s*\#\!\s*\//) {
@@ -3591,7 +3781,7 @@ sub process {
 				my $comment = "";
 				if ($realfile =~ /\.(h|s|S)$/) {
 					$comment = '/*';
-				} elsif ($realfile =~ /\.(c|dts|dtsi)$/) {
+				} elsif ($realfile =~ /\.(c|rs|dts|dtsi)$/) {
 					$comment = '//';
 				} elsif (($checklicenseline == 2) || $realfile =~ /\.(sh|pl|py|awk|tc|yaml)$/) {
 					$comment = '#';
@@ -3618,7 +3808,7 @@ sub process {
 						     "'$spdx_license' is not supported in LICENSES/...\n" . $herecurr);
 					}
 					if ($realfile =~ m@^Documentation/devicetree/bindings/@ &&
-					    not $spdx_license =~ /GPL-2\.0.*BSD-2-Clause/) {
+					    $spdx_license !~ /GPL-2\.0(?:-only)? OR BSD-2-Clause/) {
 						my $msg_level = \&WARN;
 						$msg_level = \&CHK if ($file);
 						if (&{$msg_level}("SPDX_LICENSE_TAG",
@@ -3628,18 +3818,23 @@ sub process {
 							$fixed[$fixlinenr] =~ s/SPDX-License-Identifier: .*/SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)/;
 						}
 					}
+					if ($realfile =~ m@^include/dt-bindings/@ &&
+					    $spdx_license !~ /GPL-2\.0(?:-only)? OR \S+/) {
+						WARN("SPDX_LICENSE_TAG",
+						     "DT binding headers should be licensed (GPL-2.0-only OR .*)\n" . $herecurr);
+					}
 				}
 			}
 		}
 
 # check for embedded filenames
-		if ($rawline =~ /^\+.*\Q$realfile\E/) {
+		if ($rawline =~ /^\+.*\b\Q$realfile\E\b/) {
 			WARN("EMBEDDED_FILENAME",
 			     "It's generally not useful to have the filename in the file\n" . $herecurr);
 		}
 
 # check we are in a valid source file if not then ignore this hunk
-		next if ($realfile !~ /\.(h|c|s|S|sh|dtsi|dts)$/);
+		next if ($realfile !~ /\.(h|c|rs|s|S|sh|dtsi|dts)$/);
 
 # check for using SPDX-License-Identifier on the wrong line number
 		if ($realline != $checklicenseline &&
@@ -3705,7 +3900,7 @@ sub process {
 			}
 
 			if ($msg_type ne "" &&
-			    (show_type("LONG_LINE") || show_type($msg_type))) {
+			    show_type("LONG_LINE") && show_type($msg_type)) {
 				my $msg_level = \&WARN;
 				$msg_level = \&CHK if ($file);
 				&{$msg_level}($msg_type,
@@ -3726,7 +3921,7 @@ sub process {
 		if ($realfile =~ /\.S$/ &&
 		    $line =~ /^\+\s*(?:[A-Z]+_)?SYM_[A-Z]+_(?:START|END)(?:_[A-Z_]+)?\s*\(\s*\.L/) {
 			WARN("AVOID_L_PREFIX",
-			     "Avoid using '.L' prefixed local symbol names for denoting a range of code via 'SYM_*_START/END' annotations; see Documentation/asm-annotations.rst\n" . $herecurr);
+			     "Avoid using '.L' prefixed local symbol names for denoting a range of code via 'SYM_*_START/END' annotations; see Documentation/core-api/asm-annotations.rst\n" . $herecurr);
 		}
 
 # check we are in a valid source file C or perl if not then ignore this hunk
@@ -3844,16 +4039,6 @@ sub process {
 			}
 		}
 
-# Block comment styles
-# Networking with an initial /*
-		if ($realfile =~ m@^(drivers/net/|net/)@ &&
-		    $prevrawline =~ /^\+[ \t]*\/\*[ \t]*$/ &&
-		    $rawline =~ /^\+[ \t]*\*/ &&
-		    $realline > 3) { # Do not warn about the initial copyright comment block after SPDX-License-Identifier
-			WARN("NETWORKING_BLOCK_COMMENT_STYLE",
-			     "networking block comments don't use an empty /* line, use /* Comment...\n" . $hereprev);
-		}
-
 # Block comments use * on subsequent lines
 		if ($prevline =~ /$;[ \t]*$/ &&			#ends in comment
 		    $prevrawline =~ /^\+.*?\/\*/ &&		#starting /*
@@ -3902,7 +4087,7 @@ sub process {
 		if ($prevline =~ /^[\+ ]};?\s*$/ &&
 		    $line =~ /^\+/ &&
 		    !($line =~ /^\+\s*$/ ||
-		      $line =~ /^\+\s*EXPORT_SYMBOL/ ||
+		      $line =~ /^\+\s*(?:EXPORT_SYMBOL|early_param|ALLOW_ERROR_INJECTION)/ ||
 		      $line =~ /^\+\s*MODULE_/i ||
 		      $line =~ /^\+\s*\#\s*(?:end|elif|else)/ ||
 		      $line =~ /^\+[a-z_]*init/ ||
@@ -4449,6 +4634,7 @@ sub process {
 			#   XXX(foo);
 			#   EXPORT_SYMBOL(something_foo);
 			my $name = $1;
+			$name =~ s/^\s*($Ident).*/$1/;
 			if ($stat =~ /^(?:.\s*}\s*\n)?.([A-Z_]+)\s*\(\s*($Ident)/ &&
 			    $name =~ /^${Ident}_$2/) {
 #print "FOO C name<$name>\n";
@@ -4669,12 +4855,12 @@ sub process {
 			}
 		}
 
-# avoid BUG() or BUG_ON()
-		if ($line =~ /\b(?:BUG|BUG_ON)\b/) {
+# do not use BUG() or variants
+		if ($line =~ /\b(?!AA_|BUILD_|IDA_|KVM_|RWLOCK_|snd_|SPIN_)(?:[a-zA-Z_]*_)?BUG(?:_ON)?(?:_[A-Z_]+)?\s*\(/) {
 			my $msg_level = \&WARN;
 			$msg_level = \&CHK if ($file);
 			&{$msg_level}("AVOID_BUG",
-				      "Avoid crashing the kernel - try using WARN_ON & recovery code rather than BUG() or BUG_ON()\n" . $herecurr);
+				      "Do not crash the kernel unless it is absolutely unavoidable--use WARN_ON_ONCE() plus recovery code (if feasible) instead of BUG() or variants\n" . $herecurr);
 		}
 
 # avoid LINUX_VERSION_CODE
@@ -4895,7 +5081,7 @@ sub process {
 				if|for|while|switch|return|case|
 				volatile|__volatile__|
 				__attribute__|format|__extension__|
-				asm|__asm__)$/x)
+				asm|__asm__|scoped_guard)$/x)
 			{
 			# cpp #define statements have non-optional spaces, ie
 			# if there is a space between the name and the open
@@ -5356,9 +5542,9 @@ sub process {
 			}
 		}
 
-# check for unnecessary parentheses around comparisons in if uses
-# when !drivers/staging or command-line uses --strict
-		if (($realfile !~ m@^(?:drivers/staging/)@ || $check_orig) &&
+# check for unnecessary parentheses around comparisons
+# except in drivers/staging
+		if (($realfile !~ m@^(?:drivers/staging/)@) &&
 		    $perl_version_ok && defined($stat) &&
 		    $stat =~ /(^.\s*if\s*($balanced_parens))/) {
 			my $if_stat = $1;
@@ -5528,6 +5714,7 @@ sub process {
 		    defined($stat) && defined($cond) &&
 		    $line =~ /\b(?:if|while|for)\s*\(/ && $line !~ /^.\s*#/) {
 			my ($s, $c) = ($stat, $cond);
+			my $fixed_assign_in_if = 0;
 
 			if ($c =~ /\bif\s*\(.*[^<>!=]=[^=].*/s) {
 				if (ERROR("ASSIGN_IN_IF",
@@ -5552,6 +5739,7 @@ sub process {
 						$newline .= ')';
 						$newline .= " {" if (defined($brace));
 						fix_insert_line($fixlinenr + 1, $newline);
+						$fixed_assign_in_if = 1;
 					}
 				}
 			}
@@ -5575,8 +5763,20 @@ sub process {
 					$stat_real = "[...]\n$stat_real";
 				}
 
-				ERROR("TRAILING_STATEMENTS",
-				      "trailing statements should be on next line\n" . $herecurr . $stat_real);
+				if (ERROR("TRAILING_STATEMENTS",
+					  "trailing statements should be on next line\n" . $herecurr . $stat_real) &&
+				    !$fixed_assign_in_if &&
+				    $cond_lines == 0 &&
+				    $fix && $perl_version_ok &&
+				    $fixed[$fixlinenr] =~ /^\+(\s*)((?:if|while|for)\s*$balanced_parens)\s*(.*)$/) {
+					my $indent = $1;
+					my $test = $2;
+					my $rest = rtrim($4);
+					if ($rest =~ /;$/) {
+						$fixed[$fixlinenr] = "\+$indent$test";
+						fix_insert_line($fixlinenr + 1, "$indent\t$rest");
+					}
+				}
 			}
 		}
 
@@ -5674,16 +5874,20 @@ sub process {
 #CamelCase
 			if ($var !~ /^$Constant$/ &&
 			    $var =~ /[A-Z][a-z]|[a-z][A-Z]/ &&
+#Ignore C keywords
+			    $var !~ /^_Generic$/ &&
 #Ignore some autogenerated defines and enum values
 			    $var !~ /^(?:[A-Z]+_){1,5}[A-Z]{1,3}[a-z]/ &&
 #Ignore Page<foo> variants
 			    $var !~ /^(?:Clear|Set|TestClear|TestSet|)Page[A-Z]/ &&
+#Ignore ETHTOOL_LINK_MODE_<foo> variants
+			    $var !~ /^ETHTOOL_LINK_MODE_/ &&
 #Ignore SI style variants like nS, mV and dB
 #(ie: max_uV, regulator_min_uA_show, RANGE_mA_VALUE)
 			    $var !~ /^(?:[a-z0-9_]*|[A-Z0-9_]*)?_?[a-z][A-Z](?:_[a-z0-9_]+|_[A-Z0-9_]+)?$/ &&
 #Ignore some three character SI units explicitly, like MiB and KHz
 			    $var !~ /^(?:[a-z_]*?)_?(?:[KMGT]iB|[KMGT]?Hz)(?:_[a-z_]+)?$/) {
-				while ($var =~ m{($Ident)}g) {
+				while ($var =~ m{\b($Ident)}g) {
 					my $word = $1;
 					next if ($word !~ /[A-Z][a-z]|[a-z][A-Z]/);
 					if ($check) {
@@ -5733,9 +5937,9 @@ sub process {
 			}
 		}
 
-# multi-statement macros should be enclosed in a do while loop, grab the
-# first statement and ensure its the whole macro if its not enclosed
-# in a known good container
+# Usually multi-statement macros should be enclosed in a do {} while
+# (0) loop.  Grab the first statement and ensure its the whole macro
+# if its not enclosed in a known good container
 		if ($realfile !~ m@/vmlinux.lds.h$@ &&
 		    $line =~ /^.\s*\#\s*define\s*$Ident(\()?/) {
 			my $ln = $linenr;
@@ -5788,10 +5992,13 @@ sub process {
 
 			my $exceptions = qr{
 				$Declare|
+				# named exceptions
 				module_param_named|
 				MODULE_PARM_DESC|
 				DECLARE_PER_CPU|
 				DEFINE_PER_CPU|
+				static_assert|
+				# declaration primitives
 				__typeof__\(|
 				union|
 				struct|
@@ -5813,6 +6020,7 @@ sub process {
 			    $dstat !~ /$exceptions/ &&
 			    $dstat !~ /^\.$Ident\s*=/ &&				# .foo =
 			    $dstat !~ /^(?:\#\s*$Ident|\#\s*$Constant)\s*$/ &&		# stringification #foo
+			    $dstat !~ /^case\b/ &&					# case ...
 			    $dstat !~ /^do\s*$Constant\s*while\s*$Constant;?$/ &&	# do {...} while (...); // do {...} while (...)
 			    $dstat !~ /^while\s*$Constant\s*$Constant\s*$/ &&		# while (...) {...}
 			    $dstat !~ /^for\s*$Constant$/ &&				# for (...)
@@ -5825,11 +6033,11 @@ sub process {
 					ERROR("MULTISTATEMENT_MACRO_USE_DO_WHILE",
 					      "Macros starting with if should be enclosed by a do - while loop to avoid possible if/else logic defects\n" . "$herectx");
 				} elsif ($dstat =~ /;/) {
-					ERROR("MULTISTATEMENT_MACRO_USE_DO_WHILE",
-					      "Macros with multiple statements should be enclosed in a do - while loop\n" . "$herectx");
+					WARN("MULTISTATEMENT_MACRO_USE_DO_WHILE",
+					      "Non-declarative macros with multiple statements should be enclosed in a do - while loop\n" . "$herectx\nBUT SEE:\n$DO_WHILE_0_ADVICE");
 				} else {
 					ERROR("COMPLEX_MACRO",
-					      "Macros with complex values should be enclosed in parentheses\n" . "$herectx");
+					      "Macros with complex values should be enclosed in parentheses\n" . "$herectx\nBUT SEE:\n$DO_WHILE_0_ADVICE");
 				}
 
 			}
@@ -5871,6 +6079,12 @@ sub process {
 					CHK("MACRO_ARG_PRECEDENCE",
 					    "Macro argument '$arg' may be better as '($arg)' to avoid precedence issues\n" . "$herectx");
 				}
+
+# check if this is an unused argument
+				if ($define_stmt !~ /\b$arg\b/ && $define_stmt) {
+					WARN("MACRO_ARG_UNUSED",
+					     "Argument '$arg' is not used in function-like macro\n" . "$herectx");
+				}
 			}
 
 # check for macros with flow control, but without ## concatenation
@@ -5885,6 +6099,9 @@ sub process {
 
 # check for line continuations outside of #defines, preprocessor #, and asm
 
+		} elsif ($realfile =~ m@/vmlinux.lds.h$@) {
+		    $line =~ s/(\w+)/$maybe_linker_symbol{$1}++/ge;
+		    #print "REAL: $realfile\nln: $line\nkeys:", sort keys %maybe_linker_symbol;
 		} else {
 			if ($prevline !~ /^..*\\$/ &&
 			    $line !~ /^\+\s*\#.*\\$/ &&		# preprocessor
@@ -6411,11 +6628,11 @@ sub process {
 			# ignore udelay's < 10, however
 			if (! ($delay < 10) ) {
 				CHK("USLEEP_RANGE",
-				    "usleep_range is preferred over udelay; see Documentation/timers/timers-howto.rst\n" . $herecurr);
+				    "usleep_range is preferred over udelay; see function description of usleep_range() and udelay().\n" . $herecurr);
 			}
 			if ($delay > 2000) {
 				WARN("LONG_UDELAY",
-				     "long udelay - prefer mdelay; see arch/arm/include/asm/delay.h\n" . $herecurr);
+				     "long udelay - prefer mdelay; see function description of mdelay().\n" . $herecurr);
 			}
 		}
 
@@ -6423,7 +6640,7 @@ sub process {
 		if ($line =~ /\bmsleep\s*\((\d+)\);/) {
 			if ($1 < 20) {
 				WARN("MSLEEP",
-				     "msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.rst\n" . $herecurr);
+				     "msleep < 20ms can sleep for up to 20ms; see function description of msleep().\n" . $herecurr);
 			}
 		}
 
@@ -6731,7 +6948,7 @@ sub process {
 					    ($extension eq "f" &&
 					     defined $qualifier && $qualifier !~ /^w/) ||
 					    ($extension eq "4" &&
-					     defined $qualifier && $qualifier !~ /^cc/)) {
+					     defined $qualifier && $qualifier !~ /^c(?:[hlbc]|hR)$/)) {
 						$bad_specifier = $specifier;
 						last;
 					}
@@ -6745,15 +6962,19 @@ sub process {
 				}
 				if ($bad_specifier ne "") {
 					my $stat_real = get_stat_real($linenr, $lc);
+					my $msg_level = \&WARN;
 					my $ext_type = "Invalid";
 					my $use = "";
 					if ($bad_specifier =~ /p[Ff]/) {
 						$use = " - use %pS instead";
 						$use =~ s/pS/ps/ if ($bad_specifier =~ /pf/);
+					} elsif ($bad_specifier =~ /pA/) {
+						$use =  " - '%pA' is only intended to be used from Rust code";
+						$msg_level = \&ERROR;
 					}
 
-					WARN("VSPRINTF_POINTER_EXTENSION",
-					     "$ext_type vsprintf pointer extension '$bad_specifier'$use\n" . "$here\n$stat_real\n");
+					&{$msg_level}("VSPRINTF_POINTER_EXTENSION",
+						      "$ext_type vsprintf pointer extension '$bad_specifier'$use\n" . "$here\n$stat_real\n");
 				}
 			}
 		}
@@ -6817,13 +7038,43 @@ sub process {
 #				}
 #			}
 #		}
+# strcpy uses that should likely be strscpy
+		if ($line =~ /\bstrcpy\s*\(/ && !is_userspace($realfile)) {
+			WARN("STRCPY",
+			     "Prefer strscpy over strcpy - see: https://github.com/KSPP/linux/issues/88\n" . $herecurr);
+		}
 
 # strlcpy uses that should likely be strscpy
-		if ($line =~ /\bstrlcpy\s*\(/) {
+		if ($line =~ /\bstrlcpy\s*\(/ && !is_userspace($realfile)) {
 			WARN("STRLCPY",
-			     "Prefer strscpy over strlcpy - see: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw\@mail.gmail.com/\n" . $herecurr);
+			     "Prefer strscpy over strlcpy - see: https://github.com/KSPP/linux/issues/89\n" . $herecurr);
+		}
+
+# strncpy uses that should likely be strscpy or strscpy_pad
+		if ($line =~ /\bstrncpy\s*\(/ && !is_userspace($realfile)) {
+			WARN("STRNCPY",
+			     "Prefer strscpy, strscpy_pad, or __nonstring over strncpy - see: https://github.com/KSPP/linux/issues/90\n" . $herecurr);
+		}
+
+# ethtool_sprintf uses that should likely be ethtool_puts
+		if ($line =~ /\bethtool_sprintf\s*\(\s*$FuncArg\s*,\s*$FuncArg\s*\)/) {
+			if (WARN("PREFER_ETHTOOL_PUTS",
+				 "Prefer ethtool_puts over ethtool_sprintf with only two arguments\n" . $herecurr) &&
+			    $fix) {
+				$fixed[$fixlinenr] =~ s/\bethtool_sprintf\s*\(\s*($FuncArg)\s*,\s*($FuncArg)/ethtool_puts($1, $7)/;
+			}
+		}
+
+		# use $rawline because $line loses %s via sanitization and thus we can't match against it.
+		if ($rawline =~ /\bethtool_sprintf\s*\(\s*$FuncArg\s*,\s*\"\%s\"\s*,\s*$FuncArg\s*\)/) {
+			if (WARN("PREFER_ETHTOOL_PUTS",
+				 "Prefer ethtool_puts over ethtool_sprintf with standalone \"%s\" specifier\n" . $herecurr) &&
+			    $fix) {
+				$fixed[$fixlinenr] =~ s/\bethtool_sprintf\s*\(\s*($FuncArg)\s*,\s*"\%s"\s*,\s*($FuncArg)/ethtool_puts($1, $7)/;
+			}
 		}
 
+
 # typecasts on min/max could be min_t/max_t
 		if ($perl_version_ok &&
 		    defined $stat &&
@@ -6856,11 +7107,11 @@ sub process {
 			my $max = $7;
 			if ($min eq $max) {
 				WARN("USLEEP_RANGE",
-				     "usleep_range should not use min == max args; see Documentation/timers/timers-howto.rst\n" . "$here\n$stat\n");
+				     "usleep_range should not use min == max args;  see function description of usleep_range().\n" . "$here\n$stat\n");
 			} elsif ($min =~ /^\d+$/ && $max =~ /^\d+$/ &&
 				 $min > $max) {
 				WARN("USLEEP_RANGE",
-				     "usleep_range args reversed, use min then max; see Documentation/timers/timers-howto.rst\n" . "$here\n$stat\n");
+				     "usleep_range args reversed, use min then max;  see function description of usleep_range().\n" . "$here\n$stat\n");
 			}
 		}
 
@@ -6928,6 +7179,21 @@ sub process {
 				     "arguments for function declarations should follow identifier\n" . $herecurr);
 			}
 
+		} elsif ($realfile =~ /\.c$/ && defined $stat &&
+		    $stat =~ /^\+extern struct\s+(\w+)\s+(\w+)\[\];/)
+		{
+			my ($st_type, $st_name) = ($1, $2);
+
+			for my $s (keys %maybe_linker_symbol) {
+			    #print "Linker symbol? $st_name : $s\n";
+			    goto LIKELY_LINKER_SYMBOL
+				if $st_name =~ /$s/;
+			}
+			WARN("AVOID_EXTERNS",
+			     "found a file-scoped extern type:$st_type name:$st_name in .c file\n"
+			     . "is this a linker symbol ?\n" . $herecurr);
+		  LIKELY_LINKER_SYMBOL:
+
 		} elsif ($realfile =~ /\.c$/ && defined $stat &&
 		    $stat =~ /^.\s*extern\s+/)
 		{
@@ -6996,14 +7262,16 @@ sub process {
 			    "Prefer $3(sizeof(*$1)...) over $3($4...)\n" . $herecurr);
 		}
 
-# check for k[mz]alloc with multiplies that could be kmalloc_array/kcalloc
+# check for (kv|k)[mz]alloc with multiplies that could be kmalloc_array/kvmalloc_array/kvcalloc/kcalloc
 		if ($perl_version_ok &&
 		    defined $stat &&
-		    $stat =~ /^\+\s*($Lval)\s*\=\s*(?:$balanced_parens)?\s*(k[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)\s*,/) {
+		    $stat =~ /^\+\s*($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)\s*,/) {
 			my $oldfunc = $3;
 			my $a1 = $4;
 			my $a2 = $10;
 			my $newfunc = "kmalloc_array";
+			$newfunc = "kvmalloc_array" if ($oldfunc eq "kvmalloc");
+			$newfunc = "kvcalloc" if ($oldfunc eq "kvzalloc");
 			$newfunc = "kcalloc" if ($oldfunc eq "kzalloc");
 			my $r1 = $a1;
 			my $r2 = $a2;
@@ -7020,7 +7288,7 @@ sub process {
 					 "Prefer $newfunc over $oldfunc with multiply\n" . $herectx) &&
 				    $cnt == 1 &&
 				    $fix) {
-					$fixed[$fixlinenr] =~ s/\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*(k[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/$1 . ' = ' . "$newfunc(" . trim($r1) . ', ' . trim($r2)/e;
+					$fixed[$fixlinenr] =~ s/\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/$1 . ' = ' . "$newfunc(" . trim($r1) . ', ' . trim($r2)/e;
 				}
 			}
 		}
@@ -7034,7 +7302,7 @@ sub process {
 		}
 
 # check for alloc argument mismatch
-		if ($line =~ /\b((?:devm_)?(?:kcalloc|kmalloc_array))\s*\(\s*sizeof\b/) {
+		if ($line =~ /\b((?:devm_)?((?:k|kv)?(calloc|malloc_array)(?:_node)?))\s*\(\s*sizeof\b/) {
 			WARN("ALLOC_ARRAY_ARGS",
 			     "$1 uses number as first arg, sizeof is generally wrong\n" . $herecurr);
 		}
@@ -7237,6 +7505,16 @@ sub process {
 			}
 		}
 
+# check for array definition/declarations that should use flexible arrays instead
+		if ($sline =~ /^[\+ ]\s*\}(?:\s*__packed)?\s*;\s*$/ &&
+		    $prevline =~ /^\+\s*(?:\}(?:\s*__packed\s*)?|$Type)\s*$Ident\s*\[\s*(0|1)\s*\]\s*;\s*$/) {
+			if (ERROR("FLEXIBLE_ARRAY",
+				  "Use C99 flexible arrays - see https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays\n" . $hereprev) &&
+			    $1 == '0' && $fix) {
+				$fixed[$fixlinenr - 1] =~ s/\[\s*0\s*\]/[]/;
+			}
+		}
+
 # nested likely/unlikely calls
 		if ($line =~ /\b(?:(?:un)?likely)\s*\(\s*!?\s*(IS_ERR(?:_OR_NULL|_VALUE)?|WARN)/) {
 			WARN("LIKELY_MISUSE",
@@ -7254,6 +7532,30 @@ sub process {
 			}
 		}
 
+# Complain about RCU Tasks Trace used outside of BPF (and of course, RCU).
+		our $rcu_trace_funcs = qr{(?x:
+			rcu_read_lock_trace |
+			rcu_read_lock_trace_held |
+			rcu_read_unlock_trace |
+			call_rcu_tasks_trace |
+			synchronize_rcu_tasks_trace |
+			rcu_barrier_tasks_trace |
+			rcu_request_urgent_qs_task
+		)};
+		our $rcu_trace_paths = qr{(?x:
+			kernel/bpf/ |
+			include/linux/bpf |
+			net/bpf/ |
+			kernel/rcu/ |
+			include/linux/rcu
+		)};
+		if ($line =~ /\b($rcu_trace_funcs)\s*\(/) {
+			if ($realfile !~ m{^$rcu_trace_paths}) {
+				WARN("RCU_TASKS_TRACE",
+				     "use of RCU tasks trace is incorrect outside BPF or core RCU code\n" . $herecurr);
+			}
+		}
+
 # check for lockdep_set_novalidate_class
 		if ($line =~ /^.\s*lockdep_set_novalidate_class\s*\(/ ||
 		    $line =~ /__lockdep_no_validate__\s*\)/ ) {
@@ -7395,6 +7697,13 @@ sub process {
 				WARN("MODULE_LICENSE",
 				     "unknown module license " . $extracted_string . "\n" . $herecurr);
 			}
+			if (!$file && $extracted_string eq '"GPL v2"') {
+				if (WARN("MODULE_LICENSE",
+				     "Prefer \"GPL\" over \"GPL v2\" - see commit bf7fbeeae6db (\"module: Cure the MODULE_LICENSE \"GPL\" vs. \"GPL v2\" bogosity\")\n" . $herecurr) &&
+				    $fix) {
+					$fixed[$fixlinenr] =~ s/\bMODULE_LICENSE\s*\(\s*"GPL v2"\s*\)/MODULE_LICENSE("GPL")/;
+				}
+			}
 		}
 
 # check for sysctl duplicate constants
@@ -7402,6 +7711,37 @@ sub process {
 			WARN("DUPLICATED_SYSCTL_CONST",
 				"duplicated sysctl range checking value '$1', consider using the shared one in include/linux/sysctl.h\n" . $herecurr);
 		}
+
+# Check that *_device_id tables have sentinel entries.
+		if (defined $stat && $line =~ /struct\s+$dev_id_types\s+\w+\s*\[\s*\]\s*=\s*\{/) {
+			my $stripped = $stat;
+
+			# Strip diff line prefixes.
+			$stripped =~ s/(^|\n)./$1/g;
+			# Line continuations.
+			$stripped =~ s/\\\n/\n/g;
+			# Strip whitespace, empty strings, zeroes, and commas.
+			$stripped =~ s/""//g;
+			$stripped =~ s/0x0//g;
+			$stripped =~ s/[\s$;,0]//g;
+			# Strip field assignments.
+			$stripped =~ s/\.$Ident=//g;
+
+			if (!(substr($stripped, -4) eq "{}};" ||
+			      substr($stripped, -6) eq "{{}}};" ||
+			      $stripped =~ /ISAPNP_DEVICE_SINGLE_END}};$/ ||
+			      $stripped =~ /ISAPNP_CARD_END}};$/ ||
+			      $stripped =~ /NULL};$/ ||
+			      $stripped =~ /PCMCIA_DEVICE_NULL};$/)) {
+				ERROR("MISSING_SENTINEL", "missing sentinel in ID array\n" . "$here\n$stat\n");
+			}
+		}
+
+# check for uninitialized pointers with __free attribute
+		while ($line =~ /\*\s*($Ident)\s+__free\s*\(\s*$Ident\s*\)\s*[,;]/g) {
+			ERROR("UNINITIALIZED_PTR_WITH_FREE",
+			      "pointer '$1' with __free attribute should be initialized\n" . $herecurr);
+		}
 	}
 
 	# If we have no input at all, then there is nothing to report on
@@ -7426,6 +7766,12 @@ sub process {
 		ERROR("NOT_UNIFIED_DIFF",
 		      "Does not appear to be a unified-diff format patch\n");
 	}
+	if ($is_patch && $has_commit_log && $chk_fixes_tag) {
+		if ($needs_fixes_tag ne "" && !$is_revert && !$fixes_tag) {
+			WARN("MISSING_FIXES_TAG",
+				 "The commit message has '$needs_fixes_tag', perhaps it also needs a 'Fixes:' tag?\n");
+		}
+	}
 	if ($is_patch && $has_commit_log && $chk_signoff) {
 		if ($signoff == 0) {
 			ERROR("MISSING_SIGN_OFF",
diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index 17fdc620d5..1e89b92c2f 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -23,8 +23,10 @@ absoulte||absolute
 acccess||access
 acceess||access
 accelaration||acceleration
+accelearion||acceleration
 acceleratoin||acceleration
 accelleration||acceleration
+accelrometer||accelerometer
 accesing||accessing
 accesnt||accent
 accessable||accessible
@@ -58,11 +60,13 @@ acording||according
 activete||activate
 actived||activated
 actualy||actually
+actvie||active
 acumulating||accumulating
 acumulative||accumulative
 acumulator||accumulator
 acutally||actually
 adapater||adapter
+adderted||asserted
 addional||additional
 additionaly||additionally
 additonal||additional
@@ -120,6 +124,7 @@ alue||value
 ambigious||ambiguous
 ambigous||ambiguous
 amoung||among
+amount of times||number of times
 amout||amount
 amplifer||amplifier
 amplifyer||amplifier
@@ -133,8 +138,10 @@ anniversery||anniversary
 annoucement||announcement
 anomolies||anomalies
 anomoly||anomaly
+anonynous||anonymous
 anway||anyway
 aplication||application
+apeared||appeared
 appearence||appearance
 applicaion||application
 appliction||application
@@ -149,8 +156,10 @@ apropriate||appropriate
 aquainted||acquainted
 aquired||acquired
 aquisition||acquisition
+aquires||acquires
 arbitary||arbitrary
 architechture||architecture
+archtecture||architecture
 arguement||argument
 arguements||arguments
 arithmatic||arithmetic
@@ -169,16 +178,22 @@ assigment||assignment
 assigments||assignments
 assistent||assistant
 assocaited||associated
+assocated||associated
 assocating||associating
 assocation||association
+assocative||associative
 associcated||associated
 assotiated||associated
 asssert||assert
 assum||assume
 assumtpion||assumption
+asume||assume
 asuming||assuming
 asycronous||asynchronous
+asychronous||asynchronous
 asynchnous||asynchronous
+asynchrnous||asynchronous
+asynchronus||asynchronous
 asynchromous||asynchronous
 asymetric||asymmetric
 asymmeric||asymmetric
@@ -207,6 +222,7 @@ autonymous||autonomous
 auxillary||auxiliary
 auxilliary||auxiliary
 avaiable||available
+avaialable||available
 avaible||available
 availabe||available
 availabled||available
@@ -230,6 +246,7 @@ baloons||balloons
 bandwith||bandwidth
 banlance||balance
 batery||battery
+battey||battery
 beacuse||because
 becasue||because
 becomming||becoming
@@ -241,6 +258,7 @@ beter||better
 betweeen||between
 bianries||binaries
 bitmast||bitmask
+bitwiedh||bitwidth
 boardcast||broadcast
 borad||board
 boundry||boundary
@@ -249,14 +267,18 @@ brigde||bridge
 broadcase||broadcast
 broadcat||broadcast
 bufer||buffer
+bufferred||buffered
+bufferur||buffer
 bufufer||buffer
 cacluated||calculated
 caculate||calculate
 caculation||calculation
 cadidate||candidate
 cahces||caches
+calcluate||calculate
 calender||calendar
 calescing||coalescing
+calibraiton||calibration
 calle||called
 callibration||calibration
 callled||called
@@ -265,7 +287,12 @@ calucate||calculate
 calulate||calculate
 cancelation||cancellation
 cancle||cancel
+cant||can't
+cant'||can't
 canot||cannot
+cann't||can't
+cannnot||cannot
+capabiity||capability
 capabilites||capabilities
 capabilties||capabilities
 capabilty||capability
@@ -273,9 +300,11 @@ capabitilies||capabilities
 capablity||capability
 capatibilities||capabilities
 capapbilities||capabilities
+captuer||capture
 caputure||capture
 carefuly||carefully
 cariage||carriage
+casued||caused
 catagory||category
 cehck||check
 challange||challenge
@@ -302,12 +331,14 @@ chiled||child
 chked||checked
 chnage||change
 chnages||changes
+chnange||change
 chnnel||channel
 choosen||chosen
 chouse||chose
 circumvernt||circumvent
 claread||cleared
 clared||cleared
+clearify||clarify
 closeing||closing
 clustred||clustered
 cnfiguration||configuration
@@ -323,11 +354,13 @@ comminucation||communication
 commited||committed
 commiting||committing
 committ||commit
+commmand||command
 commnunication||communication
 commoditiy||commodity
 comsume||consume
 comsumer||consumer
 comsuming||consuming
+comaptible||compatible
 compability||compatibility
 compaibility||compatibility
 comparsion||comparison
@@ -348,15 +381,20 @@ compoment||component
 comppatible||compatible
 compres||compress
 compresion||compression
+compresser||compressor
 comression||compression
+comsumed||consumed
 comunicate||communicate
 comunication||communication
 conbination||combination
+concurent||concurrent
 conditionaly||conditionally
 conditon||condition
 condtion||condition
+condtional||conditional
 conected||connected
 conector||connector
+configed||configured
 configration||configuration
 configred||configured
 configuartion||configuration
@@ -366,8 +404,10 @@ configuratoin||configuration
 configuraton||configuration
 configuretion||configuration
 configutation||configuration
+congiuration||configuration
 conider||consider
 conjuction||conjunction
+connction||connection
 connecetd||connected
 connectinos||connections
 connetor||connector
@@ -375,6 +415,8 @@ connnection||connection
 connnections||connections
 consistancy||consistency
 consistant||consistent
+consits||consists
+constructred||constructed
 containes||contains
 containts||contains
 contaisn||contains
@@ -385,6 +427,7 @@ continious||continuous
 continous||continuous
 continously||continuously
 continueing||continuing
+contiuous||continuous
 contraints||constraints
 contruct||construct
 contol||control
@@ -407,8 +450,11 @@ cotrol||control
 cound||could
 couter||counter
 coutner||counter
+creationg||creating
 cryptocraphic||cryptographic
+cummulative||cumulative
 cunter||counter
+curent||current
 curently||currently
 cylic||cyclic
 dafault||default
@@ -420,7 +466,9 @@ decendant||descendant
 decendants||descendants
 decompres||decompress
 decsribed||described
+decrese||decrease
 decription||description
+detault||default
 dectected||detected
 defailt||default
 deferal||deferral
@@ -429,6 +477,7 @@ defferred||deferred
 definate||definite
 definately||definitely
 definiation||definition
+definiton||definition
 defintion||definition
 defintions||definitions
 defualt||default
@@ -442,6 +491,8 @@ delare||declare
 delares||declares
 delaring||declaring
 delemiter||delimiter
+deley||delay
+delibrately||deliberately
 delievered||delivered
 demodualtor||demodulator
 demension||dimension
@@ -454,6 +505,7 @@ depreacte||deprecate
 desactivate||deactivate
 desciptor||descriptor
 desciptors||descriptors
+descritpor||descriptor
 descripto||descriptor
 descripton||description
 descrition||description
@@ -470,7 +522,9 @@ destorys||destroys
 destroied||destroyed
 detabase||database
 deteced||detected
+detecion||detection
 detectt||detect
+detroyed||destroyed
 develope||develop
 developement||development
 developped||developed
@@ -490,6 +544,7 @@ diferent||different
 differrence||difference
 diffrent||different
 differenciate||differentiate
+diffreential||differential
 diffrentiate||differentiate
 difinition||definition
 digial||digital
@@ -497,16 +552,20 @@ dimention||dimension
 dimesions||dimensions
 diconnected||disconnected
 disabed||disabled
+disasembler||disassembler
 disble||disable
 disgest||digest
 disired||desired
 dispalying||displaying
+dissable||disable
+dissapeared||disappeared
 diplay||display
 directon||direction
 direcly||directly
 direectly||directly
 diregard||disregard
 disassocation||disassociation
+disassocative||disassociative
 disapear||disappear
 disapeared||disappeared
 disappared||disappeared
@@ -524,6 +583,7 @@ dissconect||disconnect
 distiction||distinction
 divisable||divisible
 divsiors||divisors
+dsiabled||disabled
 docuentation||documentation
 documantation||documentation
 documentaion||documentation
@@ -554,6 +614,7 @@ eigth||eight
 elementry||elementary
 eletronic||electronic
 embeded||embedded
+emtpy||empty
 enabledi||enabled
 enbale||enable
 enble||enable
@@ -561,6 +622,7 @@ enchanced||enhanced
 encorporating||incorporating
 encrupted||encrypted
 encrypiton||encryption
+encryped||encrypted
 encryptio||encryption
 endianess||endianness
 enpoint||endpoint
@@ -590,11 +652,14 @@ etsbalishment||establishment
 evalute||evaluate
 evalutes||evaluates
 evalution||evaluation
+evaulated||evaluated
 excecutable||executable
+excceed||exceed
 exceded||exceeded
 exceds||exceeds
 exceeed||exceed
 excellant||excellent
+exchnage||exchange
 execeeded||exceeded
 execeeds||exceeds
 exeed||exceed
@@ -603,17 +668,23 @@ exeuction||execution
 existance||existence
 existant||existent
 exixt||exist
+exsits||exists
 exlcude||exclude
+exlcuding||excluding
 exlcusive||exclusive
+exlusive||exclusive
+exlicitly||explicitly
 exmaple||example
 expecially||especially
 experies||expires
 explicite||explicit
+explicity||explicitly
 explicitely||explicitly
 explict||explicit
 explictely||explicitly
 explictly||explicitly
 expresion||expression
+exprienced||experienced
 exprimental||experimental
 extened||extended
 exteneded||extended
@@ -642,27 +713,32 @@ feauture||feature
 feautures||features
 fetaure||feature
 fetaures||features
+fetcing||fetching
 fileystem||filesystem
 fimrware||firmware
 fimware||firmware
 firmare||firmware
 firmaware||firmware
+firtly||firstly
 firware||firmware
 firwmare||firmware
 finanize||finalize
 findn||find
 finilizes||finalizes
 finsih||finish
+fliter||filter
 flusing||flushing
 folloing||following
 followign||following
 followings||following
 follwing||following
 fonud||found
+forcebly||forcibly
 forseeable||foreseeable
 forse||force
 fortan||fortran
 forwardig||forwarding
+forwared||forwarded
 frambuffer||framebuffer
 framming||framing
 framwork||framework
@@ -670,6 +746,7 @@ frequence||frequency
 frequncy||frequency
 frequancy||frequency
 frome||from
+fronend||frontend
 fucntion||function
 fuction||function
 fuctions||functions
@@ -693,6 +770,8 @@ generiously||generously
 genereate||generate
 genereted||generated
 genric||generic
+gerenal||general
+geting||getting
 globel||global
 grabing||grabbing
 grahical||graphical
@@ -700,6 +779,7 @@ grahpical||graphical
 granularty||granularity
 grapic||graphic
 grranted||granted
+grups||groups
 guage||gauge
 guarenteed||guaranteed
 guarentee||guarantee
@@ -711,21 +791,27 @@ hanled||handled
 happend||happened
 hardare||hardware
 harware||hardware
+hardward||hardware
 havind||having
+heigth||height
 heirarchically||hierarchically
 heirarchy||hierarchy
+heirachy||hierarchy
 helpfull||helpful
 hearbeat||heartbeat
 heterogenous||heterogeneous
 hexdecimal||hexadecimal
 hybernate||hibernate
+hiearchy||hierarchy
 hierachy||hierarchy
 hierarchie||hierarchy
 homogenous||homogeneous
+horizental||horizontal
 howver||however
 hsould||should
 hypervior||hypervisor
 hypter||hyper
+idel||idle
 identidier||identifier
 iligal||illegal
 illigal||illegal
@@ -754,6 +840,7 @@ implmentation||implementation
 implmenting||implementing
 incative||inactive
 incomming||incoming
+incompaitiblity||incompatibility
 incompatabilities||incompatibilities
 incompatable||incompatible
 incompatble||incompatible
@@ -771,6 +858,7 @@ independed||independent
 indiate||indicate
 indicat||indicate
 inexpect||inexpected
+infalte||inflate
 inferface||interface
 infinit||infinite
 infomation||information
@@ -779,6 +867,7 @@ informations||information
 informtion||information
 infromation||information
 ingore||ignore
+inheritence||inheritance
 inital||initial
 initalized||initialized
 initalised||initialized
@@ -789,6 +878,7 @@ initators||initiators
 initialiazation||initialization
 initializationg||initialization
 initializiation||initialization
+initializtion||initialization
 initialze||initialize
 initialzed||initialized
 initialzing||initializing
@@ -805,12 +895,14 @@ instanciate||instantiate
 instanciated||instantiated
 instuments||instruments
 insufficent||insufficient
+intead||instead
 inteface||interface
 integreated||integrated
 integrety||integrity
 integrey||integrity
 intendet||intended
 intented||intended
+interal||internal
 interanl||internal
 interchangable||interchangeable
 interferring||interfering
@@ -822,6 +914,7 @@ interoprability||interoperability
 interuupt||interrupt
 interupt||interrupt
 interupts||interrupts
+interurpt||interrupt
 interrface||interface
 interrrupt||interrupt
 interrup||interrupt
@@ -862,12 +955,14 @@ iteraions||iterations
 iternations||iterations
 itertation||iteration
 itslef||itself
+ivalid||invalid
 jave||java
 jeffies||jiffies
 jumpimng||jumping
 juse||just
 jus||just
 kown||known
+lable||label
 langage||language
 langauage||language
 langauge||language
@@ -916,9 +1011,11 @@ matchs||matches
 mathimatical||mathematical
 mathimatic||mathematic
 mathimatics||mathematics
+maxmium||maximum
 maximium||maximum
 maxium||maximum
 mechamism||mechanism
+mechanim||mechanism
 meetign||meeting
 memeory||memory
 memmber||member
@@ -927,6 +1024,7 @@ memroy||memory
 ment||meant
 mergable||mergeable
 mesage||message
+mesages||messages
 messags||messages
 messgaes||messages
 messsage||message
@@ -935,9 +1033,13 @@ metdata||metadata
 micropone||microphone
 microprocesspr||microprocessor
 migrateable||migratable
+miliseconds||milliseconds
+millenium||millennium
 milliseonds||milliseconds
+minimim||minimum
 minium||minimum
 minimam||minimum
+minimun||minimum
 miniumum||minimum
 minumum||minimum
 misalinged||misaligned
@@ -956,6 +1058,7 @@ mmnemonic||mnemonic
 mnay||many
 modfiy||modify
 modifer||modifier
+modul||module
 modulues||modules
 momery||memory
 memomry||memory
@@ -965,8 +1068,9 @@ monochromo||monochrome
 monocrome||monochrome
 mopdule||module
 mroe||more
-multipler||multiplier
 mulitplied||multiplied
+muliple||multiple
+multipler||multiplier
 multidimensionnal||multidimensional
 multipe||multiple
 multple||multiple
@@ -989,15 +1093,20 @@ negotation||negotiation
 nerver||never
 nescessary||necessary
 nessessary||necessary
+none existent||non-existent
 noticable||noticeable
 notication||notification
 notications||notifications
 notifcations||notifications
 notifed||notified
+notifer||notifier
 notity||notify
+notfify||notify
 nubmer||number
 numebr||number
+numer||number
 numner||number
+nunber||number
 obtaion||obtain
 obusing||abusing
 occassionally||occasionally
@@ -1009,17 +1118,20 @@ occured||occurred
 occurence||occurrence
 occure||occurred
 occuring||occurring
+ocurrence||occurrence
 offser||offset
 offet||offset
 offlaod||offload
 offloded||offloaded
 offseting||offsetting
+oflload||offload
 omited||omitted
 omiting||omitting
 omitt||omit
 ommiting||omitting
 ommitted||omitted
 onself||oneself
+onthe||on the
 ony||only
 openning||opening
 operatione||operation
@@ -1031,12 +1143,14 @@ orientatied||orientated
 orientied||oriented
 orignal||original
 originial||original
+orphanded||orphaned
 otherise||otherwise
 ouput||output
 oustanding||outstanding
 overaall||overall
 overhread||overhead
 overlaping||overlapping
+oveflow||overflow
 overflw||overflow
 overlfow||overflow
 overide||override
@@ -1056,9 +1170,11 @@ pakage||package
 paket||packet
 pallette||palette
 paln||plan
+palne||plane
 paramameters||parameters
 paramaters||parameters
 paramater||parameter
+paramenters||parameters
 parametes||parameters
 parametised||parametrised
 paramter||parameter
@@ -1085,12 +1201,16 @@ perfomring||performing
 periperal||peripheral
 peripherial||peripheral
 permissons||permissions
+permited||permitted
 peroid||period
 persistance||persistence
 persistant||persistent
 phoneticly||phonetically
+pipline||pipeline
+plaform||platform
 plalform||platform
 platfoem||platform
+platfomr||platform
 platfrom||platform
 plattform||platform
 pleaes||please
@@ -1102,9 +1222,11 @@ poiter||pointer
 posible||possible
 positon||position
 possibilites||possibilities
+postion||position
 potocol||protocol
 powerfull||powerful
 pramater||parameter
+preambule||preamble
 preamle||preamble
 preample||preamble
 preapre||prepare
@@ -1113,11 +1235,14 @@ preceeding||preceding
 preceed||precede
 precendence||precedence
 precission||precision
+predicition||prediction
 preemptable||preemptible
 prefered||preferred
 prefferably||preferably
 prefitler||prefilter
 preform||perform
+previleged||privileged
+previlege||privilege
 premption||preemption
 prepaired||prepared
 prepate||prepare
@@ -1126,15 +1251,19 @@ preprare||prepare
 pressre||pressure
 presuambly||presumably
 previosuly||previously
+previsously||previously
 primative||primitive
 princliple||principle
 priorty||priority
+priting||printing
 privilaged||privileged
 privilage||privilege
 priviledge||privilege
+priviledged||privileged
 priviledges||privileges
 privleges||privileges
 probaly||probably
+probabalistic||probabilistic
 procceed||proceed
 proccesors||processors
 procesed||processed
@@ -1154,6 +1283,7 @@ programable||programmable
 programers||programmers
 programm||program
 programms||programs
+progres||progress
 progresss||progress
 prohibitted||prohibited
 prohibitting||prohibiting
@@ -1182,12 +1312,15 @@ purgable||purgeable
 pwoer||power
 queing||queuing
 quering||querying
+querrying||querying
 queus||queues
 randomally||randomly
 raoming||roaming
+readyness||readiness
 reasearcher||researcher
 reasearchers||researchers
 reasearch||research
+recalcualte||recalculate
 receieve||receive
 recepient||recipient
 recevied||received
@@ -1200,8 +1333,10 @@ recieves||receives
 recieving||receiving
 recogniced||recognised
 recognizeable||recognizable
+recompte||recompute
 recommanded||recommended
 recyle||recycle
+redect||reject
 redircet||redirect
 redirectrion||redirection
 redundacy||redundancy
@@ -1209,11 +1344,14 @@ reename||rename
 refcounf||refcount
 refence||reference
 refered||referred
+referencce||reference
 referenace||reference
+refererence||reference
 refering||referring
 refernces||references
 refernnce||reference
 refrence||reference
+regiser||register
 registed||registered
 registerd||registered
 registeration||registration
@@ -1233,17 +1371,21 @@ reloade||reload
 remoote||remote
 remore||remote
 removeable||removable
+repective||respective
 repectively||respectively
 replacable||replaceable
 replacments||replacements
 replys||replies
 reponse||response
 representaion||representation
+repsonse||response
+reqested||requested
 reqeust||request
 reqister||register
 requed||requeued
 requestied||requested
 requiere||require
+requieres||requires
 requirment||requirement
 requred||required
 requried||required
@@ -1254,6 +1396,8 @@ reseting||resetting
 reseved||reserved
 reseverd||reserved
 resizeable||resizable
+resonable||reasonable
+resotre||restore
 resouce||resource
 resouces||resources
 resoures||resources
@@ -1278,6 +1422,7 @@ reuest||request
 reuqest||request
 reutnred||returned
 revsion||revision
+rewritting||rewriting
 rmeoved||removed
 rmeove||remove
 rmeoves||removes
@@ -1286,11 +1431,14 @@ routins||routines
 rquest||request
 runing||running
 runned||ran
+runnnig||running
 runnning||running
 runtine||runtime
 sacrifying||sacrificing
 safly||safely
 safty||safety
+satify||satisfy
+satisifed||satisfied
 savable||saveable
 scaleing||scaling
 scaned||scanned
@@ -1325,9 +1473,11 @@ sequencial||sequential
 serivce||service
 serveral||several
 servive||service
+sesion||session
 setts||sets
 settting||setting
 shapshot||snapshot
+shoft||shift
 shotdown||shutdown
 shoud||should
 shouldnt||shouldn't
@@ -1341,17 +1491,22 @@ similiar||similar
 simlar||similar
 simliar||similar
 simpified||simplified
+simultaneusly||simultaneously
+simultanous||simultaneous
 singaled||signaled
 singal||signal
 singed||signed
+slect||select
 sleeped||slept
 sliped||slipped
 softwade||software
 softwares||software
 soley||solely
+soluation||solution
 souce||source
 speach||speech
 specfic||specific
+specfication||specification
 specfield||specified
 speciefied||specified
 specifc||specific
@@ -1380,6 +1535,7 @@ standart||standard
 standy||standby
 stardard||standard
 staticly||statically
+statisitcs||statistics
 statuss||status
 stoped||stopped
 stoping||stopping
@@ -1398,6 +1554,7 @@ submited||submitted
 submition||submission
 succeded||succeeded
 suceed||succeed
+succesfuly||successfully
 succesfully||successfully
 succesful||successful
 successed||succeeded
@@ -1413,6 +1570,7 @@ suported||supported
 suport||support
 supportet||supported
 suppored||supported
+supporing||supporting
 supportin||supporting
 suppoted||supported
 suppported||supported
@@ -1439,6 +1597,8 @@ syfs||sysfs
 symetric||symmetric
 synax||syntax
 synchonized||synchronized
+sychronization||synchronization
+sychronously||synchronously
 synchronuously||synchronously
 syncronize||synchronize
 syncronized||synchronized
@@ -1447,35 +1607,45 @@ syncronus||synchronous
 syste||system
 sytem||system
 sythesis||synthesis
+tagert||target
 taht||that
+tained||tainted
+tarffic||traffic
 tansmit||transmit
 targetted||targeted
 targetting||targeting
 taskelt||tasklet
 teh||the
+temeprature||temperature
 temorary||temporary
 temproarily||temporarily
 temperture||temperature
-thead||thread
+theads||threads
 therfore||therefore
 thier||their
 threds||threads
 threee||three
 threshhold||threshold
 thresold||threshold
+throtting||throttling
 throught||through
+tansition||transition
 trackling||tracking
 troughput||throughput
 trys||tries
 thses||these
 tiggers||triggers
 tiggered||triggered
+tiggerring||triggering
 tipically||typically
 timeing||timing
+timming||timing
 timout||timeout
 tmis||this
+tolarance||tolerance
 toogle||toggle
 torerable||tolerable
+torlence||tolerance
 traget||target
 traking||tracking
 tramsmitted||transmitted
@@ -1484,17 +1654,22 @@ tranasction||transaction
 tranceiver||transceiver
 tranfer||transfer
 tranmission||transmission
+tranport||transport
 transcevier||transceiver
 transciever||transceiver
 transferd||transferred
 transfered||transferred
 transfering||transferring
 transision||transition
+transistioned||transitioned
 transmittd||transmitted
 transormed||transformed
+trasaction||transaction
 trasfer||transfer
 trasmission||transmission
+trasmitter||transmitter
 treshold||threshold
+trigged||triggered
 triggerd||triggered
 trigerred||triggered
 trigerring||triggering
@@ -1503,13 +1678,17 @@ tunning||tuning
 ture||true
 tyep||type
 udpate||update
+updtes||updates
 uesd||used
+unknwon||unknown
 uknown||unknown
 usccess||success
 uncommited||uncommitted
 uncompatible||incompatible
+uncomressed||uncompressed
 unconditionaly||unconditionally
 undeflow||underflow
+undelying||underlying
 underun||underrun
 unecessary||unnecessary
 unexecpted||unexpected
@@ -1521,6 +1700,7 @@ unexpexted||unexpected
 unfortunatelly||unfortunately
 unifiy||unify
 uniterrupted||uninterrupted
+uninterruptable||uninterruptible
 unintialized||uninitialized
 unitialized||uninitialized
 unkmown||unknown
@@ -1537,13 +1717,17 @@ unneccessary||unnecessary
 unnecesary||unnecessary
 unneedingly||unnecessarily
 unnsupported||unsupported
+unuspported||unsupported
 unmached||unmatched
 unprecise||imprecise
+unpriviledged||unprivileged
+unpriviliged||unprivileged
 unregester||unregister
 unresgister||unregister
 unrgesiter||unregister
 unsinged||unsigned
 unstabel||unstable
+unsolicted||unsolicited
 unsolicitied||unsolicited
 unsuccessfull||unsuccessful
 unsuported||unsupported
@@ -1553,6 +1737,8 @@ unuseful||useless
 unvalid||invalid
 upate||update
 upsupported||unsupported
+upto||up to
+useable||usable
 usefule||useful
 usefull||useful
 usege||usage
@@ -1567,6 +1753,7 @@ utitity||utility
 utitlty||utility
 vaid||valid
 vaild||valid
+validationg||validating
 valide||valid
 variantions||variations
 varible||variable
@@ -1574,9 +1761,12 @@ varient||variant
 vaule||value
 verbse||verbose
 veify||verify
+verfication||verification
 veriosn||version
+versoin||version
 verisons||versions
 verison||version
+veritical||vertical
 verson||version
 vicefersa||vice-versa
 virtal||virtual
@@ -1586,6 +1776,7 @@ visiters||visitors
 vitual||virtual
 vunerable||vulnerable
 wakeus||wakeups
+was't||wasn't
 wathdog||watchdog
 wating||waiting
 wiat||wait
@@ -1596,6 +1787,7 @@ whenver||whenever
 wheter||whether
 whe||when
 wierd||weird
+wihout||without
 wiil||will
 wirte||write
 withing||within
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
