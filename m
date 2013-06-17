Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UocwF-0003j0-Ev
	for ltp-list@lists.sourceforge.net; Mon, 17 Jun 2013 17:09:55 +0000
Date: Mon, 17 Jun 2013 19:11:22 +0200
From: chrubis@suse.cz
Message-ID: <20130617171122.GA3387@rei>
References: <1371130083-5923-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1371130083-5923-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH v2] configure: add configure checks to compile
 kernel modules
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>

Hi!
> --- /dev/null
> +++ b/m4/ltp-kernel_devel.m4
> @@ -0,0 +1,82 @@
> +dnl Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
> +dnl
> +dnl This program is free software; you can redistribute it and/or
> +dnl modify it under the terms of the GNU General Public License as
> +dnl published by the Free Software Foundation; either version 2 of
> +dnl the License, or (at your option) any later version.
> +dnl
> +dnl This program is distributed in the hope that it would be useful,
> +dnl but WITHOUT ANY WARRANTY; without even the implied warranty of
> +dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +dnl GNU General Public License for more details.
> +dnl
> +dnl You should have received a copy of the GNU General Public License
> +dnl along with this program; if not, write the Free Software Foundation,
> +dnl Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +dnl
> +dnl Author: Alexey Kodanev <alexey.kodanev@oracle.com>
> +dnl
> +
> +dnl
> +dnl LTP_CHECK_KERNEL_DEVEL
> +dnl ----------------------------
> +dnl Building kernel modules
> +dnl requires kernel-devel installed
> +dnl
> +
> +AC_DEFUN([LTP_CHECK_KERNEL_DEVEL],[dnl
> +
> +AC_MSG_CHECKING([for kernel-devel])
> +AC_ARG_WITH(
> +	[linux-version],
> +	[AC_HELP_STRING([--with-linux-version=VERSION],
> +			[specify the Linux version to build modules for])],
> +	[LINUX_VERSION="${withval}"],
> +	AS_IF([test "$cross_compiling" = "no"],
> +		[LINUX_VERSION=`uname -r`]))

So either we get linux version as parameter or we try to use uname, this
is ok.

> +AC_SUBST(LINUX_VERSION)
> +
> +AC_ARG_WITH([linux-dir],
> +	[AC_HELP_STRING([--with-linux-dir=DIR],
> +			[specify path to kernel-devel directory])],
> +	[LINUX_DIR="${withval}"],
> +	AS_IF([test -n "$LINUX_VERSION"],
> +		[LINUX_DIR="/lib/modules/$LINUX_VERSION/build"]))
> +
> +AC_SUBST(LINUX_DIR)

The same with path, ok.

> +if test -f "$LINUX_DIR/Makefile"; then
> +	LINUX_VERSION_MAJOR=`sed -n '0,/^VERSION = [[0-9]]*/s,\
> +^VERSION = ,,p' ${LINUX_DIR}/Makefile`
> +
> +	LINUX_PATCHLEVEL=`sed -n '0,/^PATCHLEVEL = [[0-9]]*/s,\
> +^PATCHLEVEL = ,,p' ${LINUX_DIR}/Makefile`
> +fi

Now we check if the dir exists and parse the Makefile for MAJOR and
PATCHLEVEL, ok.

> +if [[ -n "$LINUX_VERSION_MAJOR" -a -n "$LINUX_PATCHLEVEL" ]]; then
> +	WITH_MODULES="yes"

If there is Makefile and it contains reasonable content, proceed
with module build, ok.

> +else
> +	WITH_MODULES="no"
> +	if test -n "$LINUX_VERSION"; then
> +		LINUX_VERSION_MAJOR=`echo "$LINUX_VERSION" | \
> +sed -n 's/\([[0-9]]\).*$/\1/p'`
> +		LINUX_PATCHLEVEL=`echo "$LINUX_VERSION" | \
> +sed -n 's/^[[0-9]]*.\([[0-9]]\).*$/\1/p'`
> +	fi

Here we set the MAJOR and PATCHLEVEL even if WITH_MODULES is set to no.
Is this useful? (Maybe I overlooked something but when WITH_MODULES is
set to no, the kernel version is not needed. Or is this here just in
case we will need that someday?)

> +fi
> +
> +AC_SUBST(LINUX_VERSION_MAJOR)
> +AC_SUBST(LINUX_PATCHLEVEL)
> +
> +AC_MSG_RESULT([$WITH_MODULES])
> +
> +AC_ARG_WITH(
> +	[modules],
> +	[AC_HELP_STRING([--without-modules],
> +			[disable auto-building kernel modules])],
> +			[WITH_MODULES="no"],
> +			[])
> +
> +AC_SUBST(WITH_MODULES)
> +])

But generally it looks fine to me. Mike are you fine with this version
as well? 

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
