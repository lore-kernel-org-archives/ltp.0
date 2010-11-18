Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PJ8N4-0007nt-6G
	for ltp-list@lists.sourceforge.net; Thu, 18 Nov 2010 17:34:06 +0000
Date: Thu, 18 Nov 2010 18:45:55 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101118174555.GA19296@saboteur.suse.cz>
References: <1428547509.2904601289827655670.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<431327867.2904911289827840762.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <431327867.2904911289827840762.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] maximum seconds of -I
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
> Hi, I am wondering if there is a limitation of seconds you can specify in standard command-line options for,
> 
> -I x    Execute test for x seconds
> 
> I noticed that when given a value like 3600, the test returned immediately like,
> 
> ./hugemmap04 -I 3600 -H /var/hugetlbfs
> 

Well these "standart" command line options are broken for a long time
and nobody cares as the tests are executed automatically by scripts
anyway. You could have a look at lib/parse_opts.c and include/usctest.h
if you are interested.

For a future I'm thinking about removing some of the functionality (if
not all of it) as most of it could be easily done by tools that executes
these tests. And this would lead to big simplification of the tests.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today
http://p.sf.net/sfu/msIE9-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
