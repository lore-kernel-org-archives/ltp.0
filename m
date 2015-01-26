Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YFk0E-0002Ca-2L
	for ltp-list@lists.sourceforge.net; Mon, 26 Jan 2015 13:46:54 +0000
Date: Mon, 26 Jan 2015 14:45:56 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150126134555.GC25601@rei.suse.de>
References: <20150126094613.GA2055@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150126094613.GA2055@localhost.localdomain>
Subject: Re: [LTP] [PATCH] increasing buffer size for correct alignment
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
To: ltp-list@lists.sourceforge.net

Hi!
> I have a patch for aio-stress to align buffer address correctly. Please
> have a look. Thanks in advance.
> 
> For align buffer address to the number specified by -a option in
> aio-stress, it needs to add page_size_mask extra length to total_ram
> before call allocation functions. Or it wouldn't be correct in this line
> after the allocation:
> 
>          p = (char *)((intptr_t) (p + page_size_mask) & ~page_size_mask);

You are adding the page_size_mask to all uses of total_ram, wouldn't it
be easier to add it to the total_ram at the start of the function (and
remove the page_size_mask from the malloc() call that has it allready)?

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
