Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1ShL9I-0000Wh-2V
	for ltp-list@lists.sourceforge.net; Wed, 20 Jun 2012 13:40:44 +0000
Date: Wed, 20 Jun 2012 14:57:16 +0200
From: chrubis@suse.cz
Message-ID: <20120620125716.GH24041@saboteur.suse.cz>
References: <4FD9D1DC.9010004@linux.vnet.ibm.com>
	<1340117836.2512.24.camel@freedom>
	<20120620091354.GE16073@saboteur.suse.cz>
	<1340199221.2424.4.camel@freedom>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1340199221.2424.4.camel@freedom>
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
> > > The wiki front page references some pretty old events. Some options that
> > > comes into my mind:
> >  
> > Yes, I know that, and this is something that's on my long TODO. The
> > priority is quite low though.
> > 
> > > 1) Remove the sourceforge site, port the relevant documentation to a
> > > github wiki [1], and move the site to be hosted under the github
> > > infrastructure, ltp.github.com
> > > 2) Just heavily clean up and organize the existing sourceforge wiki.
> > 
> > Well I think that github wiki is improvement so I would personaly would
> > vote for number 1.
> > 
> > Also note that we do have some relevant docs under doc/ directory in our
> > git tree currently in asciidoc format. So maybe having sf.net pages with
> > content generated form asciidoc by typing make in doc directory would be
> > sufficient. That way we would have git backend wiki, the only
> > unconvinient part is that somebody needs to upload the pages (but that
> > could be backed up by the git syncing script that's allready runing as
> > well).
> 
> I have quite some experience of migrating/cleaning project documentation
> to github, so yeah, I believe I can help with it. A good thing about
> github wikis is that they are git repos, and the wiki engine is open
> source, you can run it on your own machine.

Great!

> > > Obviously this is just a suggestion, please don't be mad at me :) I find
> > > useful to keep disciplined and try to keep the online documentation tidy
> > > and up to date (although this is a difficult goal indeed).
> > 
> > I'm not mad at all, quite contrary. I know that having good
> > documentation is important, unfortunately it looks like nobody has time
> > to write it. Are you volunteering? I would be happy to give you commit
> > access ;).
> 
> I will help with it. I'll start to sketch a new LTP page using twitter
> bootstrap and will look at the process that could be used to do semi
> automated translation of the current documentation to restructured text.

The automatic translation is probably not worth the effort, there is
IMHO not enough of relevant docs for this to pay off.

Let me know if you need help with anything.

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
