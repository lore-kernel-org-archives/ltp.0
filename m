Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1ZJdq6-0003gR-3P
	for ltp-list@lists.sourceforge.net; Mon, 27 Jul 2015 08:32:50 +0000
Received: from mx5-phx2.redhat.com ([209.132.183.37])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZJdq4-000660-97
	for ltp-list@lists.sourceforge.net; Mon, 27 Jul 2015 08:32:50 +0000
Date: Mon, 27 Jul 2015 04:32:41 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1982370381.394962.1437985961501.JavaMail.zimbra@redhat.com>
In-Reply-To: <1819982097.50101437984766322.JavaMail.weblogic@epmlwas01c>
References: <1819982097.50101437984766322.JavaMail.weblogic@epmlwas01c>
MIME-Version: 1.0
Subject: Re: [LTP] Regarding memcg control  testcase (mem_process.c)
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
To: manjeet p <manjeet.p@samsung.com>
Cc: AJEET YADAV <ajeet.y@samsung.com>, ltp-list@lists.sourceforge.net, PANKAJ MISHRA <pankaj.m@samsung.com>





----- Original Message -----
> From: "Manjeet Pawar" <manjeet.p@samsung.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp-list@lists.sourceforge.net, "AJEET YADAV" <ajeet.y@samsung.com>, "PANKAJ MISHRA" <pankaj.m@samsung.com>
> Sent: Monday, 27 July, 2015 10:12:46 AM
> Subject: Re: Re: [LTP]  Regarding memcg control  testcase (mem_process.c)
> 
> Hello Mr Jan,
> Thanks for your reply,
> With actual testscript I checked my "$!" , it is printing correct pid.
> Also changes which you suggest, I tried with those changes , it is showing me
> either "mmap failed:ffffffff"

When it fails, what is the errno?

> sometimes or "a successful mmap call".

Where is this message coming from? I can't find such string in my LTP.

> In my case "memory.usage_in_bytes" is 4096.
> Testcase is run as "./memcg_control_test.sh 4096 4096 8192".
> I am not getting this "mem_process getting killed by OOM seems like expected
> outcome:"
> May i know which kernel verison you are using.? Now I am doubtful on my
> kernel.

I'm on 4.0.4.

What is your kernel/arch and LTP version?

Regards,
Jan

> 
> Regards
> Manjeet
> 
> ------- Original Message -------
> Sender : Jan Stancek<jstancek@redhat.com>
> Date : Jul 26, 2015 20:28 (GMT+09:00)
> Title : Re: [LTP] Regarding memcg control testcase (mem_process.c)
> 
> 
> ----- Original Message -----
> > From: "Manjeet Pawar"
> > To: ltp-list@lists.sourceforge.net
> > Cc: "ajeet y" , "pankaj m"
> > Sent: Friday, 24 July, 2015 6:07:45 AM
> > Subject: [LTP]  Regarding memcg control  testcase (mem_process.c)
> > 
> > Hi,
> > 
> > I am trying to run memcg control testcase using script
> > memcg_control_test.sh.
> > This script calls a memory hog process 'mem_process'.
> > The condition for this testcase to pass is 'when the memory hog process is
> > killed on crossing boundary'. please check the below function.
> > 
> > 
> > -----------------------------
> > # Check if the test process is killed on crossing boundary
> > test_proc_kill()
> > {
> >     ( cd $TMP && mem_process -m $PROC_MEM & )
> >     sleep 1
> >     echo $! > tasks
> 
> mem_process is getting started via subshell, so I'd assume $! in parent is
> bogus.
> Can you try this instead:
> 
>         pushd $TMP || return
>         mem_process -m $PROC_MEM &
>         local pid=$!
>         popd
> 
>         sleep 1
>         echo $pid > tasks
> 
> 
> > 
> >     #Instruct the test process to start acquiring memory
> >     echo m > $STATUS_PIPE
> >     sleep 5
> > 
> >     #Check if killed
> >     ps -p $! > /dev/null 2> /dev/null    ----> at this point the process
> >     'mem_process' must have terminated so that last return value ($?) can
> >     be
> >     non-zero.
> >     if [ $? -eq 0 ]; then
> >         echo m > $STATUS_PIPE
> >         echo x > $STATUS_PIPE
> >     else
> >         : $((KILLED_CNT += 1))
> >     fi
> > }
> > -------------------------
> > In my case: 'mem_process' does not terminate until we pass 'x' to it, but
> > the
> > expected behaviour according to testcase  that the memory hog process
> > must be killed on crossing bounday.
> > Inputs taken by testcase are : "./memcg_control_test.sh 4096 4096 8192"
> > If I change the inputs from 8192 to other (1024,10MB,100MB etc) . In all
> > situation memory hog process does not terminate.
> > So what is the ideal condition for this process to terminate to make whole
> > testcase pass. ?
> 
> mem_process getting killed by OOM seems like expected outcome:
> 
> memcg_control    0  TINFO  :  Test #1: Checking if the memory usage limit
> imposed by the topmost group is enforced
> ./memcg_control_test.sh: line 56:  2795 Killed                  mem_process
> -m $PROC_MEM  (wd: /tmp)
> memcg_control    1  TPASS  :  Test #1: passed
> memcg_control    1  TPASS  :  memcg_control: passed
> 
> If it still doesn't get killed, I'd recommend checking
> "memory.usage_in_bytes".
> 
> Regards,
> Jan
> 
> 
> > 
> > ------------------------------------------------------------------------------
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
> >

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
