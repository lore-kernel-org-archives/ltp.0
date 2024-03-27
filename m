Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CECDC47DD9
	for <ltp@archiver.kernel.org>; Wed, 27 Mar 2024 13:32:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA4AC3C05D8
	for <ltp@archiver.kernel.org>; Wed, 27 Mar 2024 14:32:22 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F0D123C031D
 for <ltp@lists.linux.it>; Wed, 27 Mar 2024 14:32:05 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=geetika@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4526461336A
 for <ltp@lists.linux.it>; Wed, 27 Mar 2024 14:32:03 +0100 (CET)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42RD8KH4029448; Wed, 27 Mar 2024 13:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=content-type :
 message-id : date : mime-version : subject : to : cc : references : from :
 in-reply-to; s=pp1; bh=bXiVAA11NQM07wcl1R7OyQs+jztXhztq91gQsEZFjKc=;
 b=Y9bY2g9F1+OCt+XP0ityGZBZWtp78qEm/IK0dvPdHcM95KoDW0CfP74DUh7UnH18QuUp
 R/OK3PialJA8j6NzDbuC9hlhZeXyy4UKfGrWHowXXY1MmIaSD3vkM9aveNzEx89VvQz+
 4WzPEdNPWVP65tliDdGHmKQPyHOJu16B4ubTHi/Day0YfpPugHebwrrVti8PM0c7H5v7
 U2HOWozm/S3s6nLf9982fXmNTBBy54AsIZrp57y/ZnZxMMia3LuKj6cAWTRyYiAalOGv
 HX3Pjrnu6y8Su5XGBbvLUe1I41yKCTkI/AX3IhMt4Y8lVAbb8i3OPeC6KLap96teudfN dA== 
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x4m2d029h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Mar 2024 13:32:00 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42RCJRvX003767; Wed, 27 Mar 2024 13:31:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x2c42xas3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Mar 2024 13:31:41 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42RDVbqi51118422
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Mar 2024 13:31:39 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5FD312004B;
 Wed, 27 Mar 2024 13:31:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B982320040;
 Wed, 27 Mar 2024 13:31:36 +0000 (GMT)
Received: from [9.43.116.220] (unknown [9.43.116.220])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 27 Mar 2024 13:31:36 +0000 (GMT)
Message-ID: <7c9bf212-bbd8-4889-ade9-9798cce3a29c@linux.ibm.com>
Date: Wed, 27 Mar 2024 19:01:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: rpalethorpe@suse.de
References: <20230929083916.72813-1-geetika@linux.ibm.com>
 <87leaf7euv.fsf@suse.de>
Content-Language: en-US
From: Geetika M <geetika@linux.ibm.com>
In-Reply-To: <87leaf7euv.fsf@suse.de>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ih3BLmu0vYPlK0DAbVxt6QVkfNxTqf1f
X-Proofpoint-GUID: ih3BLmu0vYPlK0DAbVxt6QVkfNxTqf1f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_08,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 phishscore=0
 suspectscore=0 clxscore=1011 spamscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403270092
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] Migrating the
 libhugetlbfs/testcases/truncate_above_4GB.c test
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8gUmljaGFyZCwKCk9uIDMwLzExLzIzIDI6MzMgcG0sIFJpY2hhcmQgUGFsZXRob3JwZSB3
cm90ZToKPiBIZWxsbywKPgo+IEdlZXRpa2E8Z2VldGlrYUBsaW51eC5pYm0uY29tPiAgd3JpdGVz
Ogo+Ci4uLi4KPj4gKy8qXAo+PiArICpbRGVzY3JpcGl0b25dCj4+ICsgKgo+PiArICogQXQgb25l
IHN0YWdlLCBhIG1pc2NvbnZlcnNpb24gb2YgaHVnZXRsYl92bXRydW5jYXRlX2xpc3QgdG8gYQo+
PiArICogcHJpb190cmVlIG1lYW50IHRoYXQgb24gMzItYml0IG1hY2hpbmVzLCB0cnVuY2F0ZXMg
YXQgb3IgYWJvdmUgNEdCCj4+ICsgKiBjb3VsZCB0cnVuY2F0ZSBsb3dlciBwYWdlcywgcmVzdWx0
aW5nIGluIEJVR19PTigpcy4KPj4gKyAqCj4+ICsgKiBXQVJOSU5HOiBUaGUgb2Zmc2V0cyBhbmQg
YWRkcmVzc2VzIHVzZWQgd2l0aGluIGFyZSBzcGVjaWZpY2FsbHkKPj4gKyAqIGNhbGN1bGF0ZWQg
dG8gdHJpZ2dlciB0aGUgYnVnIGFzIGl0IGV4aXN0ZWQuICBEb24ndCBtZXNzIHdpdGggdGhlbQo+
PiArICogdW5sZXNzIHlvdSAqcmVhbGx5KiBrbm93IHdoYXQgeW91J3JlIGRvaW5nLgo+PiArICoK
Pj4gKyAqLwo+PiArCj4+ICsjZGVmaW5lIF9HTlVfU09VUkNFCj4+ICsjZGVmaW5lIF9MQVJHRUZJ
TEU2NF9TT1VSQ0UKPj4gKyNkZWZpbmUgRk9VUkdJRyAoKG9mZjY0X3QpMHgxMDAwMDAwMDBVTEwp
Cj4+ICsjZGVmaW5lIE1OVFBPSU5UICJodWdldGxiZnMvIgo+PiArCj4+ICsjaW5jbHVkZSA8c2ln
bmFsLmg+Cj4+ICsjaW5jbHVkZSA8c2V0am1wLmg+Cj4+ICsjaW5jbHVkZSAiaHVnZXRsYi5oIgo+
PiArCj4+ICtzdGF0aWMgaW50IHBhZ2Vfc2l6ZTsKPj4gK3N0YXRpYyBsb25nIGhwYWdlX3NpemU7
Cj4+ICtzdGF0aWMgaW50IGZkID0gLTE7Cj4+ICtzdGF0aWMgdm9sYXRpbGUgaW50IHRlc3RfcGFz
czsKPj4gK3N0YXRpYyBpbnQgZXJyOwo+PiArc3RhdGljIGludCBzaWdidXNfY291bnQ7Cj4+ICtz
dGF0aWMgc2lnam1wX2J1ZiBzaWdfZXNjYXBlOwo+PiArCj4+ICtzdGF0aWMgdm9pZCBzaWdidXNf
aGFuZGxlcl9mYWlsKGludCBzaWdudW0sIHNpZ2luZm9fdCAqc2ksIHZvaWQgKnVjKQo+PiArewo+
PiArCXNpZ2xvbmdqbXAoc2lnX2VzY2FwZSwgMTcpOwo+PiArfQo+PiArCj4+ICtzdGF0aWMgdm9p
ZCBzaWdidXNfaGFuZGxlcl9wYXNzKGludCBzaWdudW0sIHNpZ2luZm9fdCAqc2ksIHZvaWQgKnVj
KQo+PiArewo+PiArCXRlc3RfcGFzcyA9IDE7Cj4+ICsJc2lnbG9uZ2ptcChzaWdfZXNjYXBlLCAx
Nyk7Cj4+ICt9Cj4+ICsKPj4gK3N0YXRpYyB2b2lkIHJ1bl90ZXN0KHZvaWQpCj4+ICt7Cj4+ICsJ
bG9uZyBsb25nIGJ1Z2d5X29mZnNldCwgdHJ1bmNhdGVfcG9pbnQ7Cj4+ICsJdm9pZCAqcCwgKnE7
Cj4+ICsJdm9sYXRpbGUgdW5zaWduZWQgaW50ICpwaSwgKnFpOwo+PiArCj4+ICsJc3RydWN0IHNp
Z2FjdGlvbiBzYV9wYXNzID0gewo+PiArCQkuc2Ffc2lnYWN0aW9uID0gc2lnYnVzX2hhbmRsZXJf
cGFzcywKPj4gKwkJLnNhX2ZsYWdzID0gU0FfU0lHSU5GTywKPj4gKwl9Owo+PiArCj4+ICsJc3Ry
dWN0IHNpZ2FjdGlvbiBzYV9mYWlsID0gewo+PiArCQkuc2Ffc2lnYWN0aW9uID0gc2lnYnVzX2hh
bmRsZXJfcGFzcywKPj4gKwkJLnNhX2ZsYWdzID0gU0FfU0lHSU5GTywKPj4gKwl9Owo+PiArCj4+
ICsJc2lnYnVzX2NvdW50ID0gMDsKPj4gKwl0ZXN0X3Bhc3MgPSAwOwo+PiArCj4+ICsJYnVnZ3lf
b2Zmc2V0ID0gdHJ1bmNhdGVfcG9pbnQgLyAoaHBhZ2Vfc2l6ZSAvIHBhZ2Vfc2l6ZSk7Cj4+ICsJ
YnVnZ3lfb2Zmc2V0ID0gUEFMSUdOKGJ1Z2d5X29mZnNldCwgaHBhZ2Vfc2l6ZSk7Cj4+ICsKPj4g
KwkvKiBGaXJzdCBnZXQgYXJlbmEgb2YgdGhyZWUgaHBhZ2VzIHNpemUsIGF0IGZpbGUgb2Zmc2V0
IDRHQiAqLwo+PiArCXEgPSBtbWFwNjQoTlVMTCwgMypocGFnZV9zaXplLCBQUk9UX1JFQUR8UFJP
VF9XUklURSwKPj4gKwkJIE1BUF9QUklWQVRFLCBmZCwgdHJ1bmNhdGVfcG9pbnQpOwo+PiArCWlm
IChxID09IE1BUF9GQUlMRUQpCj4+ICsJCXRzdF9icmsoVEJST0ssICJtbWFwKCkgb2Zmc2V0IDRH
QjogJXMiLCBzdHJlcnJvcihlcnJubykpOwo+IEluIG11c2wgbW1hcDY0IGlzIGp1c3QgZGVmaW5l
ZCBhcyBtbWFwIG9yIG5vdCBhdCBhbGwgaWYgX0dOVV9TT1VSQ0UgaXMKPiBhYnNlbnQuIFNvIGRv
IHdlIHJlYWxseSBuZWVkIGl0PyBJdCBzZWVtcyBsaWtlbHkgdG8gY2F1c2UgY29tcGlsYXRpb24K
PiBmYWlsdXJlcy4KPgo+IEluc3RlYWQgd2UgY291bGQganVzdCB1c2UgU0FGRV9NTUFQLgo+Cj4g
U2FtZSBnb2VzIGZvciB0cnVuY2F0ZTY0IGV0Yy4KPgo+IFRoZXJlIGFyZSBhIGxvdCBvZiB3YXJu
aW5ncyB3aGVuIGNvbXBpbGluZyB0aGlzLCB3ZSBkb24ndCB3YW50IHRvCj4gaW50cm9kdWNlIG1v
cmUgd2FybmluZ3MuCj4KVGhlICJtbWFwNjQiIGZ1bmN0aW9uIGlzIHVzZWQgaW5zdGVhZCBvZiAi
bW1hcCIgaW4gdGhpcyB0ZXN0IGJlY2F1c2UgaXQgCmFsbG93cyBmb3IgbWFwcGluZyBtZW1vcnkg
ZnJvbSBmaWxlcyB0aGF0IGFyZSBsYXJnZXIgdGhhbiAyIGdpZ2FieXRlcyAKaW50byB0aGUgcHJv
Y2VzcyBtZW1vcnkuCgpJbiBhIDY0LWJpdCBzeXN0ZW0sICJtbWFwIiBhbmQgIm1tYXA2NCIgbWln
aHQgYmVoYXZlIHRoZSBzYW1lIHdheS4gCkhvd2V2ZXIsIHRoZSBrZXkgZGlmZmVyZW5jZSBsaWVz
IGluIHRoZSBvZmZzZXQgcGFyYW1ldGVyLiBUaGUgIm1tYXAiIApmdW5jdGlvbiB1c2VzICJvZmZf
dCIgdHlwZSBmb3IgdGhlIG9mZnNldCBwYXJhbWV0ZXIsIHdoaWNoIGlzIGEgMzItYml0IAp0eXBl
IG9uIHNvbWUgc3lzdGVtcywgbGltaXRpbmcgdGhlIGZpbGUgc2l6ZSB0byAyR0IuIE9uIHRoZSBv
dGhlciBoYW5kLCAKIm1tYXA2NCIgdXNlcyAib2ZmNjRfdCIgZm9yIHRoZSBvZmZzZXQgcGFyYW1l
dGVyLCB3aGljaCBpcyBhIDY0LWJpdCAKdHlwZSwgYWxsb3dpbmcgZm9yIGxhcmdlciBmaWxlIHNp
emVzLgoKVGhpcyB0ZXN0IGNhc2UgaXMgZm9yIDMyYml0IHN5c3RlbXMuIE9uIGEgMzItYml0IHN5
c3RlbSwgbW1hcCBhbmQgbW1hcDY0IApzZXJ2ZSBzaW1pbGFyIHB1cnBvc2VzLCBidXQgbW1hcDY0
IGlzIHNwZWNpZmljYWxseSBkZXNpZ25lZCB0byBoYW5kbGUgCmZpbGVzIGxhcmdlciB0aGFuIDJH
Qi7CoCBJbiB0ZXN0IHByb2dyYW0gd2UgYXJlIG1hcHBpbmcgYXQgZmlsZSBvZmZzZXQgCjRHQsKg
IHNvIHdlIHNob3VsZCB1c2UgbW1hcDY0IHdpdGggX0xBUkdFRklMRTY0X1NPVVJDRSBtYWNyby4g
Cl9MQVJHRUZJTEU2NF9TT1VSQ0UgaXMgYWxyZWFkeSBkZWZpbmVkIGluIHRoZSB0ZXN0IHByb2dy
YW0gc28gb24gMzJiaXQgCnN5c3RlbXMgaXQgd2lsbCB0YWtlIG1tYXA2NCBwYXRoIG5vdCBtbWFw
IHBhdGguCgpIZW5jZSB3ZSBjYW5ub3QgdXNlIFNBRkVfTU1BUCBoZXJlLgoKSSBjYW4gd29yayBv
biBmaXhpbmcgd2FybmluZ3MgcmVsYXRlZCB0byB1bnVzZWQgcGFyYW1ldGVycy4KCkFyZSB0aGVy
ZSBhbnkgb3RoZXIgd2FybmluZ3MgdGhhdCB5b3Ugc2VlIHdpdGggdGhpcyBjb2RlPwoKVGhhbmtz
ICYgUmVnYXJkcywKR2VldGlrYQoKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
