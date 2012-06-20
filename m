Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1ShHfB-0000Ok-Rz
	for ltp-list@lists.sourceforge.net; Wed, 20 Jun 2012 09:57:25 +0000
Date: Wed, 20 Jun 2012 11:13:54 +0200
From: chrubis@suse.cz
Message-ID: <20120620091354.GE16073@saboteur.suse.cz>
References: <4FD9D1DC.9010004@linux.vnet.ibm.com>
	<1340117836.2512.24.camel@freedom>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1340117836.2512.24.camel@freedom>
Subject: Re: [LTP] [ANNOUNCE] The Linux Test Project has been released for
 JUNE 2012.
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
To: Lucas Meneghel Rodrigues <lmr@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > The Linux Test Project test suite has been released for the month of
> > JUNE 2012.
> > 
> > The latest version of the test-suite contains 3000+ tests for the Linux
> > OS and can be found at:
> > http://ltp.sourceforge.net/,
> > Latest happenings in LTP can also be found at:
> > http://ltp.sourceforge.net/wiki/,
> > http://ltp.sourceforge.net/wikiArchives.php, and,
> > IRC: irc.freenode.org #ltp.
> > 
> > Our web site also contains other information such as:
> > - A Linux test tools matrix
> > - Technical papers
> > - How To's on Linux testing
> > - Code coverage analysis tool.
> 
> The wiki front page references some pretty old events. Some options that
> comes into my mind:
 
Yes, I know that, and this is something that's on my long TODO. The
priority is quite low though.

> 1) Remove the sourceforge site, port the relevant documentation to a
> github wiki [1], and move the site to be hosted under the github
> infrastructure, ltp.github.com
> 2) Just heavily clean up and organize the existing sourceforge wiki.

Well I think that github wiki is improvement so I would personaly would
vote for number 1.

Also note that we do have some relevant docs under doc/ directory in our
git tree currently in asciidoc format. So maybe having sf.net pages with
content generated form asciidoc by typing make in doc directory would be
sufficient. That way we would have git backend wiki, the only
unconvinient part is that somebody needs to upload the pages (but that
could be backed up by the git syncing script that's allready runing as
well).

> Obviously this is just a suggestion, please don't be mad at me :) I find
> useful to keep disciplined and try to keep the online documentation tidy
> and up to date (although this is a difficult goal indeed).

I'm not mad at all, quite contrary. I know that having good
documentation is important, unfortunately it looks like nobody has time
to write it. Are you volunteering? I would be happy to give you commit
access ;).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
