Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 396BBCD98F6
	for <ltp@archiver.kernel.org>; Thu, 18 Jun 2026 14:48:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A0F5F3E587F
	for <ltp@archiver.kernel.org>; Thu, 18 Jun 2026 16:48:08 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A91F3E11C6
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 16:47:54 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7070F600832
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 16:47:52 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IEIEKD3657756; Thu, 18 Jun 2026 14:47:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=cXdZaF0a1lbVDtrhIhhrNS8INSlp6o
 p49Yrj8g454aw=; b=rufVGvJJo95UUnp1I6IvhrdXemS+xGgInILhyZAvSU9qcx
 8psfozJLgbcSVamh7SjVJ67za4XlKjQmCa+Hi3I4DSJ4hKjUd98do/RoLbJ1PnvS
 i1SogdibVzUqk5w9x63Z0RWnuSwn3iYaaEio+ofR9CRGlD34DdLUFVj7aHU4OyB6
 IpsRzwpkf8woMIECzk8OavT7UDiuCOn3FaeoedmHM3KuXAmQv5cy+DKVS8u6n4Jx
 kMcTAGD2KhtvE61XMrEJwquObMKNDqyebcdLsl5zTdzv9Dw5vzwnYXaLCV36RJTJ
 uWr1ZkM9BbM1HpnsOPUWdSsI12ptFKv4TTnYrxuw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqw0q1u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jun 2026 14:47:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65IEYaZU012723;
 Thu, 18 Jun 2026 14:47:50 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev17247um-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jun 2026 14:47:50 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65IElmho16187842
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jun 2026 14:47:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9154D20049;
 Thu, 18 Jun 2026 14:47:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 51F7920040;
 Thu, 18 Jun 2026 14:47:48 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown
 [9.111.46.88]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 18 Jun 2026 14:47:48 +0000 (GMT)
Date: Thu, 18 Jun 2026 16:47:46 +0200
From: Jan Polensky <japo@linux.ibm.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ajQFErzQW4qfU_Cp@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <ajPcMQprnR4HJfAi@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <6a33decc.06c236eb.d871.078d@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a33decc.06c236eb.d871.078d@mx.google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDEzMyBTYWx0ZWRfX3vQvTqG7XnZt
 dEO5LrsQ1yxIsKWEBbC82B4ASMMv5ENThM0/JG/ke2LVzEbqaW9JCU89fCvYPVW9xP8cuoySDfH
 KPSzMF53m4sIg3fBr+OKylBusHANqXA=
X-Proofpoint-GUID: mSoW6aHPy3kYytkFgBvUtHqN4USs94-E
X-Authority-Analysis: v=2.4 cv=bMgm5v+Z c=1 sm=1 tr=0 ts=6a340517 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=iox4zFpeAAAA:8 a=X1ZFo_rPaELkQyYkjgkA:9 a=CjuIK1q_8ugA:10
 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-ORIG-GUID: mSoW6aHPy3kYytkFgBvUtHqN4USs94-E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDEzMyBTYWx0ZWRfX3A6kOPNRwT9k
 54Q9f5mgDAGjLXy4PRrx5EaAsYxXh1jY0d79XDQhAsP4K5FI+O8Jz6mADLF3mOAGNA+q9BIlczn
 RROQUnqKn0lVIgX4481bflTqlOWzhzNVoTQw4oxwwuUez1WppFJw5BGh2K+GocqC22GEWPYakZp
 I41AkSFefU/wviwwSUM9gwS2OOvRY9ZnGin5xBGnFp+vwEsAMEKoc+DT7dAnJwcKFu+PxtXfaRx
 c6F+Sjz4mU7cZm/TgghLMCJmaAeahNCKQNDCN64FAW0y2a3Bskbj+q62mR6nyxO1fLuLXkh6S8F
 ej2shBRVZAoIdjF5CmoFE/UjRUGKaXkSVSPLCSLXhgsrU00ENa+mrRrPrgUlnE4/SloJRmlpToS
 EbdBek88j00I/6Hgn1GhOZlsbnu9yPdyqHBWxIvHmW3prQldtJUWnbn70p94Jf9NgYtEzLzpvYj
 gWeTgdseyXaXjsA6qkA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_02,2026-06-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180133
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
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

On Thu, Jun 18, 2026 at 12:04:27PM +0000, Andrea Cervesato wrote:
> Hi Jan,
>
> > Hi Andrea,
> >
> > just to add some context: the regression itself was on the kernel side.
> > The relevant upstream patch is
> > https://lore.kernel.org/all/20260603131950.321858-1-japo@linux.ibm.com/.
> > My understanding is that the kernel-side change did not resolve the issue
> > for the LTP test suite, and that there was also a separate LTP-relevant
> > aspect for exfat swapfiles, where actual data writes are required before
> > swapon() succeeds.
>
> Sorry, I forgot to properly reply to this email.
>
> Today I sent a patch to fix the kernel, you can take a look at it here:
> https://lore.kernel.org/all/20260618-exfat_swap_activate-v1-1-4c6a465df295@suse.com/
>
> This patch should fix the issue, let me know if you are still seeing a
> failure in the LTP tests after applying it.
>
> Thanks,
> --
> Andrea Cervesato
> SUSE QE Automation Engineer Linux
> andrea.cervesato@suse.com
Hi Andrea,

thanks, this fixes the swapping issue for me on s390.

There is just one remaining problem: when exfat is built as a module
(CONFIG_EXFAT_FS=m), the build fails because
generic_swapfile_activate() is not exported.

Please add EXPORT_SYMBOL_GPL(generic_swapfile_activate) in mm/page_io.c.

Best regards,
Jan

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
