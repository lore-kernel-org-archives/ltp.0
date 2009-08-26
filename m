Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Geert.Uytterhoeven@sonycom.com>) id 1MgI4B-00031L-Pf
	for Ltp-list@lists.sourceforge.net; Wed, 26 Aug 2009 12:57:31 +0000
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=pophost.sonytel.be) by 1b2kzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1MgI44-0006mq-Nv
	for Ltp-list@lists.sourceforge.net; Wed, 26 Aug 2009 12:57:26 +0000
Received: from vixen.sonytel.be (piraat.sonytel.be [43.221.60.197])
	by pophost.sonytel.be (Postfix) with ESMTP id E452844483
	for <Ltp-list@lists.sourceforge.net>;
	Wed, 26 Aug 2009 14:57:10 +0200 (CEST)
Date: Wed, 26 Aug 2009 14:57:10 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Message-ID: <alpine.LRH.2.00.0908261443220.25669@vixen.sonytel.be>
MIME-Version: 1.0
Subject: [LTP] undefined macro: _m4_divert_diversion
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Linux Test Project <Ltp-list@lists.sourceforge.net>

When trying to autoconfigure current LTP on YDL, I get:

    # make autotools =

    touch config.mk
    aclocal -I m4
    m4/ltp-unshare.m4:2: error: m4_defn: undefined macro: _m4_divert_divers=
ion
    m4/ltp-unshare.m4:2: the top level
    autom4te: /usr/local/bin/m4 failed with exit status: 1
    aclocal: autom4te failed with exit status: 1
    make: *** [aclocal.m4] Error 1
    #

Autoconf, automake, and m4 have been compiled from source, using the versio=
ns
specified in INSTALL:

    # autoconf --version
    autoconf (GNU Autoconf) 2.61
    Copyright (C) 2006 Free Software Foundation, Inc.
    This is free software.  You may redistribute copies of it under the ter=
ms of
    the GNU General Public License <http://www.gnu.org/licenses/gpl.html>.
    There is NO WARRANTY, to the extent permitted by law.

    Written by David J. MacKenzie and Akim Demaille.
    # automake --version
    automake (GNU automake) 1.10.2
    Copyright (C) 2008 Free Software Foundation, Inc.
    License GPLv2+: GNU GPL version 2 or later <http://gnu.org/licenses/gpl=
.html>
    This is free software: you are free to change and redistribute it.
    There is NO WARRANTY, to the extent permitted by law.

    Written by Tom Tromey <tromey@redhat.com>
	   and Alexandre Duret-Lutz <adl@gnu.org>.
    # m4 --version
    m4 (GNU M4) 1.4.12
    Copyright (C) 2008 Free Software Foundation, Inc.
    License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl=
.html>
    This is free software: you are free to change and redistribute it.
    There is NO WARRANTY, to the extent permitted by law.

    Written by Rene' Seindal.
    # =


(I'm seeing the same thing on stock Ubuntu 9.04, but that one has autoconf
 2.63, and only automake 1.9.6 and m4 1.4.11.)

I also tried installing the latest m4 (1.4.13), but that didn't help.
I also tried installing the latest autoconf (2.64), but that failed even
harder:

    # make autotools
    touch config.mk
    aclocal -I m4
    m4/ltp-unshare.m4:2: error: _AC_LANG_ABBREV: unknown language: _AC_LANG
    ../../lib/autoconf/lang.m4:164: _AC_LANG_ABBREV is expanded from...
    ../../lib/autoconf/functions.m4:82: AC_CHECK_FUNC is expanded from...
    ../../lib/m4sugar/m4sh.m4:588: AS_FOR is expanded from...
    ../../lib/autoconf/functions.m4:109: AC_CHECK_FUNCS is expanded from...
    m4/ltp-unshare.m4:2: _AC_Func_unshare is expanded from...
    ../../lib/autoconf/functions.m4:130: AC_CHECK_FUNCS_ONCE is expanded fr=
om...
    m4/ltp-unshare.m4:2: the top level
    autom4te: /usr/local/bin/m4 failed with exit status: 1
    aclocal: autom4te failed with exit status: 1
    make: *** [aclocal.m4] Error 1
    # =


Anyone with a clue?
Thanks!

With kind regards,

Geert Uytterhoeven
Software Architect
Techsoft Centre

Technology and Software Centre Europe
The Corporate Village =B7 Da Vincilaan 7-D1 =B7 B-1935 Zaventem =B7 Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 =B7 RPR Brussels
Fortis =B7 BIC GEBABEBB =B7 IBAN BE41293037680010

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with =

Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
