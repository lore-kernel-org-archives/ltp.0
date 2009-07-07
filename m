Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <matthltc@us.ibm.com>) id 1MO0AS-00072w-0Z
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 02:12:24 +0000
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MO0AO-0008Ub-6e
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 02:12:23 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n6728Hnr031970
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Jul 2009 20:08:17 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n672CI9e248228
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Jul 2009 20:12:18 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n672CHkO017007
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Jul 2009 20:12:17 -0600
Date: Mon, 6 Jul 2009 19:12:15 -0700
From: Matt Helsley <matthltc@us.ibm.com>
Message-ID: <20090707021215.GC32310@count0.beaverton.ibm.com>
References: <364299f40907061818q7cda3465vffb00323af18c5f8@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <364299f40907061818q7cda3465vffb00323af18c5f8@mail.gmail.com>
Subject: Re: [LTP] [PATCH 4/4] Make makefiles more autoconf friendly
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

(Reviewing inline patches is much easier..)

Most of this looks good to me.

Introducing include/mk seems like a very good idea -- incredible numbers of
Makefiles could be factored into common includes there. It would
probably make maintenance of the LTP Makefiles alot easier in the long
run.

On Mon, Jul 06, 2009 at 06:18:10PM -0700, Garrett Cooper wrote:
> 1. Many Makefiles have hardcoded /opt/ltp paths in them. Let's make
> things more modular by making sure the files either get parsed by
> autoconf with configure, or instead of having the hardcoded path,
> include include/mk/config.mk (which is in and of itself a configure'd
> file), thus ensuring feature parity in all of our Makefiles.
> 2. These files also contain various cleanup items with other vars and
> rules conforming to the Draft 1 spec of master_rules.mk.
> 
> This requires PATCH 2/4 and PATCH 3/4.
> 
> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

<snip>

> Index: ltp-devel.spec
> ===================================================================
> RCS file: ltp-devel.spec
> diff -N ltp-devel.spec
> --- ltp-devel.spec	19 May 2009 09:39:11 -0000	1.6
> +++ /dev/null	1 Jan 1970 00:00:00 -0000
> @@ -1,68 +0,0 @@
> -#
> -# RPM Package Manager (RPM) spec file for ltp-devel
> -#
> -Summary: Linux Test Project (LTP) Software Development Kit (SDK)
> -Name: ltp-devel
> -Version: 2.0
> -Release: 0.0
> -Prefix: /opt/ltp
> -License: GPL
> -Group: Development/Libraries
> -URL: http://www.linuxtestproject.org
> -Vendor: IBM Corp
> -Packager: Subrata Modak <subrata.modak@@in.ibm.com>
> -AutoReqProv:    0
> -Provides:       LTP
> -#ExclusiveArch:  i386
> -ExclusiveOS:    linux
> -%description
> -This is a development package of the Linux Test Project (LTP).
> -It is intended to be used to build testcases using the provided API.
> -%files
> -/opt/ltp/lib/libltp.a
> -/usr/share/pkgconfig/ltp.pc
> -/opt/ltp/bin/ltp-pan
> -/opt/ltp/bin/ltp-scanner
> -/opt/ltp/bin/ltp-bump
> -/opt/ltp/include/linux_syscall_numbers.h
> -/opt/ltp/include/libtestsuite.h
> -/opt/ltp/include/usctest.h
> -/opt/ltp/include/string_to_tokens.h
> -/opt/ltp/include/str_to_bytes.h
> -/opt/ltp/include/databin.h
> -/opt/ltp/include/open_flags.h
> -/opt/ltp/include/write_log.h
> -/opt/ltp/include/dataascii.h
> -/opt/ltp/include/forker.h
> -/opt/ltp/include/compiler.h
> -/opt/ltp/include/test.h
> -/opt/ltp/include/tlibio.h
> -/opt/ltp/include/pattern.h
> -/opt/ltp/include/file_lock.h
> -/opt/ltp/include/random_range.h
> -/opt/ltp/include/search_path.h
> -/opt/ltp/include/rmobj.h
> -/usr/share/man/man3/tst_tmpdir.3
> -/usr/share/man/man3/random_range_seed.3
> -/usr/share/man/man3/pattern.3
> -/usr/share/man/man3/parse_ranges.3
> -/usr/share/man/man3/usctest.3
> -/usr/share/man/man3/random_range.3
> -/usr/share/man/man3/forker.3
> -/usr/share/man/man3/rmobj.3
> -/usr/share/man/man3/parse_open_flags.3
> -/usr/share/man/man3/tst_res.3
> -/usr/share/man/man3/write_log.3
> -/usr/share/man/man3/str_to_bytes.3
> -/usr/share/man/man3/tst_set_error.3
> -/usr/share/man/man3/parse_opts.3
> -/usr/share/man/man3/string_to_tokens.3
> -/usr/share/man/man3/tst_sig.3
> -/usr/share/man/man3/get_attrib.3
> -/usr/share/man/man1/ltp-pan.1
> -/usr/share/man/man1/doio.1
> -/usr/share/man/man1/iogen.1
> -/usr/share/man/man1/ltp-bump.1
> -# Post-install stuff would go here.
> -#EOF

Shouldn't the old files be left as defaults so we don't need to run
autotools to get a working make/install?

<snip>

> Index: include/mk/config.mk.in
> ===================================================================
> RCS file: include/mk/config.mk.in
> diff -N include/mk/config.mk.in
> --- /dev/null	1 Jan 1970 00:00:00 -0000
> +++ include/mk/config.mk.in	7 Jul 2009 01:15:48 -0000
> @@ -0,0 +1,61 @@
> +#
> +#    config.mk.in.
> +#
> +#    Copyright (C) 2009, Cisco Systems Inc.
> +#
> +#    This program is free software; you can redistribute it and/or modify
> +#    it under the terms of the GNU General Public License as published by
> +#    the Free Software Foundation; either version 2 of the License, or
> +#    (at your option) any later version.
> +#
> +#    This program is distributed in the hope that it will be useful,
> +#    but WITHOUT ANY WARRANTY; without even the implied warranty of
> +#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +#    GNU General Public License for more details.
> +#
> +#    You should have received a copy of the GNU General Public License along
> +#    with this program; if not, write to the Free Software Foundation, Inc.,
> +#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +#
> +# Garrett Cooper, July 2009
> +#
> +# Copyright (c) 2009 by Cisco Systems, Inc.
> +# All rights reserved
> +#
> +
> +AR		= @AR@
> +CC		= @CC@
> +RANLIB		= @RANLIB@
> +
> +# Avoid overwriting definitions in leaf callers.
> +CPPFLAGS	?= @CPPFLAGS@
> +CFLAGS		?= @CFLAGS@
> +LDLIBS		?= @LIBS@
> +LDFLAGS		?= @LDFLAGS@
> +
> +AIO_LIBS	= @AIO_LIBS@
> +CRYPTO_LIB	= @CRYPTO_LIB@
> +SELINUX_LIBS	= @SELINUX_LIBS@
> +
> +RPMBUILD	?= rpmbuild
> +
> +prefix		?= @prefix@

I think you should set PREFIX too. Most Makefiles that honored prefix at
all expected that variable name. Perhaps it would be best to start with
that and then, if it's best, gradually change all the Makefiles?

> +
> +#
> +# Default to /opt/ltp if the directory specified was a zero-length string, to
> +# avoid spurious Make system errors.
> +#
> +# XXX (garrcoop): I'm almost positive there's a better way to do this in
> +# autoconf. Haven't figured it out yet...
> +#
> +ifeq ($(strip $(prefix)),)
> +prefix		= /opt/ltp
> +endif

I thought the point was not having to run autoconf to get the default
build and install via Makefiles.

> +
> +datarootdir	= @datarootdir@
> +includedir	= @includedir@
> +mandir		= @mandir@
> +
> +#export AR CC CFLAGS CPPFLAGS LDLIBS LDFLAGS RANLIB
> +export AR CC CPPFLAGS LDLIBS LDFLAGS RANLIB

Perhaps now is a good time to delete the commented-out export line?

Cheers,
	-Matt Helsley

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have 
the opportunity to enter the BlackBerry Developer Challenge. See full prize 
details at: http://p.sf.net/sfu/blackberry
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
