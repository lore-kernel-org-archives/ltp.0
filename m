Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WfUL4-0003sW-44
	for ltp-list@lists.sourceforge.net; Wed, 30 Apr 2014 13:14:18 +0000
Date: Wed, 30 Apr 2014 15:13:20 +0200
From: chrubis@suse.cz
Message-ID: <20140430131320.GB22265@rei>
References: <20140430121433.GA21327@rei>
	<1372990689.12607095.1398862329568.JavaMail.zimbra@redhat.com>
	<20140430130105.GA22265@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140430130105.GA22265@rei>
Subject: Re: [LTP] Unifying syscalls tests for EFAULT
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
> > I do recall a testcase, which had special setup for ia64, because
> > it didn't work as expected for NULL. When looking at process map,
> > there was a single page mapped 0, which didn't come from test:
> > 
> > # cat /proc/self/maps
> > 00000000-00004000 r--p 00000000 00:00 0
> > 
> > See this email thread:
> >   https://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg17855.html
> 
> Hmm, so I guess that only portable way to cause EFAULT would be mapping
> PROT_NONE page.

And we can parse /proc/self/maps and figure out if NULL is mapped and
try more than one address, however I haven't had figured out a
reasonably simple way how to change the current testcases to cope with
something between 1 and 3 tests for EFAULT yet.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.  Get 
unparalleled scalability from the best Selenium testing platform available.
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
