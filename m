Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1159EC44501
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 15:12:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 38C403E97C3
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 17:12:53 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 975D53E56A3
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 17:12:35 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0CE421A00914
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 17:12:33 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EEffEn3906557; Tue, 14 Jul 2026 15:12:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=66lmevEqPmLK50OS2xQq52JjIcUpb/
 MS/4Q6Dv7VtTM=; b=eoRnIC+sYXMh3VxRe3jZwt17v/HWXnxP31CLzvlkXTh848
 x79nWR9zM9RHaOOm8MxaFJFtyAcm1EBzX3oKIXVbQsRbSuR43wnoh73Ym7vAL3x4
 jbrb3/KXSan5noAiNnLJOByqXm0CJT0MmqU3WIEoxg2lm0sGjSf2b3mVBN2Zvh5/
 YA1eRLtcAFX30E3PgS9TZNLnjNFyziX1k4tZyaFZy1kNS21/4E+b5vbOVmTBydWf
 nQPuXsdk8CvWmfFCmNHXkwuONjUF5M2npFtEMksThrE7x9zpWACZpkNvL/PyyHng
 puRvMS1muSTTBFo+ZUyrwgJMBka3P7KA4J52821Q==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv337d9w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 15:12:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EF4aPw011517;
 Tue, 14 Jul 2026 15:12:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uy33fn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 15:12:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66EFCS1s53608704
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 15:12:29 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA52A2004B;
 Tue, 14 Jul 2026 15:12:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C75CE20043;
 Tue, 14 Jul 2026 15:12:28 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown
 [9.224.74.129])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 14 Jul 2026 15:12:28 +0000 (GMT)
Date: Tue, 14 Jul 2026 17:12:27 +0200
From: Jan Polensky <japo@linux.ibm.com>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <alZR2y5aUSWB_kUg@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260709175927.268677-1-japo@linux.ibm.com> <alDW49sRfwx0eBw5@rei>
 <alDbqPsc3ueUqXlN@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <alDfPHAbN8nssBgX@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alDfPHAbN8nssBgX@rei>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE1OCBTYWx0ZWRfX1dRvUp/K1pxO
 ADyB8Yh3mXgE8hjaLfOX+KAB4cmed9dSQalhgFvbb5YPAKONeEvu5YYX+fU3Za60jaCexHgQUj2
 474i0ftEgx7J8x4h64KOmVpdtHPKTcw=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a5651df cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=C93SqfVvkn1EX-yPZfQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 1P3RudGNq9vYTn6n6idGOJgKyGXVWdJN
X-Proofpoint-ORIG-GUID: 1P3RudGNq9vYTn6n6idGOJgKyGXVWdJN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE1OCBTYWx0ZWRfX9yTwZWXsUh7r
 Qv2tz0AqKCxDUouxcJKdtpAXmixrlH5LPFAQWEGdQWXF9o5ob9jwNsOP2URXLONUf30vDHDmHdf
 pGnXlEZ/d0a6uKq27M4YTZXTyIMSg0oQ78EvH+MoDYLbycGoNTAq+ijVRJ6jqSe8rh65Xm1rtCC
 J5w8HWUwxQ+mx3V2duBLojkziPqEw1rkYUFHXIbTKnVCbsuUvsPj/EM98NwjK30FyT5cN1UoCLF
 i4MiGbsu8KHSQo6DcHpCD6JvawNd479EjgujVzjIwDwEu/p7pmKXqzDuQ6nsb77Uc3JC6j9kK0Q
 c/kz20fZopx+tHnOerLXlNQApGziESJKvZEpg3lg7MsoY7ZKKnFp28PgkHQRxJ3jFkjjg8qSZ6u
 U1zGVFSWntIT5pOS+7fPbITk2ub4aaovUpjVTEx1vfmBemVla72ba4yPPs5XXsWX4leEwNYgf7n
 saEDO6dCPdesWS56GDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140158
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/1] thp04: Add ptrace mode and fix tracee stop
 synchronization
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

On Fri, Jul 10, 2026 at 02:02:04PM +0200, Cyril Hrubis wrote:
> Hi!
> > That's a fair point.
> >
> > The main goal was to keep thp04 functional on kernels with
> > CONFIG_PROC_MEM_FORCE_PTRACE=y, where direct writes via /proc/self/mem
> > are no longer possible.
> >
> > Do you have a preference for how support for that configuration should
> > look?
> >
> > Would you prefer:
> >
> >   1. Keeping thp04 focused on the original race test and skipping it
> >      when only ptrace-based writes are available?
> >
> >   2. Splitting the ptrace write validation into a separate testcase and
> >      leaving thp04 unchanged?
> >
> >   3. Some other approach?
>
> 1 + 2 please.
>
> The thp04 is a CVE regression test, if there is no chance to trigger the
> CVE it should just report TCONF.
>
>
> > I'm mostly trying to understand the intended coverage for
> > CONFIG_PROC_MEM_FORCE_PTRACE=y before making further changes.
>
> For that we should add tests under testcases/syscalls/ptrace/. I suppose
> that we need a test that would check that the process cannot modify
> itself when that config option is enabled. And another test that would
> validate that parent can access child memory.
>
> --
> Cyril Hrubis
> chrubis@suse.cz
Hi Cyril,

thanks, I followed your suggestion and posted a new series:
https://lore.kernel.org/all/20260714150631.250972-1-japo@linux.ibm.com/

Best regards,
Jan

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
