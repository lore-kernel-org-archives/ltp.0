From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 18 Oct 2018 06:41:08 -0400 (EDT)
Subject: [LTP] [PATCH v2] syscalls/fcntl: make OFD commands use
 fcntl64() syscall on 32-bit
In-Reply-To: <CAEemH2eTncHL_jUEWUWsvVya6QsowqU5+iAz-dViAV-Wy=UedA@mail.gmail.com>
References: <a278cb39d5c72eeb51184afdbcb085defea50195.1539784033.git.jstancek@redhat.com>
 <CAEemH2eTncHL_jUEWUWsvVya6QsowqU5+iAz-dViAV-Wy=UedA@mail.gmail.com>
Message-ID: <1265846849.59583858.1539859268706.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> On Wed, Oct 17, 2018 at 9:50 PM, Jan Stancek <jstancek@redhat.com> wrote:
> 
> > OFD commands require 64-bit argument (struct flock64). Until
> > glibc commit 06ab719d30b0 ("Fix Linux fcntl OFD locks for
> > non-LFS architectures (BZ#20251)") we relied on glibc passing
> > arg directly to syscall.
> >
> > This creates problem for 32-bit version of the test, because old
> > glibc is passing arg directly, while new one is casting it to
> > struct flock.
> >
> > We could add a configure check for glibc version, but that may
> > not help with other libc libraries.
> >
> > We could do a runtime check that exploits non-zero l_pid returning
> > EINVAL. This however complicates SAFE_FCNTL macro substantially.
> >
> > This patch changes 32-bit version of test to use syscall directly.
> >
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> >
> 
> Reviewed-by: Li Wang <liwang@redhat.com>

Pushed.

Thanks,
Jan
