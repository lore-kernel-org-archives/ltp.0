Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAAFCD3427
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 10:30:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE0D53E614B
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 12:30:26 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A1E5A3CC6A7
 for <ltp@lists.linux.it>; Thu,  7 May 2026 12:30:08 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AA54510000DD
 for <ltp@lists.linux.it>; Thu,  7 May 2026 12:30:07 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6477jMhW1311914
 for <ltp@lists.linux.it>; Thu, 7 May 2026 10:30:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ils7h6
 0UgSghNBwagI8DDmLcnvq6tBvOWWUrcLYSTuQ=; b=MmpeN1Vrg0ez/BwJWqVjdF
 TUVwvEBPOmgngx14wG5NT4IGM5/s5TFtWGwTUfs7eSNPbAV5ByegqFfMLt/UmZwl
 jpl6sUDZ5KzzvgNVAp7VLwoBB/fy/q1DARv7YJXsI65985wotma1cEsd1mjXh9Rl
 Kv8lIwin8a2n27HQHQ5kG9l3RrPxjDp0BCD8CQo92bH1F7XIDmHzC2ArMyVeLm0x
 9GNcKZPhS2SLXYZqZxgsOATDFxiscziu7YLxXvfUOLf3alT/cnsxkfPTT3W06DaQ
 dMivALWYAj+HwwwFJS2ND3yOlm7jNvXe2GBsc9YJUh+ywPKjtb4Kr4Af/kkXnYAw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y4vp7p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 07 May 2026 10:30:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 647AOV4v024335
 for <ltp@lists.linux.it>; Thu, 7 May 2026 10:30:04 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtgjh57-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 07 May 2026 10:30:04 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 647AU4Ec27656718
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Thu, 7 May 2026 10:30:04 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 51D5758053
 for <ltp@lists.linux.it>; Thu,  7 May 2026 10:30:04 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7DC395805D
 for <ltp@lists.linux.it>; Thu,  7 May 2026 10:30:03 +0000 (GMT)
Received: from [9.43.101.71] (unknown [9.43.101.71])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Thu,  7 May 2026 10:30:03 +0000 (GMT)
Message-ID: <268b4fce-f752-4c6b-95cb-c4d005a7ba87@linux.ibm.com>
Date: Thu, 7 May 2026 16:00:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <20260428143614.69724-1-sachinp@linux.ibm.com>
 <aftwmBUir04jaik4@yuki.lan>
 <f5cb3a8d-8feb-45e7-b02b-2871808ac38e@linux.ibm.com>
Content-Language: en-US
From: Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <f5cb3a8d-8feb-45e7-b02b-2871808ac38e@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEwMCBTYWx0ZWRfXwuoNeIMfNXP3
 MPi1ptCyfEApkzrWtfm3OS1kSSMFKRdAHLlRzpgfJcrUPY08Kk0OunEFUusXVwqQbgWrAMZlJOv
 1vFoM8ZR+njJ0N7GFeInS3gx4/pcrgRnAJ9H4RkHaB8PqHN5/mD67qUc+tbn5NuyW2IESdkA5Jf
 j4NZ4XQ+9Usn3EUiV3b1KtDz6EcOxNxcUFqBcG0f+SnXDfU0p6pQhrxEK3sFr8ZM35s83WxQC5C
 riILGH+grhxXTDUGI+kpcQJZAvYpbnhctqVLrhQ1yjxfTkqM7G90+b1cCVD301lLZ4YoZt6YVg+
 o4AJ/sqc5MX2MwcSfgjgJNOPUAjxwt4NGZlbNbIoLj9K8BzV4zKkyZQH7ZPPPEM3VAR0Ib5bw1S
 nDa9vzonDY5TSb4XoJwhIusVMOb4T0zJEQ9fTrDLTklJFdRryQBzeTRDKgY4natgFwNW5NbIr9P
 +ewI3emfHd+2YlF9VlA==
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=69fc69ad cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=uiesr5jdU3kBX6LSi-UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: QF9wRjWjTndSUewCeUsSMuETLRvghfQD
X-Proofpoint-ORIG-GUID: QF9wRjWjTndSUewCeUsSMuETLRvghfQD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070100
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/2] doc: generate CVE catalog documentation
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

CgpPbiAwNy8wNS8yNiAzOjQ0IHBtLCBTYWNoaW4gU2FudCB3cm90ZToKPgo+Cj4gT24gMDYvMDUv
MjYgMTA6MTcgcG0sIEN5cmlsIEhydWJpcyB3cm90ZToKPj4gSGkhCj4+PiAtwqDCoMKgIHJtIC1y
ZiBodG1sLyBidWlsZC8gX3N0YXRpYy9zeXNjYWxscy5yc3QgX3N0YXRpYy90ZXN0cy5yc3QgCj4+
PiBzeXNjYWxscy50YmwgXAo+Pj4gK8KgwqDCoCBybSAtcmYgaHRtbC8gYnVpbGQvIF9zdGF0aWMv
c3lzY2FsbHMucnN0IF9zdGF0aWMvdGVzdHMucnN0IAo+Pj4gX3N0YXRpYy9jdmUucnN0IHN5c2Nh
bGxzLnRibCBcCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgJHthYnNfdG9wX2J1aWxkZGlyfS9tZXRh
ZGF0YS9sdHAuanNvbgo+PiBUaGlzIHNob3VsZG4ndCBiZSBhZGRlZCBoZXJlLiB0aGUgbHRwLmpz
b24gaXMgY2xlYW5lZCB1cCBieSB0aGUKPj4gbWV0YWRhdGEvTWFrZWZpbGUuCj4gTXkgYmFkLCBw
cm9iYWJseSBhbiBvdmVyc2lnaHQgb24gbXkgcGFydC4gV2lsbCByZW1vdmUuCkFjdHVhbGx5IHRo
aXMgY2hhbmdlIChyZW1vdmUgbHRwLmpzb24pIGlzIG5vdCBpbnRyb2R1Y2VkIGJ5IG15IHBhdGNo
LgpUaGlzIHdhcyBhbHJlYWR5IHByZXNlbnQgYW5kIHdhcyBhZGRlZCB2aWEgY29tbWl0IDg2ZGUw
NzdmYjEyOC4KCi0tIApUaGFua3MKLSBTYWNoaW4KCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
