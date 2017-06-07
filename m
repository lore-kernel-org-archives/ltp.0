From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 7 Jun 2017 06:58:11 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/flock: open test file with O_RDWR mode
In-Reply-To: <20170605142540.GL19952@eguan.usersys.redhat.com>
References: <20170517170956.27118-1-eguan@redhat.com>
 <20170605142540.GL19952@eguan.usersys.redhat.com>
Message-ID: <1358956478.30873513.1496833091191.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> On Thu, May 18, 2017 at 01:09:56AM +0800, Eryu Guan wrote:
> > NFS requires the open mode to match the lock type, i.e. for LOCK_SH
> > file must be opened for read, and for LOCK_EX file must be opened
> > for write. Otherwise flock01 and flock04 fail on NFS with EBADF.
> > 
> > So open all test files in flock tests with O_RDWR mode that both
> > lock type requirements can be met.
> > 
> > Signed-off-by: Eryu Guan <eguan@redhat.com>
> 
> ping on this one.

Pushed.

Thanks,
Jan
