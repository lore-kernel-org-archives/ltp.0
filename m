Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D680F36BBA
	for <ltp@archiver.kernel.org>; Fri, 10 Apr 2026 06:40:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F1EC83E215D
	for <ltp@archiver.kernel.org>; Fri, 10 Apr 2026 08:40:20 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9DDEB3CF3BD
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 08:40:02 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D5708200A13
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 08:40:01 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A2PQ562592704
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 06:39:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=UW8Nz6oKnUllXzGLQCEkKI0pcrfK
 Z3ZNEP3foPdblzc=; b=ZPm0d7L5qJ8np4FNpKIbBvovOPpWweYTFNsdk8E9ajtc
 K126zS8Uaem38ml9CTOdwq2hzQCaOmDkt1PilZrcJTv3XSgdxU3RJV/Py8LqbUbj
 RdsIouUIRCmUQxg/ykmCjJZ1/ooINzvxLlhPuDi97lD92aOZXMcRq0uRFMVyN5nZ
 mpVu30oH1iWckGrrD+HSt0/KwEs01hzlygRDbsEIzUjlJxc0IUZ7SFHsKZ6w+XjP
 7dcdScLi2pyC7OmpuSp5CH0mktZFEHQchYpY8XKjrhYYk8NgNOry42Fh8AeQKtea
 kwqxJ5ad6PlBFdxAhYd5fiU9Z7IYHp7Pb8sI9eMqEw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2egpnp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 06:39:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63A2tG3Q018965
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 06:39:58 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcme9pw2u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 06:39:58 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63A6dwPv28246740
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 06:39:58 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 16FED5804E
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 06:39:58 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5AF395803F
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 06:39:57 +0000 (GMT)
Received: from [9.43.56.193] (unknown [9.43.56.193])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 06:39:56 +0000 (GMT)
Message-ID: <3b5b375d-25b2-4681-bf05-58549e10b33c@linux.ibm.com>
Date: Fri, 10 Apr 2026 12:09:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: priyama2 <priyama2@linux.ibm.com>
To: ltp@lists.linux.it
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jJ-X7rzwTHoc3DF3o42GknB1GWtZL37v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA1NiBTYWx0ZWRfX3I2Li3i35WOa
 sqdkB8rTvV8AFFCCWDU81A8TMxDm3PZj/hndJ+mvDlUVPC1SWw5X7vgFxz7MbDudVFuDWa0aZfE
 sdCYAYCoxirbbVevIKsPVIpjq3sQN8dMwoNdSmp+0TagQq+bj0THLnKqVQFf2CEUfcl0UbnrFGu
 Rv01k6ecwxcz/Se9q2RyC2rv8LNuLprJQKpiU5NOMbLob5/vUle1K2mtwlCbGZG5fMdUtX78sL+
 mPxkDIL5ZQzMt3Tacn3hTPl9868+XJ2gCIhGjVaYYi+ORsSsa64M7XjwQ9waGSuhauD8k8Nvin3
 WOpguIG2buTLT1wUjshWVubm9wjC8LfxjlPFQrb6j7wBf916axAV6+j7N8z25YQkhcVMczFYZ+8
 Zt1cgoIige93KGpK2E9xD/EZwY3hdSQWvC6MXJbyi0KvJQCU1Ae0R4JnKpWLjZswdaqFrm8pYa4
 gSL3wlxHFBgj4l4j/QA==
X-Authority-Analysis: v=2.4 cv=Cfw4Irrl c=1 sm=1 tr=0 ts=69d89b3f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=Q3NZNqj7fC11OLhnbCIA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-GUID: jJ-X7rzwTHoc3DF3o42GknB1GWtZL37v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100056
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Seeking guidance for contribution opportunities and Areas of
 Improvement in LTP
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Dear LTP Maintainers,

My name is Priya with experience in automation, and system-level 
troubleshooting. I am keen to contribute to the Linux Test Project 
community and would like to understand the current areas where 
improvements or additional contributions are most needed.

Specifically, I am interested in working on scheduler, security, IPC, 
syscalls, memory, and filesystem components, but I am open to supporting 
other areas where the project could benefit. Could you kindly share 
guidance on priority tasks, ongoing challenges, or areas where new 
contributors can add the most value?


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
