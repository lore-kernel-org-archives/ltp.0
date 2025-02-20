Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 403C3C021B2
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 21:18:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A8BFC3C76FD
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 22:18:34 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2371A3C0549
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 22:18:17 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6868E141787E
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 22:18:15 +0100 (CET)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KH2295009394;
 Thu, 20 Feb 2025 21:18:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=CECIM3
 ylgWl8kOUYRPZdcobMX6X8Kq0bDAbPeqhI/7g=; b=iehyQrlUm/iBMEoRW6At/g
 gfSmDPBK3NYKb9aZDyuQ3eyXp7dfoJXMi/rpGft5Kkcy3nu6lfKkqrXeSKrb4Efc
 IFjippFxJE64nPMzrrt4YtR6oP8onI/dQlDiR020L8hAr7CMwISmi8pD1q5P1m+E
 LjUldm3Fu8rfD8Xt09QlQrQZSNYa4yUTUJAIy2y9tePf4IDO083RPHXqAvoDd9mX
 C96xi1S22A0W+jSm1lB0R5Q0T9alZTgPCEsMy6VMk7wkCnNRviTGPb9mGw0z56Su
 PHZhMVTgMpKBTwQ8pwi0adZ0XSqH9xmQjn44HXklZTxP/auyH0rCeVMiWZk+UO5g
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wtfa5ffd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Feb 2025 21:18:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51KIOoeG002297;
 Thu, 20 Feb 2025 21:18:12 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w03xc9uh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Feb 2025 21:18:12 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51KLIATg57410016
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Feb 2025 21:18:11 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D27CE5805D;
 Thu, 20 Feb 2025 21:18:11 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 92C3958057;
 Thu, 20 Feb 2025 21:18:11 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.31.103.152]) by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 20 Feb 2025 21:18:11 +0000 (GMT)
Message-ID: <2637152a2715b8e84e966b12bc9c9cb1c27592c2.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 20 Feb 2025 16:18:11 -0500
In-Reply-To: <c625586b0dbc4302dfb7adf4acb0c891b74cf8bc.camel@linux.ibm.com>
References: <20250220160054.12149-1-zohar@linux.ibm.com>
 <20250220160054.12149-3-zohar@linux.ibm.com>
 <20250220181604.GA2709977@pevik>
 <fd10e47b4c8b6af0e8d37975cdf1e82133add8c3.camel@linux.ibm.com>
 <20250220191342.GA2716312@pevik>
 <c625586b0dbc4302dfb7adf4acb0c891b74cf8bc.camel@linux.ibm.com>
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AWoWgqrAzt09j6hVZYlotmDefz7qbX7n
X-Proofpoint-GUID: AWoWgqrAzt09j6hVZYlotmDefz7qbX7n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_09,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=849
 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200140
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

T24gVGh1LCAyMDI1LTAyLTIwIGF0IDE1OjIyIC0wNTAwLCBNaW1pIFpvaGFyIHdyb3RlOgo+IE9u
IFRodSwgMjAyNS0wMi0yMCBhdCAyMDoxMyArMDEwMCwgUGV0ciBWb3JlbCB3cm90ZToKPiA+ID4g
T24gVGh1LCAyMDI1LTAyLTIwIGF0IDE5OjE2ICswMTAwLCBQZXRyIFZvcmVsIHdyb3RlOgo+ID4g
PiA+IEhpIE1pbWksCj4gPiAKPiA+ID4gPiA+IEtlcm5lbCBwYXRjaCAiaW1hOiBsaW1pdCB0aGUg
bnVtYmVyIG9mIFRvTVRvVSBpbnRlZ3JpdHkgdmlvbGF0aW9ucyIKPiA+ID4gPiA+IHByZXZlbnRz
IHN1cGVyZmx1b3VzIFRvTVRvVSB2aW9sYXRpb25zLsKgIEFkZCBjb3JyZXNwb25kaW5nIExUUCB0
ZXN0cy4KPiA+IAo+ID4gPiA+ID4gTGluazoKPiA+ID4gPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LWludGVncml0eS8yMDI1MDIxOTE2MjEzMS40MTY3MTktMy16b2hhckBsaW51eC5p
Ym0uY29tLwo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTWltaSBab2hhciA8em9oYXJAbGludXgu
aWJtLmNvbT4KPiA+IAo+ID4gPiA+IFVuZm9ydHVuYXRlbHkgdGVzdHMgZmFpbCBvbiBib3RoIG1h
aW5saW5lIGtlcm5lbCBhbmQga2VybmVsIHdpdGggeW91ciBwYXRjaGVzLgo+ID4gCj4gPiA+IFRo
ZSBuZXcgTFRQIElNQSB2aW9sYXRpb25zIHBhdGNoZXMgc2hvdWxkIGZhaWwgd2l0aG91dCB0aGUg
YXNzb2NpYXRlZCBrZXJuZWwKPiA+ID4gcGF0Y2hlcy4KPiA+IAo+ID4gPiA+IEFueSBoaW50IHdo
YXQgY291bGQgYmUgd3Jvbmc/Cj4gPiAKPiA+ID4gT2YgY291cnNlIGl0J3MgZGVwZW5kZW50IG9u
IHRoZSBJTUEgcG9saWN5LsKgIFRoZSB0ZXN0cyBhc3N1bWUgYmVpbmcgYm9vdGVkIHdpdGggdGhl
Cj4gPiA+IElNQQo+ID4gPiBUQ0IgbWVhc3VyZW1lbnQgcG9saWN5IG9yIHNpbWlsYXIgcG9saWN5
IGJlaW5nIGxvYWRlZC7CoCBDYW4geW91IHNoYXJlIHRoZSBJTUEKPiA+ID4gcG9saWN5Pwo+ID4g
PiBlLmcuIGNhdCAvc3lzL2tlcm5lbC9zZWN1cml0eS9pbWEvcG9saWN5Cj4gPiAKPiA+ID4gdGhh
bmtzLAo+ID4gCj4gPiA+IE1pbWkKPiA+IAo+ID4gTm93IHRlc3Rpbmcgb24ga2VybmVsICp3aXRo
KiB5b3VyIHBhdGNoZXMuIEZpcnN0IHJ1biBhbHdheXMgZmFpbHMsIHJlZ2FyZGxlc3MKPiA+IHdo
ZXRoZXIgdXNpbmcgaW1hX3BvbGljeT10Y2Igb3IKPiA+IC9vcHQvbHRwL3Rlc3RjYXNlcy9kYXRh
L2ltYV92aW9sYXRpb25zL3Zpb2xhdGlvbnMucG9saWN5KS4KPiA+IAo+ID4gS2luZCByZWdhcmRz
LAo+ID4gUGV0cgo+IAo+IEknbSBub3Qgc2VlaW5nIHRoYXQgb24gbXkgdGVzdCBtYWNoaW5lLsKg
IENvdWxkIHRoZXJlIGJlIG90aGVyIHRoaW5ncyBydW5uaW5nIG9uIHlvdXIKPiBzeXN0ZW0gY2F1
c2luZyB2aW9sYXRpb25zLsKgIEluIGFueWNhc2UsIHlvdXIgb3JpZ2luYWwgdGVzdCB3YXMgbGVz
cyBleGFjdGluZy7CoMKgCj4gU2ltaWxhcmx5LAo+IGluc3RlYWQgb2YgIi1lcSIsIHRyeSB1c2lu
ZyAiLXFlIiBpbiB0aGUgZm9sbG93aW5nIHRlc3QgYW5kIHJlbW92aW5nIHRoZSBzdWJzZXF1ZW50
IG5ldwo+ICJndCIgdGVzdC4KCi0+ICItZ2UiCgo+IAo+IGlmIFsgJCgoJG51bV92aW9sYXRpb25z
X25ldyAtICRudW1fdmlvbGF0aW9ucykpIC1lcSAkZXhwZWN0ZWRfdmlvbGF0aW9ucyBdOyB0aGVu
Cj4gCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
