From: Eryu Guan <eguan@redhat.com>
Date: Wed, 1 Jun 2016 19:09:17 +0800
Subject: [LTP] [PATCH 1/3] ltp-aiodio: report posix_memalign errors
 properly
In-Reply-To: <20160601092757.GA19762@rei.lan>
References: <1464351304-31405-1-git-send-email-eguan@redhat.com>
 <20160601092757.GA19762@rei.lan>
Message-ID: <20160601110917.GR5140@eguan.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jun 01, 2016 at 11:27:57AM +0200, Cyril Hrubis wrote:
> Hi!
> > From posix_memalign(3) the value of errno is indeterminate after a call
> > to posix_memalign(). So TERRNO doesn't work in this case.
> > dio_sparse    1  TBROK  :  dio_sparse.c:75: posix_memalign(): errno=SUCCESS(0): Success
> > 
> > Report posix_memalign() errors by calling strerror on the return value.
> > dio_sparse    1  TBROK  :  dio_sparse.c:74: posix_memalign(): EINVAL
> 
> That is good catch but the *_sparse.c and dio_truncate.c does not use
> the test library and hence the compilation fails on undeclared and
> implicit declarations.

Sorry about that! I tested the dio_sparse.c and it worked, but not
others. Lesson learned, thanks for the review!

Eryu
