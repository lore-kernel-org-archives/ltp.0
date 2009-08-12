Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Mb9SP-0005QF-Hb
	for ltp-list@lists.sourceforge.net; Wed, 12 Aug 2009 08:45:17 +0000
Received: from qw-out-1920.google.com ([74.125.92.148])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mb9SN-00050W-9P
	for ltp-list@lists.sourceforge.net; Wed, 12 Aug 2009 08:45:17 +0000
Received: by qw-out-1920.google.com with SMTP id 5so1478722qwc.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 12 Aug 2009 01:45:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090811173021.7074.87879.sendpatchset@subratamodak.linux.ibm.com>
References: <20090811172957.7074.62874.sendpatchset@subratamodak.linux.ibm.com>
	<20090811173021.7074.87879.sendpatchset@subratamodak.linux.ibm.com>
Date: Wed, 12 Aug 2009 01:45:09 -0700
Message-ID: <364299f40908120145h13955b1eyaa4abdd477612b6a@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 02/05] Add Script which would actually do the job
	of injecting faults
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>, LTP Mailing List <ltp-list@lists.sourceforge.net>, Mike Frysinger <vapier@gentoo.org>, Michael Reed <mreed10@us.ibm.com>, Nate Straz <nate@refried.org>, Paul Larson <paul.larson@ubuntu.com>, Manoj Iyer <manoj.iyer@ubuntu.com>, Balbir Singh <balbir@linux.vnet.ibm.com>

On Tue, Aug 11, 2009 at 10:30 AM, Subrata
Modak<subrata@linux.vnet.ibm.com> wrote:
> Script which would actually do the job of injecting faults by changing va=
rious
> parametrs available under /debug/fail*. This would be done dynamically du=
ring
> LTP run, and, is capable of taking parameters from 0 to 100 to vary the
> probability of Fault the user wants to inject in the running kernel.
>
> Signed-off-by: Subrata Modak <subrata@linux.vnet.ibm.com>
> ---
>
> diff -uprN ltp-full-20090731.orig/tools/insert_kernel_faults.sh ltp-full-=
20090731/tools/insert_kernel_faults.sh
> --- ltp-full-20090731.orig/tools/insert_kernel_faults.sh =A0 =A0 =A0 =A01=
970-01-01 05:30:00.000000000 +0530
> +++ ltp-full-20090731/tools/insert_kernel_faults.sh =A0 =A0 2009-08-11 18=
:44:45.000000000 +0530
> @@ -0,0 +1,52 @@
> +#!/bin/sh
> +########################################################################=
########
> +## =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0##
> +## Copyright (c) International Business Machines =A0Corp., 2009 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 ##
> +## =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0##
> +## This program is free software; =A0you can redistribute it and/or modi=
fy =A0 =A0 =A0##
> +## it under the terms of the GNU General Public License as published by =
=A0 =A0 =A0 ##
> +## the Free Software Foundation; either version 2 of the License, or =A0=
 =A0 =A0 =A0 =A0##
> +## (at your option) any later version. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0##
> +## =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0##
> +## This program is distributed in the hope that it will be useful, but =
=A0 =A0 =A0 =A0##
> +## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTAB=
ILITY ##
> +## or FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU General Public Li=
cense =A0 ##
> +## for more details. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0##
> +## =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0##
> +## You should have received a copy of the GNU General Public License =A0=
 =A0 =A0 =A0 =A0##
> +## along with this program; =A0if not, write to the Free Software =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 ##
> +## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 U=
SA =A0 =A0##
> +## =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0##
> +########################################################################=
########
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0##
> +# File : =A0 =A0 =A0 =A0insert_kernel_faults.sh =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0##
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0##
> +# Usage: =A0 =A0 =A0 insert_kernel_faults.sh <fault_percentage> =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0##
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0##
> +# Description: =A0This is a simple script that inserts faults at various=
 =A0 =A0 =A0 ##
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0subsystems of the kernel. Please refer to t=
he ltp/README =A0 =A0 =A0##
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0for the various kernel CONFIG options neede=
d to exploit =A0 =A0 =A0 ##
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0all those features =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0##
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0##
> +# Author: =A0 =A0 =A0Subrata Modak <subrata@linux.vnet.ibm.com> =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0##
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0##
> +# History: =A0 =A0 =A0Aug 11 2009 - Created - Subrata Modak. =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ##
> +########################################################################=
########
> +
> +if [ -z $1 ]
> + =A0 =A0 =A0 then
> + =A0 =A0 =A0 #Check if Useage has been proper
> + =A0 =A0 =A0 echo "Usage: $0 <fault_percentage>"
> + =A0 =A0 =A0 exit 1
> +fi
> +
> +#These are the types of Subsystems where fault will be injected
> +#Make sure debugfs has been mounted
> +for FAILTYPE in `echo fail_io_timeout fail_make_request fail_page_alloc =
failslab`
> +do
> + =A0 =A0 =A0 echo $1 > /debug/$FAILTYPE/probability
> + =A0 =A0 =A0 echo 100 > /debug/$FAILTYPE/interval
> + =A0 =A0 =A0 echo -1 > /debug/$FAILTYPE/times
> + =A0 =A0 =A0 echo 0 > /debug/$FAILTYPE/space
> +done

    Why ```for FAILTYPE in `echo list-of-values`'''? ```for FAILTYPE
in list-of-values''' works just as well without the echo.
Thanks,
-Garrett

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
