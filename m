Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09705C05027
	for <ltp@archiver.kernel.org>; Fri, 10 Feb 2023 22:05:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8200B3CC094
	for <ltp@archiver.kernel.org>; Fri, 10 Feb 2023 23:05:08 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA5093C2A67
 for <ltp@lists.linux.it>; Fri, 10 Feb 2023 23:04:56 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 750E81000EC3
 for <ltp@lists.linux.it>; Fri, 10 Feb 2023 23:04:54 +0100 (CET)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 31ALn6I0012906; Fri, 10 Feb 2023 22:04:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=iYRngjzocs/y5gUM/U5FLORdEsvwKWr5rv/2ege2z5M=;
 b=Mja7KMmnZ8lAVlgP8rgy9YmdeL0un52kDbYBIC6RKFFpnp0Z5DTP1uHnG7mZHsM4s1Zh
 scWz/PQh+JK7cREd8tpr9IjnRJXD4WEiWHIke7Tmi3XtamdMtGRs3vvMZNClqpWZSJpZ
 gjW4yMbMaBNiM7XO3uueAZY8/uhDrwXWkm1Xx7N1PPYruZe7GYu9FYsSt9asU88xoX4i
 0O036HRaNYlBsNlP+cfe5KI3UMULEFXbodXNA9wUg3FAlDOgBE/Vzq09aqQmukrjk/2g
 dbwN4evi34xjsZM2LtoY0fm1B9WZgF0JbauAaZ6dmGXP7hU4+SDtyXBiopeD9n4vvWJ4 Zw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnx6089jw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Feb 2023 22:04:52 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31A86CX5001846;
 Fri, 10 Feb 2023 22:04:51 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3nhf06qywj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Feb 2023 22:04:50 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 31AM4mIn20644588
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Feb 2023 22:04:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A6762004B;
 Fri, 10 Feb 2023 22:04:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D7DE420040;
 Fri, 10 Feb 2023 22:04:46 +0000 (GMT)
Received: from tarunpc (unknown [9.43.90.5])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 10 Feb 2023 22:04:46 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Cyril Hrubis <chrubis@suse.cz>
In-Reply-To: <Y9OXRJk1x5VnsmF6@rei>
References: <20230125222703.19943-1-pvorel@suse.cz>
 <20230125222703.19943-2-pvorel@suse.cz> <87edrh0zy2.fsf@linux.ibm.com>
 <Y9MGHKXel5kjwoTT@pevik> <87sffwq32u.fsf@linux.ibm.com>
 <Y9OXRJk1x5VnsmF6@rei>
Date: Sat, 11 Feb 2023 03:34:31 +0530
Message-ID: <87edqx18k0.fsf@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Gh4Z-6jy8FndF2SZwx8tQZx9V5AzNoyq
X-Proofpoint-ORIG-GUID: Gh4Z-6jy8FndF2SZwx8tQZx9V5AzNoyq
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_15,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 mlxlogscore=907 priorityscore=1501 clxscore=1011 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100188
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] hugemmap15: Compile with -O
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Cyril Hrubis <chrubis@suse.cz> writes:

Hi Cyril,

I tested with pragma, This works well.
Will send a patch.

Thanks
Tarun
> Hi!
>> I tested with clang with -O, it fails. So yeah it is not turning off
>> relevant optimization.
>
> There seems to be pragma to turn off optimizations only for clang, can
> you try if adding:
>
> #pragma clang optimize off
>
> to the source and removeing the -O0 from the Makefile works?
>
> -- 
> Cyril Hrubis
> chrubis@suse.cz
>
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
