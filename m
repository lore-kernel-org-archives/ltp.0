Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1TJmL0-0006Rv-A9
	for ltp-list@lists.sourceforge.net; Thu, 04 Oct 2012 14:23:42 +0000
Date: Thu, 4 Oct 2012 16:21:31 +0200
From: chrubis@suse.cz
Message-ID: <20121004142130.GB24253@rei.suse.cz>
References: <20100216022719.GA7902@saboteur.suse.cz>
	<1513655937.3221262.1348143318321.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1513655937.3221262.1348143318321.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH] proc01: add option to limit max read bytes
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Seems like a good idea. Question is, what should we choose
> as good default for maximum. I'm running it now with:
> proc01 proc01 -m 128
> 
> I chose 128MB as rule of thumb, so I can hit some real pages
> and holes (in pagemap). 128MB equals to 4194304 pages (32bits per entry).
> If page_size is 4kB, this covers first 16G of address space, so
> it's likely you hit all kinds of pagemap entries.

I've commited the change in runtest file.
(and quoted part of your mail in the commit message)

Thanks.

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
