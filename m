Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E850C44501
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 05:09:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E506E3E274F
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 07:09:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5EDE93E26C4
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 07:08:49 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 75657200A10
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 07:08:48 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3n0WI436091; Fri, 10 Jul 2026 05:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ij142f
 A3T20vQ+8Mc09N08Pslsvcb6eZJEg4vm+3PfU=; b=W0VLJP4ycos4nIxF6ghLRB
 riiOjXG94XxkOtGqS15RBIT4ehsPzxKtmaM9+z/t5aJCAEwB1X2f/ZT0TCNPRwL3
 MlsjI1x/xzD5PNxZWLzSug//NzW2UyJbhjpw02/x+dNf8lg378DOigx4V5uT26Y4
 3IXehoIx9Hwid224FukJteAWbJojcywOMrnHHQz8H4CxxVVSFgDCd8U7x6wj/Q5S
 /mH1r0Yr7oYUee18LI/VPKuwssy53V7wUesE1TTarCpJKOZ+2ApIArTukYyeb5U9
 gCmeARFyTgcQLdpahzysM6X6ginKYfHFWS4D5poW/ka4N4YkCGT+omi70sAJG2jw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sur4sys-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jul 2026 05:08:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66A54kGR014562;
 Fri, 10 Jul 2026 05:08:45 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqgg8de-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jul 2026 05:08:45 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66A58j4731523418
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jul 2026 05:08:45 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC7F958052;
 Fri, 10 Jul 2026 05:08:44 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 75A9B58056;
 Fri, 10 Jul 2026 05:08:43 +0000 (GMT)
Received: from [9.43.114.241] (unknown [9.43.114.241])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 10 Jul 2026 05:08:43 +0000 (GMT)
Message-ID: <c76d95ec-6598-450e-8601-b737d3cba0a8@linux.ibm.com>
Date: Fri, 10 Jul 2026 10:38:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.com>
References: <6a4fd5b9.a1b3dc3f.1e550b.63db@mx.google.com>
Content-Language: en-US
From: Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <6a4fd5b9.a1b3dc3f.1e550b.63db@mx.google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA0MSBTYWx0ZWRfX9Ts+VH6AfkOm
 3P8ak6YVvqOHZ48wFz9H1y5MiYcqLxwNlvaO9nlTPHWWkqu6Bm8jUjBCOrx1QI+T1MrFENHrUEq
 3SyfqcpndLkSTnrpUWM9anoUu2lVPmc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA0MSBTYWx0ZWRfX+aD5E16Myv51
 l1wv1SPvnxfvJs2r/+lksjjyE3ki/du/Lg7NeITtXZpwy3hpPnkZBlesMXb8hINobLBRlzPkqsG
 kBhzaa61nZnm7nfJpHGIF6JOkFnijCAzcQMK/lKzgZRdcAK6oaufMYJLKaJDsKnjybb/8k+wKcW
 PmJUFQABhgNe76udQrxEhDwJOz12JD4caDhW9WoejL3tyhqGKE1HHkWRTt3WDoXvapl/E7iBptj
 MLYRgpGamR4OtRhLLdrzGiJy1nR7SrPI4N7KXkz+hGScGAUwU3UNkVhrjuVI+IG6GeG7JlP8ZVA
 OnD7zQPyo+VTIJyvj0R5rGwqLwQX2oJ1QWRd44e6dO5uSfEinK7LekJu4SQHmM0T2ByAVzQrGo1
 UkHztpyXeWOoQHZvvfkt5EZ0Evp9cHQaeZLe5EEDwhIrmDvS8T8Rv0/wT7jPe5QCNyxkZttkZUW
 003h/yw9IRhpr1zLAQw==
X-Proofpoint-GUID: HuJoQUIUKaVAUgLyMbrwDD3d_M2TN-7P
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a507e5e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=gkce6wsvb4QjBB1H8IMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: HuJoQUIUKaVAUgLyMbrwDD3d_M2TN-7P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100041
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] mem/min_free_kbytes: Fix incorrect pass/fail
 accounting
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

CgpPbiAwOS8wNy8yNiAxMDozOSBwbSwgQW5kcmVhIENlcnZlc2F0byB3cm90ZToKPiBIaSBTYWNo
aW4sCj4KPiBJIHRoaW5rIHdpdGggdGhpcyBwYXRjaCB3ZSBhcmUgd29ya2luZyBhcm91bmQgdGhl
IHByb2JsZW0uIFdoaWNoIGlzLi4KPiB0aGUgdGVzdCBpcyBiYWRseSB3cml0dGVuIGFuZCBpdCBu
ZWVkcyBhIGNvbXBsZXRlIHJlZmFjdG9yaW5nLCBzaW5jZQo+IGl0IHNlZW1zIGxpa2UgYSBtaXgg
b2Ygb2xkIGFuZCBuZXcgQVBJLgoKSGkgQW5kcmVhLAoKVGhhbmsgeW91IGZvciB0aGUgZGV0YWls
ZWQgcmV2aWV3LgoKWW91IGFyZSByaWdodCDigJQgdGhlIG9yaWdpbmFsIHBhdGNoIHdhcyBhIHdv
cmthcm91bmQgcmF0aGVyIHRoYW4gYSBwcm9wZXIKZml4LsKgIFRoZSB0ZXN0IHdhcyBtaXhpbmcg
b2xkIGJhcmUtZm9yayBwYXR0ZXJucyB3aXRoIHRoZSBuZXdlciBMVFAgQVBJLAphbmQgcGF0Y2hp
bmcgYXJvdW5kIHRoZSBzeW1wdG9tIHdpdGhvdXQgYWRkcmVzc2luZyB0aGUgc3RydWN0dXJhbCBw
cm9ibGVtCndhcyB0aGUgd3JvbmcgYXBwcm9hY2guCgpJIHdpbGwgcmV3b3JrIHRoZSBwYXRjaCBh
cyBhIGZ1bGwgcmVmYWN0b3IgYWRkcmVzc2luZyBhbGwgcG9pbnRzIHJhaXNlZDoKCjEuIEV4dHJh
Y3QgYSBzZXRfbWluX2ZyZWVfa2J5dGVzKCkgaGVscGVyIHRoYXQgY29uc29saWRhdGVzIHRoZSB0
aHJlZQogwqAgwqB0dW5lLXNlbGVjdGlvbiBjYXNlcyB1c2luZyBhIHN3aXRjaCBzdGF0ZW1lbnQg
YW5kIE1JTigpIGFzIHN1Z2dlc3RlZCwKIMKgIMKgcmVwbGFjaW5nIHRoZSBvcGVuLWNvZGVkIGlm
L2Vsc2UgaWYvZWxzZSBibG9jayBpbiB0ZXN0X3R1bmUoKS4KCjIuIFJlcGxhY2UgYWxsIGJhcmUg
Zm9yaygpIGNhbGxzIHdpdGggU0FGRV9GT1JLKCkgdGhyb3VnaG91dC7CoCBUaGUKIMKgIMKgZWF0
dXBfbWVtIGNoaWxkcmVuIGluIHRlc3RfdHVuZSgpIGFyZSBzdGlsbCB3YWl0ZWQgd2l0aCBTQUZF
X1dBSVRQSUQKIMKgIMKgYW5kIHRoZWlyIGV4aXQgc3RhdHVzIGlzIHN0aWxsIGluc3BlY3RlZCBw
ZXItcG9saWN5LCBiZWNhdXNlCiDCoCDCoG92ZXJjb21taXRfcG9saWN5PTEgZXhwZWN0cyBTSUdL
SUxMIOKAlCBkZWxlZ2F0aW5nIHRob3NlIHRvCiDCoCDCoHRzdF9yZWFwX2NoaWxkcmVuKCkgd291
bGQgaW5jb3JyZWN0bHkgcHJvZHVjZSBUQlJPSyBvbiBhIHZhbGlkCiDCoCDCoG91dGNvbWUuCgoz
LiBEcm9wIHRoZSBTQUZFX1dBSVRQSUQgb24gdGhlIG1vbml0b3IgY2hpbGQgYW5kIGl0cyBzdGF0
dXMgY2hlY2sKIMKgIMKgZnJvbSBtaW5fZnJlZV9rYnl0ZXNfdGVzdCgpIGVudGlyZWx5LsKgIFRo
ZSBtb25pdG9yIGNoaWxkIHJlcG9ydHMgaXRzCiDCoCDCoG93biBUUEFTUy9URkFJTCB2aWEgdHN0
X3JlcygpIGFuZCBhbHdheXMgZXhpdHMgMCwgc28gdGhlIGZyYW1ld29yaydzCiDCoCDCoHRzdF9y
ZWFwX2NoaWxkcmVuKCkgKGNhbGxlZCBhdXRvbWF0aWNhbGx5IGFmdGVyIHRlc3RfYWxsIHJldHVy
bnMpCiDCoCDCoGhhbmRsZXMgaXQgY29ycmVjdGx5IHdpdGhvdXQgYW55IGR1cGxpY2F0ZSBsb2dp
YyBpbiB0aGUgdGVzdC4KCjQuIFJldmlzZSB0aGUgY29tbWl0IG1lc3NhZ2UgdG8gYmUgc2hvcnQg
YW5kIHNlbGYtZXhwbGFuYXRvcnkgd2l0aG91dAogwqAgwqByZS1uYXJyYXRpbmcgdGhlIGRpZmYu
CgpJIHdpbGwgc2VuZCBhIHYzIHdpdGggdGhlIGNoYW5nZXMgaW5jbHVkZWQuCgotLSAKVGhhbmtz
Ci0gU2FjaGluCgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
