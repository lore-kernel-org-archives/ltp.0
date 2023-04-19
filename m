Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BADC4C77B73
	for <ltp@archiver.kernel.org>; Wed, 19 Apr 2023 18:00:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F7183CC020
	for <ltp@archiver.kernel.org>; Wed, 19 Apr 2023 20:00:43 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B55AC3CBFF5
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 20:00:33 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 890EB600681
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 20:00:32 +0200 (CEST)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 33JGei0Z011225; Wed, 19 Apr 2023 18:00:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=v3siQ0Pwr1AZ6j3THB5TwuYPtJ5Qp6iWcaB9I/b0SwY=;
 b=N0jiLdrQdI7oRJ1N3kFvA7JYvQOhTCHsm+yQ3GIWXYapRY4oaJLu/qTRI557DcgjH1lV
 fbszt7TmQ5XU9UxBmR7Gu4QNJy5huhOwkkHBlSD7xJFRdNqMK2ul183piRAoPEPRmjxs
 Qaejd5+cCKGRpHN5pdQr/YA7bUNdVRZXxk2VCRY8gJ7tPOdR6E58V2EWE/O3hu32tfKX
 SJJLHVtGnxjBvJ69W46QW83SJMgpn03G5lzGV8GT54PHoKE+X4wWZBCJ6aJRT89vesL7
 qK6CF3r2CUJwBj4D+dwjS/R5OWxgbsKSZFsQibeteY37hhJeeMVcvuqlttmv2pOAbPXk Qg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q1q36q1p6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Apr 2023 18:00:27 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33INvwqb004748;
 Wed, 19 Apr 2023 18:00:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3pykj6jw72-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Apr 2023 18:00:24 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 33JI0MUM26215064
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Apr 2023 18:00:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 065152004F;
 Wed, 19 Apr 2023 18:00:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5604A20043;
 Wed, 19 Apr 2023 18:00:20 +0000 (GMT)
Received: from tarunpc (unknown [9.43.77.173])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 19 Apr 2023 18:00:19 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Avinesh Kumar <akumar@suse.de>
In-Reply-To: <10996503.sxSfETX4zk@localhost>
References: <20230419114144.1219505-1-tsahu@linux.ibm.com>
 <10996503.sxSfETX4zk@localhost>
Date: Wed, 19 Apr 2023 23:30:15 +0530
Message-ID: <87r0sfu500.fsf@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iSqnybx-422pBEYCyOqtdbZKQlcdHLja
X-Proofpoint-ORIG-GUID: iSqnybx-422pBEYCyOqtdbZKQlcdHLja
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-19_12,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=927 bulkscore=0
 phishscore=0 mlxscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304190155
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Hugetlb: Test to detect bug with freeing
 gigantic hugetlb pages
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


> Hi Tarun,
>
> You are missing the runtest/hugetlb and .gitignore entries for this new test.
>
Hi Avinesh,

Thanks for pointing this out.

Will soon send the update.

~Tarun

>
> --
> Regards,
> Avinesh
>
>
>
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
