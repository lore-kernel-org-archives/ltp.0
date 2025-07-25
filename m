Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E34C87FCE
	for <ltp@archiver.kernel.org>; Fri, 25 Jul 2025 14:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753452809; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=cPvdKSVVsMvscz36cqTn4qWb2D1sbEfS7zk23mddAYE=;
 b=q938VEOP6vghq6EGTj8Iyts7+QGxRcuWmmlZOunnnXDGTFPco7hqB26gMRJhwAKkccPZT
 gGAZcVtJq3nHT2tyNLEmzYS8U7BNTM2Hwvc3gZv1FQSKHuyoU6T+kpPPczHe+1bb39iz+Fu
 gbRxuRJNNVcoPD8p/cBEqE9UgDx2dD8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 247B53CCE95
	for <ltp@archiver.kernel.org>; Fri, 25 Jul 2025 16:13:29 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA29E3CA0FD
 for <ltp@lists.linux.it>; Fri, 25 Jul 2025 16:13:07 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 403586008E2
 for <ltp@lists.linux.it>; Fri, 25 Jul 2025 16:13:05 +0200 (CEST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P88nrj008715
 for <ltp@lists.linux.it>; Fri, 25 Jul 2025 14:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=K0q5wl2CuZClbOrCbH49TRRz
 jw/0TcILUIXhjB98fj0=; b=GnK+sjn7XdJwOGWk3UPRa6RexIXNxj3L5Xsz7ixc
 YpB5gBatpXM490IDGK1HKwo1CGlvV3XHNR7Lp0AESLH3ErjJRSaNL7JL3F7sAPzb
 7QQl97gWmpWZvcdjev23ZhVuCrMJkSzbhDnLwxEGOGHzzbkVqtTnBzT1Dtd0JlX/
 yFO6dJlzqW8KW2u9icfW6mF19hzt8D6IfXu5JF6g8UxJNWA1+frHatqEDAoRowjg
 b4+CT5SBjgGS5p5yMKfu2E5j4AUmCriM0nx0l0fo9lu5wctjKlY6OnAfG3n8p3jY
 2RusRnbVhUP4hWEZFhCQfHNjZV+dlMoYdumRq3sEFUU8Sg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4846590ypj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 25 Jul 2025 14:13:03 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-23494a515e3so17503935ad.2
 for <ltp@lists.linux.it>; Fri, 25 Jul 2025 07:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753452782; x=1754057582;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K0q5wl2CuZClbOrCbH49TRRzjw/0TcILUIXhjB98fj0=;
 b=tPNFOMz90+YUMmdAnp9Lv2zazi8TPXlQ28+P+ZUbONviKiguobY2z0mTzm419yLmoi
 Te9zZsKiJfKdASPsnfybaQYDdIWy7xpXdsHD3Fa/NhbTx6QuELfquZkSg5h3CXuG413O
 ayoVFA8XdKEWuLB49Fihnqc7Vwqjb7pJbIZ9tNYtLFOfdEHF2K44XBoQRsqOAR02glOt
 LlMpaYKHwTC4I+MQg/yL4VZfUnwrG4mY9rD5hKuml/0DI9B/Q7ZMK4/WKbswKUjyAYDT
 TNgv81+SKGOcnGPncLH6d3HC9IrVzZhh6ZgNN8dRlabgxAy3W2djbkbaiUqYcjIf5Xgd
 Hg+Q==
X-Gm-Message-State: AOJu0YzZ4/9ojf6iG+P7jKQcoqxbpeXj8sucyuPTOKEHplS3X0FqAwem
 04c5dJssVENUcrzS6z55PE485a0K8+RctkUIg8dDhkk2SB/msuqqDzFyRugJQuPzcML/ra5y8xi
 qnc0OS3h2Gi5hcH48D0UnaV2NxYSokdM5Jpax1RkcuZyvlHkmh9t8pQ==
X-Gm-Gg: ASbGncvwZ9qAYkMW9vS4H5HtHjlfPCbUoTIhu3b6BQUunNJNx3icG89F74EnZ5pdP0A
 vMQ0kzwqUSrTj43sMKj+vibImCJzkFaSht/PwwI7gctDZopru54zxeZ3YhmzaXczwSWVfqxsSi8
 4l9XXx/p6LXyruPPKoAheKIILxg8N60DPWiEswLqDPLyVIfUOM3gsA3nqjHJgTBiUYpxGtAQYkV
 pcpi/kOj4L8tTvkQVlgBErETLNyJebi4MN0OAp0FHptXzbsC/B3j0gykvnz8/aN2IJZkdIsYlol
 Fp0BnY2TL9kLNqfmwZj9jFvRtEmDfuH78g8fSO7ZYql93iM+TDhMhNtCTxUzVgdyq1WrYGK8d6z
 9wLxp5F9Csv3UJbEMYA==
X-Received: by 2002:a17:903:1b2b:b0:234:cc7c:d2e2 with SMTP id
 d9443c01a7336-23fb3050848mr27721215ad.1.1753452782672; 
 Fri, 25 Jul 2025 07:13:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyQh6EKV9e4oxnkVago7cYZITj21YY5qNo1LCM6FiKc4U6Sm521k8i0Dar96q6G6bbqjXspA==
X-Received: by 2002:a17:903:1b2b:b0:234:cc7c:d2e2 with SMTP id
 d9443c01a7336-23fb3050848mr27720645ad.1.1753452781939; 
 Fri, 25 Jul 2025 07:13:01 -0700 (PDT)
Received: from hu-mdtipton-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fa48bc73dsm38299205ad.89.2025.07.25.07.13.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 07:13:01 -0700 (PDT)
Date: Fri, 25 Jul 2025 07:12:59 -0700
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <aIOQ60MoHO/OJm/k@hu-mdtipton-lv.qualcomm.com>
References: <20250710170255.4190556-1-mike.tipton@oss.qualcomm.com>
 <aIN5Btk4Sn2azE14@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aIN5Btk4Sn2azE14@yuki.lan>
X-Proofpoint-ORIG-GUID: Ddn73s2qxRi5m7JlHG2GvcM233ffEa6_
X-Proofpoint-GUID: Ddn73s2qxRi5m7JlHG2GvcM233ffEa6_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDEyMiBTYWx0ZWRfX79W+qEX8Wehz
 M+XNuskpe5e6pf7Hkb+5VvA7ePeAAwsFflEQ09S5Zyr1FbCFqeuiAZwCbiM49GaqdSqGqr7IryG
 JTbsMeZYtSSxotNkpwnLd9ZLw2AfAfRZiT8R56TBCp2+VEOMOGi+pp2F5uCZjG9A4Z0Hyiv15go
 lxLuGJi+VaIVkobePGPZXg/TjoMDuz7bSVM3Gg0TOuDOGQf/i5Hk1kNDRmnV1sE3vbsGq5s++si
 Rdy35yFu1amfgKNJbQoBpLQkAJlpf81JTtWxtps2BGR7csnuZKXFtw5oTEkP+nZYEL9sPmhXCe2
 D3tzTPJK6YID+RJEj8xgsjy/ArFwgwWkjidY2EeXLFr7TUu9bPP8hzrzdE3Gc20e5egvYfsWq9m
 v4YwM2nl9A1s8TtRDBz01c8+G381Iy3rYUpTkaVOfFz1ABNFqerYIl2QV9bsVOF9LT3vlERl
X-Authority-Analysis: v=2.4 cv=Vo8jA/2n c=1 sm=1 tr=0 ts=688390ef cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=7TYdTqYm_sxmDhDp_JAA:9
 a=CjuIK1q_8ugA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_04,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=893 adultscore=0 impostorscore=0 suspectscore=0
 phishscore=0 spamscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507250122
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] device-drivers/cpufreq_boost: Don't hardcode
 to CPU0
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
From: Mike Tipton via ltp <ltp@lists.linux.it>
Reply-To: Mike Tipton <mike.tipton@oss.qualcomm.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Jul 25, 2025 at 02:31:02PM +0200, Cyril Hrubis wrote:
> Hi!
> > -const char governor[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_governor";
> > +static int cpu;
> > +
> > +static const char _governor[] = SYSFS_CPU_DIR "cpu%d/cpufreq/scaling_governor";
> 
> Identifiers starting with underscore are reserved for kernel/libc
> implementation we shouldn't use them here. I guess that this would be
> better as governor_fmt.
> 
> > +static char governor[64];
> >  static char governor_name[16];
> >  
> > -const char maxspeed[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_max_freq";
> > +static const char _maxspeed[] = SYSFS_CPU_DIR "cpu%d/cpufreq/scaling_max_freq";
> 
> Here as well.
> 
> 
> Other than that it looks fine. I can push the patch with the change from
> _governor to governor_fmt and _maxspeed to maxspeed_fmt if you agree.

Sure, sounds good to me.

Thanks!
Mike

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
