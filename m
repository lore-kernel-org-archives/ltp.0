Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A717ECAAA1
	for <ltp@archiver.kernel.org>; Thu, 27 Oct 2022 18:22:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A5F73CA8F9
	for <ltp@archiver.kernel.org>; Thu, 27 Oct 2022 20:22:50 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 02C6F3C6D55
 for <ltp@lists.linux.it>; Thu, 27 Oct 2022 20:22:38 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 94996200AD1
 for <ltp@lists.linux.it>; Thu, 27 Oct 2022 20:22:36 +0200 (CEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RIJYCa004938;
 Thu, 27 Oct 2022 18:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=3mWeJlWyVF5Xnv3t32aC6oq4S2VciRmeuW3E7KAcfSk=;
 b=Od8/WxaHbMugrfOgXhqRtidHQ7i15P7hZt/RvF+S7iu8tgHBLiH9m4YkQd2TdsSSUlKP
 V6zNQATREqcvd5QprZlxIybkX12msL5W69t8rnghPKfoEW9hUGWZpVQjaOpcnNt9Xko1
 vjiaXx0ss1El9oEZ84XEMxri2WL+4qL/rfcC9rpUhBmYY2Kysdouo21/4tm8JVbIB5nH
 ssoNCAEkYLgRcEa0K4W5OO/5wvRNHHFDp6tzT4A4ZIfJdwrYbW+S3DtRtJlcc3Z4MOew
 Bq1pZEEWJMOCH+eQ5HIUPXgWtgMWrvAgAkuWPTdatiMu3Nbl/tpnNXNi6wPMxGRlzZNC 4g== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kfy5qr5vk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Oct 2022 18:22:34 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29RIKsu4005968;
 Thu, 27 Oct 2022 18:22:33 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma03ams.nl.ibm.com with ESMTP id 3kfahqjfrf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Oct 2022 18:22:33 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 29RIMTOu49611038
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Oct 2022 18:22:29 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D81B9A405B;
 Thu, 27 Oct 2022 18:22:29 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 47673A4054;
 Thu, 27 Oct 2022 18:22:27 +0000 (GMT)
Received: from tarunpc (unknown [9.43.54.217])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 27 Oct 2022 18:22:26 +0000 (GMT)
Message-ID: <eeeb6eeba76ed1f39bd9a0d1aff9ccd99b470257.camel@linux.ibm.com>
From: Tarun Sahu <tsahu@linux.ibm.com>
To: rpalethorpe@suse.de
Date: Thu, 27 Oct 2022 23:52:25 +0530
In-Reply-To: <877d0lshx4.fsf@suse.de>
References: <20221019184846.89318-1-tsahu@linux.ibm.com>
 <20221019184846.89318-2-tsahu@linux.ibm.com> <877d0oxj0v.fsf@suse.de>
 <0dd4161726a3cc1cea80d30ec87c92d9089efe41.camel@linux.ibm.com>
 <877d0lshx4.fsf@suse.de>
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Rra7y0jFFhYk1ppEXrZJ7N9atE_wrRW3
X-Proofpoint-GUID: Rra7y0jFFhYk1ppEXrZJ7N9atE_wrRW3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270102
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] Hugetlb: Migrating libhugetlbfs
 brk_near_huge
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
Reply-To: tsahu@linux.ibm.com
Cc: geetika@linux.ibm.com, aneesh.kumar@linux.ibm.com, ltp@lists.linux.it,
 sbhat@linux.ibm.com, vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,
> 
> Tarun Sahu <tsahu@linux.ibm.com> writes:
> 
> > > > +	snprintf(hfile, sizeof(hfile), "%s/ltp_hugetlbfile%d",
> > > > Hopt,
> > > > getpid());
> > > > +	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
> > > > +
> > > > +	fd = SAFE_OPEN(hfile, O_RDWR | O_CREAT, 0600);
> > > > +	SAFE_UNLINK(hfile);
> > > 
> > > I'm guessing opening this file and using it with mmap is a very
> > > common
> > > pattern. If so, it should be encapsulated in tst_hugepage.c.
> > > 
> > Yeah I agree. But the change in tst_hugepage.c will require change
> > in
> > prexisting hugetlb tests.
> 
> You don't need to update existing LTP tests if you add a new flag to
> .tst_test I guess.
yes.
I will add new tst_test flag option for Mount and open file setup 
in next version.
> 
> > > > +}
> > > > +
> > > > +static void cleanup(void)
> > > > +{
> > > > +	if (fd >= 0)
> > > > +		SAFE_CLOSE(fd);
> > > > +	SAFE_UMOUNT(Hopt);
> > > > +}
> > > > +
> > > > +static struct tst_test test = {
> > > > +	.needs_root = 1,
> > > > +	.needs_tmpdir = 1,
> > > > +	.options = (struct tst_option[]) {
> > > > +		{"H:", &Hopt,   "Location of hugetlbfs, i.e.  -
> > > > H
> > > > /var/hugetlbfs"},
> > > 
> > > This is a source of confusion. This description suggests we pass
> > > in
> > > an
> > > existing hugetlb mount. However it's actually where it will be
> > > mounted.
> > > 
> > > Perhaps instead we could use set/getmntent to find an existing
> > > hugetlb
> > > mount?  Then if it is not there, try mounting it. This is what we
> > > do
> > > for
> > > CGroups.
> > > 
> > > I'm not sure what difference it makes where the FS is mounted
> > > anyway. Why is it even an option?
> > 
> > Not sure, If user is ok for using premounted fs without their
> > permission. So instead of searching, it will mount where user will
> > explicitly asked for. Or otherwise if not provided, it will mount
> > at
> > temp location under /tmp.
> 
> Does it actually create a new FS or is it just remounting the
> existing
> hugetlb interface in a new place?
> 
> Also it requires privileges to mount an FS. It seems unlikely that
> some
> database wanting to use hugepages would mount it themselves.
> 
> From the kernel docs:
> 
> "If the user applications are going to request huge pages using mmap
> system
> call, then it is required that system administrator mount a file
> system of
> type hugetlbfs"

I agree.
But this will make Hopt option compulsory for user to provide.
and during batch running of tests (/opt/ltp/runltp -f hugetlb), user
will have to modify each test line in /opt/ltp/runtest to provide the
particular mounted option to get the tests running.

Instead, I propose, to follow the same mechanism as the older hugetlb
test follow, create a random temp location under /tmp (/tmp/xxxxxx),
and mount and umount hugetlbfs as needed. For this way, I will also
remove the unnecessary Hopt option. Though need_root will become 
pre-requisite to run the test.

> 
> > I had taken this option from hugemmap01 test. Thinking, it might be
> > to provide user the flexibility incase user doesnt want test to
> > mount
> > fs at random location by default.
> > 
> > I will change the description to "Provide the location to mount the
> > hugetlbfs or default '/tmp/xxxxxxx'"
> > 
> > > > +		{"s:", &nr_opt, "Set the number of the been
> > > > allocated
> > > > hugepages"},
> > > > +		{}
> > > > +	},
> > > > +	.setup = setup,
> > > > +	.cleanup = cleanup,
> > > > +	.test_all = run_test,
> > > > +	.hugepages = {1, TST_NEEDS},
> > > 
> > > When we set this tst_hugepages.c could fill Hopt (which should be
> > > something like tst_hugepages_mount) with the location of the
> > > mount
> > > point. It could also open the hfile fd and store it in a static
> > > variable like tst_hugepage_fd.
> > Yeah, It will move the repeated actions to single location.
> > 
> > This will
> > require change in lib/tst_hugepage.c and which will require
> > change in already existing test under hugetlb/ . Which will be like
> > a
> > new separate change patch series.
> 
> If it results in too many complicated changes, then converting all
> the
> existing tests could be defered to a later time by creating new
> variables.
Ok.
> 


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
