Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA34C4452B
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 20:25:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B12183E7653
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 22:25:23 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 243093E1B59
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 22:25:07 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5661F100126C
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 22:25:06 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LHC0m91567547; Tue, 21 Jul 2026 20:25:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=v/sQYgKXzqzQu+9OIL0Ek/7qDYS/
 yt76looA8Zhq7l8=; b=rODqksyalxZM39BlEdAWln20HzdZVR+Dfbg1Lrd2agzF
 NuExkIMdRcAB+Zr7EvYnKWfHAhJ3fodncSyEHE0kiddDNF6Uj3JEhGZo9GqD9xKU
 mfKyPBrP0bmWftXkZrGox1qQd/rh+eRn6OtzTYN3CWwF2VHvhV3UXiv47OvP0zgT
 MFspqcNfOZmxFlXY+uVQYncHyR2izbMCRvVpJ6zcx4PNIc1K1Y9jQvdIFy9TVNhj
 jG7HF1Y69JyPn8z3i9K4Ng79QSCCxzOOb1fUe/xYw0PjO9mHz1+ikRUwPrKWtTHZ
 fl8YqLpQgvldBpmz2Z/y/3BHOeCyuiYRLxJ19hhm9A==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77k6bde-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 20:25:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66LKJeBF006726;
 Tue, 21 Jul 2026 20:25:03 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnah43gn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 20:25:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66LKOxG446727472
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Jul 2026 20:24:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6BB43200C4;
 Tue, 21 Jul 2026 20:24:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 353C8200BE;
 Tue, 21 Jul 2026 20:24:59 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com.com (unknown
 [9.87.158.239]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 Jul 2026 20:24:59 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 21 Jul 2026 22:24:48 +0200
Message-ID: <20260721202452.315581-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a5fd5a0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=-UpwcQOxWNG_FBFHVQUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDIxMCBTYWx0ZWRfX88osVP77wStS
 xueQiGj52dHu0AcMOKjgqcnd8lmHMdOo8CftumNPE1/34Ci0WQAqgIWzAUOSVCzGqj8KCqajuvV
 jhGbMtS+rGY8cwvCFuDpWx1RrlIiA5dZ37sLCquWm2VLw50kPWL49wiotUx6wQDj9iNNIuiqa65
 /3GnSmtizeiKjQ/uycYI/YLFhulE9yipKQQMtp4LzWXzO/QTFT6zXL5k0vY7LELaAF0mGhzqUtU
 UGNwnAwZ1w7Khdbd3JeUB6yLfrhVspXOv40wZrsaSgAs1yZiIbHEanbetnWiG0G62zq7sxfwQLU
 92xWqkW1AgjPKaREdY0Cq++lOA1rpHfrnH43IZ7tv51QFP7xO40gBEqozR5elnVy6uFpqjRw28k
 sZd8bN1r2pE8+dl4d2YdEon94WV9DQ1ljN3fa/mgLTvdmwweosBqxDRKECTKnpngbFzJiIp01mE
 1746o7SUmn7uRmcS9UA==
X-Proofpoint-ORIG-GUID: 3uJle69ojqocEmw42v1bOHFnr9B1TFMf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDIxMCBTYWx0ZWRfX2qB21Jg+PQzm
 d+dIKElLOMvOHDq9vLypPNiXHMQMQ0snLoOnnaeO0FQDdOjs+0DRZmGTYIjPEpVkI7tCe+jJceP
 TE8e31AicRaDFxO48nupsjdWZtfIPTQ=
X-Proofpoint-GUID: 3uJle69ojqocEmw42v1bOHFnr9B1TFMf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210210
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/3] Separate ptrace tests for
 CONFIG_PROC_MEM_FORCE_PTRACE
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

dGhwMDQgaXMgYSBDVkUtMjAxNy0xMDAwNDA1IHJlZ3Jlc3Npb24gdGVzdC4gSWYgZGlyZWN0Ci9w
cm9jL3NlbGYvbWVtIHdyaXRlcyBhcmUgYmxvY2tlZCBieSBDT05GSUdfUFJPQ19NRU1fRk9SQ0Vf
UFRSQUNFPXksCnRoZSBDVkUgY2Fubm90IGJlIHRyaWdnZXJlZCBhbmQgdGhwMDQgc2hvdWxkIHJl
cG9ydCBUQ09ORi4KCkFkZCBzZXBhcmF0ZSBwdHJhY2UgdGVzdHMgZm9yIHRoZSBDT05GSUdfUFJP
Q19NRU1fRk9SQ0VfUFRSQUNFIGJlaGF2aW9yCmluc3RlYWQ6CgotIHB0cmFjZTEyIGNoZWNrcyB0
aGF0IHdyaXRpbmcgdG8gL3Byb2Mvc2VsZi9tZW0gaXMgcmVqZWN0ZWQgd2l0aCBFSU8uCi0gcHRy
YWNlMTMgY2hlY2tzIHRoYXQgYSBwYXJlbnQgY2FuIHdyaXRlIHRvIGEgdHJhY2VkIGNoaWxkJ3Mg
bWVtb3J5IHZpYQogIC9wcm9jL3BpZC9tZW0uCgpCb3RoIHB0cmFjZSB0ZXN0cyB1c2UgcmVhZC1v
bmx5IG1hcHBpbmdzLCBzbyB0aGUgd3JpdGVzIHJlcXVpcmUKRk9MTF9GT1JDRSBhbmQgZXhlcmNp
c2UgdGhlIENPTkZJR19QUk9DX01FTV9GT1JDRV9QVFJBQ0UgZW5mb3JjZW1lbnQuCgpWYWxpZGF0
ZWQgb24gczM5MHggd2l0aCBDT05GSUdfUFJPQ19NRU1fRk9SQ0VfUFRSQUNFPXk6CgotIHB0cmFj
ZTEyOiBUUEFTUwotIHB0cmFjZTEzOiBUUEFTUywgMTAwIGl0ZXJhdGlvbnMKCkZvbGxvdy11cCB0
byB0aGUgcHJldmlvdXMgdGhwMDQgcHRyYWNlIG1vZGUgZGlzY3Vzc2lvbjoKaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsLzIwMjYwNzA5MTc1OTI3LjI2ODY3Ny0xLWphcG9AbGludXguaWJtLmNv
bS8KCkNoYW5nZXMgaW4gdjM6Ci0gQWxsIHBhdGNoZXM6IEZpeGVkIFJTVCBkb2MgZm9ybWF0dGlu
ZyAoYWRkZWQgYmxhbmsgbGluZXMgYmVmb3JlIGxpc3RzKQotIEFsbCBwYXRjaGVzOiBSZW1vdmVk
IHJlZHVuZGFudCBjb21tZW50cyBwZXIgTFRQIGNvZGluZyBzdHlsZQotIHRocDA0OiBSZW1vdmVk
IGNvbW1lbnRzIHJlc3RhdGluZyBwb2ludGVyIGFyaXRobWV0aWMKLSBwdHJhY2UxMjogS2VwdCBv
bmx5IGludGVudC1mb2N1c2VkIEZPTExfRk9SQ0UgY29tbWVudAotIHB0cmFjZTEzOiBSZW1vdmVk
IHVudXNlZCBzaGFyZWRfc3RhdGUucmVzdWx0IGZpZWxkCi0gcHRyYWNlMTM6IFJlbW92ZWQgbWlz
bGVhZGluZyAicHJldmlvdXMgaXRlcmF0aW9uIiBjb21tZW50Ci0gcHRyYWNlMTM6IENsYXJpZmll
ZCBpdGVyYXRpb24gY291bnRlciBpbiBURkFJTCBtZXNzYWdlIHRvIHNob3cgd2hpY2ggd3JpdGUg
aXMgYmVpbmcgdmVyaWZpZWQKLSBwdHJhY2UxMzogS2VwdCBvbmx5IGludGVudC1mb2N1c2VkIEZP
TExfRk9SQ0UgY29tbWVudCBhbmQgc3luY2hyb25pemF0aW9uIHBhdHRlcm4gY29tbWVudAoKQ2hh
bmdlcyBpbiB2MjoKLSB0aHAwNDogUmVtb3ZlZCAuZm9ya3NfY2hpbGQgZmxhZyAobm90IG5lZWRl
ZCB3aXRob3V0IGFjdHVhbCBmb3JrKQotIHRocDA0OiBDaGFuZ2VkIE1BUF9TSEFSRUQgdG8gTUFQ
X1BSSVZBVEUgZm9yIGNoaWxkIHN0YXRlIG1hcHBpbmcKLSB0aHAwNDogQWRkZWQgbWlzc2luZyAj
aW5jbHVkZSA8c3RyaW5nLmg+IGZvciBtZW1zZXQoKQotIHRocDA0OiBSZW5hbWVkIHN0cnVjdCBj
aGlsZF9zdGF0ZSDihpIgc3RydWN0IHRocF9zdGF0ZSAobm8gbG9uZ2VyIHVzZXMgZm9yaykKLSB0
aHAwNDogUmVuYW1lZCBjaGlsZCDihpIgc3RhdGUsIGNoaWxkX3NldHVwKCkg4oaSIHRocF9zZXR1
cCgpLCBjaGlsZF9jbGVhbnVwKCkg4oaSIHRocF9jbGVhbnVwKCkKLSBwdHJhY2UxMjogUmVtb3Zl
ZCBkZXByZWNhdGVkIFtEZXNjcmlwdGlvbl0gbGluZSBmcm9tIGRvYyBibG9jawotIHB0cmFjZTEy
OiBSZXBsYWNlZCBiYXJlIHdyaXRlKCkgd2l0aCBURVNUKCkgbWFjcm8sIHVzaW5nIFRTVF9SRVQv
VFNUX0VSUgotIHB0cmFjZTEyOiBBZGp1c3RlZCBzZXR1cCBjb21tZW50IHRvIGNsYXJpZnkgcGFn
ZSBpbml0aWFsaXphdGlvbiBzZXF1ZW5jZQotIHB0cmFjZTEzOiBSZW1vdmVkIGRlcHJlY2F0ZWQg
W0Rlc2NyaXB0aW9uXSBsaW5lIGZyb20gZG9jIGJsb2NrCi0gcHRyYWNlMTM6IEFkZGVkIG1pc3Np
bmcgI2luY2x1ZGUgPHN0cmluZy5oPiBmb3IgbWVtc2V0KCkKLSBCb3RoIHB0cmFjZSB0ZXN0czog
QWRkZWQgdG8gcnVudGVzdC9zeXNjYWxscwoKdjI6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Fs
bC8yMDI2MDcxNjA5NTAwNC45Mjc5My0xLWphcG9AbGludXguaWJtLmNvbS8KdjE6IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2FsbC8yMDI2MDcxNDE1MDYzMS4yNTA5NzItMS1qYXBvQGxpbnV4Lmli
bS5jb20vCgpKYW4gUG9sZW5za3kgKDMpOgogIHRocDA0OiBTaW1wbGlmeSB0byBmb2N1cyBvbiBD
VkUtMjAxNy0xMDAwNDA1IHJhY2UgdGVzdCBvbmx5CiAgcHRyYWNlOiBhZGQgdGVzdCBmb3IgL3By
b2Mvc2VsZi9tZW0gd3JpdGUgcmVqZWN0aW9uCiAgcHRyYWNlOiBhZGQgdGVzdCBmb3IgL3Byb2Mv
cGlkL21lbSB3cml0ZXMgdW5kZXIgcHRyYWNlCgogcnVudGVzdC9zeXNjYWxscyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAgMiArCiB0ZXN0Y2FzZXMva2VybmVsL21lbS90aHAvdGhwMDQu
YyAgICAgICAgICAgIHwgMTYzICsrKysrKysrKysrLS0tLS0KIHRlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvcHRyYWNlLy5naXRpZ25vcmUgfCAgIDIgKwogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9wdHJhY2UvcHRyYWNlMTIuYyB8ICA5MiArKysrKysrKysKIHRlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvcHRyYWNlL3B0cmFjZTEzLmMgfCAyMDQgKysrKysrKysrKysrKysrKysrKysKIDUgZmls
ZXMgY2hhbmdlZCwgNDExIGluc2VydGlvbnMoKyksIDUyIGRlbGV0aW9ucygtKQogY3JlYXRlIG1v
ZGUgMTAwNjQ0IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcHRyYWNlL3B0cmFjZTEyLmMKIGNy
ZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3B0cmFjZS9wdHJhY2Ux
My5jCgoKYmFzZS1jb21taXQ6IGQxMzk1MjRiMDRkMzYwYzRkYWJhZWU2MWE2MDY2YTlhNTJiMGU0
NTQKcHJlcmVxdWlzaXRlLXBhdGNoLWlkOiBiZGVkNzJiY2I5YjQwZDgxNTc5OGNlNjIzODFlZWM0
NzJjMjhhYWNlCnByZXJlcXVpc2l0ZS1wYXRjaC1pZDogMTZmYzAwZDMwMmFlZmJmNmZiMTdlOTcy
YTQzOTAzNDFiZmJiMGU1MApwcmVyZXF1aXNpdGUtcGF0Y2gtaWQ6IDZlNzdlZjA5YjIyNTlkYWFl
OTE1ZjRhNDg5NWJmMDg3OWI3YjcyMTEKcHJlcmVxdWlzaXRlLXBhdGNoLWlkOiAxZDEzZjY3NmMx
YzFiOWIzN2U5N2IxZTE4YWU3NTYxMWEzNTE2Zjk2CnByZXJlcXVpc2l0ZS1wYXRjaC1pZDogMTFi
OGYyYjEwMjAyOWI0MTgzODg5OWYyYTc4MTMyYjUwY2FjMTJhMApwcmVyZXF1aXNpdGUtcGF0Y2gt
aWQ6IDgxMWU4NWQ5YTQxNThmNzI1NTlkZTVmNTUxYWQ5M2YxMDkzNjJjOTYKLS0KMi41NS4wCgoK
LS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0
cAo=
