Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WGBIj-000708-MU
	for ltp-list@lists.sourceforge.net; Wed, 19 Feb 2014 17:51:17 +0000
Date: Wed, 19 Feb 2014 18:51:05 +0100
From: chrubis@suse.cz
Message-ID: <20140219175105.GA22691@rei>
References: <1390428817-31923-1-git-send-email-sweekar.pinto@oracle.com>
	<20140213175049.GA19125@rei.suse.cz> <5301EB5E.2010606@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5301EB5E.2010606@oracle.com>
Subject: Re: [LTP] [PATCH 1/3] Fixed compile errors in crasher.c
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
To: Sweekar Pinto <sweekar.pinto@oracle.com>
Cc: lisa.vaz@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> >> Signed-off-by: Sweekar Pinto <sweekar.pinto@oracle.com>
> >> ---
> >>   testcases/kdump/lib/crasher/crasher.c |    6 ++++--
> >>   1 files changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/testcases/kdump/lib/crasher/crasher.c b/testcases/kdump/lib/crasher/crasher.c
> >> index bc192dc..2b01412 100644
> >> --- a/testcases/kdump/lib/crasher/crasher.c
> >> +++ b/testcases/kdump/lib/crasher/crasher.c
> >> @@ -25,7 +25,10 @@
> >>   #include <linux/proc_fs.h>
> >>   #include <linux/spinlock.h>
> >>   #include <asm/uaccess.h>
> >> +#include <linux/version.h>
> >> +#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 4, 0)
> >>   #include <asm/system.h>
> >> +#endif
> > The inner include should look like:
> >
> > # include <asm/system.h>
> Not sure what you mean here?

Just indentation of the inner include blocks. The preprocesor directives
are usually indented by spaces between the # and the keyword such as:

#ifdef ...
# if ...
#  include ...
# endif
#endif

> >>   MODULE_LICENSE("GPL");
> >>   
> >> @@ -46,7 +49,7 @@ static int crasher_write(struct file *file, const char *buffer,
> >>   			 unsigned long count, void *data)
> >>   {
> >>   	char value, *a;
> >> -	spinlock_t mylock = SPIN_LOCK_UNLOCKED;
> >> +	DEFINE_SPINLOCK(mylock);
> >>   
> >>   	/* grab the first byte the user gave us, ignore the rest */
> >>   	if (copy_from_user(&value, buffer, 1))
> >> @@ -94,7 +97,6 @@ int crasher_init(void)
> >>   
> >>   	crasher_proc->read_proc = crasher_read;
> >>   	crasher_proc->write_proc = crasher_write;
> >> -	crasher_proc->owner = THIS_MODULE;
> >>   	return 0;
> >>   }
> >>   
> >> -- 
> >> 1.7.1
> >>
> >>
> >> >From f58a6316dc168781daa76edf4d78a217e2af2628 Mon Sep 17 00:00:00 2001
> >> From: Sweekar Pinto <sweekar.pinto@oracle.com>
> >> Date: Wed, 22 Jan 2014 17:05:01 -0500
> >> Subject: [PATCH 2/3] Fix passwordless ssh for network(ssh) dump test
> >>
> >> -Force ssh to use kdumps rsa key to run commands remotely
> >>
> >> Signed-off-by: Sweekar Pinto <sweekar.pinto@oracle.com>
> >> ---
> >>   testcases/kdump/runkdump.sh |    6 +++---
> >>   1 files changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/testcases/kdump/runkdump.sh b/testcases/kdump/runkdump.sh
> >> index e2e681c..cd6ee1c 100755
> >> --- a/testcases/kdump/runkdump.sh
> >> +++ b/testcases/kdump/runkdump.sh
> >> @@ -95,7 +95,7 @@ PrepareVerify ()
> >>               exit 1
> >>           fi
> >>   
> >> -        file=$(ssh "${SCP_PATH}" "ls -t ${COREDIR}/*/vmcore \
> >> +        file=$(ssh -i ~/.ssh/kdump_id_rsa "${SCP_PATH}" "ls -t ${COREDIR}/*/vmcore* \
> >>            2>/dev/null | head -1")
> >>   
> >>           mkdir -p "${COREDIR}/${last}"
> >> @@ -103,7 +103,7 @@ PrepareVerify ()
> >>           if [ "${file}" ]; then
> >>               # Not fatal error.
> >>               set +e
> >> -            scp "${SCP_PATH}:${file}" "${COREDIR}/${last}"
> >> +            scp  -i ~/.ssh/kdump_id_rsa "${SCP_PATH}:${file}" "${COREDIR}/${last}"
> >>               set -e
> >>           fi
> >>   
> >> @@ -116,7 +116,7 @@ PrepareVerify ()
> >>           COREDIR=/mnt"${COREDIR}"
> >>       fi
> >>   
> >> -    vmcore=$(ls -t "${COREDIR}"/*/vmcore 2>/dev/null | head -1)
> >> +    vmcore=$(ls -t "${COREDIR}"/*/vmcore* 2>/dev/null | head -1)
> Some versions of kexec-tools append the date to the vmcore file. Hence 
> the vmcore*.

This is missing from the commit message. Imagine that you are trying to
figure out why this change was needed, without a proper description in
the commit message this will take hours to figure out.

> > This change is not explained in the commit message.
> >
> >>   }
> >>   
> >>   VerifyTest ()
> >> -- 
> >> 1.7.1
> >>
> >>
> >> >From 76ab06883327fdcdf038af5dd96a036e0b077818 Mon Sep 17 00:00:00 2001
> >> From: Sweekar Pinto <sweekar.pinto@oracle.com>
> >> Date: Wed, 22 Jan 2014 17:08:23 -0500
> >> Subject: [PATCH 3/3] Change crashkernel param to 256M@128M
> >>
> >> -Change the crashkernel parm of x86 and default arch to 256M@128M as this is found to be the best fit
> > Can you elaborate further? The kernel documentation
> > (Documentation/kdump/kdump.txt) still says 64M@16M.
> We always get a "crashkernel reservation failed - memory is in use" with 
> crashkernel=64M@16M on all of our test hardware.
> 256M@128M seems to be the best fit based on empirical data.

Ok, this explanation should be in the commit message so that anybody who
looks at the commit can figure out why the numbers were changed this
way.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
