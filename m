Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YfTMS-00009c-H2
	for ltp-list@lists.sourceforge.net; Tue, 07 Apr 2015 13:16:12 +0000
Date: Tue, 7 Apr 2015 15:15:57 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150407131556.GA9535@rei>
References: <214042481.9356038.1428054865150.JavaMail.zimbra@redhat.com>
	<1301134399.9357345.1428055489965.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1301134399.9357345.1428055489965.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] mtest06 failures
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> <<<test_start>>>
> tag=mtest06 stime=1427900338
> cmdline="  mmap1 -x 0.05"
> contacts=""
> analysis=exit
> <<<test_output>>>
> mmap1       0  TINFO  :  created writing thread[70366651085264]
> mmap1       0  TINFO  :  [70366651085264] - map, change contents, unmap files 1000 times
> mmap1       0  TINFO  :  created reading thread[70366642696656]
> mmap1       0  TINFO  :  [70366642696656] - read contents of memory (nil) 1000 times
> mmap1       1  TFAIL  :  mmap1.c:400: thread [70366642696656] - process exited with -1
> <<<execution_status>>>
> initiation_status="ok"
> duration=1 termination_type=exited termination_id=1 corefile=no
> cutime=23 cstime=46
> <<<test_end>>>
> 
> ret code -1 indicates, that it hit:
>     if (map_address[j] != 'a')
>         pthread_exit((void *)-1);
> 
> I think what happens is that map_write_unmap() unmaps the memory,
> and something else mmaps into the same location. gdb breakpoints on
> mmap found couple places which could be responsible, pthread_exit()
> was one of them.
> 
> 2 ideas came to mind:
> 1. clear map_address after munmap
>    This however seems to go against what the testcase is trying to do
> 2. make sure mmap for map_address happens in place which is less likely
>    to be used in future mmaps

I do not recall mtest06 failing this way, but it's quite possible that
something from libc will trigger mmap() to allocate memory.

The patch looks good to me.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
