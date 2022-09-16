Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51516ECAAD8
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 13:44:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 50AF83CACA2
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 15:44:08 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A9C873CAC38
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 15:43:56 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A54B11401225
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 15:43:55 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C636B33E39;
 Fri, 16 Sep 2022 13:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663335834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oLfmQKsndXcSP38LKA3BsMIbypLoYlMlCHyngdRL4Cc=;
 b=HMqaZTFZBnzTFnxowdX2ggVpuTdZEnFvc2SWAW1n67l/TRkgu8FXgieVu5rnaygeOVdPwJ
 W+yD9KxdudVrpyFMO463W5D7DXH63CvWN0nmBjp/K6nICYJcslap6qzO2y4mQYmcwpciql
 iLjxlTAx/0Qr3qOVn3PmKvHf4OBQn6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663335834;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oLfmQKsndXcSP38LKA3BsMIbypLoYlMlCHyngdRL4Cc=;
 b=aQfObvkhOXGDAWPdUaq05YwJ4HaH/EEQ+TT7+UUTu88i6Vc3QdxqZxynj3lrI2oO06ydI0
 GX1W/lxGH9uVHICQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B8991346B;
 Fri, 16 Sep 2022 13:43:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id L2lRHJp9JGN3RwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 16 Sep 2022 13:43:54 +0000
Date: Fri, 16 Sep 2022 15:45:51 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Dylan Jhong <dylan@andestech.com>
Message-ID: <YyR+D1kOJC85h7DP@yuki>
References: <20220915123129.3962374-1-dylan@andestech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220915123129.3962374-1-dylan@andestech.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] kernel/uevent: Adjust the number of uevents
 dynamically in uevent02
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
Cc: alankao@andestech.com, minachou@andestech.com, dminus@andestech.com,
 x5710999x@gmail.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> When CONFIG_SMP is not selected, CONFIG_RPS will not be enabled. Causes the
> kernel to not create rx queues in sysfs[1] when creating tun devices.
> Uevent02 will check if the rx queue exists, adjust the uevents dynamically
> in setup() to pass this test.
> 
> [1]: https://github.com/torvalds/linux/blob/3245cb65fd91cd514801bf91f5a3066d562f0ac4/net/core/net-sysfs.c#L1109
> 
> Signed-off-by: Dylan Jhong <dylan@andestech.com>
> ---
>  testcases/kernel/uevents/uevent02.c | 168 ++++++++++++++++------------
>  1 file changed, 96 insertions(+), 72 deletions(-)
> 
> diff --git a/testcases/kernel/uevents/uevent02.c b/testcases/kernel/uevents/uevent02.c
> index ce0cf757d..dcdf393d4 100644
> --- a/testcases/kernel/uevents/uevent02.c
> +++ b/testcases/kernel/uevents/uevent02.c
> @@ -18,11 +18,77 @@
>  #include <linux/if.h>
>  #include <linux/if_tun.h>
>  
> +#include "tst_kconfig.h"
>  #include "tst_test.h"
>  
>  #include "uevent.h"
>  
>  #define TUN_PATH "/dev/net/tun"
> +#define CONFIG_RPS "CONFIG_RPS"
> +#define MAX_UEVENTS 7
> +
> +struct uevent_desc add = {
> +	.msg = "add@/devices/virtual/net/ltp-tun0",
> +	.value_cnt = 4,
> +	.values = (const char*[]) {
> +		"ACTION=add",
> +		"DEVPATH=/devices/virtual/net/ltp-tun0",
> +		"SUBSYSTEM=net",
> +		"INTERFACE=ltp-tun0",
> +	}
> +};
> +
> +struct uevent_desc add_rx = {
> +	.msg = "add@/devices/virtual/net/ltp-tun0/queues/rx-0",
> +	.value_cnt = 3,
> +	.values = (const char*[]) {
> +		"ACTION=add",
> +		"DEVPATH=/devices/virtual/net/ltp-tun0/queues/rx-0",
> +		"SUBSYSTEM=queues",
> +	}
> +};
> +
> +struct uevent_desc add_tx = {
> +	.msg = "add@/devices/virtual/net/ltp-tun0/queues/tx-0",
> +	.value_cnt = 3,
> +	.values = (const char*[]) {
> +		"ACTION=add",
> +		"DEVPATH=/devices/virtual/net/ltp-tun0/queues/tx-0",
> +		"SUBSYSTEM=queues",
> +	}
> +};
> +
> +struct uevent_desc rem_rx = {
> +	.msg = "remove@/devices/virtual/net/ltp-tun0/queues/rx-0",
> +	.value_cnt = 3,
> +	.values = (const char*[]) {
> +		"ACTION=remove",
> +		"DEVPATH=/devices/virtual/net/ltp-tun0/queues/rx-0",
> +		"SUBSYSTEM=queues",
> +	}
> +};
> +
> +struct uevent_desc rem_tx = {
> +	.msg = "remove@/devices/virtual/net/ltp-tun0/queues/tx-0",
> +	.value_cnt = 3,
> +	.values = (const char*[]) {
> +		"ACTION=remove",
> +		"DEVPATH=/devices/virtual/net/ltp-tun0/queues/tx-0",
> +		"SUBSYSTEM=queues",
> +	}
> +};
> +
> +struct uevent_desc rem = {
> +	.msg = "remove@/devices/virtual/net/ltp-tun0",
> +	.value_cnt = 4,
> +	.values = (const char*[]) {
> +		"ACTION=remove",
> +		"DEVPATH=/devices/virtual/net/ltp-tun0",
> +		"SUBSYSTEM=net",
> +		"INTERFACE=ltp-tun0",
> +	}
> +};
> +const struct uevent_desc *uevents[MAX_UEVENTS];

Now it makes sense to keep them here, but please make them all static.

>  static void generate_tun_uevents(void)
>  {
> @@ -44,78 +110,6 @@ static void verify_uevent(void)
>  {
>  	int pid, fd;
>  
> -	struct uevent_desc add = {
> -		.msg = "add@/devices/virtual/net/ltp-tun0",
> -		.value_cnt = 4,
> -		.values = (const char*[]) {
> -			"ACTION=add",
> -			"DEVPATH=/devices/virtual/net/ltp-tun0",
> -			"SUBSYSTEM=net",
> -			"INTERFACE=ltp-tun0",
> -		}
> -	};
> -
> -	struct uevent_desc add_rx = {
> -		.msg = "add@/devices/virtual/net/ltp-tun0/queues/rx-0",
> -		.value_cnt = 3,
> -		.values = (const char*[]) {
> -			"ACTION=add",
> -			"DEVPATH=/devices/virtual/net/ltp-tun0/queues/rx-0",
> -			"SUBSYSTEM=queues",
> -		}
> -	};
> -
> -	struct uevent_desc add_tx = {
> -		.msg = "add@/devices/virtual/net/ltp-tun0/queues/tx-0",
> -		.value_cnt = 3,
> -		.values = (const char*[]) {
> -			"ACTION=add",
> -			"DEVPATH=/devices/virtual/net/ltp-tun0/queues/tx-0",
> -			"SUBSYSTEM=queues",
> -		}
> -	};
> -
> -	struct uevent_desc rem_rx = {
> -		.msg = "remove@/devices/virtual/net/ltp-tun0/queues/rx-0",
> -		.value_cnt = 3,
> -		.values = (const char*[]) {
> -			"ACTION=remove",
> -			"DEVPATH=/devices/virtual/net/ltp-tun0/queues/rx-0",
> -			"SUBSYSTEM=queues",
> -		}
> -	};
> -
> -	struct uevent_desc rem_tx = {
> -		.msg = "remove@/devices/virtual/net/ltp-tun0/queues/tx-0",
> -		.value_cnt = 3,
> -		.values = (const char*[]) {
> -			"ACTION=remove",
> -			"DEVPATH=/devices/virtual/net/ltp-tun0/queues/tx-0",
> -			"SUBSYSTEM=queues",
> -		}
> -	};
> -
> -	struct uevent_desc rem = {
> -		.msg = "remove@/devices/virtual/net/ltp-tun0",
> -		.value_cnt = 4,
> -		.values = (const char*[]) {
> -			"ACTION=remove",
> -			"DEVPATH=/devices/virtual/net/ltp-tun0",
> -			"SUBSYSTEM=net",
> -			"INTERFACE=ltp-tun0",
> -		}
> -	};
> -
> -	const struct uevent_desc *const uevents[] = {
> -		&add,
> -		&add_rx,
> -		&add_tx,
> -		&rem_rx,
> -		&rem_tx,
> -		&rem,
> -		NULL
> -	};
> -
>  	pid = SAFE_FORK();
>  	if (!pid) {
>  		fd = open_uevent_netlink();
> @@ -131,7 +125,37 @@ static void verify_uevent(void)
>  	wait_for_pid(pid);
>  }
>  
> +static void setup(void)
> +{
> +	struct tst_kconfig_var kconfig = {
> +		.id = CONFIG_RPS,
> +		.id_len = sizeof(CONFIG_RPS)-1,
> +	};
> +	int i = 0;
> +
> +	tst_kconfig_read(&kconfig, 1);
> +
> +	if (kconfig.choice != 'y') {
> +		tst_res(TINFO, "CONFIG_RPS not supported by kernel");
> +		uevents[i++] = &add;
> +		uevents[i++] = &add_tx;
> +		uevents[i++] = &rem_tx;
> +		uevents[i++] = &rem;
> +		uevents[i++] = NULL;
> +	} else {
> +		tst_res(TINFO, "CONFIG_RPS supported by kernel");
> +		uevents[i++] = &add;
> +		uevents[i++] = &add_rx;
> +		uevents[i++] = &add_tx;
> +		uevents[i++] = &rem_rx;
> +		uevents[i++] = &rem_tx;
> +		uevents[i++] = &rem;
> +		uevents[i++] = NULL;
> +	}

I actually liked the version where we had the two ifs in the middle of
the initialization a bit better, since it was obviously clear what the
difference between the two cases is.

> +}
> +
>  static struct tst_test test = {
> +	.setup = setup,
>  	.test_all = verify_uevent,
>  	.forks_child = 1,
>  	.needs_checkpoints = 1,
> -- 
> 2.34.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
