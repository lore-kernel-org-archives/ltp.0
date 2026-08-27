Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2EAC61DC4
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 13:39:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 037593D865A
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 15:39:00 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 92E0A3C71FD
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 15:38:44 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BC2B1140051D
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 15:38:43 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RCVd4w1871534; Thu, 27 Aug 2026 13:38:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=IRQtAi
 nyKIRxeKgFgsFNMEK+9+DI0jDMEhepZ2uFoiQ=; b=UMNMv+y1DYW8qZ15UPoL0O
 289uh2OKInkZ21sPsOaNFzBBh+GjMY6oOKA6CtOGlHfB8doMVeOF07rcc63Wf5O+
 MZ/TombkrkaRDHn+YgAddhGHFSbLUn9Ub14jkmdbKCIMNcyDi7vqW0mS6C/sKvEh
 vx4PeqKaQeYerOM6f5zf5Xma9hBRMZm+GH5sYvAkO/NSgd+gA2jm/TRH3Cou49JD
 m4ENHVwxHKctaAwXgYDTuqRMvImkRhb/XKFH5nWLw8hLNH6is008a+7xRaj3Y5Bf
 Fx/yOvaSKku3C5Gm+nJ85PcypVmKXkMYAdBScqsUOebYBW1WlWQLW4Zq4O4URvSw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726ewj1f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 13:38:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RDQLL8013308;
 Thu, 27 Aug 2026 13:38:40 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qgj4a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 13:38:40 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67RDcdLO24707622
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Aug 2026 13:38:39 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 545155806A;
 Thu, 27 Aug 2026 13:38:39 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 033405806F;
 Thu, 27 Aug 2026 13:38:39 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.61.98.69]) by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Aug 2026 13:38:38 +0000 (GMT)
Message-ID: <24ebd275e8d93d5557c709322e312f5a2b02d95d.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.com>
In-Reply-To: <20260827102252.GA442795@pevik>
References: <20260827030518.4078-1-linuxtestproject.agent@gmail.com>
 <6a8fdf90.52a3ce3c.38dd62.6301@mx.google.com>
 <20260827102252.GA442795@pevik>
Date: Thu, 27 Aug 2026 09:38:38 -0400
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a903de1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=606PMDH-QugdDZlWdhwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDExMyBTYWx0ZWRfX6BJk88WKsk8m
 YVRDYZ/FpH5DTOc4EnWG7depnYUgtNeDXIcZGLyLwCrshW+mjjh4SmJaxfZ5D521WD0v9iCiIQH
 l3SRztlCnG+la6gV92ftt0NeE4XPzHg=
X-Proofpoint-GUID: YZB80v8J521KwUUWAQgu0fswIZFNThL3
X-Proofpoint-ORIG-GUID: zmAZazvOIHnyO85bKfY7S99cmYAfUEv5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDExMyBTYWx0ZWRfX3UwVwlGxP32R
 Cwas2xAq0fwjJ+IDIdx8DotREfat+vrtoclHj8bMlLwVheBZ9wjCze+FqSZRCCTX7qfXltT4XqH
 /TqOtIpp/PTeeZTrW6kGSarePf6jVKhhd1Yc7im/N7wE6bxC+TvD53Y9mDrTGQVO0a9ZYKRkoAL
 t8QpXledXfP5PWVRE/WIRNZHLb52SW0W0zsB2bW71Xh+xCbeCXmm/etDS4wvvE0RqrpavJkfZIc
 lhfCy1jLOzDPQZrdgxW1ZanWmYLGfiOcW60nqvIRsXOSHH+OGGYj3GTzNQ+dsAY3lJX7iyMGEHY
 efs3tGdfzrUZbjgQzHEs5kweWhnHshunsvHkfHa3WkqSD2CFHGreomni6u4mLvp5luUfSB/UtzM
 fl8GrVrLK20ESTpnGrxAurWaqkymBjTyOZuHQKt+tpmEGXgWerJSmVsDvDIBHaBQyKTIxAVh/ND
 bFUwkrQcxyklV7ftQ0Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270113
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ima_tpm.sh: properly detect failure to verify the IMA
 measurement list
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
Cc: ltp@lists.linux.it, linuxtestproject.agent@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea, Petr,

Thank you for reviewing/testing/updating the v1/v2.

On Thu, 2026-08-27 at 12:22 +0200, Petr Vorel wrote:
> > @Petr can you please take a look?
> 
> Sure :). FYI I already did have a brief look yesterday, and I also triggered CI
> jobs for v1 and wait them to finish. Of course I'll rerun them for v2.
> 
> @Mimi FYI v1 patch triggers failure - it just calculate a different
> aggregate PCR-10. Although the commit subject is "properly detect failure" ..
> I'm not sure if this is a false negative or the current code on master just did
> not find error (false positive). As I said, I'll rerun v2 and let you know if
> it's the same.

I've been testing on real HW with a physical TPM, not in a virtual VM.  

Without a dont_measure policy rule to eliminate the "systemd_unit_file_t"
measurements, the number of measurements grows really fast.  The results of
test2 looks like:

ima_tpm 2 TINFO: verify PCR values
ima_tpm 2 TINFO: real PCR-10:
'ea84103155e8a91974c2706db94f91e396dad3f91430648224e19f17790716d8'
ima_tpm 2 TINFO: ignoring 5 violations
ima_tpm 2 TINFO: aggregate PCR-10:
'4608820a46bb8ad5e4d95b6f94273e76f1f12ca8c61b84d01aaed7b0fb226a74'
ima_tpm 2 TPASS: aggregate PCR value matched real PCR value (line: 7147/7634)

> 
> Testing on openSUSE Tumbleweed x86_64 VM with kernel: 7.1.8-1, virtualized TPM
> 2.0, evmctl 1.6.2. Working master [1], broken with your patch [2].

Interesting that with this simple patch, test2 now fails.

Mimi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
