Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7B6C021B2
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 02:07:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01B143C80BC
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 03:07:47 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB56B3C0549
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 03:07:29 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C3D8B1400F97
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 03:07:28 +0100 (CET)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KH1d34007117;
 Fri, 21 Feb 2025 02:07:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=C1HPyd
 21sazgz3pXWPTlykpxc0KCB3IIyp6NaWvihYk=; b=srFNz6pKoW1rdC6cUxH6ys
 nkgWS1MoTVsmdWItDyzG6v6uu3LHeg0AJpEmbQ5sXCNu5nJY1QYYbWyNCYWEt+m5
 JXcFxrQV/y9oCz2WF0OWRNDBGEQby3lh6K4tjiHIcdGOJlc4j01Zke2vwx9w+ISj
 CJ+4cok7NFiCJIibN2NLoe04azmJhnwrdQ+Xd7cOdEeFMNpFqEXUSESUoNLuvNes
 1biADep7AhoVGiHF5P1YlKkLUYwWw4KnxnPztICjuqRc2DCQpoNpStxX8hv+cAJS
 RssknSksFJ2xWCWDJeipQQWTeUvdVCw53/ZB+BWF6hvNhvVOZaXmH6e3zStybxwQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44x1qycfqg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Feb 2025 02:07:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51L1IQKj030138;
 Fri, 21 Feb 2025 02:07:25 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w01xdet1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Feb 2025 02:07:25 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51L27OtI27656744
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Feb 2025 02:07:24 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B15F5805A;
 Fri, 21 Feb 2025 02:07:25 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A1C9058051;
 Fri, 21 Feb 2025 02:07:24 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.61.45.62]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 21 Feb 2025 02:07:24 +0000 (GMT)
Message-ID: <cd07d8052fbfa0cde426b4b07fde0c70e6aa046f.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 20 Feb 2025 21:07:24 -0500
In-Reply-To: <20250220214333.GA2726725@pevik>
References: <20250220160054.12149-1-zohar@linux.ibm.com>
 <20250220160054.12149-3-zohar@linux.ibm.com>
 <20250220181604.GA2709977@pevik>
 <fd10e47b4c8b6af0e8d37975cdf1e82133add8c3.camel@linux.ibm.com>
 <20250220191342.GA2716312@pevik>
 <c625586b0dbc4302dfb7adf4acb0c891b74cf8bc.camel@linux.ibm.com>
 <2637152a2715b8e84e966b12bc9c9cb1c27592c2.camel@linux.ibm.com>
 <20250220214333.GA2726725@pevik>
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: N0kut96FH6tF7T3-_kpE9pueIsDUixkq
X-Proofpoint-ORIG-GUID: N0kut96FH6tF7T3-_kpE9pueIsDUixkq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_09,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015
 phishscore=0 impostorscore=0 bulkscore=0 mlxlogscore=813 adultscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210013
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
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

T24gVGh1LCAyMDI1LTAyLTIwIGF0IDIyOjQzICswMTAwLCBQZXRyIFZvcmVsIHdyb3RlOgo+ID4g
T24gVGh1LCAyMDI1LTAyLTIwIGF0IDE1OjIyIC0wNTAwLCBNaW1pIFpvaGFyIHdyb3RlOgo+ID4g
PiBPbiBUaHUsIDIwMjUtMDItMjAgYXQgMjA6MTMgKzAxMDAsIFBldHIgVm9yZWwgd3JvdGU6Cj4g
PiA+ID4gPiBPbiBUaHUsIDIwMjUtMDItMjAgYXQgMTk6MTYgKzAxMDAsIFBldHIgVm9yZWwgd3Jv
dGU6Cj4gPiA+ID4gPiA+IEhpIE1pbWksCj4gCj4gPiA+ID4gPiA+ID4gS2VybmVsIHBhdGNoICJp
bWE6IGxpbWl0IHRoZSBudW1iZXIgb2YgVG9NVG9VIGludGVncml0eSB2aW9sYXRpb25zIgo+ID4g
PiA+ID4gPiA+IHByZXZlbnRzIHN1cGVyZmx1b3VzIFRvTVRvVSB2aW9sYXRpb25zLsKgIEFkZCBj
b3JyZXNwb25kaW5nIExUUCB0ZXN0cy4KPiAKPiA+ID4gPiA+ID4gPiBMaW5rOgo+ID4gPiA+ID4g
PiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWludGVncml0eS8yMDI1MDIxOTE2MjEz
MS40MTY3MTktMy16b2hhckBsaW51eC5pYm0uY29tLwo+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYt
Ynk6IE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4LmlibS5jb20+Cj4gCj4gPiA+ID4gPiA+IFVuZm9y
dHVuYXRlbHkgdGVzdHMgZmFpbCBvbiBib3RoIG1haW5saW5lIGtlcm5lbCBhbmQga2VybmVsIHdp
dGggeW91ciBwYXRjaGVzLgo+IAo+ID4gPiA+ID4gVGhlIG5ldyBMVFAgSU1BIHZpb2xhdGlvbnMg
cGF0Y2hlcyBzaG91bGQgZmFpbCB3aXRob3V0IHRoZSBhc3NvY2lhdGVkIGtlcm5lbAo+ID4gPiA+
ID4gcGF0Y2hlcy4KPiAKPiA+ID4gPiA+ID4gQW55IGhpbnQgd2hhdCBjb3VsZCBiZSB3cm9uZz8K
PiAKPiA+ID4gPiA+IE9mIGNvdXJzZSBpdCdzIGRlcGVuZGVudCBvbiB0aGUgSU1BIHBvbGljeS7C
oCBUaGUgdGVzdHMgYXNzdW1lIGJlaW5nIGJvb3RlZCB3aXRoCj4gPiA+ID4gPiB0aGUKPiA+ID4g
PiA+IElNQQo+ID4gPiA+ID4gVENCIG1lYXN1cmVtZW50IHBvbGljeSBvciBzaW1pbGFyIHBvbGlj
eSBiZWluZyBsb2FkZWQuwqAgQ2FuIHlvdSBzaGFyZSB0aGUgSU1BCj4gPiA+ID4gPiBwb2xpY3k/
Cj4gPiA+ID4gPiBlLmcuIGNhdCAvc3lzL2tlcm5lbC9zZWN1cml0eS9pbWEvcG9saWN5Cj4gCj4g
PiA+ID4gPiB0aGFua3MsCj4gCj4gPiA+ID4gPiBNaW1pCj4gCj4gPiA+ID4gTm93IHRlc3Rpbmcg
b24ga2VybmVsICp3aXRoKiB5b3VyIHBhdGNoZXMuIEZpcnN0IHJ1biBhbHdheXMgZmFpbHMsIHJl
Z2FyZGxlc3MKPiA+ID4gPiB3aGV0aGVyIHVzaW5nIGltYV9wb2xpY3k9dGNiIG9yCj4gPiA+ID4g
L29wdC9sdHAvdGVzdGNhc2VzL2RhdGEvaW1hX3Zpb2xhdGlvbnMvdmlvbGF0aW9ucy5wb2xpY3kp
Lgo+IAo+ID4gPiA+IEtpbmQgcmVnYXJkcywKPiA+ID4gPiBQZXRyCj4gCj4gPiA+IEknbSBub3Qg
c2VlaW5nIHRoYXQgb24gbXkgdGVzdCBtYWNoaW5lLsKgIENvdWxkIHRoZXJlIGJlIG90aGVyIHRo
aW5ncyBydW5uaW5nIG9uIHlvdXIKPiA+ID4gc3lzdGVtIGNhdXNpbmcgdmlvbGF0aW9ucy7CoCBJ
biBhbnljYXNlLCB5b3VyIG9yaWdpbmFsIHRlc3Qgd2FzIGxlc3MgZXhhY3RpbmcuwqDCoAo+ID4g
PiBTaW1pbGFybHksCj4gPiA+IGluc3RlYWQgb2YgIi1lcSIsIHRyeSB1c2luZyAiLXFlIiBpbiB0
aGUgZm9sbG93aW5nIHRlc3QgYW5kIHJlbW92aW5nIHRoZSBzdWJzZXF1ZW50Cj4gPiA+IG5ldwo+
ID4gPiAiZ3QiIHRlc3QuCj4gCj4gPiAtPiAiLWdlIgo+IAo+IFN1cmUsIGNoYW5naW5nIHRvIC1n
ZSBmaXhlcyB0aGUgcHJvYmxlbToKPiBpZiBbICQoKCRudW1fdmlvbGF0aW9uc19uZXcgLSAkbnVt
X3Zpb2xhdGlvbnMpKSAtZ2UgJGV4cGVjdGVkX3Zpb2xhdGlvbnMgXTsgdGhlbgo+IAo+IEkgZ3Vl
c3Mgd2UgbmVlZCAiLWdlIiBmb3Igb2xkZXIga2VybmVscyAodW5sZXNzICJmaXgiIGZvciBzdGFi
bGUpLsKgIFNob3VsZCB3ZQo+IGFjY2VwdCAiJGV4cGVjdGVkX3Zpb2xhdGlvbnMgfHwgJGV4cGVj
dGVkX3Zpb2xhdGlvbnMgKyAxIiBmb3IgbmV3IGtlcm5lbHMgdG8KPiBhdm9pZCBwcm9ibGVtcyBs
aWtlIHRoZSBvbmUgb24gbXkgc3lzdGVtLgoKVGhlIHByb2JsZW0gaXMgdGhhdCB3ZSBkb24ndCBj
b250cm9sIHdoYXQgZWxzZSBpcyBydW5uaW5nIG9uIHRoZSBzeXN0ZW0uICBTbyB0aGVyZSBjb3Vs
ZApiZSBvdGhlciB2aW9sYXRpb25zIGluZGVwZW5kZW50IG9mIHRoZXNlIHRlc3RzLiAgSSdsbCBo
YXZlIHRvIHRoaW5rIGFib3V0IGl0IHNvbWUgbW9yZSBhbmQKZ2V0IGJhY2sgdG8geW91LiAgKFRo
ZXJlJ3Mgbm8gcnVzaCB0byBkbyBhbnl0aGluZyB3aXRoIHRoZXNlIExUUCBJTUEgdmlvbGF0aW9u
IHRlc3RzLikKCj4gCj4gSSB3b25kZXIgaWYgdGhlIHByb2JsZW0gd2FzIHNvbWVob3cgY2F1c2Vk
IGJ5IHRoZSBmYWN0IHRoYXQgSSBidWlsdCBrZXJuZWwuIE9UT0gKPiBpdCdzIGJ1aWxkIGJ5IE9C
UyAob2ZmaWNpYWwgb3BlblNVU0UgYnVpbGQgc2VydmljZSkuCgpBcyBsb25nIGFzIHlvdSB3ZXJl
bid0IGJ1aWxkaW5nIHRoZSBrZXJuZWwgYW5kIHJ1bm5pbmcgdGhlIHRlc3RzIGF0IHRoZSBzYW1l
LCBJIGRvdWJ0IGl0CndvdWxkIGJlIHRoZSBwcm9ibGVtLgoKPiAKPiBJIGRvbid0IGV4cGVjdCB5
b3UnZCBoYXZlIHRpbWUgdG8gbG9vayBpbnRvIGl0LCBpbiBjYXNlIHlvdSdyZSBpbnRlcmVzdGVk
IGFuZAo+IGhhdmUgdGltZSBzZW5kaW5nIGEgbGlua3MgdG8gcnBtIGJpbmFyeSBhbmQgc3JjIHBh
Y2thZ2UuCgpPay4KPiAKPiBodHRwczovL2Rvd25sb2FkLm9wZW5zdXNlLm9yZy9yZXBvc2l0b3Jp
ZXMvaG9tZTovcGV2aWs6L2ltYS1saW1pdC1vcGVuLXdyaXRlcnMtVG9NVG9VL3N0YW5kYXJkL3g4
Nl82NC9rZXJuZWwtZGVmYXVsdC02LjE0fnJjMy0xLjEuZ2I2YjQxMDIueDg2XzY0LnJwbQo+IGh0
dHBzOi8vZG93bmxvYWQub3BlbnN1c2Uub3JnL3JlcG9zaXRvcmllcy9ob21lOi9wZXZpazovaW1h
LWxpbWl0LW9wZW4td3JpdGVycy1Ub01Ub1Uvc3RhbmRhcmQvc3JjL2tlcm5lbC1zb3VyY2UtNi4x
NH5yYzMtMS4xLmdiNmI0MTAyLnNyYy5ycG0KPiAKCnRoYW5rcywKCk1pbWkKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
