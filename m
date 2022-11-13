Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52B3C4332F
	for <ltp@archiver.kernel.org>; Sun, 13 Nov 2022 19:04:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D1B93CD341
	for <ltp@archiver.kernel.org>; Sun, 13 Nov 2022 20:03:59 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 276073C816F
 for <ltp@lists.linux.it>; Sun, 13 Nov 2022 20:03:48 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 651F31400430
 for <ltp@lists.linux.it>; Sun, 13 Nov 2022 20:03:46 +0100 (CET)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.5) with ESMTP id
 2ADIuSV1018970; Sun, 13 Nov 2022 19:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=zbndz/r9wp3j0jL0c0hK2jVw4Caja6eL9JE167Sq/do=;
 b=XUZv3MOkSv/y/MeMO01Zwq3ctDBp3yoNXnvFqFFLueDfPuBopNAZR5Y3hn4vt70MYq7i
 ePsDrKKCF4UJvq2GrN1PfrO0HDP7IPNdSXHj73FnlEPTNlzejmCpwQpiPTYijtckkggM
 umFCA0i8cvNW4ZkRqJ+FErLitZa/UIkDp4yR1tVXokvCUlr5TWzCShCxDLdL/ozWvonZ
 Cmxg4Du2iZrOb3WDKGbeB4aCWhfyHPc2ozNmEBIsfNB7V4tvUYc5/M+e8joekEvLHM5R
 rcmskIRjS9ltP9snIW7Mk+zdm2jD8zoY9RxfUG+quTRsuaH5YRv4OxahhvkyPsY8Os7j 7g== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ku6a304bk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 13 Nov 2022 19:03:45 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ADIpg4p005274;
 Sun, 13 Nov 2022 19:03:43 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma06ams.nl.ibm.com with ESMTP id 3kt2rj9m5n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 13 Nov 2022 19:03:43 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 2ADIvkTY50201010
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 13 Nov 2022 18:57:46 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4ACD0A4051;
 Sun, 13 Nov 2022 19:03:40 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 09AE2A4040;
 Sun, 13 Nov 2022 19:03:38 +0000 (GMT)
Received: from tarunpc (unknown [9.43.84.200])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Sun, 13 Nov 2022 19:03:37 +0000 (GMT)
Date: Mon, 14 Nov 2022 00:33:32 +0530
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20221113190332.gyv5t3jvpqps4ug5@tarunpc>
References: <20221108195207.232115-1-tsahu@linux.ibm.com>
 <20221108195207.232115-2-tsahu@linux.ibm.com>
 <Y2unWTTyFK8DS82w@yuki> <20221109212637.haxocrluexxhvktg@tarunpc>
 <Y2y0VzfJwFr0wiwC@yuki> <20221113184438.tmcepansvefom5bk@tarunpc>
Content-Disposition: inline
In-Reply-To: <20221113184438.tmcepansvefom5bk@tarunpc>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zTNxgcdcmapqPCt_qIA8MVUtsYURy2np
X-Proofpoint-GUID: zTNxgcdcmapqPCt_qIA8MVUtsYURy2np
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-13_13,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 suspectscore=0 mlxlogscore=945 clxscore=1015 malwarescore=0 spamscore=0
 mlxscore=0 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211130133
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/5] Hugetlb: Migrating libhugetlbfs counters
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
 vaibhav@linux.ibm.com, ltp@lists.linux.it, mike.kravetz@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Nov 14 2022, Tarun Sahu wrote:
> > I guess that we can also put the map() (touch()) test_counters() unamp()
> > sequence to a do_test() fuction then call it from the for() loop in
> > run_test(). That would make the code a bit cleaner.
> > 
> Instead, I am thinking of a defining a macro like this, 
> 
> #define CHECK_(fun) ({			\
> 		if (fun) {					\
> 				break;				\
> 			}						\
> 		})
> 
> inside test_counters:
> 
> do {
> 	CHECK_(map(...));
> 	CHECK_(touch(...));
> 	CHECK_(unmap(...));
> } while(0)
> 
> inside for loop of run_test:
> 
> CHECK_(map(...));
> CHECK_(test_counters(...));
> CHECK_(unmap(...));
> 
Code will be as clean as the previous, if we can just add
CHECK_ in map, unmap, touch macro definition. like..

#define map(a,b,c,d) CHECK_(map_(a, b, c, d))
> > -- 
> > Cyril Hrubis
> > chrubis@suse.cz
> > 
> > -- 
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
