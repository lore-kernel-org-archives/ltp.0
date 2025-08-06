Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323B8C87FD1
	for <ltp@archiver.kernel.org>; Wed,  6 Aug 2025 11:39:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 913E13C8239
	for <ltp@archiver.kernel.org>; Wed,  6 Aug 2025 13:39:23 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 25E623C6B03
 for <ltp@lists.linux.it>; Wed,  6 Aug 2025 13:39:05 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AECA71A0065F
 for <ltp@lists.linux.it>; Wed,  6 Aug 2025 13:39:04 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5766tPgG019724;
 Wed, 6 Aug 2025 11:39:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=cCZFy0
 ERv7eyF5RetPJokIFex+G+w+HH6DQ7yoHEKkM=; b=Ac5JF9qgYNBGNsVs8ocWBI
 2bYRUtThZH6KretacRkh9HSNkUM1BFLrqPPiMOz2aItWwSoJ2X8nQSUmk7E+MWo6
 nB02gVloLDn9B7SOlHuzcTILDWVViP7uucgnRiLp2RwBelbux1/Rl/NnZC7SwkVm
 AiTVuvhzyewX+wfnfvfY3qzjFvL3/HtZ/VhSYSBzjXgCNwEoLa3gTTWmEV6cVs8U
 D5TDruMqNvt8j30VXWF+C24gH1zbR1lmGTjeR0ubXJ0+u1zJqeNCmYIyv03CXsCl
 gOHJZHh7w8Q3N/uklRz+3NQfjdE0puS696o0b7jhMLG7rVyhe4LaN4aXI/y0XQmg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48c26ts64n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Aug 2025 11:39:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57680TqC022668;
 Wed, 6 Aug 2025 11:39:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwqbcgm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Aug 2025 11:39:00 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 576BcwjW39256370
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 6 Aug 2025 11:38:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B44E720043;
 Wed,  6 Aug 2025 11:38:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5CD7120040;
 Wed,  6 Aug 2025 11:38:58 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown
 [9.111.31.74]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  6 Aug 2025 11:38:58 +0000 (GMT)
Date: Wed, 6 Aug 2025 13:38:56 +0200
From: Jan Polensky <japo@linux.ibm.com>
To: Cyril Hrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>
Message-ID: <aJM-0KFggiNjfLsL@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20250729132731.57978-1-japo@linux.ibm.com>
 <20250805115208.GA272913@pevik> <aJHxrKfuiCcPXnXV@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aJHxrKfuiCcPXnXV@yuki.lan>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Pbhra-1KRNI_VgRLZT4bVhTVxypCFhdD
X-Authority-Analysis: v=2.4 cv=F/xXdrhN c=1 sm=1 tr=0 ts=68933ed6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=voM4FWlXAAAA:8 a=lAbSyxPQ_tUehgIl-2wA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-GUID: Pbhra-1KRNI_VgRLZT4bVhTVxypCFhdD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA3MSBTYWx0ZWRfXzeCpHBuX/FxD
 hZaaGoaNmq9j6+P3woJQKvVqh62sSPssN4xFyDCD7bo5RuhFuV4N0lAltzBwG3Sa70Xpj/lM/S4
 yHX5Penw0uyG6EzqHr8gH+w46w9n8sft3TcW2fEt+VVNE0EJSxcHmd1YXuCkfos5v4cQnXgPfOc
 Vt3mkerHO3gKeSA61NOxCJQmgncJPhe1Ln6B+QenIAkHox+AjDOo0PSkrqbgCJ/uPWVX6nY74BV
 WU80uUR14HOzHBnbydzqWMSQYj5LGaGKxyPpErp5LP79RMwywO+ZEZMcs68X5ihStkUUGnlzcMX
 Yhh2lPnqtPEJd+RHHga+stpKO9KPCoyjilhdkxLrDRjqKvJ1P97WnBHvzPs2ZGUoR+uJ+pAdScg
 B5734op+DLhSzKO6/YvkpXe+LBiq41KJAo5rFkLDC4yGN/9T76KkPEgSWoRnFt/6gGGcLsCD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 spamscore=0 bulkscore=0 adultscore=0 mlxlogscore=774
 malwarescore=0 phishscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060071
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/1] safe_macros.c: Fix missing ro flag for
 FUSE mounts
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

T24gVHVlLCBBdWcgMDUsIDIwMjUgYXQgMDE6NTc6MzJQTSArMDIwMCwgQ3lyaWwgSHJ1YmlzIHdy
b3RlOgo+IEhpIQo+IEkndmUgYWN0dWFsbHkgc2VuZCBhIHNpbWlsYXIgcGF0Y2ggc2luY2UgSmFu
IHdhc24ndCByZXNwb25kaW5nOgo+Cj4gaHR0cDovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2pl
Y3QvbHRwL3BhdGNoLzIwMjUwNjMwMTIyNzE5LjEyOTQ4LTEtY2hydWJpc0BzdXNlLmN6Lwo+Cj4g
VGhhdCBqdXN0IGFkZHMgJy1vIHJvJyBvciAnJyBhcyAnJXMnIHRvIHRoZSBvcmlnaW5hbCBmb3Jt
YXQuCj4KPiAtLQo+IEN5cmlsIEhydWJpcwo+IGNocnViaXNAc3VzZS5jegpXaGF0IG1hdHRlcnMg
bW9zdCBpcyB0aGF0IHRoZSBpc3N1ZSBnZXRzIHJlc29sdmVkLiBJ4oCZZCBiZSB2ZXJ5IGdyYXRl
ZnVsCmlmIGEgZml4IGNvdWxkIGJlIG1hZGUgYXZhaWxhYmxlIGluIHRoZSBuZWFyIGZ1dHVyZS4K
ClRoYW5rcyBhZ2FpbiBmb3IgdGhlIGhlbHBmdWwgaW5wdXQgYW5kIGJlc3QgcmVnYXJkcyEKSmFu
CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8v
bHRwCg==
