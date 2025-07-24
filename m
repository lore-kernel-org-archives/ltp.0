Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF237C83F1A
	for <ltp@archiver.kernel.org>; Thu, 24 Jul 2025 01:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753321976; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=gmp2EvqL4Ng24aL7/x+R04hmG6Z79l7wR61PQey7rbg=;
 b=IA0wORUqvZAFU5OQ36DB5vl4NvgAxSmtyqNU+aivH/bxKzgiC0o5vS24JMytteR3EXPko
 gjUS8iYbhFjZlCuP0RXvmTO0Q0e3DcyAkS9z2orieh8GIf6i0IadjOPwIUXjE6P8/LTx4qn
 r/wvBydxsE/2Cq90C7Wbswoy6B3/VNY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CBF703CCDE5
	for <ltp@archiver.kernel.org>; Thu, 24 Jul 2025 03:52:56 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2761F3CCD2A
 for <ltp@lists.linux.it>; Thu, 24 Jul 2025 03:52:34 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BDB8F10001C6
 for <ltp@lists.linux.it>; Thu, 24 Jul 2025 03:52:31 +0200 (CEST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NMXNlG012570
 for <ltp@lists.linux.it>; Thu, 24 Jul 2025 01:52:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=2pwftQlwnfBMsagI3HKkXxd4
 VRSR8V0FGDfApFmGZA8=; b=F8rePvo5l8CHwnJJ40rR3x/fiQXo60J+v7GV6Tnx
 5NZGyGSkhBEEuVtRAyRboFg3A4MkMvCJsekNTDfzn6FJdmnpJfizhtJBSELpSj4o
 3thHQSd3ic3kFJg0nPOrweepLAR9A6konQP9nF0o48IY5R/okKo1rZ8bJ3DqvawO
 icNSJRDUk6pmKU3ceAVYC7jpko6MgO1RvcFiwRGRwy9iVKKWWniDkHNjMOD8pUBJ
 jklNNEkD1zmTjX/I9mbZaDgEQhS24K5ZX4nFExLvTa6va4dWxOAqGuYFrY7k8WUN
 tzW7SnS3CPojzORMX/FLcCfcBvrTbDAT/KacQSgTfirO+w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482d3hw2qu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 24 Jul 2025 01:52:29 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-235196dfc50so5368935ad.1
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 18:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753321948; x=1753926748;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2pwftQlwnfBMsagI3HKkXxd4VRSR8V0FGDfApFmGZA8=;
 b=MUxtLRWA3oIYBe367Xw5y2kcsKCTyfmqI2U2eV9DHgOK+4TfO+CUzFUhG3e9Tc75yM
 w/debxD9Vbw4mBH3ivRFdHAnQr0uTe1UNvEzKFyHy6C3F5baaQh1/UACZSN5KYp4al1x
 Eu4ix2S61LL7R5i45pvW+tekEUzPK7MqL18cWdO/fXj/F53fA0DbbtqL5bT3ZeSJV03q
 gjoCjexD/l6p797+g0WqdI+c0ZmrvgX8VzeBKc4qc9z411aO1n1o+lzlsLwjm3oM2CfC
 AAozeQKdjWJIjLv7iwj3xuR2c/XDmpYOuOOPgXSYhC4r0HAM7C2oLiNostiv/LHioIJE
 gCAg==
X-Gm-Message-State: AOJu0Yw4SRVnTfyQFHvFxWQw9HGhkDy+2njvIq1VsS5RwG+FcVmpJ7uH
 5UZA5Dtj1lY7uIUDt1297Uu/PBYWVpxJyi6DEvtCgZjLKJs1NBPrNWUcOHR1A20ZF+xHIPexF5h
 QACFGI+nCIqemvA6NQ6DrE1vJzW+KBffY3GPXZrqjmM7mIACHTOhR5fKZQxpDmQ==
X-Gm-Gg: ASbGncvgf+MykS7MDnM1lYgBukZSr6NDxgOUm9/ukWd8RIzBvR2oi9dqyjj3Hqi3SYE
 JLuDlZ0p61MEZeVpxWsRGtMoM3RYkr/kGAKtc8NgevcH5H/kymHyCyEVh6a/qsZSJsqCPzcYFvE
 /Bom/z7avWOg4KJEgYGD4OZ37yLYaEmoWxlbPE0Q2k4WoJ4r1ot5wFs8fsak6jwYF4yo9UU0nb0
 sZ4GYB9Oj3ctIumBZUUKLGZQZ3jU16p+NxQqQBZ4dSM+TOq8fsa3IUxG8aORTrfdnjPUaLVyutY
 5GHtVWKFe2yQ1BrB3urp61VYP85jaef6zfjXBTPO0rQnjisP+fY2jVfkvyzJk0CMuzP2xiSgPsg
 saqK0QWf1oAzIZMKuuA==
X-Received: by 2002:a17:903:18e:b0:231:fd73:f8e5 with SMTP id
 d9443c01a7336-23fa5da8d5bmr2638835ad.24.1753321948429; 
 Wed, 23 Jul 2025 18:52:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAtYRXK8eN0+6eCiC5i76uDdPXVShiDKE01RDqNdM+SIZSZlqjo5Q/+PE1Q1pVqBvtaqQY2Q==
X-Received: by 2002:a17:903:18e:b0:231:fd73:f8e5 with SMTP id
 d9443c01a7336-23fa5da8d5bmr2638515ad.24.1753321948008; 
 Wed, 23 Jul 2025 18:52:28 -0700 (PDT)
Received: from hu-mdtipton-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fa48eff59sm2746595ad.161.2025.07.23.18.52.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 18:52:27 -0700 (PDT)
Date: Wed, 23 Jul 2025 18:52:25 -0700
To: ltp@lists.linux.it, chrubis@suse.cz
Message-ID: <aIGR2dZcJTavezn/@hu-mdtipton-lv.qualcomm.com>
References: <20250710170255.4190556-1-mike.tipton@oss.qualcomm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250710170255.4190556-1-mike.tipton@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=G8UcE8k5 c=1 sm=1 tr=0 ts=688191dd cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=iox4zFpeAAAA:8 a=h8nnEaoG7Oo0Qb710l0A:9 a=CjuIK1q_8ugA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDAwOSBTYWx0ZWRfX9zA+kAi5H4qI
 X3h7y7pRAVywmd/ZKu9HyNiJPHiMkJzjFG0sDNaF01XEB726sWjQMOKj1KeH7op7aP+hcxlMYti
 6aay8S+1ps8zJv2KfdBSB4K3P8HpOxEDpUbx4N89iW23bcqvUTjvk+U9oKhl1R1u79iywLaCRGF
 qy77WhoYYAOqjjmA/x2KS5lB9CVDjItxyDp7wI9sQGdT5pbPFSJ0WSzFiZoKTbvXdkybApphy65
 ccgI3sbFvJ0/Z5zQkj3nYfi+MLXKXxJd7xAuC1ZcQ6yGTxa4dZCj0IacDDsv+G12qDoui2V0YP3
 bAjYMMwxyDU5K7q8UtdGAkcdhXSroM1vcEMnv23vUWiAgMi6wc8Ilsmsjzz+MfaRp/jM5urZslO
 0U/mPTlVvMaCGkGS4LBIVSdK/PqSL+60hZeXcWGIw9uTyy0YikQdrq8XA9GzSMB2LJkqXMsN
X-Proofpoint-GUID: flA_LVOCWhcz91chkisRK8frB0AJrtsB
X-Proofpoint-ORIG-GUID: flA_LVOCWhcz91chkisRK8frB0AJrtsB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=727 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240009
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Jul 10, 2025 at 10:02:55AM -0700, Mike Tipton wrote:
> Some systems don't support boost on every CPU, such as on many Qualcomm
> chipsets. And if boost isn't supported on CPU0, then the test will fail
> since there's no performance improvement.
> 
> Instead of hardcoding CPU0, find the first CPU that belongs to a cpufreq
> policy with boost enabled.
> 
> Signed-off-by: Mike Tipton <mike.tipton@oss.qualcomm.com>
> Acked-by: Wei Gao <wegao@suse.com>
> ---
> Changes in v4:
> - Move error handling outside of find_boost_cpu() for improved
>   readability.
> - Collect Acked-by from Wei.
> - Link to v3: https://lore.kernel.org/ltp/20250709151439.2840206-1-mike.tipton@oss.qualcomm.com/
> 
> Changes in v3:
> - Abort when no CPUs report supporting boost instead of assuming CPU0.
> - Link to v2: https://lore.kernel.org/ltp/20250630145128.1254269-1-mike.tipton@oss.qualcomm.com/
> 
> Changes in v2:
> - Use proper maxspeed buf size in snprintf.
> - Link to v1: https://lore.kernel.org/ltp/20250626194707.3053036-1-mike.tipton@oss.qualcomm.com/
> 
>  .../device-drivers/cpufreq/cpufreq_boost.c    | 60 ++++++++++++++++---
>  1 file changed, 52 insertions(+), 8 deletions(-)

Hi Cyril / everyone,

Is anything else needed before this patch can be applied?

Thanks,
Mike

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
