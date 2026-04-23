Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D3BF589D0
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 13:18:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D5DB63E5398
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 15:18:25 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E4953E28DB
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 15:18:06 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 487C11A0079C
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 15:18:04 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63N8ecc43515292; Thu, 23 Apr 2026 13:18:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=YHlaMO
 1qXOh/1543N8nMpSBCUPRBDeTQSL0rICCR6cQ=; b=g+8Je4OLyZl0hVUAc2IjKG
 M/PFTK1an6IOZor0CVuoQ5gMasleQWeog3+JGOz3Rgvh6xpwVWOoGRv/yvRQ3JZs
 gxUidrezy8ChJvXPjuy8Ny5dKZfpqY2JVKue8vykLhgiMbfjPFqdgcSOOihqVwwy
 Nh6qvsLqH9JkwS4l7BBw9d1w2fycllHqJIXmgSK9GR68kKe46Gw/kmanrsVcMRfn
 wZ4J83XaDxlGFQfXfoKZYOQSHET3pMvY4MGTGNP7ZOwgyXS5NT+u6+Lw51IQqarU
 SD/ZWhlwdvUKN1WfE/kKSceh4mpNnq4xS6e9MRVLsBCQcI6RNZn3cHgubveq8LUQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu28tgb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Apr 2026 13:18:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63ND5N9H008897;
 Thu, 23 Apr 2026 13:18:01 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjky6r0s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Apr 2026 13:18:01 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63NDI02W31326798
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2026 13:18:00 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9CEBB5805E;
 Thu, 23 Apr 2026 13:18:00 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3DB1E58051;
 Thu, 23 Apr 2026 13:17:59 +0000 (GMT)
Received: from [9.43.55.56] (unknown [9.43.55.56])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Apr 2026 13:17:58 +0000 (GMT)
Message-ID: <0df5f75d-eb8f-428e-9888-bb7a90a6b1a4@linux.ibm.com>
Date: Thu, 23 Apr 2026 18:47:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20260423112439.69230-1-sachinp@linux.ibm.com>
 <20260423123110.GA447647@pevik>
Content-Language: en-US
From: Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <20260423123110.GA447647@pevik>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEzMiBTYWx0ZWRfX3sJ569Kh57dJ
 dqDnQLRhRXgguBTOSPDsmZ3lbRDv7/xPA58nxqAuDd84FPj9ibxxna4moABdw4FyXWduoBijfd3
 MFfJ6/k6Du9TEiBA3SESFJrG5+a4qD+peoxSbxvnCWm8ZAzGx5MSYTrBzzkUbXSt9VsTJ2bMlWJ
 vFNbadjQFQeBrB+KduVln6qIJRuQhucyuLsv0mZAOHPWVR45zzUN1OMpdVzr38BpBN/6Np8XkLh
 M6hJpP6ym+csdSUxQFEmyM1Vummn3HjLx0odTIXWPgGUw+xHBJuQ5nj2kSOIsh7ZYxD9XTY/NUx
 tOI0qewdpJhU4jQ5caVnVsDFaBklg9Rr+0+/jfCXPekQEVFuPmprMmRIdhveMEMKmBU/RHyn2Tn
 jG3ZVGLR554P3NB6odDgqBAn29M1lwphaF2x0x+ZCj+tEWxrIHIkQln0PYAWKC5mIRbZcfsuG1s
 SxNDxgQ1TlU/smK1hjQ==
X-Proofpoint-ORIG-GUID: O8GlxvypEH56mBmMtqGNe7zbvFq4fPwL
X-Proofpoint-GUID: O8GlxvypEH56mBmMtqGNe7zbvFq4fPwL
X-Authority-Analysis: v=2.4 cv=XMUAjwhE c=1 sm=1 tr=0 ts=69ea1c0a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=Ps5LTd1SL09YHDoOCeYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 priorityscore=1501 impostorscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230132
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] doc: generate CVE reproducer statistics
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

CgpPbiAyMy8wNC8yNiA2OjAxIHBtLCBQZXRyIFZvcmVsIHdyb3RlOgo+IFRoYW5rcyBmb3IgaW1w
bGVtZW50aW5nIHRoaXMuCj4KPiBJJ2QgcHJlZmVyIHRoaXMgdG8gYmUgb24gYSBzZXBhcmF0ZSBw
YWdlIG5hbWVkICJDVkUgUmVwcm9kdWNlcnMiCj4gKE9UOiBJJ2QgYWxzbyBwcmVmZXIgdG8gcmVu
YW1lICJTdGF0aXN0aWNzIiB0byAiU3VwcG9ydGVkIHN5c2NhbGxzIiwgYnV0IHRoYXQncwo+IHNl
cGFyYXRlIHRoaW5nLikKU3VyZSwgd2lsbCBhdHRlbXB0IHRvIGltcGxlbWVudCBpdC4KPgo+IE1v
cmUgbm90ZXM6Cj4KPiAqIEkgc3VwcG9zZSBpdCBzaG91bGRuJ3QgYmUgdG9vIGhhcmQgdG8gZG8g
aXQgc2ltaWxhcmx5IGFzIHdoYXQgd2UgZG8gaW4gdGhlIHRlc3QKPiAgICBjYXRhbG9nIFsxXSwg
aGF2ZSBlYWNoIENWRSBpZCArIG9wdGlvbmFsIGJpbmFyeSBuYW1lIGluIHBhcmVudGhlc2lzIGlu
IHRoZSBtZW51Cj4gICAgb24gdGhlIGxlZnQ6Cj4KPiAJQ1ZFLTIwMjUtMzgyMzYKPiAJLi4uCj4g
CUNWRS0yMDE2LTUxOTUgKGRpcnR5YzB3KQo+IAkuLi4KWWVzLCBhZ3JlZS4gSSB3aWxsIHVzZSB0
aGlzIGZvcm1hdC4KQ1ZFIGlkICsgYmluYXJ5IG5hbWUgaW4gcGFyZW50aGVzaXMgc291bmRzIGJl
dHRlcsKgIGFzIGNvbXBhcmVkIHRvIGJlbG93IApzY2hlbWUuCldpbGwgd2FpdCBmb3IgYWRkaXRp
b25hbCBmZWVkYmFjay4KCj4gICAgT3IsIHdlIGNvdWxkIGhhdmUgdGFibGVzIGJ5IHllYXJzIChp
LmUuIGxlZnQgbWVudSBvbmx5IHllYXJzIHdpdGggY291bnRlZAo+ICAgIG51bWJlciBvZiB0ZXN0
cyBpbiBwYXJlbnRoZXNpcykKPgo+IAkyMDI1ICgyKQo+IAkyMDIzICgzKQo+Cj4gICAgSSBkb24n
dCBoYXZlIGEgc3Ryb25nIHByZWZlcmVuY2UsIHdoaWNoIG9uZSBpcyBiZXR0ZXIuCj4KPiAqIFNv
cnQgYnkgQ1ZFIElEIGRlc2NlbmRpbmcgKG5ld2VzdCBDVkUgb24gdGhlIHRvcCwgcGVvcGxlIGFy
ZSBtb3N0bHkKPiAgICBpbnRlcmVzdGVkIGF0IGN1cnJlbnQgcHJvYmxlbXMgdGhhbiBhYm91dCBo
aXN0b3J5KS4KV2lsbCBpbXBsZW1lbnQgdGhpcyBsb2dpYy4KPiAqIE1heWJlIGxpbmsgdG8gdGhl
IGZpbGUgc2hvdWxkIGJlIGxpbmtlZCB0byB0aGUgdGVzdCBjYXRhbG9nIHBhZ2UgKHdoaWNoIGhh
cwo+ICAgIGFsc28gbGluayB0byB0aGUgdGVzdCBzb3VyY2U/KSwgZS5nLiBbMl0gKGxpbmsgY291
bGQgYmUgcmVsYXRpdmUpLgpTb3VuZHMgbG9naWNhbC4gV2lsbCBtYWtlIHRoZSBjaGFuZ2UuCj4g
KiBUaGUgZGVzY3JpcHRpb24gaXMgbW9zdGx5IHVzZWxlc3MgKG9mdGVuIGp1c3QgQ1ZFIElEIG9y
ICJDVkUgcmVwcm9kdWNlcgo+ICAgIHRlc3QiKSwgbGluayB0byB0aGUgdGVzdCBjYXRhbG9nIHdv
dWxkIGhlbHAuCj4gKiBZZWFyIGlzIHVzZWxlc3MgKHZpc2libGUgZnJvbSBDVkUgSUQpCldpbGwg
ZHJvcCB0aGVzZSBjb2x1bW5zLgo+ICogU29tZSBvZiB0aGUgdGVzdHMgZG9uJ3QgaGF2ZSBsaW5r
IG5vdywgZS5nLiBkaXJ0eWMwdywgc25kX3RpbWVyMDEuCldpbGwgZml4IGl0LgpUaGFua3MgZm9y
IHRoZSByZXZpZXcuCgotLSAKVGhhbmtzCi0gU2FjaGluCgoKCi0tIApNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
