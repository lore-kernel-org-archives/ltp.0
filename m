Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MCB8V-0005jA-Pg
	for ltp-list@lists.sourceforge.net; Thu, 04 Jun 2009 11:29:31 +0000
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MCB8R-00039r-OQ
	for ltp-list@lists.sourceforge.net; Thu, 04 Jun 2009 11:29:31 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Thu, 04 Jun 2009 16:59:22 +0530
Message-Id: <20090604112922.12364.5307.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [PATCH] LTP May 2009 build fail fix for ssgetmask() syscall
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8788763670642054885=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Munipradeep Beerakam <mpradeep@linux.vnet.ibm.com>
Cc: Ltp-List <ltp-list@lists.sf.net>

--===============8788763670642054885==

>On Thu, 2009-06-04 at 15:56 +0530, Munipradeep Beerakam wrote:
>Hi,
> 
> It failed on both x86 and x86_64 architectures
> 
> Regards
> Muni
> 
> On Thu, 2009-06-04 at 15:55 +0900, Nobuhiro Iwamatsu wrote:
> > Hi,
> > 
> > Munipradeep Beerakam wrote:
> >  > Hi,
> >  >
> >  > I tried to build the LTP tarball ltp-full-20090531.tgz on RHEL5.4
> >  > pre-Alpha Distribution. But build failed with the following error:
> >  >
> >  > ------------------------------------------------------------------
> >  >
> >  > make[4]: Entering directory
> >  > `/root/ltp-full-20090531/testcases/kernel/syscalls/sgetmask'
> >  > gcc -g -O2 -I../../include -g -Wall -I../../../../include -Wall
> >  > sgetmask01.c  -L../../../../lib -lltp -o sgetmask01
> >  > sgetmask01.c: In function ���main���:
> >  > sgetmask01.c:142: error: ���__NR_ssetmask��� undeclared (first use in this
> >  > function)
> >  > sgetmask01.c:142: error: (Each undeclared identifier is reported only
> >  > once
> >  > sgetmask01.c:142: error: for each function it appears in.)
> >  > make[4]: *** [sgetmask01] Error 1
> >  > make[4]: Leaving directory
> >  > `/root/ltp-full-20090531/testcases/kernel/syscalls/sgetmask'
> >  > make[3]: *** [all] Error 2
> >  > make[3]: Leaving directory
> >  > `/root/ltp-full-20090531/testcases/kernel/syscalls'
> >  > make[2]: *** [all] Error 2
> >  > make[2]: Leaving directory `/root/ltp-full-20090531/testcases/kernel'
> >  > make[1]: *** [all] Error 2
> >  > make[1]: Leaving directory `/root/ltp-full-20090531/testcases'
> >  > make: *** [all] Error 2
> 

Can you please try out this patch and see whether you are still
able to reproduce it in any of your architecture ?

Signed-off-by: Subrata Modak <subrata@linux.vnet.ibm.com>
---

--- ltp-full-20090531/testcases/kernel/syscalls/sgetmask/sgetmask01.c.orig	2009-06-04 16:41:22.000000000 +0530
+++ ltp-full-20090531/testcases/kernel/syscalls/sgetmask/sgetmask01.c	2009-06-04 16:51:36.000000000 +0530
@@ -49,7 +49,7 @@
 
 #include <stdio.h>
 #include <signal.h>
-#include <sys/syscall.h>
+#include <syscall.h>
 #include <unistd.h>
 #include <stdio.h>
 #include <errno.h>
@@ -125,6 +125,7 @@ int main(int ac, char **av) {
 	int lc;                 /* loop counter */
         char *msg;              /* message returned from parse_opts */
 	
+#ifdef __NR_ssetmask
         /* parse standard options */
         if ((msg = parse_opts(ac, av, (option_t *)NULL, NULL)) != (char *)NULL){
              tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
@@ -155,5 +156,9 @@ int main(int ac, char **av) {
         }	
 	cleanup();
         tst_exit();
+#else
+	tst_resm(TCONF,"__NR_ssetmask not defined for this Distro/Arch");
+	tst_exit();
+#endif
 }
 
---
Regards--
Subrata

>  >
> >  > ------------------------------------------------------------------
> >  >
> >  > The variable '__NR_ssetmask' declaration is available in /usr/include
> >  >
> >  > ~# grep -r "__NR_ssetmask" /usr/include/
> >  > /usr/include/bits/syscall.h:#define SYS_ssetmask __NR_ssetmask
> >  > /usr/include/asm-i386/unistd.h:#define __NR_ssetmask             69
> >  >
> >  > What could be the reason for failure?
> >  >
> > What kind of arch do you use?
> > x86_64? I became the same problem too.
> > x86_64 does not seem to have this systemcall.
> > 
> > Best regards,
> >   Nobuhiro
> > 
> 


--===============8788763670642054885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
--===============8788763670642054885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8788763670642054885==--
