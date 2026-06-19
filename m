Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D349CCD98F6
	for <ltp@archiver.kernel.org>; Fri, 19 Jun 2026 11:19:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D7A243E4D94
	for <ltp@archiver.kernel.org>; Fri, 19 Jun 2026 13:19:15 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2AE623E1D49
 for <ltp@lists.linux.it>; Fri, 19 Jun 2026 13:18:59 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0FEA610006DB
 for <ltp@lists.linux.it>; Fri, 19 Jun 2026 13:18:57 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65J7mQpF1590109
 for <ltp@lists.linux.it>; Fri, 19 Jun 2026 11:18:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=CJ/xVY
 eRL/FjmtTFhZoniloeOMHTha1nWg3hVs/v0AA=; b=osDxMnhZPE4TRGOFJsfUCj
 hL4N0UzakvNomi1WWqgQEnZ/ZLCAdqpfEcbG14Hvy5yaqHgZ204itfexJKTea6q3
 aZ798Whvm+/U/eVJw9A8i7dWR4axZRvtcLTn43vNyD9RBEoqsFsBPfmYwybqXmyX
 Zy9T3A8ERo8ul1egFW95phnQRuIZZIL27GfuJujKFRVuEUeIADgc4C3O7ffHw1nu
 O148ej0hld+cKG3Pfo+rllvyRJ8+pnJrkHm8mUCZN5hqzEbj1WqFEKRjv1uGfgVi
 nvcoAtO67s3Ry8qAVINszSgVe3pKGf/Lzh2New/krz3L3sWiJItXxCcVD41MZqig
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqxd1m5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 19 Jun 2026 11:18:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JB4vYd011195
 for <ltp@lists.linux.it>; Fri, 19 Jun 2026 11:18:55 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172ggyy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 19 Jun 2026 11:18:55 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65JBIqfs22544920
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jun 2026 11:18:52 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E94E58052;
 Fri, 19 Jun 2026 11:18:52 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DF34958045;
 Fri, 19 Jun 2026 11:18:51 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 19 Jun 2026 11:18:51 +0000 (GMT)
MIME-Version: 1.0
Date: Fri, 19 Jun 2026 16:48:51 +0530
From: pavrampu <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
In-Reply-To: <bf5ed5dc-805c-4825-898f-1e4d3d280f2c@linux.ibm.com>
References: <bf5ed5dc-805c-4825-898f-1e4d3d280f2c@linux.ibm.com>
Message-ID: <391a3ab49fcb028efe878a1227103485@linux.ibm.com>
X-Sender: pavrampu@linux.ibm.com
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDEwNSBTYWx0ZWRfX1pR1eIdHOxJm
 08DkuOJM8x8g04QveIub1VejXc3jH+WtnW8JtzJzPff297CohmRCzS7StuiPD3LAMBObNLP+HR5
 eqwmX46Bn3mEc55YXro1Zc/oL7BW11MGtmQkinxkkFIHScHQFaxpB6re0qQdRb3DUiv6p8U3bJ9
 hRkAgXG5Ou0LW3d2agNGWcWTvzG+R4JkILbcvq62EMGUqjd4/G9UfABJgDcdFCmOFsPJ0/Z4sGa
 Mf0zWtVeqexVcio2vvUSBkSyugXlPOo+h1XO3SQn230VHpNXwR05mTXh0nKB89dKMW7l6GoV7Y8
 7ZewVYiuFrgFHmXbnG1oetB9qsGnxPWjh2G0SSbJKsOKadlWQ1Vdxs5IIVL0C1ab0Cm5YH2+h48
 AzoFeTSKt6Z0sSY8H/Z6a79NjuuHrhQyj6H9fA2w6G0kVojNiJLPcyGEUhOAstcsLpegsUKhS0D
 N7jdvknMgO951nXni0w==
X-Proofpoint-GUID: JGdfMz8yoRRnv2wb2WGKvqWeZOlGNExV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDEwNSBTYWx0ZWRfX1w4JbZfDt9di
 qjJjfFyr8gLZhJhWXX9y0j8+054/SpebBjJ08Ip1sfnI3NRm/nIcpewU99mG8/lFOuJ/Xx5aFpM
 573gqFc3AZdonLa0cHvxPeAcNUQIBiQ=
X-Proofpoint-ORIG-GUID: JGdfMz8yoRRnv2wb2WGKvqWeZOlGNExV
X-Authority-Analysis: v=2.4 cv=auGCzyZV c=1 sm=1 tr=0 ts=6a3525a0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=mPJGfP9KAAAA:20
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=oh7TSFFAK5QNMmBNzIEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zY0JdQc1-4EAyPf5TuXT:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190105
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Acceptance Status of libhugetlbfs Patches
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
Cc: pavithra.visweswara@ibm.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTWFpbnRhaW5lcnMsCgpJ4oCZbSB3cml0aW5nIHRvIGZvbGxvdyB1cCBvbiB0aGUgSHVnZXRs
Yi9saWJodWdldGxiZnMgdGVzdCBtaWdyYXRpb24gCnBhdGNoZXMgdGhhdCB3ZXJlIHNoYXJlZCBl
YXJsaWVyIG9uIHRoZSBMVFAgbWFpbGluZyBsaXN0LiBXZSB3YW50ZWQgdG8gCmNoZWNrIGlmIHRo
ZXJlIGhhcyBiZWVuIGFueSB1cGRhdGUgcmVnYXJkaW5nIHRoZWlyIHJldmlldyBhbmQgcG9zc2li
bGUgCnVwc3RyZWFtIGludGVncmF0aW9uLiBTaW5jZSB0aGUgcHJldmlvdXMgc3VibWlzc2lvbiwg
d2UgaGF2ZSBhbHNvIHBvc3RlZCAKdXBkYXRlZCB2ZXJzaW9ucyBvZiB0aGUgcGF0Y2hlcywgYWRk
cmVzc2luZyBmZWVkYmFjayBhbmQgaW1wcm92ZW1lbnRzLiAKUGxlYXNlIGZpbmQgdGhlIGxhdGVz
dCBwYXRjaCBsaW5rcyBiZWxvdyBmb3IgeW91ciByZWZlcmVuY2U6CgpmYWxsb2NhdGUtc3RyZXNz
LmMgLSBbTFRQXSBbUEFUQ0hdIFN1YmplY3Q6IFtQQVRDSCB2Nl0gCmh0dHBzOi8vZ2l0aHViLmNv
bS9saWJodWdldGxiZnMvbGliaHVnZXRsYmZzL2Jsb2IvbWFzdGVyL3Rlc3RzL2ZhbGxvY2F0ZV9z
dHJlc3MuYyAKZnJvbSBsaWJodWdldGxiZnMKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbHRwLzIw
MjUwOTI4MTIyNTQ0LjIxNzY3MzktMS1wYXZyYW1wdUBsaW51eC5pYm0uY29tLwoKdHJ1bmNhdGVf
cmVzZXJ2ZV93cmFwYXJvdW5kLmMgLSBbTFRQXSBbUEFUQ0hdIGh1Z2VtbWFwMzU6IE1pZ3JhdGlu
ZyAKbGliaHVnZXRsYmZzIHRlc3QgdjYgdHJ1bmNhdGVfcmVzZXJ2ZV93cmFwYXJvdW5kLmMKaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbHRwLzIwMjYwNDA0MTcxNjE0LjE2OTUzNzEtMS1wYXZyYW1w
dUBsaW51eC5pYm0uY29tLwoKdHJ1bmNhdGVfYWJvdmVfNEdCLmMgLSBbTFRQXSBbUEFUQ0hdIGh1
Z2VtbWFwMzY6IE1pZ3JhdGluZyB0aGUgCmxpYmh1Z2V0bGJmcy90ZXN0Y2FzZXMvdHJ1bmNhdGVf
YWJvdmVfNEdCLmMgdGVzdCB2NgpodHRwczovL2xvcmUua2VybmVsLm9yZy9sdHAvMjAyNjA0MDQx
NjUzNDYuMTY4OTA2MS0xLXBhdnJhbXB1QGxpbnV4LmlibS5jb20vCgpzdHJhZGRsZV80R0IuYyAt
IFtMVFBdIFtQQVRDSF0gW1BBVENIIDMvM10gW1BBVENIXSBNaWdyYXRpbmcgdGhlIApsaWJodWdl
dGxiZnMvdGVzdGNhc2VzL3N0cmFkZGxlXzRHQi5jIHYzCmh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2x0cC8yMDI1MTEzMDA1MTMzMS4yNjE0OS0xLXBhdnJhbXB1QGxpbnV4LmlibS5jb20vCgpwdHJh
Y2Utd3JpdGUtaHVnZXBhZ2UuYyAtIFtMVFBdIFtQQVRDSF0gaHVnZW1tYXA0MTogTWlncmF0ZSAK
cHRyYWNlLXdyaXRlLWh1Z2VwYWdlIGZyb20gbGliaHVnZXRsYmZzIHYzCmh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2x0cC8yMDI2MDQwNDEzNDgxNS4xNjM4NjE4LTEtcGF2cmFtcHVAbGludXguaWJt
LmNvbS8KCnNobS1nZXRyYXcuYyAtIFtMVFBdIFtQQVRDSF0gIFtQQVRDSCBWNl0gc3lzY2FsbHM6
IGlwYzogQWRkIHNobWdldCAKaHVnZXBhZ2UgdGVzdApodHRwczovL2xvcmUua2VybmVsLm9yZy9s
dHAvMjAyNjAzMTEwNzAyMzUuMjA2OTIxLTEtcGF2cmFtcHVAbGludXguaWJtLmNvbS8KCnRhc2st
c2l6ZS1vdmVycnVuLmMgLSBbTFRQXSBbUEFUQ0hdIGh1Z2VtbWFwMzc6IG1pZ3JhdGVkIAp0YXNr
LXNpemUtb3ZlcnJ1bi5jIGZyb20gbGliaHVnZXRsYmZzIHY0Cmh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2x0cC8yMDI2MDQwNDE1Mjc0Mi4xNjY0NzgzLTEtcGF2cmFtcHVAbGludXguaWJtLmNvbS8K
CnF1b3RhLmMgLSBbTFRQXSBbUEFUQ0hdIE1pZ3JhdGluZyB0aGUgbGliaHVnZXRsYmZzL3Rlc3Rj
YXNlcy9xdW90YS5jIC0gCnYyCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2x0cC8yMDI2MDQwNDEy
MTEyMC4xNjExMDMyLTEtcGF2cmFtcHVAbGludXguaWJtLmNvbS8KCnRydW5jYXRlLmMgLSBbTFRQ
XSBbUEFUQ0ggdjRdIE1pZ3JhdGluZyB0aGUgCmxpYmh1Z2V0bGJmcy90ZXN0Y2FzZXMvdHJ1bmNh
dGUuYyB0ZXN0Cmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MDMyMjA1MDg1OS42MzEx
MzktMS1zaGlyaXNoYUBsaW51eC5pYm0uY29tLwoKV2Ugd291bGQgZ3JlYXRseSBhcHByZWNpYXRl
IGFueSBmZWVkYmFjayBvciBndWlkYW5jZSBvbiB0aGUgY3VycmVudCAKc3RhdHVzIG9mIHRoZXNl
IHBhdGNoZXMuIFBsZWFzZSBsZXQgdXMga25vdyBpZiBhbnkgZnVydGhlciBjaGFuZ2VzIGFyZSAK
bmVlZGVkIGZyb20gb3VyIHNpZGUgdG8gZmFjaWxpdGF0ZSByZXZpZXcgYW5kIG1lcmdpbmcuClRo
YW5rIHlvdSBmb3IgeW91ciB0aW1lIGFuZCBzdXBwb3J0LgoKQmVzdCBSZWdhcmRzLApQYXZpdGhy
YSBQcmFrYXNoCgpPbiAyMDI0LTA5LTAyIDExOjI1LCBHZWV0aWthIE0gd3JvdGU6Cj4gSGVsbG8g
TWFpbnRhaW5lcihzKSwKPiAKPiBJIGhvcGUgdGhpcyBtZXNzYWdlIGZpbmRzIHlvdSB3ZWxsLgo+
IAo+IEkgYW0gd3JpdGluZyBvbiBiZWhhbGYgb2YgbXkgdGVhbSByZWdhcmRpbmcgdGhlIHBhdGNo
ZXMgd2UgcmVjZW50bHkKPiBzdWJtaXR0ZWQgdG8gdGhlIExUUCBtYWlsaW5nIGxpc3QuIFdlIHdh
bnRlZCB0byBmb2xsb3cgdXAgYW5kIGlucXVpcmUKPiBhYm91dCB0aGUgc3RhdHVzIG9mIHRoZXNl
IHBhdGNoZXMgYW5kIHRoZWlyIHBvdGVudGlhbCBpbnRlZ3JhdGlvbiBpbnRvCj4gdGhlIHVwc3Ry
ZWFtIHByb2plY3QuCj4gCj4gRm9yIHlvdXIgcmVmZXJlbmNlLCBoZXJlIGFyZSB0aGUgZmV3IGxp
bmtzIHRvIHRoZSBwYXRjaGVzIHdlIGhhdmUKPiBzZW50Ogo+IAo+IFtMVFBdIFtQQVRDSCB2Ml0g
W1BBVENIXSBIdWdldGxiOiBNaWdyYXRpbmcgbGliaHVnZXRsYmZzIHNobS1wZXJtcwo+IAo+IFtM
VFBdIFtQQVRDSCB2NF0gTWlncmF0aW5nIHRoZSBsaWJodWdldGxiZnMvdGVzdGNhc2VzL3NobS1n
ZXR0ZXN0LmMKPiB0ZXN0Cj4gCj4gW0xUUF0gW1BBVENIIHYzXSBIdWdldGxiOiBNaWdyYXRpbmcg
bGliaHVnZXRsYmZzIHRlc3QKPiB0cnVuY2F0ZV9yZXNlcnZlX3dyYXBhcm91bmQuYwo+IAo+IFtM
VFBdIFtQQVRDSCB2NF0gTWlncmF0aW5nIHRoZQo+IGxpYmh1Z2V0bGJmcy90ZXN0Y2FzZXMvc3Rh
Y2tfZ3Jvd19pbnRvX2h1Z2UuYyB0ZXN0Cj4gCj4gW0xUUF0gW1BBVENIIHYzXSBNaWdyYXRpbmcg
dGhlCj4gbGliaHVnZXRsYmZzL3Rlc3RjYXNlcy90cnVuY2F0ZV9zaWdidXNfdmVyc3VzX29vbS5j
IHRlc3QKPiAKPiBSZTogW0xUUF0gW1BBVENIIHYyXSBNaWdyYXRpbmcgdGhlCj4gbGliaHVnZXRs
YmZzL3Rlc3RjYXNlcy90cnVuY2F0ZV9hYm92ZV80R0IuYyB0ZXN0Cj4gCj4gV2Ugd291bGQgZ3Jl
YXRseSBhcHByZWNpYXRlIGFueSB1cGRhdGVzIHlvdSBjb3VsZCBwcm92aWRlIG9uIHdoZW4KPiB0
aGVzZSBtaWdodCBiZSByZXZpZXdlZCBhbmQgbWVyZ2VkLiBQbGVhc2UgbGV0IHVzIGtub3cgaWYg
dGhlcmUgYXJlCj4gYW55IGFkZGl0aW9uYWwgc3RlcHMgd2UgbmVlZCB0byB0YWtlIG9yIGlmIGZ1
cnRoZXIgbW9kaWZpY2F0aW9ucyBhcmUKPiByZXF1aXJlZC4KPiAKPiBUaGFuayB5b3UgdmVyeSBt
dWNoIGZvciB5b3VyIHRpbWUgYW5kIGFzc2lzdGFuY2UuCj4gCj4gQmVzdCBSZWdhcmRzLAo+IEdl
ZXRpa2EgTQoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xp
c3RpbmZvL2x0cAo=
