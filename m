From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 29 Jun 2016 07:03:50 -0400 (EDT)
Subject: [LTP] [PATCH] fanotify06: create a mount for test
In-Reply-To: <20160629101417.GA6068@gmail.com>
References: <7ef37bcfb79c3fa81182e6530e5a0f3a35aacdad.1467190006.git.jstancek@redhat.com>
 <20160629101417.GA6068@gmail.com>
Message-ID: <848107631.672155.1467198230172.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Li Wang" <liwang@redhat.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it, jack@suse.cz
> Sent: Wednesday, 29 June, 2016 12:14:17 PM
> Subject: Re: [LTP] [PATCH] fanotify06: create a mount for test
> 
> On Wed, Jun 29, 2016 at 10:49:11AM +0200, Jan Stancek wrote:
> > This testcase can rarely fail, when there is a background process
> > modifying files on same mountpoint as is LTP's tmpdir:
> > 
> > fanotify06    1  TFAIL  :  fanotify06.c:212: group 0 got more than one
> > event (48 > 24)
> > fanotify06    2  TFAIL  :  fanotify06.c:212: group 1 got more than one
> > event (48 > 24)
> > fanotify06    3  TFAIL  :  fanotify06.c:212: group 2 got more than one
> > event (48 > 24)
> > fanotify06    4  TFAIL  :  fanotify06.c:222: group 3 got event
> > fanotify06    5  TFAIL  :  fanotify06.c:222: group 4 got event
> > fanotify06    6  TPASS  :  group 5 got no event
> > fanotify06    7  TPASS  :  group 6 got no event
> > fanotify06    8  TPASS  :  group 7 got no event
> > fanotify06    9  TPASS  :  group 8 got no event
> > 
> > This patch creates a mount, which should be only used by this
> > test to limit interference from rest of OS. It also adds missing
> > tst_require_root().
> > 
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > ---
> >  testcases/kernel/syscalls/fanotify/fanotify06.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/testcases/kernel/syscalls/fanotify/fanotify06.c
> > b/testcases/kernel/syscalls/fanotify/fanotify06.c
> > index 93c960268b57..cdbc7a16c0d7 100644
> > --- a/testcases/kernel/syscalls/fanotify/fanotify06.c
> > +++ b/testcases/kernel/syscalls/fanotify/fanotify06.c
> > @@ -42,6 +42,7 @@
> >  #include <sys/fcntl.h>
> >  #include <errno.h>
> >  #include <string.h>
> > +#include <sys/mount.h>
> >  #include <sys/syscall.h>
> >  #include "test.h"
> >  #include "linux_syscall_numbers.h"
> > @@ -80,6 +81,9 @@ static int
> > fd_notify[FANOTIFY_PRIORITIES][GROUPS_PER_PRIO];
> >  
> >  static char event_buf[EVENT_BUF_LEN];
> >  
> > +#define MOUNT_NAME "mntpoint"
> > +static int mount_created;
> > +
> >  static void create_fanotify_groups(void)
> >  {
> >  	unsigned int p, i;
> > @@ -245,8 +249,15 @@ static void setup(void)
> >  
> >  	TEST_PAUSE;
> >  
> > +	tst_require_root();
> >  	tst_tmpdir();
> >  
> > +	SAFE_MKDIR(cleanup, MOUNT_NAME, 0755);
> > +	if (mount(MOUNT_NAME, MOUNT_NAME, NULL, MS_BIND, NULL) < 0)
> 
> why not SAFE_MOUNT() here?
> 	SAFE_MOUNT(cleanup, MOUNT_NAME, MOUNT_NAME, NULL, MS_BIND, NULL);

Good point, I replaced it for SAFE_MOUNT locally
(holding off from sending v2 for now).

Thanks,
Jan
