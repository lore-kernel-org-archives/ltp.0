Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <manjeet.p@samsung.com>) id 1ZKISQ-0000uz-OH
	for ltp-list@lists.sourceforge.net; Wed, 29 Jul 2015 03:55:06 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZKISO-0007Iw-Ae
	for ltp-list@lists.sourceforge.net; Wed, 29 Jul 2015 03:55:06 +0000
Received: from epcpsbgr2.samsung.com
	(u142.gpu120.samsung.co.kr [203.254.230.142])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NS802208DJKXQ70@mailout4.samsung.com> for
	ltp-list@lists.sourceforge.net; Wed, 29 Jul 2015 12:54:56 +0900 (KST)
Date: Wed, 29 Jul 2015 03:54:56 +0000 (GMT)
From: Manjeet Pawar <manjeet.p@samsung.com>
MIME-version: 1.0
MIME-version: 1.0
Message-id: <1590056734.149151438142095446.JavaMail.weblogic@epmlwas07a>
Subject: Re: [LTP] Regarding memcg control  testcase (mem_process.c)
Reply-To: manjeet.p@samsung.com
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
To: Jan Stancek <jstancek@redhat.com>, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Cc: AJEET YADAV <ajeet.y@samsung.com>, PANKAJ MISHRA <pankaj.m@samsung.com>

Hello Jan,
After doing analysis, I found that When memory hog process (mem_process) tries to mmap double the memory of the cgroup limit which is 4096 . I am getting OOM in that situation and send kill signal to process (which is expected behaviour) . But it could not kill the process and
 it sets the process state to uninterrupted sleep state.

To get this OOM , i need to change oom_adj value of the process '208' from -17 to -16. If i dont do this, I dont get OOM and process always stuck at mmap and try to allocate 8192 Bytes of memory.
logs:- 
[2-74.5749] Memory cgroup out of memory: Kill process 208 (mem_process) score 147000 or sacrifice child
[2-74.5840] Killed process 208 (mem_process) total-vm:2704kB, anon-rss:80kB, file-rss:484kB
by mmap is -1237753856
Warning: bad syntax, perhaps a bogus '-'? See /usr/share/doc/procps-3.2.8/FAQ
root       208 39.6  0.0   2704   564 ?        D    00:01   0:02 mem_process -m 8192  // D - means uninterrupted sleep
root       215  0.0  0.0   2412   584 ?        S    00:01   0:00 grep -r 208

I am using 3.10.84 kernel. LTP is of latest  version (ltp-full-20150420)

Regards
Manjeet

------- Original Message -------
Sender : Jan Stancek<jstancek@redhat.com>
Date : Jul 27, 2015 17:32 (GMT+09:00)
Title : Re: [LTP] Regarding memcg control testcase (mem_process.c)





----- Original Message -----
> From: "Manjeet Pawar" 
> To: "Jan Stancek" 
> Cc: ltp-list@lists.sourceforge.net, "AJEET YADAV" , "PANKAJ MISHRA" 
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
> Sender : Jan Stancek
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
