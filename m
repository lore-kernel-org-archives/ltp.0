Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YZwG6-0001Pw-M5
	for ltp-list@lists.sourceforge.net; Mon, 23 Mar 2015 06:54:46 +0000
Date: Mon, 23 Mar 2015 07:53:53 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150323065353.GC3618@rei>
References: <756183AD4F83414184BA6A0635785E70A55C4B3C@LGEVEXMBAPSVC1.LGE.NET>
	<1848532869.446726.1426839071051.JavaMail.zimbra@redhat.com>
	<756183AD4F83414184BA6A0635785E70A55C4BDC@LGEVEXMBAPSVC1.LGE.NET>
	<1985883687.604987.1426857226768.JavaMail.zimbra@redhat.com>
	<550C296E.3080109@st.com> <20150322064333.GM4504@vapier>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150322064333.GM4504@vapier>
Subject: Re: [LTP] MAP_LOCKED issue in mmap with MAP_ANYNOMOUS
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
To: Carmelo Amoroso <carmelo.amoroso@st.com>, ltp-list@lists.sourceforge.net

Hi!
> > So, should the LTP be updated accordingly ?
> 
> if the kernel has changed behavior, LTP needs to adapt to it (assuming the 
> kernel people changed the behavior on purpose)

The kernel contradicts the manual page here and the change was
unintentional, it's side effect from fixes for deadlock.

Michal Hocko was looking into the issue, he said that they will likely
discuss it on LSMM. I will ask him if they agreed on what should be done
about it.

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
