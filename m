From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon,  5 Oct 2020 15:30:53 +0200
Subject: [LTP] [PATCH 10/11] docparse: Add configure options
In-Reply-To: <20201005133054.23587-1-chrubis@suse.cz>
References: <20201005133054.23587-1-chrubis@suse.cz>
Message-ID: <20201005133054.23587-11-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Petr Vorel <pvorel@suse.cz>

We build HTML and PDF docs with:
 - asciidoctor (the default as it produces better output, any version)
 - asciidoc (required >= 9)

For asciidoctor we support only native asciidoctor-pdf plugin
(we don't support DocBook, Apache FO, or LaTeX intermediary formats).

The goal is to have smart default: try to generate HTML (or also PDF
if enabled) docs if suitable generator available.

But allow user to chose:
1) disable whole metadata generation (--disable-metadata)
2) disable metadata HTML generation (--disable-metadata-html)
3) enable metadata PDF generation (--enable-metadata-pdf)
4) generator (--with-metadata-generator=asciidoc|asciidoctor)

Used 2 ax_* (third party) macros from autoconf-archive.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 Makefile                   |   6 +-
 configure.ac               |  30 ++++++-
 include/mk/features.mk.in  |   5 ++
 m4/ax_compare_version.m4   | 177 +++++++++++++++++++++++++++++++++++++
 m4/ax_prog_perl_modules.m4 |  77 ++++++++++++++++
 m4/ltp-docparse.m4         | 112 +++++++++++++++++++++++
 6 files changed, 405 insertions(+), 2 deletions(-)
 create mode 100644 m4/ax_compare_version.m4
 create mode 100644 m4/ax_prog_perl_modules.m4
 create mode 100644 m4/ltp-docparse.m4

diff --git a/Makefile b/Makefile
index 3830fb6d4..56812d77b 100644
--- a/Makefile
+++ b/Makefile
@@ -62,7 +62,11 @@ $(1):: | $$(abs_top_builddir)/$$(basename $$(subst -,.,$(1)))
 endif
 endef
 
-COMMON_TARGETS		+= testcases tools docparse
+COMMON_TARGETS		+= testcases tools
+ifeq ($(WITH_METADATA),yes)
+COMMON_TARGETS		+= docparse
+endif
+
 # Don't want to nuke the original files if we're installing in-build-tree.
 ifneq ($(BUILD_TREE_STATE),$(BUILD_TREE_SRCDIR_INSTALL))
 INSTALL_TARGETS		+= runtest scenario_groups testscripts
diff --git a/configure.ac b/configure.ac
index 05672f8f6..06be1c094 100644
--- a/configure.ac
+++ b/configure.ac
@@ -189,7 +189,7 @@ AC_CHECK_TYPES([struct xt_entry_match, struct xt_entry_target],,,[
 
 # Tools knobs
 
-# Expect
+# Bash
 AC_ARG_WITH([bash],
   [AC_HELP_STRING([--with-bash],
     [have the Bourne Again Shell interpreter])],
@@ -202,6 +202,34 @@ else
     AC_SUBST([WITH_BASH],["no"])
 fi
 
+# metadata
+AC_ARG_ENABLE([metadata],
+  [AC_HELP_STRING([--disable-metadata],
+	[Disable metadata generation (both HTML and PDF, default no)])],
+  [], [enable_metadata=yes]
+)
+AC_ARG_ENABLE([metadata_html],
+  [AC_HELP_STRING([--disable-metadata-html],
+	[Disable metadata HTML generation (default no)])],
+  [], [enable_metadata_html=yes]
+)
+
+AC_ARG_ENABLE([metadata_pdf],
+  [AC_HELP_STRING([--enable-metadata-pdf],
+	[Enable metadata PDF generation (default no)])],
+  [], [enable_metadata_pdf=no]
+)
+
+AC_ARG_WITH([metadata_generator],
+  [AC_HELP_STRING([--with-metadata-generator=asciidoc|asciidoctor],
+	[Specify metadata generator to use (default autodetect)])],
+  [with_metadata_generator=$withval],
+  [with_metadata_generator=detect]
+)
+
+LTP_DOCPARSE
+
+# Expect
 AC_ARG_WITH([expect],
   [AC_HELP_STRING([--with-expect],
     [have the Tcl/expect library])],
diff --git a/include/mk/features.mk.in b/include/mk/features.mk.in
index 8e561b738..ecb15a0f7 100644
--- a/include/mk/features.mk.in
+++ b/include/mk/features.mk.in
@@ -27,6 +27,11 @@ WITH_PERL			:= @WITH_PERL@
 
 WITH_PYTHON			:= @WITH_PYTHON@
 
+METADATA_GENERATOR		:= @METADATA_GENERATOR@
+WITH_METADATA			:= @WITH_METADATA@
+WITH_METADATA_HTML		:= @WITH_METADATA_HTML@
+WITH_METADATA_PDF		:= @WITH_METADATA_PDF@
+
 # Features knobs
 
 # Test suite knobs
diff --git a/m4/ax_compare_version.m4 b/m4/ax_compare_version.m4
new file mode 100644
index 000000000..ffb4997e8
--- /dev/null
+++ b/m4/ax_compare_version.m4
@@ -0,0 +1,177 @@
+# ===========================================================================
+#    https://www.gnu.org/software/autoconf-archive/ax_compare_version.html
+# ===========================================================================
+#
+# SYNOPSIS
+#
+#   AX_COMPARE_VERSION(VERSION_A, OP, VERSION_B, [ACTION-IF-TRUE], [ACTION-IF-FALSE])
+#
+# DESCRIPTION
+#
+#   This macro compares two version strings. Due to the various number of
+#   minor-version numbers that can exist, and the fact that string
+#   comparisons are not compatible with numeric comparisons, this is not
+#   necessarily trivial to do in a autoconf script. This macro makes doing
+#   these comparisons easy.
+#
+#   The six basic comparisons are available, as well as checking equality
+#   limited to a certain number of minor-version levels.
+#
+#   The operator OP determines what type of comparison to do, and can be one
+#   of:
+#
+#    eq  - equal (test A == B)
+#    ne  - not equal (test A != B)
+#    le  - less than or equal (test A <= B)
+#    ge  - greater than or equal (test A >= B)
+#    lt  - less than (test A < B)
+#    gt  - greater than (test A > B)
+#
+#   Additionally, the eq and ne operator can have a number after it to limit
+#   the test to that number of minor versions.
+#
+#    eq0 - equal up to the length of the shorter version
+#    ne0 - not equal up to the length of the shorter version
+#    eqN - equal up to N sub-version levels
+#    neN - not equal up to N sub-version levels
+#
+#   When the condition is true, shell commands ACTION-IF-TRUE are run,
+#   otherwise shell commands ACTION-IF-FALSE are run. The environment
+#   variable 'ax_compare_version' is always set to either 'true' or 'false'
+#   as well.
+#
+#   Examples:
+#
+#     AX_COMPARE_VERSION([3.15.7],[lt],[3.15.8])
+#     AX_COMPARE_VERSION([3.15],[lt],[3.15.8])
+#
+#   would both be true.
+#
+#     AX_COMPARE_VERSION([3.15.7],[eq],[3.15.8])
+#     AX_COMPARE_VERSION([3.15],[gt],[3.15.8])
+#
+#   would both be false.
+#
+#     AX_COMPARE_VERSION([3.15.7],[eq2],[3.15.8])
+#
+#   would be true because it is only comparing two minor versions.
+#
+#     AX_COMPARE_VERSION([3.15.7],[eq0],[3.15])
+#
+#   would be true because it is only comparing the lesser number of minor
+#   versions of the two values.
+#
+#   Note: The characters that separate the version numbers do not matter. An
+#   empty string is the same as version 0. OP is evaluated by autoconf, not
+#   configure, so must be a string, not a variable.
+#
+#   The author would like to acknowledge Guido Draheim whose advice about
+#   the m4_case and m4_ifvaln functions make this macro only include the
+#   portions necessary to perform the specific comparison specified by the
+#   OP argument in the final configure script.
+#
+# LICENSE
+#
+#   Copyright (c) 2008 Tim Toolan <toolan@ele.uri.edu>
+#
+#   Copying and distribution of this file, with or without modification, are
+#   permitted in any medium without royalty provided the copyright notice
+#   and this notice are preserved. This file is offered as-is, without any
+#   warranty.
+
+#serial 13
+
+dnl #########################################################################
+AC_DEFUN([AX_COMPARE_VERSION], [
+  AC_REQUIRE([AC_PROG_AWK])
+
+  # Used to indicate true or false condition
+  ax_compare_version=false
+
+  # Convert the two version strings to be compared into a format that
+  # allows a simple string comparison.  The end result is that a version
+  # string of the form 1.12.5-r617 will be converted to the form
+  # 0001001200050617.  In other words, each number is zero padded to four
+  # digits, and non digits are removed.
+  AS_VAR_PUSHDEF([A],[ax_compare_version_A])
+  A=`echo "$1" | sed -e 's/\([[0-9]]*\)/Z\1Z/g' \
+                     -e 's/Z\([[0-9]]\)Z/Z0\1Z/g' \
+                     -e 's/Z\([[0-9]][[0-9]]\)Z/Z0\1Z/g' \
+                     -e 's/Z\([[0-9]][[0-9]][[0-9]]\)Z/Z0\1Z/g' \
+                     -e 's/[[^0-9]]//g'`
+
+  AS_VAR_PUSHDEF([B],[ax_compare_version_B])
+  B=`echo "$3" | sed -e 's/\([[0-9]]*\)/Z\1Z/g' \
+                     -e 's/Z\([[0-9]]\)Z/Z0\1Z/g' \
+                     -e 's/Z\([[0-9]][[0-9]]\)Z/Z0\1Z/g' \
+                     -e 's/Z\([[0-9]][[0-9]][[0-9]]\)Z/Z0\1Z/g' \
+                     -e 's/[[^0-9]]//g'`
+
+  dnl # In the case of le, ge, lt, and gt, the strings are sorted as necessary
+  dnl # then the first line is used to determine if the condition is true.
+  dnl # The sed right after the echo is to remove any indented white space.
+  m4_case(m4_tolower($2),
+  [lt],[
+    ax_compare_version=`echo "x$A
+x$B" | sed 's/^ *//' | sort -r | sed "s/x${A}/false/;s/x${B}/true/;1q"`
+  ],
+  [gt],[
+    ax_compare_version=`echo "x$A
+x$B" | sed 's/^ *//' | sort | sed "s/x${A}/false/;s/x${B}/true/;1q"`
+  ],
+  [le],[
+    ax_compare_version=`echo "x$A
+x$B" | sed 's/^ *//' | sort | sed "s/x${A}/true/;s/x${B}/false/;1q"`
+  ],
+  [ge],[
+    ax_compare_version=`echo "x$A
+x$B" | sed 's/^ *//' | sort -r | sed "s/x${A}/true/;s/x${B}/false/;1q"`
+  ],[
+    dnl Split the operator from the subversion count if present.
+    m4_bmatch(m4_substr($2,2),
+    [0],[
+      # A count of zero means use the length of the shorter version.
+      # Determine the number of characters in A and B.
+      ax_compare_version_len_A=`echo "$A" | $AWK '{print(length)}'`
+      ax_compare_version_len_B=`echo "$B" | $AWK '{print(length)}'`
+
+      # Set A to no more than B's length and B to no more than A's length.
+      A=`echo "$A" | sed "s/\(.\{$ax_compare_version_len_B\}\).*/\1/"`
+      B=`echo "$B" | sed "s/\(.\{$ax_compare_version_len_A\}\).*/\1/"`
+    ],
+    [[0-9]+],[
+      # A count greater than zero means use only that many subversions
+      A=`echo "$A" | sed "s/\(\([[0-9]]\{4\}\)\{m4_substr($2,2)\}\).*/\1/"`
+      B=`echo "$B" | sed "s/\(\([[0-9]]\{4\}\)\{m4_substr($2,2)\}\).*/\1/"`
+    ],
+    [.+],[
+      AC_WARNING(
+        [invalid OP numeric parameter: $2])
+    ],[])
+
+    # Pad zeros at end of numbers to make same length.
+    ax_compare_version_tmp_A="$A`echo $B | sed 's/./0/g'`"
+    B="$B`echo $A | sed 's/./0/g'`"
+    A="$ax_compare_version_tmp_A"
+
+    # Check for equality or inequality as necessary.
+    m4_case(m4_tolower(m4_substr($2,0,2)),
+    [eq],[
+      test "x$A" = "x$B" && ax_compare_version=true
+    ],
+    [ne],[
+      test "x$A" != "x$B" && ax_compare_version=true
+    ],[
+      AC_WARNING([invalid OP parameter: $2])
+    ])
+  ])
+
+  AS_VAR_POPDEF([A])dnl
+  AS_VAR_POPDEF([B])dnl
+
+  dnl # Execute ACTION-IF-TRUE / ACTION-IF-FALSE.
+  if test "$ax_compare_version" = "true" ; then
+    m4_ifvaln([$4],[$4],[:])dnl
+    m4_ifvaln([$5],[else $5])dnl
+  fi
+]) dnl AX_COMPARE_VERSION
diff --git a/m4/ax_prog_perl_modules.m4 b/m4/ax_prog_perl_modules.m4
new file mode 100644
index 000000000..70b3230eb
--- /dev/null
+++ b/m4/ax_prog_perl_modules.m4
@@ -0,0 +1,77 @@
+# ===========================================================================
+#   https://www.gnu.org/software/autoconf-archive/ax_prog_perl_modules.html
+# ===========================================================================
+#
+# SYNOPSIS
+#
+#   AX_PROG_PERL_MODULES([MODULES], [ACTION-IF-TRUE], [ACTION-IF-FALSE])
+#
+# DESCRIPTION
+#
+#   Checks to see if the given perl modules are available. If true the shell
+#   commands in ACTION-IF-TRUE are executed. If not the shell commands in
+#   ACTION-IF-FALSE are run. Note if $PERL is not set (for example by
+#   calling AC_CHECK_PROG, or AC_PATH_PROG), AC_CHECK_PROG(PERL, perl, perl)
+#   will be run.
+#
+#   MODULES is a space separated list of module names. To check for a
+#   minimum version of a module, append the version number to the module
+#   name, separated by an equals sign.
+#
+#   Example:
+#
+#     AX_PROG_PERL_MODULES( Text::Wrap Net::LDAP=1.0.3, ,
+#                           AC_MSG_WARN(Need some Perl modules)
+#
+# LICENSE
+#
+#   Copyright (c) 2009 Dean Povey <povey@wedgetail.com>
+#
+#   Copying and distribution of this file, with or without modification, are
+#   permitted in any medium without royalty provided the copyright notice
+#   and this notice are preserved. This file is offered as-is, without any
+#   warranty.
+
+#serial 8
+
+AU_ALIAS([AC_PROG_PERL_MODULES], [AX_PROG_PERL_MODULES])
+AC_DEFUN([AX_PROG_PERL_MODULES],[dnl
+
+m4_define([ax_perl_modules])
+m4_foreach([ax_perl_module], m4_split(m4_normalize([$1])),
+	  [
+	   m4_append([ax_perl_modules],
+		     [']m4_bpatsubst(ax_perl_module,=,[ ])[' ])
+          ])
+
+# Make sure we have perl
+if test -z "$PERL"; then
+AC_CHECK_PROG(PERL,perl,perl)
+fi
+
+if test "x$PERL" != x; then
+  ax_perl_modules_failed=0
+  for ax_perl_module in ax_perl_modules; do
+    AC_MSG_CHECKING(for perl module $ax_perl_module)
+
+    # Would be nice to log result here, but can't rely on autoconf internals
+    $PERL -e "use $ax_perl_module; exit" > /dev/null 2>&1
+    if test $? -ne 0; then
+      AC_MSG_RESULT(no);
+      ax_perl_modules_failed=1
+   else
+      AC_MSG_RESULT(ok);
+    fi
+  done
+
+  # Run optional shell commands
+  if test "$ax_perl_modules_failed" = 0; then
+    :
+    $2
+  else
+    :
+    $3
+  fi
+else
+  AC_MSG_WARN(could not find perl)
+fi])dnl
diff --git a/m4/ltp-docparse.m4 b/m4/ltp-docparse.m4
new file mode 100644
index 000000000..88d2e08e4
--- /dev/null
+++ b/m4/ltp-docparse.m4
@@ -0,0 +1,112 @@
+dnl SPDX-License-Identifier: GPL-2.0-or-later
+dnl Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
+
+AC_DEFUN([LTP_CHECK_METADATA_GENERATOR_ASCIIDOCTOR], [
+	AC_MSG_NOTICE(checking asciidoctor as metadata generator)
+	AC_PATH_TOOL(asciidoctor, "asciidoctor")
+	metadata_generator_html=$asciidoctor
+	# pdf requires both asciidoctor and asciidoctor-pdf
+	if test "x$metadata_generator_html" != x; then
+		AC_PATH_TOOL(asciidoctor_pdf, "asciidoctor-pdf")
+		metadata_generator_pdf=$asciidoctor_pdf
+	fi
+])
+
+AC_DEFUN([LTP_CHECK_METADATA_GENERATOR_ASCIIDOC], [
+	AC_MSG_NOTICE(checking asciidoc as metadata generator)
+	AC_PATH_TOOL(a2x, "a2x")
+	if test "x$a2x" != x; then
+		version="`$a2x --version | cut -d ' ' -f2 `"
+		AX_COMPARE_VERSION([$version], lt, 9, [
+		AC_MSG_WARN([a2x unsupported version: $version. Use a2x >= 9])
+		a2x=
+		])
+	fi
+	metadata_generator_html=$a2x
+	# pdf requires both asciidoc and dblatex
+	if test "x$metadata_generator_html" != x; then
+		AC_PATH_TOOL(dblatex, "dblatex")
+		metadata_generator_pdf=$dblatex
+	fi
+])
+
+AC_DEFUN([LTP_DOCPARSE], [
+with_metadata=no
+with_metadata_html=no
+with_metadata_pdf=no
+
+if test "x$enable_metadata" = xyes && test "x$enable_metadata_html" = xyes -o "x$enable_metadata_pdf" = xyes; then
+	AX_PROG_PERL_MODULES(Cwd File::Basename JSON LWP::Simple)
+fi
+
+if test "x$ax_perl_modules_failed" = x0; then
+	if test "x$with_metadata_generator" = xasciidoctor -o "x$with_metadata_generator" = xdetect; then
+		LTP_CHECK_METADATA_GENERATOR_ASCIIDOCTOR
+	elif test "x$with_metadata_generator" = xasciidoc; then
+		LTP_CHECK_METADATA_GENERATOR_ASCIIDOC
+	else
+		AC_MSG_ERROR([invalid metadata generator '$with_metadata_generator', use --with-metadata-generator=asciidoc|asciidoctor])
+	fi
+
+	# autodetection: check also Asciidoc
+	if test "x$with_metadata_generator" = xdetect; then
+		with_metadata_generator='asciidoctor'
+		# problems with Asciidoctor: (html enabled && not found) || (pdf enabled && not found) => try Asciidoc
+		if test "x$enable_metadata_html" = xyes -a "x$metadata_generator_html" = x ||
+			test "x$enable_metadata_pdf" = xyes -a "x$metadata_generator_pdf" = x; then
+			backup_html="$metadata_generator_html"
+			backup_pdf="$metadata_generator_pdf"
+			AC_MSG_NOTICE(missing some dependencies for Asciidoctor => trying Asciidoc)
+			with_metadata_generator='asciidoc'
+			LTP_CHECK_METADATA_GENERATOR_ASCIIDOC
+			# prefer Asciidoctor if it's not worse than Asciidoc
+			# (html not enabled || asciidoctor html found || asciidoc html not found) && (pdf ...)
+			if test "x$enable_metadata_html" != xyes -o "x$backup_html" != x -o "x$metadata_generator_html" = x &&
+				test "x$enable_metadata_pdf" != xyes -o "x$backup_pdf" != x -o "x$metadata_generator_pdf" = x; then
+				with_metadata_generator='asciidoctor'
+				metadata_generator_html="$backup_html"
+				metadata_generator_pdf="$backup_pdf"
+			fi
+		fi
+		if test "x$metadata_generator_html" != x -o "x$metadata_generator_pdf" != x; then
+			AC_MSG_NOTICE(choosing $with_metadata_generator for metadata generation)
+		fi
+	fi
+
+	if test "x$enable_metadata_html" = xno; then
+		AC_MSG_NOTICE(HTML metadata generation disabled)
+	elif test "x$metadata_generator_html" != x; then
+		with_metadata_html=yes
+	fi
+
+	if test "x$enable_metadata_pdf" = xno; then
+		AC_MSG_NOTICE(PDF metadata generation disabled)
+	elif test "x$metadata_generator_pdf" != x; then
+		with_metadata_pdf=yes
+	fi
+fi
+
+reason="metadata generation skipped due missing suitable generator"
+hint="specify correct generator with --with-metadata-generator=asciidoc|asciidoctor or use --disable-metadata|--disable-metadata-html|--disable-metadata-pdf"
+
+if test -z "$ax_perl_modules_failed"; then
+	AC_MSG_NOTICE(metadata generation disabled)
+elif test "x$ax_perl_modules_failed" = x1; then
+	AC_MSG_WARN(metadata generation skipped due missing required Perl modules)
+elif test "x$with_metadata_html" = xno -a "x$with_metadata_pdf" = xno; then
+	AC_MSG_WARN([$reason, $hint])
+else
+	with_metadata=yes
+	AC_SUBST(METADATA_GENERATOR, $with_metadata_generator)
+	if test "x$with_metadata_html" = xno -a "x$enable_metadata_html" = xyes; then
+		AC_MSG_WARN([HTML $reason, $hint])
+	fi
+	if test "x$with_metadata_pdf" = xno -a "x$enable_metadata_pdf" = xyes; then
+		AC_MSG_WARN([PDF $reason, $hint])
+	fi
+fi
+
+AC_SUBST(WITH_METADATA, $with_metadata)
+AC_SUBST(WITH_METADATA_HTML, $with_metadata_html)
+AC_SUBST(WITH_METADATA_PDF, $with_metadata_pdf)
+])
-- 
2.26.2

