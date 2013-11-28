Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VlzuO-0000OG-5F
	for ltp-list@lists.sourceforge.net; Thu, 28 Nov 2013 11:37:24 +0000
Date: Thu, 28 Nov 2013 12:36:52 +0100
From: chrubis@suse.cz
Message-ID: <20131128113652.GB19263@rei.Home>
References: <1384353022-9088-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20131126160651.GC14089@rei.suse.cz> <5296FAB8.8050702@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5296FAB8.8050702@oracle.com>
Subject: Re: [LTP] safe_touch and utimensat
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
> Actually, I need.
> 
> I use clock_gettime() to get the current time and use it when UTIME_NOW 
> is passed. Like this:
> #if HAVE_UTIMENSAT
>          ret = utimensat(AT_FDCWD, pathname, times, 0);
> #else
>          if (times == NULL) {
>                  ret = utimes(pathname, NULL);
>          } else {
>          /* stat and etc */
> 
>                  ret = clock_gettime(CLOCK_REALTIME, &tp);
>                  if (ret == -1)
>                          tst_brkm(TBROK | TERRNO, cleanup_fn,
>                                  "Failed to clock_realtime() at %s:%d",
>                                  file, lineno);
> 
>          /* handle UTIME_NOW and etc */
>          }
> #endif
> 
> 
> The compilation of safe_file_ops.c performs ok. libltp.a is formed. But 
> compilations of other pieces of code using safe_touch fails with:
> make[1]: Entering directory `/home/stas/ltp/lib/tests'
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W 
> -D_FORTIFY_SOURCE=2 -I../../include -I../../include   -L../../lib 
> tst_process_state.c   -lltp -o tst_process_state
> ../../lib/libltp.a(safe_file_ops.o): In function `safe_touch':
> /home/stas/ltp/lib/safe_file_ops.c:213: undefined reference to 
> `clock_gettime'
> collect2: ld returned 1 exit status
> 
> I know, that clock_gettime() requires '-lrt'.
> 
> But I'm not sure about the right place inside LTP sources to put it in....

What about using gettimeofday() instead?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
