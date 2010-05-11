Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OBsRG-0000Oy-J4
	for ltp-list@lists.sourceforge.net; Tue, 11 May 2010 16:36:10 +0000
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OBsRE-0002ys-46
	for ltp-list@lists.sourceforge.net; Tue, 11 May 2010 16:36:10 +0000
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e6.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o4BGY1it029559
	for <ltp-list@lists.sourceforge.net>; Tue, 11 May 2010 12:34:01 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4BGa1B8113496
	for <ltp-list@lists.sourceforge.net>; Tue, 11 May 2010 12:36:01 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4BGZxmx014134
	for <ltp-list@lists.sourceforge.net>; Tue, 11 May 2010 13:36:00 -0300
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20100511162452.GD2832@quack.suse.cz>
References: <bug-15909-10286@https.bugzilla.kernel.org/>
	<20100506143002.0381501b.akpm@linux-foundation.org>
	<20100511154850.GC2832@quack.suse.cz>
	<20100511162452.GD2832@quack.suse.cz>
Date: Tue, 11 May 2010 22:05:52 +0530
Message-Id: <1273595753.4875.1.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [Bugme-new] [Bug 15909] New: open("a/",
	O_NOFOLLOW)	fails with ELOOP if "a" is a symbolic link to a
	directory.
Reply-To: subrata@linux.vnet.ibm.com
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Kara <jack@suse.cz>
Cc: tolzmann@molgen.mpg.de, ltp-list@lists.sourceforge.net, bugzilla-daemon@bugzilla.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, bugme-daemon@bugzilla.kernel.org, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>

Hi Jan,

On Tue, 2010-05-11 at 18:24 +0200, Jan Kara wrote:
> On Tue 11-05-10 17:48:51, Jan Kara wrote:
> > On Thu 06-05-10 14:30:02, Andrew Morton wrote:
> > > 
> > > (switched to email.  Please respond via emailed reply-to-all, not
> via the
> > > bugzilla web interface).
> > > 
> > > On Wed, 5 May 2010 13:01:22 GMT
> > > bugzilla-daemon@bugzilla.kernel.org wrote:
> > > 
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=15909
> > > > 
> > > >            Summary: open("a/",O_NOFOLLOW) fails with ELOOP if
> "a" is a
> > > >                     symbolic link to a directory.
> > > >            Product: File System
> > > >            Version: 2.5
> > > >     Kernel Version: 2.6.34-rc6
> > > >           Platform: All
> > > >         OS/Version: Linux
> > > >               Tree: Mainline
> > > >             Status: NEW
> > > >           Severity: high
> > > >           Priority: P1
> > > >          Component: Other
> > > >         AssignedTo: fs_other@kernel-bugs.osdl.org
> > > >         ReportedBy: tolzmann@molgen.mpg.de
> > > >         Regression: No
> > > > 
> > > > 
> > > > mkdir c
> > > > ln -s c a
> > > > 
> > > > f=open("a/",O_RDONLY+O_NOFOLLOW)
> > > > 
> > > > fails with ELOOP. However, this open should behave like
> open("a/.") not like
> > > > open("a") according to path_resolution(7). In kernel version
> 2.6.32 the open
> > > > worked as documented. 
> > > > 
> > > > On a higher level this bug makes
> > > > 
> > > > find a/
> > > > 
> > > > to fail.
> > > > 
> > > 
> > > It sounds like this 2.6.32->2.6.34-rc6 regression could have
> pretty
> > > serious ramifications for some users.  Does anyone know whcih
> commit
> > > might have caused it?
> >   The patch below fixes the issue for me but someone should have a
> look
> > at it because I'm not really an expert in that code and the code
> paths are so
> > twisted that my mind is currently tied into a knot ;).
> > 
> >                                                                       Honza
> > ---
> > 
> > From d53d3cc6488d9135bb69c3ff7e034b3b624866ed Mon Sep 17 00:00:00
> 2001
> > From: Jan Kara <jack@suse.cz>
> > Date: Tue, 11 May 2010 16:34:25 +0200
> > Subject: [PATCH] vfs: Fix O_NOFOLLOW behavior for paths with
> trailing slashes
> > 
> > According to specification
> > mkdir d; ln -s d a; open("a/", O_NOFOLLOW | O_RDONLY)
> > should return success but currently it did return ELOOP. Fix the
> code to ignore
> > O_NOFOLLOW in case the provided path has trailing slashes. This is a
> regression
> > caused by path lookup cleanup patch series.
> > 
> > CC: stable@kernel.org
> > Signed-off-by: Jan Kara <jack@suse.cz>
> ...
>   BTW: It might be worthwhile to add the attached testcase to LTP?

It would be great if you can shoot it in the form of a patch, mentioning

     1. The GPL Lincense,
     2. The purpose of the test case,
     3. Exact location it goes,
     4. Which LTPROOT/runtest/<file> executes it

Regards--
Subrata

:-)

> 
>                                                                         Honza
> -- 
> Jan Kara <jack@suse.cz>
> SUSE Labs, CR
> 
> 
> 
> 
> 
> 
> 
> C++ source code
> attachment
> (open-follow-test.c)
> 
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <unistd.h>
> #include <fcntl.h>
> #include <errno.h>
> #include <string.h>
> #include <sys/stat.h>
> #include <sys/types.h>
> 
> int do_test(char *p)
> {
>   int err;
>   char path[16];
> 
>   strcpy(path, p);
>   err = open(path, O_NOFOLLOW | O_RDONLY);
>   if (err >= 0) {
>     fprintf(stderr, "open(\"%s\", O_NOFOLLOW | O_RDONLY) did not fail!
> \n", path);
>     return 1;
>   }
>   strcat(path, "/");
>   err = open(path, O_NOFOLLOW | O_RDONLY);
>   if (err < 0) {
>     fprintf(stderr, "open(\"%s\", O_NOFOLLOW | O_RDONLY) failed with %
> d\n", path, errno);
>     return 1;
>   }
>   strcat(path, ".");
>   err = open(path, O_NOFOLLOW | O_RDONLY);
>   if (err < 0) {
>     fprintf(stderr, "open(\"%s\", O_NOFOLLOW | O_RDONLY) failed with %
> d\n", path, errno);
>     return 1;
>   }
>   return 0;
> }
> 
> int main(void)
> {
>   if (mkdir("d", 0700) < 0) {
>     perror("mkdir");
>     return 1;
>   }
>   if (symlink("d", "a") < 0) {
>     perror("link");
>     return 1;
>   }
>   if (do_test("a"))
>     return 1;
>   return 0;
> }


------------------------------------------------------------------------------

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
