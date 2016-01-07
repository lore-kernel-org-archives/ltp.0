From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 7 Jan 2016 15:08:51 +0100
Subject: [LTP] [PATCH V2] Use a union of sigval instead of sigval_t
In-Reply-To: <1370167031.5338451.1452174207521.JavaMail.zimbra@redhat.com>
References: <1452169516-104606-1-git-send-email-raj.khem@gmail.com>
 <1370167031.5338451.1452174207521.JavaMail.zimbra@redhat.com>
Message-ID: <20160107140850.GB13423@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > sigval_t is glibc only construct, we use a union of sigval
> > which pretty much is same effect as sigval_t
> > 
> > Signed-off-by: Khem Raj <raj.khem@gmail.com>
> 
> Reviewed-by: Jan Stancek <jstancek@redhat.com>
> 
> Looks good to me, I think this should be safe to apply before release.
> (I tested it across RHEL5.6/6.0/7.0)
> 
> Cyril, do you agree?

Looking into POSIX it explicitly says that the callback takes union
sigval paramter and not sigval_t.
(http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/signal.h.html)

So this change should not break anything. Acked to go in before release
by me as well.

-- 
Cyril Hrubis
chrubis@suse.cz
