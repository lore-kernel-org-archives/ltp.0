Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95CC9C4332F
	for <ltp@archiver.kernel.org>; Mon, 26 Dec 2022 07:55:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A4363CB881
	for <ltp@archiver.kernel.org>; Mon, 26 Dec 2022 08:55:20 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DF1283C217C
 for <ltp@lists.linux.it>; Mon, 26 Dec 2022 08:55:09 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C641510004AF
 for <ltp@lists.linux.it>; Mon, 26 Dec 2022 08:55:06 +0100 (CET)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2BQ7DIs4004927; Mon, 26 Dec 2022 07:55:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=fARPImHxzIEiDx5As9u/u1cnIUWlIh9YFqwC15emrFw=;
 b=sAqG6PqkzvEE6qJysuOENjMJmasHxm87EOjdRgZile+XQIkmGb6RMJPcdeIa8KPjlu8h
 jf6b93qsnnsoDscPwmy2FTyEQkeAf4RYByF2LZpAEX5sJUFKT2W9j+4I57cQg2cTddpB
 dV5wI6nRfSbwAJy8OGs3+qeuEvNwiR2VTTAyv8f8N001F0kyLChvctDEsWpj2UYZQXsb
 b0tev0OmRCO7MvC/GKeUNqaAFEu0WYm7/rSE3swmXUE0NFhlZ3LwApx8qN6oK2x5Tw9t
 DO4HF26SxYmBV8uDXTB2HS2j5KhVqOdj8VC3g1oTYf6nKd4xZyhh1aFPwhDv1iaLKHDK Vw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mq71h1449-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Dec 2022 07:55:05 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BQ7sCAj016594;
 Mon, 26 Dec 2022 07:55:04 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mq71h143u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Dec 2022 07:55:04 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BPCc9Ro025847;
 Mon, 26 Dec 2022 07:36:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3mns269gtt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Dec 2022 07:36:22 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2BQ7aJK024248864
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Dec 2022 07:36:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A6972004D;
 Mon, 26 Dec 2022 07:36:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5BE7920040;
 Mon, 26 Dec 2022 07:36:16 +0000 (GMT)
Received: from tarunpc (unknown [9.43.13.185])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 26 Dec 2022 07:36:16 +0000 (GMT)
Date: Mon, 26 Dec 2022 13:05:46 +0530
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Li Wang <liwang@redhat.com>
Message-ID: <20221226073546.md4doiwok4vadq3i@tarunpc>
References: <20221225154213.84183-1-tsahu@linux.ibm.com>
 <20221225154213.84183-3-tsahu@linux.ibm.com>
 <CAEemH2dB6RqzSnmN2CH0f1ZtG5sO9T2-RmDSg4cOR2-m-12b7g@mail.gmail.com>
Content-Disposition: inline
In-Reply-To: <CAEemH2dB6RqzSnmN2CH0f1ZtG5sO9T2-RmDSg4cOR2-m-12b7g@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ybuBWZsfoN1KsaqnXm7mAHm6suWco8Cu
X-Proofpoint-ORIG-GUID: GmiTJcwvuQ8e_yAw8NQqDi_gg1AK4p3S
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-26_04,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0
 spamscore=0 clxscore=1015 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212260066
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 02/13] Hugetlb: Migrating libhugetlbfs mmap-cow
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
> > +static void do_work(int thread, size_t size, int fd)
> > +{
> > +       char *addr;
> > +       size_t i;
> > +       char pattern = thread+65;
> > +
> > +       addr = SAFE_MMAP(NULL, size, PROT_READ|PROT_WRITE, MAP_PRIVATE,
> > fd, 0);
> > +
> > +       tst_res(TINFO, "Thread %d (pid %d): Mapped at address %p",
> > +              thread, getpid(), addr);
> > +
> > +       for (i = 0; i < size; i++)
> > +               memcpy((char *)addr+i, &pattern, 1);
> > +
> > +       if (msync(addr, size, MS_SYNC))
> > +               tst_brk(TBROK|TERRNO, "Thread %d (pid %d): msync() failed",
> > +                               thread, getpid());
> > +
> > +       for (i = 0; i < size; i++)
> > +               if (addr[i] != pattern) {
> > +                       tst_res(TFAIL, "thread %d (pid: %d): Corruption at
> > %p; "
> > +                                  "Got %c, Expected %c", thread, getpid(),
> > +                                  &addr[i], addr[i], pattern);
> > +                       goto cleanup;
> > +               }
> > +       tst_res(TINFO, "Thread %d (pid %d): Pattern verified",
> > +                       thread, getpid());
> >
> 
> Maybe combining the address output with the content of patterns is better?
> 
> i.e.
> 
> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c
> @@ -45,9 +45,6 @@ static void do_work(int thread, size_t size, int fd)
> 
>         addr = SAFE_MMAP(NULL, size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd,
> 0);
> 
> -       tst_res(TINFO, "Thread %d (pid %d): Mapped at address %p",
> -              thread, getpid(), addr);
> -
>         for (i = 0; i < size; i++)
>                 memcpy((char *)addr+i, &pattern, 1);
> 
> @@ -62,8 +59,8 @@ static void do_work(int thread, size_t size, int fd)
>                                    &addr[i], addr[i], pattern);
>                         goto cleanup;
>                 }
> -       tst_res(TINFO, "Thread %d (pid %d): Pattern verified",
> -                       thread, getpid());
> +       tst_res(TINFO, "Thread %d (pid %d): Pattern %c verified at address
> %p",
> +                       thread, getpid(), pattern, addr);
> 
>  cleanup:
>         SAFE_MUNMAP(addr, size);
> 
In case of failure, this verified comment will not get printed.
In case of success, I dont think it matters to show the content of pattern.
> 
> 
> > +
> > +cleanup:
> > +       SAFE_MUNMAP(addr, size);
> > +       exit(0);
> > +}
> > +
> > +static void run_test(void)
> > +{
> > +       char *addr;
> > +       size_t size, itr;
> > +       int i, pid;
> > +       pid_t *wait_list;
> > +
> > +       wait_list = SAFE_MALLOC(THREADS * sizeof(pid_t));
> > +       size = (NR_HUGEPAGES / (THREADS+1)) * hpage_size;
> > +
> > +
> > +       /* First, mmap the file with MAP_SHARED and fill with data
> > +        * If this is not done, then the fault handler will not be
> > +        * called in the kernel since private mappings will be
> > +        * created for the children at prefault time.
> > +        */
> > +       addr = SAFE_MMAP(NULL, size, PROT_READ|PROT_WRITE, MAP_SHARED, fd,
> > 0);
> > +
> > +       for (itr = 0; itr < size; itr += 8)
> > +               memcpy(addr+itr, "deadbeef", 8);
> > +
> > +       for (i = 0; i < THREADS; i++) {
> > +               pid = SAFE_FORK();
> > +
> > +               if (pid == 0)
> > +                       do_work(i, size, fd);
> > +
> > +               wait_list[i] = pid;
> > +       }
> > +       tst_reap_children();
> > +
> > +       SAFE_MUNMAP(addr, size);
> > +       free(wait_list);
> > +       tst_res(TPASS, "mmap COW working as expected.");
> > +}
> > +
> > +static void setup(void)
> > +{
> > +       hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
> >
> 
> We do have a dedicated function named tst_get_hugepage_size();
> could be used for getting huge page size.
Oh right! I could have used it in all other previous tests too.
Thanks for pointing this, Will take care of it in next revision.
> 
> The rest part looks good to me.
> 
> Reviewed-by: Li Wang <liwang@redhat.com>
> 
> 
> 
> > +       fd = tst_creat_unlinked(MNTPOINT, 0);
> > +}
> > +
> > +static void cleanup(void)
> > +{
> > +       if (fd >= 1)
> > +               SAFE_CLOSE(fd);
> > +}
> > +
> > +static struct tst_test test = {
> > +       .needs_root = 1,
> > +       .mntpoint = MNTPOINT,
> > +       .needs_hugetlbfs = 1,
> > +       .needs_tmpdir = 1,
> > +       .forks_child = 1,
> > +       .setup = setup,
> > +       .cleanup = cleanup,
> > +       .test_all = run_test,
> > +       .hugepages = {NR_HUGEPAGES, TST_NEEDS},
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
