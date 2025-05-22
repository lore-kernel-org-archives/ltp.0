Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543A6C54E65
	for <ltp@archiver.kernel.org>; Thu, 22 May 2025 16:14:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6111A3CC876
	for <ltp@archiver.kernel.org>; Thu, 22 May 2025 18:14:35 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 004143C9FDE
 for <ltp@lists.linux.it>; Thu, 22 May 2025 18:14:18 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9D0251000419
 for <ltp@lists.linux.it>; Thu, 22 May 2025 18:14:17 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54ME2a6K006586;
 Thu, 22 May 2025 16:14:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=zeAta8zYUnUBXh8XK4a8BaLPKE/eqB
 Dyqb+FZZJLt4o=; b=rRbdRefj6fapv7REBTNi53xMt7u2Yq9mh/C5xy6taIelyk
 R4kjiciUNe3hoHhK4di6mTN56zwQSfUlgvvfhIAO+NDrAD8DSGy+wRz4V2dBWqEv
 WG8GzExF+8O2PfUgpl074BL58wjc17MWoSagf1VtYdCxhGb7b+QFZ9vJPoWsI2Th
 ZzAlBZKKrc0sWWMrRDLwK+vpDgl8zqaAGo1Jed57eAzPeYnE5KX9nEXmlqhsxu09
 N+aGFgTsSK3n0mdX80KvSF72H+ZoHRcx9dnfQIPRj1dlhW5QGe52i+OgJ1TzRqZ3
 /SuZWg2rQBih/JZa8e56l5oc7wUgDH3mPDbRmi7A==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46smf9dbn8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 May 2025 16:14:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54ME98aN032014;
 Thu, 22 May 2025 16:14:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46rwmqa6gg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 May 2025 16:14:13 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54MGEBQJ51708276
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 May 2025 16:14:11 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A7F4D2004D;
 Thu, 22 May 2025 16:14:11 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 691BC20043;
 Thu, 22 May 2025 16:14:11 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown
 [9.111.61.232])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 22 May 2025 16:14:11 +0000 (GMT)
Date: Thu, 22 May 2025 18:14:09 +0200
From: Jan Polensky <japo@linux.ibm.com>
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
Message-ID: <aC9NUU0M50baaDlb@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20250521095302.13845-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250521095302.13845-1-chrubis@suse.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NJbgNX4vcOfZqR1Jx6jxvxFyNcg1TEqC
X-Proofpoint-ORIG-GUID: NJbgNX4vcOfZqR1Jx6jxvxFyNcg1TEqC
X-Authority-Analysis: v=2.4 cv=TbqWtQQh c=1 sm=1 tr=0 ts=682f4d56 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=leBozpLI6-z0OGz230oA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDE2NCBTYWx0ZWRfX2ZFzshzPAD6n
 BPWcJs6C0zp8kXfHixYHexMcG3ieu6uzBec8JgR9jvEaqnAZ0n3Ln2YucA9+lxgZYb/JHRam7+M
 33yCmIusn04tobXYM24QSd4ozmNKYLM8aeeonIqYAvjrKs4ye+sJSercFW0X0qRHMaA5EsTh+xq
 pEwL2lMU/R4lHh/yjhz3h7rvlLm1ZUL4cU8rj8lZlZIn0W686qUoY+uNeYdXQDHS3fP+6wotd9e
 FSGNmFLWV0O+yJKbITEzk0OAoSqWXxc4ZSonYuhA8rfGwfe9wfwG5Z4Am0uKb+8I9JSmXQdZWbz
 +mpcZ70m0mLTSAi6+eTAu27LsVLacTmAs0yrP7DHBFcPzHO4OlfV+UrdI4ZpqN2hryZCXCQ5ESy
 WrcWpfqQe6uOshtJ8FRH4n8bIrutLVxl25Y8z61rxxNRpGqUBwJjoUDFiQNjCdpUBorpMT8x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_07,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=779 malwarescore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505220164
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: LTP_SINGLE_FS_TYPE fix fuse blacklist
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, May 21, 2025 at 11:53:02AM +0200, Cyril Hrubis wrote:
> The case of LTP_SINGLE_FS_TYPE did not proplerly used the fuse
> filesystem blacklist and we enabled fuse filesystem even for tests that
> explicitly stated in the tst_test structure that they do not work with
> fuse.
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> CC: Jan Polensky <japo@linux.ibm.com>
> ---
Tested on x86_64 and s390x.
Reviewed-by: Jan Polensky <japo@linux.ibm.com>
Tested-by: Jan Polensky <japo@linux.ibm.com>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
