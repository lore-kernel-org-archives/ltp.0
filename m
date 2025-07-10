Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9459C83F09
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 07:43:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AACCB3C627B
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 09:43:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 35BCA3C627B
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 09:43:24 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 64461600732
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 09:43:22 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569NO5ui009230;
 Thu, 10 Jul 2025 07:43:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=a/UV+D
 H+bJbZMeoco859H+8K8ipj5CvHEK2z9mENtsw=; b=BZToQg3f6OvlWGTdRBjnzw
 CFk407JQxZm1/HDYDC3zCFCN1aWKbTE3xC3DylDHD3ipNxAJ6TEDY1EoBA8SfdGc
 H3FHFuCtLx4ulIYiWYm3dicQJ827/kfbMvIszWaTing5Comva8NcuJL7NOVMqUOr
 G18m4orP5WObHpo9qYo9xyXZ6NKKZ1WYdHZHGfA9mOvFLVwgu/ZjxG0IKk4xQQmG
 NFnt4zabQmYhrgzFDwk4IjAWKE/jG7SEalZdSWDh0EEDPwMy+1Em3ezd6bBOWmSu
 5DElHCv+MS1mCYbneaAsAud0ixyBqDH8ggsxnVDjyR6T44Vgs2kLzOPKYwhonk1A
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47svb23pqe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Jul 2025 07:43:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56A5kVdq021519;
 Thu, 10 Jul 2025 07:43:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qectvr14-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Jul 2025 07:43:20 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56A7hIbc8257902
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Jul 2025 07:43:18 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 927DD2004D;
 Thu, 10 Jul 2025 07:43:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 76F592004B;
 Thu, 10 Jul 2025 07:43:18 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown
 [9.155.201.149])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 10 Jul 2025 07:43:18 +0000 (GMT)
Date: Thu, 10 Jul 2025 09:43:17 +0200
From: Jan Polensky <japo@linux.ibm.com>
To: Wei Gao <wegao@suse.com>
Message-ID: <aG9vFbcjhu648vx3@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20250709163022.69985-1-japo@linux.ibm.com>
 <aG_A3DvZ0yRAdWbJ@MiWiFi-CR6608-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aG_A3DvZ0yRAdWbJ@MiWiFi-CR6608-srv>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA2MSBTYWx0ZWRfX93FS3D25NZ1D
 b1iq8fBMb5OTe+e6GYjeXW2d3BVD7Tyq3l+nRtPK1ysOFIYXvQBAPv391fQESXnpTcPnkLW/BJ7
 qrjfU6jLjHyIe26/vmOat8ujPkF+/Rj7b2ZKiT+RgBko2LYZ2Np3aLCM0COSAO7D9wIdZ+fsxCt
 z2qUszMT5m58aHiYk7cJjddclNb+8cRNDuXzXNPlfZI2xW46ZDKCwpfRg6UUOCOLHt8xj4jTm5m
 UmG5lzVFLlHP23YEbGFZV8gOVFOSOUykuL0GjQTNvAejJ8l2VB8e/xLVh30BfADiLDBQ3UCB1Xd
 HxXR+W7hBcvUpPOwumqz59EgwioWonrpM5TRbg6ixQYWuaWO2sR/LtDI8dF3esWo30D3m55SfSD
 1C+Qepqkhd2JALTMS+EVwJzMmPGjBbHRGc7RApn1Y6JrfI4hodVf7xq6FNle2Pu01aQ8epKF
X-Authority-Analysis: v=2.4 cv=Y774sgeN c=1 sm=1 tr=0 ts=686f6f19 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0Ni6rV8TAAAA:8 a=ipqwzSV8Wgpfka_ekeAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=MEv8DOuCJPEGjlO0Qob3:22
X-Proofpoint-ORIG-GUID: HbQ7UsN-eWtS45rWp8-Z9OG5689y09bj
X-Proofpoint-GUID: HbQ7UsN-eWtS45rWp8-Z9OG5689y09bj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 mlxlogscore=984 mlxscore=0
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100061
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH v1 1/1] splice07.c: Skip invalid splice()
 tests involving memfd secret
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

SGkgV2VpLApPbiBUaHUsIEp1bCAxMCwgMjAyNSBhdCAwOTozMjoxMkFNIC0wNDAwLCBXZWkgR2Fv
IHdyb3RlOgo+IE9uIFdlZCwgSnVsIDA5LCAyMDI1IGF0IDA2OjMwOjIyUE0gKzAyMDAsIEphbiBQ
b2xlbnNreSB3cm90ZToKPiA+IExpbnV4IGNvbW1pdCBjYmU0MTM0ZWE0YmMgKCJmczogZXhwb3J0
IGFub25faW5vZGVfbWFrZV9zZWN1cmVfaW5vZGUoKSBhbmQgZml4Cltza2lwXQo+ID4gIAkJY2Fz
ZSBUU1RfRkRfSU5FVF9TT0NLOgo+Cj4gQW5vdGhlciBvcHRpb24gbWF5YmUgd2UgY2FuIGFkZCB0
aGlzIGVycm9yIGludG8gZXhwX2Vycm5vcywgaSBndWVzcyBjYW4KPiBmaXggeW91ciBpc3N1ZT8K
Pgo+IGZvciBleGFtcGxlOgo+ICAgICAgICAgY29uc3QgaW50IGV4cF9lcnJub3NbXSA9IHtFQkFE
RiwgRUlOVkFMfTsKPiArICAgICAgIGNvbnN0IGludCBleHBfZXJybm9zW10gPSB7RUJBREYsIEVJ
TlZBTCwgRUFDQ0VTfTsKPgpJ4oCZbSBjb25jZXJuZWQgdGhhdCB0aGlzIGFwcHJvYWNoIG1pZ2h0
IG1ha2UgdGhlIHRlc3RzIHRvbyB1bnNwZWNpZmljLgoKQXNzb2NpYXRpbmcgc3BlY2lmaWMgY29t
YmluYXRpb25zIHdpdGggY29ycmVzcG9uZGluZyBlcnJvciBjb2RlcyB3b3VsZApwcm92aWRlIG11
Y2ggbW9yZSBwcmVjaXNlIHJlc3VsdHMuIEhvd2V2ZXIsIGdpdmVuIHRoZSB2YXN0IG51bWJlciBv
Zgpwb3NzaWJsZSBjb21iaW5hdGlvbnMsIHN1Y2ggYW4gZWZmb3J0IHNlZW1zIGhhcmRseSBwcmFj
dGljYWwuCj4gPiAtLQo+ID4gMi41MC4wCj4gPgo+ID4KPiA+IC0tCj4gPiBNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKCi0tIApNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
