Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97B5C4167B
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 13:43:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6033C3CDA4C
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 14:43:35 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F7B43CD9C4
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 14:43:24 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 297B260062C
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 14:43:22 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0DF9D2198B;
 Tue, 28 Nov 2023 13:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1701179002;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bv7oQHODs4SbFx5fOkbbl+7sfKUGKM9WI1jM8HCU8XE=;
 b=qXH3w2qnVTapkMwZbKKOgy0SiREJG82s8wvqi/+mBf1LBK+oplzKxSNXI/B8Tx4uxjdZ5W
 b/zx7+gEeiUXFDwCJeQPN2LTTbr/muGnr28A5V7aD+MR/C6PtaqRbZ5WOJUDIW7uRazffZ
 27LV1zewC/Ko/up0KLWAkr5i3rs0O9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1701179002;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bv7oQHODs4SbFx5fOkbbl+7sfKUGKM9WI1jM8HCU8XE=;
 b=pPN5Qpl6UVd+F6eoqkW43bNt4mjRTSsvItdp/Xa+JB2v73gtD5LsTR8fFKZJhxeOSJM1RJ
 wQo1qeJUwnespoAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E562C139FC;
 Tue, 28 Nov 2023 13:43:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 9uD2NXnuZWV8IwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 28 Nov 2023 13:43:21 +0000
Date: Tue, 28 Nov 2023 14:43:20 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Xiao Yang <yangx.jy@fujitsu.com>
Message-ID: <20231128134320.GA401671@pevik>
References: <20231102080535.63847-1-xuyang2018.jy@fujitsu.com>
 <9bcca18a-42a8-2200-c6c1-0f97b42e11e6@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9bcca18a-42a8-2200-c6c1-0f97b42e11e6@fujitsu.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.47 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.17)[-0.862];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] pathconf01: Convert to new API
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

> On 2023/11/2 16:05, Yang Xu wrote:
> > * Simplify code and description
> > * Use TST_macros

> > Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> > ---
> >   .../kernel/syscalls/pathconf/pathconf01.c     | 251 +++---------------
> >   1 file changed, 33 insertions(+), 218 deletions(-)

> > diff --git a/testcases/kernel/syscalls/pathconf/pathconf01.c b/testcases/kernel/syscalls/pathconf/pathconf01.c
> > index 362bae94f..9b8b99d48 100644
> > --- a/testcases/kernel/syscalls/pathconf/pathconf01.c
> > +++ b/testcases/kernel/syscalls/pathconf/pathconf01.c
> > @@ -1,237 +1,52 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
Unfortunately GPL-2.0-only
> >   /*
> >    * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
> > - *
> > - * This program is free software; you can redistribute it and/or modify it
> > - * under the terms of version 2 of the GNU General Public License as
> > - * published by the Free Software Foundation.
Because there is no "at any later version".

> > - *
> > - * This program is distributed in the hope that it would be useful, but
> > - * WITHOUT ANY WARRANTY; without even the implied warranty of
> > - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> > - *
> > - * Further, this software is distributed without any warranty that it is
> > - * free of the rightful claim of any third person regarding infringement
> > - * or the like.  Any license provided herein, whether implied or
> > - * otherwise, applies only to this software file.  Patent licenses, if
> > - * any, provided herein do not apply to combinations of this program with
> > - * other software, or any other product whatsoever.
> > - *
> > - * You should have received a copy of the GNU General Public License along
> > - * with this program; if not, write the Free Software Foundation, Inc.,
> > - * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> > - *
> > - * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
> > - * Mountain View, CA  94043, or:
> > - *
> > - * http://www.sgi.com
> > - *
> > - * For further information regarding this notice, see:
> > - *
> > - * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
> > - *
> > + * Copyright (c) Linux Test Project, 2000-2023
> > + * Authors: William Roske, Dave Fenner
> >    */
> > -/* $Id: pathconf01.c,v 1.5 2009/11/02 13:57:17 subrata_modak Exp $ */
> > -/**********************************************************
> > - *
> > - *    OS Test - Silicon Graphics, Inc.
> > - *
> > - *    TEST IDENTIFIER	: pathconf01
> > - *
> > - *    EXECUTED BY	: anyone
> > - *
> > - *    TEST TITLE	: Basic test for pathconf(2)
> > - *
> > - *    PARENT DOCUMENT	: usctpl01
> > - *
> > - *    TEST CASE TOTAL	: 6
> > - *
> > - *    WALL CLOCK TIME	: 1
> > - *
> > - *    CPU TYPES		: ALL
> > - *
> > - *    AUTHOR		: William Roske
> > - *
> > - *    CO-PILOT		: Dave Fenner
> > - *
> > - *    DATE STARTED	: 03/30/92
> > - *
> > - *    INITIAL RELEASE	: UNICOS 7.0
> > - *
> > - *    TEST CASES
> > - *
> > - *	1.) pathconf(2) returns...(See Description)
> > - *
> > - *    INPUT SPECIFICATIONS
> > - *	The standard options for system call tests are accepted.
> > - *	(See the parse_opts(3) man page).
> > - *
> > - *    OUTPUT SPECIFICATIONS
> > - *
> > - *    DURATION
> > - *	Terminates - with frequency and infinite modes.
> > - *
> > - *    SIGNALS
> > - *	Uses SIGUSR1 to pause before test if option set.
> > - *	(See the parse_opts(3) man page).
> > - *
> > - *    RESOURCES
> > - *	None
> > - *
> > - *    ENVIRONMENTAL NEEDS
> > - *      No run-time environmental needs.
> > - *
> > - *    SPECIAL PROCEDURAL REQUIREMENTS
> > - *	None
> > - *
> > - *    INTERCASE DEPENDENCIES
> > - *	None
> > - *
> > - *    DETAILED DESCRIPTION
> > - *	This is a Phase I test for the pathconf(2) system call.  It is intended
> > - *	to provide a limited exposure of the system call, for now.  It
> > - *	should/will be extended when full functional tests are written for
> > - *	pathconf(2).
> > - *
> > - *	Setup:
> > - *	  Setup signal handling.
> > - *	  Pause for SIGUSR1 if option specified.
> > - *
> > - *	Test:
> > - *	 Loop if the proper options are given.
> > - *	  Execute system call
> > - *	  Check return code, if system call failed (return=-1)
> > - *		Log the errno and Issue a FAIL message.
> > - *	  Otherwise, Issue a PASS message.
> > - *
> > - *	Cleanup:
> > - *	  Print errno log and/or timing stats if options given
> > - *
> > +
> > +/*\
> > + * [Description]
> >    *
> > - *#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#**/
> > + * Check the basic functionality of the pathconf() system call.
> > + */
> > -#include <unistd.h>
> > -#include <errno.h>
> > -#include <string.h>
> > -#include <signal.h>
> > -#include "test.h"
> > +#include <stdlib.h>
> > +#include "tst_test.h"
> > -void setup();
> > -void cleanup();
> > -void help();
> > +static char *path;
> > -struct pathconf_args {
> > -	char *define_tag;
> > +static struct tcase {
> > +	char *name;
> >   	int value;
> > -} args[] = {
> > -	{
> > -	"_PC_LINK_MAX", _PC_LINK_MAX}, {
> > -	"_PC_NAME_MAX", _PC_NAME_MAX}, {
> > -	"_PC_PATH_MAX", _PC_PATH_MAX}, {
> > -	"_PC_PIPE_BUF", _PC_PIPE_BUF}, {
> > -	"_PC_CHOWN_RESTRICTED", _PC_CHOWN_RESTRICTED}, {
> > -	"_PC_NO_TRUNC", _PC_NO_TRUNC}, {
> > -	NULL, 0}
> > +} tcases[] = {
> > +	{"_PC_LINK_MAX", _PC_LINK_MAX},

Please use this:
#define NAME_DESC(x) x, #x

} tcases[] = {
	{ NAME_DESC(_PC_NAME_MAX) },
	{ NAME_DESC(_PC_PATH_MAX) },
	...

> > +	{"_PC_NAME_MAX", _PC_NAME_MAX},
> > +	{"_PC_PATH_MAX", _PC_PATH_MAX},
> > +	{"_PC_PIPE_BUF", _PC_PIPE_BUF},
> > +	{"_PC_CHOWN_RESTRICTED", _PC_CHOWN_RESTRICTED},
> > +	{"_PC_NO_TRUNC", _PC_NO_TRUNC},
> > +	{NULL, 0},
> Hi Yang,

> What is the purpose of the last entry? IMO, it is equal to the first entry.
> Other than that, it looks good to me.
Very good question, I wonder as well.

BTW there are many of others:
https://www.gnu.org/software/libc/manual/html_node/Pathconf.html

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
