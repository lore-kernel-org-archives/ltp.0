Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419D2C54E5D
	for <ltp@archiver.kernel.org>; Thu, 14 Mar 2024 08:57:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3233E3CFCE6
	for <ltp@archiver.kernel.org>; Thu, 14 Mar 2024 09:57:00 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 33F313CD7F4
 for <ltp@lists.linux.it>; Thu, 14 Mar 2024 09:56:44 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=meted@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8CB44600447
 for <ltp@lists.linux.it>; Thu, 14 Mar 2024 09:56:42 +0100 (CET)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42E8Md2X017088; Thu, 14 Mar 2024 08:56:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=S3sa/G25T2O3uUHmgN8u9hhEIyoXLAlATuHh0TTlR1I=;
 b=C8kE5EV3qD6s2WbjjWIe655LJ4fZdhCJ7750USHgSSQgm8CDQN/kgoS5pf9+iVz1MifA
 GsYSuNasZzSnjQghROV6hgSe/8ZROwIpDzO3KXaHpAEgnddlmNe9FmyEujedcsO79ZbU
 3vIOQ5Wmi8jiF2Gv3ws1xLMOY+66NcLDhJyuLUGFLy59kkmYaf6/VNRNTkY5B0enFSwT
 UO7eeRUBvZ69vbtKtXKXNvYKNEF3qBVAmU2lg4qcHn/+55HT9IuFzw2cFq6dPhps8FZi
 MncfPtlGc6FOtuOqcgo8ELwiNjcsDOELeMpxK7D5P4FwrfMa8QlhYWwJ2DBbDahEeXvp 9w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wuwnure6r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Mar 2024 08:56:40 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42E8n7vi001497;
 Thu, 14 Mar 2024 08:56:40 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wuwnure6k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Mar 2024 08:56:40 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42E5pTU7018582; Thu, 14 Mar 2024 08:56:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ws4t2bbwf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Mar 2024 08:56:39 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42E8uZcf30212384
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Mar 2024 08:56:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A8CE32004D;
 Thu, 14 Mar 2024 08:56:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E42E20040;
 Thu, 14 Mar 2024 08:56:35 +0000 (GMT)
Received: from [9.152.212.129] (unknown [9.152.212.129])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 14 Mar 2024 08:56:35 +0000 (GMT)
Message-ID: <0ce23c2c-6fdb-4f6b-84e1-080ec443ab85@linux.ibm.com>
Date: Thu, 14 Mar 2024 09:56:37 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, Amir Goldstein <amir73il@gmail.com>
References: <20240307092603.16269-1-meted@linux.ibm.com>
 <CAOQ4uxhFB2Gv2+8N-sc9a1+Kz1KqW+bniJe0JhVSHsaMWnxrmQ@mail.gmail.com>
 <3700d7c9-2f7e-4946-be27-87f500ccb6dd@linux.ibm.com>
 <CAOQ4uxgrGwiwpsLinWvVER-2W3AJxA0tR3qox-V4rxnt=OTTig@mail.gmail.com>
 <20240312131024.GA472499@pevik>
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <20240312131024.GA472499@pevik>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zrWoDwzl_Qr4-Nvyjeb2PhCTKfC0D5NZ
X-Proofpoint-ORIG-GUID: avIWlGL5QicVQ0IJ6XeVPDGy969ObIcL
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_07,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0
 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403140061
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

T24gMy8xMi8yNCAxNDoxMCwgUGV0ciBWb3JlbCB3cm90ZToKPiBIaSBNZXRlLCBBbWlyLCBMaSwK
PiAKPiBbIENjIExpIHdobyBrbm93cyBtb3JlIGFib3V0IFNFTGludXggOikgXQo+IAo+PiBPbiBN
b24sIE1hciAxMSwgMjAyNCBhdCA0OjUz4oCvUE0gTWV0ZSBEdXJsdSA8bWV0ZWRAbGludXguaWJt
LmNvbT4gd3JvdGU6Cj4gCj4+PiBPbiAzLzgvMjQgMTQ6MzksIEFtaXIgR29sZHN0ZWluIHdyb3Rl
Ogo+Pj4+IE9uIEZyaSwgTWFyIDgsIDIwMjQgYXQgMjo0M+KAr1BNIE1ldGUgRHVybHUgPG1ldGVk
QGxpbnV4LmlibS5jb20+IHdyb3RlOgo+IAo+Pj4+PiBXaGVuIFNFbGludXggaXMgY29uZmlndXJl
ZCAoY29tZXMgb3V0IG9mIHRoZSBib3ggb24gbW9zdCBkaXN0cm9zKSBhbmQKPj4+Pj4gaXMgY29u
ZmlndXJlZCB0byBlbmZvcmNpbmcgKHRoZSBkZWZhdWx0IGNvbmZpZ3VyYXRpb24pLCB0ZXN0cyBy
ZWxhdGVkCj4+Pj4+IHRvIGFub255bW91cyBwaXBlcyByZXR1cm4gRUFDQ0VTIGluc3RlYWQgb2Yg
dGhlIGV4cGVjdGVkIGVycm5vIEVJTlZBTC4KPj4+Pj4gRml4IHRoZSBmYWlsdXJlcyBjYXVzZWQg
YnkgdGhlIGFib3ZlIGNvbmRpdGlvbiBieSBjaGVja2luZyB0aGUgU0VsaW51eAo+Pj4+PiBjb25m
aWd1cmF0aW9uIGFuZCBhZGp1c3RpbmcgdGhlIGVycm5vIGFjY29yZGluZ2x5Lgo+IAo+Pj4+IEhp
IE1ldGUsCj4gCj4+Pj4gSXNuJ3QgdGhlIG91dGNvbWUgb2YgdGhlIHRlc3QgZGVwZW5kZW50IG9u
IHRoZSBTRXBvbGljeSBydWxlcz8KPj4+PiBOb3Qgb25seSBpZiBpdCBpcyBlbmZvcmNlZD8KPiAK
Pj4+PiBTb3JyeSBJIGhhdmUgdmVyeSBsaXR0bGUgZXhwZXJpZW5jZSB3aXRoIFNFTGludXguCj4g
Cj4gCj4+PiBIaSBBbWlyLAo+IAo+Pj4gSSBkb24ndCBoYXZlIFNFbGludXggZXhwZXJpZW5jZSBl
aXRoZXIsIG9uIG15IHByb3Bvc2VkIHBhdGNoIEkgb25seQo+Pj4gY29uc2lkZXJlZCB0aGUgZGVm
YXVsdCBiZWhhdmlvciBidXQgeW91IGFyZSByaWdodCBkaWZmZXJlbnQgU0VsaW51eAo+Pj4gY29u
ZmlndXJhdGlvbnMgbWF5IGxlYWQgdG8gZGlmZmVyZW50IG91dGNvbWVzLiBJIHNraW1tZWQgb3Zl
ciBTRWxpbnV4Cj4+PiB3aWtpIGEgbGl0dGxlIGFuZCBub3cgSSB0aGluayB0cnlpbmcgdG8gdmVy
aWZ5IHRoZSBTRWxpbnV4IHBvbGljeSB3b3VsZAo+Pj4gYmUgdG9vIGN1bWJlcnNvbWUuIEluc3Rl
YWQgSSBwcm9wb3NlIHR3byBkaWZmZXJlbnQgc29sdXRpb25zLgo+IAo+Pj4gMS4gV2UgY2FuIHNr
aXAgdGhlIGFub255bW91cyBwaXBlIHRlc3QgY2FzZXMgd2hlbiBTRWxpbnV4IGlzIGluCj4+PiAg
ICAgIGVuZm9yY2luZyBzdGF0ZS4KPiAKPj4+IG9yCj4gCj4+PiAyLiBXZSBjYW4gYWNjZXB0IGJv
dGggRUFDRVNTIGFuZCBFSU5WQUwgYXMgdmFsaWQgZXJybm9zIHdoZW4gU0VsaW51eCBpcwo+Pj4g
ICAgICBpbiBlbmZvcmNpbmcgc3RhdGUuCj4gCj4+PiBQZXJzb25hbGx5IG9wdGlvbiAyIHNvdW5k
cyBiZXR0ZXIgdG8gbWUgc2luY2Ugd2Ugd291bGQgZ2V0IG1vcmUgY292ZXJhZ2UKPj4+IHRoYXQg
d2F5LiBJZiBlaXRoZXIgd2F5IHNvdW5kcyBnb29kIEkgY2FuIHNlbmQgYSB2MiByaWdodCBhd2F5
LiBIb3cgZG9lcwo+Pj4gdGhhdCBzb3VuZD8KPiAKPj4gb3B0aW9uIDIgc291bmRzIGdvb2QgdG8g
bWUuCj4gCj4gWWVzLCBFQUNFU1MgZm9yIGVuZm9yY2VkIFNFTGludXggaXMgd2hhdCB3ZSB3YW50
Lgo+IAo+IE1ldGUsIHRoYW5rIHlvdSBmb3IgaGFuZGxpbmcgdGhpcy4gSSBjYW4gY29uZmlybSBp
dCdzIGEgcHJvYmxlbSBvbiBTRUxpbnV4Cj4gZW5mb3JjZWQuIEFuZCBJIHN1cHBvc2UgdGhlIGN1
cnJlbnQgY29kZSB3b3JrcywgYnV0IHdlIG5lZWQgc29tZSBtb2RpZmljYXRpb25zCj4gKHBsZWFz
ZSBsZXQgbWUga25vdyBpZiB5b3UgZG9uJ3QgaGF2ZSB0aW1lIGZvciB2Mik6CgpIaSwKCkkgd2Fz
IGhvcGluZyB0byBzb2x2ZSB0aGlzIHdpdGggYSBxdWljay9zbWFsbCBmaXggYnV0IEkgZ3Vlc3Mg
dGhlcmUgaXMKbW9yZSB0byBkby4KCj4gKiBQdXQgdHN0X3NlbGludXhfZW5mb3JjaW5nKCkgZnVu
Y3Rpb24gaW50byBMVFAgbGlicmFyeTogeW91IG5lZWQgdG8gY3JlYXRlCj4gbGliL3RzdF9zZWxp
bnV4LmMgYW5kIGluY2x1ZGUvdHN0X3NlbGludXguYy4gRm9yIGluc3BpcmF0aW9uIGhhdmUgbG9v
ayBhdAo+IGxpYi90c3RfbG9ja2Rvd24uYyB2diBpbmNsdWRlL3RzdF9sb2NrZG93bi5oLiBUaGUg
cmVhc29uIGlzIG9idmlvdXM6IHNvb25lciBvcgo+IGxhdGVyIHdlIHdpbGwgcmV1c2UgdGhpcyBm
dW5jdGlvbmFsaXR5LgoKSWYgdGhlcmUgaXMgbm8gcnVzaCBmb3IgdGhpcyBJIGNhbiBhZGQgdGhp
cyBpbiBhcyBhIHNlcGFyYXRlIHBhdGNoCnNlcmllcywgYnV0IEkgYW0gbm90IHN1cmUgd2hlbiBJ
IGNhbiBzdGFydC4gSWYgdGhpcyBpcyB1cmdlbnQgdGhlbgpwcm9iYWJseSBzb21lb25lIGVsc2Ug
c2hvdWxkIGRvIGl0LgoKPiAqIHVzZSBhY2Nlc3MoKSwgcHJpbnQgYWxzbyBUSU5GTyAoc2ltaWxh
cmx5IHRvIGxpYi90c3RfbG9ja2Rvd24uYykKPiAKPiAqIC9zeXMvZnMvc2VsaW51eCB2cy4gL3Nl
bGludXgsIHNlbGludXg9MSB2cy4gc2VjdXJpdHk9c2VsaW51eCAoL3Byb2MvY21kbGluZSkKPiBA
TGk6IFRMO0RSOiByZWFkaW5nIGp1c3QgL3N5cy9mcy9zZWxpbnV4L2VuZm9yY2UgTEdUTSwgYnV0
IHBsZWFzZSBjaGVjawo+IAo+IEkgc3VwcG9zZSB3ZSBjYW4gcmVseSBvbiBzZWxpbnV4ZnMgYmVp
bmcgbW91bnRlZCBvbiAvc3lzL2ZzL3NlbGludXg6Cj4gCj4gJCBtb3VudCB8IGdyZXAgLWkgc2Vs
aW51eAo+IHNlbGludXhmcyBvbiAvc3lzL2ZzL3NlbGludXggdHlwZSBzZWxpbnV4ZnMgKHJ3LG5v
c3VpZCxub2V4ZWMscmVsYXRpbWUpCj4gCj4gTG9uZyB0aW1lIGFnbyB0aGUgZGlyZWN0b3J5IHdh
cyBqdXN0IC9zZWxpbnV4IChSSEVMIDUgb3IgNj8pLCB0aGF0J3Mgd2h5IGl0J3MKPiBzdGlsbCBj
aGVja2VkIGluIHNoZWxsIEFQSSB0ZXN0Y2FzZXMvbGliL3RzdF9zZWN1cml0eS5zaC4gVGhlc2Ug
c3lzdGVtcyBhcmUKPiBxdWl0ZSBvbGQgdG8gcnVuIG5ld2VzdCBMVFAsIHJpZ2h0PyBGcm9tIGQ0
MTQxNWViNWVkYWUgWzFdIEkgc2VlIGl0IHdhcyBrZXJuZWwKPiAzLjAgPT4gd2F5IHRvbyBvbGQg
dG8gY29uc2lkZXIuCj4gCj4gSSBndWVzcyB3ZSBjYW5ub3QgcmVseSBvbiBzZWxpbnV4PTEgb3Ig
c2VjdXJpdHk9c2VsaW51eCB0byBkZXRlY3QgZW5mb3JjZSBtb2RlLgo+IFRoZXJlIGlzIFNFQ1VS
SVRZX1NFTElOVVhfQk9PVFBBUkFNLCB3aGVuIGRpc2FibGVkIHRodXMgdGhlcmUgaXMgbm8gc2Vs
aW51eD0xCj4gdmFyaWFibGUgaW4gL3Byb2MvY21kbGluZSwgdGh1cyB3ZSBjYW5ub3QgcmVseSBv
biBpdCAoaW5zdGVhZCBvZiB1c2luZwo+IC9zeXMvZnMvc2VsaW51eCkuCj4gCj4gQWxzbywga2Vy
bmVsIDwgdjUuMSBoYWQgU0VDVVJJVFlfU0VMSU5VWF9CT09UUEFSQU1fVkFMVUUgKHJlbW92ZWQg
aW4KPiBiZTZlYzg4ZjQxYmE5NCBpbiB2NS4xIFsyXSksIGFub3RoZXIgcmVhc29uIG5vdCB0byBy
ZWx5IG9uIHNlbGludXggaW4KPiAvcHJvYy9jbWRsaW5lLgo+IE5PVEU6IGFzIEkgbm90ZWQgcHJl
dmlvdXNseSB3ZSBoYXZlIHN1cHBvcnQgZm9yIFNFTGludXggKGFuZCBBcHBBcm1vcikgZGV0ZWN0
aW9uCj4gaW4gc2hlbGwgQVBJIHRlc3RjYXNlcy9saWIvdHN0X3NlY3VyaXR5LnNoLCB3ZSBtaWdo
dCBsYXRlciBjcmVhdGUgc2ltcGxlIEMKPiBiaW5hcnkgaW4gdGVzdGNhc2VzL2xpYi8gd2hpY2gg
d2lsbCBjYWxsIGZ1bmN0aW9uIHlvdSBjcmVhdGUgaW4gQyBBUEkgKHNpbWlsYXJseQo+IHRvIHRl
c3RjYXNlcy9saWIvdHN0X2xvY2tkb3duX2VuYWJsZWQuYyksIGJ1dCB3ZSBjYW4gaWdub3JlIGl0
IG5vdy4KPiAKPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+IAo+IFsxXSBodHRwczovL2dpdC5rZXJu
ZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvY29tbWl0
Lz9pZD1kNDE0MTVlYjVlZGFlCj4gWzJdIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9s
aW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvP2lkPWJlNmVjODhmNDFi
YTk0Cj4gCj4+IFRoYW5rcywKPj4gQW1pci4KCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
