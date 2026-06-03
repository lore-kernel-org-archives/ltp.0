Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 902EECD6E4A
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 12:50:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 191933E619B
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 14:50:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C6F43E56C9
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 14:49:49 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 74464200774
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 14:49:47 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653AxhcB2242832
 for <ltp@lists.linux.it>; Wed, 3 Jun 2026 12:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=alVZJA
 LNie56Tila8Yejz07qFk6fQTrq/QFPVYR2xHc=; b=nrgWKB7KHVb+yxrXGkniDJ
 2DQB3VoVOtgddKNBfWEwJ+EUc6cjc9DkcCPVWOrWKDy3FnGiU5wxyMik6XeKQzh4
 pZLO5C/hudn6JkoFr/ZWe0aitq2fdSuM8RjhKgA6qABjIPIP6VMmZbHbk8JbXMD2
 nihrOja9wsysZB4Zl1lo/SseON2rEYQ/NNyNntRtPAmfu+Le8fYEIiXRHM7h2JEL
 7QIMKXSxi4YoAV0QT1OsCaUERGHlzAxH9NNrn/1IRPTUOrRv4w5fGupD/Ri58kXJ
 zRKiaBR2T3rbBN+rHGLW7C3wIYWUSEl2KO37Ff35lTgjYy61lKM6BhtnErmUoSww
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqhtaaq4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 03 Jun 2026 12:49:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 653CdD79027528
 for <ltp@lists.linux.it>; Wed, 3 Jun 2026 12:49:46 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqhg3a2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 03 Jun 2026 12:49:45 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 653CnjCO31130264
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Wed, 3 Jun 2026 12:49:45 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5496A58056
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 12:49:45 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B563758061
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 12:49:44 +0000 (GMT)
Received: from [9.43.49.158] (unknown [9.43.49.158])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 12:49:44 +0000 (GMT)
Message-ID: <791d4c27-697a-485f-af79-d851e9ca0856@linux.ibm.com>
Date: Wed, 3 Jun 2026 18:19:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <20260603065744.47106-2-sachinp@linux.ibm.com>
 <20260603094318.4334-1-linuxtestproject.agent@gmail.com>
Content-Language: en-US
From: Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <20260603094318.4334-1-linuxtestproject.agent@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KEddpAczkMu0fBe8HKwAe7ZuYltlmLij
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a2022ea cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=pGLkceISAAAA:8
 a=O0Cn7xWwFZV0RRG_ZCAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEyMCBTYWx0ZWRfX4TgTc6oxZda0
 +ZfbyDdY0ZLkhl4UENSoitUcddFwnjTm4QO9waHZmeS8z6wbeJ8JxrqQgPZ1w/+m++dSy0OnXfm
 nMEnHWBl2N0b7Lgwshz0OLGSV9HjctXFljKJw1bax1DzBXCOJs5frgtECKhzlq5XdS7lAQv7pJW
 oeqvU2YmcCGW7Jla4Bngg8xbVePHNLd4QQ4NdAJ42GXjPBwOaijJcuAYGyI0Wm0mb1i8PHRb7FY
 PzLRQuAcENAnMqRlV8AU+K24zc1y8X4YOqJBOBvaUZMyqu4bFrInG7XMHeU1o9inlPa9RjH+y4y
 BKvOrM4dipT7E8VgX4UFyYLAdotRRVAj/lEp4ArWf+clet2LhWM18llczKFTMoN00BCNBX88mBM
 dw2banuCxc911f//iAqGNN3YVJvzIfnQRUhYTcWSC+MISAPctSewwkq5BHShMdhKmqZEWtpQiPz
 l4yjBVEkXr03iCcQpMg==
X-Proofpoint-ORIG-GUID: KEddpAczkMu0fBe8HKwAe7ZuYltlmLij
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030120
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fs/acl: Add ACL_USER_OBJ permissions test
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

CgpPbiAwMy8wNi8yNiAzOjEzIHBtLCBsaW51eHRlc3Rwcm9qZWN0LmFnZW50QGdtYWlsLmNvbSB3
cm90ZToKPiBbUEFUQ0ggMy84XSBmcy9hY2w6IEFkZCBzeW1saW5rIEFDTCBvcGVyYXRpb25zIHRl
c3QKVGhpcyBzaG91bGQgYmUgUEFUQ0ggNi84IGluIHRoZSBzZXJpZXMuIFRoZSByZXZpZXcgY29t
bWVudHMKYXJlIGNvcnJlY3QuCgpUaGUgY3VycmVudCB0ZXN0IG9ubHkgcHJvdmVzIHRoYXQgYWNs
X3NldF9maWxlKCkgYW5kIGFjbF9nZXRfZmlsZSgpCnN1Y2NlZWQgdGhyb3VnaCB0aGUgc3ltbGlu
ayBwYXRoLCBidXQgaXQgZG9lcyBub3QgdmVyaWZ5IHRoYXQgdGhlCkFDTCB3YXMgYWN0dWFsbHkg
YXBwbGllZCB0byB0aGUgdGFyZ2V0IGZpbGUuIEnigJlsbCB1cGRhdGUgaXQgdG8gcmVhZCB0aGUK
QUNMIGZyb20gYm90aCBURVNUU1lNTElOSyBhbmQgVEVTVEZJTEUsIGFuZCB2ZXJpZnkgdGhlIGV4
cGVjdGVkCmVudHJpZXMvcGVybWlzc2lvbnMgbWF0Y2gu4oCdCgo+IGFjbF9saW5rMDEuYzogVGVz
dCBkb2VzIG5vdCB2ZXJpZnkgd2hhdCBpdCBjbGFpbXMKPgo+ICAgIFRoZSBjb21taXQgbWVzc2Fn
ZSBzYXlzOgo+ICAgICAgImFjbF9zZXRfZmlsZSgpIG9uIGEgc3ltbGluayBzZXRzIEFDTCBvbiB0
aGUgdGFyZ2V0IGZpbGUiCj4KPiAgICBCdXQgdGhlIHRlc3Qgb25seSBjaGVja3MgdGhlIHJldHVy
biB2YWx1ZSBvZiBhY2xfc2V0X2ZpbGUoKSBhbmQKPiAgICBhY2xfZ2V0X2ZpbGUoKSB0aHJvdWdo
IHRoZSBzeW1saW5rIOKAlCBpdCBuZXZlciB2ZXJpZmllcyB0aGF0IHRoZSBBQ0wKPiAgICB3YXMg
YWN0dWFsbHkgc2V0IG9uIFRFU1RGSUxFICh0aGUgc3ltbGluayB0YXJnZXQpLgo+Cj4gICAgVGhl
IHJldHJpZXZlZCBBQ0wgaXMgcmVhZCB0aHJvdWdoIHRoZSBzeW1saW5rIGFuZCB0aGVuIGltbWVk
aWF0ZWx5Cj4gICAgZnJlZWQgd2l0aG91dCBpbnNwZWN0aW5nIGl0cyBjb250ZW50cyBvciBjb21w
YXJpbmcgaXQgd2l0aCB3aGF0IHdhcwo+ICAgIHNldC4gU28gdGhlIGNsYWltIHRoYXQgIkFDTCBv
cGVyYXRpb25zIGZvbGxvdyBzeW1saW5rcyByYXRoZXIgdGhhbgo+ICAgIG9wZXJhdGluZyBvbiB0
aGUgbGluayBpdHNlbGYiIGlzIG5vdCBhY3R1YWxseSBwcm92ZW4uCj4KPiAgICBUbyBwcm9wZXJs
eSB2ZXJpZnkgdGhpcywgYWxzbyBjYWxsIGFjbF9nZXRfZmlsZShURVNURklMRSwgLi4uKSBhbmQK
PiAgICBjb25maXJtIHRoZSBleHBlY3RlZCBlbnRyaWVzIGFyZSBwcmVzZW50LCBvciBhdCBtaW5p
bXVtIGNvbXBhcmUgdGhlCj4gICAgQUNMIHJldHJpZXZlZCB2aWEgdGhlIHN5bWxpbmsgYWdhaW5z
dCB0aGUgQUNMIHJldHJpZXZlZCB2aWEgdGhlCj4gICAgZGlyZWN0IGZpbGUgcGF0aC4KPgo+IC0t
LQoKLS0gClRoYW5rcwotIFNhY2hpbgoKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
