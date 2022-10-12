Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C9CC433FE
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 12:48:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 792E33CAED7
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 14:48:55 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E532D3CAE21
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 14:48:44 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DB33E14004F3
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 14:48:43 +0200 (CEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CCflSd002558;
 Wed, 12 Oct 2022 12:48:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=W+YOwRi5zTOzvSK07eBasoRRmnOHVlE7AM0BF3BC1UE=;
 b=jiFTTcvz+3RHcXeATZZ6ig6Ev1D53VTpeIf+zfo07verrEYhtEqo46C6gFxZ7tsRQehS
 zz+V/eCGr6k5kdICuN77V9Jffeo3paZRuepvIW6gJ4KSODqhMvy+Ja38nycwfajGq2Q5
 qY5Sca5hPvss/Zy2lVPYMPjlzsSVyUFNbyB7i7LvTGev+uF7i7rKmApuNZhf69sWPHpN
 8IB/t+yVNwTgB07axCvSkpMFf1Bs2+4LQaPiLmiBt0VKdsW9QTDVXRUShFJRXS+7WDi+
 fVouNww6HoX17I/tl0GmdXD/1df7pAzJfoteAeUfoKotjrxwRiGT1baCH1eZBtCs6Day uA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k5vp2t3jk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Oct 2022 12:48:39 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29CCgaIZ005704;
 Wed, 12 Oct 2022 12:48:38 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k5vp2t3j0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Oct 2022 12:48:38 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29CCZwU1000315;
 Wed, 12 Oct 2022 12:48:37 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma02dal.us.ibm.com with ESMTP id 3k30ua7k9k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Oct 2022 12:48:37 +0000
Received: from smtpav06.wdc07v.mail.ibm.com ([9.208.128.115])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 29CCmafV16581500
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Oct 2022 12:48:37 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 36EBD5804E;
 Wed, 12 Oct 2022 12:48:36 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 75EC35803F;
 Wed, 12 Oct 2022 12:48:35 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown
 [9.160.31.46]) by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 12 Oct 2022 12:48:35 +0000 (GMT)
Message-ID: <dc5e3e41cf1465ddc70cbac0d77c4f2deff0213f.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Nikolaus Voss <nv@vosn.de>, Yael Tzur <yaelt@google.com>, Cyril Hrubis
 <chrubis@suse.cz>, Jarkko Sakkinen <jarkko@kernel.org>
Date: Wed, 12 Oct 2022 08:48:35 -0400
In-Reply-To: <20221006081709.92303897@mail.steuer-voss.de>
References: <20221006081709.92303897@mail.steuer-voss.de>
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OLVEbYe6L6Du3cbks-HWCKKRA8YyXuhI
X-Proofpoint-GUID: NgtI61N6oFUhkFuka1uObCciRlaVt3EG
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_06,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120082
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/keyctl/keyctl09.c: fix test encrypted key
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

Hi Nikolaus,

On Thu, 2022-10-06 at 08:15 +0200, Nikolaus Voss wrote:
> This commit fixes the test for adding encrypted keys with unencrypted data.
> Unencryted data must be provided hex-ascii encoding. Due to a kernel
> bug, the unencypted data was not decoded to binary thus the length of
> the key was only half the specified key size. This patch doubles the key
> size and adds a test with a wrong key size to trigger a corresponding
> error.
> 
> This patch must be used with the kernel fix
> https://lore.kernel.org/lkml/20220919072317.E41421357@mail.steuer-voss.de

Petr, please correct me if I'm wrong.  Changing an existing LTP test so
that it only works on kernels with the kernel patch applied, doesn't
sound right.  The test should emit a warning if the original "valid
payload" successfully loads.

As previously suggested, instead of replacing the existing valid
payload, define a new valid payload as the hex-ascii representation of
the existing one.  The kernel decrypted data would then be the same on
systems with and without the patch.

 #define ENCRYPTED_KEY_VALID_PAYLOAD    "new enc32 user:masterkey 32 abcdefABCDE
F1234567890aaaaaaaaaa"
+#define ENCRYPTED_KEY_VALID_PAYLOAD_NEW   "new enc32 user:masterkey 32 b61626364656
64142434445463132333435363738393061616161616161616161"

-- 
thanks,

Mimi


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
