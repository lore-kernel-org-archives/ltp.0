From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 11 May 2017 08:50:49 -0400 (EDT)
Subject: [LTP] [RFC] [PATCH] move_pages12: Allocate and free hugepages
 prior	the test
In-Reply-To: <20170511122636.GA27575@rei.lan>
References: <20170509140458.26343-1-chrubis@suse.cz>
 <510505896.9544779.1494406598104.JavaMail.zimbra@redhat.com>
 <20170510130125.GE29838@rei.suse.de>
 <1251960161.9665123.1494425698679.JavaMail.zimbra@redhat.com>
 <20170510150807.GF29838@rei.suse.de>
 <57874670.10114549.1494484804573.JavaMail.zimbra@redhat.com>
 <20170511122636.GA27575@rei.lan>
Message-ID: <1977457874.10364325.1494507049706.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > > Well that is a few forks away after the failure, if the race window is
> > > small enough we will never see the real value but maybe doing open() and
> > > read() directly would show us different values.
> > 
> > For free/reserved, sure. But is the number of reserved huge pages on
> > each node going to change over time?
> 
> Of course I was speaking about the number of currently free huge pages.
> The pool limit will not change unless something from userspace writes to
> the sysfs file...
> 
> > ---
> > 
> > I was running with 20+20 huge pages over night and it hasn't failed
> > single time. So I'm thinking we allocate 3+3 or 4+4 to avoid any
> > issues related to lazy/deffered updates.
> 
> But we have to lift the per node limits as well, right?

Sorry, what I meant by 'allocate' was configuring per node limits.
I was using your patch as-is, with 2 huge pages allocated/touched
on each node. 

> 
> So what about lifting the per node limit to something as 20 and then try
> to allocate 4 hugepages on each node prior the test?

per node limit 8 and allocate 4 hugepages on each? What worries
me are architectures, where default huge page is very large
(e.g. 512M on aarch64).

Regards,
Jan
