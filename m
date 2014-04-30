Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WfU9A-0003bg-VD
	for ltp-list@lists.sourceforge.net; Wed, 30 Apr 2014 13:02:00 +0000
Date: Wed, 30 Apr 2014 15:01:05 +0200
From: chrubis@suse.cz
Message-ID: <20140430130105.GA22265@rei>
References: <20140430121433.GA21327@rei>
	<1372990689.12607095.1398862329568.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1372990689.12607095.1398862329568.JavaMail.zimbra@redhat.com>
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
> > * Is there a machine that has userspace address mapped on NULL ?
> 
> I do recall a testcase, which had special setup for ia64, because
> it didn't work as expected for NULL. When looking at process map,
> there was a single page mapped 0, which didn't come from test:
> 
> # cat /proc/self/maps
> 00000000-00004000 r--p 00000000 00:00 0
> 
> See this email thread:
>   https://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg17855.html

Hmm, so I guess that only portable way to cause EFAULT would be mapping
PROT_NONE page.

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
