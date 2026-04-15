Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B91A1F419BB
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 13:58:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 755043E59C9
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 15:58:53 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 05CCF3D0284
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 15:58:35 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2A928600199
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 15:58:33 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63ELP1FS1843301; Wed, 15 Apr 2026 13:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ONmR1T
 mt5WKBI7s7sh7qvsYzMRkjDsyvxq5jSbLQPQc=; b=ZnQEpXBhUdacb5+xZjDWYJ
 R9DW7+/pQNx5tpOV1zXaVyRXFd0IaLUxSNZ1YNrDmEzpBrIelrJ7SbTSh3GR34Dd
 ZmcKJZO0QGewioqWwE/0hV+vi3rwgBqg/SfrrzVYTEcW/PRaHaiWBEizN8aIhkXA
 SeRmH1fJL/wS+9FgC7UyHrwDBbbvu6ymZ1vZ7dDnr46Amwc5uZCIEB/9YzC1dB30
 oCzz3Yop3PMommzVJgeGWmqb58IAPldeUAOB+paOQO+tu0Kya0q4qU31RedwG9gy
 V8nSeijjwsbt3hzVlyXAHHKKrRcu0DiHBZ3FmBBJFwr2vAkxiRLX4cInYfdv4PGA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89mrd4e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Apr 2026 13:58:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63FCnTJq003594;
 Wed, 15 Apr 2026 13:58:30 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg1mnefh6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Apr 2026 13:58:30 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63FDwThv21889538
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Apr 2026 13:58:29 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C482D58059;
 Wed, 15 Apr 2026 13:58:29 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A4D5558065;
 Wed, 15 Apr 2026 13:58:28 +0000 (GMT)
Received: from [9.43.127.43] (unknown [9.43.127.43])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 15 Apr 2026 13:58:28 +0000 (GMT)
Message-ID: <b4653e3f-ac9b-4a24-8d3f-51677c488e8c@linux.ibm.com>
Date: Wed, 15 Apr 2026 19:28:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20260324052241.21455-1-sachinp@linux.ibm.com>
 <ad9b-xRQjTkyH20Q@yuki.lan>
Content-Language: en-US
From: Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <ad9b-xRQjTkyH20Q@yuki.lan>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDEyOCBTYWx0ZWRfX8GpQhdS5iPz3
 vzJ0mySvQHFoAYHoAPOjiz5/Zc2vounxDB6PORSAyiiC0czzY8oTj6GXbFForn/Ka/+AL4UUqS6
 FXyBKzWHyXIoIGSLmmSf40bEZvhoECUJqbdilW9MTFGAxBW+CTNgnQVZrZl/I1rF39ckp682D68
 rNpU/wro5P9v/xLeqkY88dmQopbcPiopT2MR7unvunI4fQ1wXK9ZLCzUB2BGF7yqjL98tVtVD9R
 /DasGysOjl7tKiYfODeTpgDIndj1pTm0kIIGx78ZCgS4vq+Xcdsvkla7dxzo0HjphKJDA914b1z
 8LssDfOrg6HO1AHBiEPXkCg8953ZNZbhmrJN8v7uY7RhPisuZhSNG5gq0dkjaJP+/8lcnYsB5Zx
 eMmMLQpWW6jkxosiOMXte8DVORWrB06gx/CESR8ABFjLo/FEp2c3+gp4waFhv73GzqxsT+VvYqM
 J4OsjLpdEhG7A/Klq8A==
X-Authority-Analysis: v=2.4 cv=eJ4jSnp1 c=1 sm=1 tr=0 ts=69df9987 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=lmcEPCnMQJ3jnEWtiGMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: sLxrdiuSRcx2xO_RPJ_Qq8Tl59h38yfx
X-Proofpoint-ORIG-GUID: sLxrdiuSRcx2xO_RPJ_Qq8Tl59h38yfx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604150128
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/3] io_uring READ(V), WRITE(v) operation tests
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

CgpPbiAxNS8wNC8yNiAzOjA1IHBtLCBDeXJpbCBIcnViaXMgd3JvdGU6Cj4gSGkhCj4gSSd2ZSBt
ZXJnZWQgMS8zIGFuZCAzLzMgc2luY2UgdGhlc2UgdHdvIHBhdGNoZXMgd2VyZSByZWFkeSwgdGhh
bmtzLiBJCj4gd2lsbCBhZGQgYSBmZXcgbWlub3IgY29tbWVudHMgZm9yIDIvMy4KVGhhbmsgWW91
IEN5cmlsLgogwqBJIHdpbGwgc2VuZCBhbiB1cGRhdGVkIHBhdGNoIGZvciAyLzMuCgotLSAKVGhh
bmtzCi0gU2FjaGluCgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
