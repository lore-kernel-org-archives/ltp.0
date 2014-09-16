Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XTscN-0002ax-JI
	for Ltp-list@lists.sourceforge.net; Tue, 16 Sep 2014 13:16:27 +0000
Date: Tue, 16 Sep 2014 15:16:14 +0200
From: chrubis@suse.cz
Message-ID: <20140916131613.GA2967@rei>
References: <CAD4NA3205uSovUYbfDOK0TnqOevjrGE=V9vaoQ5Hvq6aeu32hw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAD4NA3205uSovUYbfDOK0TnqOevjrGE=V9vaoQ5Hvq6aeu32hw@mail.gmail.com>
Subject: Re: [LTP] Couple of queries on LTP compilation and Hugetlb testcases
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
To: M Ltp <ltp.task@gmail.com>
Cc: Ltp-list@lists.sourceforge.net

Hi!
> I have a couple of queries:
>  1. Can we compile a single test case in LTP? If yes, please share the
> procedure.

Typing make in the corresponding test directory should work just fine.
(you have to run the configure script first)

>  2. The hugetlb testcases present under
> '<ltp>/testcases/kernel/mem/hugetlb' are statically initializing the number
> of huge pages to 128. Is there any reason for the same? Please clarify.

My guess is that the test tries to enable hugepages with some reasonable
amount of hugepages and 128 was choosen as a default.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce.
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
