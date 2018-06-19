From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 19 Jun 2018 06:56:08 -0400 (EDT)
Subject: [LTP] [PATCH] fcntl36: fix 32-bit sporadic failures
In-Reply-To: <CA+G9fYt1VpwXKj+Zahf39uHopUXxqYdW3BogB0HOATyuf4Bdww@mail.gmail.com>
References: <8b5ddc69aae83b332b205dbeddb3284ab00f827e.1529082112.git.jstancek@redhat.com>
 <CA+G9fYt1VpwXKj+Zahf39uHopUXxqYdW3BogB0HOATyuf4Bdww@mail.gmail.com>
Message-ID: <667704271.27470650.1529405768650.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> On 15 June 2018 at 22:52, Jan Stancek <jstancek@redhat.com> wrote:
> > fcntl36 testcase has been observed to sporadically fail, when
> > running 32-bit user-space on 64-bit kernel.
> >
> > Strace shows that region length is 0 for some commands:
> >   fcntl64(6, F_SETLK, {l_type=F_UNLCK, l_whence=SEEK_SET, l_start=5120,
> >   l_len=0}
> >
> > This is because testcase is passing struct flock64, but
> > command is F_SETLK, not F_SETLK64.
> >
> > So, kernel treats argument for POSIX command as 32-bit "struct flock":
> >
> >   static long do_compat_fcntl64(unsigned int fd, unsigned int cmd,
> >   ...
> >         case F_SETLK:
> >         case F_SETLKW:
> >                 err = get_compat_flock(&flock, compat_ptr(arg));
> >                 ...
> >
> > in contrast to F_OFD_* commands, where argument  is treated
> > as "struct flock64":
> >         case F_SETLK64:
> >         case F_SETLKW64:
> >         case F_OFD_SETLK:
> >         case F_OFD_SETLKW:
> >                 err = get_compat_flock64(&flock, compat_ptr(arg));
> >                 ...
> >
> > Switch argument of POSIX commands to 'struct flock' and leave it to
> > glibc to pick correct syscall and command.
> >
> > I tested fcntl36 and fcntl36_64 on x86_64 kernel (as 64bit + 32bit binary)
> > and i386 kernel by running 100 iterations.
> >
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> 
> Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> 

Thanks Li & Naresh. Pushed.

Regards,
Jan
