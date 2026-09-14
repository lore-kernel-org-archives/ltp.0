Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3344BC88E50
	for <ltp@archiver.kernel.org>; Mon, 14 Sep 2026 11:59:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D6453E90AC
	for <ltp@archiver.kernel.org>; Mon, 14 Sep 2026 13:59:55 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26E163E90A9
 for <ltp@lists.linux.it>; Mon, 14 Sep 2026 13:58:50 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9FDB21A009B2
 for <ltp@lists.linux.it>; Mon, 14 Sep 2026 13:58:47 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EA1TxV4027114; Mon, 14 Sep 2026 11:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=KbgZ8Vp/YWyg2vgTJM/OOYTD/Q4m
 mnkr2OGtQOLgBMo=; b=MuTdRdlE3sUZXCt2XBo3pbsxLkqePQ/MeuYkxU3OIh07
 PFCEX1aDndzjh6mJlVG7b2rRYqxjFZr+pcGnxh7Zryx3FejMSLnSlbljeadYSQeM
 1aOOAxqI5K9PjBiF5AYAth6y0ElcwRFATzuGnH0dWzLK2NvNKqpbcsz7H5l0qxLM
 rKUbTbVt/YQiWqtV6uh+JF7ZtwH7ucbZGROspA5eIaeonSvtl9kOW+DFZCDEkmKW
 2ZeG+FqrAgB4avAMuVUabLK+9Ne1cNnq4X1EnzftYJX9w5Bs2IRoN6HkYEtJIA49
 KAbCgr7orikyo3FQbMFXlA0aoZpI+KBG2B1uIGHGxQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdq14n4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 11:58:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E9o5K82098855; Mon, 14 Sep 2026 11:58:44 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gnkry5jnh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 11:58:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68EBwfjF47055232
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Sep 2026 11:58:41 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 165CA2004D;
 Mon, 14 Sep 2026 11:58:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F256020043;
 Mon, 14 Sep 2026 11:58:40 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ehn-de.ibm.com (unknown
 [9.224.74.129]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 14 Sep 2026 11:58:40 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon, 14 Sep 2026 13:58:32 +0200
Message-ID: <20260914115838.202410-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE2NCBTYWx0ZWRfX3RC9h/LOnWCV
 3sTSnldyykXBKX2N/IuyVZyTFtmMhLNcyay75Ld+K/6WBhUObalf3zfF4TI8PeWUz2hdzupOUdv
 JUVQhJGgsXlMKcgWvh3wxod1V6qhuDrUZCjX4vw0PL961h9V0NZTnD0hsX+rkfsUjdRJw7jIbfq
 5jhJX+seuTmTjAkjOuLixZq/uRF9P6sLxoXJ9fvDwiBHbQTtGAjIAKzpbwsEq2ZeGnC5sFIHmNS
 g6AVOhMer0erQ+gzZ3+0oc99zLTNxj0XO79bqSVSrxoz2fCLSSWW8+S0w93Yauc7tX+4nk/mQIH
 U2XctSnT4cCWlo/2fFPFdzZQMYCSmV3h9WFTSwm4tJmOAbfTLthetvjj+KnpQRIFspMBDsdKGb+
 8Yt7A0QnAdRt1r9XN5RzpbyGD8WdYQxyWZlL9HyAVxlZBLi2JDAj2uyooM/SDmHjIgytHkxBJ92
 cLpJD/x7kwAGiQhwrWQ==
X-Proofpoint-GUID: 8a2Vzt-rhlimXE0qPhM6WDu2pt9xEJoq
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aa7e175 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=3hWzLWSJvJN7wsyGx_gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 8a2Vzt-rhlimXE0qPhM6WDu2pt9xEJoq
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE2NCBTYWx0ZWRfX/w4KQZRWfE93
 7sNAesxUn2epnNK9tNc3gOxatmMfNdYhM2RHcpUDGksAI6m4EiShi4cv6r3zjnt87gukG5fakXy
 IAu/43sdhEMPPVzwZgpbqU6t4xlsFvw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140164
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 0/3] Handle FORCE_PTRACE in thp04 and add ptrace
 coverage
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

dGhwMDQgaXMgYSBDVkUtMjAxNy0xMDAwNDA1IHJlZ3Jlc3Npb24gdGVzdC4gSWYgZGlyZWN0Ci9w
cm9jL3NlbGYvbWVtIHdyaXRlcyBhcmUgYmxvY2tlZCBieSBDT05GSUdfUFJPQ19NRU1fRk9SQ0Vf
UFRSQUNFPXksCnRoZSBDVkUgY2Fubm90IGJlIHRyaWdnZXJlZCBhbmQgdGhwMDQgc2hvdWxkIHJl
cG9ydCBUQ09ORi4KCkFkZCBzZXBhcmF0ZSBwdHJhY2UgdGVzdHMgZm9yIHRoZSBDT05GSUdfUFJP
Q19NRU1fRk9SQ0VfUFRSQUNFIGJlaGF2aW9yCmluc3RlYWQ6CgotIHB0cmFjZTEyIGNoZWNrcyB0
aGF0IHdyaXRpbmcgdG8gL3Byb2Mvc2VsZi9tZW0gaXMgcmVqZWN0ZWQgd2l0aCBFSU8uCi0gcHRy
YWNlMTMgY2hlY2tzIHRoYXQgYSBwYXJlbnQgY2FuIHdyaXRlIHRvIGEgdHJhY2VkIGNoaWxkJ3Mg
bWVtb3J5IHZpYQogIC9wcm9jL3BpZC9tZW0uCgpCb3RoIHB0cmFjZSB0ZXN0cyB1c2UgcmVhZC1v
bmx5IG1hcHBpbmdzLCBzbyB0aGUgd3JpdGVzIHJlcXVpcmUKRk9MTF9GT1JDRSBhbmQgZXhlcmNp
c2UgdGhlIENPTkZJR19QUk9DX01FTV9GT1JDRV9QVFJBQ0UgZW5mb3JjZW1lbnQuCgpUZXN0ZWQg
b24gczM5MHggd2l0aCBDT05GSUdfUFJPQ19NRU1fRk9SQ0VfUFRSQUNFPXk6CgotIHRocDA0OiBU
Q09ORiAoZGlyZWN0IC9wcm9jL3NlbGYvbWVtIHdyaXRlcyBibG9ja2VkKQotIHB0cmFjZTEyOiBU
UEFTUwotIHB0cmFjZTEzOiBUUEFTUywgMTAwIGl0ZXJhdGlvbnMKCkZvbGxvdy11cCB0byB0aGUg
cHJldmlvdXMgdGhwMDQgcHRyYWNlIG1vZGUgZGlzY3Vzc2lvbjoKaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsLzIwMjYwNzA5MTc1OTI3LjI2ODY3Ny0xLWphcG9AbGludXguaWJtLmNvbS8KCkNo
YW5nZXMgaW4gdjc6Ci0gdGhwMDQ6IGNhc3QgcHJvYmVfcHRyIHRvICh2b2lkICopIGluIFNBRkVf
TVBST1RFQ1QgY2FsbAotIHB0cmFjZTEzOiB1c2UgUEFUSF9NQVggZm9yIHBhdGggYnVmZmVyOyBh
ZGQgPGxpbWl0cy5oPgotIHB0cmFjZTEzOiBmaXggV0lGRVhJVEVEIHN1Y2Nlc3MgcGF0aCBvbiBs
YXN0IGl0ZXJhdGlvbgoKQ2hhbmdlcyBpbiB2NjoKLSB0aHAwNDogcHJvYmUgL3Byb2Mvc2VsZi9t
ZW0gb24gYSBzZXBhcmF0ZSBhbm9ueW1vdXMgbWFwcGluZyB0byBhdm9pZAogIENPVy1wb2xsdXRp
bmcgdGhlIGh1Z2UgemVybyBwYWdlIGJlZm9yZSB0aGUgcmFjZSB0ZXN0IHN0YXJ0cwotIHRocDA0
L3B0cmFjZTEyL3B0cmFjZTEzOiBmaXggU1BMSVRfU1RSSU5HIGNoZWNrcGF0Y2ggd2FybmluZ3MK
LSBwdHJhY2UxMi9wdHJhY2UxMzogbW92ZSBydW50ZXN0IGVudHJpZXMgYmVmb3JlIHRoZSBwd3Jp
dGUgYmxhbmsgbGluZQotIHB0cmFjZTEzOiBza2lwIHJhaXNlKFNJR1NUT1ApIG9uIGxhc3QgaXRl
cmF0aW9uIHNvIGNoaWxkIGV4aXRzIHZpYSBleGl0KDApCgpDaGFuZ2VzIGluIHY1OgotIHRocDA0
OiB1c2UgIT0gLTEgaW5zdGVhZCBvZiA+PSAwIGZvciBmZCB2YWxpZGl0eSBjaGVja3MgaW4gdGhw
X2NsZWFudXAoKQotIHRocDA0OiBjYXN0IFRTVF9SRVQgdG8gKHNzaXplX3QpIGJlZm9yZSBjb21w
YXJpbmcgd2l0aCBzaXplb2YoKQotIHB0cmFjZTEyOiB1c2UgIT0gLTEgaW5zdGVhZCBvZiA+PSAw
IGZvciBtZW1mZCB2YWxpZGl0eSBjaGVjayBpbiBjbGVhbnVwKCkKLSBwdHJhY2UxMjogY2FzdCBU
U1RfUkVUIHRvIChzc2l6ZV90KSBiZWZvcmUgY29tcGFyaW5nIHdpdGggc2l6ZW9mKCkKLSBwdHJh
Y2UxMzogZml4IHJhY2UgYmV0d2VlbiBQVFJBQ0VfSU5URVJSVVBUIGFuZCBjaGlsZCdzIGZpcnN0
IHJhaXNlKFNJR1NUT1ApOwogIHJlcGxhY2UgUFRSQUNFX0lOVEVSUlVQVCB3aXRoIGFuIGV4cGxp
Y2l0IGluaXRpYWwgcmFpc2UoU0lHU1RPUCkgaW4gdGhlIGNoaWxkCi0gcHRyYWNlMTM6IGNhc3Qg
VFNUX1JFVCB0byAoc3NpemVfdCkgYmVmb3JlIGNvbXBhcmluZyB3aXRoIHNpemVvZigpCi0gcHRy
YWNlMTM6IHJlbW92ZSByZWR1bmRhbnQgI2luY2x1ZGUgInRzdF9jaGVja3BvaW50LmgiIChhbHJl
YWR5IGluIHRzdF90ZXN0LmgpCi0gcHRyYWNlMTM6IHVwZGF0ZSBkb2MtY29tbWVudCB0byByZWZs
ZWN0IHRoZSBuZXcgc3RvcCBmbG93CgpDaGFuZ2VzIGluIHY0OgotIHRocDA0OiBwcm92ZSB0aGUg
L3Byb2Mvc2VsZi9tZW0gcHJvYmUgY2hhbmdlcyBtZW1vcnkgYmVmb3JlIHJ1bm5pbmcgdGhlIHJh
Y2UKLSB0aHAwNDogdGlnaHRlbiBkaXJlY3Qtd3JpdGUgcmVzdWx0IGhhbmRsaW5nIGFuZCBkb2N1
bWVudCBibG9ja2VkLXdyaXRlIGJlaGF2aW9yCi0gcHRyYWNlMTI6IGdhdGUgdGhlIHRlc3Qgb24g
Q09ORklHX1BST0NfTUVNX0ZPUkNFX1BUUkFDRT15Ci0gcHRyYWNlMTI6IHRyZWF0IHN1Y2Nlc3Nm
dWwgL3Byb2Mvc2VsZi9tZW0gd3JpdGVzIGFzIFRGQUlMIHVuZGVyIHRoZSByZXF1aXJlZCBjb25m
aWcKLSBwdHJhY2UxMzogdXNlIGEgdHJhY2VyLWNvbnRyb2xsZWQgUFRSQUNFX0lOVEVSUlVQVCBp
bml0aWFsIHN0b3AKLSBwdHJhY2UxMzogZml4IHRoZSBpdGVyYXRpb24gZGlhZ25vc3RpYyBhbmQg
Y2xlYW4gdXAgd2FpdC1zdGF0dXMgaGFuZGxpbmcKLSBwdHJhY2UxMzogdXNlIFBUUkFDRV9LSUxM
IGZvciBub3JtYWwgdGVybWluYXRpb24KCkNoYW5nZXMgaW4gdjM6Ci0gQWxsIHBhdGNoZXM6IEZp
eGVkIFJTVCBkb2MgZm9ybWF0dGluZyAoYWRkZWQgYmxhbmsgbGluZXMgYmVmb3JlIGxpc3RzKQot
IEFsbCBwYXRjaGVzOiBSZW1vdmVkIHJlZHVuZGFudCBjb21tZW50cyBwZXIgTFRQIGNvZGluZyBz
dHlsZQotIHRocDA0OiBSZW1vdmVkIGNvbW1lbnRzIHJlc3RhdGluZyBwb2ludGVyIGFyaXRobWV0
aWMKLSBwdHJhY2UxMjogS2VwdCBvbmx5IGludGVudC1mb2N1c2VkIEZPTExfRk9SQ0UgY29tbWVu
dAotIHB0cmFjZTEzOiBSZW1vdmVkIHVudXNlZCBzaGFyZWRfc3RhdGUucmVzdWx0IGZpZWxkCi0g
cHRyYWNlMTM6IFJlbW92ZWQgbWlzbGVhZGluZyAicHJldmlvdXMgaXRlcmF0aW9uIiBjb21tZW50
Ci0gcHRyYWNlMTM6IENsYXJpZmllZCBpdGVyYXRpb24gY291bnRlciBpbiBURkFJTCBtZXNzYWdl
IHRvIHNob3cgd2hpY2ggd3JpdGUgaXMgYmVpbmcgdmVyaWZpZWQKLSBwdHJhY2UxMzogS2VwdCBv
bmx5IGludGVudC1mb2N1c2VkIEZPTExfRk9SQ0UgY29tbWVudCBhbmQgc3luY2hyb25pemF0aW9u
IHBhdHRlcm4gY29tbWVudAoKQ2hhbmdlcyBpbiB2MjoKLSB0aHAwNDogUmVtb3ZlZCAuZm9ya3Nf
Y2hpbGQgZmxhZyAobm90IG5lZWRlZCB3aXRob3V0IGFjdHVhbCBmb3JrKQotIHRocDA0OiBDaGFu
Z2VkIE1BUF9TSEFSRUQgdG8gTUFQX1BSSVZBVEUgZm9yIGNoaWxkIHN0YXRlIG1hcHBpbmcKLSB0
aHAwNDogQWRkZWQgbWlzc2luZyAjaW5jbHVkZSA8c3RyaW5nLmg+IGZvciBtZW1zZXQoKQotIHRo
cDA0OiBSZW5hbWVkIHN0cnVjdCBjaGlsZF9zdGF0ZSDihpIgc3RydWN0IHRocF9zdGF0ZSAobm8g
bG9uZ2VyIHVzZXMgZm9yaykKLSB0aHAwNDogUmVuYW1lZCBjaGlsZCDihpIgc3RhdGUsIGNoaWxk
X3NldHVwKCkg4oaSIHRocF9zZXR1cCgpLCBjaGlsZF9jbGVhbnVwKCkg4oaSIHRocF9jbGVhbnVw
KCkKLSBwdHJhY2UxMjogUmVtb3ZlZCBkZXByZWNhdGVkIFtEZXNjcmlwdGlvbl0gbGluZSBmcm9t
IGRvYyBibG9jawotIHB0cmFjZTEyOiBSZXBsYWNlZCBiYXJlIHdyaXRlKCkgd2l0aCBURVNUKCkg
bWFjcm8sIHVzaW5nIFRTVF9SRVQvVFNUX0VSUgotIHB0cmFjZTEyOiBBZGp1c3RlZCBzZXR1cCBj
b21tZW50IHRvIGNsYXJpZnkgcGFnZSBpbml0aWFsaXphdGlvbiBzZXF1ZW5jZQotIHB0cmFjZTEz
OiBSZW1vdmVkIGRlcHJlY2F0ZWQgW0Rlc2NyaXB0aW9uXSBsaW5lIGZyb20gZG9jIGJsb2NrCi0g
cHRyYWNlMTM6IEFkZGVkIG1pc3NpbmcgI2luY2x1ZGUgPHN0cmluZy5oPiBmb3IgbWVtc2V0KCkK
LSBCb3RoIHB0cmFjZSB0ZXN0czogQWRkZWQgdG8gcnVudGVzdC9zeXNjYWxscwoKdjY6IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI2MDkwODE2NTQzMC4yNTE4OTctMS1qYXBvQGxpbnV4
LmlibS5jb20vCnY1OiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjA5MDgxMTEzMzIu
MTUwMzIzLTEtamFwb0BsaW51eC5pYm0uY29tLwp2NDogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
YWxsLzIwMjYwODEyMTMyOTAxLjIwMjYzMi0xLWphcG9AbGludXguaWJtLmNvbS8KdjM6IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI2MDcyMTIwMjQ1Mi4zMTU1ODEtMS1qYXBvQGxpbnV4
LmlibS5jb20vCnYyOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjA3MTYwOTUwMDQu
OTI3OTMtMS1qYXBvQGxpbnV4LmlibS5jb20vCnYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvMjAyNjA3MTQxNTA2MzEuMjUwOTcyLTEtamFwb0BsaW51eC5pYm0uY29tLwoKSmFuIFBvbGVu
c2t5ICgzKToKICB0aHAwNDogZ3JvdXAgcnVudGltZSBzdGF0ZSBhbmQgc2tpcCB3aGVuIC9wcm9j
L3NlbGYvbWVtIHdyaXRlcyBhcmUKICAgIGJsb2NrZWQKICBwdHJhY2U6IGFkZCB0ZXN0IGZvciAv
cHJvYy9zZWxmL21lbSB3cml0ZSByZWplY3Rpb24KICBwdHJhY2U6IGFkZCB0ZXN0IGZvciAvcHJv
Yy9waWQvbWVtIHdyaXRlcyB1bmRlciBwdHJhY2UKCiBydW50ZXN0L3N5c2NhbGxzICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgICAyICsKIHRlc3RjYXNlcy9rZXJuZWwvbWVtL3RocC90aHAw
NC5jICAgICAgICAgICAgfCAxNzIgKysrKysrKysrKystLS0tLQogdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy9wdHJhY2UvLmdpdGlnbm9yZSB8ICAgMiArCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL3B0cmFjZS9wdHJhY2UxMi5jIHwgIDk1ICsrKysrKysrKwogdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy9wdHJhY2UvcHRyYWNlMTMuYyB8IDIxNSArKysrKysrKysrKysrKysrKysrKwogNSBm
aWxlcyBjaGFuZ2VkLCA0MzQgaW5zZXJ0aW9ucygrKSwgNTIgZGVsZXRpb25zKC0pCiBjcmVhdGUg
bW9kZSAxMDA2NDQgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9wdHJhY2UvcHRyYWNlMTIuYwog
Y3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcHRyYWNlL3B0cmFj
ZTEzLmMKCgpiYXNlLWNvbW1pdDogMTMyMzFhYTIyY2E0NTcyYTRkOTQ5YmZjNzhkOTMwNDUyNGYx
MzFhNwotLQoyLjU1LjAKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
