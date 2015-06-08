Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z20FJ-0008Q5-Ml
	for ltp-list@lists.sourceforge.net; Mon, 08 Jun 2015 16:49:57 +0000
Date: Mon, 8 Jun 2015 18:48:52 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150608164852.GA17421@rei.suse.de>
References: <96265675.666421433736004552.JavaMail.weblogic@epmlwas09a>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <96265675.666421433736004552.JavaMail.weblogic@epmlwas09a>
Subject: Re: [LTP] [PATCH]: Fix memory leak
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
Cc: "ajeet.y@samsung.com" <ajeet.y@samsung.com>, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>, akhilesh.k@samsung.com

Hi!
There is also missing check for the return from malloc().

And given that we do not return the pointer to the array and that the
cound is at most 6, what about changing the malloc() to array on stack?

I.e.

- char *found = (char *) malloc(count);
- memset(found, 0, count);
+ char found[count];

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
