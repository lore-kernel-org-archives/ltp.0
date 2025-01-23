Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC525C02182
	for <ltp@archiver.kernel.org>; Thu, 23 Jan 2025 17:40:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 45CD43C4E4C
	for <ltp@archiver.kernel.org>; Thu, 23 Jan 2025 18:40:19 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0275B3C4EA1
 for <ltp@lists.linux.it>; Thu, 23 Jan 2025 18:39:56 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2CA54206C08
 for <ltp@lists.linux.it>; Thu, 23 Jan 2025 18:39:55 +0100 (CET)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NFdT9M001995;
 Thu, 23 Jan 2025 17:39:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=8r5iKo
 TiDMS1mg7o0fmUlPoSwOyHMvJejeBuMi0Du14=; b=G492nb+I+l6fBcJIOJqaVz
 HtSOZj2shGTz3vqurfVxYF1IO07AZ1rU3mSuzYVKGSDrq6hDH/gqT9sjDg6RPR9o
 mSK9iF7ro0AYgH32vKdJe261x/T05RVHbh7vUE7bb28tZZxpWWvWEKwzA3uQUDFn
 eXRcmFCgJW36B8hWPwToCUpCT+F20hesIASRNKqxaFO9GWZwViHhPWpeHvqnS/83
 KIzknfmguVIqLJDrtYW6HCqgXGKu7nqnYeNKdvTuoV70EzLR+ybgCNj9+X5LaXFs
 rSbzIRzneH2FI32LB7nYEwhtnE5CPYb/+kggB9z8Zyaf3lWXKMiQwyC+GftymUOA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44brku0jq3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Jan 2025 17:39:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50NEmAZf024307;
 Thu, 23 Jan 2025 17:39:53 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448q0yes0e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Jan 2025 17:39:53 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50NHdrcv7668012
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Jan 2025 17:39:53 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E2815805A;
 Thu, 23 Jan 2025 17:39:53 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F4C458054;
 Thu, 23 Jan 2025 17:39:53 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.61.4.223]) by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Jan 2025 17:39:52 +0000 (GMT)
Message-ID: <457bde4721991e43ceb6deefeee4a3fde33661e6.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Date: Thu, 23 Jan 2025 12:39:52 -0500
In-Reply-To: <20250114112915.610297-10-pvorel@suse.cz>
References: <20250114112915.610297-1-pvorel@suse.cz>
 <20250114112915.610297-10-pvorel@suse.cz>
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pHZ0zuCpHVF8IPGojvj0yY8P589FJVE-
X-Proofpoint-GUID: pHZ0zuCpHVF8IPGojvj0yY8P589FJVE-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 lowpriorityscore=0
 spamscore=0 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230128
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 09/10] ima_measurements.sh: Check policy for
 test3
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
cm90ZToKPiBGaXJzdCB0d28gdGVzdHMgYXJlIHdvcmtpbmcgd2l0aCBpbWFfcG9saWN5PXRjYiwK
PiBidXQgM3JkIHRlc3QgcmVxdWlyZXMgbW9yZSBzcGVjaWZpYyBwb2xpY3kuCj4gCj4gU2lnbmVk
LW9mZi1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+CgpTb3JyeSBJJ20gbm90IHNlZWlu
ZyB0aGUgZGlmZmVyZW5jZSBiZXR3ZWVuICJpbWFfcG9saWN5PXRjYiIgYW5kIHRoZSBzcGVjaWZp
YyBwb2xpY3kuClRoZSBwYXRjaCBpdHNlbGYgbG9va3MgY29ycmVjdCBhbmQgc2hvdWxkIGFsbG93
IHRoZSB0ZXN0IHRvIHdvcmsgZXZlbiB3aXRob3V0CnNwZWNpZnlpbmcgdGhlICJ0Y2IiIHBvbGlj
eSBvbiB0aGUgYm9vdCBjb21tYW5kIGxpbmUuCgpBZnRlciBmaXhpbmcgdGhlIHBhdGNoIGRlc2Ny
aXB0aW9uLCBmZWVsIGZyZWUgdG8gYWRkOgoKUmV2aWV3ZWQtYnk6IE1pbWkgWm9oYXIgPHpvaGFy
QGxpbnV4LmlibS5jb20+CgoKPiAtLS0KPiDCoC4uLi9rZXJuZWwvc2VjdXJpdHkvaW50ZWdyaXR5
L2ltYS90ZXN0cy9pbWFfbWVhc3VyZW1lbnRzLnNowqAgfCA1ICsrKysrCj4gwqAxIGZpbGUgY2hh
bmdlZCwgNSBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwv
c2VjdXJpdHkvaW50ZWdyaXR5L2ltYS90ZXN0cy9pbWFfbWVhc3VyZW1lbnRzLnNoCj4gYi90ZXN0
Y2FzZXMva2VybmVsL3NlY3VyaXR5L2ludGVncml0eS9pbWEvdGVzdHMvaW1hX21lYXN1cmVtZW50
cy5zaAo+IGluZGV4IGM0MmMzMWM4OTguLjM1YWNjNmVhNzggMTAwNzU1Cj4gLS0tIGEvdGVzdGNh
c2VzL2tlcm5lbC9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL3Rlc3RzL2ltYV9tZWFzdXJlbWVudHMu
c2gKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3NlY3VyaXR5L2ludGVncml0eS9pbWEvdGVzdHMv
aW1hX21lYXN1cmVtZW50cy5zaAo+IEBAIC03Nyw2ICs3NywxMSBAQCB0ZXN0MygpCj4gwqAJdHN0
X3JlcyBUSU5GTyAidmVyaWZ5IG5vdCBtZWFzdXJpbmcgdXNlciBmaWxlcyIKPiDCoAl0c3RfY2hl
Y2tfY21kcyBzdWRvIHx8IHJldHVybgo+IMKgCj4gKwlpZiBbICIkSU1BX1BPTElDWV9DSEVDS0VE
IiAhPSAxIF07IHRoZW4KPiArCQl0c3RfcmVzIFRDT05GICJ0ZXN0IHJlcXVpcmVzIHNwZWNpZmlj
IHBvbGljeSwgdHJ5IGxvYWQgaXQgd2l0aAo+IExUUF9JTUFfTE9BRF9QT0xJQ1k9MSIKPiArCQly
ZXR1cm4KPiArCWZpCj4gKwo+IMKgCWlmICEgaWQgJHVzZXIgPi9kZXYvbnVsbCAyPi9kZXYvbnVs
bDsgdGhlbgo+IMKgCQl0c3RfcmVzIFRDT05GICJtaXNzaW5nIHN5c3RlbSB1c2VyICR1c2VyICh3
cm9uZyBpbnN0YWxsYXRpb24pIgo+IMKgCQlyZXR1cm4KCgotLSAKTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
