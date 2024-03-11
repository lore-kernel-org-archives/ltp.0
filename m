Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D25C5475B
	for <ltp@archiver.kernel.org>; Mon, 11 Mar 2024 14:53:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE72E3CE9FD
	for <ltp@archiver.kernel.org>; Mon, 11 Mar 2024 15:53:46 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 48BDD3C196B
 for <ltp@lists.linux.it>; Mon, 11 Mar 2024 15:53:30 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=meted@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 016CE6014E6
 for <ltp@lists.linux.it>; Mon, 11 Mar 2024 15:53:28 +0100 (CET)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42BEWTYA019361; Mon, 11 Mar 2024 14:53:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=CHh0lJjZBPtW3eFb6aP4OKx/gMe5Xd44qKMAWrF0ntU=;
 b=saWdYfU29GQ9PqsGLo+v53RM9erEnjk9jRW7lXnizHKzjQNihLyEBw/8xCizGdgH3ATv
 151ZdxNzWMSUYzHrvN5na/0x4U1g+QgbjmDrhN10D8dzjUqkD+4vB/ZYBAD13uhwbfyS
 WDGWRBhccFJb0FmwHfc5WM5U3AH+XzCiGp/qNWSO35vLLWTWI45GE4WmnIE5YUOyIK7D
 9/m/tKUnibrSdF/0Q0N3XgJNISZm40NhK8KzBCjwmJ4OCEBQktRCMYlCdluNH6cCNlHG
 mSdHVjZbnXjuDEtR5NwpjCqB+pB6W8WoBsTCBLYxxJ5bKwhjK+hgC+izRtzSFbZu6hLy 8A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wt3t6gfrh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Mar 2024 14:53:25 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42BEoaGI007631;
 Mon, 11 Mar 2024 14:53:25 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wt3t6gfr0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Mar 2024 14:53:25 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42BDmL6Q014861; Mon, 11 Mar 2024 14:53:24 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws33nh3qn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Mar 2024 14:53:24 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42BErKRB48824742
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Mar 2024 14:53:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C44920043;
 Mon, 11 Mar 2024 14:53:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DEFC020040;
 Mon, 11 Mar 2024 14:53:19 +0000 (GMT)
Received: from [9.171.44.81] (unknown [9.171.44.81])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 11 Mar 2024 14:53:19 +0000 (GMT)
Message-ID: <3700d7c9-2f7e-4946-be27-87f500ccb6dd@linux.ibm.com>
Date: Mon, 11 Mar 2024 15:53:19 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Amir Goldstein <amir73il@gmail.com>
References: <20240307092603.16269-1-meted@linux.ibm.com>
 <CAOQ4uxhFB2Gv2+8N-sc9a1+Kz1KqW+bniJe0JhVSHsaMWnxrmQ@mail.gmail.com>
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <CAOQ4uxhFB2Gv2+8N-sc9a1+Kz1KqW+bniJe0JhVSHsaMWnxrmQ@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SCl_bNkKnWgPv25ToTaz93kh3OHuuNod
X-Proofpoint-ORIG-GUID: khlMTlDA-omo9zGYrl8ANwoHjWl1ffmW
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_10,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 malwarescore=0 mlxscore=0 clxscore=1011 spamscore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403110112
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] fanotify14: fix anonymous pipe testcases
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMy84LzI0IDE0OjM5LCBBbWlyIEdvbGRzdGVpbiB3cm90ZToKPiBPbiBGcmksIE1hciA4LCAy
MDI0IGF0IDI6NDPigK9QTSBNZXRlIER1cmx1IDxtZXRlZEBsaW51eC5pYm0uY29tPiB3cm90ZToK
Pj4KPj4gV2hlbiBTRWxpbnV4IGlzIGNvbmZpZ3VyZWQgKGNvbWVzIG91dCBvZiB0aGUgYm94IG9u
IG1vc3QgZGlzdHJvcykgYW5kCj4+IGlzIGNvbmZpZ3VyZWQgdG8gZW5mb3JjaW5nICh0aGUgZGVm
YXVsdCBjb25maWd1cmF0aW9uKSwgdGVzdHMgcmVsYXRlZAo+PiB0byBhbm9ueW1vdXMgcGlwZXMg
cmV0dXJuIEVBQ0NFUyBpbnN0ZWFkIG9mIHRoZSBleHBlY3RlZCBlcnJubyBFSU5WQUwuCj4+IEZp
eCB0aGUgZmFpbHVyZXMgY2F1c2VkIGJ5IHRoZSBhYm92ZSBjb25kaXRpb24gYnkgY2hlY2tpbmcg
dGhlIFNFbGludXgKPj4gY29uZmlndXJhdGlvbiBhbmQgYWRqdXN0aW5nIHRoZSBlcnJubyBhY2Nv
cmRpbmdseS4KPiAKPiBIaSBNZXRlLAo+IAo+IElzbid0IHRoZSBvdXRjb21lIG9mIHRoZSB0ZXN0
IGRlcGVuZGVudCBvbiB0aGUgU0Vwb2xpY3kgcnVsZXM/Cj4gTm90IG9ubHkgaWYgaXQgaXMgZW5m
b3JjZWQ/Cj4gCj4gU29ycnkgSSBoYXZlIHZlcnkgbGl0dGxlIGV4cGVyaWVuY2Ugd2l0aCBTRUxp
bnV4Lgo+IAoKSGkgQW1pciwKCkkgZG9uJ3QgaGF2ZSBTRWxpbnV4IGV4cGVyaWVuY2UgZWl0aGVy
LCBvbiBteSBwcm9wb3NlZCBwYXRjaCBJIG9ubHkKY29uc2lkZXJlZCB0aGUgZGVmYXVsdCBiZWhh
dmlvciBidXQgeW91IGFyZSByaWdodCBkaWZmZXJlbnQgU0VsaW51eApjb25maWd1cmF0aW9ucyBt
YXkgbGVhZCB0byBkaWZmZXJlbnQgb3V0Y29tZXMuIEkgc2tpbW1lZCBvdmVyIFNFbGludXgKd2lr
aSBhIGxpdHRsZSBhbmQgbm93IEkgdGhpbmsgdHJ5aW5nIHRvIHZlcmlmeSB0aGUgU0VsaW51eCBw
b2xpY3kgd291bGQKYmUgdG9vIGN1bWJlcnNvbWUuIEluc3RlYWQgSSBwcm9wb3NlIHR3byBkaWZm
ZXJlbnQgc29sdXRpb25zLgoKMS4gV2UgY2FuIHNraXAgdGhlIGFub255bW91cyBwaXBlIHRlc3Qg
Y2FzZXMgd2hlbiBTRWxpbnV4IGlzIGluCiAgICBlbmZvcmNpbmcgc3RhdGUuCgpvcgoKMi4gV2Ug
Y2FuIGFjY2VwdCBib3RoIEVBQ0VTUyBhbmQgRUlOVkFMIGFzIHZhbGlkIGVycm5vcyB3aGVuIFNF
bGludXggaXMKICAgIGluIGVuZm9yY2luZyBzdGF0ZS4KClBlcnNvbmFsbHkgb3B0aW9uIDIgc291
bmRzIGJldHRlciB0byBtZSBzaW5jZSB3ZSB3b3VsZCBnZXQgbW9yZSBjb3ZlcmFnZQp0aGF0IHdh
eS4gSWYgZWl0aGVyIHdheSBzb3VuZHMgZ29vZCBJIGNhbiBzZW5kIGEgdjIgcmlnaHQgYXdheS4g
SG93IGRvZXMKdGhhdCBzb3VuZD8KClRoYW5rIHlvdS4KCj4gCj4+Cj4+IFNpZ25lZC1vZmYtYnk6
IE1ldGUgRHVybHUgPG1ldGVkQGxpbnV4LmlibS5jb20+Cj4+IC0tLQo+PiAgIHRlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkxNC5jIHwgMTcgKysrKysrKysrKysrKysr
KysKPj4gICAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKQo+Pgo+PiBkaWZmIC0tZ2l0
IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTE0LmMgYi90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MTQuYwo+PiBpbmRleCBkMDJk
ODE0OTUuLjYxZWQ4YzY2MCAxMDA2NDQKPj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9mYW5vdGlmeS9mYW5vdGlmeTE0LmMKPj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9mYW5vdGlmeS9mYW5vdGlmeTE0LmMKPj4gQEAgLTI3LDEyICsyNywxNCBAQAo+PiAgICNkZWZp
bmUgX0dOVV9TT1VSQ0UKPj4gICAjaW5jbHVkZSAidHN0X3Rlc3QuaCIKPj4gICAjaW5jbHVkZSA8
ZXJybm8uaD4KPj4gKyNpbmNsdWRlIDxzdGRsaWIuaD4KPj4KPj4gICAjaWZkZWYgSEFWRV9TWVNf
RkFOT1RJRllfSAo+PiAgICNpbmNsdWRlICJmYW5vdGlmeS5oIgo+Pgo+PiAgICNkZWZpbmUgTU5U
UE9JTlQgIm1udHBvaW50Igo+PiAgICNkZWZpbmUgRklMRTEgTU5UUE9JTlQiL2ZpbGUxIgo+PiAr
I2RlZmluZSBTRUxJTlVYX1NUQVRVU19QQVRIICIvc3lzL2ZzL3NlbGludXgvZW5mb3JjZSIKPj4K
Pj4gICAvKgo+PiAgICAqIExpc3Qgb2YgaW5vZGUgZXZlbnRzIHRoYXQgYXJlIG9ubHkgYXZhaWxh
YmxlIHdoZW4gbm90aWZpY2F0aW9uIGdyb3VwIGlzCj4+IEBAIC0yNDAsNiArMjQyLDE5IEBAIHN0
YXRpYyBzdHJ1Y3QgdGVzdF9jYXNlX3Qgewo+PiAgICAgICAgICB9LAo+PiAgIH07Cj4+Cj4+ICtz
dGF0aWMgaW50IGlzX3NlbGludXhfZW5mb3JjaW5nKHZvaWQpCj4+ICt7Cj4+ICsgICAgICAgY2hh
ciByZXM7Cj4+ICsgICAgICAgaW50IGZkOwo+PiArCj4+ICsgICAgICAgZmQgPSBvcGVuKFNFTElO
VVhfU1RBVFVTX1BBVEgsIE9fUkRPTkxZKTsKPj4gKyAgICAgICBpZiAoZmQgPD0gMCkKPj4gKyAg
ICAgICAgICAgICAgIHJldHVybiAwOwo+PiArICAgICAgIFNBRkVfUkVBRCgxLCBmZCwgJnJlcywg
MSk7Cj4+ICsgICAgICAgU0FGRV9DTE9TRShmZCk7Cj4+ICsgICAgICAgcmV0dXJuIGF0b2koJnJl
cyk7Cj4+ICt9Cj4+ICsKPj4gICBzdGF0aWMgdm9pZCBkb190ZXN0KHVuc2lnbmVkIGludCBudW1i
ZXIpCj4+ICAgewo+PiAgICAgICAgICBzdHJ1Y3QgdGVzdF9jYXNlX3QgKnRjID0gJnRlc3RfY2Fz
ZXNbbnVtYmVyXTsKPj4gQEAgLTI3OSw2ICsyOTQsOCBAQCBzdGF0aWMgdm9pZCBkb190ZXN0KHVu
c2lnbmVkIGludCBudW1iZXIpCj4+ICAgICAgICAgIGlmICh0Yy0+cGZkKSB7Cj4+ICAgICAgICAg
ICAgICAgICAgZGlyZmQgPSB0Yy0+cGZkWzBdOwo+PiAgICAgICAgICAgICAgICAgIHBhdGggPSBO
VUxMOwo+PiArICAgICAgICAgICAgICAgaWYgKGlzX3NlbGludXhfZW5mb3JjaW5nKCkpCj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgIHRjLT5leHBlY3RlZF9lcnJubyA9IEVBQ0NFUzsKPj4gICAg
ICAgICAgfQo+Pgo+PiAgICAgICAgICB0c3RfcmVzKFRJTkZPLCAiVGVzdGluZyAlcyB3aXRoICVz
IiwKPj4gLS0KPj4gMi40NC4wCj4+Cj4+Cj4+IC0tCj4+IE1haWxpbmcgbGlzdCBpbmZvOiBodHRw
czovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
