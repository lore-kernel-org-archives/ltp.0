Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA099C433EF
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 05:11:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F204C3C9231
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 06:11:43 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 085283C078E
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 06:11:32 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4F5FC601078
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 06:11:30 +0100 (CET)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BM3QSUF018672; 
 Wed, 22 Dec 2021 05:11:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Jz+TRqM/kTaDY19Ct8ZIFyS8L0SnEev97rTaAsftvzY=;
 b=T5+PYFliTUxc4Q7f/CPBg/JkX3dxIOOfpRGv3MXqFamLSRCMsaRy7+tQQ/AsKGPPoc62
 c9dQ5VSPcG/Qy/HKqqiAtlhj4PD4r6QM8f+TC1ZFnPSC4F9m9W7T165lqZ+3xQ7web/w
 qSsSH9m9Yikf5Tqsemq/KazRwH3d/fbIzel8clq7jluKSUPojG5ilXRrJxNlk3Pbh/Ef
 OetstekLZwpXMrZYlHcQkbNrxNFMa2OuT2RyQSgJIqCrvnqcP+HwAIQCH9gMCcPkOmgZ
 UVOKf/K0RS1A8wk+/hlb0Z8tIlCDJ0URsW1RMQOGFqxGVlphg3R4Mp3hrMVDeQVUn0Mg 2g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3d3v40hb6r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Dec 2021 05:11:28 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BM50SZJ028916;
 Wed, 22 Dec 2021 05:11:28 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3d3v40hb6f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Dec 2021 05:11:27 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BM54HDw017052;
 Wed, 22 Dec 2021 05:11:25 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma06fra.de.ibm.com with ESMTP id 3d16wk1ff8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Dec 2021 05:11:25 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 1BM5BMRI46072286
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Dec 2021 05:11:23 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D204152052;
 Wed, 22 Dec 2021 05:11:22 +0000 (GMT)
Received: from [9.43.47.145] (unknown [9.43.47.145])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id A22DB5204E;
 Wed, 22 Dec 2021 05:11:21 +0000 (GMT)
Message-ID: <8c785afa-4564-d7ca-0bb8-34d5b5ca89bd@linux.ibm.com>
Date: Wed, 22 Dec 2021 10:41:19 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
To: Petr Vorel <pvorel@suse.cz>
References: <20211221023721.129689-1-yaelt@google.com>
 <aafb5351-a73a-dac3-b0fa-3faad707bafa@linux.ibm.com> <YcGw5Lyo+hBEnlFD@pevik>
From: Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <YcGw5Lyo+hBEnlFD@pevik>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7jkXjXALIwl71lDM4MItaYn-BHPxg8Wr
X-Proofpoint-ORIG-GUID: iUa3RKt67W364e9387hNrZ-W4cEVB4X6
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-22_01,2021-12-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 clxscore=1015 impostorscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112220031
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/keyctl09: test encrypted keys.
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
Cc: linux-integrity@vger.kernel.org, Yael Tiomkin <yaelt@google.com>,
 ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



On 21/12/21 4:18 pm, Petr Vorel wrote:
> Hi Nageswara,
> 
>> On 21/12/21 8:07 am, Yael Tiomkin wrote:
>>> Test that encrypted keys can be instantiated using
>>> both user-provided decrypted data
>>> (https://lore.kernel.org/linux-integrity/20211213192030.125091-1-yaelt@google.com/),
>>> or kernel-generated numbers.
> 
>>> Signed-off-by: Yael Tiomkin <yaelt@google.com>
> 
>> Tested on ppc64le platform
> 
> I suppose it also fails on ppc64le when run more iterations.


Tried with -i500, -i5000 and -i50000 also ... no failures were seen on 
ppc64le architecture.

Summary:
passed   500
failed   0

Summary:
passed   5000
failed   0

Summary:
passed   50000
failed   0


> ./keyctl09 -i500
> keyctl09.c:49: TPASS: Encrypted keys were successfully instantiated and read
> keyctl09.c:49: TPASS: Encrypted keys were successfully instantiated and read
> ...
> keyctl09.c:33: TFAIL: Failed to instantiate encrypted key using payload decrypted data
> 
> (It's always good to put higher number iterations.)
> 
> Kind regards,
> Petr

-- 
Thanks and Regards
R.Nageswara Sastry

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
