Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4108C433FE
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 07:37:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C34EC3CB05E
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 09:37:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1AE693CA06D
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 09:36:56 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4724520099E
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 09:36:55 +0200 (CEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29I7HuoP001467
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 07:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : content-transfer-encoding : mime-version; s=pp1;
 bh=a8dXEDx50qDUZAbCkF6oMRQScnFoExxVGfFda1d1IHg=;
 b=N4Wry6cBQsP+7ih2+g0qnUKNRfqSK3ygmC/33JYhum+OJljHpL/9ynZe+EZCXdGzd9+h
 28GGxLz6qkcZEaoC49yYjX1kmCxbZry6Posc4JnvUCE4aoI5nxOmFJbF4HL78uWBdHlz
 hZHJlpClBQKToExL8P9kj2IcssFg5BCaDe5XsHMpM4UurTWTGJp2H8s8c0Qk03wKjAbv
 O9adgbjIk1CT3ZwuiLRPcH37iKzmKZi2Thruj+X+9Zlwc6lqGeR/EyQJ0BwCKvNwmtdt
 5oCukvAn4aZvU8ik8DUaoqfhMWY5saU7E1lLelM5Oo+ylGUHoyv9MEsF4qReG2qAUfAn LA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k9qmrrct8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 07:36:51 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29I7JiUg008796
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 07:36:40 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k9qmrrc8j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Oct 2022 07:36:40 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29I7Ksc7032447;
 Tue, 18 Oct 2022 07:36:32 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma06ams.nl.ibm.com with ESMTP id 3k7m4jmqyw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Oct 2022 07:36:32 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 29I7aTmv42729826
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Oct 2022 07:36:29 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D68FA4053;
 Tue, 18 Oct 2022 07:36:29 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 67EBEA404D;
 Tue, 18 Oct 2022 07:36:27 +0000 (GMT)
Received: from tarunpc (unknown [9.43.38.108])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 18 Oct 2022 07:36:27 +0000 (GMT)
Message-ID: <fac2f04d8cdb7a28e0d84054c01ee284cb9d895b.camel@linux.ibm.com>
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Li Wang <liwang@redhat.com>
Date: Tue, 18 Oct 2022 13:06:25 +0530
In-Reply-To: <CAEemH2d_pdFqN-P=Ab00gpHypYW2z6Y2m9P6vLenRz+tFNvndw@mail.gmail.com>
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
 <20221016125731.249078-2-tsahu@linux.ibm.com>
 <CAEemH2d_pdFqN-P=Ab00gpHypYW2z6Y2m9P6vLenRz+tFNvndw@mail.gmail.com>
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: z19JxJ3PnZjaw9Zce_Vy3AvwjLbjTz9f
X-Proofpoint-ORIG-GUID: bOeWJTpB57zTskYdIj_T6--QonEL0IPl
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_01,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015
 mlxscore=0 phishscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210180042
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 01/29] Hugetlb: Migrating libhugetlbfs
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
Cc: aneesh.kumar@linux.ibm.com, sbhat@linux.ibm.com, ltp@lists.linux.it,
 vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li, 
Thanks for reviewing the patch.

I will update it to TST_NEEDS
wherever required in other tests
too. Thanks for pointing it.

On Mon,
2022-10-17 at 18:20 +0800, Li Wang wrote:
> This Message Is From an External Sender
> This message came from outside your organization.       
> Tarun Sahu <tsahu@linux.ibm.com> wrote:
> 
>  
> > +
> > +static void setup(void)
> > +{
> > +       if (tst_hugepages < 1)
> > +               tst_brk(TCONF, "Not enough hugepages for
> > testing.");
> 
> 
> If we needs at least 1 huge page for testing, the TST_NEEDS will
> be more useful than TST_REQUEST, and do not need to double
> check the hpage numbers anymore.
> 
> 
> TST_REQUEST:
>   It will try the best to reserve available huge pages and return the
> number
>   of available hugepages in tst_hugepages, which may be 0 if
> hugepages are
>   not supported at all.
> 
> TST_NEEDS:
>   This is an enforced requirement, LTP should strictly do hpages
> applying and
>   guarantee the 'HugePages_Free' no less than pages which makes that
> test can
>   use these specified numbers correctly. Otherwise, test exits with
> TCONF if
>   the attempt to reserve hugepages fails or reserves less than
> requested.
> 
> See: 
> https://github.com/linux-test-project/ltp/blob/master/doc/c-test-api.txt#L2009
> 
>  
> > +
> > +       if (!Hopt)
> > +               Hopt = tst_get_tmpdir();
> > +       SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
> > +
> > +       snprintf(hfile, sizeof(hfile), "%s/ltp_hugetlbfile%d",
> > Hopt, getpid());
> > +       hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
> > +}
> > +
> > +static void cleanup(void)
> > +{
> > +       if (fd >= 0)
> > +               SAFE_CLOSE(fd);
> > +       umount2(Hopt, MNT_DETACH);
> > +}
> > +
> > +static struct tst_test test = {
> > +       .needs_root = 1,
> > +       .needs_tmpdir = 1,
> > +       .options = (struct tst_option[]) {
> > +               {"v", &verbose, "Turns on verbose mode"},
> > +               {"H:", &Hopt,   "Location of hugetlbfs, i.e.  -H
> > /var/hugetlbfs"},
> > +               {"s:", &nr_opt, "Set the number of the been
> > allocated hugepages"},
> > +               {}
> > +       },
> > +       .setup = setup,
> > +       .cleanup = cleanup,
> > +       .test_all = run_test,
> > +       .hugepages = {1, TST_REQUEST},
> 
> ^ TST_NEEDS
> 
>  
> > +};
> 
>  
> 


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
