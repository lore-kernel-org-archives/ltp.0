Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60ADCD13CF
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 05:55:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 20C183C3223
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 07:55:49 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C7FA3C3050
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 07:55:31 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=geetika@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 980BF100049E
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 07:55:28 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4825otUn026148
 for <ltp@lists.linux.it>; Mon, 2 Sep 2024 05:55:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-type:message-id:date:to:from:subject:cc:mime-version; s=
 pp1; bh=krh768+41BmdB1qqJRBCO8vd2rWstKKO7UFE0VpVpoQ=; b=iwpycGGO
 Ga/zMiS/03NkyiMtf5WOtIahkos6dDgySRkMGlFUTHMSkJEy8sNLF9s9lXEMnnKL
 tv+qVkXyxsU6YMtwcWdWefQm3Too/GAjCHM2CFToGb+35SSPhFD5gIxlDq5VVl3D
 nIsYWfVHwRSlrno3KDNlFt84diExMQoQxm6bfPvaVMgyztT6uTyHZGxNWYlxRmec
 zYmtTr3VRkSrQyFbpNgK2zP1PJ9MT0pUXuh+1vfN3GReBYGDs3BlzP109btp5/ML
 iPakq0Ut31dpE2JFfT0hmMaC0oucgJARpbFrPM2vkwj/w9spySkddToczc+ZSj8V
 dvhTaMJ0TDt5tg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btp97b8y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 02 Sep 2024 05:55:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4825Di2g009226
 for <ltp@lists.linux.it>; Mon, 2 Sep 2024 05:55:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41cg73cfad-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 02 Sep 2024 05:55:25 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4825tMhA39190980
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Sep 2024 05:55:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 14DF620043;
 Mon,  2 Sep 2024 05:55:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1340520040;
 Mon,  2 Sep 2024 05:55:21 +0000 (GMT)
Received: from [9.43.4.51] (unknown [9.43.4.51])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  2 Sep 2024 05:55:20 +0000 (GMT)
Message-ID: <bf5ed5dc-805c-4825-898f-1e4d3d280f2c@linux.ibm.com>
Date: Mon, 2 Sep 2024 11:25:20 +0530
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ltp@lists.linux.it
From: Geetika M <geetika@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uF3aupFOC5KBCTmb32WRf5LvpdYN7rC5
X-Proofpoint-ORIG-GUID: uF3aupFOC5KBCTmb32WRf5LvpdYN7rC5
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-09-01_06,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0
 malwarescore=0 mlxlogscore=708 adultscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409020045
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] Acceptance Status of libhugetlbfs Patches
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
Cc: pavrampu@linux.ibm.com, pavithra.visweswara@ibm.com, sachinp@linux.ibm.com,
 Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


Hello Maintainer(s),

I hope this message finds you well.

I am writing on behalf of my team regarding the patches we recently 
submitted to the LTP mailing list. We wanted to follow up and inquire 
about the status of these patches and their potential integration into 
the upstream project.

For your reference, here are the few links to the patches we have sent:

*[LTP] [PATCH v2] [PATCH] Hugetlb: Migrating libhugetlbfs shm-perms 
<https://lore.kernel.org/ltp/20240510141020.189065-1-spoorthy@linux.ibm.com/>*

*[LTP] [PATCH v4] Migrating the libhugetlbfs/testcases/shm-gettest.c 
test 
<https://lore.kernel.org/ltp/20240515092456.3180-1-sachinpb@linux.ibm.com/>*

*[LTP] [PATCH v3] Hugetlb: Migrating libhugetlbfs test 
truncate_reserve_wraparound.c 
<https://lore.kernel.org/ltp/20240802061342.8540-1-geetika@linux.ibm.com/>*

*[LTP] [PATCH v4] Migrating the 
libhugetlbfs/testcases/stack_grow_into_huge.c test 
<https://lore.kernel.org/ltp/20240816103317.127972-1-samir@linux.vnet.ibm.com/> 
**[LTP] [PATCH v3] Migrating the 
libhugetlbfs/testcases/truncate_sigbus_versus_oom.c test 
<https://lore.kernel.org/ltp/20240407095243.65152-1-samir@linux.vnet.ibm.com/> 
**Re: [LTP] [PATCH v2] Migrating the 
libhugetlbfs/testcases/truncate_above_4GB.c test 
<https://lore.kernel.org/ltp/7c9bf212-bbd8-4889-ade9-9798cce3a29c@linux.ibm.com/>*

We would greatly appreciate any updates you could provide on when these 
might be reviewed and merged. Please let us know if there are any 
additional steps we need to take or if further modifications are required.

Thank you very much for your time and assistance.

Best Regards,
Geetika M

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
