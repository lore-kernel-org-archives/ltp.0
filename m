Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F50C433EF
	for <ltp@archiver.kernel.org>; Tue,  4 Jan 2022 11:25:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4444C3C90A9
	for <ltp@archiver.kernel.org>; Tue,  4 Jan 2022 12:25:12 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8CD6D3C8C62
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 12:25:03 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 05CB8140075E
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 12:25:02 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 44A2E21107;
 Tue,  4 Jan 2022 11:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641295502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S1rWDly+L2TWIkGByBOAYmBaJ5pt38hkwYn3A7GfgSQ=;
 b=e5LvX4o1MBPkJXyM+3tSO1uTbCabsvHk2JuzF8aAMY5t2rZWM7J33cSRgSHG1XICNgFLmL
 w4hc6ddDep9/wHa3cpoV109EtWcEXxMhe5gDSYIwFd4PwHxRxQEi4IrM493Dqj0QFmE1jo
 6OiZPNysGH5hEZaA6xdR/Y8yw8P3cKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641295502;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S1rWDly+L2TWIkGByBOAYmBaJ5pt38hkwYn3A7GfgSQ=;
 b=JeBftXkZngcaQan7Qp4ABD75BpKkL2eVmmw6fCmYGrblMa3aOMx1HfdsdVhZ6a1zquuCMD
 GxXRRhzayXrjwmCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2DEC313ADF;
 Tue,  4 Jan 2022 11:25:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8Zk1CY4u1GFkOAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 04 Jan 2022 11:25:02 +0000
Date: Tue, 4 Jan 2022 12:26:31 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <YdQu5zbxNkDg1oEM@yuki>
References: <20220104081836.22827-1-andrea.cervesato@suse.com>
 <20220104081836.22827-11-andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220104081836.22827-11-andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 10/10] Define watchqueue testing suite in
 runtest
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  runtest/watchqueue      | 8 ++++++++
>  scenario_groups/default | 1 +
>  2 files changed, 9 insertions(+)
>  create mode 100644 runtest/watchqueue
> 
> diff --git a/runtest/watchqueue b/runtest/watchqueue
> new file mode 100644
> index 000000000..badf7afb0
> --- /dev/null
> +++ b/runtest/watchqueue
> @@ -0,0 +1,8 @@
> +wqueue01 wqueue01
> +wqueue02 wqueue02
> +wqueue03 wqueue03
> +wqueue04 wqueue04
> +wqueue05 wqueue05
> +wqueue06 wqueue06
> +wqueue07 wqueue07
> +wqueue08 wqueue08
> diff --git a/scenario_groups/default b/scenario_groups/default
> index 1dc2987d5..68bd5300d 100644
> --- a/scenario_groups/default
> +++ b/scenario_groups/default
> @@ -30,3 +30,4 @@ cve
>  crypto
>  kernel_misc
>  uevent
> +watchqueue

I guess that I would do this in an incremental fashion as well. I.e. add
the watchqueue runtest file into the default fromp with wqueue01 in the
commit that adds the wqueue01 test.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
