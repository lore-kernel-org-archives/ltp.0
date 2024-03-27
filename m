Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6D7C47DD9
	for <ltp@archiver.kernel.org>; Wed, 27 Mar 2024 05:24:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 52D183D17FD
	for <ltp@archiver.kernel.org>; Wed, 27 Mar 2024 06:24:18 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B2AD3CD2B8
 for <ltp@lists.linux.it>; Wed, 27 Mar 2024 06:23:59 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=geetika@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 43327608A88
 for <ltp@lists.linux.it>; Wed, 27 Mar 2024 06:23:56 +0100 (CET)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42R3Mwrc021147; Wed, 27 Mar 2024 05:23:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=hwGraWDMeRNCW3vc+81fIlRabpiqvpwXa7hmybKNg3g=;
 b=ickzv8xIHIUPnUODSORWv2P0Ncqf1wGlr+XytUbXhGHUZLSqjEiCYV5eDiE2PCSLn34v
 C59nykE8Z0vGG0oE7VvNsQlHIvt+1HmD0rzx74XXtbRf23zBWsgm+sekmuCExsqkXzsN
 XZzqNcSfsZpkOH3A2jWdHrDOdBUgBWtBn/8Rm1XjTylcOKifpGWecX1fHnoRPQg8iawh
 E0iDNKgqioV7qwxRgZTm4LZcZOoPZIwbMOmudAI1AGbZnxmgH0AjBRRYdcGdgocMCl70
 VxRevXpQizj/AIHvn7axjX8nJ3uab3IJBgHVPY+67hwZq7zOIIFQIh/wyMuSlHOYkvxH ww== 
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x4bg3r5h3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Mar 2024 05:23:54 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42R30BrT016605; Wed, 27 Mar 2024 05:22:15 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x29du4x0m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Mar 2024 05:22:15 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42R5MCuS42402096
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Mar 2024 05:22:14 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3370420040;
 Wed, 27 Mar 2024 05:22:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9FBC62004E;
 Wed, 27 Mar 2024 05:22:11 +0000 (GMT)
Received: from [9.43.51.185] (unknown [9.43.51.185])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 27 Mar 2024 05:22:11 +0000 (GMT)
Message-ID: <9e339bbd-0fda-4b44-bbcf-20c0303f494a@linux.ibm.com>
Date: Wed, 27 Mar 2024 10:52:10 +0530
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20230928074624.67065-1-geetika@linux.ibm.com>
 <20231128112511.GB364870@pevik>
Content-Language: en-US
From: Geetika M <geetika@linux.ibm.com>
In-Reply-To: <20231128112511.GB364870@pevik>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: njP3T33_UDMztoRbURxlStkUEGRba_h1
X-Proofpoint-ORIG-GUID: njP3T33_UDMztoRbURxlStkUEGRba_h1
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_02,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011
 mlxscore=0 impostorscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2403210000 definitions=main-2403270034
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Hugetlb: Migrating libhugetlbfs test
 truncate_reserve_wraparound.c
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


On 28/11/23 4:55 pm, Petr Vorel wrote:
> Hi,
>
> Please have look at my comments at your colleague patch [1] [2], these changes
> apply a lot for your patches as well.
>
> [1] https://lore.kernel.org/ltp/20231128111024.GA364870@pevik/
> [2] https://lore.kernel.org/ltp/20231128112254.GA367506@pevik/

I will have a look at both of these and apply the changes that apply to 
this
testcase and send the next version.

> ...
>> +++ b/runtest/hugetlb
>> @@ -35,6 +35,7 @@ hugemmap29 hugemmap29
>>   hugemmap30 hugemmap30
>>   hugemmap31 hugemmap31
>>   hugemmap32 hugemmap32
>> +hugemmap38 hugemmap38
> nit: Why not hugemmap34? (your colleague used hugemmap33 for his patch [1].
We already have:

hugemmap34 : 
https://lore.kernel.org/ltp/20230913082214.8453-1-samir@linux.vnet.ibm.com/
hugemmap36 : 
https://lore.kernel.org/ltp/20230912064126.3350-1-samir@linux.vnet.ibm.com/
hugemmap35 : 
https://lore.kernel.org/all/20230908121135.245296-1-sachinpb@linux.vnet.ibm.com/
hugemmap37 : 
https://lore.kernel.org/ltp/20230929075435.72172-1-geetika@linux.ibm.com/

Hence hugemmap38!
>>   hugemmap05_1 hugemmap05 -m
>>   hugemmap05_2 hugemmap05 -s
>>   hugemmap05_3 hugemmap05 -s -m
> ...
>
> Kind regards,
> Petr

Thanks & Regards,
Geetika


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
