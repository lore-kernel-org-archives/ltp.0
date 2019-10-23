From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 23 Oct 2019 16:35:11 +0200
Subject: [LTP] [PATCH] timer_create01: accept kernel ENOTSUPP
In-Reply-To: <6089b924-8dbe-c43d-72d9-a4086a13b0d5@suse.cz>
References: <cb6173ec393a23949ec40c9747fc7f75fed2591f.1571838908.git.jstancek@redhat.com>
 <1714198769.8739783.1571839133168.JavaMail.zimbra@redhat.com>
 <20191023140408.GC4055@calabresa>
 <6089b924-8dbe-c43d-72d9-a4086a13b0d5@suse.cz>
Message-ID: <20191023143510.GA10116@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > You are right. We want this to succeed with EOPNOTSUPP, as it's a valid error
> > from kernel space.
> 
> Actually, man says that EOPNOTSUPP is only valid for socket operations.
> So no, we should not go out of our way to explicitly check timer errors
> against EOPNOTSUPP either. (It's also a waste of time because on Linux,
> ENOTSUP == EOPNOTSUPP).

Beware that kernel defines ENOTSUP that is not equal to EOPNOTSUPP and
in this case this value leaked to userspace leading to invalid userspace
errno value.

-- 
Cyril Hrubis
chrubis@suse.cz
