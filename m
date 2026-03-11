Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B1B112583A
	for <ltp@archiver.kernel.org>; Wed, 11 Mar 2026 14:54:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 00D6A3E4925
	for <ltp@archiver.kernel.org>; Wed, 11 Mar 2026 15:54:49 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 42A083CA401
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 15:54:30 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B08802001B0
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 15:54:29 +0100 (CET)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62BDW6KV1614605; Wed, 11 Mar 2026 14:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=/Uv27t
 Yn98XDSB38z7lUyk8Q8+4iczGkriK1tQhl6OE=; b=XkbPV7dEXPbfXeAxNVnKeL
 qb/tOvmP5ooDPMfFCVSy/O4713LKNo+Mfzqv8YJt4sABP80nbUBjozrq7/3x7hDk
 235a35BAb/eCLmHY+8zl4Ng5/wcHeN5alI/pEaoM3z7fhv18n8xu+Ly9iWzJCgIr
 sEe/r7cU5DVbELZs1cgesyPGQZfWHyg3zwVNql8ruQ3XY26ql8FjMRey+jnkH6/J
 Jn3ulbVmpF+Fb1gD71t3b9jJeln0GK8WJKbvONLiv6nq6BKU19vJ8ksPrNA6b5lF
 ipuZRwOE+LbRNiMDr9F20gQL6e3FycQpZxEDdR7TOsKhxXm7qkWOgEiRee19j15A
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvrfxw4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Mar 2026 14:54:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62BBPeiD029356;
 Wed, 11 Mar 2026 14:54:27 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4csp6utfp4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Mar 2026 14:54:27 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62BEsPis45285660
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Mar 2026 14:54:25 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 217AA20043;
 Wed, 11 Mar 2026 14:54:25 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C47CB20040;
 Wed, 11 Mar 2026 14:54:24 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown
 [9.111.35.104])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 11 Mar 2026 14:54:24 +0000 (GMT)
Date: Wed, 11 Mar 2026 15:54:23 +0100
From: Jan Polensky <japo@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, chrubis@suse.cz,
 Linux Test Project <ltp@lists.linux.it>
Message-ID: <abGCHyG8hVAJ8pla@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260309172057.272946-1-japo@linux.ibm.com>
 <20260309172057.272946-2-japo@linux.ibm.com>
 <20260310132522.GD39882@pevik> <20260310133639.GE39882@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260310133639.GE39882@pevik>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDEyMyBTYWx0ZWRfX3jGS8emCfu8b
 ejlVpHfJZzkOXjTfCiPc7iZaubyY3XKopDU5n9WRCyqUAYqfDs+nlQTTbWx+FEK1Ykif1yLf1vZ
 wlvJGrbkzOgGhTBxbSJLLF/fpDyK3bdt4OqqbTc9oIuZlNWvqwuAfbhoPE7gqtz99GH5ktmnoKH
 ZG5nPQjZVHGPXWcPq694oquz2EyqDWAGAGCDKryJMnSNXNHtA31Vgit6Smqrfi0qozIxgieOdij
 JnG+40csVwYdywZIOIy+gWLiAZnfHd0EJtFPAabwUGSAlwHbjcblhZStzmwl6Yva+FiHGROMOBg
 KsaR4nFsC4V0ffy8oDWsj57gb/mmAi6/zUUygL5syJvlYfuABBDfQxM3q6fNJnH/BhPzmxYR1NX
 sXZTLFYcVMr410tFkba5vhVfKyZCzOY7y70ASa/2YqA0OaqdJRMQmMjcMLEgzRdEwQCLyRo8sbw
 fFZQa4oOhhlxlgNDRMg==
X-Proofpoint-GUID: aBJWljbF08KG2062uhPflMp-4YnCzjld
X-Proofpoint-ORIG-GUID: aBJWljbF08KG2062uhPflMp-4YnCzjld
X-Authority-Analysis: v=2.4 cv=QoFTHFyd c=1 sm=1 tr=0 ts=69b18223 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=Gj5lycSe7jdTsZGJJ3wA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110123
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/3] fsetxattr02: Adapt test for kernel 7.0+
 socket xattr support
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBNYXIgMTAsIDIwMjYgYXQgMDI6MzY6MzlQTSArMDEwMCwgUGV0ciBWb3JlbCB3cm90
ZToKSGkgUGV0ZXIsCj4gSGkgSmFuLAo+Cj4gPiBIaSBKYW4sCj4KW3NuaXBdCj4KPiBJIGRvdWJs
ZSBjaGVja2VkIGtlcm5lbCB2ZXJzaW9uIGZvciBkYzA4NzZiOTg0NmQuCj4KPiAkIGdpdCB0YWcg
LS1jb250YWlucyBkYzA4NzZiOTg0NmQzZDQ4YmI4NTI4MzMyMTA2ZDFiMDUxNTc4YTAyCj4gbmV4
dC0yMDI2MDMwNQo+IG5leHQtMjAyNjAzMDYKPiBuZXh0LTIwMjYwMzA5Cj4KPiA9PiBJTUhPIGl0
IHdpbGwgYmUgZm9yIHY3LjEuIEFuZCBpbmRlZWQsIGN1cnJlbnQgTFRQIG1hc3RlciB3b3JrcyBv
biBvcGVuU1VTRQo+IDcuMC4wLXJjMi0yLmcwYmZjMWIwLWRlZmF1bHQga2VybmVsIGFuZCBmYWls
cyB3aXRoIHlvdXIgcGF0Y2guCj4KW3NuaXBdCj4KPiBJdCBzaG91bGQgYmUgdHN0X2t2ZXJjbXAo
NywgMSwgMCkgPj0gMAo+Cj4gS2luZCByZWdhcmRzLAo+IFBldHIKdGhhbmsgeW91IGZvciB0aGUg
aGludHMuIEnigJlsbCB0YWtlIHRoZW0gYWxsIGludG8gYWNjb3VudCwgcmV2aXNlIHRoZQpwYXRj
aGVzIGFjY29yZGluZ2x5LCBhbmQgc2VuZCBvdXQgYSB2MiBzaG9ydGx5LgoKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
