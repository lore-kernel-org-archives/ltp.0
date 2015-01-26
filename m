Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YFlyo-0004sm-Kg
	for ltp-list@lists.sourceforge.net; Mon, 26 Jan 2015 15:53:34 +0000
Date: Mon, 26 Jan 2015 16:52:36 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150126155236.GB27890@rei.suse.de>
References: <1418904024-29740-1-git-send-email-lijinyue@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1418904024-29740-1-git-send-email-lijinyue@huawei.com>
Subject: Re: [LTP] [PATCH] controllers/cgroup_fj:fix mount error for mount
 tools above v2.21
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
To: lijinyue <lijinyue@huawei.com>
Cc: ltp-list@lists.sourceforge.net, dingguofu@huawei.com, zhanyongming@huawei.com

Hi!
> For util-linux version above v2.21(eg, Red Hat Enterprise Linux 7.0, util-linux v2.23.2),
> some tests in run_cgroup_test_fj.sh will test failed.
> eg:
>         cgroup_test_fj    1  TFAIL  :  case13(function  2 1 1 2 1 2 3 2 1)    FAIL
> 
> The reason is that mount version above v2.21 will cause mount error in the following scenes:
>         (mount from util-linux 2.23.2)
>         mkdir /dev/cgroup
>         mount -t cgroup -o cpuset,release_agent=  cgroup /dev/cgroup
> 
>         error output:
>         mount: special device cgroup does not exist
> While, for mount version v2.19.1(eg, SLES 11 sp2, mount from util-linux 2.19.1 )
>         mount will success like this:
>         cgroup on /dev/cgroup type cgroup (rw,cpuset,release_agent=)

The empty release agent seems to be specially crafted testcase. The
function get_release_agent_para() has special case to set it to " ".

So if this test fails, either util-linux is broken or the test assertion
is wrong (it worked by accident) and should be removed. Either way this
needs more investigation.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
