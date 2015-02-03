Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YIa2u-0007yq-Ph
	for ltp-list@lists.sourceforge.net; Tue, 03 Feb 2015 09:45:24 +0000
Date: Tue, 3 Feb 2015 10:45:06 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150203094506.GA15330@rei.scz.novell.com>
References: <1422954897-11966-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<1422954897-11966-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<54D09440.7070701@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <54D09440.7070701@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 2/2] syscalls/mmap16: regression test for data
 corruption when blocksize < pagesize for mmaped data
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
> As you have pointed that we can use '-i num' in runtest file to make this test run
> multiple times, but if a user just chdir to testcases/kernel/syscalls/mmap/ and executes
> './mmap16' directly, and if also virtual memory subsystem happens to write dirty pages,
> test result will be not accurate. So here I still make this test run 10 times at lease ;)

You can then do two loops. One for the test itself and for the test
looping.

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
