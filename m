Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <phan@redhat.com>) id 1PpXYx-0001B0-Q1
	for ltp-list@lists.sourceforge.net; Wed, 16 Feb 2011 02:56:19 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PpXYw-0003Af-Gh
	for ltp-list@lists.sourceforge.net; Wed, 16 Feb 2011 02:56:19 +0000
Date: Wed, 16 Feb 2011 10:59:58 +0800
From: Han Pingtian <phan@redhat.com>
Message-ID: <20110216025958.GA2891@hpt.nay.redhat.com>
References: <20110214061409.GA7983@hpt.nay.redhat.com>
	<AANLkTimzLhCfwAgHuB4S3Fo=gHkHEKbjs6ObficnqKXU@mail.gmail.com>
	<20110215031334.GA2884@hpt.nay.redhat.com>
	<AANLkTi=b7R39g8kn6_oNO6dgLp_Frss+v-iTAN6o=z13@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <AANLkTi=b7R39g8kn6_oNO6dgLp_Frss+v-iTAN6o=z13@mail.gmail.com>
Subject: Re: [LTP] [PATCH] ksm: wait 3 increments of full_scans before
 checking the results
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


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx1.redhat.com id
	p1G2uBQx023552

On Tue, Feb 15, 2011 at 06:37:47AM -0800, Garrett Cooper wrote:
> On Mon, Feb 14, 2011 at 7:13 PM, Han Pingtian <phan@redhat.com> wrote:
> > On Sun, Feb 13, 2011 at 10:25:54PM -0800, Garrett Cooper wrote:
> >> On Sun, Feb 13, 2011 at 10:14 PM, Han Pingtian <phan@redhat.com> wro=
te:
> >> > The KSM developer tell us that we should wait 3~5 increments of th=
e
> >> > /sys/kernel/mm/ksm/full_scans before checking ksm* testcases's res=
ults.
> >> > Otherwise, there may be some stuck pages that cause the testing fa=
iled.
> >>
> >> =A0 =A0 A common mistake is thinking that sleep(3) is non-interrupta=
ble.
> >> This proposed patch also has style-violations and is missing error
> >> checking around lseek, et all. Please fix these items according to t=
he
> >> style guide.
> >> Thanks,
> >> -Garrett
> > Thanks reviewing. The patched function will be called by
> > testcases/kernel/mem/ksm/ksm* , which all call tst_sig() in setup().
> > =A0So I think we have processed the interruptable problem of sleep().
>=20
>     Are you sure? I suggest reading the RETURN VALUES section of
> sleep(3), along with the notes about SA_RESTART in signal(7), and
> compare that with what's implemented in the signal(3) equivalent in
> tst_sig.
Thanks. I'll try to make sure the first sleep(1) gets executed to let
KSM to scan pages. The second sleep(1) is in a while loop, so I think we
needn't do the same thing to it. I'll attach the v3 patch, please
review. Thanks.

> HTH,
> -Garrett
>=20
> -----------------------------------------------------------------------=
-------
> The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio X=
E:
> Pinpoint memory and threading errors before they happen.
> Find and fix more than 250 security defects in the development cycle.
> Locate bottlenecks in serial and parallel code that limit performance.
> http://p.sf.net/sfu/intel-dev2devfeb
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

--=20
Han Pingtian
Quality Engineer
hpt @ #kernel-qe
Red Hat, Inc
Freedom ... courage ... Commitment ... ACCOUNTABILITY

--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-ksm-wait-3-increments-of-full_scans-before-checking-.patch"

From d88cc9ab633b757d4a878754cae1063246a516e3 Mon Sep 17 00:00:00 2001
From: Han Pingtian <phan@redhat.com>
Date: Mon, 14 Feb 2011 11:47:59 +0800
Subject: [PATCH] ksm: wait 3 increments of full_scans before checking the results

The KSM developer tells us that we should wait 3~5 increments of the
/sys/kernel/mm/ksm/full_scans before checking ksm* testcases's results.
Otherwise, there may be some stuck pages that cause the testing failed.

Signed-off-by: Han Pingtian <phan@redhat.com>
---
 testcases/kernel/mem/lib/mem.c |   30 ++++++++++++++++++++++++++++--
 1 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 1a53359..435620f 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -298,8 +298,34 @@ void group_check(int run, int pages_shared, int pages_sharing,
 		int pages_volatile, int pages_unshared,
 		int sleep_millisecs, int pages_to_scan)
 {
-        /* 5 seconds for ksm to scan pages. */
-	sleep(5);
+	int fd;
+	char buf[BUFSIZ];
+	int old_num, new_num;
+
+	/* 1 seconds for ksm to scan pages. */
+	while (sleep(1) == 1)
+	    continue;
+
+	fd = open("/sys/kernel/mm/ksm/full_scans", O_RDONLY);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open");
+
+	/* wait 3 increments of full_scans */
+	if (read(fd, buf, BUFSIZ) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "read");
+	old_num = new_num = atoi(buf);
+	if (lseek(fd, 0, SEEK_SET) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "lseek");
+	while (new_num < old_num * 3) {
+		sleep(1);
+		if (read(fd, buf, BUFSIZ) < 0)
+			tst_brkm(TBROK|TERRNO, cleanup, "read");
+		new_num = atoi(buf);
+		if (lseek(fd, 0, SEEK_SET) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "lseek");
+	}
+	close(fd);
+
 	tst_resm(TINFO, "check!");
 	check("run", run);
 	check("pages_shared", pages_shared);
-- 
1.7.1


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--7AUc2qLy4jB3hD7Z--

