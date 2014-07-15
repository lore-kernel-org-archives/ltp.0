Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1X73f7-0007z7-3S
	for ltp-list@lists.sourceforge.net; Tue, 15 Jul 2014 14:24:57 +0000
Date: Tue, 15 Jul 2014 16:24:26 +0200
From: chrubis@suse.cz
Message-ID: <20140715142426.GB28667@rei>
References: <1405230591-19166-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1405230591-19166-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2 1/2] lib/tst_res.c: introduce
 tst_record_childstatus()
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> In case we need do real test work in child porcess, it is OK for child process
> to use tst_resm(), tst_brkm() or tst_exit(). Parent process can use
> tst_record_childstatus() to make child process's test results propagated to parent
> process correctly.
> 
> Meanwhile we reset T_exitval to 0 for child process in tst_fork(), which will
> make child process can record test results with tst_resm() or tst_brkm() correctly.

Looks technically correct to me. The only caveat is that you have to
decide to use either tst_* interface in child or plain exit() and do not
to mix them.

Also as the code si now we don't have to reset the T_exitval because
what we do now is or the flags form child to add them to the paren't
flags (which will be set anyway if the child has started with nonzero
flags).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
