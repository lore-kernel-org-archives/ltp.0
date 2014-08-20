Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XK8ES-0006SJ-U0
	for ltp-list@lists.sourceforge.net; Wed, 20 Aug 2014 15:55:29 +0000
Date: Wed, 20 Aug 2014 17:54:28 +0200
From: chrubis@suse.cz
Message-ID: <20140820155428.GA9005@rei>
References: <933677084.9868450.1408538960160.JavaMail.zimbra@redhat.com>
	<1070499573.9869577.1408539206966.JavaMail.zimbra@redhat.com>
	<20140820141952.GA23454@rei>
	<1919467615.10002040.1408549666554.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1919467615.10002040.1408549666554.JavaMail.zimbra@redhat.com>
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
> > That is simple enough but I'm a bit reluctant to add the fix to each
> > test that will test O_LARGEFILE.
> > 
> > Given that the only purpose of lstat() in rmobj() is to figure out if
> > given path is a file or directory, we can try to work around this by
> > trying to opendir() the path first and treat it like a file when we get
> > ENOTDIR. What do you think?
> 
> I like the idea. I can try it tomorrow, unless you have patch ready.

Not yet, I've been working on enabling keyctl01 testcase that was
previously wrongly disabled by configure checks.

(It looks like the TCONF propagation is starting to pay off because
 it's far easier to spot and review skipped testcases.)

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
