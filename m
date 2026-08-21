Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD274C5DF8C
	for <ltp@archiver.kernel.org>; Fri, 21 Aug 2026 17:01:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 868C73D0F3F
	for <ltp@archiver.kernel.org>; Fri, 21 Aug 2026 19:01:44 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 980873C55FC
 for <ltp@lists.linux.it>; Fri, 21 Aug 2026 19:01:26 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0D1491000D21
 for <ltp@lists.linux.it>; Fri, 21 Aug 2026 19:01:25 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67LG1ZaM889117
 for <ltp@lists.linux.it>; Fri, 21 Aug 2026 17:01:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=h5bSj+
 Gcg1NIvH8TtpVKdjBgm8DGUWwJ021M3VE85/8=; b=rqN2Pz78QdS5KPyGEe3aWX
 9k0aaLvMP6v0ugJcsJ5mx2mYkyuuniPgswXtxlujKVu9Lk1jYrlEL06t+NFz3wpv
 b/pkQVmLnZ1RjheGYO+MIe5IV8a1jreqsJmCw/NvNsp9qCxdnjmogEFcpSOU6BNX
 k0aeXk507ELoBQ34GKnb1cHzZdEUlAV2hBEjuRn5BABqxEtG4ria0HSzkauHhXW0
 FgsPpbMEJ6+oYWLUEapchg0HG3enT8YzbG9ZMpr9V+Q91uPHf86aXHNPIJhoweW+
 I6Z7ItoNGA16lJq3mIMcHcM4Srlh2u4/60WLdS3sYxf7ip4pPl3CJVVis5vYm5sA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu2jrt0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2026 17:01:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LGuINe027280;
 Fri, 21 Aug 2026 17:01:22 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ekntab-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2026 17:01:22 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67LH1MFt33620650
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Aug 2026 17:01:22 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 41DA258065;
 Fri, 21 Aug 2026 17:01:22 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 31D0858052;
 Fri, 21 Aug 2026 17:01:21 +0000 (GMT)
Received: from [9.43.42.13] (unknown [9.43.42.13])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 21 Aug 2026 17:01:20 +0000 (GMT)
Message-ID: <6f6fff2f-2b56-429d-8b60-c6ea520cf0e4@linux.ibm.com>
Date: Fri, 21 Aug 2026 22:31:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linuxtestproject.agent@gmail.com
References: <20260818143106.43797-1-samir@linux.ibm.com>
 <20260818202730.9105-1-linuxtestproject.agent@gmail.com>
Content-Language: en-US
From: Samir M <samir@linux.ibm.com>
In-Reply-To: <20260818202730.9105-1-linuxtestproject.agent@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AdqB2XXG c=1 sm=1 tr=0 ts=6a888463 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=pGLkceISAAAA:8
 a=zSVmW2-dFmTHdH5gISAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: o41xK_toQiMo9vEKH_j1RzsthlbcBnS8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEzNCBTYWx0ZWRfX2IynrCU0H3kI
 liWk1J+xKugoEK/KhqJiAPW9SeH9c4P7sb8GlqaHB5q54ahRHbSoJBuuvStVEKnql7d2d5Hq8lk
 aogXGcKgPO5wHtz96uM9tU+V5xBM0H4v7F+0KTNUZd5zzquGSl9aL5w4f5kc7CXJnUj7v04dUWD
 U6WKTlib2husrF8LEPqnrmAOeEOqNWsickDt3R7T2Zag5BXYKzGAl6Uxw92A3q9BjGzy9OysfuP
 G1OPIYzDotrWPk5IuwZi+JvgqVeFs7h97E57ghJIhLL1zDLCciCGXAx8dLJZiYonSfZ9UIv+T10
 nO6wWdrptoi+wza22tG5+ZucPDJNx5H7UAsgBKUIc6xpuIdV/rUn2ENr769wLG6iKvrgQKeXIei
 li4miky1u0DbVTd5ibR8kR1ItbbfnmFuNCyfvM8LVSxNkRexRFLTUm/GmQU8WBr/jZ+Y/i3KT6j
 FuRjqORO69QwmXVSwNg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEzNCBTYWx0ZWRfXzjvCT8XahV4Q
 rUsGBohL4q1dDTNE4CigVLAHYhEPutoeC5M8v5Z8UI4o/jcwCvwuFs/RolIw7YIyXCW56bjF0mu
 gC1OBoOhAjKd7q6gqybq+9AxOEFUziU=
X-Proofpoint-ORIG-GUID: Fgzl4U4UiJfIFJEVvIRrpkwNB9QK-Au4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_05,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210134
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugemmap: Migrate alloc-instantiate-race test from
 libhugetlbfs
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

Ck9uIDE5LzA4LzI2IDE6NTcgYW0sIGxpbnV4dGVzdHByb2plY3QuYWdlbnRAZ21haWwuY29tIHdy
b3RlOgo+IEhpIFNhbWlyLAo+Cj4gT24gQXVndXN0IDE4LCAyMDI2LCBTYW1pciBNdWxhbmkgd3Jv
dGU6Cj4+IGh1Z2VtbWFwOiBNaWdyYXRlIGFsbG9jLWluc3RhbnRpYXRlLXJhY2UgdGVzdCBmcm9t
IGxpYmh1Z2V0bGJmcwo+PiBNaWdyYXRlIHRoZSBhbGxvYy1pbnN0YW50aWF0ZS1yYWNlLmMgdGVz
dCBmcm9tIGxpYmh1Z2V0bGJmcyBbMV0gdG8gTFRQCj4+IGFzIGh1Z2VtbWFwMzYuCj4gQ291bGQg
dGhpcyBiZSBjb3JyZWN0ZWQgdG8gaHVnZW1tYXA0Miwgd2hpY2ggaXMgdGhlIHRlc3QgYWRkZWQg
YnkgdGhpcwo+IHBhdGNoPwpZZXMsIGZpeGVkIHRoZSBjb21taXQgbWVzc2FnZS4gSXQgbm93IGNv
cnJlY3RseSBzYXlzIGh1Z2VtbWFwNDIuIHVwZGF0ZWQgCmluIHBhdGNoIHY3Cj4+ICtodWdlbW1h
cDQyIGh1Z2VtbWFwNDIKPiBDb3VsZCBhIHNlY29uZCBydW50ZXN0IGVudHJ5IGV4ZXJjaXNlICIt
bSBwcml2YXRlIj8gV2l0aG91dCBhbiBvcHRpb24sCj4gc2V0dXAoKSBkZWZhdWx0cyB0byBNQVBf
U0hBUkVELCBzbyB0aGUgbmV3IHB0aHJlYWQgcGF0aCBpcyBub3QgcnVuIGJ5IHRoZQo+IGh1Z2V0
bGIgc3VpdGUuClllcywgYWRkZWQgYSBzZWNvbmQgZW50cnkgaW4gcnVudGVzdC9odWdldGxiOiB1
cGRhdGVkIGluIHBhdGNoIHY3Cj4+ICsJZXJyID0gc2NoZWRfc2V0YWZmaW5pdHkoZ2V0cGlkKCks
IG1hc2tfc2l6ZSwgY3B1c2V0KTsKPiBDb3VsZCB0aGlzIHBhc3MgMCBhcyB0aGUgcGlkPyBzY2hl
ZF9zZXRhZmZpbml0eSgpIGFwcGxpZXMgdGhlIG1hc2sgdG8gdGhlCj4gdGhyZWFkIElEIHN1cHBs
aWVkIGluIHBpZC4gSW4gdGhlIE1BUF9QUklWQVRFIHBhdGgsIGdldHBpZCgpIGlkZW50aWZpZXMg
dGhlCj4gdGhyZWFkLWdyb3VwIGxlYWRlciBmb3IgYm90aCBwdGhyZWFkcywgc28gYm90aCByYWNl
cnMgY2hhbmdlIHRoZSBtYWluCj4gdGhyZWFkJ3MgYWZmaW5pdHkgYW5kIHJlbWFpbiB1bnBpbm5l
ZC4KWWVzLCBmaXhlZC4gQ2hhbmdlZCBnZXRwaWQoKSB0byAwLgpXaXRoIGdldHBpZCgpLCBib3Ro
IHB0aHJlYWRzIHJldHVybiB0aGUgc2FtZSB0aHJlYWQtZ3JvdXAgSUQsIHNvIGJvdGggCndlcmUg
cGlubmluZyB0aGUgbWFpbiB0aHJlYWQgaW5zdGVhZCBvZiB0aGVtc2VsdmVzLiBVc2luZyAwIG1l
YW5zICJhcHBseSAKdG8gdGhlIGNhbGxpbmcgdGhyZWFkIiwgd2hpY2ggaXMgY29ycmVjdCBmb3Ig
Ym90aCB0aGUgZm9yayBhbmQgcHRocmVhZCAKY2FzZXMuCj4+ICsJcF9zeW5jID0gU0FGRV9NTUFQ
KE5VTEwsICh0b3RwYWdlcyAtIDEpICogaHBhZ2Vfc2l6ZSwKPj4gKwkJCSAgIFBST1RfUkVBRCB8
IFBST1RfV1JJVEUsIE1BUF9TSEFSRUQsIGZkX3N5bmMsIDApOwo+PiArCj4+ICsJcnVuX3JhY2Uo
cmFjZV90eXBlKTsKPiBDb3VsZCBlYWNoIGh1Z2VwYWdlIGluIHBfc3luYyBiZSB3cml0dGVuIGJl
Zm9yZSBydW5fcmFjZSgpPyBtbWFwKCkgd2l0aG91dAo+IE1BUF9QT1BVTEFURSBkb2VzIG5vdCBm
YXVsdCB0aGVzZSBwYWdlcyBpbi4gQ29uc2VxdWVudGx5IGFsbCBmcmVlIGh1Z2VwYWdlcwo+IHJl
bWFpbiBhdmFpbGFibGUgdG8gdGhlIHJhY2VycyBpbnN0ZWFkIG9mIG9ubHkgdGhlIGZpbmFsIHBh
Z2UsIGFuZCB0aGUKPiBhbGxvY2F0aW9uIHJhY2UgaXMgbm90IGV4ZXJjaXNlZC4gVGhlIHNvdXJj
ZSB0ZXN0IGV4cGxpY2l0bHkgdG91Y2hlcyBlYWNoCj4gcGFnZSBmb3IgdGhpcyByZWFzb24uClll
cywgZml4ZWQuIEFkZGVkIGEgbG9vcCB0aGF0IHdyaXRlcyBvbmUgYnl0ZSB0byBlYWNoIHN5bmMg
cGFnZSBiZWZvcmUgCmNhbGxpbmcgcnVuX3JhY2UoKToKCmZvciAodW5zaWduZWQgbG9uZyBpID0g
MDsgaSA8IHRvdHBhZ2VzIC0gMTsgaSsrKSB7CiDCoCDCoCB2b2xhdGlsZSBjaGFyICpjcCA9ICh2
b2xhdGlsZSBjaGFyICopcF9zeW5jICsgaSAqIGhwYWdlX3NpemU7CiDCoCDCoCAqY3AgPSAwOwp9
CldpdGhvdXQgdGhpcywgbW1hcCgpIGRvZXMgbm90IGFjdHVhbGx5IHRha2UgaHVnZXBhZ2VzIGZy
b20gdGhlIHBvb2wgKG5vIApNQVBfUE9QVUxBVEUpLCBzbyBhbGwgcGFnZXMgd2VyZSBzdGlsbCBm
cmVlIHdoZW4gdGhlIHJhY2Ugc3RhcnRlZCBhbmQgCnRoZSByYWNlIGNvbmRpdGlvbiB3YXMgbmV2
ZXIgdHJpZ2dlcmVkLiBUaGlzIHdhcyB0aGUgbW9zdCBpbXBvcnRhbnQgZml4Lgo+PiArCWlmIChw
X3N5bmMgIT0gTUFQX0ZBSUxFRCkgewo+PiArCQl1bnNpZ25lZCBsb25nIHRvdHBhZ2VzID0gU0FG
RV9SRUFEX01FTUlORk8oTUVNSU5GT19IUEFHRV9GUkVFKTsKPj4gKwo+PiArCQlTQUZFX01VTk1B
UChwX3N5bmMsIHRvdHBhZ2VzICogdHN0X2dldF9odWdlcGFnZV9zaXplKCkpOwo+PiArCX0KPiBD
b3VsZCB0aGUgZXhhY3QgbGVuZ3RoIHBhc3NlZCB0byBtbWFwKCkgYmUgc2F2ZWQgYW5kIHJldXNl
ZCBoZXJlPyBUaGUKPiBjdXJyZW50IGZyZWUtcGFnZSBjb3VudCBpcyBub3QgdGhlIG1hcHBpbmcg
bGVuZ3RoLiBPbiBhbiBhYm9ydCB3aXRoIHRoZQo+IGN1cnJlbnQgY29kZSBpdCBpcyBvbmUgcGFn
ZSBsYXJnZXIsIGFuZCBtdW5tYXAoKSBtYXkgcmVtb3ZlIGFuIGFkamFjZW50Cj4gbWFwcGluZy4g
QWZ0ZXIgdGhlIHBhZ2VzIGFyZSBmYXVsdGVkIGluLCBhIHByZS1leGlzdGluZyBodWdlcGFnZSBw
b29sIGNhbgo+IGluc3RlYWQgbWFrZSBpdCBzbWFsbGVyIGFuZCBsZWF2ZSBwYXJ0IG9mIHBfc3lu
YyBtYXBwZWQuClllcywgZml4ZWQuIEFkZGVkIGEgZ2xvYmFsIHN5bmNfbWFwcGluZ19zaXplLCBz
ZXQgaXQgYXQgbW1hcCgpIHRpbWUKYW5kIHJldXNlZCBpdCBpbiBib3RoIHJ1bl90ZXN0KCkgYW5k
IGNsZWFudXAoKS4gVGhpcyBhdm9pZHMgdXNpbmcKU0FGRV9SRUFEX01FTUlORk8oKSBpbiBjbGVh
bnVwKCkgd2hpY2ggY2FuIHJldHVybiBhIGRpZmZlcmVudCB2YWx1ZQp0aGFuIHdoYXQgd2FzIGFj
dHVhbGx5IG1hcHBlZAo+PiArCQl7TlVMTCwgTlVMTCwgTlVMTH0KPiBDb3VsZCB0aGlzIHVzZSB0
aGUgc3RhbmRhcmQgZW1wdHkgc2VudGluZWwgInt9Ij8gY2hlY2staHVnZW1tYXA0MiByZXBvcnRz
Cj4gTFRQLTAwNSBmb3IgdGhpcyBvcHRpb25zIGFycmF5LgpZZXMsIGZpeGVkLiBDaGFuZ2VkIHtO
VUxMLCBOVUxMLCBOVUxMfSB0byB7fS4KPgo+IFZlcmRpY3QgLSBOZWVkcyByZXZpc2lvbgo+Cj4g
LS0tCj4gTm90ZToKPgo+IFRoZSBhZ2VudCBjYW4gc29tZXRpbWVzIHByb2R1Y2UgZmFsc2UgcG9z
aXRpdmVzIGFsdGhvdWdoIG9mdGVuIGl0cwo+IGZpbmRpbmdzIGFyZSBnZW51aW5lLiBJZiB5b3Ug
ZmluZCBpc3N1ZXMgd2l0aCB0aGUgcmV2aWV3LCBwbGVhc2UKPiBjb21tZW50IHRoaXMgZW1haWwg
b3IgaWdub3JlIHRoZSBzdWdnZXN0aW9ucy4KPgo+IFJlZ2FyZHMsCj4gTFRQIEFJIFJldmlld2Vy
Cgp2NyBwYXRjaCB3aWxsIGZvbGxvdyBzaG9ydGx5LgoKUmVnYXJkcywKU2FtaXIKCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
