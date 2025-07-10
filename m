Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A94C83F0F
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 03:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752117079; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=QIyhsRsPaLD13u5K1vY0qqLHmucJbZ4xR0uXvWeKdqI=;
 b=Lvy4g/C8Rtx1vsYdjuOA9jzt45PLd0lCR+WjQpUgfmVs7gi7p29T2jhKI7Q1nY6W36qkw
 dhie6NdBT5ITSQ2E6L0D+bL5JhkSOzFN5BNonl8fwHE78QMheYGZaSQ2Xq/NJdNd8A4m3qs
 1vJ6q3OqGjasCAMefezIkVYXLNE+gwU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ADA083CAE45
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 05:11:19 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 528AF3C73E4
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 05:10:58 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 283C4600731
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 05:10:55 +0200 (CEST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A0uDTb014483
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 03:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=C8GD71NMUqyCLGNSbw7zq043
 YLRGNSn0ZiEAcpFzHjQ=; b=NWHgfOMzeG+J7Nn8DJ0IZFPJb2qXshoqa6YLW0u0
 R5MEgdCJ0T9VS2e0311NhAzPks7zuVLG3QEimOqYbBAaJmgPIXxEyYVgH0cUfsGn
 8UDG9D6iWmFbkzf5Icoo7tBQVproDjxNHdrbcAoKPBYI2tvbY9aYYe5G47Nux/K2
 oHNg0YdNrx5PrbF8PYDYV31tB0jUoUUJNHEm7Cn70HtYzZyoAFD/aPJ+Azj991oy
 B4eI8k7rm5vh4FMcP+B1RHJrMetyo+6FFFf+s2muD57WCtwcgdxMEl52wqYijWPJ
 A77/PxBSlBLioqwo949J1K2OhYD9FdWAWEHNMAc3Qf1qDQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47r9b144x0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 03:10:53 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-315af0857f2so637532a91.0
 for <ltp@lists.linux.it>; Wed, 09 Jul 2025 20:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752117053; x=1752721853;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C8GD71NMUqyCLGNSbw7zq043YLRGNSn0ZiEAcpFzHjQ=;
 b=XmX8uq/f9euFxd1e1IWXkt602//XIbLSGeVA/Qwcz4lNzXSu+A1Sey7hRHrJO+5tHj
 nYUG+dpyjtK2fyztHh2hpZvvzzZqGE4Sr/q0BByxOi4ra8M9MC3vA4raczzyBMpehsPe
 CsFh/IYtyCBl8P5mTQH+B2vFHmvo8RR5e0vdPbAkx+KNrHXZxWvS+/dwMd6AwdmaUQma
 vnwvVqBMpmrBQ3m/K5sZDdkmSHr8stwWcovlhrqRtNQYrMw6gjVllEepSZc5uzR5ZC8r
 2vjhwFKaGZzbuvEr2kIY1ZD/hExOTBVb6A53JTRQnSmNfdmJ0fSfkhTwm+GCUEbZYyE7
 cqGw==
X-Gm-Message-State: AOJu0YwXVuPBlVEDMm7FdM/ud0UKnBjSE2fgJOym0o3Dn7dHCsNCJd7R
 jJjGOGmtUD88qnqKdja98OsJZhVFOwPKkZ/tEvzeTQkMjIX8FJxgmPB7RpnsGALgAEK64pwqAH7
 fYaZYYegETtNhlybvDEnoZZ5Q5n2xcnFzzmP29Ec5tz9sr5OdQmpbvg==
X-Gm-Gg: ASbGncugyv/TWwuXIXPWnuZYChl4L4sBneH6ybFCsKUAzGEePPcJfj7gll/eE1P3LQf
 rK2TUJ/RdblFvek5EaHHA5dGJpO+l5H9o47x4Doe3ZiJIdzDm/DJjhym1PYUlV3lfPRQeXhspZk
 FNZk8WlATujYsYXDHu3G7C+WzEHgWZ8dvmyC+2C4d6qnA1OStU/ngvBUH3A2h3L/IAXzzEhC3TR
 rJBlmuod8ZBs2naXfcB9oV3dFd6HaiPMEZFhv0drYsFdKr9JdW8brflcDYdL+NB0BUgaGhEMQhA
 Dac4GlKmoW0ItSZ1VOh66dKG1kIwAddRzfUSbNBOiBGaqZDaEqoZLypWipZJET/FzaiNm8zLQnx
 5
X-Received: by 2002:a17:90b:35d1:b0:311:ba32:164f with SMTP id
 98e67ed59e1d1-31c3ef6ff56mr1835225a91.8.1752117052575; 
 Wed, 09 Jul 2025 20:10:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS8E/NJXNeqyW7kqNa+k0+ElNy9MUFKpxPT2B1Qq96r6xEs1IJ4Pf2jKzyXd3M9ENP/wKBuA==
X-Received: by 2002:a17:90b:35d1:b0:311:ba32:164f with SMTP id
 98e67ed59e1d1-31c3ef6ff56mr1835167a91.8.1752117052056; 
 Wed, 09 Jul 2025 20:10:52 -0700 (PDT)
Received: from hu-mdtipton-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c301a8862sm3653576a91.37.2025.07.09.20.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 20:10:51 -0700 (PDT)
Date: Wed, 9 Jul 2025 20:10:49 -0700
To: Wei Gao <wegao@suse.com>
Message-ID: <aG8vOXhoS/F3IEng@hu-mdtipton-lv.qualcomm.com>
References: <20250709151439.2840206-1-mike.tipton@oss.qualcomm.com>
 <aG-1OzeP-mB2MPq1@MiWiFi-CR6608-srv>
 <aG8bYZWlls9MiJW9@hu-mdtipton-lv.qualcomm.com>
 <aG_JlPhs4DMJfVEi@MiWiFi-CR6608-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aG_JlPhs4DMJfVEi@MiWiFi-CR6608-srv>
X-Authority-Analysis: v=2.4 cv=dYuA3WXe c=1 sm=1 tr=0 ts=686f2f3d cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=5bnX7-EcccOwkvf7-l4A:9 a=CjuIK1q_8ugA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDAyNiBTYWx0ZWRfX/O1J5uisZh1u
 Ht73/YeFbczOhlhqOxTys0AnmgBLes+GxE5nbCTj+cB/+jteMe6wHeBvUhCt2n7jKSA85fbjf0O
 N8iFaXaI6JbtkXGA7SW4tlxz/Pg7nSFiXkiDNtQ2ml5HNqjU4yOskz0bPfRMTNIetfx7EPf1LtS
 5y/p/UER5N0wMmieOuDe0ky70npwIAnJc07mQVBWwXN6PQGQOipISZKzLaJHn0zJ+gROZJKyQPU
 lTBoDrub1LoWUzvPTWkn+ngpMCyFxFq5RpRcEqpVRzOSKcjwHmqjQl5yTM3YNXWRFD6Xgs6/rSi
 Fe07JFeAZTw82rUwiMOePjELC7/H80W/W4XmlBwKu6VSp9mvivAcqH7Ppd3TyS9atY566JC3Qw8
 nGm4AfzM5DdIY4BFNk/+hKJhjTZSZsmeVcssuTI6ToN9D1VeEdYm4oAnhUjN3VbY3cNcIjyz
X-Proofpoint-GUID: JBVqgCr1eipzXUMxnxmM-6tmWy7FTKOb
X-Proofpoint-ORIG-GUID: JBVqgCr1eipzXUMxnxmM-6tmWy7FTKOb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100026
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] device-drivers/cpufreq_boost: Don't hardcode
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

On Thu, Jul 10, 2025 at 10:09:24AM -0400, Wei Gao wrote:
> On Wed, Jul 09, 2025 at 06:46:09PM -0700, Mike Tipton wrote:
> > On Thu, Jul 10, 2025 at 08:42:35AM -0400, Wei Gao wrote:
> > > On Wed, Jul 09, 2025 at 08:14:39AM -0700, Mike Tipton wrote:
> > > > Some systems don't support boost on every CPU, such as on many Qualcomm
> > > > chipsets. And if boost isn't supported on CPU0, then the test will fail
> > > > since there's no performance improvement.
> > > > 
> > > > Instead of hardcoding CPU0, find the first CPU that belongs to a cpufreq
> > > > policy with boost enabled.
> > > > 
> > > > Signed-off-by: Mike Tipton <mike.tipton@oss.qualcomm.com>
> > > > ---
> > > > Changes in v3:
> > > > - Abort when no CPUs report supporting boost instead of assuming CPU0.
> > > > - Link to v2: https://lore.kernel.org/ltp/20250630145128.1254269-1-mike.tipton@oss.qualcomm.com/
> > > > 
> > > > Changes in v2:
> > > > - Use proper maxspeed buf size in snprintf.
> > > > - Link to v1: https://lore.kernel.org/ltp/20250626194707.3053036-1-mike.tipton@oss.qualcomm.com/
> > > > 
> > > >  .../device-drivers/cpufreq/cpufreq_boost.c    | 58 ++++++++++++++++---
> > > >  1 file changed, 50 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c b/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
> > > > index 67917b3fea25..17d89c0cc164 100644
> > > > --- a/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
> > > > +++ b/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
> > > > @@ -55,10 +55,14 @@ static int id = -1;
> > > >  
> > > >  static int boost_value;
> > > >  
> > > > -const char governor[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_governor";
> > > > +static int cpu;
> > > > +
> > > > +static const char _governor[] = SYSFS_CPU_DIR "cpu%d/cpufreq/scaling_governor";
> > > > +static char governor[64];
> > > >  static char governor_name[16];
> > > >  
> > > > -const char maxspeed[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_max_freq";
> > > > +static const char _maxspeed[] = SYSFS_CPU_DIR "cpu%d/cpufreq/scaling_max_freq";
> > > > +static char maxspeed[64];
> > > >  
> > > >  static void check_set_turbo(char *file, char *off)
> > > >  {
> > > > @@ -84,6 +88,40 @@ static void cleanup(void)
> > > >  		FILE_PRINTF(governor, "%s", governor_name);
> > > >  }
> > > >  
> > > > +static int find_boost_cpu(void)
> > > > +{
> > > > +	char buf[64];
> > > > +	int fd, i;
> > > > +
> > > > +	/*
> > > > +	 * The files we're looking for only exist for acpi_cpufreq. Continue
> > > > +	 * assuming CPU0 for intel_pstate.
> > > > +	 */
> > > > +	if (!strcmp(cdrv[id].name, "intel_pstate"))
> > > > +		return 0;
> > > > +
> > > > +	for (i = 0;; i++) {
> > > > +		snprintf(buf, sizeof(buf), SYSFS_CPU_DIR "cpu%d", i);
> > > > +		fd = open(buf, O_RDONLY);
> > > > +		if (fd == -1)
> > > > +			break;
> > > > +
> > > > +		close(fd);
> > > > +
> > > > +		snprintf(buf, sizeof(buf), SYSFS_CPU_DIR "cpu%d/cpufreq/boost", i);
> > > > +		fd = open(buf, O_RDONLY);
> > > > +		if (fd == -1)
> > > > +			continue;
> > > > +
> > > > +		close(fd);
> > > > +		tst_resm(TINFO, "found boost-capable CPU (CPU%d)", i);
> > > > +		return i;
> > > > +	}
> > > > +
> > > > +	tst_brkm(TCONF, NULL, "boost not supported by any CPUs");
> > > > +	return 0;
> > > I suppose we do not need above line since brkm will jump out of the test
> > > directly.
> > 
> > Yes, that's true. But it feels wrong to reach the end of a non-void
> > function without returning something. Even though in this case it'll
> > never actually reach the return statement.
> > 
> 
> Or return -1 and handle error outside of the function?

Yeah, could do. Makes it slightly more obvious what's happening, I
guess.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
