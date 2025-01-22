Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A75C0218C
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 12:14:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 48B273C2FCD
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 13:14:04 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B6A43C227F
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 13:13:48 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=svens@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F15821034F93
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 13:13:45 +0100 (CET)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50M4FfxZ009565;
 Wed, 22 Jan 2025 12:13:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=ZfgSqV0FRWdsHEBU1nhRlcTwgGYYxp
 v+1JVkK0cnEqM=; b=c4s2RjpVX+WkEM3FRUou6J9WB11B6PyPWMa9eBf3NP+TTi
 xuGAdPYeX4/fYsQsEGGDuatB3ruxXl9z2+Vi7Y3MH0LhNmwN47E9G4oqPdoQlGbp
 RhIFazcYNfdn+iCoV0Rp2gfcdF9Q7ahlN/eKKhUhDEdACtaszVyE22SWsYJL8Znp
 un87BrUkeWRp23y7CkNeMIefQfMfzhxNZ+520l4booD0ek0lPo81bFeZFkpoM8tx
 SkNApGRjL5Tb8dXwlxL6YTm8S1BYz7jS+zuo3SBBRGKMw9J1Si4wX4AROBB6c61B
 j7lgLi7mHaamSOa02WgsqS/3KiUgsAnVjMnPml4g==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44aee1cx14-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Jan 2025 12:13:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50M9oNAT029610;
 Wed, 22 Jan 2025 12:13:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448qmngb29-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Jan 2025 12:13:42 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50MCDeY156230220
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Jan 2025 12:13:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A73442004B;
 Wed, 22 Jan 2025 12:13:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9054020040;
 Wed, 22 Jan 2025 12:13:40 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 22 Jan 2025 12:13:40 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Cyril Hrubis <chrubis@suse.cz>
In-Reply-To: <Z5DQFuQiIAGAqtK4@yuki.lan> (Cyril Hrubis's message of "Wed, 22
 Jan 2025 12:01:42 +0100")
References: <20250122100915.3126008-1-svens@linux.ibm.com>
 <20250122102648.GA29598@pevik> <Z5DQFuQiIAGAqtK4@yuki.lan>
Date: Wed, 22 Jan 2025 13:13:40 +0100
Message-ID: <yt9da5bj6o7f.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GWYyy7bgzFIW_3ZxEXfhrrTBSoy-2Zan
X-Proofpoint-GUID: GWYyy7bgzFIW_3ZxEXfhrrTBSoy-2Zan
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_05,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=603 priorityscore=1501 bulkscore=0
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501220085
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
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
>> > mmap01 reported random test failures. Turns out the
>> > the temporary buffer in check_file() isn't initialized.
>> > The SAFE_READ reads less then sizeof(buf) bytes so the
>> > rest stays initialized and might contain bytes check_file()
>> > is looking for.
>> 
>> Looks reasonable to me.
>> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>> 
>> @Cyril a candidate for merge before the release.
>
> Alternatively we could use the return value from the SAFE_READ() instead
> of the buf_len. Also I suppose that we could check that we read at least
> something.

I wonder whether a check that strlen(STRING) bytes was read is
sufficient, and if it's more just FAIL the test? My understanding of the
test is that the data written beyond file's end isn't yet synced, so
if we can read more bytes that would already be an error?

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
