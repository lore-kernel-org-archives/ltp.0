Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WkEVI-0001i9-UZ
	for ltp-list@lists.sourceforge.net; Tue, 13 May 2014 15:20:28 +0000
Date: Tue, 13 May 2014 17:19:26 +0200
From: chrubis@suse.cz
Message-ID: <20140513151926.GB21042@rei>
References: <1397102926-2630-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<1397102926-2630-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1397102926-2630-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2 2/3] perf_event_open/perf_event_open01.c:
	cleanup
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
>  AC_OUTPUT
> diff --git a/m4/ltp-perf_event_open.m4 b/m4/ltp-perf_event_open.m4
> new file mode 100644
> index 0000000..a1084cf
> --- /dev/null
> +++ b/m4/ltp-perf_event_open.m4
> @@ -0,0 +1,47 @@
> +dnl
> +dnl Copyright (c) 2014 Fujitsu Ltd.
> +dnl Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> +dnl
> +dnl This program is free software;  you can redistribute it and/or modify
> +dnl it under the terms of the GNU General Public License as published by
> +dnl the Free Software Foundation; either version 2 of the License, or
> +dnl (at your option) any later version.
> +dnl
> +dnl This program is distributed in the hope that it will be useful,
> +dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
> +dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> +dnl the GNU General Public License for more details.
> +dnl
> +dnl You should have received a copy of the GNU General Public License
> +dnl along with this program;  if not, write to the Free Software
> +dnl Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> +dnl
> +
> +dnl
> +dnl LTP_CHECK_SYSCALL_PERF_EVENT_OPEN
> +dnl ----------------------------
> +dnl
> +AC_DEFUN([LTP_CHECK_SYSCALL_PERF_EVENT_OPEN],[dnl
> +	AC_MSG_CHECKING([for perf_event_open struct perf_event_attr])
> +	save_CPPFLAGS=$CPPFLAGS
> +	CPPFLAGS="$CPPFLAGS -I$srcdir/testcases/kernel/include -I$srcdir/include"
> +	AC_COMPILE_IFELSE([AC_LANG_SOURCE([
> +#define _GNU_SOURCE
> +#include <unistd.h>
> +#include <linux/perf_event.h>
> +#include "linux_syscall_numbers.h"
> +int main(void) {
> +	struct perf_event_attr pe;
> +	syscall(__NR_perf_event_open, &pe, 0, -1, -1, 0);
> +	return 0;
> +}])],[has_perf_event_attr="yes"])
> +
> +
> +if test "x$has_perf_event_attr" = xyes; then
> +	AC_DEFINE(HAVE_PERF_EVENT_ATTR,1,[Define to 1 if you have struct perf_event_attr])
> +	AC_MSG_RESULT(yes)
> +else
> +	AC_MSG_RESULT(no)
> +fi
> +CPPFLAGS=$save_CPPFLAGS
> +])

I've simplified this configure check, you don't have to call the
syscall() because __NR_perf_event_open is always defined (due to
linux_syscall_numbers.h). So all that needs to be done here is to check
for existence of perf_event_attr structure in linux/perf_event.h.

Patches pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
