From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 23 Oct 2019 16:03:14 +0200
Subject: [LTP] [PATCH] timer_create01: accept kernel ENOTSUPP
In-Reply-To: <1714198769.8739783.1571839133168.JavaMail.zimbra@redhat.com>
References: <cb6173ec393a23949ec40c9747fc7f75fed2591f.1571838908.git.jstancek@redhat.com>
 <1714198769.8739783.1571839133168.JavaMail.zimbra@redhat.com>
Message-ID: <20191023140314.GA4362@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > ENOTSUP in userspace is alias for EOPNOTSUPP, so the test still fails.
> > Add definition of kernel's ENOTSUPP and use that.
> > 
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> 
> I think I misread the original commit. Seems we want this to fail for ENOTSUPP.

Indeed.

-- 
Cyril Hrubis
chrubis@suse.cz
