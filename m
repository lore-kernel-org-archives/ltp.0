Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7119AC02182
	for <ltp@archiver.kernel.org>; Thu, 23 Jan 2025 17:40:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E6FC3C4E21
	for <ltp@archiver.kernel.org>; Thu, 23 Jan 2025 18:40:01 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 316843C4E4C
 for <ltp@lists.linux.it>; Thu, 23 Jan 2025 18:39:36 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 66225680E38
 for <ltp@lists.linux.it>; Thu, 23 Jan 2025 18:39:34 +0100 (CET)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NFdTaC002081;
 Thu, 23 Jan 2025 17:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=EHqpjC
 GrKpx9Eoz058268XOm9Wnw8zMWMHDj+Tvv/pM=; b=gLfrAtO4QioJKEhVdY1T0d
 1eIzqtrCxvcc9IQG7VqkSfbEn4WOMgKLoCNKIMNVEXeIiyuctXJAF6DxNMBrow+D
 11iJV69wW06WffLlwyE+asHBT8mScYU8KEnAhgNlH+u6tFRXP6ZiK3XN40yKiRb4
 pSDfyhaCteYPBO/DoW9ISq9wKrrzRLNroTEe3Jsehfe95oSP2OuWV1Ka1SYH70o5
 cdT2GRw0jemUhX2gEnl1e4a8uCAd8nXtmQqjWAsfvh/TMQKUyvL4g4146GlmMOeY
 boeh+vw+B5VwKZ362xv0USshiBbTzQljeukk0KddlRc/NXDH8HDgh7PY92C+HhAw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44brku0jny-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Jan 2025 17:39:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50NGKB86020994;
 Thu, 23 Jan 2025 17:39:32 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 448sb1p8wd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Jan 2025 17:39:32 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50NHdWPN12976724
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Jan 2025 17:39:32 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D5F55805D;
 Thu, 23 Jan 2025 17:39:32 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 32D3358059;
 Thu, 23 Jan 2025 17:39:32 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.61.4.223]) by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Jan 2025 17:39:32 +0000 (GMT)
Message-ID: <574f3ba3c29253ccdc4ad4be469a7382f5904b4d.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Date: Thu, 23 Jan 2025 12:39:31 -0500
In-Reply-To: <20250114112915.610297-11-pvorel@suse.cz>
References: <20250114112915.610297-1-pvorel@suse.cz>
 <20250114112915.610297-11-pvorel@suse.cz>
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eMZlH1JryrB6hYcAB9A2f0a4KV0iOjla
X-Proofpoint-GUID: eMZlH1JryrB6hYcAB9A2f0a4KV0iOjla
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=737 clxscore=1015 lowpriorityscore=0
 spamscore=0 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230128
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 10/10] tst_test.sh: IMA: Allow to disable LSM
 warnings and use it for IMA
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
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCAyMDI1LTAxLTE0IGF0IDEyOjI5ICswMTAwLCBQZXRyIFZvcmVsIHdyb3RlOgo+IFN1
Z2dlc3RlZC1ieTogTWltaSBab2hhciA8em9oYXJAbGludXguaWJtLmNvbT4KPiBTaWduZWQtb2Zm
LWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KClRoYW5rcywgUGV0ci4gCgpSZXZpZXdl
ZC1ieTogTWltaSBab2hhciA8em9oYXJAbGludXguaWJtLmNvbT4KCj4gLS0tCj4gwqB0ZXN0Y2Fz
ZXMva2VybmVsL3NlY3VyaXR5L2ludGVncml0eS9pbWEvdGVzdHMvaW1hX3NldHVwLnNoIHwgMSAr
Cj4gwqB0ZXN0Y2FzZXMvbGliL3RzdF90ZXN0LnNowqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgNCArKy0tCj4gwqAyIGZp
bGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0t
Z2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL3Rlc3RzL2ltYV9z
ZXR1cC5zaAo+IGIvdGVzdGNhc2VzL2tlcm5lbC9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL3Rlc3Rz
L2ltYV9zZXR1cC5zaAo+IGluZGV4IDUyMTM3NjNlZTAuLjY5ZWU1YTNkNjUgMTAwNjQ0Cj4gLS0t
IGEvdGVzdGNhc2VzL2tlcm5lbC9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL3Rlc3RzL2ltYV9zZXR1
cC5zaAo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS90ZXN0
cy9pbWFfc2V0dXAuc2gKPiBAQCAtMTEsNiArMTEsNyBAQCBUU1RfQ0xFQU5VUF9DQUxMRVI9IiRU
U1RfQ0xFQU5VUCIKPiDCoFRTVF9DTEVBTlVQPSJpbWFfY2xlYW51cCIKPiDCoFRTVF9ORUVEU19S
T09UPTEKPiDCoFRTVF9NT1VOVF9ERVZJQ0U9MQo+ICtUU1RfU0tJUF9MU01fV0FSTklOR1M9MQo+
IMKgCj4gwqAjIFRTVF9NT1VOVF9ERVZJQ0UgY2FuIGJlIHVuc2V0LCB0aGVyZWZvcmUgc3BlY2lm
eSBleHBsaWNpdGx5Cj4gwqBUU1RfTkVFRFNfVE1QRElSPTEKPiBkaWZmIC0tZ2l0IGEvdGVzdGNh
c2VzL2xpYi90c3RfdGVzdC5zaCBiL3Rlc3RjYXNlcy9saWIvdHN0X3Rlc3Quc2gKPiBpbmRleCBj
ZmRhZTAyMzAwLi4yYjc5NzcwNWUzIDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9saWIvdHN0X3Rl
c3Quc2gKPiArKysgYi90ZXN0Y2FzZXMvbGliL3RzdF90ZXN0LnNoCj4gQEAgLTEsNiArMSw2IEBA
Cj4gwqAjIS9iaW4vc2gKPiDCoCMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3It
bGF0ZXIKPiAtIyBDb3B5cmlnaHQgKGMpIExpbnV4IFRlc3QgUHJvamVjdCwgMjAxNC0yMDIyCj4g
KyMgQ29weXJpZ2h0IChjKSBMaW51eCBUZXN0IFByb2plY3QsIDIwMTQtMjAyNQo+IMKgIyBBdXRo
b3I6IEN5cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6Pgo+IMKgIwo+IMKgIyBMVFAgdGVzdCBs
aWJyYXJ5IGZvciBzaGVsbC4KPiBAQCAtODEsNyArODEsNyBAQCBfdHN0X2RvX2V4aXQoKQo+IMKg
CWZpCj4gwqAKPiDCoAlpZiBbICRUU1RfQlJPSyAtZ3QgMCAtbyAkVFNUX0ZBSUwgLWd0IDAgLW8g
JFRTVF9XQVJOIC1ndCAwIF07IHRoZW4KPiAtCQlfdHN0X2NoZWNrX3NlY3VyaXR5X21vZHVsZXMK
PiArCQlbIC16ICIkVFNUX1NLSVBfTFNNX1dBUk5JTkdTIiBdICYmIF90c3RfY2hlY2tfc2VjdXJp
dHlfbW9kdWxlcwo+IMKgCWZpCj4gwqAKPiDCoAljYXQgPiYyIDw8IEVPRgoKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
