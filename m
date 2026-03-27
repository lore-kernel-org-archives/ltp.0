Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 777EE10F2865
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 18:26:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EBB0B3D85B3
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 19:26:36 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 08FA43DD1C3
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 19:26:04 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9C5D6200358
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 19:26:03 +0100 (CET)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62REWeAr3893308; Fri, 27 Mar 2026 18:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3rqeHR
 XFmCcfhcij4krun490/oapBrWicjK1gNefcSc=; b=IJHkc1Q7G14Vc3Pw+iuWML
 tsunWH/+CzdO0hG9fbsEcH1NqG8oiRYu9M/bBpC1aIj+p7Yl2yphmX3y6yZmZIXt
 E8Br9C9O12/wOE13GU5ADAXSIxkH0Pbha1z5MUZrAVj9nPTePcankHhV3eCVLpMN
 xbILezreGyjW9hANSeLS1357F4GOReZCqPWE6YFEBCzI1LciUN7KplaRZdlopyIc
 nqFCk+uisLIvVPG80J/Wj6F31zJoFtvRUVBj7qY1dImcr0G171IyZDtpc12e8Dfd
 NMLNJiyFR8D9bYy5qSvvmr4D220D0h0cLnTbDJSN7xu/glSeMAsRrUclB+IScJSA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktvadk3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Mar 2026 18:26:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62RGZ9Bt011789;
 Fri, 27 Mar 2026 18:26:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vkghkg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Mar 2026 18:26:00 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62RIPx6K31326684
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Mar 2026 18:25:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 36CE520049;
 Fri, 27 Mar 2026 18:25:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C89CF20040;
 Fri, 27 Mar 2026 18:25:58 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown
 [9.111.27.150])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 27 Mar 2026 18:25:58 +0000 (GMT)
Date: Fri, 27 Mar 2026 19:25:57 +0100
From: Jan Polensky <japo@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <acbLtetvCPGG89-y@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260327123351.GA1083266@pevik>
 <69c68890.7b0a0220.33fc19.bf70@mx.google.com>
 <20260327174338.GB1097030@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260327174338.GB1097030@pevik>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TJhdg_AZXr-evt6NnZ1CxBg0lsMFn1Wh
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c6cbb9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=NEAV23lmAAAA:8
 a=0_x2ONLpc28T4QpbDJcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEyNyBTYWx0ZWRfX5wQ2EG2K3vv3
 /8X6GMx/fOp8R/Ff1ojkSXZ3eifwZj/e9LzZMbzPI8Se02xWfFkZPI4mD9fdSuQABI48NZrKf8F
 fV86iiVLa3R1khPvQDI+029NoSEZLDoDHMitnNuXNjMNckZgqnjI63Qk6n0en0wsEMnKfynADkC
 KYf2EZ8fgZSTd81qCEp+3czoSOdGsLp6O6Yk20wPzENZ5Aqsf6yTLGa10QhfZUzowmmKGirGSsn
 WK5BDDBC50ANtmbxNIeCgEcBAHcb7D2cl29vygdq3wH3pWwEzd2H/RRe1ToYdKePE+s8dwlPz3p
 ffX0XYxiWb4V3xe20RTrn67XGBaaz3u7oiv6p9M9WHB7PfcX8F79G28odK281Ffjf4BTM7ahSib
 K02nnqDOpy77fbZlCtemoovAlKD56WaSpYAzrB8HdCc/ZUC3VlmoMqPzjqplm8F/P5FDa5lQoFw
 HqGHp6PkDV96P3YkRsQ==
X-Proofpoint-GUID: TJhdg_AZXr-evt6NnZ1CxBg0lsMFn1Wh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270127
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] editorconfig: add consistent formatting
 rules for LTP
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBNYXIgMjcsIDIwMjYgYXQgMDY6NDM6MzhQTSArMDEwMCwgUGV0ciBWb3JlbCB3cm90
ZToKPiA+IEhpIFBldHIsCj4KPiA+ID4gRllJIEkgYXNrZWQgZm9yIDQgaW4gdjEgWzFdLCBKYW4g
aGFkIG9yaWdpbmFsbHkgOCBhbmQgSSdtIG9rIHdpdGggZm9sbG93aW5nCj4gPiA+IGtlcm5lbC4g
SXQncyBqdXN0IG15IHBlcnNvbmFsIHByZWZlcmVuY2UgdG8gZGlzcGxheSB0YWIgYXMgNCBzcGFj
ZXMgYW5kIG5vdCA4Cj4gPiA+IChJTUhPIGVkaXRvcmNvbmZpZyBwbHVnaW5zIGRvbid0IGFsbG93
IGNlcnRhaW4gc2V0dXAgdG8gYmUgb3ZlcndyaXR0ZW4pLgo+Cj4gPiBTb3JyeSBJIG1pc3NlZCB0
aGF0LiBJJ20ganVzdCB3b25kZXJpbmcgaWYgZWRpdG9yIGNvbmZpZ3VyYXRpb24gaXMgYXBwbGll
ZAo+ID4gb25seSBmb3IgdmlzdWFsaXphdGlvbiBvciBhbHNvIGZvciB0eXBpbmcuIElmIGl0J3Mg
YXBwbGllZCBmb3IgdHlwaW5nIHRoZW4gd2UKPiA+IGNhbid0IHVzZSA0IGNoYXJzLCBvdGhlcndp
c2Ugd2Ugd2lsbCBoYXZlIG1hbnkgaXNzdWVzIHdpdGggY2hlY2twYXRjaC5wbCB3aGVuCj4gPiB2
ZXJpZnlpbmcgdGhlIHNvdXJjZSBjb2RlLgo+Cj4gVG8gYmUgaG9uZXN0IEkgZG9uJ3Qga25vdyAo
SSBoYXZlbid0IGluc3RhbGxlZCB0aGUgcGx1Z2luIGZvciBteSBlZGl0b3IgeWV0KS4KPiBCdXQg
SSdkIHN1c3BlY3QgdGhhdCBvbiBpbmRlbnRfc3R5bGUgPSB0YWIgaXQganVzdCBhZGRzIGEgdGFi
IGFuZCBpbmRlbnRfc2l6ZSA9IDgKPiBpcyBvbmx5IHRoZSByZXByZXNlbnRhdGlvbi4KPgo+IGh0
dHBzOi8vZ2l0aHViLmNvbS9lZGl0b3Jjb25maWcvZWRpdG9yY29uZmlnL3dpa2kvRWRpdG9yQ29u
ZmlnLVByb3BlcnRpZXMjaW5kZW50X3NpemUKPgo+IAlJbmRlbnRhdGlvbiBTaXplIChpbiBzaW5n
bGUtc3BhY2VkIGNoYXJhY3RlcnMpCj4KPiAJUG9zc2libGUgVmFsdWVzCj4KPiAJCWFuIGludGVn
ZXIKPiAJCXRhYgo+Cj4gCUlmIGluZGVudF9zaXplIGVxdWFscyB0byB0YWIsIHRoZSBpbmRlbnRf
c2l6ZSB3aWxsIGJlIHNldCB0byB0aGUgdGFiIHNpemUsCj4gCXdoaWNoIHNob3VsZCBiZSB0YWJf
d2lkdGggaWYgdGFiX3dpZHRoIGlzIHNwZWNpZmllZCwgb3IgdGhlIHRhYiBzaXplIHNldCBieQo+
IAllZGl0b3IgaWYgdGFiX3dpZHRoIGlzIG5vdCBzcGVjaWZpZWQuCj4KPiBJIHdvbmRlciBpZiBp
dCB3b3JrZWQgZm9yIHVzIHRvIHNldCBpbmRlbnRfc2l6ZSA9IHVuc2V0IGZvciBhbGwgaW5kZW50
X3N0eWxlID0gdGFiCj4gKG9mIGNvdXJzZSBub3QgZm9yIGluZGVudF9zdHlsZSA9IHNwYWNlKS4K
Pgo+IGh0dHBzOi8vZ2l0aHViLmNvbS9lZGl0b3Jjb25maWcvZWRpdG9yY29uZmlnL3dpa2kvRWRp
dG9yQ29uZmlnLVByb3BlcnRpZXMjY3VycmVudC11bml2ZXJzYWwtcHJvcGVydGllcwo+Cj4gCUZv
ciBhbnkgcHJvcGVydHksIGEgdmFsdWUgb2YgdW5zZXQgaXMgdG8gcmVtb3ZlIHRoZSBlZmZlY3Qg
b2YgdGhhdCBwcm9wZXJ0eSwKPiAJZXZlbiBpZiBpdCBoYXMgYmVlbiBzZXQgYmVmb3JlLiBGb3Ig
ZXhhbXBsZSwgYWRkIGluZGVudF9zaXplID0gdW5zZXQgdG8gdW5kZWZpbmUKPiAJaW5kZW50X3Np
emUgcHJvcGVydHkgKGFuZCB1c2UgZWRpdG9yIGRlZmF1bHQpLgo+Cj4gQEphbj8KPgo+IEtpbmQg
cmVnYXJkcywKPiBQZXRyCkhpIFBldHIsCgpHb29kIGNhdGNoLCB0aGUgRWRpdG9yQ29uZmlnIHdp
a2kgaXMgZXhwbGljaXQgaGVyZToKCi0gaW5kZW50X3NpemUgY2FuIGJlIGFuIGludGVnZXIgb3Ig
dGFiLgotIElmIGluZGVudF9zaXplID0gdGFiLCB0aGVuIGluZGVudF9zaXplIGJlY29tZXMgdGhl
IHRhYiBzaXplOgogIHRhYl93aWR0aCBpZiBzZXQsIG90aGVyd2lzZSB0aGUgZWRpdG9y4oCZcyBk
ZWZhdWx0IHRhYiBzaXplLgotIEFueSBwcm9wZXJ0eSBjYW4gYmUgc2V0IHRvIHVuc2V0IHRvIHJl
bW92ZSBpdHMgZWZmZWN0IChzbyB0aGUgZWRpdG9yCiAgZGVmYXVsdCBpcyB1c2VkKS4KClNvIHll
czogd2UgY291bGQgZG8gaW5kZW50X3N0eWxlID0gdGFiIHRvZ2V0aGVyIHdpdGgKaW5kZW50X3Np
emUgPSB1bnNldCBpZiB0aGUgZ29hbCBpcyDigJx0YWJzLCBidXQgZG9u4oCZdCBwcmVzY3JpYmUg
YQp3aWR0aOKAnS4KSWYgd2Ugd2FudCBjb25zaXN0ZW50IHZpc3VhbCB3aWR0aC9hbGlnbm1lbnQg
YWNyb3NzIGVkaXRvcnMsIGEgbW9yZQpleHBsaWNpdCBzZXR1cCB3b3VsZCBiZSBpbmRlbnRfc2l6
ZSA9IHRhYiBwbHVzIHRhYl93aWR0aCA9IDguCgpLaW5kIHJlZ2FyZHMsCkphbgoKLS0gCk1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
