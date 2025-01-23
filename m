Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF97C02182
	for <ltp@archiver.kernel.org>; Thu, 23 Jan 2025 17:38:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2CC7B3C4DF9
	for <ltp@archiver.kernel.org>; Thu, 23 Jan 2025 18:38:42 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED1823C4E21
 for <ltp@lists.linux.it>; Thu, 23 Jan 2025 18:38:18 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8F00C100035A
 for <ltp@lists.linux.it>; Thu, 23 Jan 2025 18:38:17 +0100 (CET)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NEQJnu026487;
 Thu, 23 Jan 2025 17:38:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=do++kN
 9OeziBKcS5mLlvvtu+ccocUOwUTuaNyHreyXY=; b=cLDTqvjj0ZuDlnya0OuaiI
 QHRTvudZ3v6VypzaKb2fsk3LOZcygh4ELgv+JoeUEjE5Bv75plViNlo3tJkbzE7A
 phTm9HyuKf72FUfQZ4P5YkhIsVC9jt70u1PccFTWLJRycaHJy8OniifxiJCcwCN0
 dfeSJM4wXNLyrWazlJ+jBFQQz/yqyamvCzlfAuBywCDHPSBMnGut7l1UCL71UFNN
 IkGRY3nsYh+RiEJa30j2386II6NHg+I02o7w/WxNN+yw29TcBecZvMpbqctHhKbS
 KdvtRZ1rhyDEjKI19alfDeGYwLNA0KQFhVxvR5dFwX3tJMlUbWZwlJYymafXM5tA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44bfk7ug3d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Jan 2025 17:38:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50NHZ3db019223;
 Thu, 23 Jan 2025 17:38:14 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 448pmsptvw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Jan 2025 17:38:14 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50NHcEM215467078
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Jan 2025 17:38:14 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E845458059;
 Thu, 23 Jan 2025 17:38:13 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5EB0158058;
 Thu, 23 Jan 2025 17:38:13 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.61.4.223]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Jan 2025 17:38:13 +0000 (GMT)
Message-ID: <52d6a8c168215e6dafe567b37bf5ac65e3b300eb.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Date: Thu, 23 Jan 2025 12:38:12 -0500
In-Reply-To: <20250114112915.610297-3-pvorel@suse.cz>
References: <20250114112915.610297-1-pvorel@suse.cz>
 <20250114112915.610297-3-pvorel@suse.cz>
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YgEcG4DbBteb5L7mvxLhX0wBH0bedKRP
X-Proofpoint-ORIG-GUID: YgEcG4DbBteb5L7mvxLhX0wBH0bedKRP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=999
 adultscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230128
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 02/10] IMA: Add TCB policy as an example for
 ima_measurements.sh
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
cm90ZToKPiBUYWtlbiBmcm9tIElNQSBkb2NzIFsxXSwgcmVtb3ZlZCBkb250X21lYXN1cmUgZnNt
YWdpYz0weDEwMjE5OTQgKHRtcGZzKQo+IGFzIHN1Z2dlc3RlZCBieSBNaW1pLgoKSSBiYWNrdHJh
Y2tlZCBvbiBteSBvcmlnaW5hbCBzdWdnZXN0aW9uLiAgSW5zdGVhZCBvZiByZW1vdmluZyB0aGUg
dG1wZnMgcnVsZSwgcXVhbGlmeQppdCBhcyB5b3UgZGlkIGJlbG93LgoKLT4gcXVhbGlmaWVkIHRo
ZSAiZG9udF9tZWFzdXJlIGZzbWFnaWM9MHgxMDIxOTk0IiAodG1wZnMpIHJ1bGUgdG8gdGhlIGZp
bGUgb3BlbiBob29rClsyXS4KCj4gCj4gWzFdIGh0dHBzOi8vaW1hLWRvYy5yZWFkdGhlZG9jcy5p
by9lbi9sYXRlc3QvaW1hLXBvbGljeS5odG1sI2ltYS10Y2IKPiAKPiBTaWduZWQtb2ZmLWJ5OiBQ
ZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KClsyXSBLZXJuZWwgY29tbWl0IDdlZWY3YzhiYWM5
YSAoImltYTogbGltaXQgdGhlIGJ1aWx0aW4gJ3RjYicgZG9udF9tZWFzdXJlIHRtcGZzCnBvbGlj
eSBydWxlIikKClJldmlld2VkLWJ5OiBNaW1pIFpvaGFyIDx6b2hhckBsaW51eC5pYm0uY29tPgoK
PiAtLS0KPiDCoC4uLi9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2RhdGFmaWxlcy9NYWtlZmlsZSB8
wqAgNCArKy0tCj4gwqAuLi4vaW1hL2RhdGFmaWxlcy9pbWFfbWVhc3VyZW1lbnRzL01ha2VmaWxl
wqDCoCB8IDExICsrKysrKysrKysKPiDCoC4uLi9pbWEvZGF0YWZpbGVzL2ltYV9tZWFzdXJlbWVu
dHMvdGNiLnBvbGljeSB8IDIwICsrKysrKysrKysrKysrKysrKysKPiDCoDMgZmlsZXMgY2hhbmdl
ZCwgMzMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiDCoGNyZWF0ZSBtb2RlIDEwMDY0
NAo+IHRlc3RjYXNlcy9rZXJuZWwvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9kYXRhZmlsZXMvaW1h
X21lYXN1cmVtZW50cy9NYWtlZmlsZQo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0Cj4gdGVzdGNhc2Vz
L2tlcm5lbC9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2RhdGFmaWxlcy9pbWFfbWVhc3VyZW1lbnRz
L3RjYi5wb2xpY3kKPiAKPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zZWN1cml0eS9p
bnRlZ3JpdHkvaW1hL2RhdGFmaWxlcy9NYWtlZmlsZQo+IGIvdGVzdGNhc2VzL2tlcm5lbC9zZWN1
cml0eS9pbnRlZ3JpdHkvaW1hL2RhdGFmaWxlcy9NYWtlZmlsZQo+IGluZGV4IDIwMGZkM2Y0ZDMu
LjBmMmI0ZmRiMTEgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zZWN1cml0eS9pbnRl
Z3JpdHkvaW1hL2RhdGFmaWxlcy9NYWtlZmlsZQo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc2Vj
dXJpdHkvaW50ZWdyaXR5L2ltYS9kYXRhZmlsZXMvTWFrZWZpbGUKPiBAQCAtMSw1ICsxLDUgQEAK
PiDCoCMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKPiAtIyBDb3B5
cmlnaHQgKGMpIExpbnV4IFRlc3QgUHJvamVjdCwgMjAxOS0yMDIwCj4gKyMgQ29weXJpZ2h0IChj
KSBMaW51eCBUZXN0IFByb2plY3QsIDIwMTktMjAyNQo+IMKgIyBDb3B5cmlnaHQgKGMpIDIwMjAg
TWljcm9zb2Z0IENvcnBvcmF0aW9uCj4gwqAjIENvcHlyaWdodCAoQykgMjAwOSwgQ2lzY28gU3lz
dGVtcyBJbmMuCj4gwqAjIE5naWUgQ29vcGVyLCBKdWx5IDIwMDkKPiBAQCAtOCw2ICs4LDYgQEAg
dG9wX3NyY2Rpcgk/PSAuLi8uLi8uLi8uLi8uLi8uLgo+IMKgCj4gwqBpbmNsdWRlCSQodG9wX3Ny
Y2RpcikvaW5jbHVkZS9tay9lbnZfcHJlLm1rCj4gwqAKPiAtU1VCRElSUwk6PSBpbWFfa2V4ZWMg
aW1hX2tleXMgaW1hX3BvbGljeSBpbWFfc2VsaW51eAo+ICtTVUJESVJTCTo9IGltYV9rZXhlYyBp
bWFfa2V5cyBpbWFfbWVhc3VyZW1lbnRzIGltYV9wb2xpY3kgaW1hX3NlbGludXgKPiDCoAo+IMKg
aW5jbHVkZSAkKHRvcF9zcmNkaXIpL2luY2x1ZGUvbWsvZ2VuZXJpY190cnVua190YXJnZXQubWsK
PiBkaWZmIC0tZ2l0Cj4gYS90ZXN0Y2FzZXMva2VybmVsL3NlY3VyaXR5L2ludGVncml0eS9pbWEv
ZGF0YWZpbGVzL2ltYV9tZWFzdXJlbWVudHMvTWFrZWZpbGUKPiBiL3Rlc3RjYXNlcy9rZXJuZWwv
c2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9kYXRhZmlsZXMvaW1hX21lYXN1cmVtZW50cy9NYWtlZmls
ZQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4gaW5kZXggMDAwMDAwMDAwMC4uNjMxN2YyYmY4NQo+
IC0tLSAvZGV2L251bGwKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3NlY3VyaXR5L2ludGVncml0
eS9pbWEvZGF0YWZpbGVzL2ltYV9tZWFzdXJlbWVudHMvTWFrZWZpbGUKPiBAQCAtMCwwICsxLDEx
IEBACj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKPiArIyBD
b3B5cmlnaHQgKGMpIExpbnV4IFRlc3QgUHJvamVjdCwgMjAyNQo+ICsKPiArdG9wX3NyY2Rpcgk/
PSAuLi8uLi8uLi8uLi8uLi8uLi8uLgo+ICsKPiAraW5jbHVkZQkkKHRvcF9zcmNkaXIpL2luY2x1
ZGUvbWsvZW52X3ByZS5tawo+ICsKPiArSU5TVEFMTF9ESVIJCTo9IHRlc3RjYXNlcy9kYXRhL2lt
YV9tZWFzdXJlbWVudHMKPiArSU5TVEFMTF9UQVJHRVRTCTo9ICoucG9saWN5Cj4gKwo+ICtpbmNs
dWRlICQodG9wX3NyY2RpcikvaW5jbHVkZS9tay9nZW5lcmljX2xlYWZfdGFyZ2V0Lm1rCj4gZGlm
ZiAtLWdpdAo+IGEvdGVzdGNhc2VzL2tlcm5lbC9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2RhdGFm
aWxlcy9pbWFfbWVhc3VyZW1lbnRzL3RjYi5wb2xpY3kKPiBiL3Rlc3RjYXNlcy9rZXJuZWwvc2Vj
dXJpdHkvaW50ZWdyaXR5L2ltYS9kYXRhZmlsZXMvaW1hX21lYXN1cmVtZW50cy90Y2IucG9saWN5
Cj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiBpbmRleCAwMDAwMDAwMDAwLi4xZTRhOTMyYmYwCj4g
LS0tIC9kZXYvbnVsbAo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc2VjdXJpdHkvaW50ZWdyaXR5
L2ltYS9kYXRhZmlsZXMvaW1hX21lYXN1cmVtZW50cy90Y2IucG9saWN5Cj4gQEAgLTAsMCArMSwy
MCBAQAo+ICtkb250X21lYXN1cmUgZnNtYWdpYz0weDlmYTAKPiArZG9udF9tZWFzdXJlIGZzbWFn
aWM9MHg2MjY1NjU3Mgo+ICtkb250X21lYXN1cmUgZnNtYWdpYz0weDY0NjI2NzIwCj4gK2RvbnRf
bWVhc3VyZSBmc21hZ2ljPTB4MTAyMTk5NCBmdW5jPUZJTEVfQ0hFQ0sKPiArZG9udF9tZWFzdXJl
IGZzbWFnaWM9MHgxY2QxCj4gK2RvbnRfbWVhc3VyZSBmc21hZ2ljPTB4NDI0OTRlNGQKPiArZG9u
dF9tZWFzdXJlIGZzbWFnaWM9MHg3MzYzNjY3Mwo+ICtkb250X21lYXN1cmUgZnNtYWdpYz0weGY5
N2NmZjhjCj4gK2RvbnRfbWVhc3VyZSBmc21hZ2ljPTB4NDM0MTVkNTMKPiArZG9udF9tZWFzdXJl
IGZzbWFnaWM9MHgyN2UwZWIKPiArZG9udF9tZWFzdXJlIGZzbWFnaWM9MHg2MzY3NzI3MAo+ICtk
b250X21lYXN1cmUgZnNtYWdpYz0weDZlNzM2NjczCj4gK2RvbnRfbWVhc3VyZSBmc21hZ2ljPTB4
ZGU1ZTgxZTQKPiArbWVhc3VyZSBmdW5jPU1NQVBfQ0hFQ0sgbWFzaz1NQVlfRVhFQwo+ICttZWFz
dXJlIGZ1bmM9QlBSTV9DSEVDSyBtYXNrPU1BWV9FWEVDCj4gK21lYXN1cmUgZnVuYz1GSUxFX0NI
RUNLIG1hc2s9Xk1BWV9SRUFEIGV1aWQ9MAo+ICttZWFzdXJlIGZ1bmM9RklMRV9DSEVDSyBtYXNr
PV5NQVlfUkVBRCB1aWQ9MAo+ICttZWFzdXJlIGZ1bmM9TU9EVUxFX0NIRUNLCj4gK21lYXN1cmUg
ZnVuYz1GSVJNV0FSRV9DSEVDSwo+ICttZWFzdXJlIGZ1bmM9UE9MSUNZX0NIRUNLCgoKLS0gCk1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
