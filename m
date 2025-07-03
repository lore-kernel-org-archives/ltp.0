Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24160C77B7C
	for <ltp@archiver.kernel.org>; Thu,  3 Jul 2025 16:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751559808; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=CtcLyASNyls+f41yj/38Q7omzTGxCl0LT47F98lZiqI=;
 b=bxb4HZW0TSd9ulc67B9pO8nKteLxkCrp6X0qPuZ/vSjrw+RFkEtPd5zbOvXhALVAlLs0f
 yxmsIa3szYK75wXxdrcGncWTyyO38Q0PZ3oyu5UWuaAf/2dMe4EhiCj4UB26W0TjLnnlihq
 qAlQp7rw7Zmav+cQydsqVe1pNbVR1yk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 84C5F3C9BB3
	for <ltp@archiver.kernel.org>; Thu,  3 Jul 2025 18:23:28 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6186A3C7830
 for <ltp@lists.linux.it>; Thu,  3 Jul 2025 18:23:07 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EBE4C600643
 for <ltp@lists.linux.it>; Thu,  3 Jul 2025 18:23:04 +0200 (CEST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 563982vv001269
 for <ltp@lists.linux.it>; Thu, 3 Jul 2025 16:23:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=g+2vIzcYQ95mrdTUC7UfMAka
 SC1xwh+3kBJ1lxyu2uY=; b=NMheVqmdMCtXSUulQdZ1j3MGGNmhYL0ZCcS764Gu
 R8vz7UEy1IYcxGpFNPmnzDwy5KDkoQW3QM7GtKaVI5wENh7Cov1nbzjFu1heujKE
 BObL2CKwJkeZXXx0e37Lo9i73VExUc9md8lWQbzRW33oE/xkxwFsVbAcD3aokVmy
 GeO8ierqalUHrvFoSGA1aNaY/tpepJup7r5FTkv6q3u4gFc64TLID0R+o5XTd+6h
 TT+TklHvYJlj+vIfddU52Ga31+OG4dfT29NFV35qd8QQ86psosvbXkDZD69ZNCFO
 1v8UyUaP3uT4HTOLaEkN6BQDq3onrCkcuNWJyIaYj7WOhw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j8s9s3ra-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 03 Jul 2025 16:23:03 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3139c0001b5so101412a91.2
 for <ltp@lists.linux.it>; Thu, 03 Jul 2025 09:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751559782; x=1752164582;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g+2vIzcYQ95mrdTUC7UfMAkaSC1xwh+3kBJ1lxyu2uY=;
 b=EvxK+NbYr883yrt4bC6g3Wvtf8exMoC6R9NP2tntNIw3FDgL/otYqriy0IrFkxWsJo
 f091jV/U7A7K5frTpOpEoU4xPwhMFpISFYZN7v88BovlLvYDMfjeUrsx9g7Z1YOZTspA
 20HBhiJqodoqM7EfYwUIMn+os27iTxxFmFPLMoA+4fhXiBek268aOshRkdfMn4WLX9GS
 aTtscJP142zwwuadeXMDFoc1wBA4RzNjWzdd3CBL+q4OZr9Inxtp82NvTir+LTHr2iEw
 4IvkaCfTm61DARVPsHX2G5+rTmk9owbpw6lrcAX0CeZJ4ivgHKwhblSEafwjRbeHw6d/
 GvRw==
X-Gm-Message-State: AOJu0Yxn/8PsWXBSz3hIqzJMgN4uBTQMlrj51JpYC++jpKFNfFBVTmiW
 wk+6F+d9nD/fJhMM1Pkr7F6OZ0IRB/iSlwnkw/ouNJSBkgx+pBAez9qqrdwQ21gBtJt1TiM+ciH
 A1GAsqjr+zF98IwSUSDvSSd5lgtfw7hu3wk9SAnnVDiTKWdZsWqjeuj8h+K8P9Q==
X-Gm-Gg: ASbGncsW/f5aA0v58Wc1s/mK+emu04BG61QNzEoLLAT4VWjXNI0QZLeWoCoUxEBIXJ6
 L76oOeL+5mlG1UOIPpi72AzO9wvhlEUMCEWPUjAxhDrpnip2POmo4blV+ZcQo4xSGzReufejEGm
 Ft/7NxhsLM7KSFAYdJ2LpNF+NHahqiHR3N7TakJ4DlGv0SkMyDZtPlzr/ha/dIJl94rkjFOxYG6
 +LJDk7CV287DmCrl+vE792JU8S58OH9i8uYOaT9ftYXR5Q6pVoFoyTrkmOH+XaneTzmgD8r9bv8
 LWRhT3pMe71u2VzWVSm0bu987phrMYACBQPmu3AR7O5pH0f/fZTCglPNu1CjFzOdT8p893OmyJy
 x
X-Received: by 2002:a17:90b:5706:b0:312:ec:412f with SMTP id
 98e67ed59e1d1-31a9d545e08mr5630638a91.14.1751559781608; 
 Thu, 03 Jul 2025 09:23:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKBjP0UoXpfEYQEApJ6lLSmwbbIzOOO10JCWNI2PKCxbnXWDOWPrAHMaJu0XMR8JJj0wpGpQ==
X-Received: by 2002:a17:90b:5706:b0:312:ec:412f with SMTP id
 98e67ed59e1d1-31a9d545e08mr5630607a91.14.1751559781134; 
 Thu, 03 Jul 2025 09:23:01 -0700 (PDT)
Received: from hu-mdtipton-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31a9cc4c8a5sm2808769a91.10.2025.07.03.09.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 09:23:00 -0700 (PDT)
Date: Thu, 3 Jul 2025 09:22:58 -0700
To: Wei Gao <wegao@suse.com>
Message-ID: <aGauYiUnbz0VeaID@hu-mdtipton-lv.qualcomm.com>
References: <20250630145128.1254269-1-mike.tipton@oss.qualcomm.com>
 <aGZ-3eoDE-XDTTPs@MiWiFi-CR6608-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aGZ-3eoDE-XDTTPs@MiWiFi-CR6608-srv>
X-Authority-Analysis: v=2.4 cv=H/Pbw/Yi c=1 sm=1 tr=0 ts=6866ae67 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=qCBJvXPrj-7--cnkmfEA:9 a=CjuIK1q_8ugA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: -OpXo7FjcCKJWC7ay9TJ3Fo39G7mh9do
X-Proofpoint-GUID: -OpXo7FjcCKJWC7ay9TJ3Fo39G7mh9do
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDEzNSBTYWx0ZWRfX6O88A9bRHU6P
 +acq0P2T/DDKIp5WQSJwnZPqjDJqG2XOmGHbh216WoUZ1orRsgpffsmgkNLJf+Bs3Fe98xk8zIJ
 OoKGx54JmX+yAKKncPuhsSLXQeFuZiqKsTsTdmsycLLUpE4Keypx72RdQKVm0brDvcKd/M9X66C
 4qmIfx9KiNkrgrOQIKC2y+ordno47Kedhk43Ymg8WMuzOkUu0R0oATGIgimFrr/I53QPd7INEvm
 SwR/MnTbYkB3RQTomEVYc/J3QUwrU+gvYl+ikTE9GsYFBVEWo9mUKr0JIQbRfC3AlDyHKq1r3In
 Qi9T9v1er1TYGVKvBz3zXIItBpfCuZULLsUJpxn5+oi7FO9wofm17AwBIXz9vCl1DVN/RMfu0K/
 rWzb2CI6rIwaX294fkfPHaPctkAscDsvLe4SoiwuROSP9Q6aUjdZCSvMPnRm+yctU5qP/8v2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_04,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507030135
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] device-drivers/cpufreq_boost: Don't hardcode
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

On Thu, Jul 03, 2025 at 09:00:13AM -0400, Wei Gao wrote:
> On Mon, Jun 30, 2025 at 07:51:28AM -0700, Mike Tipton via ltp wrote:
> > Some systems don't support boost on every CPU, such as on many Qualcomm
> > chipsets. And if boost isn't supported on CPU0, then the test will fail
> > since there's no performance improvement.
> > 
> > Instead of hardcoding CPU0, find the first CPU that belongs to a cpufreq
> > policy with boost enabled.
> > 
> > Signed-off-by: Mike Tipton <mike.tipton@oss.qualcomm.com>
> > ---
> > Changes in v2:
> > - Use proper maxspeed buf size in snprintf.
> > - Link to v1: https://lore.kernel.org/ltp/20250626194707.3053036-1-mike.tipton@oss.qualcomm.com/
> > 
> >  .../device-drivers/cpufreq/cpufreq_boost.c    | 58 ++++++++++++++++---
> >  1 file changed, 50 insertions(+), 8 deletions(-)
> > 
> > diff --git a/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c b/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
> > index 67917b3fea25..bbb5f602de4b 100644
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
> > +	tst_resm(TINFO, "didn't find boost-capable CPU (assuming CPU0)");
> > +	return 0;
> 
> If not find any boost-capable CPU, i suppose we need give TCONF "not
> support" message? Correct me if any misunderstanding. Thanks.

Yeah, we should.

Historically, this would have been covered by the existing check for
cdrv::file at the beginning of setup(), since the top-level
cpufreq/boost file was only created if at least one policy actually
supported it. The individual cpufreq drivers only called
cpufreq_enable_boost_support() when initializing a boost-capable policy.

However, this was recently simplified in [1] to remove that per-driver
logic, and now the cpufreq/boost sysfs file is created whenever the
driver defines a set_boost() callback, which is unconditional. So, now
it's possible for the driver-level boost feature to be enabled even when
zero policies actually support it.

I'll update it for this.

[1] - https://lore.kernel.org/all/cover.1737707712.git.viresh.kumar@linaro.org/

Thanks,
Mike

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
