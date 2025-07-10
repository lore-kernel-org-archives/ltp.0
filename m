Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6D7C83F10
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 01:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752111999; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=TVU7/X4iymflgU9X8SZCl050qoD/KmZESpVzXui+Y4U=;
 b=Hzyrl2QcrlstN2tkycTc6lcxPPycNmKSde0IacVho+JZW0IxI9QzTESjOjwDxYoXgTHyV
 6cvP5+nsxI0ENezR4/Xs9LieoftuGlofLqtaX6huAAkfKq/TDJZ7lwDV6KvT6DPB3+M7uGX
 SE3iObnVLDod8OXpmxoIPDcm+QALtf4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E00393CAD71
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 03:46:39 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1FC573C65DA
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 03:46:18 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 488D12002BF
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 03:46:16 +0200 (CEST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A0tqcQ002824
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 01:46:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=CFSq5biy33Dhg48FrkRG4qgS
 5589vUj+u+srVmzOd6o=; b=JrIn/36dVo8Lwc+6ICk+c2EDKh6NcsNKol0e69T4
 g6YwT6t91OCWdb2yZ3NP7Fkb5xLiih1XerYNODoVlTeWk/52LYfV1YTCCbkn97tg
 OKGAn1E11MV+DaH3pIuc7q25ywlWkFzuD/dJtY/Cv4BjxXG3J+d5i88KZgOZHc9d
 0khgkiSGwIS+J67p3ztzfT7O5o+/ghxLtNzqk/gC4iV4XSda4AWmmN0fpg4b1xyW
 K1K6gP78e9AN5qRTJsJnF42/C++ZFxccMCwGq7J3ih+eIYS27Z+Penp38ztrNrGZ
 dfW1u2Fvzklywr+U7NfS14BaE05Uth0yQ/Nrn9xI1AvIeA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pu2bec7p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 01:46:14 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-748e1e474f8so740124b3a.2
 for <ltp@lists.linux.it>; Wed, 09 Jul 2025 18:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752111973; x=1752716773;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CFSq5biy33Dhg48FrkRG4qgS5589vUj+u+srVmzOd6o=;
 b=Bl6gQvIhVPrVbAWk5FD/jXLoFMxgqSO2sJmLGoZXoY2X4Yu3jSixBIVlCzJybXMJmu
 SFVezUhvBqaFSiGKZi1InwUuv3FW+rSA+74/MKIdga0qGRx15MveGaZe3dxzvUxZj8h/
 2JIMql/ieiLOzfYtraBDKm/HB+L1T6uvDBNbow8ehWCiVhVeo1iPXrEFOAOSPXN14iEV
 FdCaWMjBScK1uzpiztBqCAebVfpiVEWdOzdsDYRhNTbdTWYt+J88c//DJjy4X2b4k4Ip
 B7M6yCB/qg9bZkLZlKTdrvsUS/v7VlL3qAz2y40+IL/do55QJsIBgBFyB1+mFREbadnx
 cGPQ==
X-Gm-Message-State: AOJu0YySh5KkNhdmQ+lSQv7kMrezQ9XDOAnFSQprhnpdAAFjMinrKbEC
 d+mLiOW4r6owQqLhb0UaQGs8KtAU5CRUNiqfUZC6FjU2Y2VDLrbmx3OrpBQnksfMboyHA26nZ+x
 leAOlu2X0gdImlDB5AJqWzx/viQ/GHaAORnPecxj+301WzdfEqep7vg==
X-Gm-Gg: ASbGncvFBz1QChgMU+SBDFaKfJw2RoSOcVwHOUvU0xRz057HIV36PFVHrlQwMHcsawz
 Pz08UYv5JNmJCGb7KODtwMOqkBzn7EBsdvjuIYtMzoxLrUAEDkUKPNBT0lM0wAC6emX0kXctDVt
 v1a/BfLrjq58FcmKPFdR0sMZNCoPB9MzJsBBuVq8lgbCUwSPyLA9P71BP2lRllNxllZwo2pagrp
 /w8iF8q46Zq2QXinzYSPO7kDz713YvkBcneOoQAOmGVen88u4QHwPt5jBs92YVx/HFn3Nqmk1Jm
 iLAmFfOSzituqpzOSxAXdd5t9QEjna1WyqPkPTNSNyjmtd2ybqWCXIZ/LILXErSVFlaHyrdFtL+
 F
X-Received: by 2002:a05:6a00:2d05:b0:736:3d7c:236c with SMTP id
 d2e1a72fcca58-74eb8f67e16mr1124479b3a.14.1752111972872; 
 Wed, 09 Jul 2025 18:46:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmybCt8kgQqRxMk+H+Csthqm/ezWb6c/HldalzDfroyXjqBM+tNm/xQHmEm1CKVbdfEv9Ytg==
X-Received: by 2002:a05:6a00:2d05:b0:736:3d7c:236c with SMTP id
 d2e1a72fcca58-74eb8f67e16mr1124449b3a.14.1752111972438; 
 Wed, 09 Jul 2025 18:46:12 -0700 (PDT)
Received: from hu-mdtipton-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9e06a04sm364353b3a.44.2025.07.09.18.46.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 18:46:11 -0700 (PDT)
Date: Wed, 9 Jul 2025 18:46:09 -0700
To: Wei Gao <wegao@suse.com>
Message-ID: <aG8bYZWlls9MiJW9@hu-mdtipton-lv.qualcomm.com>
References: <20250709151439.2840206-1-mike.tipton@oss.qualcomm.com>
 <aG-1OzeP-mB2MPq1@MiWiFi-CR6608-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aG-1OzeP-mB2MPq1@MiWiFi-CR6608-srv>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDAxMyBTYWx0ZWRfX4qIlD4sp5hkj
 kNYlXEZKvhyjji5A00QW+6EMq9jy9EVnCVds1J/cMoNGO48Y1mDx+gmw0sQP2gidL+YUKb/pbnn
 Y/fQpXoHoMyHpOaKJnakpHBb2XHkz04QVBvs4BZx+EVt6K6ng1708KnQoiiiUVgdli7lkHEnsdg
 ELIWrJC3xIiRANd2IVjKl2mXhrFwD+X+DjszQm+BmWu5sWJ7RA7KD+Uc6XDsFDPdsI3WYUXemQR
 ohzy7cvvKdk7gxQDxFrOrw86cOffDADunv1NdhCNKr76Kq4RnDtuLQtoMZ4cHJpPCabtt0P5K+i
 TkuUSw+hs6Bug9nC8n+pzMF7loKustQTkeqzMxSuqGe8N3+IfUx/PdFDBVL6pDqGw6F+WKUvP9Y
 JchGm1o7pGW4uFDeGXv8ayE17FPEHxxd4Emh/6ZUQbLAvtNJtY0IGpkXuRCJkloNhFQoB8QX
X-Proofpoint-ORIG-GUID: q_U8YGeChq1-VP_KT3QmysiNxA5tMN5g
X-Proofpoint-GUID: q_U8YGeChq1-VP_KT3QmysiNxA5tMN5g
X-Authority-Analysis: v=2.4 cv=erTfzppX c=1 sm=1 tr=0 ts=686f1b66 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=iox4zFpeAAAA:8 a=qCBJvXPrj-7--cnkmfEA:9 a=CjuIK1q_8ugA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507100013
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
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

On Thu, Jul 10, 2025 at 08:42:35AM -0400, Wei Gao wrote:
> On Wed, Jul 09, 2025 at 08:14:39AM -0700, Mike Tipton wrote:
> > Some systems don't support boost on every CPU, such as on many Qualcomm
> > chipsets. And if boost isn't supported on CPU0, then the test will fail
> > since there's no performance improvement.
> > 
> > Instead of hardcoding CPU0, find the first CPU that belongs to a cpufreq
> > policy with boost enabled.
> > 
> > Signed-off-by: Mike Tipton <mike.tipton@oss.qualcomm.com>
> > ---
> > Changes in v3:
> > - Abort when no CPUs report supporting boost instead of assuming CPU0.
> > - Link to v2: https://lore.kernel.org/ltp/20250630145128.1254269-1-mike.tipton@oss.qualcomm.com/
> > 
> > Changes in v2:
> > - Use proper maxspeed buf size in snprintf.
> > - Link to v1: https://lore.kernel.org/ltp/20250626194707.3053036-1-mike.tipton@oss.qualcomm.com/
> > 
> >  .../device-drivers/cpufreq/cpufreq_boost.c    | 58 ++++++++++++++++---
> >  1 file changed, 50 insertions(+), 8 deletions(-)
> > 
> > diff --git a/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c b/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
> > index 67917b3fea25..17d89c0cc164 100644
> > --- a/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
> > +++ b/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
> > @@ -55,10 +55,14 @@ static int id = -1;
> >  
> >  static int boost_value;
> >  
> > -const char governor[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_governor";
> > +static int cpu;
> > +
> > +static const char _governor[] = SYSFS_CPU_DIR "cpu%d/cpufreq/scaling_governor";
> > +static char governor[64];
> >  static char governor_name[16];
> >  
> > -const char maxspeed[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_max_freq";
> > +static const char _maxspeed[] = SYSFS_CPU_DIR "cpu%d/cpufreq/scaling_max_freq";
> > +static char maxspeed[64];
> >  
> >  static void check_set_turbo(char *file, char *off)
> >  {
> > @@ -84,6 +88,40 @@ static void cleanup(void)
> >  		FILE_PRINTF(governor, "%s", governor_name);
> >  }
> >  
> > +static int find_boost_cpu(void)
> > +{
> > +	char buf[64];
> > +	int fd, i;
> > +
> > +	/*
> > +	 * The files we're looking for only exist for acpi_cpufreq. Continue
> > +	 * assuming CPU0 for intel_pstate.
> > +	 */
> > +	if (!strcmp(cdrv[id].name, "intel_pstate"))
> > +		return 0;
> > +
> > +	for (i = 0;; i++) {
> > +		snprintf(buf, sizeof(buf), SYSFS_CPU_DIR "cpu%d", i);
> > +		fd = open(buf, O_RDONLY);
> > +		if (fd == -1)
> > +			break;
> > +
> > +		close(fd);
> > +
> > +		snprintf(buf, sizeof(buf), SYSFS_CPU_DIR "cpu%d/cpufreq/boost", i);
> > +		fd = open(buf, O_RDONLY);
> > +		if (fd == -1)
> > +			continue;
> > +
> > +		close(fd);
> > +		tst_resm(TINFO, "found boost-capable CPU (CPU%d)", i);
> > +		return i;
> > +	}
> > +
> > +	tst_brkm(TCONF, NULL, "boost not supported by any CPUs");
> > +	return 0;
> I suppose we do not need above line since brkm will jump out of the test
> directly.

Yes, that's true. But it feels wrong to reach the end of a non-void
function without returning something. Even though in this case it'll
never actually reach the return statement.

> 
> Other parts LGTM, thanks for your patch.
> Acked-by: Wei Gao <wegao@suse.com>
> 

Thanks!
Mike

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
