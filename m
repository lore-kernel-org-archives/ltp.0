Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1V46X1-00014u-Dc
	for ltp-list@lists.sourceforge.net; Tue, 30 Jul 2013 09:47:51 +0000
Date: Tue, 30 Jul 2013 11:47:42 +0200
From: chrubis@suse.cz
Message-ID: <20130730094742.GB1184@rei.scz.novell.com>
References: <1374575324-26149-1-git-send-email-zliu@redhat.com>
	<51EE6C97.1050502@cn.fujitsu.com>
	<20130730094542.GA1184@rei.scz.novell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130730094542.GA1184@rei.scz.novell.com>
Subject: Re: [LTP] [PATCH] lib/tst_kvercmp: fixed a compiling error
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> > > that's because commit 18f7be7eb used LTP lib function tst_resm(), using printf() instead can avoid it.
> > > 
> > > Signed-off-by: Zhouping Liu <zliu@redhat.com>
> > 
> > 
> > Oops, it's my fault. Thank you, applied.
> 
> This is a good workaround for now, but the correct fix would be fixing
> the check_for_unshare source to define the TCID otherwise it could break
> anytime we do change in the tst_kvercmp() interface.
> 

(And change back the printf to tst_resm() in the tst_kvercmp)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
