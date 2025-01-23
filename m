Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40AB0C02182
	for <ltp@archiver.kernel.org>; Thu, 23 Jan 2025 17:38:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A94823C4E21
	for <ltp@archiver.kernel.org>; Thu, 23 Jan 2025 18:38:23 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0AA373C4E9C
 for <ltp@lists.linux.it>; Thu, 23 Jan 2025 18:37:57 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4F1441BD4C69
 for <ltp@lists.linux.it>; Thu, 23 Jan 2025 18:37:55 +0100 (CET)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NFBkaw026409;
 Thu, 23 Jan 2025 17:37:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=5hdb8R
 DZHZwd7QD6bx4y5esLgapaGmH4Dp6faO6XXlM=; b=kp2QmF17X6eOwZAd5nvtfC
 1y67axZkEEkcqWz6ulT7Fvdh37rkBBDPnEbwUFz8kvptarCRN6jTBtofHWa+jpxO
 zzmI8IyX2jjMJba96xxtBOKMFaKA2OT5KHc0WspuGk+IGkQJs/yK7iqNtEUDpT9g
 E4cq2mYtlnC30UWOTJZTsBag+cfKs+Vj8InilvERNrk2ur25cc6qBAqL7gtusHgM
 8W7sfknxQr6uMnC5y7onb6iKUpMIsMaNpO7TTxI8PYMIAv6mHRKB5owELs9VZ5vS
 lr3HFHTofEmuIPqrejmOfN+PSFfjgM8tMw14waM2h0TKKkotTLj8WOoDSGelJ8jQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44bfk7ug1g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Jan 2025 17:37:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50NGdRaw032274;
 Thu, 23 Jan 2025 17:37:52 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 448rujx9bk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Jan 2025 17:37:52 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50NHbqNF14746358
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Jan 2025 17:37:52 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4196758059;
 Thu, 23 Jan 2025 17:37:52 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E7C2058057;
 Thu, 23 Jan 2025 17:37:51 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.61.4.223]) by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Jan 2025 17:37:51 +0000 (GMT)
Message-ID: <b1b395ef22f9d7cf50116edf121f3b195b0ea4f3.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Date: Thu, 23 Jan 2025 12:37:51 -0500
In-Reply-To: <20250114112915.610297-2-pvorel@suse.cz>
References: <20250114112915.610297-1-pvorel@suse.cz>
 <20250114112915.610297-2-pvorel@suse.cz>
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hf_kVxsGusR6wNilzj3mu8X3sBpXlrk1
X-Proofpoint-ORIG-GUID: hf_kVxsGusR6wNilzj3mu8X3sBpXlrk1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=999
 adultscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230128
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 01/10] ima_violations.sh: Fix log detection
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

SGkgUGV0ciwKCk9uIFR1ZSwgMjAyNS0wMS0xNCBhdCAxMjoyOSArMDEwMCwgUGV0ciBWb3JlbCB3
cm90ZToKPiBGaXggVEJST0sgb24gc3lzdGVtcyB3aGljaCBkb2VzIG5vdCBoYXZlIC92YXIvbG9n
L21lc3NhZ2VzCj4gKGFueSBtb2Rlcm4gZGlzdHJvIGlzIHVzaW5nIHN5c3RlbWQpIG5vdCBhdWRp
dGQgaW5zdGFsbGVkOgoKLT4gYW5kIGF1ZGl0ZCBpcyBub3QgaW5zdGFsbGVkOgoKPiAKPiDCoMKg
wqAgaW1hX3Zpb2xhdGlvbnMgMSBUQlJPSzogbG9nIC92YXIvbG9nL21lc3NhZ2VzIGRvZXMgbm90
IGV4aXN0IChidWcgaW4KPiBkZXRlY3Rpb24/KQo+IAo+IEluc3RlYWQgVENPTkYgd2l0aCBtb3Jl
IG1lYW5pbmdmdWwgbWVzc2FnZToKPiAKPiDCoMKgwqAgaW1hX3Zpb2xhdGlvbnMgMSBUQ09ORjog
bG9nIGZpbGUgbm90IGZvdW5kLCBpbnN0YWxsIGF1ZGl0ZAo+IAo+IEZpeGVzOiBodHRwczovL2dp
dGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC9pc3N1ZXMvMzcyCgpQZXJoYXBzIC92YXIv
bG9nL21lc3NhZ2VzIHdhcyBiZWluZyByYXRlIGxpbWl0ZWQuCgo+IFNpZ25lZC1vZmYtYnk6IFBl
dHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PgoKUmV2aWV3ZWQtYnk6IE1pbWkgWm9oYXIgPHpvaGFy
QGxpbnV4LmlibS5jb20+Cgo+IC0tLQo+IMKgLi4uL2tlcm5lbC9zZWN1cml0eS9pbnRlZ3JpdHkv
aW1hL3Rlc3RzL2ltYV92aW9sYXRpb25zLnNowqDCoCB8IDYgKysrKy0tCj4gwqAxIGZpbGUgY2hh
bmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS90
ZXN0Y2FzZXMva2VybmVsL3NlY3VyaXR5L2ludGVncml0eS9pbWEvdGVzdHMvaW1hX3Zpb2xhdGlv
bnMuc2gKPiBiL3Rlc3RjYXNlcy9rZXJuZWwvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS90ZXN0cy9p
bWFfdmlvbGF0aW9ucy5zaAo+IGluZGV4IDBmNzEwZGVhMmUuLmIyYjU5N2FkMDggMTAwNzU1Cj4g
LS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL3Rlc3RzL2ltYV92
aW9sYXRpb25zLnNoCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zZWN1cml0eS9pbnRlZ3JpdHkv
aW1hL3Rlc3RzL2ltYV92aW9sYXRpb25zLnNoCj4gQEAgLTIzLDggKzIzLDEwIEBAIHNldHVwKCkK
PiDCoAkJUFJJTlRLX1JBVEVfTElNSVQ9YHN5c2N0bCAtbiBrZXJuZWwucHJpbnRrX3JhdGVsaW1p
dGAKPiDCoAkJc3lzY3RsIC13cSBrZXJuZWwucHJpbnRrX3JhdGVsaW1pdD0wCj4gwqAJZmkKPiAt
CVsgLWYgIiRMT0ciIF0gfHwgXAo+IC0JCXRzdF9icmsgVEJST0sgImxvZyAkTE9HIGRvZXMgbm90
IGV4aXN0IChidWcgaW4gZGV0ZWN0aW9uPykiCj4gKwo+ICsJaWYgWyAhIC1lICIkTE9HIiBdOyB0
aGVuCj4gKwkJdHN0X2JyayBUQ09ORiAibG9nIGZpbGUgbm90IGZvdW5kLCBpbnN0YWxsIGF1ZGl0
ZCIKPiArCWZpCj4gwqAJdHN0X3JlcyBUSU5GTyAidXNpbmcgbG9nICRMT0ciCj4gwqB9Cj4gwqAK
CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8v
bHRwCg==
