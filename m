Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1VWki9-0000St-5a
	for ltp-list@lists.sourceforge.net; Thu, 17 Oct 2013 10:21:45 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VWki7-0005IA-3Y
	for ltp-list@lists.sourceforge.net; Thu, 17 Oct 2013 10:21:45 +0000
Message-ID: <525FB9FB.8030503@cn.fujitsu.com>
Date: Thu, 17 Oct 2013 18:20:43 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1382002005-15348-1-git-send-email-jshao@redhat.com>
In-Reply-To: <1382002005-15348-1-git-send-email-jshao@redhat.com>
Subject: Re: [LTP] [PATCH] setns: add ns_name in TINFO
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Monson Shao <jshao@redhat.com>, ltp-list@lists.sourceforge.net

On 10/17/2013 05:26 PM, Monson Shao wrote:
> Make it clear which namespace is enabled and being tested.
> 
> before:
> setns01     0  TINFO  :  ns_fds[0]=5, ns_types[0]=0x8000000
> setns01     0  TINFO  :  ns_fds[1]=6, ns_types[1]=0x20000
> setns01     0  TINFO  :  ns_fds[2]=7, ns_types[2]=0x40000000
> setns01     0  TINFO  :  ns_fds[3]=8, ns_types[3]=0x20000000
> setns01     0  TINFO  :  ns_fds[4]=9, ns_types[4]=0x4000000
> 
> after:
> setns01     0  TINFO  :  ns_name=ipc, ns_fds[0]=5, ns_types[0]=0x8000000
> setns01     0  TINFO  :  ns_name=mnt, ns_fds[1]=6, ns_types[1]=0x20000
> setns01     0  TINFO  :  ns_name=net, ns_fds[2]=7, ns_types[2]=0x40000000
> setns01     0  TINFO  :  ns_name=pid, ns_fds[3]=8, ns_types[3]=0x20000000
> setns01     0  TINFO  :  ns_name=uts, ns_fds[4]=9, ns_types[4]=0x4000000
> 
> Signed-off-by: Monson Shao <jshao@redhat.com>

Applied, thank you.

Wanlong Gao


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
