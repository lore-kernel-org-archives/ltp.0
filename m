Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 853CBC02181
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 12:33:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1BB543C2FD0
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 13:33:55 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A98BC3C2CF7
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 13:33:39 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=svens@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9EBF1141D0DB
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 13:33:38 +0100 (CET)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50M2XGCB009586;
 Wed, 22 Jan 2025 12:33:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=w0ce1D49YlNg3XqIwV8ptSJKYH5N/S
 VmnB67uctgow0=; b=PNlEn4pLInnKE9NkLQMtds8w2/Vdrtz/GwgINoM4KUHbDZ
 q8lIhGKgCbd04wtzIrH7DxvDzbvqEP+D8Gb7L8dKZ0Id0869SJT6EqIeg0Ajd6UO
 f2pZXpwIwNIISFcY3mY28tr8VgOKoP+Cytj9bgqALn4OsHEcOY6uNUIS97SexMU+
 0pRPwaxQVZuqtO9pjpVgxuh17UNmnAmf4XD8WIGB72KNMZ63gHg/HmrIbFq1C3OG
 NoBO+VX58fWfNCNslCuYTevtiVVjiB9wXPkOHhh6CqkmGbAXE46C3MaSlLJW44V3
 ugp3oxr6SfaYA70VZcBrkhQQtMbkBcgTFV3CMAEQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44aee1d0pm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Jan 2025 12:33:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50MBWitn032222;
 Wed, 22 Jan 2025 12:33:36 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 448rujr344-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Jan 2025 12:33:35 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50MCXYdc60555766
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Jan 2025 12:33:34 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F79720043;
 Wed, 22 Jan 2025 12:33:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 356E520040;
 Wed, 22 Jan 2025 12:33:34 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 22 Jan 2025 12:33:34 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Cyril Hrubis <chrubis@suse.cz>
In-Reply-To: <Z5DkUNyjq9x-jY7v@yuki.lan> (Cyril Hrubis's message of "Wed, 22
 Jan 2025 13:28:00 +0100")
References: <20250122100915.3126008-1-svens@linux.ibm.com>
 <20250122102648.GA29598@pevik> <Z5DQFuQiIAGAqtK4@yuki.lan>
 <yt9da5bj6o7f.fsf@linux.ibm.com> <Z5DkUNyjq9x-jY7v@yuki.lan>
Date: Wed, 22 Jan 2025 13:33:33 +0100
Message-ID: <yt9d5xm76naa.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yTFDBacY6uxaq9YrcjoiOUVS-W-CRuaU
X-Proofpoint-GUID: yTFDBacY6uxaq9YrcjoiOUVS-W-CRuaU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_05,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=594 priorityscore=1501 bulkscore=0
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501220093
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mmap01: initialize buffer in check_file()
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

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> >> > mmap01 reported random test failures. Turns out the
>> >> > the temporary buffer in check_file() isn't initialized.
>> >> > The SAFE_READ reads less then sizeof(buf) bytes so the
>> >> > rest stays initialized and might contain bytes check_file()
>> >> > is looking for.
>> >> 
>> >> Looks reasonable to me.
>> >> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>> >> 
>> >> @Cyril a candidate for merge before the release.
>> >
>> > Alternatively we could use the return value from the SAFE_READ() instead
>> > of the buf_len. Also I suppose that we could check that we read at least
>> > something.
>> 
>> I wonder whether a check that strlen(STRING) bytes was read is
>> sufficient, and if it's more just FAIL the test? My understanding of the
>> test is that the data written beyond file's end isn't yet synced, so
>> if we can read more bytes that would already be an error?
>
> I would say yes, but it does not hurt to keep the check that the file
> data were not corrupted by the write after the file end. So maybe we
> just need to:
>
> 1. check that we read right size
> 2. check that the buffer has correct bytes

Ok. I'll change the patch and send a V2 later.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
