Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621981093192
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 09:30:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BDC5A3E2B3F
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 10:30:48 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 67EAC3E180B
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 10:30:30 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7F78A2009EF
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 10:30:29 +0100 (CET)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62K6lBTJ1093922; Fri, 20 Mar 2026 09:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=oVWgsERpOQ4DhYNiSHOdP/F6nnwoB3
 aeiMDQt7ZhJG8=; b=H9vX5VvMMX0jVzquUPZAWsPDzjZRVCfSILf/cbnaywUdAH
 TnIeD8aI7nrJBIIkaWXRv/J8b6ZFE9veCV0Cmsp7KF//Npn2jdigOkj56rN0VwkG
 qPYAIpVN4UQe6PUuiIGkKSyllvR4IqABnoQ+YifaXZk+1YE/sDgd5crvwm1c1/kL
 ARnaHke4g+vUiRiekRV8JdK1tH/0/OIYB3VXiNaGUuxdnHB1wB6+VhiqjqZbOu08
 VFvReB07ovjLXgpjsSF6ZuHH6Dp54lgqKTExVX7+D1wlEP1gheR3N3VXDLEb57Cc
 6SyKTkJ+7WM2L69tQDkLYd/CCZjtmLdamWrzt/Yw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvy6532s2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Mar 2026 09:30:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62K7QNFb015746;
 Fri, 20 Mar 2026 09:30:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwk0npk0d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Mar 2026 09:30:26 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62K9UODK11731248
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 09:30:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0269420040;
 Fri, 20 Mar 2026 09:30:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D6362004B;
 Fri, 20 Mar 2026 09:30:23 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown
 [9.111.70.9]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 20 Mar 2026 09:30:23 +0000 (GMT)
Date: Fri, 20 Mar 2026 10:30:22 +0100
From: Jan Polensky <japo@linux.ibm.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ab0TrgoFMgt6iQeR@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260316122725.122719-2-japo@linux.ibm.com>
 <69bcfb4c.050a0220.196b4d.9984@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69bcfb4c.050a0220.196b4d.9984@mx.google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 36MwyC2E5yzYM7nCDV10sx4MXYk7ySU7
X-Proofpoint-GUID: 36MwyC2E5yzYM7nCDV10sx4MXYk7ySU7
X-Authority-Analysis: v=2.4 cv=KYnfcAYD c=1 sm=1 tr=0 ts=69bd13b3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=iox4zFpeAAAA:8
 a=2FL8jqfjo6Rs2SmAiWEA:9 a=CjuIK1q_8ugA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDA3MCBTYWx0ZWRfX9xMcyCLDBqBW
 Qpx2s40OBJmL95Lrb1/2yxku/P0YirzWvapID/SFhHrxHNBTXbHNsAavet0NvLk+TKqZ3U5ni1F
 UvQACncukK6G3U0ZQRzQgEXkMqsA0+4T0KryIZQronYQlGBUgIMn093aFukwV8E/IHmhA7cDtRc
 mcBsThlzfuGVG6r4kOuxmLyrg94v8CtwvPVGMMzf8v2Owb9UImja6/ZbOn9og6Ue9cBpCH7PHrM
 IU2sqFMO7O0iQVIQ4at2CqvJNjrjZF1cv6ROE75oVDQK0Qw7zFGAygXy9RPVUawkr8CBiV4ZOA0
 Aji1K0chfplEH8qcEAjlhJGTjz+/ajkZX/yXkemHtxcxtJC8wE3mZLKPPpzQb4ihtmTO+icxWy4
 qEY19E5HSroiWprDfH52HWIycqgysohqY3G/TTCcSqd98cF+E5lYj2S8X24NLmYc9H867oBJCH5
 ynXz+g72Qg062bwP8ZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_01,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200070
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] fsetxattr02: Adapt test for kernel 7.1.0+
 socket xattr support
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea:
> Hi!
>
> > +static void fix_sock(struct test_case *tc)
> > +{
> > +	/* dc0876b9846d ("xattr: support extended attributes on sockets") */
> > +	if (socket_xattr_supported)
> > +		tc->exp_err = 0;
>
> There's a mix of `bool` and `int` here. I would just define tc->exp_err as `int`
> and leave `bool` out of the test for consistency.
>
> Also I was thinking that we shouldn't explicitly edit static variables meant
> to describe the test scenario, so we probably need a local variable (also for
> consistency).
>
>     int exp_err = tc->exp_err;
>
>     if (socket_xattr_supported)
>         exp_err = 1;
>
> I can add these two small things before merge if you agree with that.
Yes, please! And thank you very much!
>
> Regards,
> --
> Andrea Cervesato
> SUSE QE Automation Engineer Linux
> andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
