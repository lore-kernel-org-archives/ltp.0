Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07517C88E71
	for <ltp@archiver.kernel.org>; Mon, 14 Sep 2026 11:04:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0234E3E90AC
	for <ltp@archiver.kernel.org>; Mon, 14 Sep 2026 13:04:08 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8EB0F3E48AE
 for <ltp@lists.linux.it>; Mon, 14 Sep 2026 13:03:51 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AD3661000929
 for <ltp@lists.linux.it>; Mon, 14 Sep 2026 13:03:50 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EA1Sv51721055
 for <ltp@lists.linux.it>; Mon, 14 Sep 2026 11:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=7Iaqyj
 ywaweTDCtuQlcFBs0fN7nHJLMd+Ac8wriwK6g=; b=V5bti1eTVT2nRhHydFvvbD
 Cgtp31Nz09xCTV2sszLu8lPZZpsXqHC5/yAfH8rCORcuQmklTgou1/5OO1hRCC/X
 tmoV/86tTtdhzlEtkbTe+ZCWkXdBjuCe+ekHjkCC1ZuyBVH1uaHPSBrMqS9fvSNk
 m9QJkqt8yNtJA5WFk8cPjOUng4LAsqV/LDuc2Lej8MiJSxZGjhltaUUqv6mJyyzI
 OFPl7g7gMJ54KglYdNysy2YErX4+Hv4speFjRtbwA1nlnA8iQzzFqH6VWA6XPWRa
 kwfhMpPrIAsiCQH+LzFVuhiaHwwNDLnFlQPYkYiIlfuLrL3L4wj/0yU5OgrPDHYA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf4rvnk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 11:03:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E9o3Vq2106284; Mon, 14 Sep 2026 11:03:47 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gnh2pwr3p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 11:03:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68EB3jDj25821750
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Sep 2026 11:03:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 787C42004B;
 Mon, 14 Sep 2026 11:03:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6505020043;
 Mon, 14 Sep 2026 11:03:45 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown
 [9.224.74.129])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 14 Sep 2026 11:03:45 +0000 (GMT)
Date: Mon, 14 Sep 2026 13:03:44 +0200
From: Jan Polensky <japo@linux.ibm.com>
To: linuxtestproject.agent@gmail.com
Message-ID: <aqfUkKvMbCabQCIt@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260908165430.251897-2-japo@linux.ibm.com>
 <20260908182629.3920-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260908182629.3920-1-linuxtestproject.agent@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: PeLYbrdmWBq8Ut_3IDMa7E29-SihMk8g
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE1NiBTYWx0ZWRfX5dQeqxXmHLtJ
 OOKH4LZoWRmlpqwvCwapy5dMiUP8hzsk2fDusKnKcZ44DCzRanzw2de9j+3cDpDearp5ht/itlE
 HO+VxDfGLEBbrBT/lqqUeja2dVZQxCA=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aa7d494 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=Lv99VKi5aH0OhHgg0IEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: JGalYfyiKYyRr1ztMp2L0vas95sl1Hx8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE1NiBTYWx0ZWRfXzS+9myQm4es1
 tk54qQzQP69dIosuXZpm80XwG0VTUEU+YKA0cy3T90fkoELL2zMCUT+uiZ1eofugvVASFXES6+3
 mhJkx2OJ/GO7bBwpCBjYt9ev84pyEp86hdmVgAFETYDLiOaZzjMg9ML1HVQvd1D0CsBhi4OD+G0
 b5fcjgrKzMQz8y6vsIMhutM3UfDjhM8PNzFkZiBgl980eU+Cppc8G5g+eK3zEm+JnmtjaIqPuQ0
 DuRPMu2AB3iE/icn6RGL9mAEFdo3uAnsogWiaINKzvRf00o/NCWmStXHiz6+4KeCvD68+wZCwHc
 lFxlkl6E+JLV4xFaQN8suXb9OZk/ADZ9z8mGREulHHEFSaEmzOt8RaovKSH4cfpTLry6gX4K/AD
 QCKWqRzd3Z1JGS2zZEcyveC1ilgV/VNbhRnPvuWaeb0OkUCZh9xUTbCLYH6yX2N2BtD+ljEaZ7q
 4rCd6NHsUg44RiASwBA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140156
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] thp04: group runtime state and skip when /proc/self/mem
 writes are blocked
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBTZXAgMDgsIDIwMjYgYXQgMDY6MjY6MjlQTSArMDAwMCwgbGludXh0ZXN0cHJvamVj
dC5hZ2VudEBnbWFpbC5jb20gd3JvdGU6Cj4gSGkgSmFuLAo+Cj4gT24gVHVlIFNlcCA4IDE4OjU0
OjI4IDIwMjYgKzAyMDAsIEphbiBQb2xlbnNreSA8amFwb0BsaW51eC5pYm0uY29tPiB3cm90ZToK
PiA+IHRocDA0OiBncm91cCBydW50aW1lIHN0YXRlIGFuZCBza2lwIHdoZW4gL3Byb2Mvc2VsZi9t
ZW0gd3JpdGVzIGFyZSBibG9ja2VkCj4KPiAtLS0gW1BBVENIIDMvM10gLS0tCj4KPiA+ICsJZm9y
IChpID0gMDsgaSA8IFRFU1RfSVRFUkFUSU9OUzsgaSsrKSB7Cj4gPiArCQlpZiAoKnNoYXJlZC0+
dGVzdF9wdHIgIT0gc2hhcmVkLT5leHBlY3RlZF92YWwpIHsKPiA+ICsJCQl0c3RfcmVzKFRGQUlM
LAo+ID4gKwkJCQkiSXRlcmF0aW9uICVkOiBleHBlY3RlZCAweCV4LCBnb3QgMHgleCIsCj4gPiAr
CQkJCWksIHNoYXJlZC0+ZXhwZWN0ZWRfdmFsLCAqc2hhcmVkLT50ZXN0X3B0cik7Cj4gPiArCQkJ
ZXhpdCgxKTsKPiA+ICsJCX0KPiA+ICsKPiA+ICsJCWlmIChpIDwgVEVTVF9JVEVSQVRJT05TIC0g
MSkKPiA+ICsJCQlyYWlzZShTSUdTVE9QKTsKPiA+ICsJfQo+Cj4gVGhlIGNvbmRpdGlvbiBpIDwg
VEVTVF9JVEVSQVRJT05TIC0gMSBwcmV2ZW50cyB0aGUgdHJhY2VlIGZyb20gc3RvcHBpbmcgb24K
PiB0aGUgbGFzdCBpdGVyYXRpb24sIGNhdXNpbmcgaXQgdG8gZXhpdCBpbW1lZGlhdGVseS4gVGhl
IHBhcmVudCdzIHdhaXRwaWQKPiBzZWVzIFdJRkVYSVRFRCBhbmQgYWJvcnRzIHdpdGggdHN0X2Jy
ayhUQlJPSykuIENhbGwgcmFpc2UoU0lHU1RPUCkKPiB1bmNvbmRpdGlvbmFsbHkgb24gYWxsIGl0
ZXJhdGlvbnMuCj4KPiA+ICtzdGF0aWMgdm9pZCBydW4odm9pZCkKPiA+ICt7Cj4gPiArCWNoYXIg
cGF0aFs2NF07Cj4KPiBEbyBub3QgdXNlIGEgY3VzdG9tIGJ1ZmZlciBzaXplIGZvciBmaWxlc3lz
dGVtIHBhdGhzLiBVc2UgUEFUSF9NQVggZnJvbQo+IDxsaW1pdHMuaD4uCj4KPiBWZXJkaWN0IC0g
TmVlZHMgcmV2aXNpb24KPgo+IC0tLQo+IE5vdGU6Cj4KPiBUaGUgYWdlbnQgY2FuIHNvbWV0aW1l
cyBwcm9kdWNlIGZhbHNlIHBvc2l0aXZlcyBhbHRob3VnaCBvZnRlbiBpdHMKPiBmaW5kaW5ncyBh
cmUgZ2VudWluZS4gSWYgeW91IGZpbmQgaXNzdWVzIHdpdGggdGhlIHJldmlldywgcGxlYXNlCj4g
Y29tbWVudCB0aGlzIGVtYWlsIG9yIGlnbm9yZSB0aGUgc3VnZ2VzdGlvbnMuCj4KPiBSZWdhcmRz
LAo+IExUUCBBSSBSZXZpZXdlcgoKSGkgdGhlcmUsCgpGaW5kaW5nIDEg4oCUIHJhaXNlKFNJR1NU
T1ApIG9uIGxhc3QgaXRlcmF0aW9uOiBmYWxzZSBwb3NpdGl2ZQpUaGUgY29uZGl0aW9uIGlmIChp
IDwgVEVTVF9JVEVSQVRJT05TIC0gMSkgcmFpc2UoU0lHU1RPUCkgaW4gcHRyYWNlMTMuYwppcyBp
bnRlbnRpb25hbCBhbmQgY29ycmVjdC4gVGhlIHBhcmVudCdzIHdhaXRwaWQgYWZ0ZXIgUFRSQUNF
X0NPTlQgb24KdGhlIGxhc3QgaXRlcmF0aW9uIGV4cGxpY2l0bHkgaGFuZGxlcyBXSUZFWElURUQg
YXMgYSB2YWxpZCB0ZXJtaW5hbApjb25kaXRpb24sIHRoZSBjaGlsZCBleGl0cyB2aWEgZXhpdCgw
KSBhbmQgdGhlIHBhcmVudCBmYWxscyB0aHJvdWdoIHRvClRQQVNTLiBNYWtpbmcgdGhlIHN0b3Ag
dW5jb25kaXRpb25hbCB3b3VsZCBjYXVzZSB0aGUgY2hpbGQgdG8gc3RvcCBvbiB0aGUKbGFzdCBp
dGVyYXRpb24sIGF0IHdoaWNoIHBvaW50IHRoZSBwYXJlbnQgd291bGQgc2VuZCBQVFJBQ0VfREVU
QUNIICsKU0lHVEVSTSB0byBhIHN0b3BwZWQgdHJhY2VlLCB3aGljaCBpcyB0aGUgYWN0dWFsIGJ1
Zywgbm90IHRoZSBmaXguCgpGaW5kaW5nIDIg4oCUIFBBVEhfTUFYOiBhY2NlcHRlZCBhbmQgYXBw
bGllZApUaGUgY2hhciBwYXRoWzY0XSBzdWdnZXN0aW9uIGlzIHZhbGlkLgoKQmVzdCBSZWdhcmRz
CkphbgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
