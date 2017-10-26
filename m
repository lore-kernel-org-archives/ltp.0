From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 26 Oct 2017 03:42:43 -0400 (EDT)
Subject: [LTP] [PATCH] clone08: don't treat EWOULDBLOCK as failure
In-Reply-To: <493d96a0-638d-b1b3-35a2-5f6bd1258b87@oracle.com>
References: <3d13f6b0963589472e7fb85b3a4a9ff75c48a004.1508488263.git.jstancek@redhat.com>
 <493d96a0-638d-b1b3-35a2-5f6bd1258b87@oracle.com>
Message-ID: <1082629693.32286711.1509003763055.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> On 10/20/2017 11:32 AM, Jan Stancek wrote:
> > futex() and clone() are racing in test_clone_thread().
> > If clone() changes ctid first, then futex() reports
> > EWOULDBLOCK and test treats that as failure.
> >
> > We don't need to eliminate the race, since all we
> > care about is that ctid is changed/cleared by clone().
> >
> > Also fix a small warning from unused variable.
> >
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > ---
> >  testcases/kernel/syscalls/clone/clone08.c | 25 +++++++++++++++++--------
> >  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> Looks good to me, thanks!
> 

Pushed.

Regards,
Jan
