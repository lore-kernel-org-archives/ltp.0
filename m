Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ext-hannu.m.heikkinen@nokia.com>) id 1OvpUJ-0002Vz-4q
	for ltp-list@lists.sourceforge.net; Wed, 15 Sep 2010 10:45:15 +0000
Received: from smtp.nokia.com ([147.243.1.47] helo=mgw-sa01.nokia.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OvpUG-0003aT-M0
	for ltp-list@lists.sourceforge.net; Wed, 15 Sep 2010 10:45:15 +0000
Date: Wed, 15 Sep 2010 13:43:18 +0000
From: Hannu Heikkinen <ext-hannu.m.heikkinen@nokia.com>
Message-ID: <20100915134318.GD24784@hannu-debian.research.nokia.com>
References: <000401cb53c6$d7a16620$86e43260$@co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <000401cb53c6$d7a16620$86e43260$@co.jp>
Subject: Re: [LTP] POSIX "sched_yield/1-1.c" build failed
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
To: ext Mitani <mitani@ryobi.co.jp>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On 14/09/10 06:39 +0200, ext Mitani wrote:
> Hi,
> 
> POSIX "open_posix_testsuite/conformance/interfaces/sched_yield/1-1.c" 
> build failed in RHEL4.8 (x86, x86_64, ia64):
> ------------
> conformance/interfaces/sched_yield/1-1 compile FAILED; SKIPPING In file
> included from ../../../conformance/interfaces/sched_yield/1-1.c:35:
> ../../../include/posixtest.h:14:2: #error "Contains GNU-isms that need
> fixing."
> ../../../conformance/interfaces/sched_yield/1-1.c: In function
> `set_thread_affinity':
> ../../../conformance/interfaces/sched_yield/1-1.c:91: warning: implicit
> declaration of function `pthread_setaffinity_np'
> ------------
> 
> This testset seems to test "sched_yield()", and uses "sched_setafinity()" 
> for CPU fixing.
> I tried to remove "_GNU_SOURCE" definition from "sched_yield/1-1.c".
> But "sched_setafinity()" needs "_GNU_SOURCE".
> "sched_setafinity()" is necessary for this testset, and I considered the
> substitution for "sched_setafinity()".
> But I don't have any ideas. There is no function to be substitute for
> "sched_setafinity()" by POSIX conformity, I think.
> 
> 
> Regards--
> 
> -Tomonori Mitani
> 

Hi,

could try this out?

--- include/posixtest.h	2010-09-14 14:05:21.000000000 +0000
+++ fixing/posixtest.h	2010-09-14 19:01:02.000000000 +0000
@@ -11,8 +11,16 @@
  */
 
 #if defined(_GNU_SOURCE)
+#if defined (PTS_GNU_SOURCE_WARNING)
+#warning "Contains GNU-isms that need fixing."
+#else
 #error "Contains GNU-isms that need fixing."
+#endif
+
 #elif defined(_BSD_SOURCE)
+#if defined (PTS_BSD_SOURCE_WARNING)
+#warning "Contains BSD-isms that need fixing."
+#else
 #error "Contains BSD-isms that need fixing."
 #endif


Add to yr source #define PTS_GNU_SOURCE_WARNING 1
and compile, or define in posixtest.h and include that hdr.

br,
Hannu

-- 
Hannu Heikkinen
http://www.nixu.com

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
