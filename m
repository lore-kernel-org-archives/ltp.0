Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60BAC54E68
	for <ltp@archiver.kernel.org>; Thu, 21 Mar 2024 06:50:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F8273CE635
	for <ltp@archiver.kernel.org>; Thu, 21 Mar 2024 07:50:04 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 32EC83CD7F0
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 07:49:47 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=shirisha@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5916C20B4B5
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 07:49:45 +0100 (CET)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42L6lfdY029911; Thu, 21 Mar 2024 06:49:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=3lpImnUxPrCurxG+1XUxFhOB92uDgCd2I4ggLmR6C0k=;
 b=fBrlw3kBRScR4BxDVa7Gnb2xSEDchdk53KCLctXFfUqZVs87xFTruQS/3Uu4blK4ENS+
 CEVl3mf9Y5iomS7Gcl5Q9DmSaqkcIQYX3YHZ0s9PV7iMIeLbZbnnw6BlZm+a7AoEorw6
 rSB8CFgdQg4Zd21TWfek3dvKp9ZbSi55sWDw9roVInX2FQNzEvDbhEEwCkPr3nfEGap1
 l+x2w1MvDj7viNSiOJvcfvzuBKD9isSmbM/c+D/1FUUfq5B/kCpDeNUjCuZXfwEhz6OG
 ylZnTHH6HQA7jJb2jSYBPwUQMG4iDEoi5Xlg46cpWp5rDupGJgvgi/HDaryrfQewc8rU 7w== 
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0c6m0dek-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Mar 2024 06:49:43 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42L62YOU015806; Thu, 21 Mar 2024 06:49:42 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wwp50bhe0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Mar 2024 06:49:41 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42L6ncri41681218
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Mar 2024 06:49:40 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EDB152004B;
 Thu, 21 Mar 2024 06:49:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5400020040;
 Thu, 21 Mar 2024 06:49:37 +0000 (GMT)
Received: from li-d12addcc-2792-11b2-a85c-bd8df30615ab.ibm.com (unknown
 [9.199.152.158])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 21 Mar 2024 06:49:37 +0000 (GMT)
Message-ID: <1859dfba3ef5b57c9f7ebb5dfe5d819fda946d4a.camel@linux.ibm.com>
From: Shirisha ganta <shirisha@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 21 Mar 2024 12:19:36 +0530
In-Reply-To: <20231128111024.GA364870@pevik>
References: <20230929091401.205277-1-shirisha@linux.ibm.com>
 <20231128111024.GA364870@pevik>
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5A3sJ9WOOO_9ScvMjCntQfXBCJMI_PdK
X-Proofpoint-ORIG-GUID: 5A3sJ9WOOO_9ScvMjCntQfXBCJMI_PdK
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_04,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0
 spamscore=0 impostorscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403210043
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Migrating the
 libhugetlbfs/testcases/truncate.c test
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCAyMDIzLTExLTI4IGF0IDEyOjEwICswMTAwLCBQZXRyIFZvcmVsIHdyb3RlOgo+IEhp
LAo+IAo+IE1heWJlIEknbSBzbG93LCBidXQgaXQgd2FzIG5vdCBub3Qgb2J2aW91cyBmcm9tIHRo
ZSBzdWJqZWN0Cj4gIk1pZ3JhdGluZyB0aGUKPiBsaWJodWdldGxiZnMvdGVzdGNhc2VzL3RydW5j
YXRlLmMgdGVzdCIgdGhhdCB5b3UgbWlncmF0ZSB0ZXN0IGZyb206Cj4gaHR0cHM6Ly9naXRodWIu
Y29tL2xpYmh1Z2V0bGJmcy9saWJodWdldGxiZnMvYmxvYi9tYXN0ZXIvdGVzdHMvdHJ1bmNhdGUu
Ywo+IAo+IEknZCBwZXJzb25hbGx5IGhhdmUgc3ViamVjdAo+IAo+IEFkZCBodWdlbW1hcDMzICh2
ZXJ5IHNvcnQgZGVzY3JpcHRpb24gb2YgdGhlIHRlc3QpCj4gCj4gQW5kIHRoZW4gbGF0ZXIgbWVu
dGlvbiBpbiB0aGUgY29tbWl0IG1lc3NhZ2UgdGhhdCB0aGUgdGVzdCBvcmlnaW5hdGVzCj4gZnJv
bQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9saWJodWdldGxiZnMvbGliaHVnZXRsYmZzL2Jsb2IvbWFz
dGVyL3Rlc3RzL3RydW5jYXRlLmMKPiAKPiBOT1RFOiBpZiB5b3UgcnVuIHRlc3QgbW9yZSB0aW1l
cyAoLWlOKSwgaXQgZmFpbHMsIGUuZy46Cj4gCj4gLi9odWdlbW1hcDMzIC1pMgo+IHRzdF9odWdl
cGFnZS5jOjg0OiBUSU5GTzogMSBodWdlcGFnZShzKSByZXNlcnZlZAo+IHRzdF90ZXN0LmM6MTAz
NzogVElORk86IE1vdW50aW5nIG5vbmUgdG8gL3RtcC9MVFBfaHVnaVVMVEo3L2h1Z2V0bGJmcwo+
IGZzdHlwPWh1Z2V0bGJmcyBmbGFncz0wCj4gdHN0X3Rlc3QuYzoxNjkwOiBUSU5GTzogTFRQIHZl
cnNpb246IDIwMjMwOTI5LTE1Mi1nY2U4N2M4ZGUzCj4gdHN0X3Rlc3QuYzoxNTc0OiBUSU5GTzog
VGltZW91dCBwZXIgcnVuIGlzIDBoIDAwbSAzMHMKPiBodWdlbW1hcDMzLmM6NTY6IFRQQVNTOiBF
eHBlY3RlZCBTSUdCVVMgdHJpZ2dlcmVkCj4gdHN0X3Rlc3QuYzoxNjM0OiBUQlJPSzogVGVzdCBr
aWxsZWQgYnkgU0lHQlVTIQo+IAo+IENvdWxkIHlvdSBwbGVhc2UgZml4IGl0PwoKV2lsbCB0YWtl
IGNhcmUgb2YgdGhpcyBpbiBWNAo+IAo+IEFsc28sIHdlIHVzZSBzdGF0aWMgd2hlbmV2ZXIgd2Ug
Y2FuLCBwbGVhc2UgZml4IHRoZXNlOgo+IAo+ICQgbWFrZSBjaGVjay1odWdlbW1hcDMzCj4gQ0hF
Q0sgdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlbW1hcC9odWdlbW1hcDMzLmMKPiBo
dWdlbW1hcDMzLmM6NjE6Njogd2FybmluZzogU3ltYm9sICdzZXR1cCcgaGFzIG5vIHByb3RvdHlw
ZSBvcgo+IGxpYnJhcnkgKCd0c3RfJykgcHJlZml4LiBTaG91bGQgaXQgYmUgc3RhdGljPwo+IGh1
Z2VtbWFwMzMuYzo3MTo2OiB3YXJuaW5nOiBTeW1ib2wgJ2NsZWFudXAnIGhhcyBubyBwcm90b3R5
cGUgb3IKPiBsaWJyYXJ5ICgndHN0XycpIHByZWZpeC4gU2hvdWxkIGl0IGJlIHN0YXRpYz8KPiAK
PiA+IFRlc3QgRGVzY3JpcHRpb246Cj4gVGhpcyBsaW5lIGlzIHVzZWxlc3MuClRoaXMgaXMgdGhl
IGdlbmVyYWwgcHJhY3RpY2UgZm9sbG93ZWQgYnkgYWxsIHRoZSB0ZXN0IGNhc2VzIGluIHRoaXMK
Zm9sZGVyIGFuZCBJIGZvbGxvd2VkIHRoZSBzYW1lLgo+IAo+ID4gVGVzdCBpcyB1c2VkIHRvIHZl
cmlmeSB0aGUgY29ycmVjdCBmdW5jdGlvbmFsaXR5IGFuZAo+ID4gY29tcGF0aWJpbGl0eSBvZiB0
aGUgbGlicmFyeSB3aXRoIHRoZSAidHJ1bmNhdGUiIHN5c3RlbQo+ID4gY2FsbCB3aGVuIG9wZXJh
dGluZyBvbiBmaWxlcyByZXNpZGluZyBpbiBhIG1vdW50ZWQKPiA+IGh1Z2UgcGFnZSBmaWxlc3lz
dGVtLgo+ID4gU2lnbmVkLW9mZi1ieTogU2hpcmlzaGEgRyA8c2hpcmlzaGFAbGludXguaWJtLmNv
bT4KPiA+IC0tLQo+ID4gdjM6Cj4gPiAgLUFkZHJlc3NlZCB0aGUgYmVsb3cgcmVxdWVzdGVkIGNo
YW5nZXMgCj4gPiAgIDEuIFJlbW92ZWQgUkFORE9NX0NPTlNUQU5UCj4gPiAgIDIuIE1hZGUgaHBh
Z2Vfc2l6ZSBhbmQgZmQgdG8gc3RhdGljCj4gPiAgIDMuIFVzZWQgYSB2b2xhdGlsZSB2YXJpYWJs
ZSBhcyBhIGZsYWcKPiA+ICAgICAgdG8gcGFzcyB0ZXN0IGluIHRoZSBydW5fdGVzdCgpCj4gPiAg
IDQuIFJlbW92ZWQgdGhlIGZhaWx1cmUgY29uZGl0aW9uIGZvciBTQUZFX01NQVAoKQo+ID4gICA1
LiBIYXZlIHNldHVwIHRoZSBoYW5kbGVyIGluIHRoZSBzZXR1cCgpCj4gPiAgIDYuIEFkZGVkIFNB
RkVfTVVOTUFQKCkKPiA+ICAgNy4gUmFuIG1ha2UgY2hlY2sgYW5kIGZpeGVkIGFsbCBpc3N1ZXMK
PiA+IC0tLQo+ID4gdjI6Cj4gPiAgLUNvcnJlY3RlZCB0eXBvCj4gPiAtLS0KPiA+ICBydW50ZXN0
L2h1Z2V0bGIgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMSArCj4gPiAgdGVzdGNh
c2VzL2tlcm5lbC9tZW0vLmdpdGlnbm9yZSAgICAgICAgICAgICAgIHwgIDEgKwo+ID4gIC4uLi9r
ZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZW1tYXAvaHVnZW1tYXAzMy5jICB8IDg4Cj4gPiArKysrKysr
KysrKysrKysrKysrCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCA5MCBpbnNlcnRpb25zKCspCj4gPiAg
Y3JlYXRlIG1vZGUgMTAwNjQ0Cj4gPiB0ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2Vt
bWFwL2h1Z2VtbWFwMzMuYwo+ID4gZGlmZiAtLWdpdCBhL3J1bnRlc3QvaHVnZXRsYiBiL3J1bnRl
c3QvaHVnZXRsYgo+ID4gaW5kZXggMjk5YzA3YWM5Li4xMzAwZTgwZmIgMTAwNjQ0Cj4gPiAtLS0g
YS9ydW50ZXN0L2h1Z2V0bGIKPiA+ICsrKyBiL3J1bnRlc3QvaHVnZXRsYgo+ID4gQEAgLTM1LDYg
KzM1LDcgQEAgaHVnZW1tYXAyOSBodWdlbW1hcDI5Cj4gPiAgaHVnZW1tYXAzMCBodWdlbW1hcDMw
Cj4gPiAgaHVnZW1tYXAzMSBodWdlbW1hcDMxCj4gPiAgaHVnZW1tYXAzMiBodWdlbW1hcDMyCj4g
PiAraHVnZW1tYXAzMyBodWdlbW1hcDMzCj4gPiAgaHVnZW1tYXAwNV8xIGh1Z2VtbWFwMDUgLW0K
PiA+ICBodWdlbW1hcDA1XzIgaHVnZW1tYXAwNSAtcwo+ID4gIGh1Z2VtbWFwMDVfMyBodWdlbW1h
cDA1IC1zIC1tCj4gPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vLmdpdGlnbm9y
ZQo+ID4gYi90ZXN0Y2FzZXMva2VybmVsL21lbS8uZ2l0aWdub3JlCj4gPiBpbmRleCA3MjU4NDg5
ZWQuLmQxMzBkNGRjZCAxMDA2NDQKPiA+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtLy5naXRp
Z25vcmUKPiA+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtLy5naXRpZ25vcmUKPiA+IEBAIC0z
NCw2ICszNCw3IEBACj4gPiAgL2h1Z2V0bGIvaHVnZW1tYXAvaHVnZW1tYXAzMAo+ID4gIC9odWdl
dGxiL2h1Z2VtbWFwL2h1Z2VtbWFwMzEKPiA+ICAvaHVnZXRsYi9odWdlbW1hcC9odWdlbW1hcDMy
Cj4gPiArL2h1Z2V0bGIvaHVnZW1tYXAvaHVnZW1tYXAzMwo+ID4gIC9odWdldGxiL2h1Z2VzaG1h
dC9odWdlc2htYXQwMQo+ID4gIC9odWdldGxiL2h1Z2VzaG1hdC9odWdlc2htYXQwMgo+ID4gIC9o
dWdldGxiL2h1Z2VzaG1hdC9odWdlc2htYXQwMwo+ID4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9r
ZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZW1tYXAvaHVnZW1tYXAzMy5jCj4gPiBiL3Rlc3RjYXNlcy9r
ZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZW1tYXAvaHVnZW1tYXAzMy5jCj4gPiBuZXcgZmlsZSBtb2Rl
IDEwMDY0NAo+ID4gaW5kZXggMDAwMDAwMDAwLi4zNDA1NjI3ZjYKPiA+IC0tLSAvZGV2L251bGwK
PiA+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZW1tYXAvaHVnZW1tYXAz
My5jCj4gPiBAQCAtMCwwICsxLDg4IEBACj4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
IEdQTC0yLjAtb3ItbGF0ZXIKPiA+ICsvKgo+ID4gKyAqIENvcHlyaWdodCAoQykgMjAwNS0yMDA2
IElCTSBDb3Jwb3JhdGlvbi4KPiBNYXliZSBhbHNvIHlvdXIgb3IgTFRQIGNvcHlyaWdodCBoZXJl
LCBhcyBjbGVhcmx5IHRoZXJlIGlzIExUUAo+IHNwZWNpZmljIGNvZGUuCj4gCj4gPiArICogQXV0
aG9yOiBEYXZpZCBHaWJzb24gJiBBZGFtIExpdGtlCj4gPiArICovCj4gPiArCj4gPiArLypcCj4g
PiArICogW0Rlc2NyaXB0aW9uXQo+ID4gKyAqCj4gPiArICogVGVzdCBOYW1lOiB0cnVuY2F0ZQo+
IFRoaXMgaXMgd3JvbmcgYW5kIHVzZWxlc3MsIHBsZWFzZSByZW1vdmUgaXQuCldpbGwgdGFrZSBj
YXJlIG9mIHRoaXMgaW4gVjQKPiA+ICsgKgo+ID4gKyAqIFRlc3QgY2FzZSBpcyB1c2VkIHRvIHZl
cmlmeSB0aGUgY29ycmVjdCBmdW5jdGlvbmFsaXR5Cj4gPiArICogYW5kIGNvbXBhdGliaWxpdHkg
b2YgdGhlIGxpYnJhcnkgd2l0aCB0aGUgInRydW5jYXRlIiBzeXN0ZW0KPiA+IGNhbGwgd2hlbgo+
ID4gKyAqIG9wZXJhdGluZyBvbiBmaWxlcyByZXNpZGluZyBpbiBhIG1vdW50ZWQgaHVnZSBwYWdl
IGZpbGVzeXN0ZW0uCj4gPiArICovCj4gPiArCj4gPiArI2luY2x1ZGUgImh1Z2V0bGIuaCIKPiA+
ICsjaW5jbHVkZSA8c2V0am1wLmg+Cj4gPiArI2luY2x1ZGUgPHNpZ25hbC5oPgo+ID4gKwo+ID4g
KyNkZWZpbmUgTU5UUE9JTlQgImh1Z2V0bGJmcy8iCj4gPiArCj4gPiArc3RhdGljIGxvbmcgaHBh
Z2Vfc2l6ZTsKPiA+ICtzdGF0aWMgaW50IGZkOwo+ID4gK3N0YXRpYyBzaWdqbXBfYnVmIHNpZ19l
c2NhcGU7Cj4gPiArc3RhdGljIHZvbGF0aWxlIGludCB0ZXN0X3Bhc3M7Cj4gPiArc3RhdGljIGlu
dCBzaWdidXNfY291bnQ7Cj4gPiArCj4gPiArc3RhdGljIHZvaWQgc2lnYnVzX2hhbmRsZXIoaW50
IHNpZ251bSkKPiAKPiBodWdlbW1hcDMzLmM6Mjk6MzI6IHdhcm5pbmc6IHVudXNlZCBwYXJhbWV0
ZXIg4oCYc2lnbnVt4oCZIFstV3VudXNlZC0KPiBwYXJhbWV0ZXJdCj4gICAgMjkgfCBzdGF0aWMg
dm9pZCBzaWdidXNfaGFuZGxlcihpbnQgc2lnbnVtKQo+IAo+IFRoZXJlZm9yZSB1c2UKPiBzdGF0
aWMgdm9pZCBzaWdidXNfaGFuZGxlcihpbnQgc2lnbnVtIExUUF9BVFRSSUJVVEVfVU5VU0VEKQoK
V2lsbCB0YWtlIGNhcmUgb2YgdGhpcyBpbiBWNAo+IAo+ID4gK3sKPiA+ICsJdGVzdF9wYXNzID0g
MTsKPiA+ICsJc2lnbG9uZ2ptcChzaWdfZXNjYXBlLCAxNyk7Cj4gPiArfQo+ID4gKwo+ID4gK3N0
YXRpYyB2b2lkIHJ1bl90ZXN0KHZvaWQpCj4gPiArewo+ID4gKwl2b2lkICpwOwo+ID4gKwl2b2xh
dGlsZSB1bnNpZ25lZCBpbnQgKnE7Cj4gPiArCj4gPiArCXNpZ2J1c19jb3VudCA9IDA7Cj4gPiAr
CXRlc3RfcGFzcyA9IDA7Cj4gPiArCWludCBlcnI7Cj4gPiArCj4gPiArCXAgPSBTQUZFX01NQVAo
TlVMTCwgaHBhZ2Vfc2l6ZSwgUFJPVF9SRUFEfFBST1RfV1JJVEUsCj4gPiBNQVBfU0hBUkVELAo+
ID4gKwkJCWZkLCAwKTsKPiA+ICsJcSA9IHA7Cj4gPiArCSpxID0gMDsKPiA+ICsJZXJyID0gZnRy
dW5jYXRlKGZkLCAwKTsKPiBCbGFuayBsaW5lIGhlcmUgd291bGQgaGVscCByZWFkYWJpbGl0eS4K
V2lsbCB0YWtlIGNhcmUgb2YgdGhpcyBpbiBWNAo+IAo+ID4gKwlpZiAoZXJyKQo+ID4gKwkJdHN0
X3JlcyhURkFJTCwgImZ0cnVuY2F0ZSBmYWlsZWQiKTsKPiBBbHNvIGhlcmUuCldpbGwgdGFrZSBj
YXJlIG9mIHRoaXMgaW4gVjQKCj4gPiArCWlmIChzaWdzZXRqbXAoc2lnX2VzY2FwZSwgMSkgPT0g
MCkKPiA+ICsJCSpxOwo+ID4gKwllbHNlCj4gPiArCQlzaWdidXNfY291bnQrKzsKPiBBbmQgaGVy
ZS4KV2lsbCB0YWtlIGNhcmUgb2YgdGhpcyBpbiBWNAo+ID4gKwlpZiAoc2lnYnVzX2NvdW50ICE9
IDEpCj4gPiArCQl0c3RfcmVzKFRGQUlMLCAiRGlkbid0IFNJR0JVUyIpOwo+IEFuZCBoZXJlLgpX
aWxsIHRha2UgY2FyZSBvZiB0aGlzIGluIFY0Cj4gPiArCWlmICh0ZXN0X3Bhc3MgPT0gMSkKPiA+
ICsJCXRzdF9yZXMoVFBBU1MsICJFeHBlY3RlZCBTSUdCVVMgdHJpZ2dlcmVkIik7Cj4gQW5kIGhl
cmUuCldpbGwgdGFrZSBjYXJlIG9mIHRoaXMgaW4gVjQKPiA+ICsJU0FGRV9NVU5NQVAocCwgaHBh
Z2Vfc2l6ZSk7Cj4gPiArfQo+IAo+IEtpbmQgcmVnYXJkcywKPiBQZXRyCgoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
