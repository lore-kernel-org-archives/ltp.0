From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 12 Jan 2018 09:40:22 -0500 (EST)
Subject: [LTP] [PATCH] endian_switch01: rewrite to newlib
In-Reply-To: <20180110142253.GB3746@rei.lan>
References: <0db42a518baa79cd6139f566482e2dab11cfb4bd.1515587913.git.jstancek@redhat.com>
 <20180110142253.GB3746@rei.lan>
Message-ID: <1148670023.6010932.1515768022843.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > Also check that syscall is supported (doesn't return ENOSYS),
> > before running actual test. This is to address kernels where
> > this syscall is disabled by default:
> >   commit 727f13616c45 ("powerpc: Disable the fast-endian switch syscall by
> >   default")
> 
> Looks good to me.

Pushed.

Regards,
Jan
