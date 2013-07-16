Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Uz3Bk-0002Fn-8z
	for ltp-list@lists.sourceforge.net; Tue, 16 Jul 2013 11:13:00 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Uz3Bi-0004hS-5u
	for ltp-list@lists.sourceforge.net; Tue, 16 Jul 2013 11:13:00 +0000
Date: Tue, 16 Jul 2013 07:12:48 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1942688902.1035838.1373973168675.JavaMail.root@redhat.com>
In-Reply-To: <51E5189F.3090703@oracle.com>
References: <1373963498-838-1-git-send-email-penght@cn.fujitsu.com>
	<1752195557.979708.1373966382515.JavaMail.root@redhat.com>
	<51E5136F.5080103@cn.fujitsu.com> <51E5189F.3090703@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] testcases/kernel/firmware: fix a bug of make
 install
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
To: alexey kodanev <alexey.kodanev@oracle.com>
Cc: ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "alexey kodanev" <alexey.kodanev@oracle.com>
> To: "Peng Haitao" <penght@cn.fujitsu.com>
> Cc: "Jan Stancek" <jstancek@redhat.com>, ltp-list@lists.sourceforge.net
> Sent: Tuesday, 16 July, 2013 11:55:43 AM
> Subject: Re: [LTP] [PATCH] testcases/kernel/firmware: fix a bug of make install
> 
> Hi!
> 
> >>
> >>   ifeq ($(SKIP),0)
> >>   SUBDIRS                        += fw_load_kernel
> >> -SUBDIRS                        += fw_load_user
> >>   endif
> >> +SUBDIRS                        += fw_load_user
> >>
> >> We always build userspace part. The check for kernel version is
> >> already in setup(). We just need to make sure userspace bits compile
> >> everywhere.
> >> I tried 2.6.32 based kernel, it builds and runs:
> >> # ./fw_load_user/fw_load
> >> fw_load     1  TCONF  :  Test must be run with kernel 3.7 or newer
> >> fw_load     2  TCONF  :  Remaining cases not appropriate for configuration
> >>
> or in case we don't want compile user-space part:

I think the issue here is that this testcase is listed in some runtest file (kernel_misc).
So when you try to run it, ltp is looking for 'fw_load' binary, which doesn't exist.

Regards,
Jan

> ...
> 
> SUBDIRS			+= fw_load_user
> include $(top_srcdir)/include/mk/generic_trunk_target.mk
> else
> include $(top_srcdir)/include/mk/generic_leaf_target.mk
> endif
> 
> Thanks,
> Alexey
> 
> 

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
