Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC935C433F5
	for <ltp@archiver.kernel.org>; Thu, 13 Jan 2022 15:50:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 78C953C954C
	for <ltp@archiver.kernel.org>; Thu, 13 Jan 2022 16:50:43 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BBBB13C821C
 for <ltp@lists.linux.it>; Thu, 13 Jan 2022 16:50:33 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 54CD31A00E7F
 for <ltp@lists.linux.it>; Thu, 13 Jan 2022 16:50:32 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7FB2E1F3A8;
 Thu, 13 Jan 2022 15:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642089032;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6rb8hbrZhzVMircbrtv+OBrKulRQqFSvfpa7tpc+IOc=;
 b=ikOo+qh2JWcx/B/ZyVmZwtZCgwFP7RaJUk20akDdN6laIhlkfLj2kswKvmq4w7EL5DgsAK
 Mty4QDGnqZBD2o5PUdlMAW8coFZVgKapIX9VaIRqq/lEbSohYSdpdo7Ln7QEhyTKJmIkk4
 T+a7epCAS7IpcJ3mEPtYPKHrAyiybgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642089032;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6rb8hbrZhzVMircbrtv+OBrKulRQqFSvfpa7tpc+IOc=;
 b=mcpDsC1a1EhyallCM+ysWY4UacHRbFgwqN6WKeg3sUsmxa9bJeoAtjRBXpCBMZRmoqj/+T
 hI8RzysgQRDfkMAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5546F1330C;
 Thu, 13 Jan 2022 15:50:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sSMzE0hK4GHfIQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 13 Jan 2022 15:50:32 +0000
Date: Thu, 13 Jan 2022 16:50:30 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Message-ID: <YeBKRoYuuZFVBmHf@pevik>
References: <20220112161942.4065665-1-nikita.yushchenko@virtuozzo.com>
 <20220112161942.4065665-2-nikita.yushchenko@virtuozzo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220112161942.4065665-2-nikita.yushchenko@virtuozzo.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] nfs_lib.sh: run exportfs at "server side" in
 LTP_NETNS case
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

Hi Nikita,

[ Cc Alexey ]

> In LTP_NETNS case, nfs server is the root namespace and nfs client is
> the ltp namespace.

> Then, exportfs shall be executed locally, without tst_rhost_run.

> Otherwise, things implicitly depend on /var/lib/nfs being the same in
> the root namespace and the ltp namespace.
Not sure if I understand your use case. Do you run rpc.statd (or what is using
/var/lib/nfs) in non-default net namespace?

> Signed-off-by: Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
> ---
>  testcases/network/nfs/nfs_stress/nfs_lib.sh | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

> diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> index b01215136..b50ccf196 100644
> --- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
> +++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> @@ -81,8 +81,14 @@ nfs_setup_server()
>  {
>  	local export_cmd="exportfs -i -o fsid=$$,no_root_squash,rw *:$remote_dir"

> -	if ! tst_rhost_run -c "test -d $remote_dir"; then
> -		tst_rhost_run -s -c "mkdir -p $remote_dir; $export_cmd"
> +	if [ -n "$LTP_NETNS" ]; then
Please use tst_net_use_netns (as in the patch I Cc you just now).

Shouldn't be also $LTP_NFS_NETNS_USE_LO considered?

Kind regards,
Petr

> +		if ! test -d $remote_dir; then
> +			mkdir -p $remote_dir; $export_cmd
> +		fi
> +	else
> +		if ! tst_rhost_run -c "test -d $remote_dir"; then
> +			tst_rhost_run -s -c "mkdir -p $remote_dir; $export_cmd"
> +		fi
>  	fi
>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
