Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PR4fQ-0002gd-5d
	for ltp-list@lists.sourceforge.net; Fri, 10 Dec 2010 15:13:52 +0000
Date: Fri, 10 Dec 2010 16:27:33 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101210152733.GA19747@saboteur.suse.cz>
References: <1121514674.248741291701070316.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<2077621807.248761291701110101.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2077621807.248761291701110101.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH] a race in pid generation that causes pids to be
 reused immediatelly
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
To: caiqian@redhat.com
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> > Ask the expert ;). Seriously kernel folks should help with writing
> > tests, they are the only ones who trully know what to test anyway.
> Well, they can't test their own code. :) -- Software testing rule #1.

That's true in ideal world, but then, there are no bugs in ideal world
either. ;)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
