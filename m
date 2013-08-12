Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1V8qu6-0005KJ-6N
	for ltp-list@lists.sourceforge.net; Mon, 12 Aug 2013 12:07:18 +0000
Date: Mon, 12 Aug 2013 14:07:16 +0200
From: chrubis@suse.cz
Message-ID: <20130812120716.GD24962@rei>
References: <a4b10219d9304cc8ea0fb62447640710d72d05c6.1376300996.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a4b10219d9304cc8ea0fb62447640710d72d05c6.1376300996.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] aio_fsync: wait until aio_fsync completes
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
> This is to avoid SIGSEGV:
>  #0  0x000003fffd1f4a24 in _IO_flush_all_lockp () at genops.c:850
>  #1  0x000003fffd1f4b8e in _IO_cleanup () at genops.c:1010
>  #2  0x000003fffd1a88f6 in __run_exit_handlers () at exit.c:90
>  #3  0x000003fffd1a89b0 in __GI_exit () at exit.c:99
>  #4  0x000003fffd18c822 in __libc_start_main () at libc-start.c:292
>  #5  0x0000000080000b76 in _start ()
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Acked.

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
