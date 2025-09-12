Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6578CAC582
	for <ltp@archiver.kernel.org>; Fri, 12 Sep 2025 13:18:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A21843CD8E8
	for <ltp@archiver.kernel.org>; Fri, 12 Sep 2025 15:18:30 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA6573CD8D4
 for <ltp@lists.linux.it>; Fri, 12 Sep 2025 15:18:14 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6D2D61400BEC
 for <ltp@lists.linux.it>; Fri, 12 Sep 2025 15:18:12 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58CBfS6D029066;
 Fri, 12 Sep 2025 13:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=rjGdHh
 +ftt2qBFlZwuyMmhQlwlfRRJVAShREhD2SeOI=; b=lDi0v9CxAwgzaIn2DllOwl
 4uLJ/7f70gJpB7U7fmtU39JTZFB0DOjUFP34jTlycbxTAlYwUClC1T5tGQhEkXz8
 XJyMRLv6UMhcZrZuFncWRyFuIKECTuEJSlloZ6unDrTVS4D/TDjw6KfWg0jASiuN
 v2OPbM+2+R+evsGRcAgqjcNJ0BKZiWYda2/DkWz7TzSJiwOvualhZYGE0tyHC1FB
 kvbEwcrWlUzwxuOCDIThSUcXTaVzwfwZaXCsjWBswQEdI+i+IxUuYIFyf9qbWltK
 2r0gpNOVG/gMNueUQU+cuSin1xSVGBtTzikin+rsWUv9nagh/yo9Y+OomRsij31Q
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmxbqpy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Sep 2025 13:18:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58CCCdDW011428;
 Fri, 12 Sep 2025 13:18:09 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 490y9uucgh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Sep 2025 13:18:09 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58CDI9aV19333562
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Sep 2025 13:18:09 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A5EC58052;
 Fri, 12 Sep 2025 13:18:09 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C16458045;
 Fri, 12 Sep 2025 13:18:08 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.61.85.212]) by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 12 Sep 2025 13:18:08 +0000 (GMT)
Message-ID: <79bb6b761ef478b6b4ac71875ac9d7215edd7c78.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
In-Reply-To: <20250912073210.47637-2-pvorel@suse.cz>
References: <20250912073210.47637-1-pvorel@suse.cz>
 <20250912073210.47637-2-pvorel@suse.cz>
Date: Fri, 12 Sep 2025 09:18:07 -0400
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IJMtwYpPVrK9FJR4g_nQkYt3IF4I-9GV
X-Proofpoint-ORIG-GUID: IJMtwYpPVrK9FJR4g_nQkYt3IF4I-9GV
X-Authority-Analysis: v=2.4 cv=J52q7BnS c=1 sm=1 tr=0 ts=68c41d92 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=9TuvdWacXOjX2tRd1rUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNSBTYWx0ZWRfXyrRD2ZcUMJqM
 RiiDrZcFjX8nCeIPOsZLEDo4sXd/nSNI+vuNUeBe6WrbqzF5DvM0IfS1ofxhkPntg28lv9VXxa5
 LAUw51Mv8rk5dmb2F+Udsi9P84eywR4RhDErd+WdMnpgafUZL+U9pwaPNYp8tJonsYwuRJtNZQH
 wcUvkd4npYp4zSdM83waBNILz5MfV0Ne3jp48Wrbt8grCUhJV2+14snVOqdUVL8lynpl/BtbrGV
 Pz1dEglvJKWeAoEwNt13F8SL626ZVid31T3T/KLl33HNIzGghj7jmX7clcku89lMUhzsCSKx38O
 hST/jNhicu9tZ2Arjp+nm8sSQavYIaf6i2tpRD5/EuJ/OSpsSN0+bQ/XYSJK385D7uO+NsWhnki
 bTX3UGVn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060025
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] ima_policy.sh: Optimize check for policy
 writable
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
Cc: selinux@vger.kernel.org, linux-integrity@vger.kernel.org,
 Coiby Xu <coxu@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, 2025-09-12 at 09:32 +0200, Petr Vorel wrote:
> Previously policy was checked in setup and in all tests
> (redundant in test1). It should be enough to test in setup and after
> write in test1, but let's being careful and test before writing the
> policy in load_policy().
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Thanks, Petr.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
