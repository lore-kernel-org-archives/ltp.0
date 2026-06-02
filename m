Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08252CD6E4A
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 06:24:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6809A3E3096
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 08:24:22 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E5283CD595
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 08:24:04 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2FB47601B2D
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 08:24:03 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 651In7nG2386944; Tue, 2 Jun 2026 06:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=akd38f
 rPoTjH378lDV1u7MPKokYHJSMF5F62tYwnJ/o=; b=VMYs29GUA8edMrGOgE67O7
 4QN5cA/qg1lmKjDK0g1RU9BaGUrdsLu6CYV9UHwnO27JPOOMPCh9Oe2CI0jnwFRR
 9svyx3GQATkR40SjF4/PcztTCBu0DlRCk2O/duTTunWF51DYf09UzOR9y/R1JHeH
 qI0VGW0Td7AR8JgPlpXQwC0fFemPUDAz3R5hwTd6pY/Ovwl2msUgfALDJY3Uq4SS
 dP6Q+7qrR1rBQ357AROuKQnvkl0VKR5BTDhWyeJf1TKMxtabWgiDSODV3f7UL4LX
 BgkdV8NV4+h3QGllIBx8IDJ0F9c8cCQFCiZitAs2IldZ+4CuHl1eYaku3csr0dzw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd44j9m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 02 Jun 2026 06:24:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65269Ogn027778;
 Tue, 2 Jun 2026 06:24:00 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7k1vkt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 02 Jun 2026 06:24:00 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6526NTpj19726956
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 2 Jun 2026 06:23:30 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D7ACA58057;
 Tue,  2 Jun 2026 06:23:59 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F32B58058;
 Tue,  2 Jun 2026 06:23:58 +0000 (GMT)
Received: from [9.43.122.22] (unknown [9.43.122.22])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  2 Jun 2026 06:23:57 +0000 (GMT)
Message-ID: <477836fd-80c8-4168-bfe6-00b374bb2534@linux.ibm.com>
Date: Tue, 2 Jun 2026 11:53:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.com>
References: <6a1d2bad.97b0ce82.3c3385.8804@mx.google.com>
Content-Language: en-US
From: Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <6a1d2bad.97b0ce82.3c3385.8804@mx.google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA1NCBTYWx0ZWRfX62AgnyKNs03V
 JNctLEwtiSdob/JLaTg4RwbYXXsdOQ1NJ+wkB3QGMQkGuVQL9Z0275OuhIVEM8I/ueeIlZVNp3o
 Y624fHJ79SglPAbqkc5nHMPrut/Irx8FO1wxPj/Xhb7XAq2/k8nSCIXO1mg7uvriDOXaXfXWR4m
 kpSk/1tY2K7nbnBPL8PqFodEWjhYbOpX7ngum+8ipCRkwIoSHnX7owoHfgRTOn2SDIWRd/yEy8v
 /pxrawNSEhA3/gPugUBo7n3zhO7l7hjEKiARpBnKEgSlx1xsueNbvqBmY24dWhl90q7DoWJI++h
 VYuOsmnGwN6oojJUdlvn3Ec9lVXPJDyxPUJ39LrnXvKvg/cyA6dtMtfliO5T8UB+1Uj5PMhLlHq
 0fhjMweTRsimvFNdVN6cfEetPSjdmBz3Ops41Nw+CttEMEjQ1EvIqDTN3ryDH21lakdpRpJ02ul
 D7HH6Cy4goE91nx5ZNA==
X-Proofpoint-GUID: mLesQiOXoZS0LMchnphXAf2dReu3Bci5
X-Proofpoint-ORIG-GUID: mLesQiOXoZS0LMchnphXAf2dReu3Bci5
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a1e7701 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=NEAV23lmAAAA:8
 a=AXLt2C3_GRQdbXtvD_wA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020054
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC][PATCH 0/8] Convert shell-based ACL test
 (tacl_xattr.sh) to C
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



On 01/06/26 12:20 pm, Andrea Cervesato wrote:
> Hi Sachin,
>
> the patch set is not compiling in some systems. Please verify that it
> compiles by running the CI in your github branch before sending a new
> patch.
>
> https://github.com/linux-test-project/ltp/actions/runs/26713233737
Thanks Andrea for the pointer.
Test building in various distros in Docker workflow was not enabled in 
my branch.
I have now enabled it so that I can catch such failures in future.

The compile/link failure seems to be due to unconditional inclusion of 
-lacl and
sys/acl.h header. Will add a build-time detection for libacl to allow 
tests to
compile on systems without libacl development packages.

Will send an updated patch series.

-- 
Thanks
- Sachin



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
