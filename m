Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76F3CD6E74
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 06:19:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 001133E16C8
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 08:19:51 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A8E233C5601
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 08:19:35 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B41D51000544
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 08:19:34 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654NjCXg3938571; Fri, 5 Jun 2026 06:19:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=uTAvvb
 BeCyyLAAk9OomaC/p88gYoOeZHLioeSgWDHaY=; b=Y1SyDYyfp68I5PvPAx2Ezl
 nY6fK+IZXI6OVzqw3+siaZuCo49I58cmcY4R8RZKwF3F+rRX7+GVxSOf9u4VlmDf
 YZvZT2Wwin891XW6Vh4n8k1WIC6uDcHRbjnNHD+1JZbVHiQagua7cnvPY42wHH0Y
 DjP2kc8fUhAQsGY8HWyjlcHhY6DNWE3W8R0OeinthE31usZAEOP3O7fBreQQj8Bx
 WCooYFR5wst3CDjUVY2Ccz4iN1m2JzpeE34V0ZdUEmmSPGCXMAobtpzUYAhsYr9c
 Hff/7EMsiNkajjFixa3NXErPWI2HLWAUemBObzm0eCkqXNylcCcFy3KQB61Rj8/w
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd4k808-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Jun 2026 06:19:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65569CUj015710;
 Fri, 5 Jun 2026 06:19:31 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egceh06ys-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Jun 2026 06:19:31 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6556JUKR24707726
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 5 Jun 2026 06:19:31 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BBDCF58059;
 Fri,  5 Jun 2026 06:19:30 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DD1CA58058;
 Fri,  5 Jun 2026 06:19:28 +0000 (GMT)
Received: from [9.43.79.44] (unknown [9.43.79.44])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  5 Jun 2026 06:19:28 +0000 (GMT)
Message-ID: <f280507d-41d9-4496-a90d-49ecc7fff8dd@linux.ibm.com>
Date: Fri, 5 Jun 2026 11:49:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20260604065417.25924-1-sachinp@linux.ibm.com>
 <20260604065417.25924-2-sachinp@linux.ibm.com> <aiFUB1QyVXZcM-ah@yuki.lan>
Content-Language: en-US
From: Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <aiFUB1QyVXZcM-ah@yuki.lan>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA1NiBTYWx0ZWRfXyse97NFvFS3Y
 S5v58Y+QggJ1nitJ/NgLKsYhbuqxlgVADBG+B0Y6W1uj6EsRGnTmDFfOQ+nMp9AY9x1XKNnANgV
 md12/HInZnP2ztm81BVfcPQihxAlHa21avzJ81ouMpxa8djAVkO0/rfEEGnbIwQPMEm+a40ziTy
 qbdpYAdiVNmrVm+cL0gApsublhD8bJjttkMDqL+ueSraoLmK/uGj5fb3Se3qDUVQfOlzx0CQ9n3
 eGtvYhf4FhFFEQdYQgP0VVGvy/h0hRKK80cV8UZoBGAuHAYSIJTrI1U78eLYY9v527bhqQXSezr
 A0hpa80swZnSyxfTxMgqL5xxVwkojdIZfpV1xZeVYgQx6guOtZjEfSicHCBZN09u/ctvxXM4QQ/
 /wleZha/bVmgo49b6iM28f2Ax+FNQBiZ8oRYYmxqRf7W7fWf1YKxnQPm2jJhThYKuEQ0cdKTQXe
 gUS9D45V/GUbJaPZ2Hw==
X-Proofpoint-GUID: KbBA7CQkktVGSSytsgX33IUWAJRLL3m9
X-Proofpoint-ORIG-GUID: KbBA7CQkktVGSSytsgX33IUWAJRLL3m9
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a226a74 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=LjBxtAbWovG118TDkCIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050056
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/8] fs/acl: Add ACL_USER_OBJ permissions test
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



On 04/06/26 4:01 pm, Cyril Hrubis wrote:
> Hi!
> I think that it would actually be way simpler and easier if we avoided
> the whole userspace username to UID lookups. The test does not need to
> create users, etc. if we simply focus on the kernel part of the ACL
> implementation. For that we would create extended attributes with UIDs
> (that is what is stored in kernel) and then we could simply run a child
> process that sets its UIDs so that they match the rules in extended
> attributes. That way there would be no dependency on libacl, no
> userspace lookups and we would validate only the kernel part, which is
> what LTP should do.

This is an excellent suggestion. This will avoid userspace 
username-to-UID lookups
and libacl dependency. It simplifies tests while maintaining full 
coverage of kernel
ACL functionality.

The existing create_file_as() helper already demonstrates the 
fork+setuid pattern
needed for testing with arbitrary UIDs.

The logic can be:
- Use setxattr(path, "system.posix_acl_access", buf, size, 0) to set 
ACLs directly
- Build xattr buffers with raw UID/GID values (no username lookups needed)
- Fork child processes that call setuid(uid) + setgid(gid) to match ACL 
entries
- Test file access in child to validate kernel ACL enforcement

Let me know if this approach is acceptable.

-- 
Thanks
- Sachin



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
