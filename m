Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WHunC-0008Hn-5x
	for ltp-list@lists.sourceforge.net; Mon, 24 Feb 2014 12:37:54 +0000
Date: Mon, 24 Feb 2014 13:37:40 +0100
From: chrubis@suse.cz
Message-ID: <20140224123740.GA23791@rei>
References: <CAPxN80CzjoOyhTwsPii42+u2qxO=u5oe0B_jok7TozzX-=nNow@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPxN80CzjoOyhTwsPii42+u2qxO=u5oe0B_jok7TozzX-=nNow@mail.gmail.com>
Subject: Re: [LTP] LTP syscall question
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
To: Jessica Foest <jessica.foest@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I'm a new user of LTP tool , my goal is to execute some system calls using
> LTP and to intercept them using a kernel tracer .
> 
> i do this example :
> 
> /opt/ltp/runltp -q -p -l result.03.log -f
> /home/jessica/LTP-test/test-syscall.txt
> 
> the content of the test-syscall.txt file is :
> #Tag       Test case
> #---------------------------------------
> fork01      fork01
> chdir01     symlink01 -T chdir01
> #----------------------------------------
> 
> the problem is that i didn't intercept the syscall fork and the syscall
> chdir using my tracer in the kernel space.
> 
> So i wanna ask :
> Which processes are responsible of the execution of these system calls ?
> Does this tool, i mean LTP, really execute these system calls ( fork and
> chdir ) in the kernel space?

The test itself (standalone executable binary) calls the syscall to be
tested. But these are not the only syscalls that the test calls you
cannot write a test that calls a single syscall. You can run most of the
tests directly (without the runltp script) if you execute the cmdline
(marked as Test case in your example file) in the directory with the
test binaries or if you add the path to your PATH.

Moreover the runltp tool that runs LTP tests forks a few times before
the actual test is executed. You cannot run new program without doing
fork() beforehand in UNIX. So in your place, I would double check if the
kernel tracing works.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
