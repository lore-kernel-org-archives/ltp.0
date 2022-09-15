Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC5FECAAA1
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 08:57:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 06EB23CAC26
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 10:57:11 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5809A3CA7AF
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 10:57:00 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2A1CC600681
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 10:56:59 +0200 (CEST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 656655C972;
 Thu, 15 Sep 2022 08:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663232219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fr81y7aEWrOI558rGgAes0+q7tQM7Y1hpGK1F4KcFtY=;
 b=MOnON5HPz4wxY1Jwviaw6KVfXYny7QUGN7jtsNOWqE1ElpkI0NgWIIqS3LDrTn2/1OBkQT
 lvZ7Ql9/vL0E4Ka7325BOm8S3v7hyCHP8qCQSpXgc3jj2u2XTn3nKOo+F9lO0iYPE1ZveP
 yR7SDtnKcBsZ1hXnCCngvsscxSRmjBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663232219;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fr81y7aEWrOI558rGgAes0+q7tQM7Y1hpGK1F4KcFtY=;
 b=+1jB3qOubcluF3Y/RI44sde4P9+wlb8tJ02Ihr5d+odjtP/MIkFl5x+E/T30Rdap1/6MAe
 qleifNJJFzr0AZAg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 507E4132BD;
 Thu, 15 Sep 2022 08:56:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id PWCDEtvoImMWEQAAGKfGzw
 (envelope-from <chrubis@suse.cz>); Thu, 15 Sep 2022 08:56:59 +0000
Date: Thu, 15 Sep 2022 10:58:56 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Dylan Jhong <dylan@andestech.com>
Message-ID: <YyLpUMPMlGoXjwls@yuki>
References: <20220914131950.1783054-1-dylan@andestech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220914131950.1783054-1-dylan@andestech.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] kernel/uevent: Adjust the number of uevents
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
Cc: minachou@andestech.com, x5710999x@gmail.com, dminus@andestech.com,
 alankao@andestech.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Signed-off-by: Dylan Jhong <dylan@andestech.com>
> ---
>  testcases/kernel/uevents/uevent02.c | 146 ++++++++++++++--------------
>  1 file changed, 73 insertions(+), 73 deletions(-)
> 
> diff --git a/testcases/kernel/uevents/uevent02.c b/testcases/kernel/uevents/uevent02.c
> index ce0cf757d..059320f1c 100644
> --- a/testcases/kernel/uevents/uevent02.c
> +++ b/testcases/kernel/uevents/uevent02.c
> @@ -19,11 +19,71 @@
>  #include <linux/if_tun.h>
>  
>  #include "tst_test.h"
> +#include "tst_private.h"

This header is called private for a reason, the tst_kconfig_get() is not
meant to be used from tests, you are supposed to call tst_config_read()
as it's done in shmget02.c for example.

>  #include "uevent.h"
>  
>  #define TUN_PATH "/dev/net/tun"
>  
> +#define MAX_UEVENT 7
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
> +struct uevent_desc add_rx = {
> +	.msg = "add@/devices/virtual/net/ltp-tun0/queues/rx-0",
> +	.value_cnt = 3,
> +	.values = (const char*[]) {
> +		"ACTION=add",
> +		"DEVPATH=/devices/virtual/net/ltp-tun0/queues/rx-0",
> +		"SUBSYSTEM=queues",
> +	}
> +};
> +struct uevent_desc add_tx = {
> +	.msg = "add@/devices/virtual/net/ltp-tun0/queues/tx-0",
> +	.value_cnt = 3,
> +	.values = (const char*[]) {
> +		"ACTION=add",
> +		"DEVPATH=/devices/virtual/net/ltp-tun0/queues/tx-0",
> +		"SUBSYSTEM=queues",
> +	}
> +};
> +struct uevent_desc rem_rx = {
> +	.msg = "remove@/devices/virtual/net/ltp-tun0/queues/rx-0",
> +	.value_cnt = 3,
> +	.values = (const char*[]) {
> +		"ACTION=remove",
> +		"DEVPATH=/devices/virtual/net/ltp-tun0/queues/rx-0",
> +		"SUBSYSTEM=queues",
> +	}
> +};
> +struct uevent_desc rem_tx = {
> +	.msg = "remove@/devices/virtual/net/ltp-tun0/queues/tx-0",
> +	.value_cnt = 3,
> +	.values = (const char*[]) {
> +		"ACTION=remove",
> +		"DEVPATH=/devices/virtual/net/ltp-tun0/queues/tx-0",
> +		"SUBSYSTEM=queues",
> +	}
> +};
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

Why do we have to move these outside of the function? I do not see a
single reason to do so.

> +	const struct uevent_desc *uevents[MAX_UEVENT];
> +	int pid, fd, i = 0;
> +	int has_RPS = tst_kconfig_get("CONFIG_RPS");

Getting the flag should be done once in the test setup, otherwise kernel
config will be parsed in each iteration of the test.

> +	uevents[i++] = &add;
> +	if (has_RPS)
> +		uevents[i++] = &add_rx;
> +	uevents[i++] = &add_tx;
> +	if (has_RPS)
> +		uevents[i++] = &rem_rx;
> +	uevents[i++] = &rem_tx;
> +	uevents[i++] = &rem;
> +	uevents[i++] = NULL;



-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
