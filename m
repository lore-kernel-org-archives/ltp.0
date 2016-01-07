From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 7 Jan 2016 09:24:01 -0500 (EST)
Subject: [LTP] [PATCH V2] Use a union of sigval instead of sigval_t
In-Reply-To: <20160107140850.GB13423@rei.lan>
References: <1452169516-104606-1-git-send-email-raj.khem@gmail.com>
 <1370167031.5338451.1452174207521.JavaMail.zimbra@redhat.com>
 <20160107140850.GB13423@rei.lan>
Message-ID: <415704325.5352146.1452176641402.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: "Khem Raj" <raj.khem@gmail.com>, ltp@lists.linux.it
> Sent: Thursday, 7 January, 2016 3:08:51 PM
> Subject: Re: [LTP] [PATCH V2] Use a union of sigval instead of sigval_t
> 
> Hi!
> > > sigval_t is glibc only construct, we use a union of sigval
> > > which pretty much is same effect as sigval_t
> > > 
> > > Signed-off-by: Khem Raj <raj.khem@gmail.com>
> > 
> > Reviewed-by: Jan Stancek <jstancek@redhat.com>
> > 
> > Looks good to me, I think this should be safe to apply before release.
> > (I tested it across RHEL5.6/6.0/7.0)
> > 
> > Cyril, do you agree?
> 
> Looking into POSIX it explicitly says that the callback takes union
> sigval paramter and not sigval_t.
> (http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/signal.h.html)
> 
> So this change should not break anything. Acked to go in before release
> by me as well.

Pushed with 2nd fwd declaration removed too and added POSIX reference
to commit message.

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
