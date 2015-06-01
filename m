Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YzR3D-0002bP-EW
	for ltp-list@lists.sourceforge.net; Mon, 01 Jun 2015 14:50:51 +0000
Date: Mon, 1 Jun 2015 16:49:51 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150601144951.GC12369@rei.suse.de>
References: <388214473.190591432788271460.JavaMail.weblogic@epmlwas05c>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <388214473.190591432788271460.JavaMail.weblogic@epmlwas05c>
Subject: Re: [LTP] [PATCH]: Fix memory leak by freeing buf
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
To: Manjeet Pawar <manjeet.p@samsung.com>
Cc: "ajeet.y@samsung.com" <ajeet.y@samsung.com>, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>, Yogesh Narayan Gaur <yn.gaur@samsung.com>

Hi!
Looking at the code, ltp-pan exits if this function fails, so the danger
of memory leak was not real here.

But it's better to fix the function, pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
