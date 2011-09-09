Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1R20RU-000274-AQ
	for ltp-list@lists.sourceforge.net; Fri, 09 Sep 2011 12:44:24 +0000
Date: Fri, 9 Sep 2011 14:45:07 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110909124507.GA5501@saboteur.suse.cz>
References: <20110908124331.GB9484@saboteur.suse.cz>
	<1088381242.60838.1315552402924.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1088381242.60838.1315552402924.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH 1/2] mem/lib: add vm tunable file read/write/check
 func
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
To: Zhouping Liu <zliu@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > Using sscanf() to fill string buffer is potentialy dangerous. You
> > could
> > either to use GNU extension to hardcode maximal buffer length into the
> > format string or to go trough the string while you find whitespace
> > (see
> > isspace()).
> I'm not sure how to changed it, could you give me more details about how to avoid
> Using sscanf(). and always I think Using sscanf() can solve this question.

Well, the problem with sscanf("%s", buf) is that the sscanf() don't know
how long is the buffer and that may lead to buffer overflow and strange
and unexpected behavior.

Generally there are two ways how to fix it. Either use GNU extension to
hardcode the maximal length of the buffer into the string, eg.
sscanf("%64s, buf); would say sscanf to use at most 64 bytes of the
buffer. Or go trough the string with while cycle till you find first
occurence of whitespace.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Why Cloud-Based Security and Archiving Make Sense
Osterman Research conducted this study that outlines how and why cloud
computing security and archiving is rapidly being adopted across the IT 
space for its ease of implementation, lower cost, and increased 
reliability. Learn more. http://www.accelacomm.com/jaw/sfnl/114/51425301/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
