Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <lizf@cn.fujitsu.com>) id 1MlFUk-0006Yn-Ss
	for ltp-list@lists.sourceforge.net; Wed, 09 Sep 2009 05:13:26 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MlFUd-00023X-Cn
	for ltp-list@lists.sourceforge.net; Wed, 09 Sep 2009 05:13:26 +0000
Message-ID: <4AA7391B.4020804@cn.fujitsu.com>
Date: Wed, 09 Sep 2009 13:11:55 +0800
From: Li Zefan <lizf@cn.fujitsu.com>
MIME-Version: 1.0
References: <4AA67D12.5010602@in.ibm.com>
In-Reply-To: <4AA67D12.5010602@in.ibm.com>
Subject: Re: [LTP] LTP : Fix connectors event_generator program : gen_fork
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
To: Suzuki Poulose <suzuki@in.ibm.com>
Cc: ltp-list@lists.sourceforge.net

Suzuki Poulose wrote:
> Hi,
> 
> There is a testcase issue in the event_generator code. The gen_fork() is
> called to generate the fork event.
> 
> The child process prints the following message:
> 
> static inline void gen_fork(void)
> {
>         pid_t pid;
>         int status;
> 
>         pid = fork();
>         if (pid == 0) {
>                 printf("fork parent: %d, child: %d\n", getppid(),
> getpid());
>                 exit(0);
>         } else if (pid < 0) {
>                 fprintf(stderr, "fork() failed\n");
>                 exit(1);
>         }
> }
> 
> Now the parent process just exits after this call. So, if the child
> doesn't get to run before parent exits, the child will see the ppid as
> 1, that of INIT and this contradicts the actual data. Hence the test fails.
> 
> Attached patch fixes the issue. I have verified the same. Please apply.
> 

Thanks for fixing it.

Acked-by: Li Zefan <lizf@cn.fujitsu.com>

But you forgot to add your Signed-off-by in the patch. ;)


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
