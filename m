Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96950C433FE
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 13:02:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 109C93CAEB3
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 15:02:33 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A88163C9481
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 15:02:23 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D7E581400BCA
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 15:02:22 +0200 (CEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CB0RYs025805;
 Wed, 12 Oct 2022 13:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=7cS8VAs9EpgKsE78ArHY87I+rMXHawx+k3s4u0etSEg=;
 b=OSBZ6hzMCXJqPu5xOtgfejrIx3UbWMH8dyDYg5LSa6Umjo3L4/8rYnNJ11sH5Byuw5mZ
 VXYpyupID/NmuTIOQ/kC7DZNYwnMXoRsv/TSasShzdbMJLayJWkcgz4IzuWu82wbMaDE
 INtP1iMGBxp3+6/0x3z0IZHIH9lilUFFck68gBrNSDxM5YjlErEqxFrfmYbx2WIlDAxY
 uvNAgVa36U11K2LOv01TymtIoOHP9DQz1GPPAqOVIm95nJJpTTPseOY3h4a1w1x1FJ28
 sQB96yUoMRirJ1necToL6Oyv/mlRInP/O6lxvOyuxB6FazDfvq5s50CzHkOfNGRqrMr3 bA== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k5vb2be7q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Oct 2022 13:02:20 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29CCpKvK010070;
 Wed, 12 Oct 2022 13:02:18 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma04wdc.us.ibm.com with ESMTP id 3k30ua9cyf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Oct 2022 13:02:18 +0000
Received: from smtpav02.wdc07v.mail.ibm.com ([9.208.128.114])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 29CD2Hnd13369852
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Oct 2022 13:02:18 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A00BF58059;
 Wed, 12 Oct 2022 13:02:17 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F0D75805C;
 Wed, 12 Oct 2022 13:02:17 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown
 [9.160.31.46]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 12 Oct 2022 13:02:17 +0000 (GMT)
Message-ID: <39e9f8468b43b7d7a916e2b3e643aa233d161a81.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Wed, 12 Oct 2022 09:02:16 -0400
In-Reply-To: <Y0aq/Oar7Swmqzhj@pevik>
References: <20221006164342.68763-1-zohar@linux.ibm.com>
 <Yz9CW5vXCuztOTOl@pevik>
 <42eb7aef99a50e09d28f0b9c16ad64cb2caabe91.camel@linux.ibm.com>
 <Yz+4xepB6HlyFSNJ@pevik>
 <9aee3c94e8816196b9449981f3559e1c149d1c49.camel@linux.ibm.com>
 <Y0QFSiMTx3XlvAHJ@pevik>
 <a7b9b60182d13d92d6e0c5d2c588644027c72b41.camel@linux.ibm.com>
 <Y0aq/Oar7Swmqzhj@pevik>
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vwXzwYIhfjh2QA0ZvR9fteLlrX70k7lM
X-Proofpoint-GUID: vwXzwYIhfjh2QA0ZvR9fteLlrX70k7lM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_06,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=979 clxscore=1015 mlxscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120086
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] security/ima: limit the scope of the LTP policy
 rules based on the UUID
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

Hi Petr,

On Wed, 2022-10-12 at 13:54 +0200, Petr Vorel wrote:

> For some reason ima_violations.sh works, when run as the first test after boot
> (at least with only "ima_policy=tcb" setup), but not when whole ima runtest file
> is run (as there are tests run before it).  I'm still trying to figure out
> what's wrong.

Sounds like initially the tests are run with the builtin "tcb" policy. 
Loading any IMA policy rules replaces the existing builtin policy with
the new custom policy.

-- 
thanks,

Mimi


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
