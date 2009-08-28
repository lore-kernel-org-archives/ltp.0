Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1Mh3JS-0006d2-QN
	for ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 15:24:26 +0000
Date: Fri, 28 Aug 2009 17:24:15 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20090828152415.GB4567@schrodinger.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
Subject: Re: [LTP] [PATCH] Add autoconf tests for taskstats members not
	present	on older kernels
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jiri Palecek <jpalecek@web.de>
Cc: ltp-list@lists.sourceforge.net


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
> this patch adds autoconf checks for some build failures reported by Cyril Hrubis. Please note I have not tested this on an old kernel.
> 
> Also, it corrects the names of the preprocessor macros defined by autoconf
> 
> The remaining issue (the cgroupstats.h file) should be solved using the autoconf test that was committed recently.

The autoconf part is okay, but getdelays.c needs some more #ifdef
HAVE_LINUX_CGROUPSTAT_H to build correctly on all I have here.

Patch attached, however it may need minor cleanups.

Signed-off-by: Cyril Hrubis chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--lrZ03NoBR/3+SXJZ
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="getdalays_no_cgroupstats_h.patch"

Index: ltp-full-20090731/testcases/kernel/controllers/cgroup/getdelays.c
===================================================================
--- ltp-full-20090731.orig/testcases/kernel/controllers/cgroup/getdelays.c
+++ ltp-full-20090731/testcases/kernel/controllers/cgroup/getdelays.c
@@ -23,11 +23,15 @@
 #include <sys/socket.h>
 #include <signal.h>
 
+#include "config.h"
+
 #include <linux/genetlink.h>
 #include <linux/taskstats.h>
+
+#ifdef HAVE_LINUX_CGROUPSTATS_H
 #include <linux/cgroupstats.h>
+#endif
 
-#include "config.h"
 /*
  * Generic macros for dealing with netlink sockets. Might be duplicated
  * elsewhere. It is recommended that commercial grade applications use
@@ -232,6 +236,8 @@ void task_context_switch_counts(struct t
 #endif
 }
 
+#ifdef HAVE_LINUX_CGROUPSTATS_H
+
 void print_cgroupstats(struct cgroupstats *c)
 {
 	printf("sleeping %llu, blocked %llu, running %llu, stopped %llu, "
@@ -242,6 +248,7 @@ void print_cgroupstats(struct cgroupstat
 		(unsigned long long)c->nr_uninterruptible);
 }
 
+#endif
 
 void print_ioacct(struct taskstats *t)
 {
@@ -390,6 +397,7 @@ int main(int argc, char *argv[])
 	}
 
 	if (containerset) {
+		#ifdef HAVE_LINUX_CGROUPSTAT_H
 		cfd = open(containerpath, O_RDONLY);
 		if (cfd < 0) {
 			perror("error opening container file");
@@ -401,6 +409,10 @@ int main(int argc, char *argv[])
 			perror("error sending cgroupstats command");
 			exit(1);
 		}
+		#else
+			printf("Header linux/cgroupstat.h was missing during compilation,"
+			       "you may have old or incomplete kernel-headers.\n");
+		#endif
 	}
 	if (!maskset && !tid && !containerset) {
 		usage();
@@ -484,10 +496,11 @@ int main(int argc, char *argv[])
 					na = (struct nlattr *) ((char *) na + len2);
 				}
 				break;
-
+			#ifdef HAVE_LINUX_CGROUPSTATS_H
 			case CGROUPSTATS_TYPE_CGROUP_STATS:
 				print_cgroupstats(NLA_DATA(na));
 				break;
+			#endif
 			default:
 				fprintf(stderr, "Unknown nla_type %d\n",
 					na->nla_type);
@@ -513,3 +526,4 @@ done:
 		close(cfd);
 	return 0;
 }
+

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--lrZ03NoBR/3+SXJZ--

