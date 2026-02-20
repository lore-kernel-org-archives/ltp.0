Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4CC9C56201
	for <ltp@archiver.kernel.org>; Fri, 20 Feb 2026 15:06:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 20B343D03DC
	for <ltp@archiver.kernel.org>; Fri, 20 Feb 2026 16:06:28 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C653F3D0892
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 16:05:56 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D1FA1600AD1
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 16:05:55 +0100 (CET)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61KEYtWN1294756; Fri, 20 Feb 2026 15:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=G86iiQ
 WJwC1muUNEQbyHlndJQ50fHWGx5srk28JhLaA=; b=RsUVIWtxq071EU1Bgwx5xf
 tO2cAmGQwaIXG5gmH1LexVKG3MzeKtgRegEktAPYO21/X6Mk6og5YXW4p1psyrL6
 gizXvcLfE96wwlFsYmSqc59oIWUIV/AhQoY9myc6rF7vxOJZE8O/BiLU6gRpd/ec
 txyXXWKv+t7GM7/InA/Gb3GbSORZmXI2C8lJLJCJRgh8zlPy+xMoGsjOJb6UEA3y
 XGTrdwXVJl/mu2KkEsSUJ+vps5dBpd6if3MOrnREzoKsFPP/lJ/MUao4jVLQF80o
 5g+0gVoNWVFCaAPJBS76GHGm5MHy2WhfXyR54CePKe0la2xmv4UHtpurWYpQp3GA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj64j3ud-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Feb 2026 15:05:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61KEXkh9030217;
 Fri, 20 Feb 2026 15:05:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb45gu2k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Feb 2026 15:05:52 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61KF5pOJ31064494
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Feb 2026 15:05:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D1FC20049;
 Fri, 20 Feb 2026 15:05:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D9F612004E;
 Fri, 20 Feb 2026 15:05:50 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown
 [9.111.48.185])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 20 Feb 2026 15:05:50 +0000 (GMT)
Date: Fri, 20 Feb 2026 16:05:49 +0100
From: Jan Polensky <japo@linux.ibm.com>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <aZh4TbAp6_mCMkbP@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260219163030.69022-1-japo@linux.ibm.com>
 <aZg8FeATSABAhBfw@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aZg8FeATSABAhBfw@yuki.lan>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qPtQz_KQz8W2P0z_5NBRUymdEjdBMLlM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDEyOCBTYWx0ZWRfX0irwFFG06HP4
 pBmZ1UARNi6N28Gclgq38L0JuKE7cdcsU7qdH3OX1PVkkmc52DKhilRc6UkQsnyfMzOd8B3ruAE
 U4vMhTM50QbRtzlNXbqRBpzjXVzT3zWplOVkzBbLmODsFZ+Uydkalepig66bcgLYfVwApHYEEc8
 c0508W46b7hxYT5mSkpfMtCO1grgO+YO3OXT5FiXLDCkFSBOexIxu/aSjKeQdV3W5woObevnPbG
 ++dneP+YUNyJOs6xmL+YLc9swsKcnCBU9XF/6XNqM4YC7S+l6edJVlj0ypZrH9bAma1WVKSV7ou
 w8M0GVQrDPvL0gwuOGprCzqAV0L24eHFkaizmhGGIFBhZiWFGV/Xb59rg2b2YgmKZQIPfEHdGlW
 gqC+tkfQe2ln2o2JqJHU5iCZB7V5ydUF9pT0NUI/UF1jpolzmPo2BVplVrf4oTUs+BgprKCl/KV
 PTP0OAzM4J3QbN9NaAA==
X-Proofpoint-GUID: qPtQz_KQz8W2P0z_5NBRUymdEjdBMLlM
X-Authority-Analysis: v=2.4 cv=U+mfzOru c=1 sm=1 tr=0 ts=69987851 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=4RvkmL-UwT3zVJuuy60A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_01,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602200128
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] [STAGING] ioctl_pidfd06: accept
 EREMOTE/ESRCH for PIDFD_GET_INFO across pidns
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

T24gRnJpLCBGZWIgMjAsIDIwMjYgYXQgMTE6NDg6NTNBTSArMDEwMCwgQ3lyaWwgSHJ1YmlzIHdy
b3RlOgo+IEhpIQo+ID4gUElERkRfR0VUX0lORk8gc2VtYW50aWNzIGNoYW5nZWQgZm9yIHBpZGZk
cyByZWZlcnJpbmcgdG8gdGFza3Mgd2l0aG91dCBhIFBJRApbc25pcF0KPiA+Cj4KPiBJIHdvdWxk
IGJlIHN0cmljdGVyIGZvciBuZXcga2VybmVscywgd2UgZG8gbm90IHdhbnQgdGhlIG5ldyB2YWx1
ZQo+IHJldmVydGVkIGJhY2sgYnkgYW4gYWNjaWRlbnQuIFNvIHdoYXQgYWJvdXQ6Cj4KPiBzdGF0
aWMgaW50IGVycl9uciA9IEFSUkFZX1NJWkUoZXhwX2Vycm5vcyk7Cj4KPiBzdGF0aWMgdm9pZCBz
ZXR1cCh2b2lkKQo+IHsKPiAJLi4uCj4gCWlmICh0c3Rfa3ZlcmNtcCg5LCAxOSwgMCkgPj0gMCkK
PiAJCWVycl9uciA9IDE7Cj4gCS4uLgo+IH0KPgo+ID4gIAlpZiAoIVNBRkVfQ0xPTkUoYXJncykp
IHsKPiA+IC0JCVRTVF9FWFBfRkFJTChpb2N0bChwaWRmZCwgUElERkRfR0VUX0lORk8sIGluZm8p
LCBFU1JDSCk7Cj4gPiArCQlUU1RfRVhQX0ZBSUxfQVJSKGlvY3RsKHBpZGZkLCBQSURGRF9HRVRf
SU5GTywgaW5mbyksIGV4cF9lcnJub3MsCj4gPiArCQkJCUFSUkFZX1NJWkUoZXhwX2Vycm5vcykp
Owo+IAkJCQleCj4gCQkJCWVycl9ucgpIaSBDeXJpbCwKCnRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rp
b24uIEkgYWdyZWUgd2l0aCB5b3UuCkkgdGVzdGVkIHRoZSBjaGFuZ2Ugb24gdjYuMTguNSBhbmQg
djYuMTkuMC4KCknigJlsbCBzZW5kIHYzIHdpdGggdGhlIGVycl9uciB1cGRhdGUgYXMgcHJvcG9z
ZWQuCgpUaGFua3MsCkphbgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
