Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Qr9Dp-0004QB-NR
	for ltp-list@lists.sourceforge.net; Wed, 10 Aug 2011 13:53:25 +0000
Date: Wed, 10 Aug 2011 15:57:19 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110810135719.GF8687@saboteur.suse.cz>
References: <1609707634.578233.1312258810042.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
	<474812428.578270.1312259338813.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <474812428.578270.1312259338813.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] Running only kernel syscall tests
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
To: Shakthi Kannan <skannan@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Are there any options to runltp or any other means to just run the
> kernel syscall tests? How long does it take to run the runalltests.sh
> on an i386/x86_64 machine?

You can save a lot of time (hours) if you omit the aio testcases, these
are submitting a lot of aio requests moving gigabytes of data back and
forth.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
uberSVN's rich system and user administration capabilities and model 
configuration take the hassle out of deploying and managing Subversion and 
the tools developers use with it. Learn more about uberSVN and get a free 
download at:  http://p.sf.net/sfu/wandisco-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
