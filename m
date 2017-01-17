From: J. Bruce Fields <bfields@fieldses.org>
Date: Tue, 17 Jan 2017 14:35:57 -0500
Subject: [LTP] utimensat EACCES vs. EPERM in 4.8+
In-Reply-To: <20170117044104.ktrtizpzhghqludn@thunk.org>
References: <18a5b416-ad6a-e679-d993-af7ffa0dcc10@redhat.com>
 <20170117044104.ktrtizpzhghqludn@thunk.org>
Message-ID: <20170117193557.GA17332@fieldses.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Jan 16, 2017 at 11:41:05PM -0500, Theodore Ts'o wrote:
> On Mon, Jan 16, 2017 at 04:46:45PM +0100, Jan Stancek wrote:
> > 4.9 kernel and simple touch on immutable file gives me:
> > utimensat(AT_FDCWD, "afile", NULL, 0)   = -1 EPERM (Operation not permitted)
> > 
> > while an older kernel it gives me:
> > utimensat(AT_FDCWD, "afile", NULL, 0)   = -1 EACCES (Permission denied)
> > 
> > Do we need to update man page or fix kernel back to return EACCES?
> 
> Quoting from: http://blog.unclesniper.org/archives/2-Linux-programmers,-learn-the-difference-between-EACCES-and-EPERM-already!.html
>    It appears that many programmers are unaware that there is a
>    fundamental difference between the error codes EACCES (aka
>    "Permission denied") and EPERM (aka "Operation not permitted"). In
>    particular, a lot of code returns EPERM when they really mean
>    EACCES:
> 
>    mist% killall sshd
>    sshd(2244): Operation not permitted

That's posix, not just linux.

>    To clear this up: "Permission denied" means just that -- the
>    process has insufficient privileges to perform the requested
>    operation. Simply put, this means that "trying the same thing as
>    root will work".

Where did this blog entry come from?  I've never seen the ACCES/PERM
distinction made that way anywhere else.  Posix says:

	[EACCES]
	    Permission denied. An attempt was made to access a file in a
	    way forbidden by its file access permissions.
	[EPERM]
	    Operation not permitted. An attempt was made to perform an
	    operation limited to processes with appropriate privileges
	    or to the owner of a file or other resource.

So EPERM is exactly for attempts to do things that are reserved for root
(or process with appropriate capabilities or whatever).

--b.
