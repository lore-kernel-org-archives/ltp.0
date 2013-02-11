Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1U4veY-00010v-13
	for ltp-list@lists.sourceforge.net; Mon, 11 Feb 2013 15:50:46 +0000
Date: Mon, 11 Feb 2013 16:51:11 +0100
From: chrubis@suse.cz
Message-ID: <20130211155111.GA2753@rei>
References: <20130211143838.GA2829@rei>
	<652016734.705678.1360596388811.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <652016734.705678.1360596388811.JavaMail.root@redhat.com>
Subject: Re: [LTP] open posix testsuite and names of testcases
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
> > Just recently I've found that one of the posix tests stays running
> > after
> > the testsuite has exited (is reparented to init and runs happily ever
> > after). Which is another usecase for this rename.
> > 
> > But the original patch was rather hack (and it doesn't work for me
> > anyway).
> > 
> > So what about renaming the sources itself? Do we agree on this?
> 
> I'm not against renaming sources, just thinking if there is less
> intrusive way to achieve same result. I believe all Makefiles are generated,
> so other option that comes to mind would be to modify scripts/generate-makefiles.sh.
> Any thoughts about this approach?

We can hack the script to generate Makefiles that include the dir name
into the binary name which would be less intrusive but on the other hand
that would break the rule that foo.c generates foo.run_test...

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
