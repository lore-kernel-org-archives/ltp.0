Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <phan@redhat.com>) id 1PsBOK-0003VJ-3h
	for ltp-list@lists.sourceforge.net; Wed, 23 Feb 2011 09:52:16 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PsBOI-0000ll-UB
	for ltp-list@lists.sourceforge.net; Wed, 23 Feb 2011 09:52:16 +0000
Date: Wed, 23 Feb 2011 17:56:05 +0800
From: Han Pingtian <phan@redhat.com>
Message-ID: <20110223095605.GI2947@hpt.nay.redhat.com>
References: <20110221083135.GA9779@hpt.nay.redhat.com>
	<AANLkTi=vTXpHj92=D3O=Oua6iZjfQoaCYSokb8PZvEsi@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8P1HSweYDcXXzwPJ"
Content-Disposition: inline
In-Reply-To: <AANLkTi=vTXpHj92=D3O=Oua6iZjfQoaCYSokb8PZvEsi@mail.gmail.com>
Subject: Re: [LTP] [PATCH v2] check two possible pathes for cpuset
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


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 23, 2011 at 12:45:04AM -0800, Garrett Cooper wrote:
> On Mon, Feb 21, 2011 at 12:31 AM, Han Pingtian <phan@redhat.com> wrote:
> > From
> >
> > http://lxr.linux.no/#linux+v2.6.37/Documentation/cgroups/cpusets.txt
> >
> > "Note that for legacy reasons, the "cpuset" filesystem exists as a
> > wrapper around the cgroup filesystem.
> >
> > The command
> >
> > mount -t cpuset X /dev/cpuset
> >
> > is equivalent to
> >
> > mount -t cgroup -ocpuset,noprefix X /dev/cpuset"
> >
> > However, I found this is not always case. In addition, there is an
> > direct implementation without cgroup, and I can't find any doc about
> > the behaviours of the prefix.
> >
> > So, It can be difficult to predict if cpuset files have prefix or not,
> > so only to fail after checked both.
> 
>     Please resubmit this as a proper git-formatted email with the patch.
> Thanks,
> -Garrett
Is this one make sense to you? Thanks.

-- 
Han Pingtian
Quality Engineer
hpt @ #kernel-qe
Red Hat, Inc
Freedom ... courage ... Commitment ... ACCOUNTABILITY

--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-check-two-possible-pathes-for-cpuset.patch"

From ac0a3402d8e9a3d788f301818e1672a7a96596bb Mon Sep 17 00:00:00 2001
From: CAI Qian <caiqian@redhat.com>
Date: Fri, 21 Jan 2011 17:49:27 +0800
Subject: [PATCH] check two possible pathes for cpuset

From Documentation/cgroups/cpusets.txt of kernel source:

"Note that for legacy reasons, the "cpuset" filesystem exists as a
wrapper around the cgroup filesystem.

The command

mount -t cpuset X /dev/cpuset

is equivalent to

mount -t cgroup -ocpuset,noprefix X /dev/cpuset"

However, I found this is not always case. In addition, there is an
direct implementation without cgroup, and I can't find any doc about
the behaviours of the prefix.

So, It can be difficult to predict if cpuset files have prefix or not,
so only to fail after checked both.

Signed-off-by: CAI Qian <caiqian@redhat.com>
Signed-off-by: Han Pingtian <phan@redhat.com>
---
 testcases/kernel/mem/lib/mem.c |   24 ++++++++++++++++++++----
 1 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 1a53359..75ecaee 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -89,16 +89,32 @@ void write_cpusets(void)
 	gather_cpus(cpus);
 	tst_resm(TINFO, "CPU list for 2nd node is %s.", cpus);
 
+	/* try either '/dev/cpuset/mems' or '/dev/cpuset/cpuset.mems'
+	 * please see Documentation/cgroups/cpusets.txt of kernel src for detail */
 	fd = open(CPATH_NEW "/mems", O_WRONLY);
-	if (fd == -1)
-		tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+	if (fd == -1) {
+		if (errno == ENOENT) {
+			fd = open(CPATH_NEW "/cpuset.mems", O_WRONLY);
+			if (fd == -1)
+				tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		} else
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+	}
 	if (write(fd, "1", 1) != 1)
 		tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
 	close(fd);
 
+	/* try either '/dev/cpuset/cpus' or '/dev/cpuset/cpuset.cpus'
+	 * please see Documentation/cgroups/cpusets.txt of kernel src for detail */
 	fd = open(CPATH_NEW "/cpus", O_WRONLY);
-	if (fd == -1)
-		tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+	if (fd == -1) {
+		if (errno == ENOENT) {
+			fd = open(CPATH_NEW "/cpuset.cpus", O_WRONLY);
+			if (fd == -1)
+				tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		} else
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+	}
 	if (write(fd, cpus, strlen(cpus)) != strlen(cpus))
 		tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
 	close(fd);
-- 
1.7.1


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Free Software Download: Index, Search & Analyze Logs and other IT data in 
Real-Time with Splunk. Collect, index and harness all the fast moving IT data 
generated by your applications, servers and devices whether physical, virtual
or in the cloud. Deliver compliance at lower cost and gain new business 
insights. http://p.sf.net/sfu/splunk-dev2dev 
--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--8P1HSweYDcXXzwPJ--

