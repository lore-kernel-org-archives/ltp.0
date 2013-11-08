Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <siva.padhy@lge.com>) id 1VejeT-0000vh-M1
	for ltp-list@lists.sourceforge.net; Fri, 08 Nov 2013 10:50:57 +0000
Received: from lgeamrelo02.lge.com ([156.147.1.126])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VejeR-0001Bj-Df
	for ltp-list@lists.sourceforge.net; Fri, 08 Nov 2013 10:50:57 +0000
From: Siva Padhy <siva.padhy@lge.com>
Date: Fri, 8 Nov 2013 19:50:46 +0900
Message-ID: <81212EE27BC298499DBD7CA069AAD071428CDDFBD1@LGEVEXMBAPSVC2.LGE.NET>
References: <81212EE27BC298499DBD7CA069AAD071428CD96A5A@LGEVEXMBAPSVC2.LGE.NET>
	<2139722103.23140441.1383778076485.JavaMail.root@redhat.com>
	<81212EE27BC298499DBD7CA069AAD071428CD96BD7@LGEVEXMBAPSVC2.LGE.NET>
	<1893446010.23601038.1383834759982.JavaMail.root@redhat.com>
In-Reply-To: <1893446010.23601038.1383834759982.JavaMail.root@redhat.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v2] BindMounts: fix to properly unmount during
 cleanup in fs_bind
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
To: Jan Stancek <jstancek@redhat.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

HI Jan,

I debug thoroughly again, I think you are right. Even after applying my patch still share1 left mounted. :(
Below is the log of the mount directories as you asked.

rbind/test02    0  TINFO  :  -----mount directory after umount parent1------------
/tmp/ltp-XXXXNSbrDv/sandbox on /tmp/ltp-XXXXNSbrDv/sandbox type nfs (rw,relatime,..)
/tmp/ltp-XXXXNSbrDv/sandbox/share1 on /tmp/ltp-XXXXNSbrDv/sandbox/share1 type nfs (rw,relatime,...)
rbind/test02    0  TINFO  :  -----------------------------------------------------
rm: can't remove 'share1': Device or resource busy
rbind/test02    1  TPASS  :  rbind/test02: PASSED
rbind/test38    0  TINFO  :  ***************TEST38***************

But I am surprised why It was not showing any diff and TWARN in that case. Do you have any idea?

I will upload a new patch with your modification, please review it.

Thanks,
Siva

-----Original Message-----
From: Jan Stancek [mailto:jstancek@redhat.com] 
Sent: Thursday, November 07, 2013 11:33 PM
To: Siva Padhy/LGSIA CSP-4(siva.padhy@lge.com)
Cc: ltp-list@lists.sourceforge.net
Subject: Re: [LTP] [PATCH v2] BindMounts: fix to properly unmount during cleanup in fs_bind





----- Original Message -----
> From: "Siva Padhy" <siva.padhy@lge.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp-list@lists.sourceforge.net
> Sent: Thursday, 7 November, 2013 3:21:20 AM
> Subject: RE: [LTP] [PATCH v2] BindMounts: fix to properly unmount 
> during cleanup in fs_bind
> 
> HI Jan,
> 
> Thanks for the reply.
> 
> I verified test02 testcase again with my patch, it is working fine for 
> me. I am also using 3.10.11+ kernel.
> I am wondering why share1 is still mounted in your case.

And I'm wondering why it's not in your case :-).

There are 2 mounts:
"${FS_BIND_ROOT}/bin/makedir" share share1 mount --rbind parent1/child1 share1

so I'd expect 2 umounts:

# mkdir test1; mkdir test2
# mount --bind test1 test1
# mount --rbind test2 test1
# umount test1
# mount | grep test1
/dev/mapper/rhel_dhcp--27--145-root on /mnt/testarea/ltp/test1 type xfs (rw,relatime,seclabel,attr2,inode64,noquota)
# umount test1


Can you rerun test02 with this change and send the output of mounted directories?

diff --git a/testcases/kernel/fs/fs_bind/rbind/test02 b/testcases/kernel/fs/fs_bind/rbind/test02
index 3ab7b6c..610e873 100755
--- a/testcases/kernel/fs/fs_bind/rbind/test02
+++ b/testcases/kernel/fs/fs_bind/rbind/test02
@@ -83,10 +83,12 @@ trap '' ERR
        umount share1
        umount parent2
        umount parent1
+       mount | grep sandbox
 
        rm -rf parent* share*
        cleanup
-} >& /dev/null
+}

Regards,
Jan

> 
> I observed, share1 hold the part of parent2/child2  and 
> parent2/child2/b mount points.
> In our case parent2/child2  and parent2/child2/b are not un-mounted 
> so, when I will un-mount share1 it will show resource busy.
> 
> So for that reason I added those 2 line to un-mount the share1 successfully.
> > +	umount parent2/child2/b
> > +	umount parent2/child2
> 
> After adding the above 2 line, now the share1 is free and can be 
> un-mounted successfully.
> > 	umount share1
> 
> I tested your code also. That is also working fine. I am successfully 
> executing the test02 without any warning.
> 
> Please share your suggestion so that I can go-ahead. Hope my changes 
> for
> test38 is proper.
> 
> Regards,
> Siva
> 
> -----Original Message-----
> From: Jan Stancek [mailto:jstancek@redhat.com]
> Sent: Thursday, November 07, 2013 7:48 AM
> To: Siva Padhy/LGSIA CSP-4(siva.padhy@lge.com)
> Cc: ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] [PATCH v2] BindMounts: fix to properly unmount 
> during cleanup in fs_bind
> 
> 
> 
> 
> 
> ----- Original Message -----
> > From: "Siva Padhy" <siva.padhy@lge.com>
> > To: ltp-list@lists.sourceforge.net
> > Sent: Wednesday, 6 November, 2013 10:45:51 AM
> > Subject: [LTP] [PATCH v2] BindMounts: fix to properly unmount during 
> > cleanup in fs_bind
> > 
> > While running fs_bound testcases, some test directory structure are 
> > mounted using -rbind option. While exiting the testcase the umount 
> > is not properly done, hence the below testcase are falling into TWARN.
> > 
> >   fs_bind/test02
> >   fs_bind/test38
> > 
> > The warning message is as below for respective testcases
> >   TWARN  :  rbind/test02 did not properly clean up
> >   "/tmp/ltp-XXXX9qdYqG/sandbox"
> >   TWARN  :  rbind/test38 did not properly clean up
> >   "/tmp/ltp-XXXX9qdYqG/sandbox"
> > 
> > This patch unmount all the mounted/submounted parts of the 
> > filesystem properly.
> > 
> > Change-Id: Ica6d1799b89e933587c11c1755dff996ddbdf8c5
> > Signed-off-by: Siva <siva.padhy@lge.com>
> > ---
> >  testcases/kernel/fs/fs_bind/rbind/test02 |    2 ++
> >  testcases/kernel/fs/fs_bind/rbind/test38 |    5 +++++
> >  2 files changed, 7 insertions(+)
> > 
> > diff --git a/testcases/kernel/fs/fs_bind/rbind/test02
> > b/testcases/kernel/fs/fs_bind/rbind/test02
> > index 3ab7b6c..eab9cdc 100755
> > --- a/testcases/kernel/fs/fs_bind/rbind/test02
> > +++ b/testcases/kernel/fs/fs_bind/rbind/test02
> > @@ -76,8 +76,10 @@ trap '' ERR
> >  {
> >  	umount parent1/child1/a
> >  	umount parent1/child1/b
> > +	umount parent2/child2/b
> >  	umount parent1/child1
> >  	umount parent1/child1
> > +	umount parent2/child2
> >  	umount parent1/child1
> >  	umount parent1/child1
> >  	umount share1
> 
> Hi,
> 
> This still leaves me with share1 mounted. The following umount 
> sequence works for me (3.10 based kernel). Can you try if it fixes 
> also your issue in test02?
> 
>         umount parent2/child2/b
>         umount parent1/child1/a
>         umount parent2/child2
>         umount share1
>         umount parent1/child1
> 
>         umount parent1/child1
>         umount share1
>         umount parent2
>         umount parent1
> 
> Regards,
> Jan
> 
> > diff --git a/testcases/kernel/fs/fs_bind/rbind/test38
> > b/testcases/kernel/fs/fs_bind/rbind/test38
> > index c9cf3e1..c944ce5 100755
> > --- a/testcases/kernel/fs/fs_bind/rbind/test38
> > +++ b/testcases/kernel/fs/fs_bind/rbind/test38
> > @@ -77,6 +77,7 @@ trap '' ERR
> >  {
> >  	umount share1/a
> >  	umount parent1/child1/b
> > +	umount parent2/child1/b
> >  	umount parent2/child1/c
> >  	umount parent1/child1
> >  	umount parent1/child1
> > @@ -86,6 +87,10 @@ trap '' ERR
> >  	umount parent2
> >  	umount share1
> >  	umount share1
> > +	umount parent1
> > +	umount share2
> > +	umount parent2/child2
> > +	umount parent2
> >  
> >  	rm -rf parent* share*
> >  	cleanup
> > --
> > 1.7.9.5
> > 
> > 
> > --------------------------------------------------------------------
> > --
> > -------- November Webinars for C, C++, Fortran Developers Accelerate 
> > application performance with scalable programming models. Explore 
> > techniques for threading, error checking, porting, and tuning. Get 
> > the most from the latest Intel processors and coprocessors. See 
> > abstracts and register 
> > http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg
> > .c lktrk _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
> > 
> 
------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
