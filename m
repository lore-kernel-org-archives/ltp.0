Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1VtEva-0000wy-5W
	for ltp-list@lists.sourceforge.net; Wed, 18 Dec 2013 11:04:34 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VtEvY-0007Gx-Uw
	for ltp-list@lists.sourceforge.net; Wed, 18 Dec 2013 11:04:34 +0000
Date: Wed, 18 Dec 2013 06:04:24 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <332691450.7043247.1387364664832.JavaMail.root@redhat.com>
In-Reply-To: <1387359135.1664.39.camel@G08JYZSD130126>
References: <1387359135.1664.39.camel@G08JYZSD130126>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v5 2/2] clone/clone08.c: add new tests
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
To: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>



----- Original Message -----
> From: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: "ltp-list" <ltp-list@lists.sourceforge.net>
> Sent: Wednesday, 18 December, 2013 10:32:15 AM
> Subject: [PATCH v5 2/2] clone/clone08.c: add new tests
> 
> Add new tests for clone(2):
> CLONE_PARENT
> CLONE_CHILD_SETTID
> CLONE_PARENT_SETTID
> CLONE_STOPPED
> CLONE_THREAD
> 
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>

Looks good to me.

Reviewed-by: Jan Stancek <jstancek@redhat.com>

> ---
>  runtest/ltplite                           |   1 +
>  runtest/stress.part3                      |   1 +
>  runtest/syscalls                          |   1 +
>  testcases/kernel/syscalls/.gitignore      |   1 +
>  testcases/kernel/syscalls/clone/clone08.c | 307
>  ++++++++++++++++++++++++++++++
>  5 files changed, 311 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/clone/clone08.c
> 

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
