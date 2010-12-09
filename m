Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PQj0m-00048I-Gp
	for ltp-list@lists.sourceforge.net; Thu, 09 Dec 2010 16:06:28 +0000
Date: Thu, 9 Dec 2010 17:20:05 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101209162004.GA14177@saboteur.suse.cz>
References: <AANLkTi=1byd4Aef1uwOKKBFVoGKFMkPm7bBTGJBigT+R@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTi=1byd4Aef1uwOKKBFVoGKFMkPm7bBTGJBigT+R@mail.gmail.com>
Subject: Re: [LTP] Failed to build ltp 20101031 on RHEL5u6
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
To: Romu <huruomu@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!,
> I failed to build ltp 20101031 on RHEL5u6 beta (i686):
> 
> ./configure
> make all
> 
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -D_GNU_SOURCE
> -I/root/ltp-full-20101031/testcases/realtime/include
> -I../../../../include -I../../../../include
> -L/root/ltp-full-20101031/testcases/realtime/lib -L../../../../lib
> async_handler.c   -lrealtime -lpthread -lrt -lm -o async_handler
> /root/ltp-full-20101031/testcases/realtime/lib/librealtime.a(librttest.o):
> In function `atomic_add':
> /root/ltp-full-20101031/testcases/realtime/lib/../include/librttest.h:117:
> undefined reference to `__sync_add_and_fetch_4'
> collect2: ld returned 1 exit status
> make[4]: *** [async_handler] Error 1
> make[4]: Leaving directory
> `/root/ltp-full-20101031/testcases/realtime/func/async_handler'
> make[3]: *** [all] Error 2
> make[3]: Leaving directory `/root/ltp-full-20101031/testcases/realtime/func'
> make[2]: *** [all] Error 2
> make[2]: Leaving directory `/root/ltp-full-20101031/testcases/realtime'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/root/ltp-full-20101031/testcases'
> make: *** [testcases-all] Error 2
> 
> I googled and some people said "-march=i686" should be used.  I tried:
> 
> CFLAGS="-march=i686" ./configure
> CFLAGS="-march=i686" make all
> 
> still got the same error.
> 
> Any idea?

Problably too old gcc (that doesn't support __sync_add_and_fetch()) this
should be covered by autoconf checks in latest git. Workaround is to
disable realtime tests in testcases makefile (by adding it to
FILTER_OUT_DIRS).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
