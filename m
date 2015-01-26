Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YFmwD-0007ZN-9Q
	for ltp-list@lists.sourceforge.net; Mon, 26 Jan 2015 16:54:57 +0000
Date: Mon, 26 Jan 2015 17:53:59 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150126165359.GC29158@rei>
References: <1419737900-6117-1-git-send-email-liwang@redhat.com>
	<1915647923.1462940.1419739614431.JavaMail.zimbra@redhat.com>
	<197257986.1477814.1419759005661.JavaMail.zimbra@redhat.com>
	<CAE1O6mjDP5TJi6XaqaX18VQXTpZFU04ReB250GZWRimjJBkhWA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAE1O6mjDP5TJi6XaqaX18VQXTpZFU04ReB250GZWRimjJBkhWA@mail.gmail.com>
Subject: Re: [LTP] Fwd: [PATCH] mem/hugeshmat: new case for hugepage leak
 inspection
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
To: Li Wang <wangli.ahau@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Description of Problem:
>     When over 1GB shared memory was alocated in hugepage, the hugepage
>     is not released though process finished.
> 
> Signed-off-by: Li Wang <liwang@redhat.com>

Ah, there is another version. Usually people add version number to the
email subject so that is clear which patch is the newest and include
short list of changes from the previous versions...

Which one is the latest version?

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
