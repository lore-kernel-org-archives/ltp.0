Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1TOWa9-0004L1-Io
	for ltp-list@lists.sourceforge.net; Wed, 17 Oct 2012 16:34:57 +0000
Date: Wed, 17 Oct 2012 18:32:42 +0200
From: chrubis@suse.cz
Message-ID: <20121017163242.GE27890@rei>
References: <9D7565DAE340BD42B8D00446E021992C28ABAD91@SZXEML506-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9D7565DAE340BD42B8D00446E021992C28ABAD91@SZXEML506-MBS.china.huawei.com>
Subject: Re: [LTP] testcases/kernel/syscalls/mount test cases of mount2 and
 mount3 faild in JUNE 2012 STABLE :ltp-full-20120614
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
To: Wangyicheng <yicheng.wang@huawei.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>, Dingguofu <dingguofu@huawei.com>

Hi!
> There are egiht items in the exp_enos, but the value of TST_TOTAL is
> 13, it means there are 13 checkpoints int the testcase.  As a result
> ,in the setup_test function , there are 13 switch-cases ( case
> 0??case1 ... case 12)
>
> But the number of the expect result in the exp_enos array is mismatch
> with the number of checkpoint, so the TBROK  happend.

That seems to be correct. Could you please send signed patch against
latest LTP git? Ideally attached as well as inline (the best way to send
git patches is using the 'git send-email').

Also please check your coding style (which could be easily done by
checkpatch.pl script that is shipped with linux kernel sources).

> In mount03.c, there are three issues:
>
>   1??In setup function,  the setuid_test file is in the testhome_path
>   instead of the temporary directory Path_name. It results "stat for
>   setuid_test failed"
>
>   2??In setup function,  snprintf(Path_name, PATH_MAX, "%s/%s/",
>   Path_name, mntpoint)?? it can not implement appending the mntpoint
>   string to the Path_name string;

There is still quite a lot of unnecessary string handling. Couldn't the
whole setup be done with two or three snprintf()?

>   3??In test_rwflag function, in the part of "case 2"(at line 280 in
>   mount03.c), if the "execlp(file, basename(file), NULL)" will return
>   (actually it will return), the return value of test_rwflag is always
>   1 (1 means fail),so the testcase is always failed; Another hand, if
>   it will not return (if kernel bug exists), the process will
>   terminate unexpectedly.

I'm not sure that I follow, but you changed execlp to system so that the
file gets executed in child and the return value gets passed to the
test?

> I fix them in the patch (See the attachment), and both of the tow
> testcase can get pass. Pls check the patch attachmented.

And while you are looking at these files, there are several things that
could be fixed too. These tests should use tst_require_root(NULL)
instead of if (getuid() != 0). There are unnecessary casts for pointers
returned from malloc() and useless comments like /* this is loop counter */.
If you care enough to fix them, these should be ideally fixed in separate patch.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
