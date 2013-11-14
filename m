Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VgyXQ-0000PG-Pt
	for ltp-list@lists.sourceforge.net; Thu, 14 Nov 2013 15:08:56 +0000
Date: Thu, 14 Nov 2013 16:08:42 +0100
From: chrubis@suse.cz
Message-ID: <20131114150841.GB15449@rei>
References: <1384353022-9088-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1384353022-9088-2-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1384353022-9088-2-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [RFC PATCH 1/2] autoconf check for utimensat(2)
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> +AC_DEFUN([LTP_CHECK_SYSCALL_UTIMENSAT],[
> +	AC_MSG_CHECKING([for utimensat])
> +	AC_LINK_IFELSE([AC_LANG_SOURCE([
> +#include <stdlib.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +
> +int main(void) {
> +	long tv_nsec;
> +	tv_nsec = UTIME_NOW;
> +	tv_nsec = UTIME_OMIT;
> +
> +	return utimensat(AT_FDCWD, (const char *) "/dev/null", NULL, 0);
> +}])],[has_utimensat="yes"])

Why the cast to const char* and why cannot be the second parameter NULL
too (it's just linked not executed)?

> +
> +if test "x$has_utimensat" == "xyes"; then
> +	AC_DEFINE(HAVE_UTIMENSAT, 1, [Define to 1 if you have utimensat(2)])
> +	AC_MSG_RESULT(yes)
> +else
> +	AC_MSG_RESULT(no)
> +fi
> +])

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
