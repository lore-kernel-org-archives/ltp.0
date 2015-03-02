Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YSOpN-0007EE-RE
	for ltp-list@lists.sourceforge.net; Mon, 02 Mar 2015 11:48:01 +0000
Date: Mon, 2 Mar 2015 12:47:20 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150302114720.GA10726@rei>
References: <1424978234-21530-1-git-send-email-jjaburek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1424978234-21530-1-git-send-email-jjaburek@redhat.com>
Subject: Re: [LTP] [PATCH] syscalls/fadvise03: add alternative expected
 s390-only values
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
To: Jiri Jaburek <jjaburek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Since this test tries 0-32 values as 'advice', it needs to expect the
> little-known ABI hack used for fadvise64 on s390 in the kernel,
> see Linux kernel commit 068e1b94bbd268f375349f68531829c8b7c210bc.
> 
> Signed-off-by: Jiri Jaburek <jjaburek@redhat.com>

Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
