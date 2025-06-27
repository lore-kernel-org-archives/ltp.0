Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33939C7EE2A
	for <ltp@archiver.kernel.org>; Fri, 27 Jun 2025 16:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751040195; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=mrn21VxES8b4UbtfIaVhAOeArVyN+fI6JSrYkrPN+VQ=;
 b=Y4v/criVWJugzsZRcE4P2HAZDuHi7uXBS5lm1M4m4CDagc86uTXKbDBDfemnGuvbtJ6T4
 GO2jimZUChqvsMxKdkx5WJPm5YJwxhoDuMzfv6T2Trnj5NeAtsQBsYSxV5EnXqqdGqkCayc
 2tTkHC8mwDh/o2kC3F7ZMvwjB53Ac2k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6442D3C91C2
	for <ltp@archiver.kernel.org>; Fri, 27 Jun 2025 18:03:15 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 439803C5371
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 18:02:54 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A3531600A31
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 18:02:51 +0200 (CEST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RCdeWt017712
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 16:02:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=LJWyIcrltDzf0ElNOTH2Bq3+
 3z6uSpuZKaRF6dwkkWg=; b=h5PB8HyNxwMMqCXaph3Cz4SQqi7pH3s5vLBwHTq6
 Mglv+OxUGMvqtoiH4KFO1uZQ1gIsCSfeopOWLkIs420GJFDub/4xdj56m+PqjwvO
 OLTZQIGSFG5WDkKtKlO44Ziv9PyJWGnCN4c37BNNLQy3LJ78xeVTOEseBfE1XTyy
 RAJKNuMpta9B8VfdJODyeFUXKaUFwOEq8WUzGof9b1HqVkHyt6vARLz0ybzKY66b
 qke1ifOIhpz1yOqIwv1PbTDc5r+k4cOys5XiwlNap/y/w3DupItcDexdzp07EWoO
 sWkVAVZFU+fQy82EL6oYEQ0J3ChAVx7NjfVvLudbjElswA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47fdfx5q35-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 16:02:49 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-7377139d8b1so1893441b3a.0
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 09:02:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751040168; x=1751644968;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LJWyIcrltDzf0ElNOTH2Bq3+3z6uSpuZKaRF6dwkkWg=;
 b=W/uQ0kigqhVPbzy3/iWeLeDsOVOTfEvMth8Mita0MnYOw+6dGG1avDXirnGTZcRkxG
 ubB+gVA9WT8fVsRaUWwbNMT72Fy+NXUvviZ42KQ2QWZAm/VtkO8SqLsmQ/FJvkzGf6cq
 W/UeVABWQqkAeg43iYyBB6njfzR8nTBcT8IgeciN6EXUSNiJ3xHpsGrW9QTtRPWdt67p
 +TB0qtBTTIioielYop0o4jYaR/gouLC1/KHYp9beci9Eztg89Z+FJaiLVWJ4iqe53D1O
 Gxe08AS/rdULSE53DnDkpktQZxtO/yqSv47ONLlqmlS6BjoBt6VAvlXdgVyLjQCXQ1mf
 /2IA==
X-Gm-Message-State: AOJu0YyFf5peV8V1Rkm4viVrOkxSV0jEwtJ967wvXNluJ79V9gwiLWo9
 WjRWulALqrDPKQWoDycQppGZqetn42SoSKS2mA2wfkKzWCrdSB/jaVRzN/UbgNqLs78i19wOjOg
 eNGxMYmHHTKLo1kHvvhwXxlglWad6Jr1LkoPHLZcuM98cPD+0vg76Bw==
X-Gm-Gg: ASbGncsYYwVwPUah9HBO8a009t6uGV3obbVft2K50GlV4NyMju9dhhAxInavGSFHnKH
 evfHmXyTZgQRDgU4qJAXYi1Bb2MTPKWjHrSUe5vx9RwVGXrdcuXszIqyZ+3hL98/2hkxROZQf+1
 6nbRfB6+Aq7lldXZH1N5/YB9Dbvfsa/lX48VHeV9WDLe/WF6+E6ZJAu9wH+5ub+RyCtiDpEkO6+
 Q9YdKvV9jHPwYgwzNvafgz7sPEKwKEUb/xROb6ZjVrZ3uMUKzMC1Yioly8pPSZ0hF7zs4CDtmxq
 wqsZii0VwW9vA7lF+e6DI93pUVT9u/sWMZcrJb8x7FR7CV9ePUN/DpEx4K2THyRNhx2L4VTCypL
 P
X-Received: by 2002:a05:6a00:399e:b0:748:ffaf:9b53 with SMTP id
 d2e1a72fcca58-74af6fe14d5mr5329537b3a.16.1751040167815; 
 Fri, 27 Jun 2025 09:02:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiw/VzyUtmotDnIzCjbVHeCEbDEgC8ndsD7FuqQDl/ohWEPT7Y2Li2iak2PGy4Mpo/wQLvtA==
X-Received: by 2002:a05:6a00:399e:b0:748:ffaf:9b53 with SMTP id
 d2e1a72fcca58-74af6fe14d5mr5329453b3a.16.1751040167175; 
 Fri, 27 Jun 2025 09:02:47 -0700 (PDT)
Received: from hu-mdtipton-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b34e3023a11sm1661131a12.25.2025.06.27.09.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 09:02:46 -0700 (PDT)
Date: Fri, 27 Jun 2025 09:02:44 -0700
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Message-ID: <aF7ApP/89jnW6PUu@hu-mdtipton-lv.qualcomm.com>
References: <20250626194707.3053036-1-mike.tipton@oss.qualcomm.com>
 <94bce2af-8b36-4846-959a-3a2a798b2a59@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <94bce2af-8b36-4846-959a-3a2a798b2a59@oracle.com>
X-Proofpoint-GUID: tBQeK1CVvKnRCeYKMlLpxUhkYb-3g2Mj
X-Proofpoint-ORIG-GUID: tBQeK1CVvKnRCeYKMlLpxUhkYb-3g2Mj
X-Authority-Analysis: v=2.4 cv=MtZS63ae c=1 sm=1 tr=0 ts=685ec0a9 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=1HPUncCyJOTKReP4n_oA:9
 a=CjuIK1q_8ugA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDEzMCBTYWx0ZWRfXyr901Phrk6M0
 Xhif+9dlIlv+n18bAqbdUujkHa3/NEakxzWZSwUIS3MODwo6BjwgR9pnGLZygFBV57eO7LsHKAo
 PvV3RbCdyLrlooGraN4/3+/jRaP9VBXzETazFnrbjRDHkIwK+q7MI5NC4eN2Hn5f/ZUN4rASqsW
 D2ndRjD6JrD2l9nidWaPgvh0EB7IwzlO7UwZqlph1H6iOceW+3U+HparLaWyfUjOS07lAa/tTKm
 uEWdK7dSPGoQ0ASTBrGIgpsoickYELkpaJxt3x/RP/g0Lkh9DscBWohirrGSqhKlur6N4bonpT0
 yc39V3eBIxtJRCChupSbcKq/GSoic71wcE+wEMj2u/jt1fi9vGUS4jKlSkhHs/Nxovu+OSVqdb7
 jhmjEXSN29hOwyLSKNo/bA4F2DxmvkaqK3tSfvFRnUhnsOCoKPlNZunWvNdzAub/C3Kh890Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506270130
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [External] : [PATCH] device-drivers/cpufreq_boost: Don't
 hardcode to CPU0
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

On Fri, Jun 27, 2025 at 08:43:31AM +0530, ALOK TIWARI wrote:
> 
> 
> On 6/27/2025 1:17 AM, Mike Tipton via ltp wrote:
> > Some systems don't support boost on every CPU, such as on many Qualcomm
> > chipsets. And if boost isn't supported on CPU0, then the test will fail
> > since there's no performance improvement.
> > 
> > Instead of hardcoding CPU0, find the first CPU that belongs to a cpufreq
> > policy with boost enabled.
> > 
> > Signed-off-by: Mike Tipton <mike.tipton@oss.qualcomm.com>
> > ---
> >   .../device-drivers/cpufreq/cpufreq_boost.c    | 58 ++++++++++++++++---
> >   1 file changed, 50 insertions(+), 8 deletions(-)
> > 
> > diff --git a/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c b/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
> > index 67917b3fea25..5469126d2d12 100644
> > --- a/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
> > +++ b/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
> > @@ -55,10 +55,14 @@ static int id = -1;
> >   static int boost_value;
> > -const char governor[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_governor";
> > +static int cpu;
> > +
> > +static const char _governor[] = SYSFS_CPU_DIR "cpu%d/cpufreq/scaling_governor";
> > +static char governor[64];
> >   static char governor_name[16];
> > -const char maxspeed[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_max_freq";
> > +static const char _maxspeed[] = SYSFS_CPU_DIR "cpu%d/cpufreq/scaling_max_freq";
> > +static char maxspeed[64];
> >   static void check_set_turbo(char *file, char *off)
> >   {
> > @@ -84,6 +88,40 @@ static void cleanup(void)
> >   		FILE_PRINTF(governor, "%s", governor_name);
> >   }
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
> > +}
> > +
> >   static void setup(void)
> >   {
> >   	int fd;
> > @@ -109,6 +147,10 @@ static void setup(void)
> >   	tst_resm(TINFO, "found '%s' driver, sysfs knob '%s'",
> >   		cdrv[id].name, cdrv[id].file);
> > +	cpu = find_boost_cpu();
> > +	snprintf(governor, sizeof(governor), _governor, cpu);
> > +	snprintf(maxspeed, sizeof(governor), _maxspeed, cpu);
> 
> why sizeof(governor) not sizeof(maxspeed)

Whoops, copy/paste mistake. I'll fix that.

Thanks,
Mike

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
