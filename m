Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 892BDC61DBD
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 00:25:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A2C93C9EB4
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 02:25:20 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B42E73C6EBE
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 02:25:02 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D3EF8140026C
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 02:25:01 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PLViSp1966846; Wed, 26 Aug 2026 00:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=XEqf+d
 afsZnCPbm+2rzhijXU0Tzq/Y8PPHFVMyq8fwI=; b=Ikr6iYe97v8dUgHR+qzcqA
 n+bVsmxdm3h6vTjSoZ8qJq++IyDDHiYTzkvBz/g5GvJ39Ydt0Yznlh3DOg4m8rB2
 8rEB0T+VJhNcahp7hFhO2oRSFpgFwDdI+K6eKyxJGoyHMS7jNZIzyGbKIMHlFcKs
 CgF5cEPXbU9KrXyEHEzrgDMoSuQwlzjtcE6auXa0C3CBmnrcjeK8MjKfnGahpsqo
 SGW4AVF2yw2cg7rd0dfpHG4w4eZfFsW5ZgG8We6m/8FgRKzDbuN5kgBBZauoBD0e
 kaNWicv+OptBw4w5YYN26xa1DA+qvnAIULmsgV3x58/PSrQd4kZ6TrNH6lu5Q7RA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hup9j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 00:24:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67Q0BhT1019773;
 Wed, 26 Aug 2026 00:24:58 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkh74rj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 00:24:58 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67Q0Owoc35783138
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 00:24:58 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F00A35804E;
 Wed, 26 Aug 2026 00:24:57 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 88FB558054;
 Wed, 26 Aug 2026 00:24:57 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.61.20.77]) by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 00:24:57 +0000 (GMT)
Message-ID: <8564c18ee78ca4f308dc0b7f48ac2f63b295ee00.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, linuxtestproject.agent@gmail.com
In-Reply-To: <20260825044433.GB22725@pevik>
References: <20260821200620.902699-1-zohar@linux.ibm.com>
 <20260821202613.4033-1-linuxtestproject.agent@gmail.com>
 <20260825044433.GB22725@pevik>
Date: Tue, 25 Aug 2026 20:24:57 -0400
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDIwNSBTYWx0ZWRfX8X1O+IfWWbeh
 oLDH4E7j4H+Gu0ueBZNPUvYPEhZuIRnfqMRELTXUeExX1UbL3RVglyNry7u2+/VeAtl4eBy0u0l
 i0Y/I7CJKTNwJopKQhBHzxb9DpzxiO8=
X-Proofpoint-GUID: CvgYdZgDvzE7TdJpy_IcPRfPA_aZMbcU
X-Proofpoint-ORIG-GUID: LuDES5oZTedzH5htJi_qfLzduVGJ9YJU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDIwNSBTYWx0ZWRfX7NUuMcsxGZtQ
 NwgmnthuiRpFDqOG7khIrdrpEmZx/mShkOk4Y6hhv8jcU+w3V961gwirNOyv+/SjWX0iXfLQjpr
 dU1L0CtG7cY6zVMUR6v9dT226QdzYwQiPDZf5u7mq7X2d5crBwVL2bepvfMdu4YxFbJW13uboz5
 OMIY9rDcru9fDNLoYSE7n4+PSNUsXPh7rm6WgYgTyFDEhY3BPXtIKEoethQeDEy2XXO3Kw/egIK
 XEoiJalQdt2jDmAPkYGvC9aZJxMT3NufkpMHJUGQ08LvQQdG8PWJC+uvl+hKAE9iATrLoEashzw
 7tD6TrMGjBZ+ekEtFwATk1nSLs3A/ZwldFMVz1cpcy+m/aKEjY0nSZKovzGgWyDGJlO5f/Pfcr7
 E/Xd+NNVn7pUuvhopM5h8DUWzni7yoQdZL/AB08hyvI8Ca+/O7zI0X5YK7E0qQyq43dMIanRnH5
 rqJuPVC2pnyuNcnU51g==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8e325b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=yiLAOaqLNPTphfV9390A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250205
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ima_selinux.sh: test2 assumes CONFIG_IMA_DISABLE_HTABLE
 is configured
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

Hi Petr.

On Tue, 2026-08-25 at 06:44 +0200, Petr Vorel wrote:
[...]
> > On August 21, 2026, Mimi Zohar wrote:
> > > ima_selinux.sh: test2 assumes CONFIG_IMA_DISABLE_HTABLE is configured
> 
> > > +		if ! tst_check_kconfigs "CONFIG_IMA_DISABLE_HTABLE=y"; then
> > > +			tst_res TPASS "Duplicate \"selinux-state\" record missing (CONFIG_IMA_DISABLE_HTABLE not set)"
> 
> I would suggest the same, it makes sense to use TCONF to make it visible that
> it's not an error but OTOH it was not actually tested due
> CONFIG_IMA_DISABLE_HTABLE not set. If you don't mind, I'd change TPASS to TCONF
> before merge (or feel free to send v2 with this change yourself with my
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ).
> 
> Thanks for the fix!

Agreed, it should be TCONF.  Please make the change.

thanks,

Mimi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
