Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E161EE9A04B
	for <ltp@archiver.kernel.org>; Wed, 18 Feb 2026 19:03:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7692C3D066C
	for <ltp@archiver.kernel.org>; Wed, 18 Feb 2026 20:03:03 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3856D3D0640
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 20:02:44 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D583B1400072
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 20:02:41 +0100 (CET)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61IBvuXw3424040; Wed, 18 Feb 2026 19:02:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=8K/ZOm4Y7cJzf7jPxxp9IALaBJYB
 yeBYt/uwNMM024s=; b=RNNcv26f0kYBLCCb2kkuWctj4hDcgxuQqXrWt95aipHr
 rM2hMHBMPn4cfI2GNLf4elqTY3qTSNDEz5ky5BRRV/90MD8fE4B9FztasyrW7n47
 1xL6Fc+0W7ywh+J97Dch/EwRp09LSTp9dMW7kz6FcGYxhINMns8Owmf13wzEnl/y
 +YIZAldeG59LPli45/n0X8SPz85pieqhykzBPsnv/foLJgyLVBajpMS/roZkuRQi
 0yV+r5PlxgMD4byuCmaWxXwi3Gv6/wyKrinuCFZlDo3bLR/f/rIV6nYeLrmRzIzh
 HayiyC0US6rD0BsNZPbjx/JCZSXWkd2tYx7uKOdHFw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj4khp26-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Feb 2026 19:02:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61IHRoB4015846;
 Wed, 18 Feb 2026 19:02:39 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb4595w9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Feb 2026 19:02:38 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61IJ2bvW57344458
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Feb 2026 19:02:37 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE95520063;
 Wed, 18 Feb 2026 19:02:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 98C9B20040;
 Wed, 18 Feb 2026 19:02:36 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com.com (unknown
 [9.111.83.208]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 18 Feb 2026 19:02:36 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: chrubis@suse.cz, pvorel@suse.cz
Date: Wed, 18 Feb 2026 20:02:30 +0100
Message-ID: <20260218190230.53759-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDE2MCBTYWx0ZWRfX8374Ggc8aeUZ
 FXBFzoUAjVbBEFCvwIptc08Gvvv467o1HNvycI8SJakow4jo9FAp0X4DHc+DZHucFkzxGubSKlO
 bOCyk92mC784wlIm7m/l86KNuzHAa1DEhhema8ppMAHKKMqtvBy0Q9yiSZeiOdAaAUqTdv4gjKi
 lDXcxy7BjKJKz8PiY5Cl67OWSLXWaRsT92zJqz42BCWgfCHxuqz8gpLwtFHrv0/K96zQKdx7ERQ
 +cDKUtqCONcK3/DfSAKuFNgcPpoCtVgcrcBuV0OuYfh/vyhnoPl2C9MRMT3H7L+2eZ3SfiD4GBH
 jKOz8hdm2JdyyCudxZXAMzTAJDsqgMmHrzxyQQCokBF80fQW81oYfcPtG2t2LZZoThFYzjAaOyF
 rU5P0lKoqI88tesz++7B8my7ICNDLXj61u8JdHyFzkXRQfYIpJ3PEd8inlvxI+isLOaS0YEdX+s
 KVkM/S7EoJfk70Subrw==
X-Proofpoint-ORIG-GUID: GPcZYhyVpIJLwKjaogCBxyE_D3jbOCKF
X-Proofpoint-GUID: GPcZYhyVpIJLwKjaogCBxyE_D3jbOCKF
X-Authority-Analysis: v=2.4 cv=M7hA6iws c=1 sm=1 tr=0 ts=69960ccf cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=OLL_FvSJAAAA:8
 a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=IeM_0OaE5tNhmo2q7v4A:9
 a=QEXdDO2ut3YA:10 a=oIrB72frpwYPwTMnlWqB:22 a=W4TVW4IDbPiebHqcZpNg:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_04,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180160
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/1] ioctl_pidfd06: expect EREMOTE for
 PIDFD_GET_INFO across pidns
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

S2VybmVsIGNoYW5nZWQgUElERkRfR0VUX0lORk8gc2VtYW50aWNzIHdoZW4gdGhlIHBpZGZkIHJl
ZmVycyB0byBhIHRhc2sKdGhhdCBoYXMgbm8gUElEIGluIHRoZSBjYWxsZXIncyBjdXJyZW50IHBp
ZCBuYW1lc3BhY2U6IHJldHVybiAtRVJFTU9URQppbnN0ZWFkIG9mIC1FU1JDSCwgYWxsb3dpbmcg
dXNlcnNwYWNlIHRvIGRpc3Rpbmd1aXNoIOKAnGRpZmZlcmVudCBwaWRuc+KAnQpmcm9tIOKAnHBy
b2Nlc3MgZXhpdGVk4oCdLgoKVXBkYXRlIGlvY3RsX3BpZGZkMDYgdG8gZXhwZWN0IEVSRU1PVEUg
aW4gdGhhdCBjYXNlLgoKTGluazogaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvbGludXgt
ZnNkZXZlbC9tc2czMjY2OTkuaHRtbApMaW5rOiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAyNi8y
LzE2LzYwOApMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjYwMjE0MDEwMjQ1LjM2
NzE5MDctMzQtc2FzaGFsQGtlcm5lbC5vcmcKU2lnbmVkLW9mZi1ieTogSmFuIFBvbGVuc2t5IDxq
YXBvQGxpbnV4LmlibS5jb20+Ci0tLQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pb2N0bC9p
b2N0bF9waWRmZDA2LmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lvY3Rs
L2lvY3RsX3BpZGZkMDYuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaW9jdGwvaW9jdGxf
cGlkZmQwNi5jCmluZGV4IDc1MTI4MWJhY2I3NC4uODEyMDVhZmI3MmE2IDEwMDY0NAotLS0gYS90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lvY3RsL2lvY3RsX3BpZGZkMDYuYworKysgYi90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lvY3RsL2lvY3RsX3BpZGZkMDYuYwpAQCAtNDEsNyArNDEs
NyBAQCBzdGF0aWMgdm9pZCBydW4odm9pZCkKIAlhcmdzLT5leGl0X3NpZ25hbCA9IFNJR0NITEQ7
CiAKIAlpZiAoIVNBRkVfQ0xPTkUoYXJncykpIHsKLQkJVFNUX0VYUF9GQUlMKGlvY3RsKHBpZGZk
LCBQSURGRF9HRVRfSU5GTywgaW5mbyksIEVTUkNIKTsKKwkJVFNUX0VYUF9GQUlMKGlvY3RsKHBp
ZGZkLCBQSURGRF9HRVRfSU5GTywgaW5mbyksIEVSRU1PVEUpOwogCQlleGl0KDApOwogCX0KIAot
LSAKMi41My4wCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0
L2xpc3RpbmZvL2x0cAo=
