From: Petr Vorel <petr.vorel@gmail.com>
Date: Wed, 11 Dec 2019 21:16:00 +0100
Subject: [LTP] [PATCH 0/3] musl: travis build and include fixes
In-Reply-To: <1509318407.16168104.1576069693282.JavaMail.zimbra@redhat.com>
References: <20191210201321.1430984-1-petr.vorel@gmail.com>
 <1509318407.16168104.1576069693282.JavaMail.zimbra@redhat.com>
Message-ID: <20191211201600.GA87570@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

> > although LTP not yet fully support musl, I'd like
> > to add travis build via Alpine linux distro.
> > Remaining broken tests are deleted before building,
> > I volunteer to solve musl problems for new code.

> Fine by me, we can always disable it later if we run into (too many) issues.

> > I also added 2 simple RPC fixes.

> LGTM. As for RHEL, socketvar.h appears to be unused for decade at least.

Thanks a lot for a review, merged.

Kind regards,
Petr
