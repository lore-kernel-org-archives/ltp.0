Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B84F9D0D6
	for <ltp@archiver.kernel.org>; Tue, 14 Apr 2026 15:55:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F75D3E5DC4
	for <ltp@archiver.kernel.org>; Tue, 14 Apr 2026 17:55:17 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26A603E2939
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 17:54:59 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3B82E6003BC
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 17:54:57 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63EEITmM1833259
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 15:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=dZZ88B
 gSTzqYUSvTwh4oiqiOYGmJcRv9byDOaWpsybg=; b=DdKOhtSEq0/n1pzF4eRq48
 vK53J+GX39PqijTiAGAnSGh5Gdv9D9Mk9Zld78j+HVRt/9FmEUiDG+MEYKI63nBt
 ZS2oNLzC1Wy0yNF9ssS/6R3FXLKzNAxCalNLWpIS4JUTBK1iC5fAwFK43xO2FjH1
 tLHTJJDfDWTdwg1V6pIYgy2Ctj3SjFjWgJG6ObdzAzk4G+tvKSAvC0F/dwqHUUdJ
 JardcOZhVw8Qb/3Nuth8o0XME+HmmIuJVYjdG3VqN4Y5q1yA/4B6awLT6ANblKEy
 CwheP0Hx7qemmki0fHo6GL9k9mg51nhNTs0sApi8Pxr4SwC5PoFju2njTQdGATTQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89rbmkj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 15:54:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63EDvIAV031099
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 15:54:54 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg10yabkr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 15:54:54 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63EFsoiF46268740
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Apr 2026 15:54:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D192D20043;
 Tue, 14 Apr 2026 15:54:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 97D7320040;
 Tue, 14 Apr 2026 15:54:50 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown
 [9.111.2.172]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 14 Apr 2026 15:54:50 +0000 (GMT)
Date: Tue, 14 Apr 2026 17:54:49 +0200
From: Jan Polensky <japo@linux.ibm.com>
To: Soma Das <somadas1@linux.ibm.com>, ltp@lists.linux.it
Message-ID: <ad5jSSYZJS0FdZva@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <53f26493-09fc-4f8b-9751-24d2c2e80697@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53f26493-09fc-4f8b-9751-24d2c2e80697@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE0OCBTYWx0ZWRfX/ulH+UtUhAIN
 2iCp6I956wvOxzxcZsw4xpIjaELG7JtbcW9M9MT4WtzWeTuFoUt+BHoY/I9ZW1y6PL7iAWF2uro
 3b39W5+SukwwE+kZi3zwt8DfNx+8pr27zSRJBWApvctaQ8Q2bfXm7xR+SXnMmRavhZaCL+4FtWM
 EW5FPqAXHkfB3z0dM77WzFQ3p3y1JQ9ibmJw73Pu2UjmZvprJ4gF6l21+HuhodNJbHQfuT8IkTx
 o+imuUL60AAlAxUjtA8sI8pnxUgkZApvuNObupRYDMJVykHEBPiEtJ+V2nKmPEp9X37JFuH1nmk
 tR6qoc/RDY7YdgmAF/jbJwzyM+UerV3HDUTkQ0bnnEgTk/BJarBF9BZteEh2w/fzNq5BbnDeosm
 y0jsG5/k0MFwRRqLjsPBBzn5z4dX0XrIMd9jpraKiIVNh/VvX+qrYK+M7pg8EzFICu5Sfz9fdqt
 mW7Tla/Uw+D8yXzHyXw==
X-Proofpoint-ORIG-GUID: jbCr8H29153z2SYon1FR_LD0h6-x8rFQ
X-Proofpoint-GUID: jbCr8H29153z2SYon1FR_LD0h6-x8rFQ
X-Authority-Analysis: v=2.4 cv=fYidDUQF c=1 sm=1 tr=0 ts=69de634f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=xtmZHlQmzooOEY0VdzoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140148
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sched_football: fix false failures on many-CPU
 systems
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gU3VuLCBBcHIgMTIsIDIwMjYgYXQgMDY6MzU6NDJQTSArMDUzMCwgU29tYSBEYXMgd3JvdGU6
Cj4gVGVzdCBsb2dzIGF0dGFjaGVkIOKAlCA0MCsgY29uc2VjdXRpdmUgcnVucyBwYXNzaW5nIGFm
dGVyIGZpeCBvbiA4MC1DUFUKPiBwcGM2NGxlIExQQVIuIC0tLQo+IEZyb20gM2ZjMTdkZDA2OTA3
Nzg1ZjViMWI2NWFlYmZlMTUwYzhhYzczZDU0YSBNb24gU2VwIDE3IDAwOjAwOjAwIDIwMDEKPiBG
cm9tOiBTb21hIERhcyA8c29tYWRhczFAbGludXguaWJtLmNvbT4KPiBEYXRlOiBTdW4sIDEyIEFw
ciAyMDI2IDEzOjEzOjA4ICswMDAwCj4gU3ViamVjdDogW1BBVENIXSBzY2hlZF9mb290YmFsbDog
Zml4IGZhbHNlIGZhaWx1cmVzIG9uIG1hbnktQ1BVIHN5c3RlbXMKPiBPbiBsYXJnZSBTTVAgc3lz
dGVtcyB3aXRoIENPTkZJR19SVF9HUk9VUF9TQ0hFRD1uLCBmb3VyIGluZGVwZW5kZW50Cj4gaXNz
dWVzIGNhdXNlIGZhbHNlIGZhaWx1cmVzLgo+IDEuIFJUIHRocm90dGxpbmcgZnJlZXplcyBhbGwg
U0NIRURfRklGTyB0aHJlYWRzIHNpbXVsdGFuZW91c2x5LiBPbgo+IHJlbGVhc2UsIHRoZSBrZXJu
ZWwgZG9lcyBub3QgYWx3YXlzIHJlc2NoZWR1bGUgdGhlIGhpZ2hlc3QtcHJpb3JpdHkKPiB0aHJl
YWQgZmlyc3Qgb24gZXZlcnkgQ1BVLCBzbyBvZmZlbnNlIGJyaWVmbHkgcnVucyBhbmQgaW5jcmVt
ZW50cwo+IHRoZV9iYWxsIGJlZm9yZSBkZWZlbnNlIGlzIHJlc2NoZWR1bGVkLiBGaXggYnkgc2F2
aW5nIGFuZCBkaXNhYmxpbmcKPiBzY2hlZF9ydF9ydW50aW1lX3VzIGluIHNldHVwIGFuZCByZXN0
b3JpbmcgaXQgaW4gYSBuZXcgY2xlYW51cAo+IGNhbGxiYWNrLgo+IDIuIE9mZmVuc2UgYW5kIGRl
ZmVuc2UgdGhyZWFkcyB3ZXJlIHVucGlubmVkLCBhbGxvd2luZyB0aGUgc2NoZWR1bGVyCj4gdG8g
bWlncmF0ZSB0aGVtIGZyZWVseS4gQW4gb2ZmZW5zZSB0aHJlYWQgY291bGQgbGFuZCBvbiBhIENQ
VSB3aXRoCj4gbm8gZGVmZW5zZSB0aHJlYWQgcHJlc2VudCBhbmQgcnVuIHVuY2hlY2tlZC4gRml4
IGJ5IHBhc3NpbmcgYSBDUFUKPiBpbmRleCBhcyB0aGUgdGhyZWFkIGFyZyBhbmQgY2FsbGluZyBz
Y2hlZF9zZXRhZmZpbml0eSgpIGF0IHRocmVhZAo+IHN0YXJ0LiBQYWlycyBhcmUgZGlzdHJpYnV0
ZWQgcm91bmQtcm9iaW4gKGkgJSBuY3B1cykgc28gZWFjaAo+IG9mZmVuc2UgdGhyZWFkIHNoYXJl
cyBpdHMgQ1BVIHdpdGggYSBkZWZlbnNlIHRocmVhZC4KPiAzLiBnYW1lX292ZXIgd2FzIG5ldmVy
IHJlc2V0IGJldHdlZW4gaXRlcmF0aW9ucywgY2F1c2luZyBhbGwgdGhyZWFkcwo+IHRvIGV4aXQg
aW1tZWRpYXRlbHkgb24gcmVydW5zICgtaSBOKSwgbWFraW5nIHRoZSB0ZXN0IGEgbm8tb3AuCj4g
Rml4IGJ5IHJlc2V0dGluZyBib3RoIGtpY2tvZmZfZmxhZyBhbmQgZ2FtZV9vdmVyIGF0IHRoZSB0
b3Agb2YKPiBkb190ZXN0KCkuCj4gNC4gc2NoZWRfc2V0c2NoZWR1bGVyKCkgZmFpbHVyZSBmb3Ig
dGhlIHJlZmVyZWUgd2FzIHNpbGVudGx5IGlnbm9yZWQuCj4gSWYgdGhlIGNhbGwgZmFpbHMgdGhl
IHRlc3QgcHJvZHVjZXMgbWVhbmluZ2xlc3MgcmVzdWx0cy4gRml4IGJ5Cj4gY2hlY2tpbmcgdGhl
IHJldHVybiB2YWx1ZSBhbmQgY2FsbGluZyB0c3RfYnJrKFRCUk9LKSBvbiBmYWlsdXJlLgo+IFNp
Z25lZC1vZmYtYnk6IFNvbWEgRGFzIDxzb21hZGFzMUBsaW51eC5pYm0uY29tPgo+IC0tLQpbc25p
cF0KSGkgU29tYSwKCnRoaXMgcGF0Y2ggbWFrZXMgdGhlIHRlc3QgbXVjaCBtb3JlIGRldGVybWlu
aXN0aWMgYnkgY2hhbmdpbmcgdGhlCnNjaGVkdWxpbmcgc2NlbmFyaW86IG9mZmVuc2UvZGVmZW5z
ZSB3ZXJlIHByZXZpb3VzbHkgdW5waW5uZWQgKHNvIHRoZXkKY291bGQgbWlncmF0ZSBmcmVlbHkp
LCBidXQgYXJlIG5vdyBwaW5uZWQgdmlhIHNjaGVkX3NldGFmZmluaXR5KCkgd2l0aApleHBsaWNp
dCBDUFUgcGFpcmluZyAocm91bmTigJFyb2JpbiBhY3Jvc3MgQ1BVcykuCgpUaGF0IGxpa2VseSBm
aXhlcyB0aGUgZmFsc2UgZmFpbHVyZXMgeW91IGRlc2NyaWJlIChvZmZlbnNlIGJyaWVmbHkKcnVu
bmluZyDigJx1bmNoZWNrZWTigJ0gd2hlbiBpdCBsYW5kcyBvbiBhIENQVSB3aXRob3V0IGEgbG9j
YWwgaGlnaGVy4oCRcHJpbwpkZWZlbnNlKSwgYnV0IGl0IGFsc28gbWVhbnMgd2XigJlyZSBubyBs
b25nZXIgZXhlcmNpc2luZwptaWdyYXRpb24vbG9hZOKAkWJhbGFuY2luZyBiZWhhdmlvciBoZXJl
LgoKV2XigJlyZSBlZmZlY3RpdmVseSB0ZXN0aW5nIGxvY2FsIFNDSEVEX0ZJRk8gcHJpb3JpdHkg
b3JkZXJpbmcgdW5kZXIKY29udHJvbGxlZCBwbGFjZW1lbnQuIEl0IHdvdWxkIGJlIGdyZWF0IHRv
IGNhbGwgdGhpcyBvdXQgZXhwbGljaXRseSBpbgp0aGUgdGVzdCBkZXNjcmlwdGlvbiAvIGNvbW1p
dCBtZXNzYWdlIHNvIHJlYWRlcnMgZG9u4oCZdCBhc3N1bWUgdGhlIHRlc3QKc3RpbGwgY292ZXJz
IG1pZ3JhdGlvbiBmYWlybmVzcy4KClRlc3RlZC1ieTogSmFuIFBvbGVuc2t5IDxqYXBvQGxpbnV4
LmlibS5jb20+CgpUZXN0ZWQgb24gejE2OgoKICAgIFsqKioqKioqKioqKiogfl0jIGxzY3B1CiAg
ICBBcmNoaXRlY3R1cmU6ICAgICAgICAgICAgICAgIHMzOTB4CiAgICAgIENQVSBvcC1tb2RlKHMp
OiAgICAgICAgICAgIDMyLWJpdCwgNjQtYml0CiAgICAgIEJ5dGUgT3JkZXI6ICAgICAgICAgICAg
ICAgIEJpZyBFbmRpYW4KICAgIENQVShzKTogICAgICAgICAgICAgICAgICAgICAgMjU2CiAgICAg
IE9uLWxpbmUgQ1BVKHMpIGxpc3Q6ICAgICAgIDAtMjU1CiAgICBWZW5kb3IgSUQ6ICAgICAgICAg
ICAgICAgICAgIElCTS9TMzkwCiAgICAgIE1vZGVsIG5hbWU6ICAgICAgICAgICAgICAgIC0KICAg
ICAgICBNYWNoaW5lIHR5cGU6ICAgICAgICAgICAgOTE3NQogICAgICAgIFRocmVhZChzKSBwZXIg
Y29yZTogICAgICAyCltzbmlwXQoKQmVzdCByZWdhcmRzCkphbgoKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
