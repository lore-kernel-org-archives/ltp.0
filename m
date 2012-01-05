Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RiptQ-0007pY-8F
	for ltp-list@lists.sourceforge.net; Thu, 05 Jan 2012 16:10:16 +0000
Date: Thu, 5 Jan 2012 17:21:08 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120105162108.GA22435@saboteur.suse.cz>
References: <4EEB065C.4060805@cn.fujitsu.com>
	<20111222151810.GA1494@saboteur.suse.cz>
	<4EF98B7B.3040005@cn.fujitsu.com>
	<20111228115439.GA18611@saboteur.suse.cz>
	<4EFBCE29.9070000@cn.fujitsu.com>
	<20111230132552.GB26420@saboteur.suse.cz>
	<4F02696B.9040202@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F02696B.9040202@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] memcg_function:fix the wrong of test_proc_kill
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> > Also note that running the sleep 2; kill ... in background is not
> > necessary as shell is required to save return status from background
> > command if it's pid was saved by $!.
> > 
> > Generally sequence of
> > 
> > command&
> > pid=$!
> > kill $pid
> > wait $pid
> > 
> > Should work as expected.
> > 
> 
> Thanks for you comment.
> I think the following way is better.
> 
> test_proc_kill() tests process will be killed due to exceed memory limit, but
> when memcg_process exit due to mmap/munmap fails, the case still pass.

This one seems right to me as well, commited.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
