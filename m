From: Theodore Ts'o <tytso@mit.edu>
Date: Mon, 16 Jan 2017 23:41:05 -0500
Subject: [LTP] utimensat EACCES vs. EPERM in 4.8+
In-Reply-To: <18a5b416-ad6a-e679-d993-af7ffa0dcc10@redhat.com>
References: <18a5b416-ad6a-e679-d993-af7ffa0dcc10@redhat.com>
Message-ID: <20170117044104.ktrtizpzhghqludn@thunk.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Jan 16, 2017 at 04:46:45PM +0100, Jan Stancek wrote:
> 4.9 kernel and simple touch on immutable file gives me:
> utimensat(AT_FDCWD, "afile", NULL, 0)   = -1 EPERM (Operation not permitted)
> 
> while an older kernel it gives me:
> utimensat(AT_FDCWD, "afile", NULL, 0)   = -1 EACCES (Permission denied)
> 
> Do we need to update man page or fix kernel back to return EACCES?

Quoting from: http://blog.unclesniper.org/archives/2-Linux-programmers,-learn-the-difference-between-EACCES-and-EPERM-already!.html

   It appears that many programmers are unaware that there is a
   fundamental difference between the error codes EACCES (aka
   "Permission denied") and EPERM (aka "Operation not permitted"). In
   particular, a lot of code returns EPERM when they really mean
   EACCES:

   mist% killall sshd
   sshd(2244): Operation not permitted

   To clear this up: "Permission denied" means just that -- the
   process has insufficient privileges to perform the requested
   operation. Simply put, this means that "trying the same thing as
   root will work". For instance, messing around with files you do not
   have the appropriate permissions to (i.e. in the access(2) sense)
   will get you EACCES:

   mist% ls /root
   ls: cannot open directory /root: Permission denied

   On the other hand, "Operation not permitted" means the operation is
   systematically not permissible; in other words it would be unwise
   for the system to perform the requested operation -- regardless of
   access privileges (think "I can't let you do that,
   Dave."). Usually, this means that either the operation is not
   supported (e.g. chmodding a file residing on a FAT filesystem --
   FAT simply does not support permission bits, there is nothing
   anyone can do about that) or it would endanger the integrity of the
   system (e.g. creating additional hardlinks on a directory -- this
   would mess up the reference counting mechanism and result in "lost"
   disk space). Simply put, this means that "it cannot be done, not
   even as root".

   So next time you write code signalling errors with the E*
   constants, think hard before choosing: Do user privileges play a
   role in whether or not the error will occur? If yes, use EACCES. If
   no, use EPERM.

						- Ted
