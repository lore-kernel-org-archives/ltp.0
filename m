Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XKUNG-0003pG-SF
	for ltp-list@lists.sourceforge.net; Thu, 21 Aug 2014 15:34:02 +0000
Date: Thu, 21 Aug 2014 17:33:01 +0200
From: chrubis@suse.cz
Message-ID: <20140821153301.GA14010@rei>
References: <933677084.9868450.1408538960160.JavaMail.zimbra@redhat.com>
	<1070499573.9869577.1408539206966.JavaMail.zimbra@redhat.com>
	<20140820141952.GA23454@rei>
	<1919467615.10002040.1408549666554.JavaMail.zimbra@redhat.com>
	<1317036748.10807258.1408632581704.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1317036748.10807258.1408632581704.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] open12 failing on i386 with EOVERFLOW
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
Cc: ltp-list <ltp-list@lists.sf.net>

Hi!
> > > That is simple enough but I'm a bit reluctant to add the fix to each
> > > test that will test O_LARGEFILE.
> > > 
> > > Given that the only purpose of lstat() in rmobj() is to figure out if
> > > given path is a file or directory, we can try to work around this by
> > > trying to opendir() the path first and treat it like a file when we get
> > > ENOTDIR. What do you think?
> > 
> > I like the idea. I can try it tomorrow, unless you have patch ready.
> 
> I hit some issues with opendir() because it tries to follow symlinks,
> so in case of bad symlink I was getting ENOENT, in some testcases ELOOP.

Doesn't that mean that we are not dealing with a directory and should
proceed with the unlink()? Or am I mistaken?

> I posted version using plain open(O_DIRECTORY | O_NOFOLLOW,..), if you
> want to comment on such approach. Initial results from x86 and ppc64 looked
> good, so I'll run it through some more testing.

This looks good, maybe better than the original idea and given that both
flags were added to kernel 2.1.126 we can just assume that these are
present anywhere.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
