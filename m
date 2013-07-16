Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Uz4M0-0006ii-DQ
	for ltp-list@lists.sourceforge.net; Tue, 16 Jul 2013 12:27:40 +0000
Date: Tue, 16 Jul 2013 14:29:24 +0200
From: chrubis@suse.cz
Message-ID: <20130716122924.GA21078@rei>
References: <CADyrn+t16kR9FAfQSYUB2aYJej1BEFFZcLwUzDi0nKAjHyZ6Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADyrn+t16kR9FAfQSYUB2aYJej1BEFFZcLwUzDi0nKAjHyZ6Rw@mail.gmail.com>
Subject: Re: [LTP] [mtest01w] mtest01w test hangs
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
To: SHASHANK BILGI <shashank192@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> <<<test_start>>>
> tag=mtest01w stime=2336
> cmdline="mtest01 -p80 -w"
> contacts=""
> analysis=exit
> <<<test_output>>>
> [ 2351.111281] rmon:L
> mtest01     0  TINFO  :  Total memory already used on system = 22796 kbytes
> mtest01     0  TINFO  :  Total memory used needed to reach maximum =
> 1750246 kbytes
> mtest01     0  TINFO  :  Filling up 80% of ram which is 1727450 kbytes
> mtest01     1  TBROK  :  stopped at 716177408 bytes: errno=ENOMEM(12):
> Cannot allocate memory
> 
> 
> * When the malloc fails the child process seems to be calling tst_exit().
> mtest01.c
> .....
> .....
>         if (pid == 0) {
>                 bytecount = chunksize;
>                 while (1) {
>                         if ((mem = malloc(chunksize)) == NULL) {
>                                 tst_resm(TBROK | TERRNO,
>                                          "stopped at %lu bytes", bytecount);
>                                 free(pid_list);
>                                 tst_exit();
>                         }
> 
> .....
> .....
> 
> * but in this case i can see the child process in the process list(ps -ax)
> in sleep state.
> 
>  333 ttyAM0   S      0:00 mtest01 -p80 -w
>  334 ttyAM0   Z      0:14 [mtest01] <defunct>
>  335 ttyAM0   S      0:13 mtest01 -p80 -w
> 
> Here is my query , why tst_exit() isn't ending the child process?

Using tst_exit() and any other tst interface from child is a mistake but
tst_exit() should end the child process.

However there may be other childrens still running as tst_exit() is just
equivalent to exit() (it does flush output buffers and exits the process
with result as return value but nothing more).

So my guess is that the rest of the childrens continue to fill the
chunks and then waits to be reaped by the parent. Which may hang the
machine if there is not enough memory.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
