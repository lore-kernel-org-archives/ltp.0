Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4827C83F10
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 02:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752113426; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=cbne+CKqHetgRDyR6ODYotbnexx1DZQ9cJT4WXQgdSQ=;
 b=gjdqqXdqV+FgLTLYlBzk/VvyHsXZvf87gjG8IgNUcfd6RyBZSLhdkQoTmfLYeCZ43NP2e
 q12ZV7gvFqF/6mll3i1KVBzeYqOXDeDl7iUcSY2UgwYugv//wcXmZ8JmUYd644/Kl3prjUQ
 gBSLbrzAuccS6ipDL5Sudx+U0sCqvgE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB3533CAECA
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 04:10:26 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1705B3C4F8C
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 04:10:05 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 21A0C2000E3
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 04:10:05 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a6d77b43c9so464584f8f.3
 for <ltp@lists.linux.it>; Wed, 09 Jul 2025 19:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752113404; x=1752718204; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jR2iQ6sDOz94TYikEuDtT9J8e6+03GmQLu6T/PHnjNA=;
 b=c1ko8OvVXO+TsvdYyt4T0JiFScENXzWqDfvhU5z9A99Tk7lM9aEsNKrZc/OMYkWO9y
 C4gZAQqO/CiHvb0UEGBkIEomhS7jhZ/+suqjmPWTSVYq10+p+oFKGkAEf6+lg9EJwGqh
 Dd0E5qhdVLC9JxIWBRfyg4aP/a9uOhxM6CAXCXKFG4730Ef58iADR2cDE+Q86pEO0SPh
 dHMLax49kTH5rzMyYecyRzzCo5gdgaANDPgFr5ssQi+Pc7eXKxWYIklmxAPZ5Z+qLF1T
 jEgyBNTzIncFrpFTXZe9pPymtKzHWgBBYs0RELr0glfkkGNdFK+9Z4oRKIyZhMlla7b9
 J/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752113404; x=1752718204;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jR2iQ6sDOz94TYikEuDtT9J8e6+03GmQLu6T/PHnjNA=;
 b=gd3JJspNMxtICO3ni+sw/dAg/UqfwdMfbsiLiF2My8oAVQsh1s4jxdlWPtKgsIJNVV
 jeYAFRwK4Bz4BuMVBERgYX58GKLxkSCj62XeAvBigy7TSq51V6UQpS1eNU/G9Z4oqCrq
 uQAyH8JVbxhqcnJ4kjUxHW4ZIjPt4NxEg4NLtPTtG+eR2iY77ks4/ShzInCGzAzsJ/4D
 xgTKARfwHEHwW4sd5dhUqyEY04v7UPnQw7bTgYgHL0njKU0C/CobD28QyLyqjnNfWzYQ
 Vviq1Wm0RZoyr+aH2fooa2vqmz2aLBLfhho8qntpQFoEY/xIcl4Ijo8dIMR5TmnKow+Y
 5Vsg==
X-Gm-Message-State: AOJu0YxblUbRxA+sW1Or0+EaSPEN5RFCRBhnbYZwcUP6Vm1eqlRxBYrY
 jJxwdTvFxD2BevoGClY6bx2BQmt0231dXYXTxJLDKa0E/26ZooiysXajNNk6us83MalSjX2xAdR
 JCII=
X-Gm-Gg: ASbGncs6C0jJVPhGvO4PYOLSMU54hY1GV0y88Ji4kjiYdN2h8nPzdAAZUMvzxgCjACd
 +1AJfvGv6a00PKZMm0w8MuoSBCpnr0YP8XO4h2zeU+pIzGIQaSdQxnSWgyQklIWVHUGKG8uF00l
 qxSgbxI0iJozyJ16eDvSJf81liwfH5bD6nEOqGJ2D/rnFtKBivWGmeNICVQIXw1U0YMqlrJBDDD
 rkv+r/37jtpem3VslmZk+2POObdtWC8HN2dcgYEJ4tUSmmVQIRixvmwQsrkxtRylv7NOBQzJNdG
 e9N+rFU4rI0FJB13o5lz3B8QLxQwmYsHXyDiEQcAmpo6kDyVV0rtbBoYp3CcxQ==
X-Google-Smtp-Source: AGHT+IEsK+Ft+bIp7Pd0u9M0Gc5pj6D6FpdVQfaQC+iSUj2A4w6RDgKCpQWVFa9JKLtbgq7Irl7sog==
X-Received: by 2002:a05:6000:64b:b0:3a5:2ec5:35a9 with SMTP id
 ffacd0b85a97d-3b5e788d2dcmr1776523f8f.3.1752113404471; 
 Wed, 09 Jul 2025 19:10:04 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de4284898sm6025625ad.24.2025.07.09.19.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 19:10:04 -0700 (PDT)
Date: Thu, 10 Jul 2025 10:09:24 -0400
To: Mike Tipton <mike.tipton@oss.qualcomm.com>
Message-ID: <aG_JlPhs4DMJfVEi@MiWiFi-CR6608-srv>
References: <20250709151439.2840206-1-mike.tipton@oss.qualcomm.com>
 <aG-1OzeP-mB2MPq1@MiWiFi-CR6608-srv>
 <aG8bYZWlls9MiJW9@hu-mdtipton-lv.qualcomm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aG8bYZWlls9MiJW9@hu-mdtipton-lv.qualcomm.com>
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Jul 09, 2025 at 06:46:09PM -0700, Mike Tipton wrote:
> On Thu, Jul 10, 2025 at 08:42:35AM -0400, Wei Gao wrote:
> > On Wed, Jul 09, 2025 at 08:14:39AM -0700, Mike Tipton wrote:
> > > Some systems don't support boost on every CPU, such as on many Qualcomm
> > > chipsets. And if boost isn't supported on CPU0, then the test will fail
> > > since there's no performance improvement.
> > > 
> > > Instead of hardcoding CPU0, find the first CPU that belongs to a cpufreq
> > > policy with boost enabled.
> > > 
> > > Signed-off-by: Mike Tipton <mike.tipton@oss.qualcomm.com>
> > > ---
> > > Changes in v3:
> > > - Abort when no CPUs report supporting boost instead of assuming CPU0.
> > > - Link to v2: https://lore.kernel.org/ltp/20250630145128.1254269-1-mike.tipton@oss.qualcomm.com/
> > > 
> > > Changes in v2:
> > > - Use proper maxspeed buf size in snprintf.
> > > - Link to v1: https://lore.kernel.org/ltp/20250626194707.3053036-1-mike.tipton@oss.qualcomm.com/
> > > 
> > >  .../device-drivers/cpufreq/cpufreq_boost.c    | 58 ++++++++++++++++---
> > >  1 file changed, 50 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c b/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
> > > index 67917b3fea25..17d89c0cc164 100644
> > > --- a/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
> > > +++ b/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
> > > @@ -55,10 +55,14 @@ static int id = -1;
> > >  
> > >  static int boost_value;
> > >  
> > > -const char governor[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_governor";
> > > +static int cpu;
> > > +
> > > +static const char _governor[] = SYSFS_CPU_DIR "cpu%d/cpufreq/scaling_governor";
> > > +static char governor[64];
> > >  static char governor_name[16];
> > >  
> > > -const char maxspeed[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_max_freq";
> > > +static const char _maxspeed[] = SYSFS_CPU_DIR "cpu%d/cpufreq/scaling_max_freq";
> > > +static char maxspeed[64];
> > >  
> > >  static void check_set_turbo(char *file, char *off)
> > >  {
> > > @@ -84,6 +88,40 @@ static void cleanup(void)
> > >  		FILE_PRINTF(governor, "%s", governor_name);
> > >  }
> > >  
> > > +static int find_boost_cpu(void)
> > > +{
> > > +	char buf[64];
> > > +	int fd, i;
> > > +
> > > +	/*
> > > +	 * The files we're looking for only exist for acpi_cpufreq. Continue
> > > +	 * assuming CPU0 for intel_pstate.
> > > +	 */
> > > +	if (!strcmp(cdrv[id].name, "intel_pstate"))
> > > +		return 0;
> > > +
> > > +	for (i = 0;; i++) {
> > > +		snprintf(buf, sizeof(buf), SYSFS_CPU_DIR "cpu%d", i);
> > > +		fd = open(buf, O_RDONLY);
> > > +		if (fd == -1)
> > > +			break;
> > > +
> > > +		close(fd);
> > > +
> > > +		snprintf(buf, sizeof(buf), SYSFS_CPU_DIR "cpu%d/cpufreq/boost", i);
> > > +		fd = open(buf, O_RDONLY);
> > > +		if (fd == -1)
> > > +			continue;
> > > +
> > > +		close(fd);
> > > +		tst_resm(TINFO, "found boost-capable CPU (CPU%d)", i);
> > > +		return i;
> > > +	}
> > > +
> > > +	tst_brkm(TCONF, NULL, "boost not supported by any CPUs");
> > > +	return 0;
> > I suppose we do not need above line since brkm will jump out of the test
> > directly.
> 
> Yes, that's true. But it feels wrong to reach the end of a non-void
> function without returning something. Even though in this case it'll
> never actually reach the return statement.
> 

Or return -1 and handle error outside of the function?

> > 
> > Other parts LGTM, thanks for your patch.
> > Acked-by: Wei Gao <wegao@suse.com>
> > 
> 
> Thanks!
> Mike

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
