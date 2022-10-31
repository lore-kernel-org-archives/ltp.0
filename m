Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E115FA3740
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 11:09:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F38E63CAA08
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 12:09:37 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 74A7F3C1DB8
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 12:09:26 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 79BB4200224
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 12:09:23 +0100 (CET)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VAhiA2026994;
 Mon, 31 Oct 2022 11:09:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=EkyxJ1mquFUU/+nL+quJw8AslJ9+zR8z7NItNThPMMg=;
 b=aQLSP+jdWK/AGcAOzWuDEZjDoviNT1isviF+jtiuTxWA3cKVurPOh6rLjBmFKP3scgi9
 6S/mwsjNxZDPtwLHCECyZ62EGBrY4MRmRItnqs24LyPjrmpZT+P2hGLY3aJrsSw3I3z7
 XA5FXqkTohrJ1f5I6wrU/XW5e2ZpmXcX7fmGZ3uTkDmsloROPbBAPSuPRLhC0GBmWt35
 WX2BmRVClxuLcnJq+YMFoqNQU+bAqghSrc8V4jeUxoA8Oqcq16Jks52PmPss1k/cYQfQ
 DQP+ttcKjk/PR+ChoEyIELMh1grVRcXfNyaIJHL/c63zVt2Uo50on+LuHWiHz/+cbJt1 zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kjcuwrq9h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Oct 2022 11:09:21 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29VAldDN026871;
 Mon, 31 Oct 2022 11:09:21 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kjcuwrq8g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Oct 2022 11:09:21 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29VB6XNR000358;
 Mon, 31 Oct 2022 11:09:19 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma05fra.de.ibm.com with ESMTP id 3kgut8t2sx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Oct 2022 11:09:19 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 29VB9GvZ39846312
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Oct 2022 11:09:16 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2ACC54C046;
 Mon, 31 Oct 2022 11:09:16 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 75F5D4C044;
 Mon, 31 Oct 2022 11:09:12 +0000 (GMT)
Received: from tarunpc (unknown [9.43.3.121])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Mon, 31 Oct 2022 11:09:12 +0000 (GMT)
Date: Mon, 31 Oct 2022 16:38:54 +0530
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Li Wang <liwang@redhat.com>
Message-ID: <20221031110825.qwnxaj7chjpaiall@tarunpc>
References: <20221029071344.45447-1-tsahu@linux.ibm.com>
 <20221029071344.45447-2-tsahu@linux.ibm.com>
 <CAEemH2e+FUZnQws-9pW5E25Uq01T0zaHzsk8QUa2KJsCKQpDBA@mail.gmail.com>
Content-Disposition: inline
In-Reply-To: <CAEemH2e+FUZnQws-9pW5E25Uq01T0zaHzsk8QUa2KJsCKQpDBA@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: u3uy6qNd-amlopSNo2EpEBZGut50lgHs
X-Proofpoint-GUID: MEMmEfjN5XxSoheuYVP24wmu2etHxrYB
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_06,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999
 clxscore=1011 mlxscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210310070
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/4] Hugetlb: Add new tst_test options for
 hugeltb test support
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com, geetika@linux.ibm.com,
 vaibhav@linux.ibm.com, Richard Palethorpe <rpalethorpe@suse.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,
Thanks for reviewing patch Li,

On Oct 31 2022, Li Wang wrote:
> Hi Tarun,
> 
> This version is much better, comments are inline below.
> 
> On Sat, Oct 29, 2022 at 3:14 PM Tarun Sahu <tsahu@linux.ibm.com> wrote:
> 
> > Most of libhugetlbfs test require mounted hugetlbfs and random opened
> > unlinked file for follow-up test actions.
> >
> > Here, this patch adds two new field in tst_test struct(include/tst_test.h)
> > which user can set if the test requires mounted hugetlbfs and other one
> > for if test requires opened unlinked file.
> >
> > Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> > ---
> >  include/tst_test.h | 20 +++++++++++++++++-
> >  lib/tst_test.c     | 51 +++++++++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 67 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/tst_test.h b/include/tst_test.h
> > index a69965b95..f36382ae9 100644
> > --- a/include/tst_test.h
> > +++ b/include/tst_test.h
> > @@ -131,7 +131,7 @@ struct tst_tag {
> >  };
> >
> >  extern unsigned int tst_variant;
> > -
> > +extern int tst_hugetlb_fd;
> >  #define TST_NO_HUGEPAGES ((unsigned long)-1)
> >
> >  #define TST_UNLIMITED_RUNTIME (-1)
> > @@ -176,6 +176,18 @@ struct tst_test {
> >         int all_filesystems:1;
> >         int skip_in_lockdown:1;
> >         int skip_in_compat:1;
> > +       /*
> > +        * If set, the test function will create a hugetlbfs mount point
> > +        * at /tmp/xxxxxx, where xxxxxx is a random string.
> > +        */
> > +       int needs_hugetlbfs:1;
> > +       /*
> > +        * If set, the test function will create and open a random file
> > +        * under mounted hugetlbfs. To use this option, needs_hugetlbfs
> > must
> > +        * be set. The file descriptior will be set in tst_hugetlb_fd.
> > +        * The close(tst_hugetlb_fd) will be called on test exit(cleanup).
> > +        */
> > +       int needs_unlinked_hugetlb_file:1;
> >
> 
> Why not consider encapsulating these two new fields in 'struct
> tst_hugepage' ?
> 
> Then the tst_test in the case can simply initialize to:
> 
> ....
> static struct tst_test test = {
>     .needs_root = 1,
>     .taint_check = TST_TAINT_D | TST_TAINT_W,
>     .setup = setup,
>     .test_all = run_test,
>     .hugepages = {1, TST_NEEDS, 1, 1},
> };
> 
Ok, I will move these fields in tst_hugepages struct.
> 
> 
> >
> >         /*
> >          * The skip_filesystems is a NULL terminated list of filesystems
> > the
> > @@ -357,6 +369,12 @@ unsigned int tst_remaining_runtime(void);
> >   */
> >  void tst_set_max_runtime(int max_runtime);
> >
> > +/*
> > + * Create and open a random file inside the given dir path.
> > + * It unlinks the file after opening and return file descriptor.
> > + */
> > +int tst_create_unlinked_file(const char *path);
> >
> 
> what about renaming this function to tst_'get|create'_unlinked_file_fd?
> I guess the 'fd' part should be emphasized here.
> 
OK. Will update it.
> 
> 
> > +
> >  /*
> >   * Returns path to the test temporary directory in a newly allocated
> > buffer.
> >   */
> > diff --git a/lib/tst_test.c b/lib/tst_test.c
> > index 8ccde1629..43cba1004 100644
> > --- a/lib/tst_test.c
> > +++ b/lib/tst_test.c
> > @@ -925,7 +925,8 @@ static int needs_tmpdir(void)
> >                tst_test->needs_device ||
> >                tst_test->mntpoint ||
> >                tst_test->resource_files ||
> > -              tst_test->needs_checkpoints;
> > +              tst_test->needs_checkpoints ||
> > +                  tst_test->needs_hugetlbfs;
> >  }
> >
> >  static void copy_resources(void)
> > @@ -1021,6 +1022,30 @@ static void prepare_and_mount_dev_fs(const char
> > *mntpoint)
> >         }
> >  }
> >
> > +static void prepare_and_mount_hugetlb_fs(void)
> > +{
> > +       tst_test->mntpoint = tst_get_tmpdir();
> > +       SAFE_MOUNT("none", tst_test->mntpoint, "hugetlbfs", 0, NULL);
> > +       mntpoint_mounted = 1;
> > +}
> > +
> > +int tst_create_unlinked_file(const char *path)
> > +{
> > +       char template[PATH_MAX];
> > +       int fd;
> > +
> > +       snprintf(template, PATH_MAX, "%s/ltp_%.3sXXXXXX",
> > +                       path, TCID);
> > +
> > +       fd = mkstemp(template);
> > +       if (fd < 0)
> > +               tst_brk(TBROK | TERRNO,
> > +                        "%s: mkstemp(%s) failed", __func__, template);
> > +
> > +       SAFE_UNLINK(template);
> > +       return fd;
> > +}
> > +
> >  static const char *limit_tmpfs_mount_size(const char *mnt_data,
> >                 char *buf, size_t buf_size, const char *fs_type)
> >  {
> > @@ -1094,6 +1119,8 @@ static void do_cgroup_requires(void)
> >         tst_cg_init();
> >  }
> >
> > +int tst_hugetlb_fd = -1;
> > +
> >  static void do_setup(int argc, char *argv[])
> >  {
> >         if (!tst_test)
> > @@ -1217,6 +1244,17 @@ static void do_setup(int argc, char *argv[])
> >                 }
> >         }
> >
> > +       if (tst_test->needs_hugetlbfs)
> > +               prepare_and_mount_hugetlb_fs();
> > +
> > +       if (tst_test->needs_unlinked_hugetlb_file) {
> > +               if (!(tst_test->needs_hugetlbfs)) {
> > +                       tst_brk(TBROK, "Option needs_unlinked_hugetlb_file
> > "
> > +                                       "requires option needs_hugetlbfs");
> > +               }
> > +               tst_hugetlb_fd =
> > tst_create_unlinked_file(tst_test->mntpoint);
> > +       }
> > +
> >
> 
> Seems we have to add a confliction check[1] to avoid multiple mounting
> at 'tst_test->mntpoint'. Or maybe go another method to move all the
> hugetlbfs
> operations into tst_hugetlb.c to isolate details from the tst_test library,
> but
> this will require more changes for all preexisting hugetlb tests.
> 
> 
> [1] something like this:
> 
> @@ -1224,9 +1224,9 @@ static void do_setup(int argc, char *argv[])
>         }
> 
>         if (!!tst_test->needs_rofs + !!tst_test->needs_devfs +
> -           !!tst_test->needs_device > 1) {
> +           !!tst_test->needs_device + !!tst_test->needs_hugetlbfs > 1) {
>                 tst_brk(TBROK,
> -                       "Two or more of needs_{rofs, devfs, device} are
> set");
> +                       "Two or more of needs_{rofs, devfs, device,
> hugetlb} are set");
>         }
> 
OK. Will update it.
> 
>         if (tst_test->needs_device && !mntpoint_mounted) {
> >                 tdev.dev = tst_acquire_device_(NULL,
> > tst_test->dev_min_size);
> 
> 
> > @@ -1299,8 +1337,15 @@ static void do_cleanup(void)
> >         if (ovl_mounted)
> >                 SAFE_UMOUNT(OVL_MNT);
> >
> > -       if (mntpoint_mounted)
> > -               tst_umount(tst_test->mntpoint);
> > +       if (tst_hugetlb_fd >= 0)
> > +               SAFE_CLOSE(tst_hugetlb_fd);
> > +
> > +       if (mntpoint_mounted) {
> > +               if (tst_test->needs_hugetlbfs)
> > +                       SAFE_UMOUNT(tst_test->mntpoint);
> > +               else
> > +                       tst_umount(tst_test->mntpoint);
> > +       }
> >
> >         if (tst_test->needs_device && tdev.dev)
> >                 tst_release_device(tdev.dev);
> > --
> > 2.31.1
> >
> >
> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> >
> >
> 
> -- 
> Regards,
> Li Wang

> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
