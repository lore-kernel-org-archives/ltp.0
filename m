Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FDAC27C53
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 14:25:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD2BF3D0A92
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 16:25:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 540F53D0A9C
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 16:24:34 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D0840204B73
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 16:24:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BFBAA1FBA0;
 Fri,  7 Jun 2024 14:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717770270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pDOK5+GTRTQ9A5jPboEgC9kJMbv00nNHVEjmzrD4zG4=;
 b=nCUr8pOtZ/wtUyUU9N8y05vgMW986OveVy7gAuJXMgd2egRo+sOaYj3NrZoixUJ3r0IN2o
 v3U/hOaO7MfJNgzLha59hQ5ijwUKv4Om/maVSIL3gf0i7+vVAor9Jnejb7uOxGZQKiMDMj
 xn0XAHPw/TrkjM+HlT4r+5EEpwgKZfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717770270;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pDOK5+GTRTQ9A5jPboEgC9kJMbv00nNHVEjmzrD4zG4=;
 b=Ean/kLslfUuVQZ5Rp9lMGBfGCLAtz3K0yIeOIKAPtQDS9v3pxjXANlmFy6V+qHKvdvGnda
 7xiMkFi8EEeZHQBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717770270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pDOK5+GTRTQ9A5jPboEgC9kJMbv00nNHVEjmzrD4zG4=;
 b=nCUr8pOtZ/wtUyUU9N8y05vgMW986OveVy7gAuJXMgd2egRo+sOaYj3NrZoixUJ3r0IN2o
 v3U/hOaO7MfJNgzLha59hQ5ijwUKv4Om/maVSIL3gf0i7+vVAor9Jnejb7uOxGZQKiMDMj
 xn0XAHPw/TrkjM+HlT4r+5EEpwgKZfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717770270;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pDOK5+GTRTQ9A5jPboEgC9kJMbv00nNHVEjmzrD4zG4=;
 b=Ean/kLslfUuVQZ5Rp9lMGBfGCLAtz3K0yIeOIKAPtQDS9v3pxjXANlmFy6V+qHKvdvGnda
 7xiMkFi8EEeZHQBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61AA2133F3;
 Fri,  7 Jun 2024 14:24:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oNvRFh4YY2a0CAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 07 Jun 2024 14:24:30 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  7 Jun 2024 16:24:23 +0200
Message-ID: <20240607142423.116285-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240607142423.116285-1-pvorel@suse.cz>
References: <20240607142423.116285-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_SEVEN(0.00)[8];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 3/3] doc/old: Remove man pages
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

Remove man pages for outdated tools (used in legacy API,
people should migrate to from ltp-pan to kirk).

Since moved to doc/old/ they don't install anyway.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/old/Makefile                 |  11 --
 doc/old/man1/Makefile            |  27 ---
 doc/old/man1/doio.1              |  70 -------
 doc/old/man1/iogen.1             |  78 --------
 doc/old/man1/ltp-bump.1          |  80 --------
 doc/old/man1/ltp-pan.1           | 262 --------------------------
 doc/old/man3/Makefile            |  27 ---
 doc/old/man3/parse_opts.3        | 179 ------------------
 doc/old/man3/parse_ranges.3      | 169 -----------------
 doc/old/man3/random_range.3      | 114 -----------
 doc/old/man3/random_range_seed.3 | 114 -----------
 doc/old/man3/tst_res.3           | 313 -------------------------------
 doc/old/man3/tst_sig.3           | 141 --------------
 doc/old/man3/tst_tmpdir.3        |  76 --------
 doc/old/man3/usctest.3           | 164 ----------------
 15 files changed, 1825 deletions(-)
 delete mode 100644 doc/old/Makefile
 delete mode 100644 doc/old/man1/Makefile
 delete mode 100644 doc/old/man1/doio.1
 delete mode 100644 doc/old/man1/iogen.1
 delete mode 100644 doc/old/man1/ltp-bump.1
 delete mode 100644 doc/old/man1/ltp-pan.1
 delete mode 100644 doc/old/man3/Makefile
 delete mode 100644 doc/old/man3/parse_opts.3
 delete mode 100644 doc/old/man3/parse_ranges.3
 delete mode 100644 doc/old/man3/random_range.3
 delete mode 100644 doc/old/man3/random_range_seed.3
 delete mode 100644 doc/old/man3/tst_res.3
 delete mode 100644 doc/old/man3/tst_sig.3
 delete mode 100644 doc/old/man3/tst_tmpdir.3
 delete mode 100644 doc/old/man3/usctest.3

diff --git a/doc/old/Makefile b/doc/old/Makefile
deleted file mode 100644
index f7e4dd021..000000000
--- a/doc/old/Makefile
+++ /dev/null
@@ -1,11 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (C) 2009, Cisco Systems Inc.
-# Ngie Cooper, July 2009
-
-top_srcdir			?= ..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-RECURSIVE_TARGETS	:= install
-
-include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/doc/old/man1/Makefile b/doc/old/man1/Makefile
deleted file mode 100644
index ecd2b6da9..000000000
--- a/doc/old/man1/Makefile
+++ /dev/null
@@ -1,27 +0,0 @@
-#
-#    man1 Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-MANPREFIX		:= 1
-
-top_srcdir		?= ../..
-
-include $(top_srcdir)/include/mk/man.mk
diff --git a/doc/old/man1/doio.1 b/doc/old/man1/doio.1
deleted file mode 100644
index e488c03f1..000000000
--- a/doc/old/man1/doio.1
+++ /dev/null
@@ -1,70 +0,0 @@
-.\"
-.\" $Id: doio.1,v 1.1 2000/07/27 16:59:03 alaffin Exp $
-.\"
-.\" Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
-.\"
-.\" This program is free software; you can redistribute it and/or modify it
-.\" under the terms of version 2 of the GNU General Public License as
-.\" published by the Free Software Foundation.
-.\"
-.\" This program is distributed in the hope that it would be useful, but
-.\" WITHOUT ANY WARRANTY; without even the implied warranty of
-.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-.\"
-.\" Further, this software is distributed without any warranty that it is
-.\" free of the rightful claim of any third person regarding infringement
-.\" or the like.  Any license provided herein, whether implied or
-.\" otherwise, applies only to this software file.  Patent licenses, if
-.\" any, provided herein do not apply to combinations of this program with
-.\" other software, or any other product whatsoever.
-.\"
-.\" You should have received a copy of the GNU General Public License along
-.\" with this program; if not, write the Free Software Foundation, Inc.,
-.\" 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-.\"
-.\" Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
-.\" Mountain View, CA  94043, or:
-.\"
-.\" http://www.sgi.com
-.\"
-.\" For further information regarding this notice, see:
-.\"
-.\" http://oss.sgi.com/projects/GenInfo/NoticeExplan/
-.\"
-.TH doio 1 10/13/93 "UNICOS Testing"
-.SH NAME
-\*Cdoio\fR - Executes I/O Requests
-.SH IMPLEMENTATION
-All Cray Research systems
-.SH SYNOPSIS
-\*Cdoio\fR
-.SH DESCRIPTION
-.QS
-Doio is one of the device-beater tools.
-.PP
-Options:
-.RS .5i
-.IP "-a"
-abort on data compare errors
-.IP "-n opt"
-.IP "-k opt"
-lockd request pipe
-.IP "-K opt"
-use fcntl() file locking
-.IP "-r opt"
-resource release interval
-.IP "-s opt"
-syscall log file
-.IP "-w opt"
-file write log file
-.IP "-v"
-verify writes if set
-.IP "-U opt"
-upanic() on varios conditions
-.RE
-.SH AUTHOR
-Mark Maule wrote the code.
-.br
-Glen Overby wrote the man page.
-.SH BUGS
-See "Features".
diff --git a/doc/old/man1/iogen.1 b/doc/old/man1/iogen.1
deleted file mode 100644
index f59415714..000000000
--- a/doc/old/man1/iogen.1
+++ /dev/null
@@ -1,78 +0,0 @@
-.\"
-.\" $Id: iogen.1,v 1.1 2000/07/27 16:59:03 alaffin Exp $
-.\"
-.\" Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
-.\"
-.\" This program is free software; you can redistribute it and/or modify it
-.\" under the terms of version 2 of the GNU General Public License as
-.\" published by the Free Software Foundation.
-.\"
-.\" This program is distributed in the hope that it would be useful, but
-.\" WITHOUT ANY WARRANTY; without even the implied warranty of
-.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-.\"
-.\" Further, this software is distributed without any warranty that it is
-.\" free of the rightful claim of any third person regarding infringement
-.\" or the like.  Any license provided herein, whether implied or
-.\" otherwise, applies only to this software file.  Patent licenses, if
-.\" any, provided herein do not apply to combinations of this program with
-.\" other software, or any other product whatsoever.
-.\"
-.\" You should have received a copy of the GNU General Public License along
-.\" with this program; if not, write the Free Software Foundation, Inc.,
-.\" 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-.\"
-.\" Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
-.\" Mountain View, CA  94043, or:
-.\"
-.\" http://www.sgi.com
-.\"
-.\" For further information regarding this notice, see:
-.\"
-.\" http://oss.sgi.com/projects/GenInfo/NoticeExplan/
-.\"
-.TH iogen 1 10/13/93 "UNICOS Testing"
-.SH NAME
-\*Ciogen\fR - Generate I/O Requests
-.SH IMPLEMENTATION
-All Cray Research systems
-.SH SYNOPSIS
-\*Ciogen\fR
-.SH DESCRIPTION
-.QS
-Iogen is one of the device-beater tools.
-.PP
-Options:
-.RS .5i
-.IP "-f [opt]"
-open flags:
-raw, sync, ssd, ldraw, buffered
-.IP "-i [opt]"
-Number of iterations to run.
-0 implies infinite.
-.IP "-q"
-.IP "-m [opt]"
-Offset mode.
-One of: random, sequential, reverse.
-.IP "-o"
-Overlap flag.
-.IP "-p [opt]"
-output pipe (default is stdout)
-.IP "-r [opt]"
-specify raw io multiple instead of getting it from the mounted on device.
-Only applies to regular files.
-.IP "-s [opt]"
-System calls to use for I/O.
-A list of:
-read, write, reada, writea, ssread, sswrite
-.IP "-t [opt]"
-min transfer size
-.IP "-T [opt]"
-max transfer size
-.RE
-.SH AUTHOR
-Mark Maule wrote the code.
-.br
-Glen Overby wrote the man page.
-.SH BUGS
-See "Features".
diff --git a/doc/old/man1/ltp-bump.1 b/doc/old/man1/ltp-bump.1
deleted file mode 100644
index aef2b4a30..000000000
--- a/doc/old/man1/ltp-bump.1
+++ /dev/null
@@ -1,80 +0,0 @@
-.\"
-.\" $Id: ltp-bump.1,v 1.1 2009/05/19 09:39:11 subrata_modak Exp $
-.\"
-.\" Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
-.\"
-.\" This program is free software; you can redistribute it and/or modify it
-.\" under the terms of version 2 of the GNU General Public License as
-.\" published by the Free Software Foundation.
-.\"
-.\" This program is distributed in the hope that it would be useful, but
-.\" WITHOUT ANY WARRANTY; without even the implied warranty of
-.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-.\"
-.\" Further, this software is distributed without any warranty that it is
-.\" free of the rightful claim of any third person regarding infringement
-.\" or the like.  Any license provided herein, whether implied or
-.\" otherwise, applies only to this software file.  Patent licenses, if
-.\" any, provided herein do not apply to combinations of this program with
-.\" other software, or any other product whatsoever.
-.\"
-.\" You should have received a copy of the GNU General Public License along
-.\" with this program; if not, write the Free Software Foundation, Inc.,
-.\" 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-.\"
-.\" Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
-.\" Mountain View, CA  94043, or:
-.\"
-.\" http://www.sgi.com
-.\"
-.\" For further information regarding this notice, see:
-.\"
-.\" http://oss.sgi.com/projects/GenInfo/NoticeExplan/
-.\"
-.TH BUMP 1 "14 Sep 2000" "LTP" "Linux Test Project"
-.SH NAME
-ltp-bump \- send signal to tags run by ltp-pan
-.SH SYNOPSIS
-\fBltp-bump [-1] [-s \fIsig\fB] [\fI-a active-file\fB] [tags...]
-.SH DESCRIPTION
-
-Bump will send a SIGINT signal to processes, given that each process has a
-corresponding tag in an active-file.  The active-file is the same one that is
-used by the ltp-pan to start the processes.
-
-If the active file has multiple occurrences of a single tag name then only the
-first process will be signaled.  You may specify the tag name multiple times
-on the commandline if necessary.
-
-.TP 1i
-\fB-1\fP
-Send a SIGUSR1 signal.  By default a SIGINT will be sent.
-.TP 1i
-\fB-a \fIactive_file\fB
-A file containing the tagnames, pids, and commands being run by a ltp-pan.  If this
-is not specified then the ZOO environment variable will be read for the name of
-the directory where the active file can be found.
-.TP 1i
-\fB-s \fIsig\fB
-Used to specify a signal number to send.  By default a SIGINT will be sent.
-
-.in -1i
-
-.SH ENVIRONMENT
-.TP
-ZOO
-If set, should name the directory where the active file can be found.
-This is ignored if \fI-a\fP is specified.
-
-.SH FILES
-.TP
-active
-Default name of active file if \fI-a\fP is not specified.  This is prefixed
-by the directory name found in the ZOO environment variable.
-
-.SH "SEE ALSO"
-Zoo tools - ltp-pan(1)
-
-.SH DIAGNOSTICS
-Exits zero, unless it cannot find the active file or if there were no tags
-listed on the commandline.
diff --git a/doc/old/man1/ltp-pan.1 b/doc/old/man1/ltp-pan.1
deleted file mode 100644
index 5ffa57dba..000000000
--- a/doc/old/man1/ltp-pan.1
+++ /dev/null
@@ -1,262 +0,0 @@
-.\"
-.\" $Id: ltp-pan.1,v 1.1 2009/05/19 09:39:11 subrata_modak Exp $
-.\"
-.\" Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
-.\"
-.\" This program is free software; you can redistribute it and/or modify it
-.\" under the terms of version 2 of the GNU General Public License as
-.\" published by the Free Software Foundation.
-.\"
-.\" This program is distributed in the hope that it would be useful, but
-.\" WITHOUT ANY WARRANTY; without even the implied warranty of
-.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-.\"
-.\" Further, this software is distributed without any warranty that it is
-.\" free of the rightful claim of any third person regarding infringement
-.\" or the like.  Any license provided herein, whether implied or
-.\" otherwise, applies only to this software file.  Patent licenses, if
-.\" any, provided herein do not apply to combinations of this program with
-.\" other software, or any other product whatsoever.
-.\"
-.\" You should have received a copy of the GNU General Public License along
-.\" with this program; if not, write the Free Software Foundation, Inc.,
-.\" 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-.\"
-.\" Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
-.\" Mountain View, CA  94043, or:
-.\"
-.\" http://www.sgi.com
-.\"
-.\" For further information regarding this notice, see:
-.\"
-.\" http://oss.sgi.com/projects/GenInfo/NoticeExplan/
-.TH PAN 1 "21 Jan 2011" "LTP" "Linux Test Project"
-.SH NAME
-ltp-pan \- A light-weight driver to run tests and clean up their pgrps
-.SH SYNOPSIS
-\fBltp-pan -n tagname [-SyAehp] [-t #s|m|h|d \fItime\fB] [-s \fIstarts\fB] [\fI-x nactive\fB] [\fI-l logfile\fB] [\fI-a active-file\fB] [\fI-f command-file\fB] [\fI-d debug-level\fB] [\fI-o output-file\fB] [\fI-O buffer_directory\fB] [\fI-r report_type\fB] [\fI-C fail-command-file\fB] [cmd]
-.SH DESCRIPTION
-
-Pan will run a command, as specified on the commandline, or collection of
-commands from a command-file.  By default ltp-pan runs one command, choosing it at
-random from the whole set of commands available to it.  The ltp-pan's name in the
-active file is specified by the tagname.  When a command terminates ltp-pan will
-kill any orphans that may have been left behind in its pgrp.  If ltp-pan is
-signaled it will kill any active commands and, again, clean up any orphans.
-
-Pan uses the signal ratchet found in other zoo tools.  The first time ltp-pan is
-signaled it sends a SIGTERM to the active pgrps; the second time it sends
-SIGHUP; the third time a SIGINT; after that it always sends SIGKILL.
-
-Pan will not terminate until all the active commands and everything in their
-pgrps is dead.  It will loop around at 5 second intervals, triggering its own
-signal ratchet, until it succeeds in killing the pgrps.
-
-When the ltp-pan starts up it places its own tagname and commandline in the active
-file and begins scheduling commands.  After a command is started ltp-pan puts an
-entry for it into the active file with its indicated tagname.  If the command
-was specified on the command line, rather than in the command-file, then its
-tagname will be "cmdln".  When a process terminates ltp-pan frees the active file
-entry.  If a command terminates and leaves an orphaned pgrp then ltp-pan will put
-an entry into the active file called "panorphan" which will be removed only
-when the orphaned pgrp is cleaned up.  Before ltp-pan exits it will ensure that
-all orphaned pgrps are dead (see above) and then it will remove its own
-tagname from the active file.
-
-The command-file is a file containing tag/command pairs.  Each line in the
-file begins with a tag identifying the command, followed by white space, and
-then the command and its arguments.  A line beginning with the # character is
-a comment.  Pan recognizes the token "%f" in a command's arguments and
-replaces it with a unique identifier--add this to filename arguments to
-prevent two instances of the command from interfering with each other.
-
-When ltp-pan receives a SIGUSR2 it stops scheduling new tests and waits for the
-active tests to terminate.  If the \fB-y\fP option was used then it will begin
-scheduling again, otherwise it will exit.  It does not propagate the SIGUSR2.
-
-.TP 1i
-\fB-A\fP
-The all-stop flag.  If any command exits non-zero ltp-pan will shutdown its
-scheduler and signal any active pgrps.  The ltp-pan will exit non-zero after
-everything is shut down.  By default ltp-pan ignores command exit statuses.
-The \fI-e\fP option is implied when this option is used.
-.TP 1i
-\fB-a \fIactive_file\fB
-A file containing the tagnames, pids, and commands being run.  If this is
-not specified then the ZOO environment variable will be read for the name
-of a directory where the active file will be placed, and in this case the
-active file's name will be "active".  A single active file may be shared
-by any number of Zoo tools.
-.TP 1i
-\fB-C \fIfail-command-file\fB
-The file to which all failed test commands will be saved.  You can use it later with \fI-f\fP option if you want to run only the failed test cases.
-.TP 1i
-\fB-d \fIdebug-level\fB
-See the source for settings.
-.TP 1i
-\fB-e\fP
-Pan will exit non-zero if any of its commands exited non-zero.  By default
-ltp-pan ignores command exit statuses.
-.TP 1i
-\fB-f \fIcommand-file\fB
-The file that has a collection of commands that ltp-pan will execute.
-.TP 1i
-\fB-h\fP
-Print some simple help.
-.TP 1i
-\fB-l \fIlogfile\fB
-Name of a log file to be used to store exit information for each of the
-commands (tags) that are run.  This log file may not be shared with other Zoo
-tools or other ltp-pan processes.
-.TP 1i
-\fB-n \fItagname\fB
-The tagname by which this ltp-pan process will be known by the zoo tools.  This
-is a required argument.
-.TP 1i
-\fB-o \fIoutput_file\fB
-The file to which all test output will be saved.  Normally all test output is sent to standard output.  This includes each test's standard output and standard error.
-.TP 1i
-\fB-O \fIbuffer_directory\fB
-A directory where ltp-pan can place temporary files to capture test output.  This will prevent output from several tests mixing together in the output file.
-.TP 1i
-\fB-p\fP
-Enables printing results in human readable format.
-.TP 1i
-\fB-r \fIreport_type\fB
-This controls the type of output that ltp-pan will produce.  Supported formats are \fIrts\fP and \fInone\fP.  The default is \fIrts\fP.
-.TP 1i
-\fB-S\fP
-Causes ltp-pan to run commands (tags) sequentially, as they are listed in the
-command-file.  By default it chooses tags randomly.  If a command is specified
-on the commandline and a command-file is also specified, then the commandline
-tag will be the last command.  If this is specified and \fI-s\fP is not
-specified then the default setting for \fI-s\fP is equal to the total number
-of commands.
-.TP 1i
-\fB-s \fIstarts\fB
-Indicates the number of commands (tags) that should be run before terminating.
-Set this to zero to run forever.  By default this is set to 1 (but see
-\fI-S\fP for an exception).  If this is specified and is less than the value
-specified for \fI-x\fP then it is bumped up to be equal to the value of
-\fI-x\fP (in other words, \fI-x\fP is always satisfied).
-.TP 1i
-\fB-t #s|m|h|d \fItime\fB
-Indicates the length that ltp-pan should run tests. By default this is not set.  If specified,
-the \fI-s\fP flag is automatically set to 0 (infinite).  Presumably, you want as many
-tests ran during this timeframe. Duration is measured in \fIs\fPeconds, \fIm\fPinutes,
-\fIh\fPours, or \fId\fPays.
-.TP 1i
-\fB-x \fInactive\fB
-Indicates the number of commands (tags) that should be kept active at any one
-time.  If this is greater than 1 then it is possible to have multiple
-instances of the same tag active at once.  By default this is 1.
-.TP 1i
-\fB-y\fP
-Causes the ltp-pan scheduler to go idle if a signal is received or if a command
-exits non-zero.  All active commands and their pgrps will be killed.  After
-everything is dead the scheduler will restart again where it left off.  If the
-signal is SIGUSR1 then ltp-pan will behave as if \fI-y\fP had not been specified.
-
-.in -1i
-
-.SH EXAMPLES
-
-In practice, the ZOO environment variable is generally preferred over the
-\fI-a\fP option.  All examples assume this is being set.
-
-The following creates a ltp-pan named "ex1" with an active file in /tmp/active.
-It runs the command "echo hello", keeping 3 copies running at all times,
-running 10 copies before terminating.
-
-$ export ZOO=/tmp
-.br
-$ ltp-pan -n ex1 -s 10 -x 3 echo hello
-
-The next example will use this command file.  Call this /tmp/cmds1.
-.br
-----------cut------
-.br
-fido    ls /bin
-.br
-rover   echo hello wally
-.br
-gidget  sleep 2
-.br
-lassie  ls /etc
-.br
-----------cut------
-.br
-
-Using the above command file, /tmp/cmds1, run one command at a time,
-sequentially, running each command only once.  If one command should fail then
-terminate immediately.  An exit log is kept for all the commands.
-
-$ ltp-pan -n ex3 -S -A -f /tmp/cmds1 -l ex3.log
-
-Here is just a simple stress case. In this case the test will run for 24 hours,
-printing the output as a human readable format, with the test output at /tmp/output-file
-and all failed test commands (if you have any) at /tmp/fail-command-file.
-
-$ ltp-pan -n stress -e -p -q -S -t 24h -a stress -l logfile -f command-file \
-		-o /tmp/output-file -C /tmp/fail-command-file
-
-.SH LAYERING
-
-Pan is often used in layers.  This section extends the above examples to show
-how this is done.
-
-The next example will use this command file.  Call this /tmp/cmds2.  Note that
-the embedded ltp-pans inside this file have exit logs, and that %f is used to give
-each ltp-pan a unique log file name.
-.br
-----------cut------
-.br
-larry  ltp-pan -n ex4b -s10 -A -l ex4_%f.log echo hello
-.br
-curly  ltp-pan -n ex4c -S -A -f /tmp/cmds1 -l ex4_%f.log
-.br
-moe    echo done here
-.br
-----------cut------
-.br
-
-The following will run commands from the command file, keeping two at a time
-running, choosing them sequentially, and terminating if any of them exits
-non-zero.
-
-$ ltp-pan -n ex4 -x2 -A -S -f /tmp/cmds2
-
-Now run the commands in /tmp/cmds2, but this time we want to recover if one of
-the commands should exit non-zero.  In this example it is possible for the
-"larry" or "curly" tags to exit non-zero.  When this happens the ltp-pan will kill
-all active tags, making sure both larry and curly are dead, and then will
-continue scheduling--ensuring that our "done here" message comes out no matter
-what.
-
-$ ltp-pan -n ex5 -x2 -A -S -y -f /tmp/cmds2
-
-.SH ENVIRONMENT
-.TP
-ZOO
-If set, should name the directory where the active file should be placed.
-This is ignored if \fI-a\fP is specified.
-
-.SH FILES
-.TP
-active
-Default name of active file if \fI-a\fP is not specified.  This is prefixed
-by the directory name found in the ZOO environment variable.
-.TP
-PAN_STOP_FILE
-The creation of this file in the defined \fITMP\fP directory will cause ltp-pan to
-execute one more loop and stop.  This is useful when testing needs to be stopped
-before its scheduled stop time (\fI-t\fP).  By doing a 'touch' on this file, testing
-is ended, i.e. touch /tmp/runalltests-2345/PAN_STOP_FILE
-
-.SH "SEE ALSO"
-Zoo tools - ltp-bump(1)
-
-.SH DIAGNOSTICS
-By default it exits zero unless signaled, regardless of the exit status of any
-of the commands it is running.  If \fI-A\fP or \fI-e\fP are specified it exits non-zero if
-it is signaled or if any of the commands it is running should exit non-zero.
diff --git a/doc/old/man3/Makefile b/doc/old/man3/Makefile
deleted file mode 100644
index ff36ddd15..000000000
--- a/doc/old/man3/Makefile
+++ /dev/null
@@ -1,27 +0,0 @@
-#
-#    man3 Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-MANPREFIX		:= 3
-
-top_srcdir		?= ../..
-
-include $(top_srcdir)/include/mk/man.mk
diff --git a/doc/old/man3/parse_opts.3 b/doc/old/man3/parse_opts.3
deleted file mode 100644
index b3472ce9a..000000000
--- a/doc/old/man3/parse_opts.3
+++ /dev/null
@@ -1,179 +0,0 @@
-.\"
-.\" $Id: parse_opts.3,v 1.3 2000/08/31 18:40:28 nstraz Exp $
-.\"
-.\" Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
-.\"
-.\" This program is free software; you can redistribute it and/or modify it
-.\" under the terms of version 2 of the GNU General Public License as
-.\" published by the Free Software Foundation.
-.\"
-.\" This program is distributed in the hope that it would be useful, but
-.\" WITHOUT ANY WARRANTY; without even the implied warranty of
-.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-.\"
-.\" Further, this software is distributed without any warranty that it is
-.\" free of the rightful claim of any third person regarding infringement
-.\" or the like.  Any license provided herein, whether implied or
-.\" otherwise, applies only to this software file.  Patent licenses, if
-.\" any, provided herein do not apply to combinations of this program with
-.\" other software, or any other product whatsoever.
-.\"
-.\" You should have received a copy of the GNU General Public License along
-.\" with this program; if not, write the Free Software Foundation, Inc.,
-.\" 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-.\"
-.\" Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
-.\" Mountain View, CA  94043, or:
-.\"
-.\" http://www.sgi.com
-.\"
-.\" For further information regarding this notice, see:
-.\"
-.\" http://oss.sgi.com/projects/GenInfo/NoticeExplan/
-.\"
-.TH PARSE_OPTS 3 "21 Jan 2011" "LTP" "Linux Test Project"
-.SH NAME
-parse_opts \- parse standard and user options for LTP test programs
-.SH SYNOPSIS
-.nf
-.B #include \(rqtest.h\(rq
-.B #include \(rqusctest.h\(rq
-.sp
-.BI "char *parse_opts(int " argc ", char *" argv[] ", "
-.BI "                 option_t " option_array[] ","
-.BI "                 void (*" user_help_func ")());"
-.fi
-.SH DESCRIPTION
-The \fBparse_opts()\fP routine parses options from the command line, looking
-for user specified options or standard options (see below). Its arguments
-\fIargc\fP and \fIargv\fP are the argument count and array as passed to the
-main() function on program invocation. User options may be specified in the
-\fIoption_array\fR argument. A help function may be specified in the
-\fIuser_help_func\fP argument.
-.sp
-\fIoption_array\fP is a pointer to the first element of an array of
-\fBoption_t\fP.  If no additional options are needed, pass NULL.
-\fBoption_t\fR is declared in \fBusctest.h\fP as
-.nf
-.sp
-.in 10
-typedef struct {
-.in 14
-char	*option;
-int	*flag;
-char	**arg;
-.in 10
-} option_t;
-.fi
-.PP
-The meanings of the different fields are:
-.TP
-.I option
-is a valid option string to be given to getopt().
-.TP
-.I flag
-is a pointer to an integer location to set true if option is given in
-\fIargv\fR.  This can be NULL if the option doesn't require an argument.
-.TP
-.I arg
-is a pointer to a character pointer variable that will be set with the option
-argument if the option is present in argv.  This pointer MUST be provided if
-the option can take an argument.  Failure to provide a location will cause
-\fBparse_opts()\fR to return an error.
-.PP
-.I user_help_func
-is a pointer to a function that will be called when the \-h option is found.
-This function should print help messages for the options in \fIoption_array\fR
-to standard out. The standard help messages are formatted such that the option
-designator starts in column 3 and the description starts in column 11.
-.sp
-.SH "STANDARD OPTIONS"
-Below is a list of the standard options defined in \fBparse_opts()\fR:
-.TP
-.BI \-c " n"
-Run \fIn\fR copies of the test in parallel.  This is done by forking \fIn\fR
-times and running the test as usual.  If \-i or \-I are specified, each process
-will run for that amount of time.
-.TP
-.B \-e
-Turn on logging all errno's received.  This option is to facilitate security
-audit testing for MLS.
-.TP
-.B \-f
-Suppresses functional testing messages.
-.TP
-.B \-h
-Print help message.  The standard options will be printed first, then a call to
-.I user_help_func()
-will be made.
-.TP
-.BI \-i " n"
-Run for \fIn\fR iterations. A value of 0 makes the test loop infinitely.
-(default 1)
-.TP
-.BI \-I " x"
-The test will loop until \fIx\fR seconds have passed. (default 0.0)
-.TP
-.B \-p
-Pause for SIGUSR1 before testing. The test will pause where you place
-TEST_PAUSE.  \fIWarning\fR: The test will also fork at this point if \-c is
-used.
-.TP
-.BI \-P " x"
-This option will do a delay of \fIx\fR seconds after each iteration. (default 0.0)
-.TP
-.B \-t
-Produce timing statistics. *NOT IMPLEMENTED*
-.PP
-.sp
-The STD_* flags are used by system call test macros defined in usctest.h
-(see \fBusctest(3)\fR), or may be used in the user's code.
-.SH "RETURN VALUE"
-.B parse_opts()
-returns a NULL pointer upon successful completion.  If an error occurs a
-pointer to an error message is returned.
-.SH "EXAMPLE"
-The following example defines two options, one with an argument, one without.
-.sp
-.nf
-int fflag, Tflag;	/* binary flags: opt or not */
-char *Topt;		/* option arguments */
-
-option_t options[] = {
-	{ "F", &fflag, NULL },		/* No argument */
-	{ "T:",	&Tflag, &Topt },	/* argument required */
-	{ NULL, NULL, NULL }		/* NULL required to end array */
-};
-
-void help()
-{
-	printf("  -F       An option with no argument\\n");
-	printf("  -T opt   An option that requires an argument\\n");
-}
-
-int main(int argc, char *argv[])
-{
-	char *msg;
-
-	if ((msg = parse_opts(argc, argv, options, &help)) != NULL)
-		error_exit(msg);
-
-	return 0;
-}
-.fi
-.sp
-The following example shows how to use \fBparse_opts()\fR without defining new options.
-.sp
-.nf
-int main(int argc, char *argv[])
-{
-	char *msg;
-
-	if ((msg = parse_opts(argc, argv, NULL, NULL)) != NULL)
-		error_exit(msg);
-
-	return 0;
-}
-.fi
-.SH "SEE ALSO"
-usctest(3), getopt(3).
diff --git a/doc/old/man3/parse_ranges.3 b/doc/old/man3/parse_ranges.3
deleted file mode 100644
index d92e001f1..000000000
--- a/doc/old/man3/parse_ranges.3
+++ /dev/null
@@ -1,169 +0,0 @@
-.\"
-.\" $Id: parse_ranges.3,v 1.1 2000/07/27 16:59:03 alaffin Exp $
-.\"
-.\" Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
-.\"
-.\" This program is free software; you can redistribute it and/or modify it
-.\" under the terms of version 2 of the GNU General Public License as
-.\" published by the Free Software Foundation.
-.\"
-.\" This program is distributed in the hope that it would be useful, but
-.\" WITHOUT ANY WARRANTY; without even the implied warranty of
-.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-.\"
-.\" Further, this software is distributed without any warranty that it is
-.\" free of the rightful claim of any third person regarding infringement
-.\" or the like.  Any license provided herein, whether implied or
-.\" otherwise, applies only to this software file.  Patent licenses, if
-.\" any, provided herein do not apply to combinations of this program with
-.\" other software, or any other product whatsoever.
-.\"
-.\" You should have received a copy of the GNU General Public License along
-.\" with this program; if not, write the Free Software Foundation, Inc.,
-.\" 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-.\"
-.\" Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
-.\" Mountain View, CA  94043, or:
-.\"
-.\" http://www.sgi.com
-.\"
-.\" For further information regarding this notice, see:
-.\"
-.\" http://oss.sgi.com/projects/GenInfo/NoticeExplan/
-.\"
-.TH PARSE_RANGES 3 07/25/2000 "Linux Test Project"
-.SH NAME
-parse_ranges \- function to parse a string formatted like 'min:max:mult,...'
-.SH SYNOPSIS
-.nf
-int parse_ranges(char *str, int defmin, int defmax, int defmult, int (*parse_func)(), char **rangeptr, char **errptr);
-int range_min(char *rbuf, int r);
-int range_max(char *rbuf, int r);
-int range_mult(char *rbuf, int r);
-.fi
-.SH DESCRIPTION
-parse_ranges() is a function to parse a comma-separated list of range
-tokens each having the following form:
-.SP
-.nf
-		num
-	or
-		min:max[:mult]
-.fi
-
-any of the values may be blank (ie. min::mult, :max, etc.) and default
-values for missing arguments may be supplied by the caller.
-
-The special first form is short hand for 'num:num'.
-
-After parsing the string, the ranges are put into an array of integers,
-which is malloc'd by the routine.  The min, max, and mult entries of each
-range can be extracted from the array using the range_min(), range_max(),
-and range_mult() functions.
-
-If \fIrange_ptr\fP is not NULL, and parse_ranges() successfully parses the
-range string (ie. does not return -1), *range_ptr will point to space
-malloc'd by parse_ranges().  The user may free this space by calling free().
-
-parse_ranges() parameters are:
-.SP
-.TP 1i
-\fIstr\fP
-The string to parse - assumed to be a comma-separated
-list of tokens having the above format.
-.TP 1i
-\fIdefmin\fP
-default value to plug in for min, if it is missing
-.TP 1i
-\fIdefmax\fP
-default value to plug in for max, if it is missing
-.TP 1i
-\fIdefmult\fP
-default value to plug in for mult, if missing
-.TP 1i
-\fIparse_func\fP
-A user-supplied function pointer, which parse_ranges()
-can call to parse the min, max, and mult strings.  This
-allows for customized number formats.  The function
-MUST have the following prototype:
-.SP
-.nf
-	int parse_func(char *str, int *val)
-.fi
-.SP
-The function should return -1 if str cannot be parsed
-into an integer, or >= 0 if it was successfully
-parsed.  The resulting integer will be stored in
-*val.  If parse_func is NULL, parse_ranges will parse
-the tokens in a manner consistent with the sscanf %i format.
-.TP 1i
-\fIrange_ptr\fP
-A user-supplied char **, which will be set to point
-at malloc'd space which holds the parsed range
-values.   If range_ptr is NULL, parse_ranges() just
-parses the string.  The data returned in range_ptr
-should not be processed directly - use the functions
-range_min(), range_max(), and range_mult() to access
-data for a given range.
-.TP 1i
-\fIerrptr\fP
-user-supplied char ** which can be set to point to a
-static error string.  If errptr is NULL, it is ignored.
-.in -1i
-
-.SP
-range_min(), range_max(), and range_mult() parameters are:
-.SP
-.SP
-.TP 1i
-\fIrbuf\fP
-An array of ranges set up by parse_ranges().
-.TP 1i
-\fIr\fP
-The range number to extract information from.  Must be an integer >= 0 and
-< the number of ranges returned by parse_ranges().
-.in -1i
-
-.SH EXAMPLES
-\fC
-.ta .25i +.25i +.25i +.25i
-.nf
-/*
- * simple example to take a list of ranges on the cmdline (in argv[1]), and
- * print a random number from within that range.
- */
-
-#include <stdio.h>
-
-main()
-{
-	extern int	parse_ranges(), range_min(), range_max(), range_mult();
-	extern long	random_range(), random_range_seed();
-	int		min, max, mult, nranges;
-	char		*ep, *rp;
-
-	random_range_seed(getpid());
-	if ((nranges = parse_ranges(argv[1], 0, INT_MAX, 1, NULL, &rp, &ep)) < 0) {
-		fprintf(stderr, "parse_ranges() failed:  %s\n", ep);
-		exit(1);
-	}
-
-	range = random_range(0, nranges-1, 1);
-	min = range_min(rp, range);
-	max = range_max(rp, range);
-	mult = range_mult(rp, range);
-
-	fprintf("%d\\n", random_range(min, max-1, mult));
-	exit(0);
-}
-\fP
-.DT
-.SH "SEE ALSO"
-random_range(3),
-random_range_seed(3),
-bytes_by_prefix(3).
-.SH DIAGNOSTICS
-parse_ranges() returns -1 on error or the number of ranges parsed.  No space
-will be malloc'd if parse_ranges() fails.  Error
-messages are passed back through the errptr parameter.  There are no error
-conditions for range_min(), range_max(), or range_mult().
diff --git a/doc/old/man3/random_range.3 b/doc/old/man3/random_range.3
deleted file mode 100644
index e7ab67271..000000000
--- a/doc/old/man3/random_range.3
+++ /dev/null
@@ -1,114 +0,0 @@
-.\"
-.\" $Id: random_range.3,v 1.1 2000/07/27 16:59:03 alaffin Exp $
-.\"
-.\" Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
-.\"
-.\" This program is free software; you can redistribute it and/or modify it
-.\" under the terms of version 2 of the GNU General Public License as
-.\" published by the Free Software Foundation.
-.\"
-.\" This program is distributed in the hope that it would be useful, but
-.\" WITHOUT ANY WARRANTY; without even the implied warranty of
-.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-.\"
-.\" Further, this software is distributed without any warranty that it is
-.\" free of the rightful claim of any third person regarding infringement
-.\" or the like.  Any license provided herein, whether implied or
-.\" otherwise, applies only to this software file.  Patent licenses, if
-.\" any, provided herein do not apply to combinations of this program with
-.\" other software, or any other product whatsoever.
-.\"
-.\" You should have received a copy of the GNU General Public License along
-.\" with this program; if not, write the Free Software Foundation, Inc.,
-.\" 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-.\"
-.\" Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
-.\" Mountain View, CA  94043, or:
-.\"
-.\" http://www.sgi.com
-.\"
-.\" For further information regarding this notice, see:
-.\"
-.\" http://oss.sgi.com/projects/GenInfo/NoticeExplan/
-.\"
-.TH random_range 3 07/25/2000 "Linux Test Project"
-.SH NAME
-random_range \- a set of routines for dealing with integer ranges, and random numbers in a range
-.SH SYNOPSIS
-.nf
-void random_range_seed(int seed)
-long random_range(int min, int max, int mult, char **errp)
-long random_rangel(long min, long max, long mult, char **errp)
-long long random_rangell(long long min, long long max,
-		         long long mult, char **errp)
-long random_bit(long mask)
-.fi
-.SH DESCRIPTION
-This is a set of routines for parsing numeric ranges, and choosing random
-numbers from a range.
-
-random_range() chooses a random number in the range min-max (inclusive) which
-is a multiple of mult.  min and max may be any integer, but mult must be
-a positive integer greater than 0.  errp is a char ** which is used to detect
-error conditions.  If errp is not NULL, *errp will be set to point to an
-error message.  If errp is NULL, error conditions cannot be detected by the
-caller.  If mult is 1 (the most common case), there are no possible error
-conditions, and the return value is guaranteed to be valid.
-
-random_range_seed() sets the random number generator seed to the specified
-value.
-
-random_bit() will return a randomly selected single bit bitmask from the bits
-set in mask.  The bit is randomly chosen using random_range().
-If mask is zero, zero is returned.
-
-random_range() functions uses lrand48() internally.  If the range is bigger
-than will fit in a 32 bit long (2G), lrand48() with a
-a internal recursive algorithm to produce a random number.
-
-.SH EXAMPLES
-\fC
-.ta .25i +.25i +.25i +.25i
-.nf
-#include <stdio.h>
-
-main(argc, argv)
-int	argc;
-char	**argv;
-{
-	int		r;
-	char		*errp;
-	extern void	random_range_seed();
-	extern long	random_range();
-
-	random_range_seed(getpid());
-
-	r = random_range(atoi(argv[1]), atoi(argv[2]), atoi(argv[3]), &errp);
-	if (errp == NULL) {
-		fprintf(stderr, "random_range failed:  %s\n", errp);
-		exit(1);
-	} else {
-		printf("%d\n", r);
-	}
-
-	exit(0);
-}
-\fP
-.fi
-
-.SH "SEE ALSO"
-lrand48(3c)
-.SH DIAGNOSTICS
-If random_range() fails, errp will point to NULL, and the return value will be
-undefined.  If mult is 1, there are no possible error conditions, so the return
-value is always valid in this case.
-
-.SH BUGS
-On CRAY systems, random_range(), random_rangel(), random_rangell()
-all have the 64 bit limit since int, long and long long are always 64 bits.
-
-On IRIX systems, random_range() can only produce a 32 number.
-random_rangel() when compiled as a 32 bit object is still limited to 32 bit
-number.  random_rangell() can be used to return a value bigger than 32 bits
-even when compiled as a 32 bit object.
-
diff --git a/doc/old/man3/random_range_seed.3 b/doc/old/man3/random_range_seed.3
deleted file mode 100644
index 2344b570f..000000000
--- a/doc/old/man3/random_range_seed.3
+++ /dev/null
@@ -1,114 +0,0 @@
-.\"
-.\" $Id: random_range_seed.3,v 1.1 2000/07/27 16:59:03 alaffin Exp $
-.\"
-.\" Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
-.\"
-.\" This program is free software; you can redistribute it and/or modify it
-.\" under the terms of version 2 of the GNU General Public License as
-.\" published by the Free Software Foundation.
-.\"
-.\" This program is distributed in the hope that it would be useful, but
-.\" WITHOUT ANY WARRANTY; without even the implied warranty of
-.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-.\"
-.\" Further, this software is distributed without any warranty that it is
-.\" free of the rightful claim of any third person regarding infringement
-.\" or the like.  Any license provided herein, whether implied or
-.\" otherwise, applies only to this software file.  Patent licenses, if
-.\" any, provided herein do not apply to combinations of this program with
-.\" other software, or any other product whatsoever.
-.\"
-.\" You should have received a copy of the GNU General Public License along
-.\" with this program; if not, write the Free Software Foundation, Inc.,
-.\" 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-.\"
-.\" Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
-.\" Mountain View, CA  94043, or:
-.\"
-.\" http://www.sgi.com
-.\"
-.\" For further information regarding this notice, see:
-.\"
-.\" http://oss.sgi.com/projects/GenInfo/NoticeExplan/
-.\"
-.TH random_range 3 07/25/2000 "Linux Test Project"
-.SH NAME
-random_range \- a set of routines for dealing with integer ranges, and random numbers in a range
-.SH SYNOPSIS
-.nf
-void random_range_seed(int seed)
-long random_range(int min, int max, int mult, char **errp)
-long random_rangel(long min, long max, long mult, char **errp)
-long long random_rangell(long long min, long long max,
-		         long long mult, char **errp)
-long random_bit(long mask)
-.fi
-.SH DESCRIPTION
-This is a set of routines for parsing numeric ranges, and choosing random
-numbers from a range.
-
-random_range() chooses a random number in the range min-max (inclusive) which
-is a multiple of mult.  min and max may be any integer, but mult must be
-a positive integer greater than 0.  errp is a char ** which is used to detect
-error conditions.  If errp is not NULL, *errp will be set to point to an
-error message.  If errp is NULL, error conditions cannot be detected by the
-caller.  If mult is 1 (the most common case), there are no possible error
-conditions, and the return value is guaranteed to be valid.
-
-random_range_seed() sets the random number generator seed to the specified
-value.
-
-random_bit() will return a randomly selected single bit bitmask from the bits
-set in mask.  The bit is randomly chosen using random_range().
-If mask is zero, zero is returned.
-
-random_range() functions uses lrand48() internally.  If the range is bigger
-than will fit in a 32 bit long (2G), lrand48() with a
-a internal recursive algorithm to produce a random number.
-
-.SH EXAMPLES
-\fC
-.ta .25i +.25i +.25i +.25i
-.nf
-#include <stdio.h>
-
-main(argc, argv)
-int	argc;
-char	**argv;
-{
-	int		r;
-	char		*errp;
-	extern void	random_range_seed();
-	extern long	random_range();
-
-	random_range_seed(getpid());
-
-	r = random_range(atoi(argv[1]), atoi(argv[2]), atoi(argv[3]), &errp);
-	if (errp == NULL) {
-		fprintf(stderr, "random_range failed:  %s\n", errp);
-		exit(1);
-	} else {
-		printf("%d\n", r);
-	}
-
-	exit(0);
-}
-\fP
-.fi
-
-.SH "SEE ALSO"
-lrand48(3c)
-.SH DIAGNOSTICS
-If random_range() fails, errp will point to NULL, and the return value will be
-undefined.  If mult is 1, there are no possible error conditions, so the return
-value is always valid in this case.
-
-.SH BUGS
-On CRAY systems, random_range(), random_rangel(), random_rangell()
-all have the 64 bit limit since int, long and long long are always 64 bits.
-
-On IRIX systems, random_range() can only produce a 32 number.
-random_rangel() when compiled as a 32 bit object is still limited to 32 bit
-number.  random_rangell() can be used to return a value bigger than 32 bits
-even when compiled as a 32 bit object.
-
diff --git a/doc/old/man3/tst_res.3 b/doc/old/man3/tst_res.3
deleted file mode 100644
index 56f722436..000000000
--- a/doc/old/man3/tst_res.3
+++ /dev/null
@@ -1,313 +0,0 @@
-.\"
-.\" $Id: tst_res.3,v 1.2 2008/06/10 05:52:02 subrata_modak Exp $
-.\"
-.\" Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
-.\"
-.\" This program is free software; you can redistribute it and/or modify it
-.\" under the terms of version 2 of the GNU General Public License as
-.\" published by the Free Software Foundation.
-.\"
-.\" This program is distributed in the hope that it would be useful, but
-.\" WITHOUT ANY WARRANTY; without even the implied warranty of
-.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-.\"
-.\" Further, this software is distributed without any warranty that it is
-.\" free of the rightful claim of any third person regarding infringement
-.\" or the like.  Any license provided herein, whether implied or
-.\" otherwise, applies only to this software file.  Patent licenses, if
-.\" any, provided herein do not apply to combinations of this program with
-.\" other software, or any other product whatsoever.
-.\"
-.\" You should have received a copy of the GNU General Public License along
-.\" with this program; if not, write the Free Software Foundation, Inc.,
-.\" 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-.\"
-.\" Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
-.\" Mountain View, CA  94043, or:
-.\"
-.\" http://www.sgi.com
-.\"
-.\" For further information regarding this notice, see:
-.\"
-.\" http://oss.sgi.com/projects/GenInfo/NoticeExplan/
-.\"
-.TH TST_RES 3 01/21/2011 "Linux Test Project"
-.SH NAME
-tst_resm \- Print result message
-.sp
-tst_resm_hexd \- Print result message, including specified buffer in hexadecimal format
-.sp
-tst_brkm \- Print result message and break remaining test cases
-.sp
-tst_old_flush \- Print any messages pending because of CONDENSE mode, and flush output stream
-.sp
-tst_exit \- Exit test with a meaningful exit value
-.sp
-tst_environ \- Keep results coming to original stdout
-.SH SYNOPSIS
-\fB#include "test.h"\fR
-.P
-.P
-\fBvoid tst_resm(int \fIttype\fB, char *\fItmesg, [arg ...]\fR)
-.P
-\fBvoid tst_resm_hexd(int \fIttype\fB, const void *\fIbuf\fB, size_t \fIsize\fB,
-char *\fItmesg, [arg ...]\fR)
-.P
-\fBvoid tst_brkm(int \fIttype\fB, void (*\fIfunc\fB)(), char *\fItmesg,
-[arg ...]\fR)
-.P
-\fBvoid tst_old_flush()
-.P
-\fBvoid tst_exit()
-.P
-\fBint  tst_environ()
-.P
-\fBextern int tst_count;
-.br
-extern int tst_range;
-.br
-\fR
-.SH DESCRIPTION
-.SS Introduction
-This library of functions are used by UNICOS tests to report results to
-standard output in a consistent manner.  It is assumed that tests using this
-library have a distinct number of test cases, and that each test case is
-distinct and uniquely identified by the test case number.  It is also assumed
-that test case results are printed in consecutive order, starting with 1.
-The library maintains a set of global variables (\fBTCID\fR, \fBTST_TOTAL\fR,
-\fBtst_count\fR), which are used by the various functions to format the
-results and to keep track of the current result reporting state (i.e. how many
-total test cases there are, and how many have been reported so far) for the
-calling test.
-.P
-The \fBTCID\fR and \fBTST_TOTAL\fR global variables are externed in the
-library, and MUST be defined/initialized by tests using the library.
-\fBTCID\fR must be set to the \fBT\fRest \fBC\fRase \fBID\fRentifier, and
-\fBTST_TOTAL\fR must be set to the total number of test cases that will be
-reported.
-.P
-The other global variables are available as externs to tests linked with
-tst_res.o.  \fBtst_count\fR is the running count of the number of test
-results that have been reported so far.  The library initializes it to 0, and
-it should not be modified by the test.
-The details are described below under the appropriate functions.
-.SS Arguments
-.RS 5
-.TP 10
-.I ttype
-test result type; one of \fBTPASS, TFAIL, TBROK, TCONF, TWARN\fR, or
-\fBTINFO\fR (explained below).
-.TP 10
-.I fname
-pointer to a character string holding the name of a file whose contents will
-be printed on a new line following \fItmesg\fR.  If this pointer is NULL, it
-is ignored.
-.TP 10
-.I tmesg, [arg ...]
-pointer to a character string containing a message explaining the test
-result.  This character string can contain percent-sign conversion
-specifications as in \fBprintf\fR(3C) with corresponding \fIarg\fR arguments
-following the \fItmesg\fR argument.
-.br
-\fBNOTE:\fR These routines use static space internally to hold the
-expanded message.  The maximum size allowed for an expanded message is
-2048 bytes.
-.TP 10
-.I func
-pointer to a function which performs either the cleanup necessary prior to
-exiting the test or some function executed at the end of each iteration of a
-loop.
-.TP 10
-.I buf
-pointer to a buffer whose contents will be printed in hexadecimal format.
-.TP 10
-.I size
-size of the buffer.
-.RE
-.SS Result Types
-The possible test result types defined in \fBtest.h\fR are as follows:
-.RS 5
-.TP 10
-.B TPASS
-The test case produced expected results.
-.TP 10
-.B TFAIL
-The test case produced unexpected results.
-.TP 10
-.B TBROK
-A resource needed to execute the test case was not available (e.g. a
-temporary file could not be opened).
-.TP 10
-.B TCONF
-The test case was not appropriate for the current hardware or software
-configuration (e.g. MLS was not enabled).
-.TP 10
-.B TWARN
-The testing procedure caused undesirable side effects that did not affect
-test results (e.g. a temporary file could not be removed after all test
-results were recorded).
-.TP 10
-.B TINFO
-An informative message about the execution of the test that does not
-correspond to a test case result and does not indicate a problem.
-.RE
-.SS Function Descriptions
-
-\fBtst_resm()\fR and \fBtst_resm_hexd()\fR are the basic
-result reporting functions. They report 1 or more test case results of the
-specified \fIttype\fR.  All result types are valid for these functions.  The
-\fBtst_range\fR global variable indicates the number of results that will be
-reported for each call to one of these functions.  It is initialized by the
-library to 1, but may be set to a value > 1 by the test.  Each call to one of
-these functions will result in \fBtst_range\fR test case results being
-reported, each with an identical message (\fItmesg\fR).  \fBtst_range\fR is
-always reset to 1 by the library before returning to the caller.
-.P
-\fBtst_brk()\fR and \fBtst_brkm()\fR are used to report results for all test
-cases remaining in the test, and then call a cleanup function.  The only
-result types that are valid for these functions are: \fBTFAIL, TBROK,
-and TCONF\fR.  When called with a \fIttype\fR of \fBTFAIL\fR or
-\fBTBROK\fR, one result of the specified \fIttype\fR will be printed,
-followed by results of type \fBTBROK\fR for the remaining test cases.  When
-called with a \fIttype\fR of \fBTCONF\fR, the specified
-\fIttype\fR will be printed for all remaining test cases.  If \fIfunc\fR is
-not NULL, \fBtst_brk()\fR and \fBtst_brkm()\fR will call \fIfunc\fR after all
-results have been printed.  If the call to \fIfunc\fR returns,
-\fBtst_brk()\fR and \fBtst_brkm()\fR will then call \fBtst_exit()\fR.  If
-\fIfunc\fR is NULL, \fBtst_brk()\fR and \fBtst_brkm()\fR return to the caller
-after all results have been printed.  If \fBtst_brk()\fR is called with a
-\fIfname\fR argument, the contents of the file will only be printed for the
-first reported result.  \fBtst_brk()\fR takes the \fIfname\fR argument
-whereas \fBtst_brkm()\fR does not.
-.P
-\fBtst_old_flush()\fR is used to print any results pending because of
-\fBCONDENSE\fR or \fBNOPASS\fR modes (described below), and flushes the
-output stream.
-.P
-\fBtst_exit()\fR is used to allow tests to exit with a meaningful exit
-value.  A bit is set in the exit value for each of the non passing test
-case result types (TFAIL, TBROK, and TWARN) encountered by the library.
-Thus any bit which is set in the exit value indicates that the
-corresponding result flag was used at least once in the test run.
-.P
-The current bit fields for the result types are as follows:
-.RS 5
-.TP 10
-TPASS
-0000	/* .... .... */
-.TP 10
-TFAIL
-0001	/* .... ...1 */
-.TP 10
-TBROK
-0002	/* .... ..1. */
-.TP 10
-TWARN
-0004	/* .... .1.. */
-.TP 10
-TINFO
-0020	/* ...1 .... */
-.TP 10
-TCONF
-0040	/* ..1. .... */
-.RE
-.P
-NOTE: \fBTPASS and TINFO\fR do not have an effect
-on the test program exit status.
-.P
-\fBtst_environ()\fR is used to ensure that results reported by this library
-will go to the original stdout, even if the test changes the original stdout
-to another file, or closes it.  A test may want to do this in order to
-redirect output that normally goes to stdout (e.g. printf() output) to a
-file.  \fBtst_environ()\fR returns 0 upon successful completion, and -1 if it
-encountered any problems.
-.SS Output Modes
-Four output display modes are supported by the \fBtst_resm()\fR family of
-functions to enhance output readability. The active mode is controlled via
-the environment variable \fBTOUTPUT\fR, which must be set prior to the start
-of the test in order to have any effect (see \fBksh\fR(1) for information on
-environment variables).  The supported modes are as follows:
-.RS 5
-.TP 15
-.B VERBOSE
-A test result output line is generated for each test result.  This is the
-default mode.
-.TP 15
-.B CONDENSE
-Consecutive, identical PASS, FAIL, BROK, CONF, and RETR test results are
-condensed into one output line.  The test case number field contains the range
-of results involved.  WARN and INFO output lines are not condensed, but
-printed as usual.
-.TP 15
-.B NOPASS
-All PASS, CONF, INFO, and RETR output lines are discarded (i.e. not printed),
-and consecutive, identical FAIL and BROK output lines are condensed as in
-\fBCONDENSE\fR mode.  WARN output lines are printed as usual.
-.TP 15
-.B DISCARD
-All output lines are discarded.
-.RE
-.SH EXAMPLES
-.nf
-#include "test.h"
-
-char *TCID = "tsttcs01"; /* set test case identifier */
-int TST_TOTAL = 15;      /* set total number of test results */
-
-main()
-{
-		.
-		.
-	/* a successful test result */
-	tst_resm(TPASS, "\fIwhat was tested\fR");
-		.
-		.
-
-	/* break all remaining test results */
-	tst_brkm(TBROK, cleanup, "\fIwhat didn't work\fR");
-		/* or */
-	tst_brk(TBROK, file, cleanup, "\fIwhat didn't work\fR");
-		.
-		.
-
-	/* exit after all test results have been passed to tst_res */
-	tst_exit();
-}
-.fi
-.P
-Sample output:
-.RS 5
-.nf
-tsttcs01    1       PASS  :  Able to create MAXUP processes
-tsttcs01    2       FAIL  :  Too many processes (MAXUP+1) created
-tsttcs01    3       BROK  :  tabinfo(PROCTAB, &tbs) failed; errno = 13: Permission denied
-.fi
-.SH "SEE ALSO"
-tst_setup(1),
-printf(3C),
-ksh(1).
-.SH DIAGNOSTICS
-.P
-A WARN result message will be printed if any of the following occur:
-.RS 5
-.P
-If an invalid test type is specified.
-.P
-If \fBtst_count\fR is negative.
-.P
-If one of the \fBtst_brk[m]()\fR routines is called with a test type
-other than \fBTFAIL, TBROK, TCONF\fR.
-.P
-If there are any problems opening/reading/writing the contents of \fIfname\fR.
-.RE
-.SH LIMITATIONS
-If \fIfname\fR is NULL and \fItmesg\fR is NULL or empty, the result message
-will be empty.  This allows a test to not print a message for a result, but
-it is not advised.
-.SH NOTES
-In multithreaded environment, output of \fBtst_resm_hexd()\fR may be interleaved
-with messages produced by other threads.
-.SH BUGS
-.P
-The programmer is free to alter the value of \fBtst_count\fR causing possible
-test result order problems.
diff --git a/doc/old/man3/tst_sig.3 b/doc/old/man3/tst_sig.3
deleted file mode 100644
index 7550644fd..000000000
--- a/doc/old/man3/tst_sig.3
+++ /dev/null
@@ -1,141 +0,0 @@
-.\"
-.\" $Id: tst_sig.3,v 1.1 2000/07/27 16:59:03 alaffin Exp $
-.\"
-.\" Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
-.\"
-.\" This program is free software; you can redistribute it and/or modify it
-.\" under the terms of version 2 of the GNU General Public License as
-.\" published by the Free Software Foundation.
-.\"
-.\" This program is distributed in the hope that it would be useful, but
-.\" WITHOUT ANY WARRANTY; without even the implied warranty of
-.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-.\"
-.\" Further, this software is distributed without any warranty that it is
-.\" free of the rightful claim of any third person regarding infringement
-.\" or the like.  Any license provided herein, whether implied or
-.\" otherwise, applies only to this software file.  Patent licenses, if
-.\" any, provided herein do not apply to combinations of this program with
-.\" other software, or any other product whatsoever.
-.\"
-.\" You should have received a copy of the GNU General Public License along
-.\" with this program; if not, write the Free Software Foundation, Inc.,
-.\" 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-.\"
-.\" Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
-.\" Mountain View, CA  94043, or:
-.\"
-.\" http://www.sgi.com
-.\"
-.\" For further information regarding this notice, see:
-.\"
-.\" http://oss.sgi.com/projects/GenInfo/NoticeExplan/
-.\"
-.TH TST_SIG 3 07/25/2000 "Linux Test Project"
-.SH NAME
-tst_sig \- set up for unexpected signals
-.SH SYNOPSIS
-.nf
-\fB
-#include "test.h"
-
-void tst_sig(fork_flag, handler, cleanup)
-char *fork_flag;
-int (*handler)();
-void (*cleanup)();
-\fR
-.fi
-.SH DESCRIPTION
-.P
-\fItst_sig\fR is used by UNICOS test case programs
-to set up signal handling functions for unexpected
-signals.  This provides test cases with a graceful means
-of exiting following an unexpected interruption by a signal.
-\fItst_sig\fR should be called only once by a test
-program.
-.P
-The \fIfork_flag\fR parameter is used to tell \fItst_sig\fR
-whether or not to ignore the SIGCHLD signal caused by the death of a
-child process that had previously been created by the
-\fIfork\fR(2) system call (see \fIsignal\fR(2) for more
-information on the SIGCHLD signal).
-.P
-Setting \fIfork_flag\fR to FORK will cause \fItst_sig\fR to
-ignore the SIGCHLD signal.  This option should be set if the
-test program directly (eg. call \fIfork\fR(2)) or indirectly
-(eg. call \fIsystem\fR(3S)) creates a child process.
-.P
-Setting \fIfork_flag\fR to NOFORK will cause \fItst_sig\fR to
-treat the SIGCHLD signal just as any other unexpected
-signal (ie. the \fIhandler\fR will be called).
-This option should be set by any test program which does not
-directly or indirectly create any child processes.
-.P
-The \fIhandler\fR parameter is
-a pointer to a function returning type int which is
-executed upon the receipt of an unexpected signal.
-The test program may pass a pointer to a signal handling
-function or it may elect to use a \fIdefault handler\fR
-supplied by \fItst_sig\fR.
-
-The \fIdefault handler\fR is specified by passing DEF_HANDLER
-as the \fIhandler\fR argument.  Upon receipt of an unexpected
-signal, the \fIdefault handler\fR will generate
-\fItst_res\fR(3) messages for all test results that had
-not been completed at the time of the signal, execute the
-\fIcleanup\fR routine, if provided, and call \fItst_exit\fR.
-Note: if the \fIdefault handler\fR is used, the variables
-\fBTCID\fR and \fBtst_count\fR must be defined and available to
-\fItst_sig\fR (see \fItst_res\fR(3)).
-.P
-The \fIcleanup\fR parameter is a pointer to a user-defined
-function returning type void which is executed
-by the \fIdefault handler\fR.  The \fIcleanup\fR function
-should remove any files, directories, processes, etc. created
-by the test program.
-If no cleanup is required, this parameter should be set to NULL.
-
-.SH EXAMPLES
-
-.nf
-#include "test.h"
-
-/*
- * the TCID and TST_TOTAL variables must be available to tst_sig
- * if the \fIdefault handler\fR is used.  The \fIdefault handler\fR will call
- * \fItst_res\fR(3) and will need this information.
- */
-int TCID = "tsttcs01";  /* set test case identifier */
-int TST_TOTAL = 5;        /* set total number of test results */
-
-
-	void tst_sig();
-
-	/*
-	 * set up for unexpected signals:
-	 *		no \fIfork\fR() system calls will be executed during the test run
-	 *		use the default signal handler provided by \fItst_sig\fR
-	 *		no cleanup is necessary
-	 */
-	tst_sig(NOFORK, DEF_HANDLER, NULL);
-
-
-	void tst_sig(), cleanup();
-	int handler();
-
-	/*
-	 * set up for unexpected signals:
-	 *		\fIfork\fR() system calls will be executed during the test run
-	 *		use user-defined signal handler
-	 *		use cleanup
-	 */
-	tst_sig(FORK, handler, cleanup);
-
-.fi
-.SH "SEE ALSO"
-signal(2),
-tst_setup(1).
-.SH DIAGNOSTICS
-.P
-\fItst_sig\fR will output warnings in standard \fItst_res\fR
-format if it cannot set up the signal handlers.
diff --git a/doc/old/man3/tst_tmpdir.3 b/doc/old/man3/tst_tmpdir.3
deleted file mode 100644
index b8a8d7994..000000000
--- a/doc/old/man3/tst_tmpdir.3
+++ /dev/null
@@ -1,76 +0,0 @@
-.\"
-.\" $Id: tst_tmpdir.3,v 1.1 2000/07/27 16:59:03 alaffin Exp $
-.\"
-.\" Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
-.\"
-.\" This program is free software; you can redistribute it and/or modify it
-.\" under the terms of version 2 of the GNU General Public License as
-.\" published by the Free Software Foundation.
-.\"
-.\" This program is distributed in the hope that it would be useful, but
-.\" WITHOUT ANY WARRANTY; without even the implied warranty of
-.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-.\"
-.\" Further, this software is distributed without any warranty that it is
-.\" free of the rightful claim of any third person regarding infringement
-.\" or the like.  Any license provided herein, whether implied or
-.\" otherwise, applies only to this software file.  Patent licenses, if
-.\" any, provided herein do not apply to combinations of this program with
-.\" other software, or any other product whatsoever.
-.\"
-.\" You should have received a copy of the GNU General Public License along
-.\" with this program; if not, write the Free Software Foundation, Inc.,
-.\" 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-.\"
-.\" Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
-.\" Mountain View, CA  94043, or:
-.\"
-.\" http://www.sgi.com
-.\"
-.\" For further information regarding this notice, see:
-.\"
-.\" http://oss.sgi.com/projects/GenInfo/NoticeExplan/
-.\"
-.TH TST_TMPDIR 3 07/25/2000 "Linux Test Project"
-.SH NAME
-tst_tmpdir \- create a unique testing directory and make it current.
-.br
-tst_rmdir \- remove the directory created by \fBtst_tmpdir\fR.
-.SH SYNOPSIS
-\fBvoid tst_tmpdir()
-.P
-void tst_rmdir()
-.P
-extern char *TESTDIR;\fR
-.SH DESCRIPTION
-The \fBtst_tmpdir()\fR function uses the first three characters of the
-\fBTCID\fR global variable as the prefix in forming a unique directory name
-(via \fBtempnam\fR(3S)).  The directory is then created and made the current
-working directory.
-.P
-If \fBtst_tmpdir()\fR cannot form a unique directory name, create the
-directory, or \fBchdir\fR to the directory, it uses \fBtst_brk()\fR to issue
-"BROK" messages for all test cases.  It then exits via \fBtst_exit()\fR.
-Because \fBtst_tmpdir()\fR exits in the event of a problem, a test must call
-it \fBbefore\fR performing any operations that would require running a
-cleanup routine.
-.P
-The \fBtst_rmdir()\fR function recursively removes the directory created by
-\fBtst_tmpdir()\fR.  This function should be used \fBonly\fR as a companion
-to \fBtst_tmpdir()\fR and should be called immediately prior to the test
-exiting via \fBtst_exit()\fR.
-.P
-\fBtst_rmdir()\fR uses the \fBsystem\fR(3S) library routine (which in turn
-calls \fBfork\fR(2)), so tests that use it \fBcannot\fR treat SIGCHLD as an
-unexpected signal.
-.P
-Users may gain access to the name of the temporary directory by declaring the
-external character pointer \fBTESTDIR\fR.
-.SH DIAGNOSTICS
-The \fBtst_rmdir()\fR function will check the \fBTESTDIR\fR global variable
-to ensure that the user is not attempting to remove the root directory or
-some unspecified directories with a "*" parameter.  All error/warning
-messages are delivered through \fBtst_resm()\fR.
-.SH "SEE ALSO"
-fork(2), system(3S), tst_res(3), tmpnam(3S).
-
diff --git a/doc/old/man3/usctest.3 b/doc/old/man3/usctest.3
deleted file mode 100644
index df3c5ad12..000000000
--- a/doc/old/man3/usctest.3
+++ /dev/null
@@ -1,164 +0,0 @@
-.\" $Id: usctest.3,v 1.2 2000/08/31 18:40:28 nstraz Exp $
-.\"
-.\" Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
-.\"
-.\" This program is free software; you can redistribute it and/or modify it
-.\" under the terms of version 2 of the GNU General Public License as
-.\" published by the Free Software Foundation.
-.\"
-.\" This program is distributed in the hope that it would be useful, but
-.\" WITHOUT ANY WARRANTY; without even the implied warranty of
-.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-.\"
-.\" Further, this software is distributed without any warranty that it is
-.\" free of the rightful claim of any third person regarding infringement
-.\" or the like.  Any license provided herein, whether implied or
-.\" otherwise, applies only to this software file.  Patent licenses, if
-.\" any, provided herein do not apply to combinations of this program with
-.\" other software, or any other product whatsoever.
-.\"
-.\" You should have received a copy of the GNU General Public License along
-.\" with this program; if not, write the Free Software Foundation, Inc.,
-.\" 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-.\"
-.\" Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
-.\" Mountain View, CA  94043, or:
-.\"
-.\" http://www.sgi.com
-.\"
-.\" For further information regarding this notice, see:
-.\"
-.\" http://oss.sgi.com/projects/GenInfo/NoticeExplan/
-.\"
-.TH USCTEST 3 01/21/2011 "Linux Test Project"
-.SH NAME
-usctest \-  macros and libraries for common functions in system call tests
-.SH SYNOPSIS
-\fBRoutines:\fR
-.br
-.in +1
-char *\fBparse_opts(\fI...\fB)\fR
-.in -1
-.sp
-\fBMacros\fR
-.in +1
-.br
-\fBTEST_PAUSE\fR
-.br
-\fBTEST(\fIsyscall\fB)\fR
-.br
-.\"\fBTEST_CALLER(\fIsyscall\fB, \fIpid\fB)\fR
-.\".br
-\fBTEST_VOID(\fIsyscall\fB)\fR
-.br
-\fBTEST_CLEANUP\fR
-.br
-\fBTEST_LOOPING(\fIcounter\fB)\fR
-.br
-\fBTEST_ERROR_LOG(\fIerrno\fB)\fR
-.br
-\fBTEST_EXP_ENOS(\fIarray\fB)\fR
-.in -1
-.sp
-\fBGlobal Variable(s)\fR (see \fBparse_opts(3)\fR for complete list):
-.br
-.in +1
-int \fBTEST_RETURN\fR;	/* set by the \fBTEST\fR macro to the return code from \fIsyscall\fR */
-.br
-int \fBTEST_ERRNO\fR;	/* set by the \fBTEST\fR macro to the value of \fBerrno\fR after \fIsyscall\fR returns */
-.br
-/* All STD_* variables referenced below are set by the \fBparse_opts(3)\fR routine. */
-.in -1
-
-.SH DESCRIPTION
-The \fBTEST_PAUSE\fR macro checks if the global variable STD_PAUSE is set.  If so, it
-pauses for a SIGUSR1 before continuing execution.  The signal handler used does nothing.
-After the signal is processed, the previous action is replaced for SIGUSR1.
-.sp
-The \fBTEST(\fIsyscall\fB)\fR macro executes (\fIsyscall\fR) and times its execution.
-It saves the max time, min time, accumulated time, and
-execution count, if STD_TIMING_ON is set.
-.sp
-.\"The\fBTEST_CALLER(\fIsyscall\fB, \fIpid\fB)\fR macro executes (\fIsyscall\fR) and times its execution.
-.\"It saves the max time, min time, accumulated time, and
-.\"execution count, if STD_TIMING_ON is set and if \fIpid\fR is equal to the current pid.
-.\".sp
-The \fBTEST_VOID(\fIsyscall\fB)\fR macro works exactly the same as the \fBTEST()\fR
-macro except that it does NOT set the global \fBTEST_RETURN\fR.  It is intended
-to be used with system calls that do not have a return value.
-.sp
-The \fBTEST_CLEANUP\fR macro prints timing statistics,
-accumulated through the TEST macro, if STD_TIMING_ON is set.  Also, prints the \fBerrno\fR return
-counts as logged by the \fBTEST_ERROR_LOG\fR macro, if STD_ERR_LOG is set.  \fBTEST_CLEANUP\fR uses
-\fBtst_resm(3)\fR to output this information.
-.sp
-The \fBTEST_LOOPING(\fIcounter\fB)\fR macro checks \fIcounter\fR against
-the global variable STD_LOOP_COUNTER.  If \fIcounter\fR is less than STD_LOOP_COUNTER or STD_INFINITE
-is set, it returns TRUE.
-.sp
-The \fBTEST_ERROR_LOG\fR macro records the return of \fIerrno\fR as unexpected, unless the option to
-turn it off is specified on the command line.
-.sp
-The \fBTEST_EXP_ENOS(\fIarray\fB)\fR macro sets an internal flag for each errno in \fIarray\fR, indicating
-that the errno is expected at some point in the test.  This is used by the TEST_CLEANUP macro to determine
-which errnos are expected when printing the log.  The \fIarray\fR must be zero terminated.
-.sp
-The \fBparse_opts\fR routine parses the command line (see \fBparse_opts(3)\fR).  All STD_* global
-variables used are set by the \fBparse_opts(3)\fR routine.
-
-.SH EXAMPLES
-Below is a partial template of a system call test using these routines, macros, and global variables.
-
-.nf
-void setup(void)
-{
-	TEST_PAUSE;	/* Pause  if option specified */
-}
-
-void cleanup(void)
-{
-	TEST_CLEANUP;
-}
-
-int main(int argc, char *argv[])
-{
-	int lc;
-	char *msg;
-
-	int exp_enos[]={EACCESS, 0};
-
-
-	TEST_EXP_ENOS(exp_enos);	/* set expected errnos */
-
-	setup();	/* execute setup */
-
-	/* parse options */
-	msg = parse_opts(ac, av, NULL, NULL);
-
-	/* Check parse_opts return */
-
-	for (lc=0; TEST_LOOPING(lc); lc++) {
-		TEST(open("file", O_RDWR))
-
-		if (TEST_RETURN == -1) {
-			TEST_ERROR_LOG(TEST_ERRNO)
-			/* BREAK test case, or whatever... */
-		}
-
-	}
-
-	cleanup();
-	tst_exit();
-}
-.fi
-
-.SH "SEE ALSO"
-parse_opts(3).
-
-.SH "RETURN VALUES"
-The TEST_LOOPING macro evaluates to TRUE (1) or FALSE (0), and is intended for
-use in while or for loops.  The TEST macro places the return value from
-\fIsyscall\fR in the global variable TEST_RETURN and the errno in the global
-variable TEST_ERRNO.  The \fBTEST_PAUSE\fR, \fBTEST_CLEANUP\fR,
-\fBTEST_ERROR_LOG\fR, and \fBTEST_EXP_ENOS\fR macros do not have any return
-values.
-- 
2.45.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
