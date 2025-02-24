Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1CAC021A4
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 18:49:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 69C713C99FD
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 19:49:12 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F31BC3C9911
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 19:48:54 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C018D1000C21
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 19:48:53 +0100 (CET)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OCQDHT020365;
 Mon, 24 Feb 2025 18:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Yojfkl
 zttvkO+bI+UNhP7iJoOSgbvukoX/a57WEYxkk=; b=c3OHhQxJNeIBypNcL09r9Z
 Ap59tVimliwp+tifC8esZO98OIoWW72zRyfe9wTfS+9/BEUvOKWGqoETPsf1JQyW
 SMqkitP8KqNCjYAZNSno8/xOp6IpAdvBFfF38A8HJLBhI5O+NCMBIaUb/HPjwfbq
 RHwddA+JloQH4aDaF95LsxV8TO261KVJ5X2nSFLj3EZ0m18l5qbWYZKtuud3Cy0C
 qBlSjEknzCITY8w+dp0UopnsPItYbzfBYw+fqgMANeF3ci9VhsIWeFbvSni1Fil8
 18+We3EZcl7WnosiXyL5XAb11VLoOKAB41CqVh1i4NCO8v2pB+ibec3UHiodiAqA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 450cta4u4n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Feb 2025 18:48:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51OGdGcX026990;
 Mon, 24 Feb 2025 18:48:49 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ytdk8ke0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Feb 2025 18:48:49 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51OImmNi22479158
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2025 18:48:49 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D3F7858059;
 Mon, 24 Feb 2025 18:48:48 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 813A458061;
 Mon, 24 Feb 2025 18:48:48 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.61.5.153]) by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Feb 2025 18:48:48 +0000 (GMT)
Message-ID: <26a46dd0c56d95108c575937c15fa35d48f67577.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 24 Feb 2025 13:48:48 -0500
In-Reply-To: <20250221081623.GA2739743@pevik>
References: <20250220160054.12149-1-zohar@linux.ibm.com>
 <20250220160054.12149-3-zohar@linux.ibm.com>
 <20250220181604.GA2709977@pevik>
 <fd10e47b4c8b6af0e8d37975cdf1e82133add8c3.camel@linux.ibm.com>
 <20250220191342.GA2716312@pevik>
 <c625586b0dbc4302dfb7adf4acb0c891b74cf8bc.camel@linux.ibm.com>
 <2637152a2715b8e84e966b12bc9c9cb1c27592c2.camel@linux.ibm.com>
 <20250220214333.GA2726725@pevik>
 <cd07d8052fbfa0cde426b4b07fde0c70e6aa046f.camel@linux.ibm.com>
 <20250221081623.GA2739743@pevik>
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: y4BuzdeDU8x7SE1siHUCGmJAp_FrpMT0
X-Proofpoint-ORIG-GUID: y4BuzdeDU8x7SE1siHUCGmJAp_FrpMT0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_09,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=887
 lowpriorityscore=0 mlxscore=0 impostorscore=0 suspectscore=0 adultscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502240121
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 3/3] ima: additional ToMToU violation tests
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it,
 Stefan Berger <stefanb@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCAyMDI1LTAyLTIxIGF0IDA5OjE2ICswMTAwLCBQZXRyIFZvcmVsIHdyb3RlOgo+ID4g
T24gVGh1LCAyMDI1LTAyLTIwIGF0IDIyOjQzICswMTAwLCBQZXRyIFZvcmVsIHdyb3RlOgo+ID4g
PiA+IE9uIFRodSwgMjAyNS0wMi0yMCBhdCAxNToyMiAtMDUwMCwgTWltaSBab2hhciB3cm90ZToK
PiA+ID4gPiA+IE9uIFRodSwgMjAyNS0wMi0yMCBhdCAyMDoxMyArMDEwMCwgUGV0ciBWb3JlbCB3
cm90ZToKPiA+ID4gPiA+ID4gPiBPbiBUaHUsIDIwMjUtMDItMjAgYXQgMTk6MTYgKzAxMDAsIFBl
dHIgVm9yZWwgd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiBIaSBNaW1pLAo+IAo+ID4gPiA+ID4gPiA+
ID4gPiBLZXJuZWwgcGF0Y2ggImltYTogbGltaXQgdGhlIG51bWJlciBvZiBUb01Ub1UgaW50ZWdy
aXR5Cj4gPiA+ID4gPiA+ID4gPiA+IHZpb2xhdGlvbnMiCj4gPiA+ID4gPiA+ID4gPiA+IHByZXZl
bnRzIHN1cGVyZmx1b3VzIFRvTVRvVSB2aW9sYXRpb25zLsKgIEFkZCBjb3JyZXNwb25kaW5nIExU
UAo+ID4gPiA+ID4gPiA+ID4gPiB0ZXN0cy4KPiAKPiA+ID4gPiA+ID4gPiA+ID4gTGluazoKPiA+
ID4gPiA+ID4gPiA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaW50ZWdyaXR5LzIw
MjUwMjE5MTYyMTMxLjQxNjcxOS0zLXpvaGFyQGxpbnV4LmlibS5jb20vCj4gPiA+ID4gPiA+ID4g
PiA+IFNpZ25lZC1vZmYtYnk6IE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4LmlibS5jb20+Cj4gCj4g
PiA+ID4gPiA+ID4gPiBVbmZvcnR1bmF0ZWx5IHRlc3RzIGZhaWwgb24gYm90aCBtYWlubGluZSBr
ZXJuZWwgYW5kIGtlcm5lbCB3aXRoCj4gPiA+ID4gPiA+ID4gPiB5b3VyIHBhdGNoZXMuCj4gCj4g
PiA+ID4gPiA+ID4gVGhlIG5ldyBMVFAgSU1BIHZpb2xhdGlvbnMgcGF0Y2hlcyBzaG91bGQgZmFp
bCB3aXRob3V0IHRoZQo+ID4gPiA+ID4gPiA+IGFzc29jaWF0ZWQga2VybmVsCj4gPiA+ID4gPiA+
ID4gcGF0Y2hlcy4KPiAKPiA+ID4gPiA+ID4gPiA+IEFueSBoaW50IHdoYXQgY291bGQgYmUgd3Jv
bmc/Cj4gCj4gPiA+ID4gPiA+ID4gT2YgY291cnNlIGl0J3MgZGVwZW5kZW50IG9uIHRoZSBJTUEg
cG9saWN5LsKgIFRoZSB0ZXN0cyBhc3N1bWUKPiA+ID4gPiA+ID4gPiBiZWluZyBib290ZWQgd2l0
aAo+ID4gPiA+ID4gPiA+IHRoZQo+ID4gPiA+ID4gPiA+IElNQQo+ID4gPiA+ID4gPiA+IFRDQiBt
ZWFzdXJlbWVudCBwb2xpY3kgb3Igc2ltaWxhciBwb2xpY3kgYmVpbmcgbG9hZGVkLsKgIENhbiB5
b3UKPiA+ID4gPiA+ID4gPiBzaGFyZSB0aGUgSU1BCj4gPiA+ID4gPiA+ID4gcG9saWN5Pwo+ID4g
PiA+ID4gPiA+IGUuZy4gY2F0IC9zeXMva2VybmVsL3NlY3VyaXR5L2ltYS9wb2xpY3kKPiAKPiA+
ID4gPiA+ID4gPiB0aGFua3MsCj4gCj4gPiA+ID4gPiA+ID4gTWltaQo+IAo+ID4gPiA+ID4gPiBO
b3cgdGVzdGluZyBvbiBrZXJuZWwgKndpdGgqIHlvdXIgcGF0Y2hlcy4gRmlyc3QgcnVuIGFsd2F5
cyBmYWlscywKPiA+ID4gPiA+ID4gcmVnYXJkbGVzcwo+ID4gPiA+ID4gPiB3aGV0aGVyIHVzaW5n
IGltYV9wb2xpY3k9dGNiIG9yCj4gPiA+ID4gPiA+IC9vcHQvbHRwL3Rlc3RjYXNlcy9kYXRhL2lt
YV92aW9sYXRpb25zL3Zpb2xhdGlvbnMucG9saWN5KS4KPiAKPiA+ID4gPiA+ID4gS2luZCByZWdh
cmRzLAo+ID4gPiA+ID4gPiBQZXRyCj4gCj4gPiA+ID4gPiBJJ20gbm90IHNlZWluZyB0aGF0IG9u
IG15IHRlc3QgbWFjaGluZS7CoCBDb3VsZCB0aGVyZSBiZSBvdGhlciB0aGluZ3MKPiA+ID4gPiA+
IHJ1bm5pbmcgb24geW91cgo+ID4gPiA+ID4gc3lzdGVtIGNhdXNpbmcgdmlvbGF0aW9ucy7CoCBJ
biBhbnljYXNlLCB5b3VyIG9yaWdpbmFsIHRlc3Qgd2FzIGxlc3MKPiA+ID4gPiA+IGV4YWN0aW5n
LsKgwqAKPiA+ID4gPiA+IFNpbWlsYXJseSwKPiA+ID4gPiA+IGluc3RlYWQgb2YgIi1lcSIsIHRy
eSB1c2luZyAiLXFlIiBpbiB0aGUgZm9sbG93aW5nIHRlc3QgYW5kIHJlbW92aW5nCj4gPiA+ID4g
PiB0aGUgc3Vic2VxdWVudAo+ID4gPiA+ID4gbmV3Cj4gPiA+ID4gPiAiZ3QiIHRlc3QuCj4gCj4g
PiA+ID4gLT4gIi1nZSIKPiAKPiA+ID4gU3VyZSwgY2hhbmdpbmcgdG8gLWdlIGZpeGVzIHRoZSBw
cm9ibGVtOgo+ID4gPiBpZiBbICQoKCRudW1fdmlvbGF0aW9uc19uZXcgLSAkbnVtX3Zpb2xhdGlv
bnMpKSAtZ2UgJGV4cGVjdGVkX3Zpb2xhdGlvbnMKPiA+ID4gXTsgdGhlbgo+IAo+ID4gPiBJIGd1
ZXNzIHdlIG5lZWQgIi1nZSIgZm9yIG9sZGVyIGtlcm5lbHMgKHVubGVzcyAiZml4IiBmb3Igc3Rh
YmxlKS7CoCBTaG91bGQKPiA+ID4gd2UKPiA+ID4gYWNjZXB0ICIkZXhwZWN0ZWRfdmlvbGF0aW9u
cyB8fCAkZXhwZWN0ZWRfdmlvbGF0aW9ucyArIDEiIGZvciBuZXcga2VybmVscwo+ID4gPiB0bwo+
ID4gPiBhdm9pZCBwcm9ibGVtcyBsaWtlIHRoZSBvbmUgb24gbXkgc3lzdGVtLgo+IAo+ID4gVGhl
IHByb2JsZW0gaXMgdGhhdCB3ZSBkb24ndCBjb250cm9sIHdoYXQgZWxzZSBpcyBydW5uaW5nIG9u
IHRoZSBzeXN0ZW0uwqAgU28KPiA+IHRoZXJlIGNvdWxkCj4gPiBiZSBvdGhlciB2aW9sYXRpb25z
IGluZGVwZW5kZW50IG9mIHRoZXNlIHRlc3RzLsKgIEknbGwgaGF2ZSB0byB0aGluayBhYm91dCBp
dAo+ID4gc29tZSBtb3JlIGFuZAo+ID4gZ2V0IGJhY2sgdG8geW91LsKgIChUaGVyZSdzIG5vIHJ1
c2ggdG8gZG8gYW55dGhpbmcgd2l0aCB0aGVzZSBMVFAgSU1BCj4gPiB2aW9sYXRpb24gdGVzdHMu
KQo+IAo+IE9LLCB0aGFuayB5b3UuIFRoZSB3b3JzZSBzY2VuYXJpbyB3b3VsZCBiZSB0byB1c2Ug
bGVzcyBwcmVjaXNlIHZhcmlhbnQgIi1nZSIuCj4gCj4gPiA+IEkgd29uZGVyIGlmIHRoZSBwcm9i
bGVtIHdhcyBzb21laG93IGNhdXNlZCBieSB0aGUgZmFjdCB0aGF0IEkgYnVpbHQKPiA+ID4ga2Vy
bmVsLiBPVE9ICj4gPiA+IGl0J3MgYnVpbGQgYnkgT0JTIChvZmZpY2lhbCBvcGVuU1VTRSBidWls
ZCBzZXJ2aWNlKS4KPiAKPiA+IEFzIGxvbmcgYXMgeW91IHdlcmVuJ3QgYnVpbGRpbmcgdGhlIGtl
cm5lbCBhbmQgcnVubmluZyB0aGUgdGVzdHMgYXQgdGhlCj4gPiBzYW1lLCBJIGRvdWJ0IGl0Cj4g
PiB3b3VsZCBiZSB0aGUgcHJvYmxlbS4KPiAKPiBVbmRlcnN0YW5kLCBqdXN0IHNvbWV0aGluZyBv
biBvcGVuU1VTRSBUdW1ibGV3ZWVkIHN5c3RlbS4KClBldGVyLCB0aGFuayB5b3UgZm9yIHRoZSB0
dW1ibGV3ZWVkIGltYWdlLgoKVGhlIGRlZmF1bHQgSU1BIHRjYiBwb2xpY3kgcmVzdWx0cyBpcyBt
ZWFzdXJpbmcgJExPRyAoL3Zhci9sb2cvYXVkaXQvYXVkaXQubG9nKQpvbiB0aGUgZmlyc3QgY2Fs
bCB0byB2YWxpZGF0ZSgpLiAgVG8gcHJldmVudCB0aGF0IGZyb20gaW50ZXJmZXJpbmcgd2l0aCB0
ZXN0MSwgSQp3b3VsZCBhZGQgdGhlIGZvbGxvd2luZyBsaW5lIG9yIHNvbWV0aGluZyBzaW1pbGFy
IGluIHNldHVwKCkgdG8gZm9yY2UgbWVhc3VyaW5nCiRMT0cgdG8gaGFwcGVuIGVhcmxpZXIuCgpl
eGVjIDM8ICRMT0cgfHwgZXhpdCAxCgpBc3N1bWluZyB0aGF0IHdvcmtzLCBJJ2xsIHVwZGF0ZSB0
aGUga2VybmVsIGFuZCBMVFAgdGVzdHMuCgp0aGFua3MsCgpNaW1pCgoKCgoKCgoKCgoKCgoKCi0t
IApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
