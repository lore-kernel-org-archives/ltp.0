Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E47C4321E
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 08:36:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A9B873CC497
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 09:36:07 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF9E03CC450
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 09:35:56 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3590D1001187
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 09:35:54 +0100 (CET)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2B18PVUe003994; Thu, 1 Dec 2022 08:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=ilqX9q9mWS53nlDD48w9qkuI+5vf+sy1B1LZpf5oxm8=;
 b=NcQNBPQGnA8FywdGn7DZmaCFUBUeymdr8T0u8w40GjMUplJQnwMr4tIAafmcbDe9OwsW
 1qfENOyNX1cMEjOpcojCQ72TMifNw/j8J5iEJ/+tVeYi9pc3cYfj6t/3/jeDGJvDBIyw
 iI0fbiK58evgBAd8b1hh5yK0baRIpislX1Uo4SVIMjc8AEryhnHV8y1srkKQvufrQUFH
 5g3XW4F80fSXFNIfVnW4JCwyZkl1F8Y5VlYY4pZWuCOZk30sAcBP2y4B+tenCpRoKx6X
 NH+0Kz472Qlm7Q6iCZzcBo6FRs0Y9emxXwvUMUz+jrjnG6PsuPDHR8Zn5QHrZx5W3zLH BQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m6rre87mj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Dec 2022 08:35:52 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2B18KQbm005747;
 Thu, 1 Dec 2022 08:35:50 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma06ams.nl.ibm.com with ESMTP id 3m3a2hy2ca-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Dec 2022 08:35:49 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 2B18TFqF2556452
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Dec 2022 08:29:15 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B59564203F;
 Thu,  1 Dec 2022 08:35:46 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 22D1242041;
 Thu,  1 Dec 2022 08:35:45 +0000 (GMT)
Received: from tarunpc.in.ibm.com (unknown [9.199.157.25])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Thu,  1 Dec 2022 08:35:44 +0000 (GMT)
Date: Thu, 1 Dec 2022 14:05:42 +0530
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20221201083542.zw4uwkarntzpz43g@tarunpc.in.ibm.com>
References: <20221120191533.164848-1-tsahu@linux.ibm.com>
 <20221125223740.80580-1-tsahu@linux.ibm.com>
 <Y4YxgIN88g7qWo1R@yuki>
Content-Disposition: inline
In-Reply-To: <Y4YxgIN88g7qWo1R@yuki>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mnmW7hEOb7zfOFjZdfFR1BneBhDydV0a
X-Proofpoint-GUID: mnmW7hEOb7zfOFjZdfFR1BneBhDydV0a
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_04,2022-11-30_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212010057
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/2] Hugetlb: Safe macro for posix_fadvise call
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
Cc: aneesh.kumar@linux.ibm.com, ltp@lists.linux.it, sbhat@linux.ibm.com,
 geetika@linux.ibm.com, vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Nov 29 2022, Cyril Hrubis wrote:
> Hi!
> I did split this patch into two, one that touches tst_test.h and one
> that adds the safe macro and pushed the patchset, thanks.
> 

> The cleanest way how to split changes into patchset is that each patch
> does one logical change and properly explains why the change is needed
> in the commit message too.
>
Ok. I will keep it in mind..
Thanks.
> -- 
> Cyril Hrubis
> chrubis@suse.cz
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
