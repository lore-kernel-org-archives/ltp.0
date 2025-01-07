Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F5D6E77197
	for <ltp@archiver.kernel.org>; Tue,  7 Jan 2025 18:29:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9FFA03C1774
	for <ltp@archiver.kernel.org>; Tue,  7 Jan 2025 19:29:57 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 42BF33C03E1
 for <ltp@lists.linux.it>; Tue,  7 Jan 2025 19:29:40 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 19D7510279B1
 for <ltp@lists.linux.it>; Tue,  7 Jan 2025 19:29:39 +0100 (CET)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507I4CXX005396;
 Tue, 7 Jan 2025 18:29:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=JbEa5N
 rKIkHLRPHhFYuxRdkxm6VZs+vNTKG7MSmh0uo=; b=ArO/GxfSzebwgN+T/enl8+
 xELSIR99no1ozkDFTdeEJHiHjZU/hbi0bff6Ho91raNvtyhS+l+0izMp4j7CS6L4
 sysuIzqxPTC1DyMyPVqw0AYhGrlCME5ky0XVLiU91b4YElKvVEnEnJyegf37Zljk
 e+tKyCRDFb+ZNGxHRfiWuhIUvS336o0pI7VyBvJnRJa37DJcOHQvsi3RXwyjSCOc
 VsUCWHLeDEdGW1zNu4/OXKkzFLrQ/e/3LXgzCvo7vh3wl9wxlqIrXY/PyLBYSaQC
 hd6zpLwolISfJDp7tQkt8oM3zVT0G+T9zreCsvH23QmiAZekK5IcDzsOKLCrwYyg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4410f3atfh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jan 2025 18:29:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 507G5L6s003614;
 Tue, 7 Jan 2025 18:29:37 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yfat42j4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jan 2025 18:29:37 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 507ITaqR29950582
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jan 2025 18:29:36 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3FBF55804E;
 Tue,  7 Jan 2025 18:29:36 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B39F25803F;
 Tue,  7 Jan 2025 18:29:35 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.61.138.2]) by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jan 2025 18:29:35 +0000 (GMT)
Message-ID: <baefcfa48e2e66e88b79b9db915d6c664d71c428.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 07 Jan 2025 13:29:35 -0500
In-Reply-To: <20250103190259.GA223253@pevik>
References: <20241213222014.1580991-1-pvorel@suse.cz>
 <20241213222014.1580991-7-pvorel@suse.cz>
 <35af7de88f6961817a9df23c55104d20c32d2680.camel@linux.ibm.com>
 <20241231122340.GE36475@pevik>
 <f0746bfae90306d45079f6f3e2f7a1d55e0ad79f.camel@linux.ibm.com>
 <20250103190259.GA223253@pevik>
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Pt7PLwZyzJzqUL0HWFxCBAxwLP7A5rKU
X-Proofpoint-ORIG-GUID: Pt7PLwZyzJzqUL0HWFxCBAxwLP7A5rKU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501070153
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 6/8] IMA: Add example policy for
 ima_violations.sh
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCAyMDI1LTAxLTAzIGF0IDIwOjAyICswMTAwLCBQZXRyIFZvcmVsIHdyb3RlOgo+ID4g
T24gVHVlLCAyMDI0LTEyLTMxIGF0IDEzOjIzICswMTAwLCBQZXRyIFZvcmVsIHdyb3RlOgo+ID4g
PiBIaSBNaW1pLAo+IAo+ID4gPiA+IEhpIFBldHIsCj4gCj4gPiA+ID4gT24gRnJpLCAyMDI0LTEy
LTEzIGF0IDIzOjIwICswMTAwLCBQZXRyIFZvcmVsIHdyb3RlOgo+ID4gPiA+ID4gU3VnZ2VzdGVk
LWJ5OiBNaW1pIFpvaGFyIDx6b2hhckBsaW51eC5pYm0uY29tPgo+ID4gPiA+ID4gU2lnbmVkLW9m
Zi1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4gPiA+ID4gPiAtLS0KPiA+ID4gPiA+
IMKgLi4uL2ludGVncml0eS9pbWEvZGF0YWZpbGVzL2ltYV92aW9sYXRpb25zL3Zpb2xhdGlvbnMu
cG9saWN5wqDCoMKgwqAgfCAxICsKPiA+ID4gPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspCj4gPiA+ID4gPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NAo+ID4gPiA+ID4gdGVzdGNhc2Vz
L2tlcm5lbC9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2RhdGFmaWxlcy9pbWFfdmlvbGF0aW9ucy92
aW9sYXRpb25zCj4gPiA+ID4gPiAucG9saWN5Cj4gCj4gPiA+ID4gPiBkaWZmIC0tZ2l0Cj4gPiA+
ID4gPiBhL3Rlc3RjYXNlcy9rZXJuZWwvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9kYXRhZmlsZXMv
aW1hX3Zpb2xhdGlvbnMvdmlvbGF0aW8KPiA+ID4gPiA+IG5zLnBvbGljeQo+ID4gPiA+ID4gYi90
ZXN0Y2FzZXMva2VybmVsL3NlY3VyaXR5L2ludGVncml0eS9pbWEvZGF0YWZpbGVzL2ltYV92aW9s
YXRpb25zL3Zpb2xhdGlvCj4gPiA+ID4gPiBucy5wb2xpY3kKPiA+ID4gPiA+IG5ldyBmaWxlIG1v
ZGUgMTAwNjQ0Cj4gPiA+ID4gPiBpbmRleCAwMDAwMDAwMDAwLi41NzM0Yzc2MTdmCj4gPiA+ID4g
PiAtLS0gL2Rldi9udWxsCj4gPiA+ID4gPiArKysKPiA+ID4gPiA+IGIvdGVzdGNhc2VzL2tlcm5l
bC9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2RhdGFmaWxlcy9pbWFfdmlvbGF0aW9ucy92aW9sYXRp
bwo+ID4gPiA+ID4gbnMucG9saWN5Cj4gPiA+ID4gPiBAQCAtMCwwICsxIEBACj4gPiA+ID4gPiAr
ZnVuYz1GSUxFX0NIRUNLCj4gCj4gPiA+ID4gIltQQVRDSCB2MiAxLzhdIElNQTogQWRkIFRDQiBw
b2xpY3kgYXMgYW4gZXhhbXBsZSBmb3IgaW1hX21lYXN1cmVtZW50cy5zaCIKPiA+ID4gPiBjb250
YWlucyB0d28gcnVsZXMgdG8gbWVhc3VyZSBmaWxlcyBvcGVuZWQgYnkgcm9vdCBvbiBmaWxlIG9w
ZW4uCj4gCj4gPiA+ID4gbWVhc3VyZSBmdW5jPUZJTEVfQ0hFQ0sgbWFzaz1eTUFZX1JFQUQgZXVp
ZD0wCj4gPiA+ID4gbWVhc3VyZSBmdW5jPUZJTEVfQ0hFQ0sgbWFzaz1eTUFZX1JFQUQgdWlkPTAK
PiAKPiA+ID4gPiBJZiB0aGUgJ3RjYicgb3IgZXF1aXZhbGVudCBwb2xpY3kgaXMgbG9hZGVkLCB0
aGVyZSBpcyBubyBuZWVkIHRvIGxvYWQgYW5vdGhlcgo+ID4gPiA+IHBvbGljeSBydWxlLiAKPiAK
PiA+ID4gSSBndWVzcyBJJ2xsIG1vdmUgY2hlY2sgZm9yIGJ1aWx0aW4gcG9saWN5IGxvYWRlZCB2
aWEga2VybmVsIGNvbW1hbmQgbGluZQo+ID4gPiBwYXJhbWV0ZXIgYWxzbyB0byBpbWFfc2V0dXAu
c2ggdG8gYXZvaWQgbG9hZGluZyBleGFtcGxlIHBvbGljeSB3aGVuIHRoZXJlIGlzIGEKPiA+ID4g
cmVxdWlyZWQgYnVpbHRpbiBwb2xpY3kgbG9hZGVkLgo+IAo+IAo+ID4gQmV0d2VlbiB0aGUgYnVp
bHRpbiBhbmQgYXJjaCBzcGVjaWZpYyBwb2xpY2llcywgbW9zdCBvZiB0aGUgcnVsZXMgYXJlIGFs
cmVhZHkKPiA+IGRlZmluZWQuwqAgVGhlIGV4Y2VwdGlvbiBpcyBtZWFzdXJpbmcgdGhlIGJvb3Qg
Y29tbWFuZCBsaW5lLsKgIFBlcmhhcHMgd2Ugc2hvdWxkCj4gPiB1cGRhdGUgdGhlIGFyY2ggc3Bl
Y2lmaWMgcG9saWN5IHRvIGluY2x1ZGUgaXQgd2l0aCB0aGUgb3RoZXIga2V4ZWMgcnVsZXMuCj4g
Cj4gPiBUaGUgYXJjaCBzcGVjaWZpYyBwb2xpY3kgbWF5IGluY2x1ZGUgdGhlIHJ1bGUgdGhhdCBy
ZXF1aXJlcyB0aGUgSU1BIHBvbGljeSB0byBiZQo+ID4gc2lnbmVkLgo+IAo+ID4gPiBJIGFsc28g
d29uZGVyIHdoYXQgaXMgYSBjb21tb24gYXBwcm9hY2ggLSBkb24ndAo+ID4gPiB0cnkgdG8gbG9h
ZCBjdXN0b20gZXhhbXBsZSBwb2xpY3kgd2hlbiB0aGVyZSBpcyBidWlsdGluIHBvbGljeSBsb2Fk
ZWQ/Cj4gCj4gPiBIb3cgYWJvdXQgZmlyc3QgY2hlY2tpbmcgaWYgdGhlIHJ1bGUgZXhpc3RzIHdo
ZW4gdGhlcmUgaXMgYSBidWlsdGluIG9yCj4gPiBlcXVpdmFsZW50IGN1c3RvbSBwb2xpY3kgbG9h
ZGVkLCBiZWZvcmUgbG9hZGluZyB0aGUgZXhhbXBsZSB0ZXN0IHBvbGljeT8KPiAKPiAKPiA+ID4g
TXkgZ29hbCB3YXMgdG8gYWxsb3cgbW9yZSBicm9hZCBJTUEgdGVzdGluZyBiYXNlZCBvbiBkaWZm
ZXJlbnQgc2V0dXA6Cj4gCj4gPiBWZXJ5IGdvb2QuCj4gCj4gPiA+ICogcnVubmluZyB0ZXN0cyB3
aXRoIGltYV9wb2xpY3k9dGNiIGJ1aWx0aW4gcG9saWN5IChjdXJyZW50IGFwcHJvYWNoKS4gTWFu
eQo+ID4gPiB0ZXN0cyB3aWxsIGJlIHNraXBwZWQgZHVlIG1pc3NpbmcgcmVxdWlyZWQgcG9saWN5
IGNvbnRlbnQuCj4gCj4gPiBPay7CoCBSZW1lbWJlciBldmVuIHdpdGggImltYV9wb2xpY3k9dGNi
IiBzcGVjaWZpZWQgb24gdGhlIGJvb3QgY29tbWFuZCBsaW5lLCB0aGUKPiA+IHJlc3VsdHMgd2ls
bCBkaWZmZXIgZGVwZW5kaW5nIG9uIHdoZXRoZXIgdGhlIGFyY2ggc3BlY2lmaWMgcG9saWN5IGlz
IGxvYWRlZC4KPiAKPiA+ID4gKiBydW5uaW5nIHRlc3RzIHdpdGhvdXQgYW55IGJ1aWx0aW4gcG9s
aWN5ICsgbG9hZCBhIGN1c3RvbSBwb2xpY3kgKyByZWJvb3QgdmlhCj4gPiA+IExUUF9JTUFfTE9B
RF9QT0xJQ1k9MSAodGhpcyBwYXRjaHNldCksIGJ1dCB0aGlzIHNob3VsZCBiZSBwcm9iYWJseSBi
ZSBkb25lIG9ubHkKPiA+ID4gaWYgcmVxdWlyZWQgKG9yIGV2ZW4gbm9uZSkgYnVpbHRpbiBwb2xp
Y3kgaXMgbG9hZGVkLgo+IAo+ID4gR29vZC7CoCBUaGUgZmlyc3QgcGF0Y2ggaW50cm9kdWNlcyB0
aGUgZXF1aXZhbGVudCBjdXN0b20gcG9saWN5IHRvCj4gPiAiaW1hX3BvbGljeT10Y2IiLsKgIEJ5
ICJsb2FkIGEgY3VzdG9tIHBvbGljeSIgYXJlIHlvdSByZWZlcnJpbmcgdG8gdGhpcyBwb2xpY3kg
b3IKPiA+IGEgc3BlY2lmaWMgcG9saWN5IHRlc3QgcnVsZT8KPiAKPiBJIHJlZmVyIHRvIHRoaXMg
cG9saWN5LiBNYXliZSBiZXR0ZXIgd291bGQgYmUgInBvbGljeSBjb250ZW50IHJlcXVpcmVkIGJ5
IHRoZSB0ZXN0Igo+IG9yICJ0ZXN0IGV4YW1wbGUgcG9saWN5Ii4KPiAKPiBNeSBwb2ludCBpcyB0
byBhbGxvdyB0ZXN0aW5nIHdpdGhvdXQgZm9yY2luZyBpbWFfcG9saWN5PXRjYiBzZXR1cCAoc29t
ZSB0b29saW5nCj4gbWlnaHQgbm90IGFsbG93IGVhc2lseSB0byBhZGQga2VybmVsIGNtZGxpbmUg
cGFyYW1ldGVycykuIEFsc28sIG1peGluZyB0ZXN0Cj4gZXhhbXBsZSBwb2xpY3kgd2l0aCBpbWFf
cG9saWN5PXRjYiBtYXkgcmVzdWx0IGEgZGlmZmVyZW50IG1lYXN1cmVtZW50cywgcmlnaHQ/CgpP
bmx5IGlmIHRoZSBmaWxlIG1hdGNoZXMgbXVsdGlwbGUsIGRpZmZlcmVudCBtZWFzdXJlbWVudCBy
dWxlcy4gIFRoZSBvcmRlcmluZyBvZiB0aGUKcG9saWN5IHJ1bGVzIGltcGFjdHMgdGhlIG1lYXN1
cmVtZW50IGFuZCBtaWdodCBldmVuIHByZXZlbnQgdGhlIG1lYXN1cmVtZW50LgoKPiAKPiBJZiB0
aGUgYWJvdmUgYXNzdW1wdGlvbiBpcyBjb3JyZWN0IEkgd291bGQgbGlrZSB0byBoYXZlIHRlc3Rp
bmcgKndpdGgqCj4gaW1hX3BvbGljeT10Y2Igd2l0aG91dCBsb2FkaW5nIGFueSB0ZXN0IGV4YW1w
bGUgcG9saWN5CgpJIGFzc3VtZSB0aGUgcHVycG9zZSBpcyB0byBzaW1wbGlmeSB0ZXN0aW5nLgoK
SG93ZXZlciwKLSBOb3QgYWxsIG9mIHRoZSBwb2xpY3kgcnVsZXMgbmVlZGVkIGJ5IHRoZSB0ZXN0
cyBhcmUgaW5jbHVkZWQgaW4gdGhlIGJ1aWx0aW4gInRjYiIKbWVhc3VyZW1lbnQgcG9saWN5LiAg
V2l0aG91dCBsb2FkaW5nIHRlc3Qgc3BlY2lmaWMgZXhhbXBsZSBwb2xpY3kgcnVsZXMsIHRoZSB0
ZXN0aW5nCndvdWxkIGJlIGluY29tcGxldGUuCgotIFRoZXJlJ3Mgbm8gZ3VhcmFudGVlIHRoYXQg
dGhlIGJ1aWx0aW4gInRjYiIgbWVhc3VyZW1lbnQgcG9saWN5IGhhcyBub3QgYmVlbgpyZXBsYWNl
ZCB3aXRoIGEgY3VzdG9tIHBvbGljeS4KCj4gYW5kICp3aXRob3V0Kgo+IGltYV9wb2xpY3k9dGNi
IGJ1dCBsb2FkaW5nIHRlc3QgZXhhbXBsZSBwb2xpY3kgdmlhIExUUF9JTUFfTE9BRF9QT0xJQ1k9
MS4KCk9rLCBidXQgdGhpcyBhc3N1bWVzIHRoZSBhYmlsaXR5IG9mIGxvYWRpbmcgYW4gdW5zaWdu
ZWQgcG9saWN5LgoKPiAKPiA+ID4gKiBJZGVhbGx5IG5vdCByZXF1aXJlIENPTkZJR19JTUFfUkVB
RF9QT0xJQ1k9eSBhcyBzb21lIGRpc3Ryb3MgZG9lcyBub3QgaGF2ZSBpdAo+ID4gPiAoYnV0IHRo
ZW4gaXQgaXMgaGFyZCB0byBkZXRlY3Qgd2hldGhlciBmYWlsdXJlcyBhcmUgcmVhbCBidWdzIG9y
IGp1c3QgZmFsc2UKPiA+ID4gcG9zaXRpdmVzIGR1ZSBub3QgaGF2aW5nIGEgcHJvcGVyIHBvbGlj
eSkuIE1heWJlIGNvbnZlcnQgVEJST0svVEZBSUwgdG8gVENPTkYKPiA+ID4gaWYKPiAKPiBJJ20g
c29ycnksIEkgd2FzIHdyb25nIGhlcmUsIEkgbWVhbnQgdG8gYXNrOiBjb252ZXJ0IFRGQUlMIHRv
IGVpdGhlciBUQlJPSyBvcgo+IFRDT05GLAo+IGUuZy4gbXkgcGF0Y2ggWzFdLgo+IAo+ID4gPiBw
b2xpY3kgY29udGVudCBpcyByZXF1aXJlZCBidXQgY2Fubm90IGJlIHJlYWQgZHVlIENPTkZJR19J
TUFfUkVBRF9QT0xJQ1kgKGFuZAo+ID4gPiBjdXN0b20gcG9saWN5IHdpdGggcHJvcGVyIGNvbnRl
bnQgd2FzIG5vdCBsb2FkZWQpLgo+IAo+ID4gUHJvYmFibHkgdGhlIGxhdHRlciBvcHRpb24gb2Yg
Y29udmVydGluZyBmcm9tIFRCUk9LL1RGQUlMIHRvIFRDT05GIGlzCj4gPiBwcmVmZXJhYmxlLsKg
IFdoeSBmYWlsIGEgdGVzdCB3aXRob3V0IGtub3dpbmcgaXQgd2lsbCBmYWlsLgo+IAo+IEJlY2F1
c2Ugb24gZGlzdHJvcyB3aXRob3V0IENPTkZJR19JTUFfUkVBRF9QT0xJQ1k9eSB3ZSBuZXZlciBn
ZXQgbm90aWZpZWQgYWJvdXQKPiB0aGUgZmFpbHVyZSAobWF5YmUga2VybmVsIGlzIGJyb2tlbiB3
aGVuIGl0IGZhaWxzIGJ1dCBub2JvZHkgbm90aWNlcyBUQ09ORikuCj4gQnV0IGFsdGhvdWdoIHRo
ZXJlIGlzIGEgc2xpZ2h0IGRpZmZlcmVuY2UgYmV0d2VlbiBURkFJTCBhbmQgVEJST0sgWzJdLCBJ
IGFncmVlCj4gdGhhdCBUQ09ORiBpcyBwcm9iYWJseSB0aGUgYmVzdCAobm9ib2R5IHdhbnRzIHRv
IGRlYWwgd2l0aCBmYWxzZSBwb3NpdGl2ZXMpLAo+IHdoaWNoIGlzIGhhbmRsZWQgaW4gbXkgcGF0
Y2ggWzFdLgo+IAo+IEJ1dCBpbnN0ZWFkIG9mIHRoaXMgSSdsbCB0cnkgZm9yIGFsbCB0ZXN0cyB3
aGljaCByZXF1aXJlIHRvIGhhdmUgY2VydGFpbiBwb2xpY3kKPiBjb250ZW50IChjdXJyZW50bHkg
YWxsIGJ1dCBpbWFfY29uZGl0aW9uYWxzLnNoKTogaWYgTFRQX0lNQV9MT0FEX1BPTElDWT0xIHNl
dAo+IHRyeSB0byBsb2FkIGV4YW1wbGUgcG9saWN5IGV2ZW4gcG9saWN5IGNvbnRlbnQgY2Fubm90
IGJlIGNoZWNrZWQgKFRDT05GIHdoZW4KPiBwb2xpY3kgZmFpbHMgdG8gYmUgbG9hZGVkIG9yIGlm
IExUUF9JTUFfTE9BRF9QT0xJQ1kgbm90IHNldCkuCgpTb3VuZHMgZ29vZC4KCk1pbWkKCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
