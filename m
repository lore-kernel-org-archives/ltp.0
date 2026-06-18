Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDCBCD98ED
	for <ltp@archiver.kernel.org>; Thu, 18 Jun 2026 11:53:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5403A3E587C
	for <ltp@archiver.kernel.org>; Thu, 18 Jun 2026 13:53:45 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F35403E586C
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 13:53:29 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3B8A2200246
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 13:53:28 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IBIhnI3431119; Thu, 18 Jun 2026 11:53:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=DDCrVFJSiggxg55Yv67ELFAXcFrNBd
 12gBLUmtWivUE=; b=jAPFPf1fhW/dxNxz4ivba8FawmhsDC2I8E81r/15XT7avK
 DhzZuUolps5E3yrW9/JY0vGil2FUsCa4docE7BfsCLt5xd2Rr4U8SbGAWqgI0yao
 kBKJCBbHzbJbe1ptZqQ1XETbUQx9IopXz/7II1Sovqo4swRZbc0UZb14IhqJjCYP
 0HEPy4pdqKWlaTJrswYv/f3noT0ALN0HSTGpIw2bdVzxnsDSF0Z6Hy7+TzgLvT+O
 4nvZUXO3TH27qPV9Vx8Th65PxfZgTPiewIUFL8CfILqFKSV6Aw5NtupSNc+OUtdq
 sMHJ0nuOR68vJ7DFG4hJgBBmPsiSIPsWC8AZRcKg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4euequ7v6d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jun 2026 11:53:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65IBnb4O011336;
 Thu, 18 Jun 2026 11:53:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172bgm7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jun 2026 11:53:25 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65IBrNlm16843032
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jun 2026 11:53:23 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E0FB2004B;
 Thu, 18 Jun 2026 11:53:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4145520040;
 Thu, 18 Jun 2026 11:53:23 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown
 [9.111.46.88]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 18 Jun 2026 11:53:23 +0000 (GMT)
Date: Thu, 18 Jun 2026 13:53:21 +0200
From: Jan Polensky <japo@linux.ibm.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ajPcMQprnR4HJfAi@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <6a32b644.f32a6769.150c63.1270@mx.google.com>
 <6a32baec.95d0a0ea.22b4a3.6ffe@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a32baec.95d0a0ea.22b4a3.6ffe@mx.google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExMCBTYWx0ZWRfXw+APs15u1mma
 5OGdPgBu0e9UHlBdmGXjJ2h80XWYX+OjWVdGMiWWwh4uCH8yh66tVsUQCCi3jC8Ev7nIFT/mic+
 fNV8XWr5B0zTD5FHK325uFtsAf40ybQ=
X-Proofpoint-ORIG-GUID: jhfBUayhIcAaMxLZb_S_qIoEogUFtl-h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExMCBTYWx0ZWRfX2S34BWJSBqXy
 dgoLepn/670IG0X8U4AX66x0jZw/KanZJqHFCM1GUpnejuyzBAxBzTzVQEQtTvuZE8EAhm+pZXa
 r/rRDe6J2NJby52u3ij+5LZSGIUWAGp7o7nNXgGx4CEsnC0bDygiXwI7kua6hduSYRWeG5PsJTv
 jmuDKWCKg6ZlBmXciGoZaLsjYEOZIUX4TjkfubLPC4YNdOnHkZo0EGFJqo73lux8yyMEIpxl4az
 D58THkfczsinEqNZOP7T7Hcc1YB7EWPXSsPvsoXqD6H5sWHYth25nYW3Xp0rGFz4YRD8KPg1jvl
 Izy1rcKaJQbvfttMvkdCThbHj1xKi1Do1F6eUVhbJzrIHvhBIWKRzkHY3ypjHDO8CqExTAqsMjb
 WZYUzPe3JsW02DVmq/79VvZXxiiIkIT3+fB93bsvfELOkNWf3CWv00wdDwONvIMSa+ZVKAH89Up
 jQI/wx2LZ39kdsDfGxw==
X-Proofpoint-GUID: jhfBUayhIcAaMxLZb_S_qIoEogUFtl-h
X-Authority-Analysis: v=2.4 cv=L9gtheT8 c=1 sm=1 tr=0 ts=6a33dc36 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=iox4zFpeAAAA:8 a=Q46RfXtMypDhzTC_2doA:9 a=CjuIK1q_8ugA:10
 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180110
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
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

On Wed, Jun 17, 2026 at 03:19:07PM +0000, Andrea Cervesato wrote:
> > I'm just wondering how to implement it better.
> >
> > First of all, we should mention the commit that introduced fallocate()
> > support into exfat inside the patch commit message.
> >
> > Secondly, since the code was already working before v7.1, maybe we should
> > fill the file in exfat only for kernel >= 7.1. But I don't want to touch
> > the core library.
>
> Second update: .swap_activate is not implemented in the linux kernel
> for exfat and the commit causes EINVAL only for swap allocation. That
> is caused by bmap() due to the generic swap activation.
>
> So instead of working around the issue, we probably should have a feature
> in the kernel along with fallocate() support in exfat.
>
> Probably a kernel bug/missing feature.
>
> --
> Andrea Cervesato
> SUSE QE Automation Engineer Linux
> andrea.cervesato@suse.com
Hi Andrea,

just to add some context: the regression itself was on the kernel side.
The relevant upstream patch is
https://lore.kernel.org/all/20260603131950.321858-1-japo@linux.ibm.com/.
My understanding is that the kernel-side change did not resolve the issue
for the LTP test suite, and that there was also a separate LTP-relevant
aspect for exfat swapfiles, where actual data writes are required before
swapon() succeeds.

Best regards,
Jan

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
