Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE918C4332F
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 05:01:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED4183CBE7F
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 06:01:16 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FDF63C1C26
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 06:01:04 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 13377200915
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 06:01:02 +0100 (CET)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2BD4DFZ9008492; Tue, 13 Dec 2022 05:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=AU8dJhKyK/T/k6OwkzxSP4D+Fm6yHMGMlKaLF64kay8=;
 b=XZB20InJda/1MBxc3hiU4bfh1wBlx8IMzKAb2VafhLQiIBTlF+phYHvbFWQad3Lq5yle
 yJMV2x8+XfGV0FbUPqiqwC0u9WSi53zJyySIm9QRmTeUzqmxRbb2hzeR3okti9/pR2SQ
 pzQNH3wT3+gjTG+7hPpYLaYPUlf6T1oLFGNDOhHPsBgYg0hXcADAogP0g0K3JrkEWrNR
 Rm01LwtmuJwFyODFZYcscTODJRHEcSFBYKrwRLjslhYoR/apM3FgiQbizz4M53SWphj0
 1FjkLpoIFPlEsEtsLSNtzSgrJchLOwC27GE1vtkL2LBcih7xELgToP8ynjkAix/RgDEA vg== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mej5w8wd5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Dec 2022 05:01:00 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCAi7bH018218;
 Tue, 13 Dec 2022 05:00:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3mchr62kdb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Dec 2022 05:00:58 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2BD50s0n39715276
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Dec 2022 05:00:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E048B2004F;
 Tue, 13 Dec 2022 05:00:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 444D920040;
 Tue, 13 Dec 2022 05:00:53 +0000 (GMT)
Received: from tarunpc.in.ibm.com (unknown [9.199.157.25])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 13 Dec 2022 05:00:53 +0000 (GMT)
Date: Tue, 13 Dec 2022 10:30:50 +0530
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <20221213050050.o5irjv56vjbpzaef@tarunpc.in.ibm.com>
References: <20221201122844.142062-1-tsahu@linux.ibm.com>
 <87edt4u112.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87edt4u112.fsf@suse.de>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9dpQjtr_OtTMQmUqKCy-8R3s6luu1cyl
X-Proofpoint-ORIG-GUID: 9dpQjtr_OtTMQmUqKCy-8R3s6luu1cyl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_01,2022-12-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0
 adultscore=0 phishscore=0 mlxlogscore=735 clxscore=1015 malwarescore=0
 spamscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212130041
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/8][PART 3] Hugetlb:Migrating the libhugetlbfs
 tests
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
Cc: aneesh.kumar@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
 ltp@lists.linux.it, geetika@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Dec 12 2022, Richard Palethorpe wrote:
> Hello,
> 
> Setting the rest of this patch serious to "changes requested" in
> patchwork. EVen though I have added reviewed tags to most of the tests,
> I don't want to merge them out of sequence.
> 
> Also please assume that any comments that were made about previous tests
> may also apply to those left. I did not check these very carefully.
> 
Thanks, for reviewing it, Richard.
Sure, Will update and post updated version.

Thanks
Tarun

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
