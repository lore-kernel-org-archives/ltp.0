Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D851EC7618D
	for <ltp@archiver.kernel.org>; Thu,  6 Apr 2023 02:58:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B6C53CCFEB
	for <ltp@archiver.kernel.org>; Thu,  6 Apr 2023 04:58:43 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AAA273C9908
 for <ltp@lists.linux.it>; Thu,  6 Apr 2023 04:58:31 +0200 (CEST)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1E4CB1A00607
 for <ltp@lists.linux.it>; Thu,  6 Apr 2023 04:58:23 +0200 (CEST)
X-UUID: 2418ab03aca9496c92a83028bc15c643-20230406
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22, REQID:24a7202c-3572-4cde-b7e5-d3356ea2c4c8, IP:5,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-3,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-3
X-CID-INFO: VERSION:1.1.22, REQID:24a7202c-3572-4cde-b7e5-d3356ea2c4c8, IP:5,
 URL
 :0,TC:0,Content:-5,EDM:0,RT:0,SF:-3,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:-3
X-CID-META: VersionHash:120426c, CLOUDID:6caee5f7-ddba-41c3-91d9-10eeade8eac7,
 B
 ulkID:230404213659Q14SCUO0,BulkQuantity:1,Recheck:0,SF:24|100|17|19|43|101
 |20|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:11|1,File:nil,Bulk:40,QS:nil,BEC
 :nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 2418ab03aca9496c92a83028bc15c643-20230406
X-User: zenghao@kylinos.cn
Received: from [172.20.12.253] [(116.128.244.169)] by mailgw
 (envelope-from <zenghao@kylinos.cn>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES128-GCM-SHA256 128/128)
 with ESMTP id 125060061; Thu, 06 Apr 2023 10:58:17 +0800
Message-ID: <2952a9e2-7fcf-21b1-b0ea-ca2bf50da73f@kylinos.cn>
Date: Thu, 6 Apr 2023 10:58:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
References: <20230404022808.925841-1-zenghao@kylinos.cn>
 <20230404133650.GA1283114@pevik>
From: zenghao <zenghao@kylinos.cn>
In-Reply-To: <20230404133650.GA1283114@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] testcases:Fix the failure of shell script to get
 path
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

RGVhciBQZXRyClRoYW5rIHlvdSBmb3IgdGFraW5nIHRoZSB0aW1lIHRvIHJlcGx5IHRvIG15IGVt
YWlsLiBJIGFwcHJlY2lhdGUgeW91ciAKcHJvbXB0IHJlc3BvbnNlIGFuZCB0aGUgdmFsdWFibGUg
aW5mb3JtYXRpb24geW91IGhhdmUgcHJvdmlkZWQuCgrlnKggMjAyMy80LzQgMjE6MzYsIFBldHIg
Vm9yZWwg5YaZ6YGTOgo+PiBGb3IgZXhhbXBsZSwgaW4gdGhlIGZpbGUgdGVzdGNhc2VzL2tlcm5l
bC9jb250cm9sbGVycy9jcHVzZXQvY3B1c2V0X2Z1bmNzLnNoLCBpZiB0aGUgcGF0aCBpcyBvYnRh
aW5lZCBieQo+PiBmaW5kICIkQ1BVU0VUIiAtdHlwZSBkIHwgc29ydCB8IHNlZCAtbiAnMiwkcCcg
fCB0YWMgfCB3aGlsZSByZWFkIHN1YmRpciwgdGhlIGVzY2FwZWQgY2hhcmFjdGVycyB3aWxsIGJl
IGxvc3QsCj4+IGFuZCBieSBhZGRpbmcgdGhlIC1yIG9wdGlvbiwgdGhlIGVzY2FwZWQgY2hhcmFj
dGVycyB3aWxsIGJlIGtlcHQgYXMgdGhleSBhcmUgd2l0aG91dCBlc2NhcGluZwo+PiBUaGUgZXJy
b3JzIGFyZSBhcyBmb2xsb3dzOgo+PiAvb3B0L2x0cC90ZXN0Y2FzZXMvYmluL2NwdXNldF9mdW5j
cy5zaDpsaW5lMTc4OiAvZGV2L2NwdXNldC9tYWNoaW5lLnNsaWNlL21hY2hpbmUtcWVtdXgyZDE1
N3gyZHpoeDJkc3hmLnNjb3BlL3ZjcHU3L3Rhc2tzOiBUaGUgZmlsZSBvciBkaXJlY3RvcnkgaXMg
bm90IGF2YWlsYWJsZQo+IENvdWxkIHlvdSBwcmludCB0aGUgcGF0aCBob3cgaXQgbG9va3MgbGlr
ZSB3aXRoIGxzOgo+Cj4gbHMgLWwgL2Rldi9jcHVzZXQvbWFjaGluZS5zbGljZS8KbHMgLWwgL2Rl
di9jcHVzZXQvbWFjaGluZS5zbGljZS8KLXJ3LXItLXItLSAxIHJvb3Qgcm9vdCAwwqAgQXBywqAg
NSAxMzo0NMKgIGNncm91cC5jbG9uZV9jaGlsZHJlbgotcnctci0tci0tIDEgcm9vdCByb290IDDC
oCBBcHLCoCA1IDEzOjQ0wqAgY2dyb3VwLnByb2NzCi1ydy1yLS1yLS0gMSByb290IHJvb3QgMMKg
IEFwcsKgIDUgMTM6NDTCoCBjcHVzZXQuY3B1X2V4Y2x1c2l2ZQotcnctci0tci0tIDEgcm9vdCBy
b290IDDCoCBBcHLCoCA0IDE3OjQxwqAgY3B1c2V0LmNwdXMKLXItLXItLXItLSAxIHJvb3Qgcm9v
dCAwwqAgQXBywqAgNSAxMzo0NMKgIGNwdXNldC5lZmZlY3RpdmVfY3B1cwotci0tci0tci0tIDEg
cm9vdCByb290IDDCoCBBcHLCoCA1IDEzOjQ0wqAgY3B1c2V0LmVmZmVjdGl2ZV9tZW1zCi1ydy1y
LS1yLS0gMSByb290IHJvb3QgMMKgIEFwcsKgIDUgMTM6NDTCoCBjcHVzZXQubWVtX2V4Y2x1c2l2
ZQotcnctci0tci0tIDEgcm9vdCByb290IDDCoCBBcHLCoCA1IDEzOjQ0wqAgY3B1c2V0Lm1lbV9o
YXJkd2FsbAotcnctci0tci0tIDEgcm9vdCByb290IDDCoCBBcHLCoCA0IDE3OjQxwqAgY3B1c2V0
Lm1lbW9yeV9taWdyYXRlCi1yLS1yLS1yLS0gMSByb290IHJvb3QgMMKgIEFwcsKgIDUgMTM6NDTC
oCBjcHVzZXQubWVtb3J5X3ByZXNzdXJlCi1ydy1yLS1yLS0gMSByb290IHJvb3QgMMKgIEFwcsKg
IDUgMTM6NDTCoCBjcHVzZXQubWVtb3J5X3NwcmVhZF9wYWdlCi1ydy1yLS1yLS0gMSByb290IHJv
b3QgMMKgIEFwcsKgIDUgMTM6NDTCoCBjcHVzZXQubWVtb3J5X3NwcmVhZF9zbGFiCi1ydy1yLS1y
LS0gMSByb290IHJvb3QgMMKgIEFwcsKgIDQgMTc6NDHCoCBjcHVzZXQubWVtcwotcnctci0tci0t
IDEgcm9vdCByb290IDDCoCBBcHLCoCA1IDEzOjQ0wqAgY3B1c2V0LnNjaGVkX2xvYWRfYmFsYW5j
ZQotcnctci0tci0tIDEgcm9vdCByb290IDDCoCBBcHLCoCA1IDEzOjQ0IGNwdXNldC5zY2hlZF9y
ZWxheF9kb21haW5fbGV2ZWwKZHJ3eHIteHIteCA2IHJvb3Qgcm9vdCAwwqAgQXBywqAgNSAxMzo0
NCAKJ21hY2hpbmUtcWVtdVx4MmQzXHgyZHpoXHgyZG5vZGUxLnNjb3BlJwotcnctci0tci0tIDEg
cm9vdCByb290IDDCoCBBcHLCoCA1IDEzOjQ0wqAgbm90aWZ5X29uX3JlbGVhc2UKLXJ3LXItLXIt
LSAxIHJvb3Qgcm9vdCAwwqAgQXBywqAgNSAxMzo0NMKgIHRhc2tzCj4KPiBGWUkgY2dyb3VwIHRl
c3RzIHdyaXR0ZW4gaW4gc2hlbGwgYXJlIGJyb2tlbiBieSBkZXNpZ24sIHdlIHdyaXRlIG5ldyB0
ZXN0cyBpbiBDLgo+IE5vdCBzdXJlIGlmIHRoZXNlIG9sZCB0ZXN0cyBhcmUgcmVsZXZhbnQgZW5v
dWdoIHRvIGJlIHJld3JpdHRlbiBpbnRvIEMuCj4KPiAuLi4KZ2V0IGl0Cj4+ICsrKyBiL3Rlc3Rj
YXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9zY3JpcHRzL2dlbmVyYXRlLW1ha2VmaWxlcy5zaAo+
PiBAQCAtMzEyLDcgKzMxMiw3IEBAIGdlbmVyYXRlX2xvY2F0ZV90ZXN0X21ha2VmaWxlIGJ1aWxk
b25seSAnLnRlc3QnICIkYnVpbGRvbmx5X2NvbXBpbGVyX2FyZ3MiCj4+ICAgZ2VuZXJhdGVfbG9j
YXRlX3Rlc3RfbWFrZWZpbGUgcnVubmFibGUgJy5ydW4tdGVzdCcKPj4gICBnZW5lcmF0ZV9sb2Nh
dGVfdGVzdF9tYWtlZmlsZSB0ZXN0LXRvb2xzICcnCj4+IC1maW5kIC4gLW5hbWUgTWFrZWZpbGUu
MSAtZXhlYyBkaXJuYW1lIHt9IFw7IHwgd2hpbGUgcmVhZCBkaXI7IGRvCj4+ICtmaW5kIC4gLW5h
bWUgTWFrZWZpbGUuMSAtZXhlYyBkaXJuYW1lIHt9IFw7IHwgd2hpbGUgcmVhZCAtciBkaXI7IGRv
Cj4gSSBkb24ndCB0aGluayBpdCdzIG5lZWRlZCBmb3Igb3BlbiBwb3NpeC4KSSBhZ3JlZSB3aXRo
IHlvdXIgdmlld3BvaW50Lgo+Cj4gS2luZCByZWdhcmRzLAo+IFBldHIKQmVzdCByZWdhcmRzCkhh
bwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZv
L2x0cAo=
