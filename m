Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA923C43458
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 11:47:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C9DAE3E5BC6
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 13:47:11 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F9073C9911
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 13:46:56 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A12C11000A1E
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 13:46:55 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AAmfgV888753; Fri, 10 Jul 2026 11:46:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=fp4oQzbaGDSGnET6JJ1Qkamgq/e6Q6
 x3AetCNltfw1g=; b=SlsNHSWnQrP6xF+GcselzIg25XPv0lRfzsb3OHmJcqmpqy
 Di8vmksA0dGwT+4HIMeiiMXd/bA3j1u6tYsldfhvLl/gu9pjeiWMwU5wf6m7WeeS
 EEOtSX/bZU9ZI15aj1C/jaFJt4x+kT0MaI0u+aD85OnnVgiKFvWchW79rMHfPeMU
 3bPgP78l/mi3ZwWynrweXLwNrgzwe2Ky4Wz/vjKaNpcEaY7lNyDg++QMezqLhjW5
 3iyQ1dEF9qHeSsY53OSZ/abGoVby3hFbOHzp+lvH/mIg2/EkYilvE3vDTQwd3TKY
 nCBGt2k7xE9ATt0vTUAzt6zKdbi8Yw8mobo4JyNA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fafh0bs13-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jul 2026 11:46:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ABYf6s001594;
 Fri, 10 Jul 2026 11:46:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqghkxp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jul 2026 11:46:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66ABkogs46661944
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jul 2026 11:46:50 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2878320043;
 Fri, 10 Jul 2026 11:46:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EB5E520040;
 Fri, 10 Jul 2026 11:46:49 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown
 [9.87.140.3]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 10 Jul 2026 11:46:49 +0000 (GMT)
Date: Fri, 10 Jul 2026 13:46:48 +0200
From: Jan Polensky <japo@linux.ibm.com>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <alDbqPsc3ueUqXlN@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260709175927.268677-1-japo@linux.ibm.com> <alDW49sRfwx0eBw5@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alDW49sRfwx0eBw5@rei>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=VebH+lp9 c=1 sm=1 tr=0 ts=6a50dbac cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=d6Zq3oZ6_tHfbCBfB0gA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: tJxAURrXCkYUdjx1mjpL6OCCfItPZyMY
X-Proofpoint-ORIG-GUID: tJxAURrXCkYUdjx1mjpL6OCCfItPZyMY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDExMiBTYWx0ZWRfX4DGPOFebB/uF
 nKO0GWZzZzP2L85cWyX7l0A++PnSLqm1qg2PPdvrrjPfWHQ05ItIqv9EAHPRau2/roDYDsZWA0x
 LvsDzUMvRWh7od2/RO8JfcgtVQZv8BE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDExMiBTYWx0ZWRfX02hgn5pkaDb1
 EsC9NzdTgxzMO3YLsr16YSJEzUeOq85TZ017ebOHxsHIVftZaQtCUdxu3kLNB43+yBvEyMxckVh
 tcwBx8JktCPJmeREFRc9LXezH2IHzbrGtmvK+Rm2SYApFfoTdiRTk2DEwdmIEaoHjn2ogfXJ+YR
 c917rtmJXdpFHZBCmCwMlbVSaDd+jff0CS4HLUw+/2kvvAoE4csRc2zKo6Q1fsiL6LO4zyX361V
 uTGv/UJccxyqbtDK4GJRNymbLORJ6xxX+j37V6Kr8Sb8japYwVpQ4KT/IdXo7UWMLIz2ivN++vm
 iAZ8qI4wEIJSbhPOs+EWwDfb+dB5MfcrshNs8ryH3NiFQNp2HpA1gCdermqi/DA0uKQsuAsEVjV
 RcLmnWsHRaZstXtoiLXrirPED3WX3AeLY2aCrd8NDiNJHfaCDuJ8Hjx05e/KtjjcWHUtPA83Th5
 kFwMqgO9PFuB14Hq4pA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100112
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/1] thp04: Add ptrace mode and fix tracee stop
 synchronization
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Jul 10, 2026 at 01:26:27PM +0200, Cyril Hrubis wrote:
> Hi!
> > - Note: Serialization eliminates the race; tests write functionality
>
> I'm a bit puzzled by this line. If there is no chance of hitting the
> race wouldn't it make much more sense to write a separate ptrace test
> that would excercise the parent being able to write into child memory?
>
> --
> Cyril Hrubis
> chrubis@suse.cz
Hi Cyril,

That's a fair point.

The main goal was to keep thp04 functional on kernels with
CONFIG_PROC_MEM_FORCE_PTRACE=y, where direct writes via /proc/self/mem
are no longer possible.

Do you have a preference for how support for that configuration should
look?

Would you prefer:

  1. Keeping thp04 focused on the original race test and skipping it
     when only ptrace-based writes are available?

  2. Splitting the ptrace write validation into a separate testcase and
     leaving thp04 unchanged?

  3. Some other approach?

I'm mostly trying to understand the intended coverage for
CONFIG_PROC_MEM_FORCE_PTRACE=y before making further changes.

Thanks,
Jan

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
