Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6536BC4345F
	for <ltp@archiver.kernel.org>; Tue, 16 Apr 2024 08:12:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1DBB73CFA94
	for <ltp@archiver.kernel.org>; Tue, 16 Apr 2024 10:12:09 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7D713CF78D
 for <ltp@lists.linux.it>; Tue, 16 Apr 2024 10:11:53 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=shirisha@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8764B1001F4C
 for <ltp@lists.linux.it>; Tue, 16 Apr 2024 10:11:51 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43G82M6I016708; Tue, 16 Apr 2024 08:11:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Y6X3cNqecHz1qLfdaAGEWslIWHXwoGjmYkhFlVkZr8w=;
 b=GleyJnJgAbKXGbynvm/+d+uoTJjj7orTKy7+IxZYFce+8ZfbE9p502EVK41W6Uzywc6m
 x97OfedsRMKmnpTSCSWXrEn5VpmH+ThwjWXg5+eWIT+sXC1xOmdjUKeL7E3wHxaBVIxb
 gQxd5+8ikwijjOPrY86RqyosN330S+r1KbD4RGnVEGzk5GWOvis7nCFGDEE59vcPQOsZ
 1fMAaRlhrbBfYjvkVJqwkYReD29QBx3bUSdi1raMYNpgb6oxPftYnXc7AMn9BhzvLXrZ
 J55bzYHj0wTmO/9Lmvli8Pw7miXQ7qd5y+6i6xYrMPvN/XzMNWRy2CyvvA67JR9ZwLkD 8Q== 
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xhnf9r0qc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Apr 2024 08:11:49 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43G5NW84027323; Tue, 16 Apr 2024 08:11:48 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xg4ryw3hc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Apr 2024 08:11:48 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43G8Biiv41353588
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Apr 2024 08:11:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4AA6F2004F;
 Tue, 16 Apr 2024 08:11:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9B0C520043;
 Tue, 16 Apr 2024 08:11:43 +0000 (GMT)
Received: from li-d12addcc-2792-11b2-a85c-bd8df30615ab.ibm.com (unknown
 [9.199.152.158])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Apr 2024 08:11:43 +0000 (GMT)
Message-ID: <8125158bc5b44f8cc3328939d6f321008064a0fd.camel@linux.ibm.com>
From: Shirisha ganta <shirisha@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 16 Apr 2024 13:41:42 +0530
In-Reply-To: <20240219221811.GC1067220@pevik>
References: <20231213084753.61762-1-shirisha@linux.ibm.com>
 <20240219221811.GC1067220@pevik>
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: F8jwaD8LtY7l5L2GvudgMB1DYnBa70h_
X-Proofpoint-GUID: F8jwaD8LtY7l5L2GvudgMB1DYnBa70h_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_06,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 adultscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 clxscore=1011 lowpriorityscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404160049
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add hugemmap41(Migrating the
 libhugetlbfs/testcases/slbpacaflush.c test)
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, 2024-02-19 at 23:18 +0100, Petr Vorel wrote:
> Hi Shirisha,
> 
> > +void check_online_cpus(int online_cpus[], int nr_cpus_needed)
> > +{
> > +	char cpu_state, path_buf[64];
> > +	int total_cpus, cpu_idx, fd, ret, i;
> > +
> > +	total_cpus = get_nprocs_conf();
> > +	cpu_idx = 0;
> > +
> > +	if (get_nprocs() < nr_cpus_needed)
> > +		tst_res(TFAIL, "Atleast online %d cpus are required",
> > nr_cpus_needed);
> s/Atleast/At least/
> (or better: "minimum %d online cpus" ..., but I'm not a native
> speaker.)
will take care in V2
> 
> Also test should exit when not enough online CPU, right? (it's a test
> requirement not a subject of testing). Therefore tst_brk(TCONF, ...)
> should be
> used instead of tst_res(TFAIL).
will take care in V2
> 
> And shouldn't this be a setup function (i.e. run only once, before
> test starts -
> test itself can be run more times, eg 3x with -i3).
I think not because of successive iterations the online cpus state
might change
> 
> > +
> > +	for (i = 0; i < total_cpus && cpu_idx < nr_cpus_needed; i++) {
> > +		errno = 0;
> > +		sprintf(path_buf, SYSFS_CPU_ONLINE_FMT, i);
> > +		fd = open(path_buf, O_RDONLY);
> > +		if (fd < 0) {
> > +			/* If 'online' is absent, the cpu cannot be
> > offlined */
> > +			if (errno == ENOENT) {
> > +				online_cpus[cpu_idx] = i;
> > +				cpu_idx++;
> > +				continue;
> > +			} else {
> > +				tst_res(TFAIL, "Unable to open %s: %s",
> > path_buf,
> > +				     strerror(errno));
> > +			}
> > +		}
> > +
> > +		ret = read(fd, &cpu_state, 1);
> > +		if (ret < 1)
> > +			tst_res(TFAIL, "Unable to read %s: %s",
> > path_buf,
> > +			     strerror(errno));
> > +
> > +		if (cpu_state == '1') {
> > +			online_cpus[cpu_idx] = i;
> > +			cpu_idx++;
> > +		}
> > +
> > +		if (fd >= 0)
> > +			SAFE_CLOSE(fd);
> > +	}
> > +
> > +	if (cpu_idx < nr_cpus_needed)
> > +		tst_res(TFAIL, "Atleast %d online cpus were not found",
> > nr_cpus_needed);
> Also here tst_brk(TCONF, ...)
will take care in V2
> > +}
> 
> Kind regards,
> Petr


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
