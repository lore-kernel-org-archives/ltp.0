Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1V46V8-0003Kq-1W
	for ltp-list@lists.sourceforge.net; Tue, 30 Jul 2013 09:45:54 +0000
Date: Tue, 30 Jul 2013 11:45:42 +0200
From: chrubis@suse.cz
Message-ID: <20130730094542.GA1184@rei.scz.novell.com>
References: <1374575324-26149-1-git-send-email-zliu@redhat.com>
	<51EE6C97.1050502@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51EE6C97.1050502@cn.fujitsu.com>
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
> > make[1]: Leaving directory `/mnt/tests/kernel/distribution/ltp/git_test/ltp/testcases/kernel/containers/libclone'
> > gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -I../../../include -I../../../include   -L../../../lib  check_for_unshare.c  -ldl -lltp -o check_for_unshare
> > check_for_unshare.c: In function ???main???:
> > check_for_unshare.c:35:8: warning: variable ???ret??? set but not used [-Wunused-but-set-variable]
> >   void *ret;
> >         ^
> > ../../../lib/libltp.a(tst_res.o): In function `cat_file':
> > /mnt/tests/kernel/distribution/ltp/git_test/ltp/lib/tst_res.c:777: undefined reference to `TCID'
> > /mnt/tests/kernel/distribution/ltp/git_test/ltp/lib/tst_res.c:787: undefined reference to `TCID'
> > /mnt/tests/kernel/distribution/ltp/git_test/ltp/lib/tst_res.c:795: undefined reference to `TCID'
> > ../../../lib/libltp.a(tst_res.o): In function `tst_res':
> > /mnt/tests/kernel/distribution/ltp/git_test/ltp/lib/tst_res.c:301: undefined reference to `TCID'
> > /mnt/tests/kernel/distribution/ltp/git_test/ltp/lib/tst_res.c:317: undefined reference to `TCID'
> > ../../../lib/libltp.a(tst_res.o):/mnt/tests/kernel/distribution/ltp/git_test/ltp/lib/tst_res.c:370: more undefined references to `TCID' follow
> > collect2: error: ld returned 1 exit status
> > make: *** [check_for_unshare] Error 1
> > 
> > that's because commit 18f7be7eb used LTP lib function tst_resm(), using printf() instead can avoid it.
> > 
> > Signed-off-by: Zhouping Liu <zliu@redhat.com>
> 
> 
> Oops, it's my fault. Thank you, applied.

This is a good workaround for now, but the correct fix would be fixing
the check_for_unshare source to define the TCID otherwise it could break
anytime we do change in the tst_kvercmp() interface.

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
