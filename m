Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1625EC02192
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 15:46:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 40D9F3C8EF8
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 16:46:30 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 83A333C8E9C
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 16:46:12 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 097871000D58
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 16:46:11 +0100 (CET)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513F5NRj013659;
 Mon, 3 Feb 2025 15:46:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=jfqYp3
 36tgJfmanRiwA983qSFPBmw9Bio0gNkxBaUMQ=; b=lNt2InHPrMZOy2ay8Kv094
 uH/MY0+K37BJ4v4hgBaiyu7M0S+kPZ7LEI1SAKoKuF2jYpKtRxLNhm5aO3ePrjfe
 4vu3fZUPcFwAe8NcBnRRnYvs2BUKNNkbBCiFwwPYrv4KjJ7XUSQBXnn20G+fhlUE
 CpZBNJygSJdf+CiV2UPgDPku27yxpZg/vePoqfJOX6bp/RN86fkXCdMzZCQrbPCG
 UQtBy5srQmqFIrOBHxCb8g5nNOJ1+9RBCZ0jPSAbpPjCgKkLg/FagGa4bLPj2dht
 8UprQ2bvn/0SjdKTNuk0ZbX2vMzyDFo17gLxi4jhu+nZjfY8vLyvzM5CvmH09UTw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44jqm7avg1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Feb 2025 15:46:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 513DBEGg021483;
 Mon, 3 Feb 2025 15:46:08 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44j0n16q3t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Feb 2025 15:46:08 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 513Fk7FQ27460202
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Feb 2025 15:46:08 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B848958063;
 Mon,  3 Feb 2025 15:46:07 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7216858052;
 Mon,  3 Feb 2025 15:46:07 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.61.83.5]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Feb 2025 15:46:07 +0000 (GMT)
Message-ID: <236770773858ed5e619f0a45ed8f2e103e5da9c8.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Date: Mon, 03 Feb 2025 10:46:07 -0500
In-Reply-To: <52d6a8c168215e6dafe567b37bf5ac65e3b300eb.camel@linux.ibm.com>
References: <20250114112915.610297-1-pvorel@suse.cz>
 <20250114112915.610297-3-pvorel@suse.cz>
 <52d6a8c168215e6dafe567b37bf5ac65e3b300eb.camel@linux.ibm.com>
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: e-u09LBIrHWITJk6nsB14sQtQt0VvEBF
X-Proofpoint-ORIG-GUID: e-u09LBIrHWITJk6nsB14sQtQt0VvEBF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_06,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=977 bulkscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502030114
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 02/10] IMA: Add TCB policy as an example for
 ima_measurements.sh
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
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


> > diff --git
> > a/testcases/kernel/security/integrity/ima/datafiles/ima_measurements/tcb.policy
> > b/testcases/kernel/security/integrity/ima/datafiles/ima_measurements/tcb.policy
> > new file mode 100644
> > index 0000000000..1e4a932bf0
> > --- /dev/null
> > +++
> > b/testcases/kernel/security/integrity/ima/datafiles/ima_measurements/tcb.policy
> > @@ -0,0 +1,20 @@
> > +dont_measure fsmagic=0x9fa0
> > +dont_measure fsmagic=0x62656572
> > +dont_measure fsmagic=0x64626720
> > +dont_measure fsmagic=0x1021994 func=FILE_CHECK

Petr, to avoid test failures datafiles/ima_policy/measure.policy should be similarly
constrained.

thanks,

Mimi

> > +dont_measure fsmagic=0x1cd1
> > +dont_measure fsmagic=0x42494e4d
> > +dont_measure fsmagic=0x73636673
> > +dont_measure fsmagic=0xf97cff8c
> > +dont_measure fsmagic=0x43415d53
> > +dont_measure fsmagic=0x27e0eb
> > +dont_measure fsmagic=0x63677270
> > +dont_measure fsmagic=0x6e736673
> > +dont_measure fsmagic=0xde5e81e4
> > +measure func=MMAP_CHECK mask=MAY_EXEC
> > +measure func=BPRM_CHECK mask=MAY_EXEC
> > +measure func=FILE_CHECK mask=^MAY_READ euid=0
> > +measure func=FILE_CHECK mask=^MAY_READ uid=0
> > +measure func=MODULE_CHECK
> > +measure func=FIRMWARE_CHECK
> > +measure func=POLICY_CHECK
> 
> 


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
