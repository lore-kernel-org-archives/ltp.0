Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YLrYQ-0001a6-33
	for ltp-list@lists.sourceforge.net; Thu, 12 Feb 2015 11:03:30 +0000
Date: Thu, 12 Feb 2015 12:03:10 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150212110310.GA14329@rei>
References: <789026778.7588485.1423581396876.JavaMail.zimbra@redhat.com>
	<1688764619.7589818.1423581433749.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1688764619.7589818.1423581433749.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] network namespaces tests cleanup
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
To: Matus Marhefka <mmarhefk@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> As network namespaces tests (ltp/testcases/kernel/containers/netns) code is
> a bit messy and it's hard to figure out how return values are passed in the code
> I propose to remove all test cases and leave only the ones specified below.

Sounds good to me.

> Implementation:
> ===============
> As ip command cannot be used (because of older systems), we can use this generic
> functions to create/delete namespace handle:

Maybe we can do even better, make the testcases work both with unshare
and ip and run them twice (and get TCONF with ip on older systems) so
that we cover ip on newer systems as well.

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
