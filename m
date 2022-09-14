Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576ACC6FA82
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 20:31:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC1F03CAC01
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 22:31:46 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA7FC3CABD6
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 22:31:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DCE116020DA
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 22:31:36 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C51125CD7F;
 Wed, 14 Sep 2022 20:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663187495;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jm53UDT3gt8C0MIwEO0ZEld+a7VKQ3kwHVmxL4KO/2g=;
 b=kXHy/hCSMHUNsARN7d5u3Cp5pn0/l6lrOna87AgJa3Vlgij7XFw/2OECm1sEXZVak4qhXj
 2lCGM0JpR1Zd2Ic8dSgX3X2rPP3TAjL1qxLHwTKAbExObBw/NjzM/zzzPN9cwoNaDLD2o5
 qJ37+zW++G2DBGGU85iaQclYeoh4cws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663187495;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jm53UDT3gt8C0MIwEO0ZEld+a7VKQ3kwHVmxL4KO/2g=;
 b=dzb+OdJ4GZzWUTHUrSKTuJ79Yzvbs0duyM62LUaaerMRDmiA8KOIHpCed2i37czLXrayh+
 fAybpPx8+6GB5wBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 781B313494;
 Wed, 14 Sep 2022 20:31:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OF00FSc6ImPQKwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 14 Sep 2022 20:31:35 +0000
Date: Wed, 14 Sep 2022 22:31:33 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YyI6JbIQp4uv8YR+@pevik>
References: <20220914161930.27681-1-mdoucha@suse.cz>
 <20220914161930.27681-4-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220914161930.27681-4-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/5] perf_event_open02: Add max_runtime
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

> Changes since v1:
> - Changed max_runtime from 15s to 72s

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Again, we'll add .max_setup_runtime after the new release.
+1

>  testcases/kernel/syscalls/perf_event_open/perf_event_open02.c | 1 +
>  1 file changed, 1 insertion(+)

> diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
> index 618a27016..defe13c62 100644
> --- a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
> +++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
> @@ -334,4 +334,5 @@ static struct tst_test test = {
>  	},
>  	.test_all = verify,
>  	.needs_root = 1,
> +	.max_runtime = 72
>  };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
