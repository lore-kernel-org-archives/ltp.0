Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Ovuge-0003wS-3g
	for ltp-list@lists.sourceforge.net; Wed, 15 Sep 2010 16:18:20 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ovuga-0007SQ-6D
	for ltp-list@lists.sourceforge.net; Wed, 15 Sep 2010 16:18:20 +0000
Received: by iwn2 with SMTP id 2so310435iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 15 Sep 2010 09:18:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100915134318.GD24784@hannu-debian.research.nokia.com>
References: <000401cb53c6$d7a16620$86e43260$@co.jp>
	<20100915134318.GD24784@hannu-debian.research.nokia.com>
Date: Wed, 15 Sep 2010 09:18:10 -0700
Message-ID: <AANLkTikYz9ppRN1FZBSnpyePoMV79GDWNA4umS7NLUn_@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Hannu Heikkinen <ext-hannu.m.heikkinen@nokia.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>, ext Mitani <mitani@ryobi.co.jp>

On Wed, Sep 15, 2010 at 6:43 AM, Hannu Heikkinen
<ext-hannu.m.heikkinen@nokia.com> wrote:
> On 14/09/10 06:39 +0200, ext Mitani wrote:
>> Hi,
>>
>> POSIX "open_posix_testsuite/conformance/interfaces/sched_yield/1-1.c"
>> build failed in RHEL4.8 (x86, x86_64, ia64):
>> ------------
>> conformance/interfaces/sched_yield/1-1 compile FAILED; SKIPPING In file
>> included from ../../../conformance/interfaces/sched_yield/1-1.c:35:
>> ../../../include/posixtest.h:14:2: #error "Contains GNU-isms that need
>> fixing."
>> ../../../conformance/interfaces/sched_yield/1-1.c: In function
>> `set_thread_affinity':
>> ../../../conformance/interfaces/sched_yield/1-1.c:91: warning: implicit
>> declaration of function `pthread_setaffinity_np'
>> ------------
>>
>> This testset seems to test "sched_yield()", and uses "sched_setafinity()"
>> for CPU fixing.
>> I tried to remove "_GNU_SOURCE" definition from "sched_yield/1-1.c".
>> But "sched_setafinity()" needs "_GNU_SOURCE".
>> "sched_setafinity()" is necessary for this testset, and I considered the
>> substitution for "sched_setafinity()".
>> But I don't have any ideas. There is no function to be substitute for
>> "sched_setafinity()" by POSIX conformity, I think.
>>
>>
>> Regards--
>>
>> -Tomonori Mitani
>>
>
> Hi,
>
> could try this out?
>
> --- include/posixtest.h 2010-09-14 14:05:21.000000000 +0000
> +++ fixing/posixtest.h =A02010-09-14 19:01:02.000000000 +0000
> @@ -11,8 +11,16 @@
> =A0*/
>
> =A0#if defined(_GNU_SOURCE)
> +#if defined (PTS_GNU_SOURCE_WARNING)
> +#warning "Contains GNU-isms that need fixing."
> +#else
> =A0#error "Contains GNU-isms that need fixing."
> +#endif
> +
> =A0#elif defined(_BSD_SOURCE)
> +#if defined (PTS_BSD_SOURCE_WARNING)
> +#warning "Contains BSD-isms that need fixing."
> +#else
> =A0#error "Contains BSD-isms that need fixing."
> =A0#endif
>
>
> Add to yr source #define PTS_GNU_SOURCE_WARNING 1
> and compile, or define in posixtest.h and include that hdr.

That seems like a reasonable thing to do, but here's an alternative
way to do this (less variables):

--- a/testcases/open_posix_testsuite/include/posixtest.h
+++ b/testcases/open_posix_testsuite/include/posixtest.h
@@ -10,10 +10,24 @@
  * return codes
  */

+/*
+ * Define PTS_DEVELOPER_MODE if you want to compile for developer scenario=
s,
+ * including reporting errors (as opposed to warnings), when compiling some
+ * test programs.
+ */
+
 #if defined(_GNU_SOURCE)
+#if defined(PTS_DEVELOPER_MODE)
 #error "Contains GNU-isms that need fixing."
+#else
+#warning "Contains GNU-isms that need fixing."
+#endif
 #elif defined(_BSD_SOURCE)
+#if defined(PTS_DEVELOPER_MODE)
 #error "Contains BSD-isms that need fixing."
+#else
+#warning "Contains BSD-isms that need fixing."
+#endif
 #endif

 #define PTS_PASS        0

Thanks for the idea Hannu :),
-Garrett

---------------------------------------------------------------------------=
---
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
