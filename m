Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QzT9k-0000JE-Sg
	for ltp-list@lists.sourceforge.net; Fri, 02 Sep 2011 12:47:36 +0000
Date: Fri, 2 Sep 2011 14:47:44 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110902124744.GA14944@saboteur.suse.cz>
References: <4E377560.7060600@cn.fujitsu.com> <4E4A2359.2040602@cn.fujitsu.com>
	<20110902124352.GA14558@saboteur.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110902124352.GA14558@saboteur.suse.cz>
Subject: Re: [LTP] [PATCH 3/6] hugemmap01.c
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
To: tangchen <tangchen@cn.fujitsu.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> The parse_opts() should stay here but with NULL parameters there are
> some default options and it makes the test bail out on invalid options
> passed.

The same goes for the rest of the tests, without this the test looping
wouldn't work. The rest seems to be good.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Special Offer -- Download ArcSight Logger for FREE!
Finally, a world-class log management solution at an even better 
price-free! And you'll get a free "Love Thy Logs" t-shirt when you
download Logger. Secure your free ArcSight Logger TODAY!
http://p.sf.net/sfu/arcsisghtdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
