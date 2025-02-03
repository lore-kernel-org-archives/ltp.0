Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98AFC02192
	for <ltp@archiver.kernel.org>; Tue,  4 Feb 2025 00:50:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C5CA3C8F80
	for <ltp@archiver.kernel.org>; Tue,  4 Feb 2025 01:50:37 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CED6A3C54B2
 for <ltp@lists.linux.it>; Tue,  4 Feb 2025 01:50:20 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A3F2C64F649
 for <ltp@lists.linux.it>; Tue,  4 Feb 2025 01:50:18 +0100 (CET)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513MvaiK027290;
 Tue, 4 Feb 2025 00:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=iFD7h3
 eA60RTkB1tif+Q3mte1FUD/lUZQjV+uaohdwk=; b=JqzDLA8kb8QTFeSl+MtUjh
 yZ24+8vdg4GjNbh35wfmQSfKSFeqmUoa9jq3pIy3yVy09tiUfPDqSBYleI8WIHGQ
 TQFPtJY9ALgAzm16UExvZ8kSkBZPqRTbP77QhR/B0tTkgG7ZSGMgTvSkD2uoGVbU
 kBq5j9HrZGCR0EnJY5dwrDZpUOS/fjVQD0kTzfdhjQnvuKQbf5kh9ZfUyBq39Zsy
 Upgwc05HT11S+XamWH0TKOZL5t0wvK9/FsDUi+0Lp9X0xdzo9tikxloFJxP/SMAP
 IX5sSf5Zrjbsq62WvRyt0SR5B5FIt47UAT/2f/2BXpeaQSMWqOkPJpIYMoIem1sA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44jkv961ke-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Feb 2025 00:50:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 513NPWWD024635;
 Tue, 4 Feb 2025 00:50:15 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hxxn11p1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Feb 2025 00:50:15 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5140oFmI19923702
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Feb 2025 00:50:15 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E06A85806D;
 Tue,  4 Feb 2025 00:50:14 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E9E258068;
 Tue,  4 Feb 2025 00:50:14 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.61.18.96]) by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Feb 2025 00:50:14 +0000 (GMT)
Message-ID: <4e4fb197b7127f8d82705ec441e8a273cd237b7f.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
In-Reply-To: <20250203210233.1407530-1-pvorel@suse.cz>
References: <20250203210233.1407530-1-pvorel@suse.cz>
MIME-Version: 1.0
Date: Mon, 03 Feb 2025 18:48:10 -0500
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OSMniuTFzQyC2Z-dKRU-m4GR0-1MMSrz
X-Proofpoint-ORIG-GUID: OSMniuTFzQyC2Z-dKRU-m4GR0-1MMSrz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_10,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040002
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] IMA: measure.policy: limit dont_measure tmpfs
 policy to func=FILE_CHECK
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

T24gTW9uLCAyMDI1LTAyLTAzIGF0IDIyOjAyICswMTAwLCBQZXRyIFZvcmVsIHdyb3RlOgo+IGFk
ZCBmdW5jPUZJTEVfQ0hFQ0sgdG8gZG9udF9tZWFzdXJlIHRtcGZzCj4gCj4gU2ltaWxhcmx5IHRv
IHRjYi5wb2xpY3kgbGltaXQgZG9udF9tZWFzdXJlIHRtcGZzIHBvbGljeSB0byBmdW5jPUZJTEVf
Q0hFQ0suCj4gVGhpcyBhbGxvd3MgdG8gZG8gZXh0cmEgbWVhc3VyZW1lbnRzLCBlLmcuIGtleGVj
IGJvb3QgY29tbWFuZCBsaW5lLCBzZWUKPiBrZXJuZWwgY29tbWl0Cj4gCj4gN2VlZjdjOGJhYzlh
ICgiaW1hOiBsaW1pdCB0aGUgYnVpbHRpbiAndGNiJyBkb250X21lYXN1cmUgdG1wZnMgcG9saWN5
IHJ1bGUiKQo+IAo+IEFsc28gcmVtb3ZlIGxlYWRpbmcgMCBmcm9tIHRtcGZzIG1hZ2ljICh0byBt
YXRjaCBJTUEgZG9jcyBhbmQgdGNiLnBvbGljeSkuCj4gCj4gU3VnZ2VzdGVkLWJ5OiBNaW1pIFpv
aGFyIDx6b2hhckBsaW51eC5pYm0uY29tPgo+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2
b3JlbEBzdXNlLmN6PgoKUmV2aWV3ZWQtYnk6IE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4LmlibS5j
b20+Cgo+IC0tLQo+IMKgLi4uL3NlY3VyaXR5L2ludGVncml0eS9pbWEvZGF0YWZpbGVzL2ltYV9w
b2xpY3kvbWVhc3VyZS5wb2xpY3nCoCB8IDIgKy0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQKPiBhL3Rlc3RjYXNlcy9rZXJu
ZWwvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9kYXRhZmlsZXMvaW1hX3BvbGljeS9tZWFzdXJlLnBv
bGljeQo+IGIvdGVzdGNhc2VzL2tlcm5lbC9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2RhdGFmaWxl
cy9pbWFfcG9saWN5L21lYXN1cmUucG9saWN5Cj4gaW5kZXggOTk3NmRkZjJkZS4uOGFiZDA1ZmIx
YSAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3NlY3VyaXR5L2ludGVncml0eS9pbWEv
ZGF0YWZpbGVzL2ltYV9wb2xpY3kvbWVhc3VyZS5wb2xpY3kKPiArKysgYi90ZXN0Y2FzZXMva2Vy
bmVsL3NlY3VyaXR5L2ludGVncml0eS9pbWEvZGF0YWZpbGVzL2ltYV9wb2xpY3kvbWVhc3VyZS5w
b2xpY3kKPiBAQCAtOCw3ICs4LDcgQEAgZG9udF9tZWFzdXJlIGZzbWFnaWM9MHg2MjY1NjU3Mgo+
IMKgIyBERUJVR0ZTX01BR0lDCj4gwqBkb250X21lYXN1cmUgZnNtYWdpYz0weDY0NjI2NzIwCj4g
wqAjIFRNUEZTX01BR0lDCj4gLWRvbnRfbWVhc3VyZSBmc21hZ2ljPTB4MDEwMjE5OTQKPiArZG9u
dF9tZWFzdXJlIGZzbWFnaWM9MHgxMDIxOTk0IGZ1bmM9RklMRV9DSEVDSwo+IMKgIyBTRUNVUklU
WUZTX01BR0lDCj4gwqBkb250X21lYXN1cmUgZnNtYWdpYz0weDczNjM2NjczCj4gwqBtZWFzdXJl
IGZ1bmM9RklMRV9NTUFQIG1hc2s9TUFZX0VYRUMKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0
dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
