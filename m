Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A6FEF4ED4
	for <ltp@archiver.kernel.org>; Mon,  6 Apr 2026 12:26:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D5A23CF512
	for <ltp@archiver.kernel.org>; Mon,  6 Apr 2026 14:26:15 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9CFC13C2B27
 for <ltp@lists.linux.it>; Mon,  6 Apr 2026 14:25:56 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EC1396005DD
 for <ltp@lists.linux.it>; Mon,  6 Apr 2026 14:25:55 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6363kJYU156186; Mon, 6 Apr 2026 12:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=/qEBTWjqK0D47e29j/9LLOdzr1FT
 ISLyxARqZxf7Dm0=; b=jFoCkIQIXptRL3VoyMFtPAvgh8zjMUW/XQAEhSUuwkD5
 Jf3WGFwhOLwTe957gNuGccro+kzmvgyR3wXoqOadvi9w+zuvqTLcbPyoYzAf4o+r
 Xu/wnJNG5sVsnGBZqnP8Mxhyre0R3iLjzBQ2Td4uOEHQ2iUdQAdFHfZvo+8GZk8/
 LVOjctQdbLeY0xheEPTBQAONeGVwnrVlmQhBceY6YGeHDCtlTROl1El0YXyHqyNR
 NkffEpNFFPwxAZXKpezI75rZdY19a+ad8pWIXshpnOZ6L94XqJKkBa3/2Ix1LpLw
 yfhIDwvxMDHxHfk35txstdsbKXVdl7E/rOiIKIEa4g==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dar2ge7e6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Apr 2026 12:25:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 636C948P014731;
 Mon, 6 Apr 2026 12:25:53 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dbf6jveup-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Apr 2026 12:25:53 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 636CPnwM39518464
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Apr 2026 12:25:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5B2AD20040;
 Mon,  6 Apr 2026 12:25:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8DB8F2004E;
 Mon,  6 Apr 2026 12:25:48 +0000 (GMT)
Received: from ltcden9-lp6.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Apr 2026 12:25:48 +0000 (GMT)
From: =?UTF-8?q?=E2=80=9CSamir?= <samir@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue,  7 Apr 2026 11:19:37 +0530
Message-ID: <20260407054943.125260-1-samir@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 73XQpKATJzPfIeORJsGnj0EzPIkftoRz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDEyMSBTYWx0ZWRfXxXvy6PRvcAPk
 PGdjWLPQzjSwD2gGqa4aAN+W0fPi2TqqWDmXHfg9J3uB7C8XjO8/MawDChOd23d+CVYSq/+EnPy
 TwqJCCRzSyzH/2axvlN308xWUEnX01tzEKHPbyBwIaBw8BNl9tFBk2waXj7lriArLKdkbmjZ4oD
 rtyuUsvesi39vyD4k3IuOlwsnyoqPjAOrT2ODcT5fcKimZlDjRwDyMv1EvYuHLRzt2DfP9SDERz
 e11el+TSB5kBV8ulRnx+t8nD/xajO8PHLPa55vW3Vd6uLNq/kcQMEdAU58Vxm5qXWuGhTSC9fwf
 8T4kbuYIYGPA4u3XCFfdwMPonKmTT91bGGp4BQvT6AFTJyc2XuJZkCITzvMpVBt9fLxxkY6ZI09
 XdUrlflhk8+nn/6MhLRU4gVslHQ3LP6VWi3P71tDccBx4/7gJgaAQYa9Uwa1PGaIF/7+VqA2AMj
 OxxG1DAdFrVt3ObC1eA==
X-Authority-Analysis: v=2.4 cv=b+u/I9Gx c=1 sm=1 tr=0 ts=69d3a652 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22
 a=VnNF1IyMAAAA:8 a=FNCLZmOxJmYuWFtuQQQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 73XQpKATJzPfIeORJsGnj0EzPIkftoRz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604060121
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] hugeshmget: Use __func__ instead of hardcoded function
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
Cc: =?UTF-8?q?=E2=80=9CSamir?= <samir@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

UmVwbGFjZSBoYXJkY29kZWQgInNldHVwIiBzdHJpbmcgd2l0aCBfX2Z1bmNfXyBpbiBlcnJvciBt
ZXNzYWdlcwp0byBmb2xsb3cgTFRQIGNvZGluZyBzdHlsZSBndWlkZWxpbmVzKG1ha2UgY2hlY2sp
LgoKRml4ZWQgaW46Ci0gaHVnZXNobWdldDAyLmM6ODMKLSBodWdlc2htZ2V0MDMuYzo3NgotIGh1
Z2VzaG1nZXQwNS5jOjc1CgpDaGFuZ2VkIGZyb206IHRzdF9icmsoVEJST0sgfCBURVJSTk8sICJz
aG1nZXQgI3NldHVwIik7CkNoYW5nZWQgdG86ICAgdHN0X2JyayhUQlJPSyB8IFRFUlJOTywgInNo
bWdldCAjJXMiLCBfX2Z1bmNfXyk7CgpTaWduZWQtb2ZmLWJ5OiDigJxTYW1pciA8c2FtaXJAbGlu
dXguaWJtLmNvbT4KLS0tCiB0ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2VzaG1nZXQv
aHVnZXNobWdldDAyLmMgfCAyICstCiB0ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2Vz
aG1nZXQvaHVnZXNobWdldDAzLmMgfCAyICstCiB0ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxi
L2h1Z2VzaG1nZXQvaHVnZXNobWdldDA1LmMgfCAyICstCiAzIGZpbGVzIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVs
L21lbS9odWdldGxiL2h1Z2VzaG1nZXQvaHVnZXNobWdldDAyLmMgYi90ZXN0Y2FzZXMva2VybmVs
L21lbS9odWdldGxiL2h1Z2VzaG1nZXQvaHVnZXNobWdldDAyLmMKaW5kZXggYmJkOTY4YzA2Li4w
NjVhYTA1ZmMgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZXNo
bWdldC9odWdlc2htZ2V0MDIuYworKysgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1
Z2VzaG1nZXQvaHVnZXNobWdldDAyLmMKQEAgLTgwLDcgKzgwLDcgQEAgdm9pZCBzZXR1cCh2b2lk
KQogCXNobV9pZF8xID0gc2htZ2V0KHNobWtleSwgc2htX3NpemUsCiAJCQkgIFNITV9IVUdFVExC
IHwgSVBDX0NSRUFUIHwgSVBDX0VYQ0wgfCBTSE1fUlcpOwogCWlmIChzaG1faWRfMSA9PSAtMSkK
LQkJdHN0X2JyayhUQlJPSyB8IFRFUlJOTywgInNobWdldCAjc2V0dXAiKTsKKwkJdHN0X2JyayhU
QlJPSyB8IFRFUlJOTywgInNobWdldCAjJXMiLCBfX2Z1bmNfXyk7CiB9CiAKIHZvaWQgY2xlYW51
cCh2b2lkKQpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlc2ht
Z2V0L2h1Z2VzaG1nZXQwMy5jIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlc2ht
Z2V0L2h1Z2VzaG1nZXQwMy5jCmluZGV4IDYyNTc2MWY2ZS4uMWYwN2Q1ODVhIDEwMDY0NAotLS0g
YS90ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2VzaG1nZXQvaHVnZXNobWdldDAzLmMK
KysrIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlc2htZ2V0L2h1Z2VzaG1nZXQw
My5jCkBAIC03Myw3ICs3Myw3IEBAIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCiAJCQkJICBTSE1f
SFVHRVRMQiB8IElQQ19DUkVBVCB8IElQQ19FWENMIHwgU0hNX1JXKTsKIAl9CiAJaWYgKGVycm5v
ICE9IEVOT1NQQykKLQkJdHN0X2JyayhUQlJPSyB8IFRFUlJOTywgInNobWdldCAjc2V0dXAiKTsK
KwkJdHN0X2JyayhUQlJPSyB8IFRFUlJOTywgInNobWdldCAjJXMiLCBfX2Z1bmNfXyk7CiB9CiAK
IHN0YXRpYyB2b2lkIGNsZWFudXAodm9pZCkKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwv
bWVtL2h1Z2V0bGIvaHVnZXNobWdldC9odWdlc2htZ2V0MDUuYyBiL3Rlc3RjYXNlcy9rZXJuZWwv
bWVtL2h1Z2V0bGIvaHVnZXNobWdldC9odWdlc2htZ2V0MDUuYwppbmRleCAzMzYzMTk2MDMuLmEy
YmI5MDIwZCAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlc2ht
Z2V0L2h1Z2VzaG1nZXQwNS5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVn
ZXNobWdldC9odWdlc2htZ2V0MDUuYwpAQCAtNzIsNyArNzIsNyBAQCB2b2lkIHNldHVwKHZvaWQp
CiAJc2htX2lkXzEgPSBzaG1nZXQoc2hta2V5LCBzaG1fc2l6ZSwKIAkJCSAgU0hNX0hVR0VUTEIg
fCBTSE1fUlcgfCBJUENfQ1JFQVQgfCBJUENfRVhDTCk7CiAJaWYgKHNobV9pZF8xID09IC0xKQot
CQl0c3RfYnJrKFRCUk9LIHwgVEVSUk5PLCAic2htZ2V0ICNzZXR1cCIpOworCQl0c3RfYnJrKFRC
Uk9LIHwgVEVSUk5PLCAic2htZ2V0ICMlcyIsIF9fZnVuY19fKTsKIAogCS8qIGdldCB0aGUgdXNl
cmlkIGZvciBhIG5vbi1yb290IHVzZXIgKi8KIAlsdHBfdWlkID0gZ2V0dXNlcmlkKGx0cF91c2Vy
KTsKLS0gCjIuNTIuMAoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
