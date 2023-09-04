Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84968C71153
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 07:03:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CBF653CB8B8
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 09:03:28 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C46EF3CB856
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 09:03:17 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E51FB1A010EE
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 09:03:16 +0200 (CEST)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38468Rln014363 for <ltp@lists.linux.it>; Mon, 4 Sep 2023 07:03:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : references : cc : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=kKKIkL4qXx2p1dm+Ejc0Vmvisy3K/MjKAp8u9cB1YTE=;
 b=KQQOt2VOn+FjmgfWdBiEaZ4EjgFhi40v2BLeDsa1yZ7Qqi8NT+f9NCjE4Eyqb0Fb2/wb
 fHsnr3YcxZCKQZBk6l7ue7jU0k/I2jZrTO4Cn0sRc+CBj+BOqJlJXoqSCd5sYrmvQZ5L
 wbm9T5BJNhexGS7TSEVshYU0PdWnD1RhBMJP09Wdfv1tveyRz1BmtsDt45jIzluGXpZk
 DNHZ0ttBuZEpxK5nurI3cBSn72tHOnL9by3vClaxxuP7zp8DrYFgqwmwcnej2eKQBwJg
 YVSECo91FnTdm5xTpL/D1gwWZYTIMGzbFLoKcO3OWuN4W/DlclMdsRsC0oUg3uHx5gWo lw== 
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sw830txrb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 04 Sep 2023 07:03:14 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3845cw2s006611 for <ltp@lists.linux.it>; Mon, 4 Sep 2023 07:03:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svgvk0be1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 04 Sep 2023 07:03:13 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38473AgV62194092
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 4 Sep 2023 07:03:10 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E8B9820040;
 Mon,  4 Sep 2023 07:03:09 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E80120043;
 Mon,  4 Sep 2023 07:03:09 +0000 (GMT)
Received: from [9.43.20.181] (unknown [9.43.20.181])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon,  4 Sep 2023 07:03:09 +0000 (GMT)
Message-ID: <f8e0331f-a4b1-115c-f4b0-680f73dc4f22@linux.ibm.com>
Date: Mon, 4 Sep 2023 12:33:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
To: ltp@lists.linux.it
References: <20230904065643.32590-1-rnsastry@linux.ibm.com>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20230904065643.32590-1-rnsastry@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2h0XzCOVKQ0cPGiVxiIxmgaISxYIRiV8
X-Proofpoint-ORIG-GUID: 2h0XzCOVKQ0cPGiVxiIxmgaISxYIRiV8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_04,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 adultscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309040063
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib/tst_lockdown.c: Add PPC64 architecture support
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
Cc: rnsastry@linux.ibm.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

CgpPbiAwNC8wOS8yMyAxMjoyNiBwbSwgTmFnZXN3YXJhIFIgU2FzdHJ5IHdyb3RlOgo+IEFkZCBQ
UEM2NCBhcmNoaXRlY3R1cmUgc3VwcG9ydCB0byB0aGUgbG9ja2Rvd24gbGlicmFyeS4KPiAKPiBT
aWduZWQtb2ZmLWJ5OiBOYWdlc3dhcmEgUiBTYXN0cnkgPHJuc2FzdHJ5QGxpbnV4LmlibS5jb20+
CgpUZXN0ZWQgd2l0aCBhbmQgd2l0aCBvdXQgU2VjdXJlIGJvb3QgZW5hYmxlZCBvbiBQUEM2NExF
IHN5c3RlbS4KClJhbiB0ZXN0Y2FzZXMgbmFtZWQ6CmZpbml0X21vZHVsZTAxIGZpbml0X21vZHVs
ZTAxCmZpbml0X21vZHVsZTAyIGZpbml0X21vZHVsZTAyCgpXaXRoIHNlY3VyZSBib290IGRpc2Fi
bGVkOgouLi4KdHN0X2xvY2tkb3duLmM6OTA6IFRJTkZPOiBLZXJuZWwgbG9ja2Rvd246IG9mZgp0
c3RfbG9ja2Rvd24uYzo1MTogVElORk86IFNlY3VyZUJvb3Q6IG9mZgrigKYKU3VtbWFyeToKcGFz
c2VkICAgMTAKZmFpbGVkICAgMApicm9rZW4gICAwCnNraXBwZWQgIDAKd2FybmluZ3MgMAoKCldp
dGggc2VjdXJlIGJvb3QgZW5hYmxlZDoKLi4uCnRzdF9sb2NrZG93bi5jOjkwOiBUSU5GTzogS2Vy
bmVsIGxvY2tkb3duOiBvbgp0c3RfbG9ja2Rvd24uYzo1MTogVElORk86IFNlY3VyZUJvb3Q6IG9u
CuKApgpTdW1tYXJ5OgpwYXNzZWQgICA3CmZhaWxlZCAgIDAKYnJva2VuICAgMApza2lwcGVkICAz
Cndhcm5pbmdzIDAKCgo+IC0tLQo+ICAgbGliL3RzdF9sb2NrZG93bi5jIHwgMzQgKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDI3IGluc2VydGlv
bnMoKyksIDcgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2xpYi90c3RfbG9ja2Rvd24u
YyBiL2xpYi90c3RfbG9ja2Rvd24uYwo+IGluZGV4IDkwODZlYmEzNi4uNmZhZGFkODA4IDEwMDY0
NAo+IC0tLSBhL2xpYi90c3RfbG9ja2Rvd24uYwo+ICsrKyBiL2xpYi90c3RfbG9ja2Rvd24uYwo+
IEBAIC0xNCwzMyArMTQsNDYgQEAKPiAgICNpbmNsdWRlICJ0c3RfbG9ja2Rvd24uaCIKPiAgICNp
bmNsdWRlICJ0c3RfcHJpdmF0ZS5oIgo+ICAgCj4gLSNkZWZpbmUgRUZJVkFSX1NFQ1VSRUJPT1Qg
Ii9zeXMvZmlybXdhcmUvZWZpL2VmaXZhcnMvU2VjdXJlQm9vdC04YmU0ZGY2MS05M2NhLTExZDIt
YWEwZC0wMGUwOTgwMzJiOGMiCj4gLQo+ICsjaWYgZGVmaW5lZChfX3Bvd2VycGM2NF9fKSB8fCBk
ZWZpbmVkKF9fcHBjNjRfXykKPiArI2RlZmluZSBTRUNVUkVCT09UX1ZBUiAiL3Byb2MvZGV2aWNl
LXRyZWUvaWJtLHNlY3VyZS1ib290Igo+ICsjZWxzZQo+ICsjZGVmaW5lIFNFQ1VSRUJPT1RfVkFS
ICIvc3lzL2Zpcm13YXJlL2VmaS9lZml2YXJzL1NlY3VyZUJvb3QtOGJlNGRmNjEtOTNjYS0xMWQy
LWFhMGQtMDBlMDk4MDMyYjhjIgo+ICsjZW5kaWYKPiAgIGludCB0c3Rfc2VjdXJlYm9vdF9lbmFi
bGVkKHZvaWQpCj4gICB7Cj4gICAJaW50IGZkOwo+ICAgCWNoYXIgZGF0YVs1XTsKPiAgIAo+IC0J
aWYgKGFjY2VzcyhFRklWQVJfU0VDVVJFQk9PVCwgRl9PSykpIHsKPiAtCQl0c3RfcmVzKFRJTkZP
LCAiRWZpdmFyIEZTIG5vdCBhdmFpbGFibGUiKTsKPiArCWlmIChhY2Nlc3MoU0VDVVJFQk9PVF9W
QVIsIEZfT0spKSB7Cj4gKwkJdHN0X3JlcyhUSU5GTywgIlNlY3VyZUJvb3Qgc3lzZnMgZmlsZSBu
b3QgYXZhaWxhYmxlIik7Cj4gICAJCXJldHVybiAtMTsKPiAgIAl9Cj4gICAKPiAtCWZkID0gb3Bl
bihFRklWQVJfU0VDVVJFQk9PVCwgT19SRE9OTFkpOwo+ICsJZmQgPSBvcGVuKFNFQ1VSRUJPT1Rf
VkFSLCBPX1JET05MWSk7Cj4gICAKPiAgIAlpZiAoZmQgPT0gLTEpIHsKPiAgIAkJdHN0X3JlcyhU
SU5GTyB8IFRFUlJOTywKPiAtCQkJIkNhbm5vdCBvcGVuIFNlY3VyZUJvb3QgRWZpdmFyIHN5c2Zp
bGUiKTsKPiArCQkJIkNhbm5vdCBvcGVuIFNlY3VyZUJvb3QgZmlsZSIpOwo+ICAgCQlyZXR1cm4g
LTE7Cj4gICAJfSBlbHNlIGlmIChmZCA8IDApIHsKPiAgIAkJdHN0X2JyayhUQlJPSyB8IFRFUlJO
TywgIkludmFsaWQgb3BlbigpIHJldHVybiB2YWx1ZSAlZCIsIGZkKTsKPiAgIAkJcmV0dXJuIC0x
Owo+ICAgCX0KPiAtCj4gKwkjaWYgZGVmaW5lZChfX3Bvd2VycGM2NF9fKSB8fCBkZWZpbmVkKF9f
cHBjNjRfXykKPiArCVNBRkVfUkVBRCgxLCBmZCwgZGF0YSwgNCk7Cj4gKwkjZWxzZQo+ICAgCVNB
RkVfUkVBRCgxLCBmZCwgZGF0YSwgNSk7Cj4gKwkjZW5kaWYKPiArCj4gICAJU0FGRV9DTE9TRShm
ZCk7Cj4gKwo+ICsJI2lmIGRlZmluZWQoX19wb3dlcnBjNjRfXykgfHwgZGVmaW5lZChfX3BwYzY0
X18pCj4gKwl0c3RfcmVzKFRJTkZPLCAiU2VjdXJlQm9vdDogJXMiLCBkYXRhWzNdID8gIm9uIiA6
ICJvZmYiKTsKPiArCXJldHVybiBkYXRhWzNdOwo+ICsJI2Vsc2UKPiAgIAl0c3RfcmVzKFRJTkZP
LCAiU2VjdXJlQm9vdDogJXMiLCBkYXRhWzRdID8gIm9uIiA6ICJvZmYiKTsKPiAgIAlyZXR1cm4g
ZGF0YVs0XTsKPiArCSNlbmRpZgo+ICAgfQo+ICAgCj4gICBpbnQgdHN0X2xvY2tkb3duX2VuYWJs
ZWQodm9pZCkKPiBAQCAtNTEsOSArNjQsMTYgQEAgaW50IHRzdF9sb2NrZG93bl9lbmFibGVkKHZv
aWQpCj4gICAKPiAgIAlpZiAoYWNjZXNzKFBBVEhfTE9DS0RPV04sIEZfT0spICE9IDApIHsKPiAg
IAkJY2hhciBmbGFnOwo+ICsKPiAgIAkJLyogU2VjdXJlQm9vdCBlbmFibGVkIGNvdWxkIG1lYW4g
aW50ZWdyaXR5IGxvY2tkb3duIChub24tbWFpbmxpbmUgdmVyc2lvbikgKi8KPiArCQkjaWYgZGVm
aW5lZChfX3Bvd2VycGM2NF9fKSB8fCBkZWZpbmVkKF9fcHBjNjRfXykKPiArCQlmbGFnID0gdHN0
X2tjb25maWdfZ2V0KCJDT05GSUdfU0VDVVJJVFlfTE9DS0RPV05fTFNNIikgPT0gJ3knOwo+ICsJ
CWZsYWcgfD0gdHN0X2tjb25maWdfZ2V0KCJDT05GSUdfU0VDVVJJVFlfTE9DS0RPV05fTFNNX0VB
UkxZIikgPT0gJ3knOwo+ICsJCSNlbHNlCj4gICAJCWZsYWcgPSB0c3Rfa2NvbmZpZ19nZXQoIkNP
TkZJR19FRklfU0VDVVJFX0JPT1RfTE9DS19ET1dOIikgPT0gJ3knOwo+ICAgCQlmbGFnIHw9IHRz
dF9rY29uZmlnX2dldCgiQ09ORklHX0xPQ0tfRE9XTl9JTl9FRklfU0VDVVJFX0JPT1QiKSA9PSAn
eSc7Cj4gKwkJI2VuZGlmCj4gKwo+ICAgCQlpZiAoZmxhZyAmJiB0c3Rfc2VjdXJlYm9vdF9lbmFi
bGVkKCkgPiAwKQo+ICAgCQkJcmV0dXJuIDE7Cj4gICAKCi0tIApUaGFua3MgYW5kIFJlZ2FyZHMK
Ui5OYWdlc3dhcmEgU2FzdHJ5CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
