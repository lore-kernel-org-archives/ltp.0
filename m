Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YxwfZ-0007qh-1v
	for ltp-list@lists.sourceforge.net; Thu, 28 May 2015 12:12:17 +0000
Date: Thu, 28 May 2015 14:11:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150528121121.GA3941@rei.suse.de>
References: <1432805039-21401-1-git-send-email-lijinyue@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1432805039-21401-1-git-send-email-lijinyue@huawei.com>
Subject: Re: [LTP] [PATCH] controllers/memcg: memory.limit_in_bytes is round
 down on kernel >= 3.19.0
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
To: Li Jinyue <lijinyue@huawei.com>
Cc: ltp-list@lists.sourceforge.net, zhanyongming@huawei.com

Hi!
> Since commit 3e32cb2e0a12b6915056ff04601cf1bb9b44f967, case 22-24 in
> memcg_function_test.sh will fail for unaligned PAGESIZE input.
> 
> We need update the test more smoothly.

I was talking with Michal Hocko about these failures recently [1] and we
concluded that better fix would be to pass the test both if the value
was rouned up or down. Because that way the test will still work if
someone backports the changes to the older kernels (either via stable
kernel updates or by distributions).

And I pinged him now and got the patch he worked out for this that
changes the test_limit_in_bytes() instead.

[1] http://www.spinics.net/lists/linux-mm/index.html#88491

Thanks for your effort either way.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
