Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF38E77188
	for <ltp@archiver.kernel.org>; Tue, 31 Dec 2024 14:54:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE7DD3EFB8B
	for <ltp@archiver.kernel.org>; Tue, 31 Dec 2024 15:54:36 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 973253EF328
 for <ltp@lists.linux.it>; Tue, 31 Dec 2024 15:54:18 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 26F24200BDE
 for <ltp@lists.linux.it>; Tue, 31 Dec 2024 15:54:16 +0100 (CET)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BV2sYjZ009748;
 Tue, 31 Dec 2024 14:54:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=T3QoaK
 cfhU0ZHHmSOmCZ0Cg1YeG5s4qCECce2l3XUF4=; b=Whr+mQPnZZyRT7LDukE+l7
 AeX1SSa0MWbgWStnzUSSfR3+8eFs5SQ2qTowwALCLYmwHOXBSYeMwWpeivBCwymA
 jSfDZ30paBPiTSExdU8spefXMciokb5EemU+2nx55YJfDdaNeA/RgwFzUQniGwQS
 A3P+VpTaVPqdA4AFXT39leoyXHCrAd58IkpANew/rZlh7C9jYpHnOgi488Za4cLE
 KZVLNm2MfsqTUN+ltmfCviWOaz8imREiIV0o73IEMcIr2Nn8pmG/4oeIbMDK57p1
 ODlbmagQydajhvbasP9ej/M6cjncKKJaz5FWhUznlDnbDMDO+JCMqU55a6xoCHIg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43v5baacut-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Dec 2024 14:54:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BVEmb63014023;
 Tue, 31 Dec 2024 14:54:14 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43tv1y2km4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Dec 2024 14:54:14 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BVEsDvF29033130
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 31 Dec 2024 14:54:13 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BA9CB5805D;
 Tue, 31 Dec 2024 14:54:13 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 461C558053;
 Tue, 31 Dec 2024 14:54:13 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.61.178.58]) by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 31 Dec 2024 14:54:13 +0000 (GMT)
Message-ID: <b577405f0c6d2af8de6650eb1cd8c69305f616bf.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 31 Dec 2024 09:54:12 -0500
In-Reply-To: <20241231100057.GB36475@pevik>
References: <20241213222014.1580991-1-pvorel@suse.cz>
 <20241213222014.1580991-3-pvorel@suse.cz>
 <a617f000c69875b5c02743c8f0a8fee72cb1ea55.camel@linux.ibm.com>
 <20241231100057.GB36475@pevik>
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OR6WJwgFfQxiQikF3FXmuhdF4H4FEbqG
X-Proofpoint-ORIG-GUID: OR6WJwgFfQxiQikF3FXmuhdF4H4FEbqG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412310123
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/8] ima_setup.sh: Allow to load predefined
 policy
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

T24gVHVlLCAyMDI0LTEyLTMxIGF0IDExOjAwICswMTAwLCBQZXRyIFZvcmVsIHdyb3RlOgo+ID4g
SGkgUGV0ciwKPiAKPiA+IE9uIEZyaSwgMjAyNC0xMi0xMyBhdCAyMzoyMCArMDEwMCwgUGV0ciBW
b3JlbCB3cm90ZToKPiA+IFtzbmlwXQo+IAo+ID4gPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3Nl
Y3VyaXR5L2ludGVncml0eS9pbWEvdGVzdHMvaW1hX3NldHVwLnNoCj4gPiA+ICsrKyBiL3Rlc3Rj
YXNlcy9rZXJuZWwvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS90ZXN0cy9pbWFfc2V0dXAuc2gKPiA+
ID4gQEAgLTEsNyArMSw3IEBACj4gPiA+IMKgIyEvYmluL3NoCj4gPiA+IMKgIyBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgo+ID4gPiDCoCMgQ29weXJpZ2h0IChjKSAy
MDA5IElCTSBDb3Jwb3JhdGlvbgo+ID4gPiAtIyBDb3B5cmlnaHQgKGMpIDIwMTgtMjAyMCBQZXRy
IFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPiA+ID4gKyMgQ29weXJpZ2h0IChjKSAyMDE4LTIwMjQg
UGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4gPiA+IMKgIyBBdXRob3I6IE1pbWkgWm9oYXIg
PHpvaGFyQGxpbnV4LmlibS5jb20+Cj4gCj4gPiA+IMKgVFNUX1RFU1RGVU5DPSJ0ZXN0Igo+ID4g
PiBAQCAtNzIsMTQgKzcyLDIwIEBAIHJlcXVpcmVfcG9saWN5X3JlYWRhYmxlKCkKPiA+ID4gwqAJ
ZmkKPiA+ID4gwqB9Cj4gCj4gPiA+IC1yZXF1aXJlX3BvbGljeV93cml0YWJsZSgpCj4gPiA+ICtj
aGVja19wb2xpY3lfd3JpdGFibGUoKQo+ID4gPiDCoHsKPiA+ID4gLQlsb2NhbCBlcnI9IklNQSBw
b2xpY3kgYWxyZWFkeSBsb2FkZWQgYW5kIGtlcm5lbCBub3QgY29uZmlndXJlZCB0byBlbmFibGUg
bXVsdGlwbGUgd3JpdGVzIHRvIGl0IChuZWVkIENPTkZJR19JTUFfV1JJVEVfUE9MSUNZPXkpIgo+
ID4gPiAtCj4gPiA+IC0JWyAtZiAkSU1BX1BPTElDWSBdIHx8IHRzdF9icmsgVENPTkYgIiRlcnIi
Cj4gPiA+IC0JIyBDT05GSUdfSU1BX1JFQURfUE9MSUNZCj4gPiA+ICsJWyAtZiAkSU1BX1BPTElD
WSBdIHx8IHJldHVybiAxCj4gPiA+ICsJIyB3b3JrYXJvdW5kIGZvciBrZXJuZWxzIDwgdjQuMTgg
d2l0aG91dCBmaXgKPiA+ID4gKwkjIGZmYjEyMmRlOWE2MGIgKCJpbWE6IFJlZmxlY3QgY29ycmVj
dCBwZXJtaXNzaW9ucyBmb3IgcG9saWN5IikKPiA+ID4gwqAJZWNobyAiIiAyPiBsb2cgPiAkSU1B
X1BPTElDWQo+ID4gPiAtCWdyZXAgLXEgIkRldmljZSBvciByZXNvdXJjZSBidXN5IiBsb2cgJiYg
dHN0X2JyayBUQ09ORiAiJGVyciIKPiA+ID4gKwlncmVwIC1xICJEZXZpY2Ugb3IgcmVzb3VyY2Ug
YnVzeSIgbG9nICYmIHJldHVybiAxCj4gPiA+ICsJcmV0dXJuIDAKPiA+ID4gK30KPiA+ID4gKwo+
ID4gPiArcmVxdWlyZV9wb2xpY3lfd3JpdGFibGUoKQo+ID4gPiArewo+ID4gPiArCWNoZWNrX3Bv
bGljeV93cml0YWJsZSB8fCB0c3RfYnJrIFRDT05GIFwKPiA+ID4gKwkJIklNQSBwb2xpY3kgYWxy
ZWFkeSBsb2FkZWQgYW5kIGtlcm5lbCBub3QgY29uZmlndXJlZCB0byBlbmFibGUgbXVsdGlwbGUg
d3JpdGVzIHRvIGl0IChuZWVkIENPTkZJR19JTUFfV1JJVEVfUE9MSUNZPXkpIgo+ID4gPiDCoH0K
PiAKPiA+ID4gwqBjaGVja19pbWFfcG9saWN5X2NvbnRlbnQoKQo+ID4gPiBAQCAtMTU4LDYgKzE2
NCwzNCBAQCBwcmludF9pbWFfY29uZmlnKCkKPiA+ID4gwqAJdHN0X3JlcyBUSU5GTyAiL3Byb2Mv
Y21kbGluZTogJChjYXQgL3Byb2MvY21kbGluZSkiCj4gPiA+IMKgfQo+IAo+ID4gPiArbG9hZF9p
bWFfcG9saWN5KCkKPiA+ID4gK3sKPiA+ID4gKwlsb2NhbCBwb2xpY3k9IiQobHMgJFRTVF9EQVRB
Uk9PVC8qLnBvbGljeSAyPi9kZXYvbnVsbCkiCj4gPiA+ICsKPiA+ID4gKwlpZiBbICIkTFRQX0lN
QV9MT0FEX1BPTElDWSIgIT0gMSAtYSAiJHBvbGljeSIgLWEgLWYgIiRwb2xpY3kiIF07IHRoZW4K
PiA+ID4gKwkJdHN0X3JlcyBUSU5GTyAiTk9URTogc2V0IExUUF9JTUFfTE9BRF9QT0xJQ1k9MSB0
byBsb2FkIHBvbGljeSBmb3IgdGhpcyB0ZXN0Igo+ID4gPiArCQlyZXR1cm4KPiA+ID4gKwlmaQo+
ID4gPiArCj4gPiA+ICsJaWYgWyAteiAiJHBvbGljeSIgLW8gISAtZiAiJHBvbGljeSIgXTsgdGhl
bgo+ID4gPiArCQl0c3RfcmVzIFRJTkZPICJubyBwb2xpY3kgZm9yIHRoaXMgdGVzdCIKPiA+ID4g
KwkJTFRQX0lNQV9MT0FEX1BPTElDWT0KPiA+ID4gKwkJcmV0dXJuCj4gPiA+ICsJZmkKPiA+ID4g
Kwo+ID4gPiArCXRzdF9yZXMgVElORk8gInRyeWluZyB0byBsb2FkICckcG9saWN5JyBwb2xpY3k6
Igo+ID4gPiArCWNhdCAkcG9saWN5Cj4gPiA+ICsJaWYgISBjaGVja19wb2xpY3lfd3JpdGFibGU7
IHRoZW4KPiA+ID4gKwkJdHN0X3JlcyBUSU5GTyAiV0FSTklORzogSU1BIHBvbGljeSBhbHJlYWR5
IGxvYWRlZCBhbmQga2VybmVsIG5vdCBjb25maWd1cmVkIHRvIGVuYWJsZSBtdWx0aXBsZSB3cml0
ZXMgdG8gaXQgKG5lZWQgQ09ORklHX0lNQV9XUklURV9QT0xJQ1k9eSksIHJlYm9vdCByZXF1aXJl
ZCIKPiA+ID4gKwkJTFRQX0lNQV9MT0FEX1BPTElDWT0KPiA+ID4gKwkJcmV0dXJuCj4gPiA+ICsJ
ZmkKPiA+ID4gKwo+ID4gPiArCWNhdCAiJHBvbGljeSIgMj4gbG9nID4gJElNQV9QT0xJQ1kKPiA+
ID4gKwlpZiBncmVwIC1xICJEZXZpY2Ugb3IgcmVzb3VyY2UgYnVzeSIgbG9nOyB0aGVuCj4gPiA+
ICsJCXRzdF9icmsgVEJST0sgIkxvYWRpbmcgcG9saWN5IGZhaWxlZCIKPiA+ID4gKwlmaQo+IAo+
ID4gVG8gd3JpdGUgdG8gdGhlIElNQSBzZWN1cml0eWZzIHBvbGljeSBmaWxlLCBjaGVja19wb2xp
Y3lfd3JpdGFibGUoKSB1c2VkICJlY2hvIiwKPiA+IHdoaWxlIGhlcmUgaXQncyB1c2luZyAiY2F0
Ii4gICJjYXQiIGZhaWxzIHdoZW4gc2lnbmVkIHBvbGljaWVzIGFyZSByZXF1aXJlZC4KPiA+IFBl
cmhhcHMgYWRkIHNvbWV0aGluZyBsaWtlOgo+ID4gKwo+ID4gKyAgICAgICBpZiBncmVwIC1xICJ3
cml0ZSBlcnJvcjogUGVybWlzc2lvbiBkZW5pZWQiIGxvZzsgdGhlbgo+ID4gKyAgICAgICAgICAg
ICAgIHRzdF9icmsgVEJST0sgIkxvYWRpbmcgdW5zaWduZWQgcG9saWN5IGZhaWxlZCIKPiA+ICsg
ICAgICAgZmkKPiAKPiArMSwgSSdsbCBhZGQgdGhpcyBleHRyYSBjaGVjayB0byB2My4KPiAKPiBJ
IHN1cHBvc2UgZWNobyAiIiA+IC9zeXMva2VybmVsL3NlY3VyaXR5L2ltYS9wb2xpY3kgZG9lcyBu
b3QgbmVlZCB0aGlzIGNoZWNrLgoKVGhlIG9yaWdpbmFsIG1ldGhvZCBmb3IgbG9hZGluZyBhbiBJ
TUEgcG9saWN5IHdhcyBieSBjYXQnaW5nIHRoZSBwb2xpY3kgcnVsZXMuIApDb21taXQgNzQyOWIw
OTI4MTFmICgiaW1hOiBsb2FkIHBvbGljeSB1c2luZyBwYXRoIikgaW50cm9kdWNlZCB0aGUgYWJp
bGl0eSBvZgp2ZXJpZnlpbmcgdGhlIGludGVncml0eSBvZiB0aGUgcG9saWN5IGl0c2VsZi4KCmVj
aG8gPHBvbGljeSBmaWxlcGF0aD4gID4gL3N5cy9rZXJuZWwvc2VjdXJpdHkvaW1hL3BvbGljeQoK
PiAKPiBEbyBJIHVuZGVyc3RhbmQgY29ycmVjdGx5IHlvdSB0YWxrIGFib3V0IHBvbGljeSBjb250
YWluaW5nIGZ1bmM9UE9MSUNZX0NIRUNLIFsxXT8KClllcy4gIE9uIGEgc2VjdXJlIGJvb3QgZW5h
YmxlZCBzeXN0ZW0sIHRoZSBhcmNoaXRlY3R1cmUgc3BlY2lmaWMgcG9saWN5IG1pZ2h0CnJlcXVp
cmUgdGhlIElNQSBwb2xpY3kgaXRzZWxmIHRvIGJlIHNpZ25lZC4KClNuaXBwZXQgZnJvbSBpbWFf
ZnMuYzoKCiNpZiBJU19FTkFCTEVEKENPTkZJR19JTlRFR1JJVFlfTUFDSElORV9LRVlSSU5HKSAm
JgpJU19FTkFCTEVEKENPTkZJR19JTUFfS0VZUklOR1NfUEVSTUlUX1NJR05FRF9CWV9CVUlMVElO
X09SX1NFQ09OREFSWSkKICAgICAgICAiYXBwcmFpc2UgZnVuYz1QT0xJQ1lfQ0hFQ0sgYXBwcmFp
c2VfdHlwZT1pbWFzaWciLAojZW5kaWYKCj4gTWF5YmUgdGhlcmUgY291bGQgYmUgYSB0ZXN0IGJh
c2VkIG9uIGV4YW1wbGUgWzJdLgo+IAo+IGVjaG8gL2hvbWUvdXNlci90bXBmaWxlID4gL3N5cy9r
ZXJuZWwvc2VjdXJpdHkvaW1hL3BvbGljeQo+IGNwIHRtcGZpbGUgL3N5cy9rZXJuZWwvc2VjdXJp
dHkvaW1hL3BvbGljeQo+IGNhdCB0bXBmaWxlID4gL3N5cy9rZXJuZWwvc2VjdXJpdHkvaW1hL3Bv
bGljeQoKQWxsIG9mIHRoZSBhYm92ZSB3aWxsIGxvYWQgYSBwb2xpY3ksIGFzc3VtaW5nIHRoZSBw
b2xpY3kgaXRzZWxmIGRvZXNuJ3QgbmVlZCB0bwpiZSBzaWduZWQuICBPbmx5ICJlY2hvIC9ob21l
L3VzZXIvdG1wZmlsZSA+IC9zeXMva2VybmVsL3NlY3VyaXR5L2ltYS9wb2xpY3kiIGNhbgpsb2Fk
IGEgc2lnbmVkIHBvbGljeS4KCkxvYWRpbmcgYSBDQSBrZXkgKG1va3V0aWwpLCBzaWduaW5nIChl
dm1jdGwpWzFdIGFuZCBsb2FkaW5nIChrZXljdGwpIGFuIElNQQpwb2xpY3kgaXMgcHJvYmFibHkg
YmV5b25kIExUUC4gIFRoZSBwdXJwb3NlIG9mIHRoaXMgdGVzdCB3b3VsZCBiZSB0byBkZXRlY3QK
d2hldGhlciBwb2xpY2llcyBuZWVkIHRvIGJlIHNpZ25lZC4KCkdvaW5nIGZvcndhcmQgd2hhdCdz
IHByb2JhYmx5IG5lZWRlZCBpcyBhIG5ldyBwYWNrYWdlIGNvbnRhaW5pbmcgYSBzZXQgb2YgcHJl
LQpkZWZpbmVkIHNhbXBsZSBjdXN0b20gcG9saWNpZXMsIHdoaWNoIGFyZSBzaWduZWQgYnkgdGhl
IGRpc3Ryby4KClsxXSBEaXJlY3Rpb25zIGZvciBzaWduaW5nIGFuZCBsb2FkaW5nIGEgY3VzdG9t
IHBvbGljeSwKaHR0cHM6Ly9pbWEtZG9jLnJlYWR0aGVkb2NzLmlvL2VuL2xhdGVzdC9pbWEtdXRp
bGl0aWVzLmh0bWwjc2lnbi1hbmQtaW5zdGFsbC1hLWN1c3RvbS1wb2xpY3kKClRoYW5rcywKCk1p
bWkKCj4gCj4gS2luZCByZWdhcmRzLAo+IFBldHIKPiAKPiBbMV0gaHR0cHM6Ly9pbWEtZG9jLnJl
YWR0aGVkb2NzLmlvL2VuL2xhdGVzdC9wb2xpY3ktc3ludGF4Lmh0bWwjZnVuYy1wb2xpY3ktY2hl
Y2sKPiBbMl0gaHR0cHM6Ly9pbWEtZG9jLnJlYWR0aGVkb2NzLmlvL2VuL2xhdGVzdC9pbWEtcG9s
aWN5Lmh0bWwjcnVudGltZS1jdXN0b20tcG9saWN5Cj4gCj4gPiA+ICt9Cj4gCj4gPiBNaW1pCj4g
Cj4gCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
