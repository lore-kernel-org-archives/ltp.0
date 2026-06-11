Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE88BCD98CC
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 07:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781162021; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=wMfSJSPyujQAcNWDbLEZ64OBM0EmUzInBMkjIL1PtmA=;
 b=MP7KaCsdHBmw7YGBZ+T02PpfDKq7ez9wk/GAHl6axtImJSje0RUIGjGpJwj11MXVBZnIQ
 hsGd85FNKCNh6R5ChWFQo6f+k328RADKk9LrZB4dFUaGrD/wlQOgu/+IsaHNWD74ilUX14j
 JvwN0A4E/WPMTOyHMvwjib19MvfacP4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80A5C3CC6A7
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 09:13:41 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 99F473C1C1F
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 09:13:21 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 96C091A00692
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 09:13:20 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-45ef4223be7so4193067f8f.2
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 00:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781162000; x=1781766800; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ujjw1rABlk9UPE4+FgzFXqLJ+BaWrfTsv6p7XH+wh2g=;
 b=CxQOOq3RPUznd7TwS7Z2TXNsaGCSvIRJ8aSrLrcAuOjp6+3ZeM01L+Lhsz0g92LirI
 bwvwLETuQt4gM9exWfWl6+WSi0hgSTlgdzs98JHBLdPsGQY52CX2jaFaF61lNCgp80Az
 APhMHP4x4o0h6ne0S/sJBURBToCgvG2yrLfkqV69dt7j4ZPQox8Pc1zqKlo9zcYvl3N/
 FYKYROid6YqXL2pnG1a3G+jbhpqG1wchPFo1WB7EQMPu8JyqBnYzinDUszokZ+Xazrbk
 MjEbBDimmdCEAB1ZY8Ppic0IhddoVGF7kHWrQ8gUA1H4UWzZhq8awJqdvDMPSMPtmtzC
 2I1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781162000; x=1781766800;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ujjw1rABlk9UPE4+FgzFXqLJ+BaWrfTsv6p7XH+wh2g=;
 b=tFClY69oxVOA5CHBp75JZ5272F2xD78nmomMDipsDkWyRCijdXI6ljIZBR92djLFwB
 u9pI3yWjR8E+ovqm7NQloYP9uN+5MDqSD88muWxDokzsxoKpnmEhGCqySQixHUC4+oAb
 hgq0szqQn2FdXklkuVprKFOhCfoTgAz9kEXqZYHRjJzBrn3uanYXSBo4MLLJWT981mwE
 Mt1eueqyYlbrTWsz0g8ZbSPPpLUSiiY9ymjyb4xuGMosyGnfB3SLtyUenGQubU+ZnQfa
 qaPKxJsn33EbJbsSDVMdzQCBlZp8L1IoiKNwJfGhPA4rmdsbRg+OqEJsVuDd3qvUt1qp
 E21Q==
X-Gm-Message-State: AOJu0Yz3Y43z0glLUjOTj9hAZbdT5/PYgXgscx68mCEeWQYBJV8Javdv
 q6Nswx5QjnBZoK4xNXCpqmEnz03OCha43R+QETbGxHAR2rsVUK2wPBBepBgXulO3hLg=
X-Gm-Gg: Acq92OEu5CMmstpdQdHp0LoAVsIxZ7cm4P5rW+IN1buyQkDoP0J8D4kifXBijbKHHGn
 jAFwO+sQRIO1Rt6yA+Dm+aQf9crTW8TI2zVx2PU+qxMdS7CdfmtziYRR7iLLlpdApn5I4mbpTgZ
 LNnYJseHK0AnupxYq+0/BzpKYpat5trNXU8IikVs3xzWfN2ZuV54J5D0qthP+o0cvpNFX8y0pHD
 9dZeDC/IuJCn7aFQBoVrzvyROw/qI9KGzY98oAKI9XLuf6n00LIMyjw2H9ua6yn3KK1xZG1+yeH
 +tZQS8TwIgdNMSQizOeRHFMheEikfvKvm89tjNDS6ajktixVH3GT4Y8iAsUP4pvlMdFkDVVjsxy
 TN+meomp9sQDph9eIwI7OAORpQMl3CMiV/YJ5jP73zdurZ5P7UVXvredEB2h/OazRqRKolWAF4T
 7ebR1kNOjWgcCwvrV1Z3pUOPuz0W+Mi2Axf+FqqoLK52dCw85+Y+GGzBZYx26e+gCdMKdId2XVv
 VFTqTSnL86qTqtLzbehLOezysvwqZvUhYuCp7CcV4jpgQ==
X-Received: by 2002:a5d:5d09:0:b0:45e:edc8:d440 with SMTP id
 ffacd0b85a97d-4606757a682mr2160061f8f.1.1781161999887; 
 Thu, 11 Jun 2026 00:13:19 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f345209sm84655294f8f.17.2026.06.11.00.13.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 00:13:19 -0700 (PDT)
Message-ID: <6a2a600f.e130e254.13e740.627f@mx.google.com>
To: "Piotr Kubaj" <piotr.kubaj@intel.com>
In-Reply-To: <20260507111145.112276-2-piotr.kubaj@intel.com>
Date: Thu, 11 Jun 2026 07:13:18 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8] cpufreq.c: add new test for cpufreq sysfs
 interface validation
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: daniel.niestepski@intel.com, tomasz.ossowski@intel.com,
 helena.anna.dubel@intel.com, rafael.j.wysocki@intel.com, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Piotr,

> +static void cleanup(void)
> +{
> +	char path[PATH_MAX];
> +
> +	if (!setup_done) {
> +		free(online);
> +		free(previous_scaling_max_freq);
> +		free(previous_scaling_min_freq);
> +		free(previous_scaling_governor);

Better to use goto at the end of the cleanup() function, instead
of defining free() in two different parts and duplicating code.

> +		return;
> +	}
> +
> +	SAFE_FILE_PRINTF("/sys/devices/system/cpu/intel_pstate/status", "%s", intel_pstate_status);
> +	SAFE_FILE_PRINTF("/sys/devices/system/cpu/intel_pstate/no_turbo", "%d", no_turbo);

For fixed sysfs files that we need to modify and restore, we should use
.save_restore instead.

> +static void setup(void)
> +{
> +	char path[PATH_MAX];
> +
> +	if (access("/sys/devices/system/cpu/intel_pstate/status", F_OK) == -1)
> +		tst_brk(TCONF, "intel_pstate driver not active");

Are you sure it's not a TBROK/TFAIL? We are checking for the driver
configuration inside the kernel at tst_test level. I expect that
.../cpu/intel_pstate/status is present at this point. If it's not,
we are probably facing a bug in the driver, isnt it?

[..]

> +
> +	SAFE_FILE_SCANF("/sys/devices/system/cpu/intel_pstate/no_turbo", "%d", &no_turbo);
> +	SAFE_FILE_SCANF("/sys/devices/system/cpu/intel_pstate/status", "%15s", intel_pstate_status);

And since we are scanning the status value later on, we probably don't
need the access(.../cpu/intel_pstate/status) verification. The test will
TBROK anyway here.

We should probably use .save_restore at this point, since we can safely
guard the test from having drivers issues at configuration level.
In particular, we should use .save_restore with TST_SR_TBROK (or
TST_SR_TCONF if you confirm that driver might not initialize the
sysfs under certain circumstances). 

> +		snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/cpufreq/scaling_available_governors", i);
> +		memset(contents, 0, sizeof(contents));
> +		SAFE_FILE_SCANF(path, "%255[^\n]", contents);
> +
> +		tst_res(TDEBUG, "Checking whether %s contains \"performance\" and \"schedutil\"", path);

Please change all of these double quotes inside tst_res() message parameter
single quotes (as Cyril mentioned already).

> +		SAFE_FILE_SCANF(path, "%255s", contents);
> +
> +		if (strstr(contents, "schedutil"))

Also, I'm a bit concern for the massive use of strstr() patterns.
Again, if drivers are bugged and show a string with garbage
data matching one of the "supposed" correct string, we pass the test
while drivers are still bugged.

You are also missing these two configurations which are needed
by the test:

- CONFIG_CPU_FREQ_GOV_SCHEDUTIL
- CONFIG_CPU_FREQ_GOV_PERFORMANCE

Otherwise, it's not possible to run:

> +      SAFE_FILE_PRINTF(path, "schedutil");

or setting CPU governor to performance.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
