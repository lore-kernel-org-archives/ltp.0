From: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
Date: Wed, 18 Jan 2017 21:17:00 +1300
Subject: [LTP] utimensat EACCES vs. EPERM in 4.8+
In-Reply-To: <20170117210403.spl6fpzegfmir6cy@thunk.org>
References: <18a5b416-ad6a-e679-d993-af7ffa0dcc10@redhat.com>
 <20170117044104.ktrtizpzhghqludn@thunk.org>
 <20170117193557.GA17332@fieldses.org>
 <20170117210403.spl6fpzegfmir6cy@thunk.org>
Message-ID: <19d8cbe2-4209-0e25-42ea-380a55104f0e@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 01/18/2017 10:04 AM, Theodore Ts'o wrote:
> On Tue, Jan 17, 2017 at 02:35:57PM -0500, J. Bruce Fields wrote:
>> Where did this blog entry come from?  I've never seen the ACCES/PERM
>> distinction made that way anywhere else.  Posix says:
>>
>> 	[EACCES]
>> 	    Permission denied. An attempt was made to access a file in a
>> 	    way forbidden by its file access permissions.
>> 	[EPERM]
>> 	    Operation not permitted. An attempt was made to perform an
>> 	    operation limited to processes with appropriate privileges
>> 	    or to the owner of a file or other resource.
>> So EPERM is exactly for attempts to do things that are reserved for root
>> (or process with appropriate capabilities or whatever).

> (or process with appropriate capabilities or whatever).

Yes. POSIX makes it pretty clear here, I think. EACCES is (generally) 
about pathname permissions. (One can see this by perusing the various 
EACCES cases in POSIX.) EPERM is (generally) about other kinds of
permission denials (including Ted's "I'm sorry Dave, I can't let you
do that" cases, which are a subset of these cases). And in both cases,
superuser privilege may potentially bypass the restriction (except
for the EPERM "Dave" cases).

So, that suggests that EPERM would be the right error for denial of
permission because of the inode immutable or append-only flag. 
(Earlier, I thought EACCES would be right, but I changed my mind.) Or,
roughly, the patch under discussion made things more "correct", but
at a (small) risk of user-space breakage.

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
