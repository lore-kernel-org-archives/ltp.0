Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WGUqd-0000Si-S3
	for ltp-list@lists.sourceforge.net; Thu, 20 Feb 2014 14:43:35 +0000
Date: Thu, 20 Feb 2014 15:43:23 +0100
From: chrubis@suse.cz
Message-ID: <20140220144323.GA9177@rei>
References: <1d493ab679dd89f48f100209f59cd268bfcceb0d.1389605779.git.jstancek@redhat.com>
	<956250964.4933831.1392716586384.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <956250964.4933831.1392716586384.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH/RFC] sigaltstack02: avoid using MINSIGSTKSZ
 defined by glibc
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
> > The value of MINSIGSTKSZ defined by glibc can be different
> > as the value defined by kernel. Recent change for ppc
> > is now causing sigaltstack02 to fail:
> > https://sourceware.org/ml/libc-alpha/2013-08/msg00093.html
> > 
> > Use value which is low enough for all kernel versions.
> > 
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > ---
> 
> Any thoughts/ideas?

So they fixed the size in glibc which broke the test because the
MINSIGSTKSZ - 1 is not small enough now. I wonder if we can pass
even smaller value (zero) there and get the same result...

Anyway the change looks good to me,

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
