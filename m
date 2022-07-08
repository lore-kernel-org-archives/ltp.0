Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7FEC433EF
	for <ltp@archiver.kernel.org>; Wed, 13 Jul 2022 09:39:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB2D33CA77A
	for <ltp@archiver.kernel.org>; Wed, 13 Jul 2022 11:39:17 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 603C93CA43B
 for <ltp@lists.linux.it>; Fri,  8 Jul 2022 15:35:50 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C174A601BD5
 for <ltp@lists.linux.it>; Fri,  8 Jul 2022 15:35:47 +0200 (CEST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 268DLuFu028959;
 Fri, 8 Jul 2022 13:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=zZmfro7mXR0S40WCOQWWHZkCS4KzvXqk4oBZ6pMPVSg=;
 b=HD0NuHGOJg628cgzFfVycNHLHvMJt4M4ssehwXjrod9DaCYvXe/YWOdFlkxSW/lZSNYA
 DpT45gEMmWjrjgBkCGAQhCiO4lry+Ji2HmeJWg9fupxjNhrM2iPuxnVqPK9Jz7WNS+O9
 68D3uPE6ISkuI8f99jSat170aRHBB1HNfLzfLPsBE1990NhytTHD0A3HiAjokOaD4JWR
 wOlcrQodcNkqn2voHgaG7X9hiIxMWzBTTb+yhwyMLUZo3bxDh+BEfnoBuDr1Z/n/X7fh
 TkIIINE20ytgMz5bTlYpONdlB9dBFhQU8UP0jjd7YIW6QQSY3u8iboVs6XiU2k+WKLDh OQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h6mh51qmw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Jul 2022 13:35:45 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 268DJkrM008061;
 Fri, 8 Jul 2022 13:35:43 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma03ams.nl.ibm.com with ESMTP id 3h4ujsm1sk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Jul 2022 13:35:42 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 268DZek025821560
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Jul 2022 13:35:40 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B47FC5204E;
 Fri,  8 Jul 2022 13:35:40 +0000 (GMT)
Received: from [9.145.86.83] (unknown [9.145.86.83])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D11EF52050;
 Fri,  8 Jul 2022 13:35:39 +0000 (GMT)
Message-ID: <475e984d-fc17-1632-6f1a-9ef2eb9442cd@linux.ibm.com>
Date: Fri, 8 Jul 2022 15:35:38 +0200
Content-Language: en-US
To: "Zhang, Cynthia X. (GSFC-710.0)[TELOPHASE CORP]" <cynthia.x.zhang@nasa.gov>
References: <PH0PR09MB8537C12911766525158A7828D5BD9@PH0PR09MB8537.namprd09.prod.outlook.com>
 <YsMpmLENCE42TgnA@yuki>
From: Peter Oberparleiter <oberpar@linux.ibm.com>
In-Reply-To: <YsMpmLENCE42TgnA@yuki>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: x002QOHSN9FWx-78O1fQxfaf-PJ9foQA
X-Proofpoint-GUID: x002QOHSN9FWx-78O1fQxfaf-PJ9foQA
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-08_11,2022-07-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 impostorscore=0 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207080051
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 13 Jul 2022 11:38:55 +0200
Subject: Re: [LTP] Inquiry: Country of Origin for LCOV Version 1.x
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksCgpwbGVhc2UgZmluZCBteSByZXBseSB0byB5b3VyIHF1ZXN0aW9ucyByZWdhcmRpbmcgTENP
ViBiZWxvdy4KCj4+IEhlbGxvLCBteSBuYW1lIGlz4oCvQ3ludGhpYeKAr2FuZCBJIGFtIGEgU3Vw
cGx5IENoYWluIFJpc2sgTWFuYWdlbWVudAo+PiBBbmFseXN0IGF0IE5BU0EuIE5BU0EgaXMgY3Vy
cmVudGx5IGNvbmR1Y3RpbmcgYSBzdXBwbHkgY2hhaW4KPj4gYXNzZXNzbWVudCBvZiBMQ09WIFZl
cnNpb24gMS54LiAgQXMgc3RhdGVkIGluIFNlY3Rpb25zIDIwOCBhbmQgNTE0IG9mCj4+IHRoZSBD
b25zb2xpZGF0ZWQgQXBwcm9wcmlhdGlvbnMgQWN0LCAyMDIyLCBQdWJsaWMgTGF3IDExNy0xMDMs
IGVuYWN0ZWQKPj4gTWFyY2ggMTUsIDIwMjIsIGEgcmVxdWlyZWQgc3RlcCBvZiBvdXIgcHJvY2Vz
cyBpcyB0byB2ZXJpZnkgdGhlCj4+IENvdW50cnkgb2YgT3JpZ2luIChDb08pIGluZm9ybWF0aW9u
IGZvciB0aGUgcHJvZHVjdCAoaS5lLiwgdGhlIGNvdW50cnkKPj4gd2hlcmUgdGhlIHByb2R1Y3Rz
IHdlcmUgZGV2ZWxvcGVkLCBtYW51ZmFjdHVyZWQsIGFuZCBhc3NlbWJsZWQuKSBBcwo+PiBMQ09W
IFZlcnNpb24gMS54IGlzIG9wZW4gc291cmNlLCB3ZSB1bmRlcnN0YW5kIHRoYXQgdGhpcyBpbnF1
aXJ5IGlzCj4+IG5vdCBkaXJlY3RseSBhcHBsaWNhYmxlLCBhcyBjb250cmlidXRpb25zIG1heSBi
ZSBtYWRlIGZyb20gaW5kaXZpZHVhbHMKPj4gZnJvbSBhcm91bmQgdGhlIHdvcmxkLiBJbiB0aGlz
IGNhc2UsIE5BU0EgaXMgaW50ZXJlc3RlZCBpbiBjb25maXJtaW5nCj4+IHRoZSBmb2xsb3dpbmcg
aW5mb3JtYXRpb246Cj4+Cj4+ICAgMS4gIElzIHRoZXJlIGFuIG9yZ2FuaXphdGlvbiB3aGljaCBz
cG9uc29ycy9wdWJsaXNoZXMgdGhlIHByb2plY3QsCj4+ICAgICAgIG9yIGEgcHJpbWFyeSBkZXZl
bG9wZXIgd2hvIGF1ZGl0cyB0aGUgY29kZSBmb3IgcG90ZW50aWFsCj4+ICAgICAgIHZ1bG5lcmFi
aWxpdGllcywgZXJyb3JzLCBvciBtYWxpY2lvdXMgY29kZT8gWS9OCj4+Cj4+ICAgMi4gIERvZXMg
TENPViBWZXJzaW9uIDEueCBoYXZlIGFuIG92ZXJzZWVpbmcgb3JnYW5pemF0aW9uIG9yCj4+ICAg
ICAgIGluZGl2aWR1YWwgYWxvbmcgdGhlc2UgbGluZXM/IFkvTgoKSUJNIGlzIHRoZSBtYWluIHNw
b25zb3Igb2Ygd29yayBvbiB0aGUgdXBzdHJlYW0gTENPViByZXBvc2l0b3J5IFsxXSwgYW5kCkkn
bSB3b3JraW5nIGFzIG1haW50YWluZXIgb2YgdGhlIExDT1YgY29kZSBiYXNlLiBJbiB0aGlzIHJv
bGUgSSByZXZpZXcKY29kZSBjb250cmlidXRpb25zIGZyb20gb3RoZXIgZGV2ZWxvcGVycyBmb3Ig
YXBwYXJlbnQgZXJyb3JzLCBhbmQKYWxpZ25tZW50IHdpdGggTENPVuKAmXMgcHJvamVjdCBnb2Fs
cyBbMl0gYW5kIGNvZGluZyBzdHlsZSBiZWZvcmUgaW5jbHVzaW9uLgoKSG93ZXZlciB0aGVyZSBp
cyBubyBmb3JtYWwgcHJvY2VkdXJlIGVzdGFibGlzaGVkIHRvIGF1ZGl0IHRoZSBjb2RlCnNwZWNp
ZmljYWxseSBmb3IgcG90ZW50aWFsIHZ1bG5lcmFiaWxpdGllcyBvciBtYWxpY2lvdXMgY29kZS4g
VGhlcmVmb3JlCnRoZSBhbnN3ZXIgdG8gdGhlc2UgdHdvIHF1ZXN0aW9ucyBpcyBuby4KCj4+ICAg
MS4gIElmIHNvLCBwbGVhc2UgcHJvdmlkZSB0aGUgbmFtZSBvZiB0aGUgb3JnYW5pemF0aW9uIGFu
ZCBjb3VudHJ5Cj4+ICAgdGhleSBhcmUgZXN0YWJsaXNoZWQgaW4uICBJZiB0aGUgaW5mb3JtYXRp
b24gYWJvdmUgaXMgdW5rbm93biBvcgo+PiAgIGNhbm5vdCBiZSBwcm92aWRlZCwgd2UgcmVxdWVz
dCB0aGF0IHlvdSBwcm92aWRlIHRoZSBjb3VudHJ5IG9yIGxpc3QKPj4gICBvZiBjb3VudHJpZXMg
d2hlcmUgdGhlIG1ham9yaXR5IG9mIGNvbnRyaWJ1dGlvbnMgb3JpZ2luYXRlIGZyb20gdG8KPj4g
ICBzYXRpc2Z5IFNlY3Rpb25zIDIwOCBhbmQgNTE0IG9mIHRoZSBDb25zb2xpZGF0ZWQgQXBwcm9w
cmlhdGlvbnMgQWN0LAo+PiAgIDIwMjIsIFB1YmxpYyBMYXcgMTE3LTEwMywgZW5hY3RlZCBNYXJj
aCAxNSwgMjAyMi4KCkF0IHRoZSB0aW1lIG9mIHdyaXRpbmcgKEp1bHkgMjAyMiksIHRoZSBtYWpv
cml0eSAoPjkwJSkgb2YgY29kZSBhcwptZWFzdXJlZCBpbiBsaW5lcyBvZiBjb2RlIGluIHRoZSBM
Q09WIHJlcG9zaXRvcnkgd2FzIGRldmVsb3BlZCBieSBteXNlbGYKb24gYmVoYWxmIG9mIOKAnElC
TSBEZXV0c2NobGFuZCBSZXNlYXJjaCAmIERldmVsb3BtZW50IEdtYkjigJ0gd2hpY2ggaXMgYQpH
ZXJtYW4gc3Vic2lkaWFyeSBvZiB0aGUgVVMtYmFzZWQgSUJNIENvcnBvcmF0aW9uLgoKRnVydGhl
cm1vcmUgdGhlIExDT1YgZ2l0IHJlcG9zaXRvcnkgWzFdIGNvbnRhaW5zIGEgcmVjb3JkIG9mIGFs
bApjb250cmlidXRpb25zLCBpbmNsdWRpbmcgdGhlIGUtbWFpbCBhZGRyZXNzIG9mIGVhY2ggY29u
dHJpYnV0b3IsIGJ1dCBubwphdHRyaWJ1dGlvbiB0byBjb3VudHJpZXMgb2Ygb3JpZ2luLgoKClJl
Z2FyZHMsCiAgUGV0ZXIKClsxXSBodHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0
L2xjb3YKWzJdIGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbGNvdi9ibG9i
L3YxLjE2L0NPTlRSSUJVVElORyNMNTEKCi0tIApQZXRlciBPYmVycGFybGVpdGVyCkxpbnV4IG9u
IElCTSBaIERldmVsb3BtZW50CklCTSBEZXV0c2NobGFuZCBSZXNlYXJjaCAmIERldmVsb3BtZW50
IEdtYkgKClZvcnNpdHplbmRlciBkZXMgQXVmc2ljaHRzcmF0czogR3JlZ29yIFBpbGxlbgpHZXNj
aMOkZnRzZsO8aHJ1bmc6IERhdmlkIEZhbGxlcgpTaXR6IGRlciBHZXNlbGxzY2hhZnQ6IELDtmJs
aW5nZW4KUmVnaXN0ZXJnZXJpY2h0OiBBbXRzZ2VyaWNodCBTdHV0dGdhcnQsIEhSQiAyNDMyOTQJ
CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8v
bHRwCg==
