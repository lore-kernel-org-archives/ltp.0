Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82076C282D1
	for <ltp@archiver.kernel.org>; Thu,  6 Mar 2025 21:02:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D45B53CA115
	for <ltp@archiver.kernel.org>; Thu,  6 Mar 2025 22:02:40 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED97F3C9D9E
 for <ltp@lists.linux.it>; Thu,  6 Mar 2025 22:02:22 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C80411A003F2
 for <ltp@lists.linux.it>; Thu,  6 Mar 2025 22:02:21 +0100 (CET)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526E36wC019215;
 Thu, 6 Mar 2025 21:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=KIzB9L
 0P5j+67GIo5o4poOoQOFZrFpnukv0t4SquZSk=; b=CezD1BislMTuZ0MiPPi+qZ
 h88j0/5Y8fwx//bQJ70TorLMI36CU0jJwCL93hExlJTx2EgX1DWGBK2ErSAJZtPN
 e98v++Zcu1jxDp8t0c62NUsb2/AkoaG7Chb+y2tnJ2P0YIVftibYZ9PrUtbejMQh
 5WzDr/I+e9G8uNnDwPUyoDesjMNsKJ1pP9bvkwCSm2pSj5+wH+t0Yfru1jeCaH0w
 kjmIiTOBgUi1Z1m7mQkRSQmJN+ygYyI1dit+F/7+dOicJ6B4ISSp/bec8NJYUA9M
 fBvD5kN5CzdOHHASBJvQfydcFByoco+WtnualOJp/yU59KHFT4U10TCZ0A0idFXw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 457d4p26a3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Mar 2025 21:02:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 526JY3d1013743;
 Thu, 6 Mar 2025 21:02:17 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454e2m2vn5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Mar 2025 21:02:17 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 526L2GHZ29950610
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Mar 2025 21:02:17 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E1E775805D;
 Thu,  6 Mar 2025 21:02:16 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E56358052;
 Thu,  6 Mar 2025 21:02:16 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.31.103.152]) by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  6 Mar 2025 21:02:16 +0000 (GMT)
Message-ID: <a87d1f288726949f330e35df87c9df1f7327d2ac.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 06 Mar 2025 16:02:16 -0500
In-Reply-To: <20250306172622.GB186319@pevik>
References: <20250305145421.638857-1-zohar@linux.ibm.com>
 <20250305145421.638857-5-zohar@linux.ibm.com>
 <20250306172622.GB186319@pevik>
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7MErAH1D6imI1QKJsK4vPgwXRJLw_Gqr
X-Proofpoint-ORIG-GUID: 7MErAH1D6imI1QKJsK4vPgwXRJLw_Gqr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_06,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 mlxlogscore=737 adultscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503060160
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 5/5] ima_violations.sh: require kernel v6.14
 for minimizing violations tests
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it,
 Stefan Berger <stefanb@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, 2025-03-06 at 18:26 +0100, Petr Vorel wrote:
> Hi Mimi,
> 
> > Depending on the IMA policy and the number of violations, the kernel
> > patches for minimizing the number of open-writers and ToMToU (Time of
> > Measure Time of Use) violations may be a major performance improvement.
> 
> I would prefer this to be squashed into "ima_violations.sh: additional
> open-writer violation tests" commit, which adds this incompatibility.
> 
> But it's a minor detail, therefore I merged whole patchset as is.

Thanks, Petr.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
