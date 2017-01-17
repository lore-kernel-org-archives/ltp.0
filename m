From: Theodore Ts'o <tytso@mit.edu>
Date: Tue, 17 Jan 2017 16:04:03 -0500
Subject: [LTP] utimensat EACCES vs. EPERM in 4.8+
In-Reply-To: <20170117193557.GA17332@fieldses.org>
References: <18a5b416-ad6a-e679-d993-af7ffa0dcc10@redhat.com>
 <20170117044104.ktrtizpzhghqludn@thunk.org>
 <20170117193557.GA17332@fieldses.org>
Message-ID: <20170117210403.spl6fpzegfmir6cy@thunk.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Jan 17, 2017 at 02:35:57PM -0500, J. Bruce Fields wrote:
> Where did this blog entry come from?  I've never seen the ACCES/PERM
> distinction made that way anywhere else.  Posix says:
> 
> 	[EACCES]
> 	    Permission denied. An attempt was made to access a file in a
> 	    way forbidden by its file access permissions.
> 	[EPERM]
> 	    Operation not permitted. An attempt was made to perform an
> 	    operation limited to processes with appropriate privileges
> 	    or to the owner of a file or other resource.
> So EPERM is exactly for attempts to do things that are reserved for root
> (or process with appropriate capabilities or whatever).

Yeah, the blog entry is over-generalizing a bit too much.  But if you
take a look at the entry for unlink:

[EACCES]
   Search permission is denied for a component of the path prefix, or
   write permission is denied on the directory containing the
   directory entry to be removed
[EPERM]
   The file named by path is a directory, and either the calling
   process does not have appropriate privileges, or the implementation
   prohibits using unlink() on directories.
[EPERM] or [EACCES]
   The S_ISVTX flag is set on the directory containing the file
   referred to by the path argument and the process does not satisfy
   the criteria specified in XBD Directory Protection.

The second entry, for EPERM, is an example of the "I'm sorry, Dave, I
won't let you do that".  (Early AT&T Unices allowed you to call unlink
on a directory if you were root, even if it resulted in corrupting the
file system.  BSD changed that to be "F*ck that, I don't care if
you're root, I'm not going to let you do that.

In generally there are a lot of cases where people will return EPERM
when technically EACCES is a much better closer match what they should
use.  But the last one shows that there's quite a lot of confusion
even with systems that are allowed to call themselves Unix-complaint
by virtue of their parantage of their code base (as opposed to
compliance to a standards document).

						- Ted
