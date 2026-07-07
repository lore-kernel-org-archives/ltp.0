Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47365C43602
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 09:59:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F3FA3E2CDF
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 11:59:50 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C34783C746A
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 11:59:34 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 03ED81400445
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 11:59:33 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6678IGGC3342108; Tue, 7 Jul 2026 09:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=BjZhYb2cAp9SKnW0azTo+g34dbWOly
 sKVGlLrf1EC0g=; b=aNPdqSfjTIbEsB0PiNCxerfLteGjKiNgo9/H36TCv7egS3
 b12w6poKuOcrgSPCEWKn0+IwgJCbr+QjifPky9Bm4oY0EE0Lzx96Ez8q/bLM9D9b
 W+rMXNF2pT7rFlOvK51EORqUpUiYujyGOpvHxLj89FaPl2IxweAGaRz/Sx5T72Sr
 kq2Z0tMDv5Q2wrtJyIK2onp7lzZBlTGjOSPC5YK4HypqJxC0CXJv+Evo50I+f1rZ
 xkx1I7+z3b3T5TdJyitERpYLhU7dUSOPIhdY1r/j36OK0ZTtRLRJp7ablRGpBys5
 fx0MS/J/25/vB8rH7qbJfbuwT+wGyO2lJR8+raxw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6suqp803-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 09:59:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6679nZEl031975;
 Tue, 7 Jul 2026 09:59:30 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqg1y8w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 09:59:30 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6679xSxx56754620
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jul 2026 09:59:28 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7FC712004B;
 Tue,  7 Jul 2026 09:59:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 46C5120049;
 Tue,  7 Jul 2026 09:59:28 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown
 [9.111.59.117])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue,  7 Jul 2026 09:59:28 +0000 (GMT)
Date: Tue, 7 Jul 2026 11:59:26 +0200
From: Jan Polensky <japo@linux.ibm.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <akzN_iISxNTztbEw@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <ajQFErzQW4qfU_Cp@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <6a463902.41a38e5f.27f5bd.337a@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a463902.41a38e5f.27f5bd.337a@mx.google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA5NSBTYWx0ZWRfX+EDJaaElUkOq
 VX4nha8LUAiPMREWmluXR5tllDFiAeiSFyfWPK0rJyi2VIinnUkjK8IUOlzWlO9mzdojWxTH2vV
 sexKU/Mi313KIlbc29IOvL8hHIVE5yc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA5NSBTYWx0ZWRfX4BUbRNmzBJWK
 sMiT/VXDtNTj9Xzw8RrOqmCd0djZoCpPvgNc541guGMj6ZPDxiYJA9UUc/GZbMrftdh/kAWEP36
 eYmrFkB2FMDSDuYwz6uWfD2ZiFMGVCPfPCoaa/1iw9f8pd+uCwrXGkhsYrRL5vnzfnKtv0LRYfv
 HRyC3x6Ovi7opgYQdOGH2iNOqmuytl+q2sAtgcMhCYwtPQiKUnFRqNbgi7LJR/PILiZo4CQ3rRn
 u2Y3C29ys4q7ZXVguu45INXsCPpA22NVDxmLB54roCFF8n8UFMDFD9ioK6KYPE8BigOKjGJwlzT
 HvAt8+7jJ5VjbeaTcy4HiShhtNWikp+Epy/o46zXZxjIslCBQgQg+BVUxn81+UfvRjb3lqudTGv
 Lh6ihu3RrS0RBqaPSih9u2oXXaXXPU2+wJU8X7hbuTugs71jN8oIY6euUSIA4gnK1Qb8gvrn1nW
 Ag/IOR9Fs8RDPstCPXg==
X-Proofpoint-GUID: H9tuOul1T8BJh7wBXjF3tksf4LiN__pJ
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4cce03 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=iox4zFpeAAAA:8 a=d0VEmG3JA_4b86qDspUA:9 a=CjuIK1q_8ugA:10
 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-ORIG-GUID: H9tuOul1T8BJh7wBXjF3tksf4LiN__pJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070095
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/1] swap: Add exfat to filesystems requiring
 tst_fill_file
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

On Thu, Jul 02, 2026 at 10:10:09AM +0000, Andrea Cervesato wrote:
> Hi Jan,
>
> I seen you implemented in v7.2-rc1:
>
> commit 03a43677ca91e3997355a13b1da6e47329b025e1
> Author: Jan Polensky <japo@linux.ibm.com>
> Date:   Tue Jun 9 18:21:49 2026 +0900
>
>     exfat: add swap_activate support
>
>     Commit 07d67f3e9083 ("exfat: add iomap buffered I/O support")
>     converted exfat buffered I/O to iomap, but did not add a
>     .swap_activate handler to the address_space_operations.
>
>     swapon(2) on an exfat swapfile then fails with EINVAL, which causes
>     LTP swap tests to fail.
>
>     Add exfat_iomap_swap_activate() and hook it into exfat_aops so exfat
>     uses iomap_swapfile_activate() for swapfile activation.
>
>     Fixes: 614f71ca1bdf ("exfat: add iomap buffered I/O support")
>     Closes: https://lore.kernel.org/all/20260603110212.3020276-1-japo@linux.ibm.com/
>     Signed-off-by: Jan Polensky <japo@linux.ibm.com>
>     Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
>
> what should we do with your patch in LTP?
>
> Regards,
> --
> Andrea Cervesato
> SUSE QE Automation Engineer Linux
> andrea.cervesato@suse.com

Hi Andrea,

Thanks for following up on this.

On my side (s390x, Fedora 44, kernel v7.2-rc1), I still need both
patches for the LTP swap tests to pass:
 1. The kernel fix (03a43677ca91 "exfat: add swap_activate support")
 2. This LTP patch (adding exfat to tst_fill_file)

Without the LTP patch, the tests still fail even with the kernel fix
applied.

Could you validate on your setup whether the kernel fix alone is
sufficient, or if you also need this LTP patch? It would be good to
understand if this is architecture-specific or a general requirement.

If you can confirm the tests pass with only the kernel fix, we can
close this LTP patch. Otherwise, one should merge it.

Best regards,
Jan

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
