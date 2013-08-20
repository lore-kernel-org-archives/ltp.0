Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1VBfoP-0005jt-JY
	for ltp-list@lists.sourceforge.net; Tue, 20 Aug 2013 06:53:05 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VBfoN-0003xW-Fk
	for ltp-list@lists.sourceforge.net; Tue, 20 Aug 2013 06:53:05 +0000
Message-ID: <52131226.20101@cn.fujitsu.com>
Date: Tue, 20 Aug 2013 14:52:22 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <a4b10219d9304cc8ea0fb62447640710d72d05c6.1376300996.git.jstancek@redhat.com>
In-Reply-To: <a4b10219d9304cc8ea0fb62447640710d72d05c6.1376300996.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] aio_fsync: wait until aio_fsync completes
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 08/12/2013 07:03 PM, Jan Stancek wrote:
> This patch introduces wait so that testcases exit doesn't race
> with completion of aio_fsync.
> 
> This is to avoid SIGSEGV:
>  #0  0x000003fffd1f4a24 in _IO_flush_all_lockp () at genops.c:850
>  #1  0x000003fffd1f4b8e in _IO_cleanup () at genops.c:1010
>  #2  0x000003fffd1a88f6 in __run_exit_handlers () at exit.c:90
>  #3  0x000003fffd1a89b0 in __GI_exit () at exit.c:99
>  #4  0x000003fffd18c822 in __libc_start_main () at libc-start.c:292
>  #5  0x0000000080000b76 in _start ()
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>


------------------------------------------------------------------------------
Introducing Performance Central, a new site from SourceForge and 
AppDynamics. Performance Central is your source for news, insights, 
analysis and resources for efficient Application Performance Management. 
Visit us today!
http://pubads.g.doubleclick.net/gampad/clk?id=48897511&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
