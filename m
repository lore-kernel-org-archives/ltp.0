Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C700C4167B
	for <ltp@archiver.kernel.org>; Mon, 26 Dec 2022 09:39:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A5423CB896
	for <ltp@archiver.kernel.org>; Mon, 26 Dec 2022 10:39:36 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 93E723C899B
 for <ltp@lists.linux.it>; Mon, 26 Dec 2022 10:39:26 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 23D25600120
 for <ltp@lists.linux.it>; Mon, 26 Dec 2022 10:39:24 +0100 (CET)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2BQ9BmLg008091; Mon, 26 Dec 2022 09:39:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=8l35mdAv6JP20LBcKzBmluRjvyrMuNLNwmAszNClQHw=;
 b=ckc3/xe+qZh02qZ5zlHlwduHCzDyP+ONNqiYuYErttyzR2DruRgET6GuWw01SNoerleg
 F1e8szdBzSkmMu0WZqm7GUuTwzDsqmz9LjGCgIVW3sLm+Lwl4S6yTmL+KDcoXNAQquRO
 j6SJ8pYWzs08Ir1c5aJ8AVDBrM88IHrRLuv3JUSzx1Gvc/4NbDPBfKbklVbhuU35lG9z
 FZREXb5Ji8Py6LNzL86CR5fgoL4sXAa4hozuPCjq1Wl68qJBuddir/eIKfnalJHwssg4
 rYSnzyKN+XfB5+yC+4E+zraGrXd4LicKPK+PGY7Neyx1bZ0ZvTOghgVDtBhcoKrUqlXx 9w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mq8s2rnyp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Dec 2022 09:39:22 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BQ9YA3B005663;
 Mon, 26 Dec 2022 09:39:21 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mq8s2rnvt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Dec 2022 09:39:21 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BPF7udB014382;
 Mon, 26 Dec 2022 09:39:19 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3mns26j6gv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Dec 2022 09:39:19 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2BQ9dFd522872336
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Dec 2022 09:39:15 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4029F20049;
 Mon, 26 Dec 2022 09:39:15 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 130A620040;
 Mon, 26 Dec 2022 09:39:12 +0000 (GMT)
Received: from tarunpc (unknown [9.43.13.185])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 26 Dec 2022 09:39:11 +0000 (GMT)
Date: Mon, 26 Dec 2022 15:09:08 +0530
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Li Wang <liwang@redhat.com>
Message-ID: <20221226093908.hfcf4o25wfh2zfsp@tarunpc>
References: <20221225154213.84183-1-tsahu@linux.ibm.com>
 <20221225154213.84183-2-tsahu@linux.ibm.com>
 <CAEemH2eyO686YNSSdRE7vDhyU9qYEsdNLfwFUiv_a+jK1QeLiA@mail.gmail.com>
Content-Disposition: inline
In-Reply-To: <CAEemH2eyO686YNSSdRE7vDhyU9qYEsdNLfwFUiv_a+jK1QeLiA@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SIyJEX3aGGT0lLw4jJH9NBmlY2HjPJ1J
X-Proofpoint-ORIG-GUID: gM-6kStCPK0Njhl_faSgrGInrATrokt4
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-26_06,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1015 suspectscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212260083
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 01/13] Hugetlb: Migrating libhugetlbfs mlock
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
 vaibhav@linux.ibm.com, rpalethorpe@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,
Thanks for reviewing the patch.
Please find my comments inline.

--skip
On Dec 26 2022, Li Wang wrote:
> On Sun, Dec 25, 2022 at 11:42 PM Tarun Sahu <tsahu@linux.ibm.com> wrote:
> > +static void run_test(void)
> > +{
> >
> 
> 
> 
> > +       struct rlimit limit_info;
> > +
> > +       if (getrlimit(RLIMIT_MEMLOCK, &limit_info))
> > +               tst_res(TWARN|TERRNO, "Unable to read locked memory
> > rlimit");
> > +       if (limit_info.rlim_cur < hpage_size)
> > +               tst_brk(TCONF, "Locked memory ulimit set below huge page
> > size");
> >
> 
> These lines are better for moving into setup() phase. And, I'd propose
> printing the value of 'limit_info.rlim_cur' and 'hpage_size' when TCONF.
> 
> The default value of max-locked-memory is smaller than hpage_size on
> both RHEL8 and 9, which means this test will TCONF and skip running.
> I'm hesitating should we temporally cancel the limitations and make
> this test can really perform then restore that value to the original,
> is this change make sense? WDYT?
> 
Yeah, Incase if limit is smaller than expected, we can change it temporarily
to run the test. Will update in next revision. Also will change,
getrlimit/setrlimit function to SAFE_*.


> 
> 
> > +
> > +       test_simple_mlock(MAP_PRIVATE, "MAP_PRIVATE");
> > +       test_simple_mlock(MAP_SHARED, "MAP_SHARED");
> > +       test_simple_mlock(MAP_PRIVATE|MAP_LOCKED,
> > "MAP_PRIVATE|MAP_LOCKED");
> > +       test_simple_mlock(MAP_SHARED|MAP_LOCKED, "MAP_SHARED|MAP_LOCKED");
> >
> 
> If we define an additional function like flags_to_str(int flags) for
> converting
> the flag into a string, which will be more simple for reading.
> 
> static char *flags_to_str(int flags)
> {
>        ...
> }
> 
> static void test_simple_mlock(int flags)
> {
>         char *flags_str = flags_to_str(flags);
>         ...
> }
> 
It was not used so often and only some specific flags are used. I think
if there will be more general use case being some more mmap flags used in
application, then it would be good to change this to function.

Another way is to define a macro like

#define FLAGS_STR(flag) #flag

and pass it like: test_simple_mlock(flag, FLAGS_STR(flag));

But I thought, it is like passing the string itself.

what do you think?

> 
> 
> > +
> > +}
> > +
> > +static void setup(void)
> > +{
> > +       hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
> > +}
> > +
> > +static void cleanup(void)
> > +{
> > +       if (fd >= 0)
> > +               SAFE_CLOSE(fd);
> > +}
> > +
> > +static struct tst_test test = {
> > +       .needs_root = 1,
> > +       .mntpoint = MNTPOINT,
> > +       .needs_hugetlbfs = 1,
> > +       .needs_tmpdir = 1,
> > +       .setup = setup,
> > +       .cleanup = cleanup,
> > +       .test_all = run_test,
> > +       .hugepages = {1, TST_NEEDS},
> > +};
> > --
> > 2.31.1
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
