Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7483C43458
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 09:15:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 246213E5BBD
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 11:15:16 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9825E3C036C
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 11:14:46 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 58812600AB4
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 11:14:44 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A7mRXq3742702; Fri, 10 Jul 2026 09:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=SybNUC
 L255Xu4sNwnUwsMtq8enxA1E1nlxsho4dJEhM=; b=H22mx6W8wHnG1Y66zC6jQJ
 k3MMILPb50Jw8l5avl2Qu0JcnUGhUKQa7Y6dvPOMLk0gmh74I4++2dsEnuSrq0qB
 dD2xxmqNbBsPQN4OE2ExVnubac7j0inExG1wxbjiG9+bOJlO6pkZSMzeRNfrHNaK
 XXS/lWisEuzOTKigL6CBKmb5KcgvkhjNcRNRF+RyTZGLwbHzrFcqkhm66rq0PkVm
 AYvakHIdVJGRFI52yq/lX22wC7yNWqPBp4Qx3QDP/+oe8ImwCsKV80hCU036kGF4
 illhkQnzXinDuizndxaQVWHJPqiguZF6GGekoNw2yo6GivNGq1jEuYB342klRRUA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stt63sf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jul 2026 09:14:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66A94wmA028824;
 Fri, 10 Jul 2026 09:14:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvwhfxa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jul 2026 09:14:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66A9EeT243516322
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jul 2026 09:14:40 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C394720040;
 Fri, 10 Jul 2026 09:14:40 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF3EF2004E;
 Fri, 10 Jul 2026 09:14:39 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.124.87])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 10 Jul 2026 09:14:39 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri, 10 Jul 2026 14:44:37 +0530
Message-Id: <20260710091437.92148-2-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260710091437.92148-1-sachinp@linux.ibm.com>
References: <20260710091437.92148-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wSLQTDGQt7W4eq3eUfdUNtbCjst5Jf6Y
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA4NSBTYWx0ZWRfX9Gy6ylDCjxgj
 +UsApkb3G4gfaO4ZMG0PXe578xDtWXRwtW646guNlm/IRK8F65ik+zSgQBfR/ZxGnHMonf0Vutu
 5bEw6gcdBAOH2aqp5ap5MYjx36H5cm0=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a50b803 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=iox4zFpeAAAA:8
 a=VnNF1IyMAAAA:8 a=TyC3HsA0tWK9_jyjcpcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-GUID: wSLQTDGQt7W4eq3eUfdUNtbCjst5Jf6Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA4NSBTYWx0ZWRfXx2xOH9EpBGC5
 F7fXq31eH0ZqHK4Y870vQgovloxjUiL9TlmlPlbaMiyg0uKWxD4igR76U4MKMhsoqH5OvAmUSjb
 +ga5wkXkyjHS0BmNqjfopkCVOSyv26AEXu6R77rG0I2MuLAopTVuAv3GzNilXngUzJv//vlCti9
 SmJ5u7IH35Zr/4hk95/hV7oOdxQt3EpNgtd+Od/GexzlNco55DI3279fXe19TN3cb0101LhGaxU
 MIYul4zizOso7KDP582suqV74603FZqJMZ7nRhzcIEXNdvPfpHSXBSrGxm+9N7UBPs2rfxB8Wcs
 IvtNbYOzyLtOyt+I6W7Xpil8Fs/Qp7x/hVJKOVrG49TwdaxGcLrLGYj1sTXepmagyDHdgne1eFZ
 vQmXHfkNQlSs5Si6jsICt1HTEmtgWxRYDs/EwdY+jD8llq8O8zm2GYeDzMXQc+DJvRYAwFdi0c7
 qgfKJcp6zDVEC351V2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100085
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] mem/min_free_kbytes: refactor to use SAFE_FORK
 and simplify tune logic
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

VGhlIHRlc3QgbWl4ZWQgb2xkIGJhcmUtZm9yayBwYXR0ZXJucyB3aXRoIHRoZSBuZXdlciBMVFAg
QVBJLCBtYWtpbmcgaXQKaGFyZCB0byBmb2xsb3cgYW5kIGVhc3kgdG8gbWlzY291bnQgcGFzcy9m
YWlsIHJlc3VsdHMuICBFeHRyYWN0IHRoZSB0dW5lCnNlbGVjdGlvbiBpbnRvIHNldF9taW5fZnJl
ZV9rYnl0ZXMoKSwgcmVwbGFjZSByYXcgZm9yaygpIHdpdGggU0FGRV9GT1JLKCkKdGhyb3VnaG91
dCwgYW5kIGRyb3AgdGhlIG1hbnVhbCBTQUZFX1dBSVRQSUQgb24gdGhlIG1vbml0b3IgY2hpbGQg
4oCUIHRoZQpmcmFtZXdvcmsncyB0c3RfcmVhcF9jaGlsZHJlbigpIGhhbmRsZXMgaXQgYWZ0ZXIg
dGVzdF9hbGwoKSByZXR1cm5zLgoKU3VnZ2VzdGVkLWJ5OiBBbmRyZWEgQ2VydmVzYXRvIDxhbmRy
ZWEuY2VydmVzYXRvQHN1c2UuY29tPgpTaWduZWQtb2ZmLWJ5OiBTYWNoaW4gU2FudCA8c2FjaGlu
cEBsaW51eC5pYm0uY29tPgotLS0KdjIgLT4gdjM6Ci0gRXh0cmFjdGVkIHR1bmUgc2VsZWN0aW9u
IGludG8gYSBuZXcgc2V0X21pbl9mcmVlX2tieXRlcygpIGhlbHBlciwKICByZXBsYWNpbmcgdGhl
IG9wZW4tY29kZWQgaWYvZWxzZSBjaGFpbiBpbiB0ZXN0X3R1bmUoKS4KLSBSZXBsYWNlZCByYXcg
Zm9yaygpIHdpdGggU0FGRV9GT1JLKCkgaW4gdGVzdF90dW5lKCk7IHBpZCBhcnJheQogIGNvbGxh
cHNlZCB0byBhIHNpbmdsZSBwaWRfdCBzaW5jZSBlYWNoIGNoaWxkIGlzIHdhaXRlZCBpbmxpbmUu
Ci0gRHJvcHBlZCBTQUZFX1dBSVRQSUQgb24gdGhlIG1vbml0b3IgY2hpbGQgZnJvbSBtaW5fZnJl
ZV9rYnl0ZXNfdGVzdCgpOwogIHRzdF9yZWFwX2NoaWxkcmVuKCkgY2FsbGVkIGJ5IHRoZSBmcmFt
ZXdvcmsgYWZ0ZXIgdGVzdF9hbGwoKSByZXR1cm5zCiAgaGFuZGxlcyBpdCBpbnN0ZWFkLgotIFJl
cGxhY2VkIGJhcmUgTUlOKCkgb3Blbi1jb2RlIGluIHR1bmUgc2VsZWN0aW9uIHdpdGggdGhlIE1J
TigpIG1hY3JvLgotIERyb3BwZWQgbGVmdG92ZXIgVFBBU1MvVEZBSUwgZnJvbSB0aGUgcGFyZW50
J3Mgd2FpdCBibG9jazsKICByZXN1bHQgcmVwb3J0aW5nIHN0YXlzIHNvbGVseSBpbiBjaGVja19t
b25pdG9yKCkuIAoKdjEgLT4gdjI6Ci0gQWRkcmVzc2VkIHJldmlldyBjb21tZW50cyBieSBtb3Zp
bmcgVFBBU1MvVEZBSUwgcmVwb3J0aW5nCiAgaW50byBjaGVja19tb25pdG9yKCkgaW4gdGhlIGNo
aWxkIHByb2Nlc3MuCi0tLQogLi4uL2tlcm5lbC9tZW0vdHVuYWJsZS9taW5fZnJlZV9rYnl0ZXMu
YyAgICAgIHwgNjcgKysrKysrKysrKy0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDM0IGluc2Vy
dGlvbnMoKyksIDMzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwv
bWVtL3R1bmFibGUvbWluX2ZyZWVfa2J5dGVzLmMgYi90ZXN0Y2FzZXMva2VybmVsL21lbS90dW5h
YmxlL21pbl9mcmVlX2tieXRlcy5jCmluZGV4IGIxZDAwZTQ1My4uNGY5OTEwMjVhIDEwMDY0NAot
LS0gYS90ZXN0Y2FzZXMva2VybmVsL21lbS90dW5hYmxlL21pbl9mcmVlX2tieXRlcy5jCisrKyBi
L3Rlc3RjYXNlcy9rZXJuZWwvbWVtL3R1bmFibGUvbWluX2ZyZWVfa2J5dGVzLmMKQEAgLTQ0LDkg
KzQ0LDMwIEBAIHN0YXRpYyBpbnQgZWF0dXBfbWVtKHVuc2lnbmVkIGxvbmcgb3ZlcmNvbW1pdF9w
b2xpY3kpOwogc3RhdGljIHZvaWQgY2hlY2tfbW9uaXRvcih2b2lkKTsKIHN0YXRpYyB2b2lkIHNp
Z2hhbmRsZXIoaW50IHNpZ25vIExUUF9BVFRSSUJVVEVfVU5VU0VEKTsKIAorc3RhdGljIHZvaWQg
c2V0X21pbl9mcmVlX2tieXRlcyhpbnQgaSkKK3sKKwl1bnNpZ25lZCBsb25nIG1lbWZyZWUsIG1l
bXRvdGFsLCB0dW5lOworCisJc3dpdGNoIChpKSB7CisJY2FzZSAwOgorCQl0dW5lID0gZGVmYXVs
dF90dW5lOworCQlicmVhazsKKwljYXNlIDE6CisJCXR1bmUgPSAyICogZGVmYXVsdF90dW5lOwor
CQlicmVhazsKKwlkZWZhdWx0OgorCQltZW1mcmVlID0gU0FGRV9SRUFEX01FTUlORk8oIk1lbUZy
ZWU6Iik7CisJCW1lbXRvdGFsID0gU0FGRV9SRUFEX01FTUlORk8oIk1lbVRvdGFsOiIpOworCQl0
dW5lID0gTUlOKG1lbWZyZWUgLyAyMCwgbWVtdG90YWwgLyA1MCk7CisJCWJyZWFrOworCX0KKwor
CVRTVF9TWVNfQ09ORl9MT05HX1NFVChQQVRIX1ZNX01JTl9GUkVFX0tCWVRFUywgdHVuZSwgMSk7
Cit9CisKIHN0YXRpYyB2b2lkIG1pbl9mcmVlX2tieXRlc190ZXN0KHZvaWQpCiB7Ci0JaW50IHBp
ZCwgc3RhdHVzOworCXBpZF90IHBpZDsKIAlzdHJ1Y3Qgc2lnYWN0aW9uIHNhOwogCiAJc2Euc2Ff
aGFuZGxlciA9IHNpZ2hhbmRsZXI7CkBAIC01Niw3ICs3Nyw2IEBAIHN0YXRpYyB2b2lkIG1pbl9m
cmVlX2tieXRlc190ZXN0KHZvaWQpCiAKIAlwaWQgPSBTQUZFX0ZPUksoKTsKIAlpZiAocGlkID09
IDApIHsKLQkJLyogc3RhcnR1cCB0aGUgY2hlY2sgbW9uaXRvciAqLwogCQljaGVja19tb25pdG9y
KCk7CiAJCWV4aXQoMCk7CiAJfQpAQCAtNjYsNTAgKzg2LDI2IEBAIHN0YXRpYyB2b2lkIG1pbl9m
cmVlX2tieXRlc190ZXN0KHZvaWQpCiAJdGVzdF90dW5lKDEpOwogCiAJU0FGRV9LSUxMKHBpZCwg
U0lHVVNSMSk7Ci0JU0FGRV9XQUlUUElEKHBpZCwgJnN0YXR1cywgV1VOVFJBQ0VEIHwgV0NPTlRJ
TlVFRCk7Ci0KLQlpZiAoV0lGRVhJVEVEKHN0YXR1cykgJiYgV0VYSVRTVEFUVVMoc3RhdHVzKSAh
PSAwKQotCQl0c3RfcmVzKFRGQUlMLCAiY2hlY2tfbW9uaXRvciBjaGlsZCBleGl0IHdpdGggc3Rh
dHVzOiAlcyIsCi0JCQl0c3Rfc3Ryc3RhdHVzKHN0YXR1cykpOwotCi0JdHN0X3JlcyhUUEFTUywg
Im1pbl9mcmVlX2tieXRlcyB0ZXN0IHBhc3MiKTsKIH0KIAogc3RhdGljIHZvaWQgdGVzdF90dW5l
KHVuc2lnbmVkIGxvbmcgb3ZlcmNvbW1pdF9wb2xpY3kpCiB7CiAJaW50IHN0YXR1czsKLQlpbnQg
cGlkWzNdOwotCWludCByZXQsIGk7Ci0JdW5zaWduZWQgbG9uZyB0dW5lLCBtZW1mcmVlLCBtZW10
b3RhbDsKKwlwaWRfdCBwaWQ7CisJaW50IGk7CiAKIAlUU1RfU1lTX0NPTkZfTE9OR19TRVQoUEFU
SF9WTV9PVkVSQ09NTUlUX01FTU9SWSwgb3ZlcmNvbW1pdF9wb2xpY3ksIDEpOwogCiAJZm9yIChp
ID0gMDsgaSA8IDM7IGkrKykgewotCQlpZiAoaSA9PSAwKQotCQkJVFNUX1NZU19DT05GX0xPTkdf
U0VUKFBBVEhfVk1fTUlOX0ZSRUVfS0JZVEVTLCBkZWZhdWx0X3R1bmUsIDEpOwotCQllbHNlIGlm
IChpID09IDEpIHsKLQkJCVRTVF9TWVNfQ09ORl9MT05HX1NFVChQQVRIX1ZNX01JTl9GUkVFX0tC
WVRFUywgMiAqIGRlZmF1bHRfdHVuZSwgMSk7Ci0JCX0gZWxzZSB7Ci0JCQltZW1mcmVlID0gU0FG
RV9SRUFEX01FTUlORk8oIk1lbUZyZWU6Iik7Ci0JCQltZW10b3RhbCA9IFNBRkVfUkVBRF9NRU1J
TkZPKCJNZW1Ub3RhbDoiKTsKLQkJCXR1bmUgPSBtZW1mcmVlIC8gMjA7Ci0JCQlpZiAodHVuZSA+
IChtZW10b3RhbCAvIDUwKSkKLQkJCQl0dW5lID0gbWVtdG90YWwgLyA1MDsKLQotCQkJVFNUX1NZ
U19DT05GX0xPTkdfU0VUKFBBVEhfVk1fTUlOX0ZSRUVfS0JZVEVTLCB0dW5lLCAxKTsKLQkJfQor
CQlzZXRfbWluX2ZyZWVfa2J5dGVzKGkpOwogCiAJCWZmbHVzaChzdGRvdXQpOwotCQlzd2l0Y2gg
KHBpZFtpXSA9IGZvcmsoKSkgewotCQljYXNlIC0xOgotCQkJdHN0X2JyayhUQlJPSyB8IFRFUlJO
TywgImZvcmsiKTsKLQkJCWJyZWFrOwotCQljYXNlIDA6Ci0JCQlyZXQgPSBlYXR1cF9tZW0ob3Zl
cmNvbW1pdF9wb2xpY3kpOwotCQkJZXhpdChyZXQpOworCQlwaWQgPSBTQUZFX0ZPUksoKTsKKwkJ
aWYgKHBpZCA9PSAwKSB7CisJCQlleGl0KGVhdHVwX21lbShvdmVyY29tbWl0X3BvbGljeSkpOwog
CQl9CiAKLQkJU0FGRV9XQUlUUElEKHBpZFtpXSwgJnN0YXR1cywgV1VOVFJBQ0VEIHwgV0NPTlRJ
TlVFRCk7CisJCVNBRkVfV0FJVFBJRChwaWQsICZzdGF0dXMsIFdVTlRSQUNFRCB8IFdDT05USU5V
RUQpOwogCiAJCWlmIChvdmVyY29tbWl0X3BvbGljeSA9PSAyKSB7CiAJCQlpZiAoIVdJRkVYSVRF
RChzdGF0dXMpIHx8IFdFWElUU1RBVFVTKHN0YXR1cykgIT0gMCkKQEAgLTE3Miw2ICsxNjgsNyBA
QCBzdGF0aWMgaW50IGVhdHVwX21lbSh1bnNpZ25lZCBsb25nIG92ZXJjb21taXRfcG9saWN5KQog
CiBzdGF0aWMgdm9pZCBjaGVja19tb25pdG9yKHZvaWQpCiB7CisJaW50IHZpb2xhdGVkID0gMDsK
IAl1bnNpZ25lZCBsb25nIHR1bmU7CiAJdW5zaWduZWQgbG9uZyBtZW1mcmVlOwogCkBAIC0xODMs
MTAgKzE4MCwxNCBAQCBzdGF0aWMgdm9pZCBjaGVja19tb25pdG9yKHZvaWQpCiAJCQl0c3RfcmVz
KFRJTkZPLCAiTWVtRnJlZSBpcyAlbHUga0IsICIKIAkJCQkibWluX2ZyZWVfa2J5dGVzIGlzICVs
dSBrQiIsIG1lbWZyZWUsIHR1bmUpOwogCQkJdHN0X3JlcyhURkFJTCwgIk1lbUZyZWUgPCBtaW5f
ZnJlZV9rYnl0ZXMiKTsKKwkJCXZpb2xhdGVkID0gMTsKIAkJfQogCiAJCXNsZWVwKDIpOwogCX0K
KworCWlmICghdmlvbGF0ZWQpCisJCXRzdF9yZXMoVFBBU1MsICJtaW5fZnJlZV9rYnl0ZXMgdGVz
dCBwYXNzIik7CiB9CiAKIHN0YXRpYyB2b2lkIHNpZ2hhbmRsZXIoaW50IHNpZ25vIExUUF9BVFRS
SUJVVEVfVU5VU0VEKQotLSAKMi4zOS4xCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczov
L2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
