Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5B6C282C6
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 20:11:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4AEB03C9F03
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 21:11:43 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA41F3C98C9
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 21:11:25 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=hca@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 10820237003
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 21:11:24 +0100 (CET)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SGTHrv031271;
 Fri, 28 Feb 2025 20:11:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=SAqjea
 exf6+BbWfCUMnASLfVxTYCdm/s5Zm9m5dloDs=; b=i6fbvaEKMb/tu5Y4Wzd69O
 BhG2L7fO7xGIIsXKBSduDBegWKxNzvRTC5QPdGAJnV3ThZcwyG6/x2irBfEGyYso
 Ii08VMHI34XSRBHOP9j0C2IJFRwztefSr2i5JfFxliakMqaJsgSurJFFFj1ViwR7
 KhoNF/5oBpzYL0yMyNN0IZODfSqK6NUmIU2RWq5eZq3GH9AAhHJoZBdLAFPRG+MC
 zAe1BQwEUlTcKrk1O6iHVF1/FcGl41tLSzxzk5AR0Vqre8lJUGpsSLbrYP5SBNUL
 iW9a55hC9aJOa5kGdrRLiomIvLikEbAINVnwWXIXTq29oSZNTYo1sLDAV3tFEzAA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4537v6kw01-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Feb 2025 20:11:22 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51SKBMwQ027063;
 Fri, 28 Feb 2025 20:11:22 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4537v6kvyv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Feb 2025 20:11:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51SHMJUU026274;
 Fri, 28 Feb 2025 20:11:21 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44yswp0fmd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Feb 2025 20:11:21 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51SKBJiO50135506
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Feb 2025 20:11:19 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E11320043;
 Fri, 28 Feb 2025 20:11:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 42E1D20040;
 Fri, 28 Feb 2025 20:11:19 +0000 (GMT)
Received: from osiris (unknown [9.179.22.205])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 28 Feb 2025 20:11:19 +0000 (GMT)
Date: Fri, 28 Feb 2025 21:11:17 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20250228201117.11519A64-hca@linux.ibm.com>
References: <20250210151316.246079-1-amir73il@gmail.com>
 <20250210151316.246079-4-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250210151316.246079-4-amir73il@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JWwNBacUIEReik3nRqRea1dUHbMsngQx
X-Proofpoint-GUID: OJxiGpECEc0xX-NIvI3I7VJJ-ecIgyVy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_06,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 mlxlogscore=984 mlxscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502280144
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/4] fanotify24: Add test for FAN_PRE_ACCESS and
 FAN_DENY_ERRNO
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBGZWIgMTAsIDIwMjUgYXQgMDQ6MTM6MTVQTSArMDEwMCwgQW1pciBHb2xkc3RlaW4g
d3JvdGU6Cj4gRm9yayB0aGUgdGVzdCBmYW5vdGlmeTI0IGZyb20gdGVzdCBmYW5vdGlmeTAzLCBy
ZXBsYWNpbmcgdGhlCj4gcGVybWlzc2lvbiBldmVudCBGQU5fQUNDRVNTX1BFUk0gd2l0aCB0aGUg
bmV3IHByZS1jb250ZW50IGV2ZW50Cj4gRkFOX1BSRV9BQ0NFU1MuCj4gCj4gVGhlIHRlc3QgaXMg
Y2hhbmdlZCB0byB1c2UgY2xhc3MgRkFOX0NMQVNTX1BSRV9DT05URU5ULCB3aGljaCBpcwo+IHJl
cXVpcmVkIGZvciBGQU5fUFJFX0FDQ0VTUyBhbmQgdGhpcyBjbGFzcyBhbHNvIGVuYWJsZWQgdGhl
IHJlc3BvbnNlCj4gd2l0aCBjdXRvbWVyIGVycm9yIGNvZGUgRkFOX0RFTllfRVJSTk8uCj4gCj4g
VW5saWtlIEZBTl9BQ0NFU1NfUEVSTSwgRkFOX1BSRV9BQ0NFU1MgaXMgYWxzbyBjcmVhdGVkIG9u
IHdyaXRlKCkKPiBzeXN0ZW0gY2FsbC4gIFRoZSB0ZXN0IGNhc2UgZXhwZWN0ZWQgcmVzdWx0cyBh
cmUgYWRqdXN0ZWQgdG8KPiByZXNwb25kIHdpdGggdGhlIGRlZmF1bHQgZXJyb3IgKEVQRVJNKSB0
byBvcGVuKCkgYW5kIHdyaXRlKCkgYW5kCj4gdG8gcmVzcG9uZCB3aXRoIGN1c3RvbSBlcnJvcnMg
KEVJTywgRUJVU1kpIHRvIHJlYWQoKSBhbmQgZXhlY3ZlKCkuCj4gCj4gTm90IGFsbCBmcyBzdXBw
b3J0IHByZS1jb250ZW50IGV2ZW50cywgc28gcnVuIG9uIGFsbCBmaWxlc3lzdGVtcwo+IHRvIGV4
Y2VyY2lzZSBGQU5fUFJFX0FDQ0VTUyBvbiBhbGwgc3VwcG9ydGVkIGZpbGVzeXN0ZW1zLgo+IAo+
IFNpZ25lZC1vZmYtYnk6IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+Cj4gLS0t
Cj4gIGluY2x1ZGUvbGFwaS9mYW5vdGlmeS5oICAgICAgICAgICAgICAgICAgICAgICB8ICAgNyAr
Cj4gIHJ1bnRlc3Qvc3lzY2FsbHMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSAr
Cj4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvLmdpdGlnbm9yZSB8ICAgMSAr
Cj4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkuaCB8ICAgMyAr
Cj4gIC4uLi9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkyNC5jICAgICB8IDQzMyAr
KysrKysrKysrKysrKysrKysKPiAgNSBmaWxlcyBjaGFuZ2VkLCA0NDUgaW5zZXJ0aW9ucygrKQo+
ICBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9m
YW5vdGlmeTI0LmMKPiAKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9sYXBpL2Zhbm90aWZ5LmggYi9p
bmNsdWRlL2xhcGkvZmFub3RpZnkuaAo+IGluZGV4IGU1YjkzMGY0ZS4uOTA3NjY4NWU4IDEwMDY0
NAo+IC0tLSBhL2luY2x1ZGUvbGFwaS9mYW5vdGlmeS5oCj4gKysrIGIvaW5jbHVkZS9sYXBpL2Zh
bm90aWZ5LmgKPiBAQCAtMTI0LDYgKzEyNCwxMyBAQAo+ICAjZGVmaW5lIEZBTl9FUElERkQJCS0y
Cj4gICNlbmRpZgo+ICAKPiArLyogZXJybm8gb3RoZXIgdGhhbiBFUEVSTSBjYW4gc3BlY2lmaWVk
IGluIHVwcGVyIGJ5dGUgb2YgZGVueSByZXNwb25zZSAqLwo+ICsjaWZuZGVmIEZBTl9ERU5ZX0VS
Uk5PCj4gKyNkZWZpbmUgRkFOX0VSUk5PKGVycikgKCgoKChfX3UzMikoZXJyKSkgJiAweGZmKSA8
PCAyNCkpCj4gKyNkZWZpbmUgRkFOX0RFTllfRVJSTk8oZXJyKSAoRkFOX0RFTlkgfCBGQU5fRVJS
Tk8oZXJyKSkKPiArI2RlZmluZSBGQU5fUkVTUE9OU0VfRVJSTk8ocmVzKSAoKGludCkoKHJlcykg
Pj4gMjQpKQo+ICsjZW5kaWYKPiArCgpUaGlzIGRvZXMgbm90IHdvcmsgd2l0aCBsYXRlc3QrZ3Jl
YXRlc3Qga2VybmVsIGhlYWRlcnMgc2luY2UgdGhlcmUKRkFOX0RFTllfRVJSTk8gaXMgZGVmaW5l
ZCBidXQgRkFOX1JFU1BPTlNFX0VSUk5PIGlzIG5vdC4gVGhlcmVmb3JlCnRoaXMgZW5kcyB1cCBp
biBhIGNvbXBpbGUgZXJyb3I6CgpmYW5vdGlmeTI0LmM6IEluIGZ1bmN0aW9uIOKAmGV4cGVjdGVk
X2Vycm5v4oCZOgpmYW5vdGlmeTI0LmM6MTY2OjI0OiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRp
b24gb2YgZnVuY3Rpb24g4oCYRkFOX1JFU1BPTlNFX0VSUk5P4oCZOyBkaWQgeW91IG1lYW4g4oCY
RkFOX0RFTllfRVJSTk/igJk/IFstV2ltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogIDE2
NiB8ICAgICAgICAgICAgICAgICByZXR1cm4gRkFOX1JFU1BPTlNFX0VSUk5PKHJlc3BvbnNlKTsK
ICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fgogICAgICB8
ICAgICAgICAgICAgICAgICAgICAgICAgRkFOX0RFTllfRVJSTk8KCkZXSVcsIGNvbnZlcnRpbmcg
dGhlIGFib3ZlIHRvOgoKLyogZXJybm8gb3RoZXIgdGhhbiBFUEVSTSBjYW4gc3BlY2lmaWVkIGlu
IHVwcGVyIGJ5dGUgb2YgZGVueSByZXNwb25zZSAqLwojaWZuZGVmIEZBTl9ERU5ZX0VSUk5PCiNk
ZWZpbmUgRkFOX0VSUk5PKGVycikgKCgoKChfX3UzMikoZXJyKSkgJiAweGZmKSA8PCAyNCkpCiNk
ZWZpbmUgRkFOX0RFTllfRVJSTk8oZXJyKSAoRkFOX0RFTlkgfCBGQU5fRVJSTk8oZXJyKSkKI2Vu
ZGlmCgojaWZuZGVmIEZBTl9SRVNQT05TRV9FUlJOTwojZGVmaW5lIEZBTl9SRVNQT05TRV9FUlJO
TyhyZXMpICgoaW50KSgocmVzKSA+PiAyNCkpCiNlbmRpZgoKd29ya3MgZm9yIG1lLgoKLS0gCk1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
