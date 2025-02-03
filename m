Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58979C02195
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 16:00:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C1E403C8F17
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 17:00:42 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8E79A3C8EC7
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 17:00:26 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7287E632B4E
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 17:00:24 +0100 (CET)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5137Wq3l014520;
 Mon, 3 Feb 2025 16:00:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=mh1EaX
 CRk9gCrfTq0Sj0NtgEFMOXSC56emU6Jgqw4QQ=; b=O/xh1QuyxaFh3DJunZeda2
 qhne8iQYC9YDJZ3DrwZb2tFWdxqB4rDEaj/sBnYyrDIR7Dr9tb6LhUlSmGEmMQk0
 4VDfOy9QWtbum+3l/lQCN8CaQ2rBkc9TKNY3UbqQ5Eax5QYtiMiUwttAph7pWlcm
 xRQ/7pOKxeOE5ttRNdVtWIZwZMrwMFbHqNPOtnxZjtwM+a0wpgRPNmEttbRmd519
 HzsKqK8UzHliTAd4PaFkFS1vgC2krqIAnABr3MI1sn8el94P1v3R3mc63HpOOZ81
 T5cTRf9+rfxThdK+9za8vnWhzMNX2mNENVq3k9FMLmfkZmCEDVfUzR+kX6U+h/Hw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44jsgnja8k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Feb 2025 16:00:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 513Fiket006535;
 Mon, 3 Feb 2025 16:00:21 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hyek70pv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Feb 2025 16:00:21 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 513G0LDi28836560
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Feb 2025 16:00:21 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 15C085805C;
 Mon,  3 Feb 2025 16:00:21 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D01D658051;
 Mon,  3 Feb 2025 16:00:20 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.61.83.5]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Feb 2025 16:00:20 +0000 (GMT)
Message-ID: <19d67fb8887a2b322978a8901850587b0ac343b1.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Date: Mon, 03 Feb 2025 11:00:20 -0500
In-Reply-To: <20250114112915.610297-8-pvorel@suse.cz>
References: <20250114112915.610297-1-pvorel@suse.cz>
 <20250114112915.610297-8-pvorel@suse.cz>
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oeAhcrL5viRetUjl1IowcwHaUVyzHPkh
X-Proofpoint-ORIG-GUID: oeAhcrL5viRetUjl1IowcwHaUVyzHPkh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_07,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 phishscore=0
 mlxscore=0 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502030117
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 07/10] ima_setup.sh: Add digest index detection
 for ima-buf format
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

T24gVHVlLCAyMDI1LTAxLTE0IGF0IDEyOjI5ICswMTAwLCBQZXRyIFZvcmVsIHdyb3RlOgo+IGlt
YS1idWYgZm9ybWF0IG1pZ2h0IGJlIGxvYWRlZCB2aWEgbG9hZGluZyBwb2xpY3kgaW4gdGhlIG5l
eHQgY29tbWl0Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6
PgoKCiJpbWEtYnVmIiBpcyB1c2VkIGluICJbUEFUQ0ggdjMgMDUvMTBdIElNQTogUmVhZCByZXF1
aXJlZCBwb2xpY3kgZnJvbSBmaWxlIi4KCk90aGVyd2lzZSwgClJldmlld2VkLWJ5OiBNaW1pIFpv
aGFyIDx6b2hhckBsaW51eC5pYm0uY29tPgoKPiAtLS0KPiDCoHRlc3RjYXNlcy9rZXJuZWwvc2Vj
dXJpdHkvaW50ZWdyaXR5L2ltYS90ZXN0cy9pbWFfc2V0dXAuc2ggfCAyICstCj4gwqAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEv
dGVzdGNhc2VzL2tlcm5lbC9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL3Rlc3RzL2ltYV9zZXR1cC5z
aAo+IGIvdGVzdGNhc2VzL2tlcm5lbC9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL3Rlc3RzL2ltYV9z
ZXR1cC5zaAo+IGluZGV4IGFmNTU4NDk1MWMuLjFmMDFmMThjZjYgMTAwNjQ0Cj4gLS0tIGEvdGVz
dGNhc2VzL2tlcm5lbC9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL3Rlc3RzL2ltYV9zZXR1cC5zaAo+
ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS90ZXN0cy9pbWFf
c2V0dXAuc2gKPiBAQCAtMjQyLDcgKzI0Miw3IEBAIHNldF9kaWdlc3RfaW5kZXgoKQo+IMKgCSMg
cGFyc2UgZGlnZXN0IGluZGV4Cj4gwqAJIyBodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1s
L2xhdGVzdC9zZWN1cml0eS9JTUEtdGVtcGxhdGVzLmh0bWwjdXNlCj4gwqAJY2FzZSAiJHRlbXBs
YXRlIiBpbgo+IC0JaW1hfGltYS1uZ3xpbWEtc2lnKSBESUdFU1RfSU5ERVg9NCA7Owo+ICsJaW1h
fGltYS1idWZ8aW1hLW5nfGltYS1zaWcpIERJR0VTVF9JTkRFWD00IDs7Cj4gwqAJKikKPiDCoAkJ
IyB1c2luZyBpbWFfdGVtcGxhdGVfZm10IGtlcm5lbCBwYXJhbWV0ZXIKPiDCoAkJbG9jYWwgSUZT
PSJ8IgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0
aW5mby9sdHAK
