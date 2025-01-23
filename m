Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B0D8C02182
	for <ltp@archiver.kernel.org>; Thu, 23 Jan 2025 17:45:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DED503C4E70
	for <ltp@archiver.kernel.org>; Thu, 23 Jan 2025 18:45:47 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B32603C008D
 for <ltp@lists.linux.it>; Thu, 23 Jan 2025 18:45:32 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 79D3F1434634
 for <ltp@lists.linux.it>; Thu, 23 Jan 2025 18:45:31 +0100 (CET)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NAPogN022452;
 Thu, 23 Jan 2025 17:45:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=4KlNUV
 OAqpUDBiHrRJsi3KUeaVLhtjaRAVXgC3xL1hE=; b=jMLBsH7nnkb5nZWV2Y126/
 LMDaK86ir97o0VJ9KloI94OrnQt1x7bFS/a03DnL4Nwkgl5sYWWHbuI5rnx1eDL0
 9e4IymFWTTofi0TAu7rmksEX3cKEfDp+bKa7qp+h3Sr8HEzczhwk/13ZOT+Pix7L
 gXmHmKZU1Va88LgbeA5g4gkMcQ2wLSA2l6FlhdcRkaNsPfYp6Q310IEnz+0SbTUK
 lX5a+M+ZSEOhXoTv3LZmm3EZGGa+VszHNnjAPZWVP51pGxIXNcoQcrxLzyIfDwWw
 AvmIUXSi+rK6Jo15OQ47kkMxv9ml/w1xFfbbilemu0h6qyzNN66/NF4a/QBW+eFA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44bbu9cet0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Jan 2025 17:45:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50NGDpnI021063;
 Thu, 23 Jan 2025 17:45:28 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 448sb1p9tq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Jan 2025 17:45:28 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50NHjR1Q16056860
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Jan 2025 17:45:28 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BA19E5805D;
 Thu, 23 Jan 2025 17:45:27 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4C0EB5805A;
 Thu, 23 Jan 2025 17:45:27 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.61.4.223]) by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Jan 2025 17:45:27 +0000 (GMT)
Message-ID: <06b7338df420a274e6c2c9e4a8badce4cf277a01.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Date: Thu, 23 Jan 2025 12:45:26 -0500
In-Reply-To: <20250114112915.610297-7-pvorel@suse.cz>
References: <20250114112915.610297-1-pvorel@suse.cz>
 <20250114112915.610297-7-pvorel@suse.cz>
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hKFybcQny4GHQRVcjbk5MM5W_W34SQI6
X-Proofpoint-ORIG-GUID: hKFybcQny4GHQRVcjbk5MM5W_W34SQI6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=796
 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230128
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 06/10] ima_violations.sh: Declare tcb builtin
 policy
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

T24gVHVlLCAyMDI1LTAxLTE0IGF0IDEyOjI5ICswMTAwLCBQZXRyIFZvcmVsIHdyb3RlOgo+IElN
QSBidWlsdGluIHBvbGljeSBjb250YWlucyByZXF1aXJlZCBydWxlcywgYWxsb3cgdXNpbmcgaXQu
Cj4gVGhpcyBoZWxwcyBtb3JlIHJlbGlhYmxlIHJlc3VsdHMgb24ga2VybmVscyB3aXRob3V0Cj4g
Q09ORklHX0lNQV9SRUFEX1BPTElDWT15Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwg
PHB2b3JlbEBzdXNlLmN6PgoKVGhhbmtzLCBQZXRyLgoKUmV2aWV3ZWQtYnk6IE1pbWkgWm9oYXIg
PHpvaGFyQGxpbnV4LmlibS5jb20+Cgo+IC0tLQo+IMKgdGVzdGNhc2VzL2tlcm5lbC9zZWN1cml0
eS9pbnRlZ3JpdHkvaW1hL3Rlc3RzL2ltYV92aW9sYXRpb25zLnNoIHwgMSArCj4gwqAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPiAKPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5l
bC9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL3Rlc3RzL2ltYV92aW9sYXRpb25zLnNoCj4gYi90ZXN0
Y2FzZXMva2VybmVsL3NlY3VyaXR5L2ludGVncml0eS9pbWEvdGVzdHMvaW1hX3Zpb2xhdGlvbnMu
c2gKPiBpbmRleCAxODUyZThiYzc0Li4zN2Q4ZDQ3M2MyIDEwMDc1NQo+IC0tLSBhL3Rlc3RjYXNl
cy9rZXJuZWwvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS90ZXN0cy9pbWFfdmlvbGF0aW9ucy5zaAo+
ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS90ZXN0cy9pbWFf
dmlvbGF0aW9ucy5zaAo+IEBAIC0xMCw2ICsxMCw3IEBAIFRTVF9TRVRVUD0ic2V0dXAiCj4gwqBU
U1RfQ0xFQU5VUD0iY2xlYW51cCIKPiDCoFRTVF9DTlQ9Mwo+IMKgCj4gK1JFUVVJUkVEX0JVSUxU
SU5fUE9MSUNZPSJ0Y2IiCj4gwqBSRVFVSVJFRF9QT0xJQ1lfQ09OVEVOVD0ndmlvbGF0aW9ucy5w
b2xpY3knCj4gwqAKPiDCoHNldHVwKCkKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
