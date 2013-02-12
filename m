Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1U5FbW-0007CT-28
	for ltp-list@lists.sourceforge.net; Tue, 12 Feb 2013 13:08:58 +0000
Date: Tue, 12 Feb 2013 14:09:26 +0100
From: chrubis@suse.cz
Message-ID: <20130212130926.GD9378@rei>
References: <20130212124149.GB9378@rei>
	<1704604395.1338521.1360674295147.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1704604395.1338521.1360674295147.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH v2 3/3] setns: add new syscall test setns02
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
> > > +static void setup(void)
> > > +{
> > > +	char tmp[PATH_MAX];
> > > +
> > > +	tst_require_root(NULL);
> > > +
> > > +	/* runtime check if syscall is supported */
> > > +	syscall(__NR_setns, -1, 0);
> > > +
> > 
> > What happens when the syscall is not supported? The call should
> > return
> > -1 and errno should be set to ENOSYS but the return value is not
> > checked, I'm puzzled.
> 
> It's a bit unfortunate name collision with syscall macro defined
> in linux_syscall_numbers.h. That macro contains check for ENOSYS.

Ah, now I remeber.

We really should change that one. Any volunteers?

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
