Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WUdgl-0005UR-Ky
	for ltp-list@lists.sourceforge.net; Mon, 31 Mar 2014 14:59:51 +0000
Date: Mon, 31 Mar 2014 16:59:15 +0200
From: chrubis@suse.cz
Message-ID: <20140331145915.GA9824@rei.suse.cz>
References: <1395044011-31911-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1395044011-31911-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 1/3] performance_counters/performance_counter01.c:
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
> +#define _GNU_SOURCE
> +#include <unistd.h>
> +#include <sys/syscall.h>
> +#include <linux/perf_event.h>
> +int main(void) {
> +	struct perf_event_attr pe;
> +	syscall(__NR_perf_event_open, &pe, 0, -1, -1, 0);
> +	return 0;
> +}])],[has_perf_event_open_syscall="yes"])
> +if test "x$has_perf_event_open_syscall" = "xyes"; then
> +	AC_DEFINE(HAVE_PERF_EVENT_OPEN_SYSCALL,1,[Define to 1 if you have the perf_event_open syscall support on your system])
> +else
> +	AC_DEFINE(HAVE_PERF_EVENT_OPEN_SYSCALL,0,[Define to 0 if you do not have the perf_event_open syscall support on your system])
> +fi
> +])

This is wrong, we have linux_syscall_numbers.h in
testcases/kernel/include/ in order to make sure syscall numbers are
defined.

Looking at the code it should rather be check for
struct perf_event_attr in /usr/include/linux/perf_event.h, right?

> +static void do_work(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < LOOPS; ++i)
> +		asm volatile ("" : : "g" (i));
> +}

What is the exact purpose of the asm snippet here?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
