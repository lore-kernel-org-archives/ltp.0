Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <penght@cn.fujitsu.com>) id 1PgD4Q-0003Vj-R3
	for ltp-list@lists.sourceforge.net; Fri, 21 Jan 2011 09:14:14 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PgD4P-0002wm-8a
	for ltp-list@lists.sourceforge.net; Fri, 21 Jan 2011 09:14:14 +0000
Message-ID: <4D394E65.2010601@cn.fujitsu.com>
Date: Fri, 21 Jan 2011 17:14:13 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
References: <4D39456D.4040308@cn.fujitsu.com>
	<AANLkTik7Zp+LZ8VcMGZMoHtdhcdKHkiqEOCN7s-nbE0c@mail.gmail.com>
In-Reply-To: <AANLkTik7Zp+LZ8VcMGZMoHtdhcdKHkiqEOCN7s-nbE0c@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------010607070306090400010802"
Subject: Re: [LTP] [PATCH] fix error of wrong return code in cases
 rt_sigsuspend01, sched_getaffinity01, ftest06, sem02 and hugemmap03
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net


--------------010607070306090400010802
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8

Hi Garrett,

Garrett Cooper said the following on 2011-1-21 16:43:
> On Fri, Jan 21, 2011 at 12:35 AM, Peng Haitao <penght@cn.fujitsu.com> wrote:
>> Hi Garrett,
>>
>> "return 1" should be replaced with "tst_exit()" in the following cases.
> 
>     Patch please?

The patch is in the first mail. Do you need an attached patch? 

-- 
Best Regards,
Peng Haitao

--------------010607070306090400010802
Content-Type: text/plain;
	name="0001-rt_sigsuspend-fix-error-of-wrong-return-code.patch"
Content-Disposition: attachment;
	filename="0001-rt_sigsuspend-fix-error-of-wrong-return-code.patch"
Content-Transfer-Encoding: quoted-printable

"return 1" should be replaced with "tst=5Fexit()".=0A=0ASigned-off-by: Peng=
 Haitao <penght@cn.fujitsu.com>=0A---=0A testcases/kernel/fs/ftest/ftest06.=
c                |    4 ++--=0A testcases/kernel/ipc/semaphore/sem02.c     =
        |    4 ++--=0A testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c |=
    4 ++--=0A .../syscalls/rt=5Fsigsuspend/rt=5Fsigsuspend01.c       |    4=
 ++--=0A .../sched=5Fgetaffinity/sched=5Fgetaffinity01.c        |    5 ++--=
-=0A 5 files changed, 10 insertions(+), 11 deletions(-)=0A=0Adiff --git a/t=
estcases/kernel/fs/ftest/ftest06.c b/testcases/kernel/fs/ftest/ftest06.c=0A=
index b985a1d..d8ff8b6 100644=0A--- a/testcases/kernel/fs/ftest/ftest06.c=
=0A+++ b/testcases/kernel/fs/ftest/ftest06.c=0A@@ -249,7 +249,7 @@ int main=
(int ac, char *av[])=0A 		tst=5Fresm(TPASS, "Test passed.");=0A =0A 	cleanu=
p();=0A-	return 1;=0A+	tst=5Fexit();=0A }=0A =0A #define	warn(val,m1,m2)	if=
 ((val) < 0) dowarn(me,m1,m2)=0A@@ -479,4 +479,4 @@ static void cleanup(voi=
d)=0A 	}=0A 	tst=5Frmdir();=0A =0A-}=0A\ No newline at end of file=0A+}=0Ad=
iff --git a/testcases/kernel/ipc/semaphore/sem02.c b/testcases/kernel/ipc/s=
emaphore/sem02.c=0Aindex 17645d8..5b9c58d 100644=0A--- a/testcases/kernel/i=
pc/semaphore/sem02.c=0A+++ b/testcases/kernel/ipc/semaphore/sem02.c=0A@@ -1=
26,7 +126,7 @@ int main(int argc, char **argv)=0A 	tst=5Fresm(TPASS, "passe=
d");=0A     cleanup();=0A =0A-    return 1;=0A+    tst=5Fexit();=0A }=0A =
=0A /* This thread sleeps 10 seconds then waits on the semaphore.  As long=
=0A@@ -169,4 +169,4 @@ void cleanup(void)=0A {=0A 	TEST=5FCLEANUP;=0A =0A-}=
=0A\ No newline at end of file=0A+}=0Adiff --git a/testcases/kernel/mem/hug=
etlb/hugemmap/hugemmap03.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap=
03.c=0Aindex 209e40e..c1479fe 100644=0A--- a/testcases/kernel/mem/hugetlb/h=
ugemmap/hugemmap03.c=0A+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap=
03.c=0A@@ -134,7 +134,7 @@ main(int ac, char **av)=0A =0A 	cleanup();=0A =
=0A-	return 1;=0A+	tst=5Fexit();=0A #endif=0A }=0A =0A@@ -178,4 +178,4 @@ c=
leanup()=0A =0A 	unlink(TEMPFILE);=0A =0A-}=0A\ No newline at end of file=
=0A+}=0Adiff --git a/testcases/kernel/syscalls/rt=5Fsigsuspend/rt=5Fsigsusp=
end01.c b/testcases/kernel/syscalls/rt=5Fsigsuspend/rt=5Fsigsuspend01.c=0Ai=
ndex f9e3b34..60f63dd 100644=0A--- a/testcases/kernel/syscalls/rt=5Fsigsusp=
end/rt=5Fsigsuspend01.c=0A+++ b/testcases/kernel/syscalls/rt=5Fsigsuspend/r=
t=5Fsigsuspend01.c=0A@@ -182,5 +182,5 @@ int main(int ac, char **av) {=0A =
=0A 	cleanup();=0A =0A-	return 1;=0A-}=0A\ No newline at end of file=0A+	ts=
t=5Fexit();=0A+}=0Adiff --git a/testcases/kernel/syscalls/sched=5Fgetaffini=
ty/sched=5Fgetaffinity01.c b/testcases/kernel/syscalls/sched=5Fgetaffinity/=
sched=5Fgetaffinity01.c=0Aindex d5182da..014acf2 100644=0A--- a/testcases/k=
ernel/syscalls/sched=5Fgetaffinity/sched=5Fgetaffinity01.c=0A+++ b/testcase=
s/kernel/syscalls/sched=5Fgetaffinity/sched=5Fgetaffinity01.c=0A@@ -236,6 +=
236,5 @@ realloc:=0A =0A 	cleanup();=0A =0A-	return (1);=0A-=0A-}=0A\ No ne=
wline at end of file=0A+	tst=5Fexit();=0A+}=0A-- =0A1.7.3.1=0A=0A=

--------------010607070306090400010802
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
--------------010607070306090400010802
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------010607070306090400010802--


