Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D148FD7308D
	for <ltp@archiver.kernel.org>; Fri,  3 Apr 2026 03:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1775185817; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=j5GIaJW/DWEX1zeYcpdPDuJz1tx1fC2opHYmooMmy2k=;
 b=KHRGwgzekLNPf8xdF6Y9roVB4r2tBF9dFLqxoyIWj2ZGt58S1cZHdTczF6WS5KsBc1ur5
 wrtyi1BmX3HUhyGNbm6pZBLTawQsTSB2L2A03Krl64wd94uv5/Nd1NcgGlPPVn4NpI47nXQ
 3aWTSiNlUJ8TSbH2yT7miWSPuoEf/e0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1192F3E54D9
	for <ltp@archiver.kernel.org>; Fri,  3 Apr 2026 05:10:17 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 833B43E2389
 for <ltp@lists.linux.it>; Fri,  3 Apr 2026 05:09:52 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D6ECB1A0121F
 for <ltp@lists.linux.it>; Fri,  3 Apr 2026 05:09:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775185789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uU0LicUvWGDyA4SMMDkcoFdRXxWWf0smsoQ4mR1HECQ=;
 b=F7URgpHM+HTGx7wRwVmA8hi5CHCxUzWCEAaggq1is2ohCISIA7MS4OkmmRJ3hq0NyHIBgL
 D/yH1zFtQ8WrbYIWWTTXam2j5D+tLNF85Z9w++wK6MyVWg2JZ6WwsKbpIPZ46+dryHlZIG
 SUiFoqbgAeQKom57s6TPoIc4BiAZSbw=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-o6jEczE9P76UUXUIVrT0YQ-1; Thu, 02 Apr 2026 23:09:48 -0400
X-MC-Unique: o6jEczE9P76UUXUIVrT0YQ-1
X-Mimecast-MFC-AGG-ID: o6jEczE9P76UUXUIVrT0YQ_1775185787
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b249975139so36046915ad.0
 for <ltp@lists.linux.it>; Thu, 02 Apr 2026 20:09:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775185787; x=1775790587;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uU0LicUvWGDyA4SMMDkcoFdRXxWWf0smsoQ4mR1HECQ=;
 b=TrAxT/wk5GQ38jafe1OqFunhSjA9KI4LCXErvVjEtNWCYFbuNd5fWvhUfeahDzWXWx
 5tFo4mRnmOVxdP1/Ngt9GMwjpCN2Uf2V9LElpEGyJWX9LK6X8ZcNdm4fELr7MH/N92zb
 yzRs0eL37K1LergrQlu1u9WeFCiTiHvfy+iivbLlZJSLTgcLetea4nutYqzaIabe3lH6
 ajOk3qC/9Ga75/M7hZS5ofDcmAh4rch8tFrvKnqxFCUJU9wDHXLmjtLYsvDZ8XygVn+f
 820SQP4V0eZkcG5qUJlyOFx3G7uXXpDbsSTMT9niOAgzceqX4kYKfUwzt67NDgHStWis
 80bA==
X-Gm-Message-State: AOJu0YzgbrLeaatS1HBGWJjjzn8jgU2v1XHTccfTLtBqxeklG0W6DJyW
 3dG0YB6NY48Gp36P23yYA6RGMnR0oULKiXPe59IbzfarkVgRjPkB1Y6vFnSBdcXrnwvvPfxLUAy
 0pzKhEtPJMdt3Lutmyqa7/G/8tsPt0fEzLjewMZdmAMpEKpPK1E55
X-Gm-Gg: AeBDiesDT7/OCpNiUQsjPpIddTe0CKh2C8j856dKT00FKrDHvX1eiVh8yQjASjtquwI
 vl6pPrZDFtqDbCtTxcL+FaszKbU34AN4meFHR9vT3QjK5Djv/vFb0yhRr5k/Orx7vfSwpa8GDze
 gmOXD0vgXpVinRMwj+7UzhD4slZBxVHEFSKf2jhBVEvvDN9rOOjIzShvKRpbbQqpKdhsBwpL3qB
 Tw49DbMQUWdtoFw/nmEKZ4MOkgDWvVTUDXULkS5KHrncpuJxXPrERGy45+zeFm59OK8FusSp23I
 6JVHtSZUFntKOE+rcAxDZ+8MlDcQOjieUfuXvy4jQ8u2KzEsiP7LaFEw7OQ5UZJj/pmKwm7YRj5
 FvH46sHF6hh3lJ+DPUg==
X-Received: by 2002:a17:903:1b2e:b0:2ae:ced7:4650 with SMTP id
 d9443c01a7336-2b281799547mr16514025ad.24.1775185786922; 
 Thu, 02 Apr 2026 20:09:46 -0700 (PDT)
X-Received: by 2002:a17:903:1b2e:b0:2ae:ced7:4650 with SMTP id
 d9443c01a7336-2b281799547mr16513635ad.24.1775185786341; 
 Thu, 02 Apr 2026 20:09:46 -0700 (PDT)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6476119sm4614792a12.4.2026.04.02.20.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 20:09:45 -0700 (PDT)
Date: Fri, 3 Apr 2026 11:09:42 +0800
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <ac8vdjEM0awKPmHE@redhat.com>
References: <20260402121356.31266-1-chrubis@suse.cz>
 <20260402121356.31266-5-chrubis@suse.cz>
MIME-Version: 1.0
In-Reply-To: <20260402121356.31266-5-chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CL7RRi1Vp8YwjMC88tbW8qUqnpelqMGaAarvuPMmHdE_1775185787
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 04/17] lib: tst_kconfig: Add module presence checks
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Apr 02, 2026 at 02:13:43PM +0200, Cyril Hrubis wrote:
> The .needs_kconfig and .needs_drivers fields in the tst_test structure
> had overlaping functionality. Both were checking if a functionality was
> build in into the kernel or compiled as a driver. Similarily to the
> runtime checks added to tst_kconfig modules can be build but packaged
> into separate packages and may not be installed on the system even if
> corresponding config option was set to 'm'.
> 
> This commit adds a mapping table from CONFIG options to module names for
> the modules we care about. Most of the time the mapping is trivial, but
> some CONFIG options does not really match the module name, hence we need
> a mapping. We may also be able to generate the table from kernel config
> infrastructure later on, but at this point the number of options is
> small enough to be manageable by hand editing.
> 
> Once we have that mapping we can run aditional check for a module
> presence if the confing option was set to 'm' and if mapping exists in
> order to disable the config option when the module was not found.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  lib/tst_kconfig.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
> index 52dd6d726..c5dd97a45 100644
> --- a/lib/tst_kconfig.c
> +++ b/lib/tst_kconfig.c
> @@ -144,6 +144,46 @@ static void runtime_check(struct tst_kconfig_var *var)
>  	}
>  }
>  
> +static struct module_check {
> +	const char *config;
> +	const char *module_name;
> +} module_checks[] = {
> +	{"CONFIG_KVM", "kvm"},
> +	{"CONFIG_ZRAM", "zram"},
> +	{"CONFIG_SQUASHFS", "squashfs"},
> +	{"CONFIG_BLK_DEV_LOOP", "loop"},
> +	{"CONFIG_TUN", "tun"},
> +	{"CONFIG_BLK_DEV_RAM", "brd"},
> +	{"CONFIG_HWPOISON_INJECT", "hwpoison_inject"},
> +	{"CONFIG_QFMT_V2", "quota_v2"},
> +	{"CONFIG_INPUT_UINPUT", "uinput"},
> +	{"CONFIG_DUMMY", "dummy"},
> +	{"CONFIG_CAN_VCAN", "vcan"},
> +	{"CONFIG_CAN_RAW", "can-raw"},
> +	{"CONFIG_CAN_BCM", "can-bcm"},
> +	{"CONFIG_IP_SCTP", "sctp"},
> +	{}
> +};

Maybe rename the struct to:

	static struct config_module_map {
		const char *config;
		const char *module_name;
	} config_module_maps[] = {
		...
	}

And rename 'struct runtime_check' to:

	static struct config_runtime_map {
		const char *config;
		bool (*runtime_check)(void);
	} config_runtime_maps[] = {
		...
	};

This is a tiny nit; I don't have strong opinions.

>  static inline int kconfig_parse_line(const char *line,
>                                       struct tst_kconfig_var *vars,
>                                       unsigned int vars_len)
> @@ -222,6 +262,7 @@ out:
>  			case 'm':
>  				vars[i].choice = 'm';
>  				runtime_check(&vars[i]);
> +				module_check(&vars[i]);

Then rename the two functions to:

    kconfig_runtime_check()
    kconfig_module_check()

Because in tst_kconfig.c most function contains "kconfig_" string.

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
