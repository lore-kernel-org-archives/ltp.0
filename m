Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1TJLfT-0000zq-ID
	for ltp-list@lists.sourceforge.net; Wed, 03 Oct 2012 09:55:03 +0000
Date: Wed, 3 Oct 2012 11:55:29 +0200
From: chrubis@suse.cz
Message-ID: <20121003095529.GA22986@saboteur.suse.cz>
References: <503DE20A.8010200@casparzhang.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <503DE20A.8010200@casparzhang.com>
Subject: Re: [LTP] hugemmap02/03?
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> I looked into hugemmap02 and hugemmap03, they were about huge maping in 
> high region/low region. After checked the codes, I don't think they're 
> well-implmented, or even worse, I don't think the tests make too much 
> sense. I don't know mmap regions very well, is there any other comments 
> against these two cases?

I've glanced over the code but haven't found anything unusual (the
quality reflect rest of the LTP).

On the other hand I don't really understand the assertions here. Could
you describe more closely why are these assertions wrong (or point me to
some source of information)?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Don't let slow site performance ruin your business. Deploy New Relic APM
Deploy New Relic app performance management and know exactly
what is happening inside your Ruby, Python, PHP, Java, and .NET app
Try New Relic at no cost today and get our sweet Data Nerd shirt too!
http://p.sf.net/sfu/newrelic-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
