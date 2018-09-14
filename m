From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 14 Sep 2018 08:21:57 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/mmap15: relax condition a bit
In-Reply-To: <20180913122847.GB18036@rei.lan>
References: <1fbbf1d06b0e08fc2b078c0ad24f2dd2111348c3.1536827409.git.jstancek@redhat.com>
 <20180913122847.GB18036@rei.lan>
Message-ID: <498616961.48354227.1536927717430.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > High address is arch specific, and it also occasionally changes
> > as can be seen in history of this test.
> > 
> > Relax the condition and accept both ENOMEM and EINVAL
> > as expected outcome.
> > 
> > Fixes: #390
> 
> I've already acked that on GitHub...
> 
> But just for a clarity, acked.

Pushed.

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
