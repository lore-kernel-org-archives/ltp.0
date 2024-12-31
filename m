Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1953E77188
	for <ltp@archiver.kernel.org>; Tue, 31 Dec 2024 03:44:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5EB803F0299
	for <ltp@archiver.kernel.org>; Tue, 31 Dec 2024 04:44:00 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 146FA3DB768
 for <ltp@lists.linux.it>; Tue, 31 Dec 2024 04:43:44 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 634E3101C58E
 for <ltp@lists.linux.it>; Tue, 31 Dec 2024 04:43:42 +0100 (CET)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BUNwUY2024058;
 Tue, 31 Dec 2024 03:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=YpKVFy
 GMBfIPOZWg4R8WEyPbBwaaIwFcma+92rf1Fsw=; b=UWm6AWcmnKXQJ5l+mI3Poi
 Los8ZedfjhiMFWfqj8AaSkUXWsucf1O22RrdMXxNMCYc/mhqDQW6zUxKSF6NJUpK
 7IthrOJkpv08nPW+A9CBuKlRBeeHp3srd6dCQUvsF3tp1kFJfN4DqWwE5Mp4KIXT
 6K3Qe51Bbdpe9dsSj1sRAuCAaNHpalrswAm4sNW1ta0djLIVddzNIGU8HIOsBZQe
 AMVNIBEp0117AZy7DxWKqYxUqri088sY2tTZ4UiYZlz7Gq19ajC6SNTL4Z9ktXch
 wSnVtTT/l8NYxS9DNkQmY8QIAClTGjuZCc36lwNwFc+yH+Hcq+5BDjBTOwOgvGUg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43v5nh8gwp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Dec 2024 03:43:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BV0nbPv027055;
 Tue, 31 Dec 2024 03:43:39 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43txc1rd5t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Dec 2024 03:43:39 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BV3hdSk30868046
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 31 Dec 2024 03:43:39 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 138DB5805A;
 Tue, 31 Dec 2024 03:43:39 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 99C2F58054;
 Tue, 31 Dec 2024 03:43:38 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.61.96.225]) by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 31 Dec 2024 03:43:38 +0000 (GMT)
Message-ID: <35af7de88f6961817a9df23c55104d20c32d2680.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Date: Mon, 30 Dec 2024 22:43:38 -0500
In-Reply-To: <20241213222014.1580991-7-pvorel@suse.cz>
References: <20241213222014.1580991-1-pvorel@suse.cz>
 <20241213222014.1580991-7-pvorel@suse.cz>
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tsqu5O78B3Ou64dEJdY-YoxMBY2hxBjD
X-Proofpoint-GUID: tsqu5O78B3Ou64dEJdY-YoxMBY2hxBjD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0
 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412310027
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 6/8] IMA: Add example policy for
 ima_violations.sh
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

Hi Petr,

On Fri, 2024-12-13 at 23:20 +0100, Petr Vorel wrote:
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  .../integrity/ima/datafiles/ima_violations/violations.policy     | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_violations/violations.policy
> 
> diff --git a/testcases/kernel/security/integrity/ima/datafiles/ima_violations/violations.policy b/testcases/kernel/security/integrity/ima/datafiles/ima_violations/violations.policy
> new file mode 100644
> index 0000000000..5734c7617f
> --- /dev/null
> +++ b/testcases/kernel/security/integrity/ima/datafiles/ima_violations/violations.policy
> @@ -0,0 +1 @@
> +func=FILE_CHECK

"[PATCH v2 1/8] IMA: Add TCB policy as an example for ima_measurements.sh"
contains two rules to measure files opened by root on file open.

measure func=FILE_CHECK mask=^MAY_READ euid=0
measure func=FILE_CHECK mask=^MAY_READ uid=0

If the 'tcb' or equivalent policy is loaded, there is no need to load another
policy rule. 

Thanks,

Mimi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
