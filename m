Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E44AF013DA
	for <ltp@archiver.kernel.org>; Mon, 16 Mar 2026 09:07:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F46A3E235E
	for <ltp@archiver.kernel.org>; Mon, 16 Mar 2026 10:07:41 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B9F623E10D3
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 10:07:23 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DC848200975
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 10:07:22 +0100 (CET)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62FATam34073613; Mon, 16 Mar 2026 09:07:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=lOUh7n
 YnwFcMhXMxOV9zG0DO11p/lNjAZrQju4jlLY8=; b=kyL5Zxh0bmXvl9I05zkBeu
 l9vtGYZKPp9AjO3WN8m4dYCB0MEdsdCtswmqyDUW4YRh6wMHjrCXcB/I08HkVvvA
 ND/vZYCxIoDE/IXs72yVuW9+xSfD42fXkfRXKQyOXIHpzYUOl/xHLZ73f2FPcnf2
 F5yAgN9lPnQefzfuXMIjq4zfYfzYTBzSEzn7iZd9XxXrr7SE8hFbmDl8+BE/11Lu
 igEPExm/oWCAGGSDYyVzJDO4RbIHLZCNN7Lsj8l/AhogKolV3rlxNpWncwmfygqY
 NLTBE9cEf7htzwkQoQeAunHmIlAReroAT3VvhOMBVQl5npeHbEsY/WTtuKW3yxuA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvy64f3mf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Mar 2026 09:07:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62G4IYK0013997;
 Mon, 16 Mar 2026 09:07:19 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcxv83v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Mar 2026 09:07:19 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62G97HpA18481648
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Mar 2026 09:07:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6BA0A2004B;
 Mon, 16 Mar 2026 09:07:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2CA2A20043;
 Mon, 16 Mar 2026 09:07:17 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown
 [9.111.83.233])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 16 Mar 2026 09:07:17 +0000 (GMT)
Date: Mon, 16 Mar 2026 10:07:15 +0100
From: Jan Polensky <japo@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <abfIQ6V02ujtwc7P@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260314151304.82136-1-japo@linux.ibm.com>
 <20260314151304.82136-3-japo@linux.ibm.com>
 <20260316075637.GA283115@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260316075637.GA283115@pevik>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: s8f2D8izIYqfZahhlAko2Ikj4kgWLZkC
X-Proofpoint-GUID: s8f2D8izIYqfZahhlAko2Ikj4kgWLZkC
X-Authority-Analysis: v=2.4 cv=KYnfcAYD c=1 sm=1 tr=0 ts=69b7c848 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=o9E6Hvx5NsczacpZpb8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA2NiBTYWx0ZWRfX5P/9156gI26r
 QomPaaJfCNhddVEYc9uRklewNfJY33SOGXiOxfhbqOOiisNxZ1/kSr/EGJZQ4cCfwtgVcyiH6vH
 k3zAYENKX0I/8Qpkcvq+PZDYlzMSGO2lKVGbdV1mhCXZ3ZKw2Uu6CWQpnwvvZ21q4DaCfG+4J21
 aYSMRRznmjsfyA+odMRDaCUICuBQQSbCpieMQjyDpLsxfSrUSuSoyuEL8iqSGbd/9Zyfn9UOTzt
 wikq/Lt39HU402deHY7meNoUSDxWeqwmJZaTN/c3t3ppwizMIoy92aOJIBZRGrWJ01nTIZjzwve
 YLDhlTMR3StRSYUMuK+QI7gbW31sVX6etXERkwBsoSh8MxflvRD7gAcn7cvGRqhBry4QhHFV2Qz
 IyfItpzWfOpUA+sWIa4s3JCvoJT7HDYii7+zpwKpb2JlQ47ZINjyJc+KG+U5rbY4zEQ+F+Z+z78
 ZIjFKo2O0Iarqa4VeIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160066
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] setxattr02: Adapt test for kernel 7.1.0+
 socket xattr support
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBNYXIgMTYsIDIwMjYgYXQgMDg6NTY6MzdBTSArMDEwMCwgUGV0ciBWb3JlbCB3cm90
ZToKSGkgUGV0ciwKPiBIaSBKYW4sCj4KPiA+ICAJCXRzdF9icmsoVENPTkYsICJzZXR4YXR0cigy
KSBub3Qgc3VwcG9ydGVkIik7Cj4KPiA+ICsJLyogY29uc2lkZXIga2VybmVscyB3aXRoIGNvbW1p
dCBkYzA4NzZiOTg0NmQgKi8KPiA+ICsJaWYgKCh0c3Rfa3ZlcmNtcCg3LCAxLCAwKSA+PSAwKSAm
JiAoc3RybmNtcCh0Y1tpXS5mbmFtZSwgU09DSywgc3RybGVuKFNPQ0spKSA9PSAwKSkKPiA+ICsJ
CXRjW2ldLmV4cF9lcnIgPSAwOwo+IEknbSBzb3JyeSBJIGhhdmVuJ3QgcG9pbnRlZCBvdXQgaXQg
b24gdjEuCj4KPiAxKSBLZXJuZWwgZGV0ZWN0aW9uIHNob3VsZCBiZSBpbiB0aGUgc2V0dXAgZnVu
Y3Rpb24gKG90aGVyd2lzZSBrZXJuZWwgZGV0ZWN0aW9uCj4gaXMgZG9uZSA3eCwgYnV0IG5lZWRl
ZCBvbmx5IDF4LCBhbmQgd2hlbiBydW4gbW9yZSB0aW1lcyB3aXRoIC1pMTAwMCBpdCdzIGV2ZW4K
PiBtb3JlIHRpbWUgd2FzdGVkKSwgcmVzdWx0IHN0b3JlZCBpbnRvIHN0YXRpYyB2YXJpYWJsZSwg
c2VlOgo+IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdXNlcmZhdWx0ZmQvdXNlcmZhdWx0ZmQw
MS5jCj4KPiAyKSBXaGlsZSBjaGVja2luZyBmaWxlIG5hbWUgd29ya3MsIHdlIHVzdWFsbHkgdHJ5
IHRvIHNvbWVob3cgbW92ZSB0aGUgY2hlY2sgaW50bwo+IHN0cnVjdCB0ZXN0X2Nhc2UuCj4KPiB0
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zpbml0X21vZHVsZS9maW5pdF9tb2R1bGUwMi5jCj4g
ZnVuY3Rpb24gcG9pbnRlciB0byBpbiB0aGUgdGVzdCBzdHJ1Y3QsIGZ1bmN0aW9uIGZpeGVzIHRo
ZSBlcnJubywgY29kZSBydW4gaW4KPiB0aGUgc2V0dXAuCj4KPiBJbiB0aGlzIGNhc2Ugd2hlbiBh
IHNpbmdsZSBjYXNlIHJlcXVpcmVzIGl0LCBJIHdvdWxkIGNvbWJpbmUgdGhlc2UgMiBhcHByb2Fj
aGVzOgo+Cj4gMSkgZGV0ZWN0IGt2ZXIgaW4gdGhlIHNldHVwCj4KPiAjZGVmaW5lIEJFRk9SRV83
XzEgMQo+ICNkZWZpbmUgQUZURVJfN18xIDIKPiBzdGF0aWMgaW50IGt2ZXI7Cj4KPiBzdGF0aWMg
dm9pZCBzZXR1cCh2b2lkKQo+IHsKPiAJLi4uCj4gCWlmICh0c3Rfa3ZlcmNtcCg3LCAxLCAwKSA+
PSAwKQo+IAkJa3ZlciA9IEFGVEVSXzdfMTsKPiAJZWxzZQo+IAkJa3ZlciA9IEJFRk9SRV83XzE7
Cj4gfQo+Cj4gMikgY3VzdG9tIGZ1bmN0aW9uCj4gc3RydWN0IHRlc3RfY2FzZSB7Cj4gCS4uLgo+
IAl2b2lkICgqZml4X2Vycm5vKShzdHJ1Y3QgdGVzdF9jYXNlICp0Yyk7Cj4gfTsKPgo+IHN0YXRp
YyB2b2lkIGZpeF9zb2NrKHN0cnVjdCB0Y2FzZSAqdGMpCj4gewo+IAkvKiBkYzA4NzZiOTg0NmQg
KCJ4YXR0cjogc3VwcG9ydCBleHRlbmRlZCBhdHRyaWJ1dGVzIG9uIHNvY2tldHMiKSAqLwo+IAlp
ZiAoa3ZlciA9PSBBRlRFUl83XzEpCj4gCQl0Y1tpXS5leHBfZXJyID0gMDsKPiB9Cj4KPiBzdGF0
aWMgdm9pZCB2ZXJpZnlfc2V0eGF0dHIodW5zaWduZWQgaW50IGkpCj4gewo+IAlpZiAodGNbaV0u
Zml4X2Vycm5vKQo+IAkJdGNbaV0uZml4X2Vycm5vKCZ0Y1tpXSk7Cj4gCS4uLgo+IH0KPgo+IEFs
c28sIGl0IGhlbHBzIHJldmlld2luZyB3aGVuIHlvdXIgY292ZXIgbGV0dGVyIGNvbnRhaW5zIGNo
YW5nZWxvZy4KPiBPbiBzaW5nbGUgcGF0Y2ggaXQgY2FuIGJlIGFkZGVkIHVuZGVyIC0tLSAoc28g
dGhhdCBpdCdzIG5vdCBwYXJ0IG9mIHRoZSBjb21taXQKPiBtZXNzYWdlLgo+Cj4gS2luZCByZWdh
cmRzLAo+IFBldHIKPiA+ICsKPiA+ICAJLyogc3VjY2VzcyAqLwo+Cj4gPiAgCWlmICghdGNbaV0u
ZXhwX2VycikgewpUaGFuayB5b3UgZm9yIHRoZSBzdWdnZXN0aW9ucywgSSBhcHByZWNpYXRlIHRo
ZW0gYW5kIHdpbGwgdGFrZSB0aGVtIGludG8KYWNjb3VudC4gSeKAmWxsIHNlbmQgYW4gdXBkYXRl
ZCB2ZXJzaW9uIHNvb24uCgpLaW5kIHJlZ2FyZHMsCkphbgoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
