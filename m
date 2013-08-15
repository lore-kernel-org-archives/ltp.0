Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1V9x3b-0005vp-4f
	for ltp-list@lists.sourceforge.net; Thu, 15 Aug 2013 12:53:39 +0000
Date: Thu, 15 Aug 2013 14:53:41 +0200
From: chrubis@suse.cz
Message-ID: <20130815125341.GA336@rei>
References: <364946f8001c14134ce7bf32fe8b5c6b5201bcfb.1376399706.git.jstancek@redhat.com>
	<cfa1ee92801ae50856d8d7b000c5bb046724475e.1376479412.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cfa1ee92801ae50856d8d7b000c5bb046724475e.1376479412.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH v5 2/2] open_posix_testsuite/../mq_timedsend/12-1:
 fix race
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
Cc: ltp-list@lists.sourceforge.net

Hi!
> Test can send SIGUSR1 signal after thread has already completed
> and report failure from main() and success from a_thread_func():
> 
>   conformance/interfaces/mq_timedsend/12-1: execution: UNRESOLVED: Output:
>   Error: in pthread_kill
>   : Success
>   thread: mq_timedsend interrupted by signal and correctly set errno to EINTR
> 
> Synchronize exit of a_thread_func(), so that thread can exit only
> after loop sending SIGUSR1 completed.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
> Changes in v5:
> - return value from pthread_exit is not used, always return NULL

Looks good to me. Acked.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
