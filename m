Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VdLt9-0008KJ-NM
	for ltp-list@lists.sourceforge.net; Mon, 04 Nov 2013 15:16:23 +0000
Date: Mon, 4 Nov 2013 16:16:01 +0100
From: chrubis@suse.cz
Message-ID: <20131104151600.GA10512@rei>
References: <526A4001.5050909@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <526A4001.5050909@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] access(2): add ELOOP, ENOTDIR,
 EROFS error values test
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
To: "Wang, Xiaoguang" <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +/*
> + * EROFS need superuser privilege (mount and umount a readonly file system),
> + * but the other error values tests need a normal user.
> + * So we first call setup1() with superuser privilege to test EROFS, and then
> + * use setup() to call setuid()to change the real user id to perform
> + * other tests.
> + */

Ah, this adds unexpected complexity and does not work test looping :(.

I've looked closely on the test code and the problem is that acces uses
real user id so we have to drop the rights to check the access call but
we need to be able to unmount the fs at the end of the test, which is
privileged operation.

Only solution that I have currenlty in mind is to run the test from
within the child process that drops the rights so that the parent
can perform the cleanup at the end, but again this adds unnecessary
complexity.

Was this problem the original reason why you added the new testcase for
the EROFS part? If so, you should have spoken as I did not foresee that
we will hit this problem.

So we should either proceed with the previous version (EROFS in separate
test) or move the code to child processes. The first solution seems
better to me, what do you think?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
