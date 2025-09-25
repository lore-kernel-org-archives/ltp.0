Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F18ABCAC5A5
	for <ltp@archiver.kernel.org>; Thu, 25 Sep 2025 06:01:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C1003CDCE2
	for <ltp@archiver.kernel.org>; Thu, 25 Sep 2025 08:01:14 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C29FC3C29E9
 for <ltp@lists.linux.it>; Thu, 25 Sep 2025 08:00:58 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C56BA10004A1
 for <ltp@lists.linux.it>; Thu, 25 Sep 2025 08:00:57 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P1FCda005703;
 Thu, 25 Sep 2025 06:00:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=U7gnQnc1Y8zjvVWM9hsS4b/BxXnz
 FoWgyXnNiPNQN90=; b=XZmc3wC63a+C+gDa0yi5KNzc6VRWyI77AhbtkYq619fu
 3CrZIBfE+OH4RFARaY7uKqrphJSJ4yGA9/oLoGbrzTXstOcO7daI5xCsqjsXIz2K
 GsdmFt/bWG7R4pCw6DQ2MruUBCIdYGOMh0QJS0PoFr9jpomszXv0C2dHYb7jgrl/
 RiFylC4pHHZFAoXouEp4eBwl8JY0c4Ar6uQRHznuPLnGdR11tR+JFO9izP6bCVzu
 OT3lPIlol5Scjo9bZHQlhRA0oivJU8+4HM9e5mOVx9hq5gRitbXqhBzDGhokRla2
 ut1MFvXaUympS+ngO5Z0kNzMHFwvhoqO9R1staL40A==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499kwytybg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 06:00:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58P5p1S1019675;
 Thu, 25 Sep 2025 06:00:55 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49a83kc83k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 06:00:54 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58P60rmZ52887918
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Sep 2025 06:00:53 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC6B420040;
 Thu, 25 Sep 2025 06:00:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CFC8420043;
 Thu, 25 Sep 2025 06:00:51 +0000 (GMT)
Received: from li-6442e9cc-24ed-11b2-a85c-915a5b5fa426.in.ibm.com (unknown
 [9.109.212.52]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Sep 2025 06:00:51 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu, 25 Sep 2025 11:30:45 +0530
Message-ID: <20250925060046.1006111-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J5Cq7BnS c=1 sm=1 tr=0 ts=68d4da97 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=NEAV23lmAAAA:8
 a=j77m7DWCv6wA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8
 a=qlThe8qJfWNvhCPcO8wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: A1X3wSo_U37jpto_KdGGhTRtcvTVy_Q6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxNSBTYWx0ZWRfX6Oc/KCgkg5NI
 tyzhm5Moq7jft3mtcqcQ8myCemGpdhrtLMMH2PvCpCyr64W4GkVyy7qbvXS9rvHIsIothsBs22X
 GG3z7GoP5vfH9fyKWxKlKIf427tESHkF0QLCuHIdoGgEPzY3arujrgQtjJvGGa9Pg4Wn8f3nNxS
 8tIU2Z4pzohK5FCoBpSRD1ioiz2m3UarCBWDuqkjSDYReLwl58peaN22BoK8zqkGFn9HFMkv3Sh
 iWG/tJ9VehfwX7oTfmj5JfTyP7eX0yJxCUTItXINZFppn6k1hBkm0kFZWkFmYBuybzsp6G86PhU
 rt8IuoIRfNZ8C1IncxT37EN64v43L+ejfmHr1kC/dBBENp5RRAy2x/Ff1qpvSSNwpNlxk21l9GF
 hdP2o4+Z
X-Proofpoint-ORIG-GUID: A1X3wSo_U37jpto_KdGGhTRtcvTVy_Q6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1011 adultscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200015
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6] Origin:
 https://github.com/libhugetlbfs/libhugetlbfs/blob/master/tests/shm-getraw.c
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
Cc: pavrampu@linux.ibm.com, Pavithra <pavrampu@linux.vnet.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

RnJvbTogUGF2aXRocmEgPHBhdnJhbXB1QGxpbnV4LnZuZXQuaWJtLmNvbT4KClRoZSB0ZXN0IGNy
ZWF0ZXMgYSBzaGFyZWQgbWVtb3J5IHNlZ21lbnQsIHRoZW4gYXR0YWNoZXMgaXQgdG8gdGhlIHBy
b2Nlc3PigJlzIGFkZHJlc3Mgc3BhY2UuCkl0IHdyaXRlcyBhIHN0cmluZyB0byB0aGUgc2hhcmVk
IG1lbW9yeSBmcm9tIHJhdyBkZXZpY2UgYW5kIGRldGFjaGVzIHRoZSBzaGFyZWQgbWVtb3J5CnNl
Z21lbnQgYW5kIGZpbmFsbHkgcmVtb3ZlcyBpdC4KVGhlIHB1cnBvc2Ugb2YgdGhpcyB0ZXN0IGlz
IHRvIGVuc3VyZSB0aGF0IHRoZSBzaGFyZWQgbWVtb3J5IHN1YnN5c3RlbSBpcyB3b3JraW5nIGNv
cnJlY3RseQp3aXRoIGh1Z2VwYWdlcy4gSXQgY2hlY2tzIHRoYXQgc2hhcmVkIG1lbW9yeSBzZWdt
ZW50cyBjYW4gYmUgY3JlYXRlZCwgYXR0YWNoZWQsIHdyaXR0ZW4gdG8sCnJlYWQgZnJvbSwgZGV0
YWNoZWQsIGFuZCByZW1vdmVkIHdpdGhvdXQgZXJyb3JzCgpTaWduZWQtb2ZmLWJ5OiBQYXZpdGhy
YSA8cGF2cmFtcHVAbGludXgudm5ldC5pYm0uY29tPgotLS0KIHJ1bnRlc3Qvc3lzY2FsbHMtaXBj
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxICsKIHRlc3RjYXNlcy9rZXJuZWwvbWVtLy5n
aXRpZ25vcmUgICAgICAgICAgICAgICB8ICAxICsKIC4uLi9rZXJuZWwvc3lzY2FsbHMvaXBjL3No
bWdldC9zaG1nZXQwNy5jICAgICB8IDczICsrKysrKysrKysrKysrKysrKysKIDMgZmlsZXMgY2hh
bmdlZCwgNzUgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvaXBjL3NobWdldC9zaG1nZXQwNy5jCgpkaWZmIC0tZ2l0IGEvcnVudGVzdC9z
eXNjYWxscy1pcGMgYi9ydW50ZXN0L3N5c2NhbGxzLWlwYwppbmRleCA4OTYwYzQ4N2MuLjQxNTlm
MjMzMSAxMDA2NDQKLS0tIGEvcnVudGVzdC9zeXNjYWxscy1pcGMKKysrIGIvcnVudGVzdC9zeXNj
YWxscy1pcGMKQEAgLTY2LDMgKzY2LDQgQEAgc2htZ2V0MDMgc2htZ2V0MDMKIHNobWdldDA0IHNo
bWdldDA0CiBzaG1nZXQwNSBzaG1nZXQwNQogc2htZ2V0MDYgc2htZ2V0MDYKK3NobWdldDA3IHNo
bWdldDA3CmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL21lbS8uZ2l0aWdub3JlIGIvdGVz
dGNhc2VzL2tlcm5lbC9tZW0vLmdpdGlnbm9yZQppbmRleCBiNDQ1NWRlNTEuLmY5NDM4NjA2ZSAx
MDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vLmdpdGlnbm9yZQorKysgYi90ZXN0Y2Fz
ZXMva2VybmVsL21lbS8uZ2l0aWdub3JlCkBAIC01MCw2ICs1MCw3IEBACiAvaHVnZXRsYi9odWdl
c2htZ2V0L2h1Z2VzaG1nZXQwMwogL2h1Z2V0bGIvaHVnZXNobWdldC9odWdlc2htZ2V0MDUKIC9o
dWdldGxiL2h1Z2VzaG1nZXQvaHVnZXNobWdldDA2CisvaHVnZXRsYi9odWdlc2htZ2V0L2h1Z2Vz
aG1nZXQwNwogL2tzbS9rc20wMQogL2tzbS9rc20wMgogL2tzbS9rc20wMwpkaWZmIC0tZ2l0IGEv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pcGMvc2htZ2V0L3NobWdldDA3LmMgYi90ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL2lwYy9zaG1nZXQvc2htZ2V0MDcuYwpuZXcgZmlsZSBtb2RlIDEw
MDY0NAppbmRleCAwMDAwMDAwMDAuLmIxYmVlMDZmOQotLS0gL2Rldi9udWxsCisrKyBiL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvaXBjL3NobWdldC9zaG1nZXQwNy5jCkBAIC0wLDAgKzEsNzMg
QEAKKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBMR1BMLTIuMS1vci1sYXRlcgorLyoKKyAq
IENvcHlyaWdodCAoQykgMjAwNS0yMDA2IERhdmlkIEdpYnNvbiAmIEFkYW0gTGl0a2UsIElCTSBD
b3Jwb3JhdGlvbi4KKyAqLworCisvKlwKKyAqIFtEZXNjcmlwaXRvbl0KKyAqCisgKiBPcmlnaW46
IGh0dHBzOi8vZ2l0aHViLmNvbS9saWJodWdldGxiZnMvbGliaHVnZXRsYmZzL2Jsb2IvbWFzdGVy
L3Rlc3RzL3NobS1nZXRyYXcuYworICoKKyAqIFRoZSB0ZXN0IGNyZWF0ZXMgYSBzaGFyZWQgbWVt
b3J5IHNlZ21lbnQsIHRoZW4gYXR0YWNoZXMgaXQgdG8gdGhlIHByb2Nlc3PigJlzIGFkZHJlc3Mg
c3BhY2UuCisgKiBJdCB3cml0ZXMgYSBzdHJpbmcgdG8gdGhlIHNoYXJlZCBtZW1vcnkgZnJvbSBy
YXcgZGV2aWNlIGFuZCBkZXRhY2hlcyB0aGUgc2hhcmVkIG1lbW9yeQorICogc2VnbWVudCBhbmQg
ZmluYWxseSByZW1vdmVzIGl0LgorICogVGhlIHB1cnBvc2Ugb2YgdGhpcyB0ZXN0IGlzIHRvIGVu
c3VyZSB0aGF0IHRoZSBzaGFyZWQgbWVtb3J5IHN1YnN5c3RlbSBpcyB3b3JraW5nIGNvcnJlY3Rs
eQorICogd2l0aCBodWdlcGFnZXMuIEl0IGNoZWNrcyB0aGF0IHNoYXJlZCBtZW1vcnkgc2VnbWVu
dHMgY2FuIGJlIGNyZWF0ZWQsIGF0dGFjaGVkLCB3cml0dGVuIHRvLAorICogcmVhZCBmcm9tLCBk
ZXRhY2hlZCwgYW5kIHJlbW92ZWQgd2l0aG91dCBlcnJvcnMKKyAqCisgKi8KKworI2luY2x1ZGUg
Ii4uLy4uLy4uL21lbS9odWdldGxiL2xpYi9odWdldGxiLmgiCisjaW5jbHVkZSAidHN0X3NhZmVf
c3lzdl9pcGMuaCIKKworI2RlZmluZSBNTlRQT0lOVCAiaHVnZXRsYmZzLyIKKyNkZWZpbmUgTlJf
SFVHRVBBR0VTIDIKKworc3RhdGljIGludCBzaG1pZCA9IC0xOworc3RhdGljIHNpemVfdCBzaXpl
Oworc3RhdGljIHNpemVfdCBpOworCitzdGF0aWMgY2hhciAqc2htYWRkcjsKK3N0YXRpYyBpbnQg
cmF3X2ZkOworc3RhdGljIGxvbmcgaHBhZ2Vfc2l6ZTsKKworc3RhdGljIHZvaWQgc2V0dXAodm9p
ZCkKK3sKKwlocGFnZV9zaXplID0gdHN0X2dldF9odWdlcGFnZV9zaXplKCk7Cit9CisKK3N0YXRp
YyB2b2lkIGNsZWFudXAodm9pZCkKK3sKKwlpZiAoc2htaWQgPj0gMCkKKwkJU0FGRV9TSE1DVEwo
c2htaWQsIElQQ19STUlELCBOVUxMKTsKK30KKworc3RhdGljIHZvaWQgcnVuX3Rlc3Qodm9pZCkK
K3sKKwlzaXplID0gaHBhZ2Vfc2l6ZSAqIE5SX0hVR0VQQUdFUzsKKwlyYXdfZmQgPSBTQUZFX09Q
RU4oIi9kZXYvemVybyIsIE9fUkRPTkxZKTsKKworCXNobWlkID0gU0FGRV9TSE1HRVQoSVBDX1BS
SVZBVEUsIHNpemUsIFNITV9IVUdFVExCfFNITV9SfFNITV9XKTsKKworCXNobWFkZHIgPSBTQUZF
X1NITUFUKHNobWlkLCAwLCBTSE1fUk5EKTsKKwl0c3RfcmVzKFRJTkZPLCAic2htYWRkcjogJXBc
biIsIHNobWFkZHIpOworCisJLyogUmVhZCBhIHBhZ2UgZnJvbSBkZXZpY2UgYW5kIHdyaXRlIHRv
IHNobSBzZWdtZW50ICovCisKKwlmb3IgKGkgPSAwOyBpIDwgc2l6ZTsgaSArPSBocGFnZV9zaXpl
KSB7CisJCVRTVF9SRVQgPSByZWFkKHJhd19mZCwgc2htYWRkciwgaHBhZ2Vfc2l6ZSk7CisJCVRT
VF9FWFBfVkFMKFRTVF9SRVQsIGhwYWdlX3NpemUsICJyZWFkIHJldHVybmVkICVsZCIsIFRTVF9S
RVQpOworCQlpZiAoVFNUX1JFVCAhPSBocGFnZV9zaXplKQorCQkJdHN0X3JlcyhURkFJTCB8IFRF
UlJOTywgIkNhbid0IHJlYWQgZnVsbCBwYWdlIGZyb20gcmF3IGRldmljZSEiKTsKKwl9CisKKwlT
QUZFX1NITURUKHNobWFkZHIpOworfQorCitzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7
CisJLm5lZWRzX3Jvb3QgPSAxLAorCS5zZXR1cCA9IHNldHVwLAorCS5jbGVhbnVwID0gY2xlYW51
cCwKKwkudGVzdF9hbGwgPSBydW5fdGVzdCwKKwkuaHVnZXBhZ2VzID0gezIsIFRTVF9ORUVEU30s
Cit9OwotLSAKMi40My41CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
