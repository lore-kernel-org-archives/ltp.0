Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1PGS2a-0005Jv-I5
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 07:57:52 +0000
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PGS2Z-00083l-Mc
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 07:57:52 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20101027094502.208c1207.kamezawa.hiroyu@jp.fujitsu.com>
References: <1288089237.5010.9.camel@subratamodak.linux.ibm.com>
	<20101027094502.208c1207.kamezawa.hiroyu@jp.fujitsu.com>
Date: Thu, 11 Nov 2010 13:27:25 +0530
Message-Id: <1289462245.5622.46.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [linux-2.6.36-git7: Power7] LTP Memory CGROUP
	Controller	functional test creates Backtrace,
	OOMKill & rcu_sched_state detected stall	jiffies
Reply-To: subrata@linux.vnet.ibm.com
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
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Linuxppc-dev <Linuxppc-dev@ozlabs.org>, linux-kernel <linux-kernel@vger.kernel.org>, ltp-list <ltp-list@lists.sf.net>

On Wed, 2010-10-27 at 09:45 +0900, KAMEZAWA Hiroyuki wrote: 
> On Tue, 26 Oct 2010 16:03:56 +0530
> Subrata Modak <subrata@linux.vnet.ibm.com> wrote:
> 
> > If you run LTP Memory CGROUP Controller functional test on
> > linux-2.6.36-git7, the following Backtrace, OOMKill & rcu_sched_state
> > detected stall jiffies are created. The machine is not reachable
> > thereafter. Ways to reproduce this problem:
> > 
> > 1) Build and boot kernel 2.6.36-git7 on Power7 machine with attached
> > config file,
> > 2) Fetch, build and install LTP:
> > 	git clone git://ltp.git.sourceforge.net/gitroot/ltp/ltp
> > 	cd ltp
> > 	./configure
> > 	make
> > 	make install
> > 3) Create a LTP runtest file /opt/ltp/runtest/memcg_function_test with
> > the following entry:
> > memcg_function          memcg_function_test.sh
> > <<EOF>>
> > 	cd /opt/ltp
> > 	./runltp -f memcg_function_test
> > 
> 
> IIUC, memcg test includes intentional OOM-Kill test by setting the limit to 0.
> And it has another test to set the limit to PAGE_SIZE.
> 
> In your environemnt, I think page size is 64kb...right ?
> 
> About rcu_sched_state()....I have no idea at this stage. I reviewed memcontrol.c
> and oom_kill.c again and coundn't found anything in quick review.
> 
> Could you try again after -rc1 shipped ?

Oh Sure, I saw this mail now. I will try it out on the latest git tree
available :-)

Regards--
Subrata

> I think Andrew Morton sent some amount of updates for oom_kill and memcg, vmscan
> to Linus, today.
> 
> Thanks,
> -Kame
> 


------------------------------------------------------------------------------
Centralized Desktop Delivery: Dell and VMware Reference Architecture
Simplifying enterprise desktop deployment and management using
Dell EqualLogic storage and VMware View: A highly scalable, end-to-end
client virtualization framework. Read more!
http://p.sf.net/sfu/dell-eql-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
