Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D832E66892
	for <ltp@archiver.kernel.org>; Fri, 19 Dec 2025 21:27:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AADBF3D0547
	for <ltp@archiver.kernel.org>; Fri, 19 Dec 2025 22:27:53 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AFD803C28C5
 for <ltp@lists.linux.it>; Fri, 19 Dec 2025 22:27:33 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1FF401000751
 for <ltp@lists.linux.it>; Fri, 19 Dec 2025 22:27:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0F2375BD22;
 Fri, 19 Dec 2025 21:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1766179647;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ETsdfsfB/+IzIn8JRjU8pNRrXw1CXFeJaj8pMf5JTXY=;
 b=k+jJM69XwpBl/ro4+0V+XPB3gSNNBHOd7lCRADHXCqrl4tn5O1ec5+SpnskeI8h3J9b/ru
 s6sy9NB3s5d62HidPTFHpRPSJ+ectbPepirPmxmbaC+Expl1kOUznc1tMqhxI2oh+0zSYq
 cS7GgaUkV92B1m9hZGnSrFYvxoxXDjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1766179647;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ETsdfsfB/+IzIn8JRjU8pNRrXw1CXFeJaj8pMf5JTXY=;
 b=5ttRS7Oc2tuIVGEWKtdfz+JsxU2cU6YG1NlOY4akpukNBqufn0gr1e6AjRHcFsGmwnQqEK
 WFEtM3e0EvPM+cCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=k+jJM69X;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5ttRS7Oc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1766179647;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ETsdfsfB/+IzIn8JRjU8pNRrXw1CXFeJaj8pMf5JTXY=;
 b=k+jJM69XwpBl/ro4+0V+XPB3gSNNBHOd7lCRADHXCqrl4tn5O1ec5+SpnskeI8h3J9b/ru
 s6sy9NB3s5d62HidPTFHpRPSJ+ectbPepirPmxmbaC+Expl1kOUznc1tMqhxI2oh+0zSYq
 cS7GgaUkV92B1m9hZGnSrFYvxoxXDjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1766179647;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ETsdfsfB/+IzIn8JRjU8pNRrXw1CXFeJaj8pMf5JTXY=;
 b=5ttRS7Oc2tuIVGEWKtdfz+JsxU2cU6YG1NlOY4akpukNBqufn0gr1e6AjRHcFsGmwnQqEK
 WFEtM3e0EvPM+cCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E49153EA63;
 Fri, 19 Dec 2025 21:27:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mY2mNj7DRWmjCgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 19 Dec 2025 21:27:26 +0000
Date: Fri, 19 Dec 2025 22:27:17 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
Message-ID: <20251219212717.GA15539@pevik>
References: <20251219155732.46696-1-vasileios.almpanis@virtuozzo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251219155732.46696-1-vasileios.almpanis@virtuozzo.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:replyto,virtuozzo.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,virtuozzo.com:email];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0F2375BD22
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ssh-stress: disable resource penalties
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

Hi Vasileios,

first, our ML requires subscription (unlike kernel's lore). I subscribed you then.

> Our tests create a number of ssh sessions in the
> background which are immediately killed. Some of
> them haven't finished the authentication stage yet
> and they close the connection incurring penalties from
> the ssh daemon.

> debug1: srclimit_penalise: active penalty for ipv4 10.0.0.1/32
> already exists, 16 seconds remaining

> Then when we try to reconnect to the daemon we are bounced
> because of the active penalty which leads to a failed test.

> ssh-stress 1 TINFO: Killing all ssh sessions
> kex_exchange_identification: read: Connection reset by peer
> Connection reset by fd00:1:1:1::2 port 58373
> ssh-stress 1 TFAIL: SSH not reachable

> From the sshd logs we can see

> debug1: srclimit_penalise: active penalty for ipv4 10.0.0.1/32
> already exists, 16 seconds remaining

> This feature was added to OpenSSH 9.8 in the 2024 release in the
> 81c1099d2 commit. Lets disable penalties for the versions that
> support them.

> Signed-off-by: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
> ---
>  testcases/network/stress/ssh/ssh-stress.sh | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

> diff --git a/testcases/network/stress/ssh/ssh-stress.sh b/testcases/network/stress/ssh/ssh-stress.sh
> index c27c27a28..cb6659ed5 100755
> --- a/testcases/network/stress/ssh/ssh-stress.sh
> +++ b/testcases/network/stress/ssh/ssh-stress.sh
> @@ -39,8 +39,12 @@ cleanup()

>  setup()
>  {
> -	local port rc
> +	local port rc version major minor

> +	version=$(sshd -V 2>&1 | sed -nE 's/^.*OpenSSH_([0-9]+)\.([0-9]+).*$/\1 \2/p' | head -n1)
> +	set -- $version
> +	major=$1
> +	minor=$2

Interesting, I never used set like this.  FYI we suppose POSIX shell
compatibility, i.e. it should work on dash and busybox sh. At least
checkbashisms does not complain therefore it looks to be valid. Testing just
this part locally on both dash and busybox sh shows it's working.

>  	port=$(tst_rhost_run -c "tst_get_unused_port ipv${TST_IPVER} stream")

> @@ -60,6 +64,13 @@ HostKey $TST_TMPDIR/ssh_host_ecdsa_key
>  HostKey $TST_TMPDIR/ssh_host_ed25519_key
>  EOF

> +	if ([ -n "$major" ] && [ -n "$minor" ]); then
	if [ -n "$major" ] && [ -n "$minor" ]; then
nit: IMHO this could be without curly brackets, right? ( ). Any reason to add
them?

> +		if ([ "$major" -gt 9 ] || ([ "$major" -eq 9 ] && [ "$minor" -ge 8 ])); then
I never tried ( ) to force evaluation. I hope it works on POSIX only shell
(dash, busybox sh). BTW IMHO it should work as (which is POSIX compatible):

		if [ "$major" -gt 9 ] || [ "$major" -eq 9 -a "$minor" -ge 8 ]; then

The rest LGTM.

Kind regards,
Petr

> +			cat << EOF >> sshd_config
> +PerSourcePenalties no
> +EOF
> +		fi
> +	fi
>  	ssh-keygen -q -N "" -t rsa -b 4096 -f $TST_TMPDIR/ssh_host_rsa_key
>  	ssh-keygen -q -N "" -t ecdsa -f $TST_TMPDIR/ssh_host_ecdsa_key
>  	ssh-keygen -q -N "" -t ed25519 -f $TST_TMPDIR/ssh_host_ed25519_key

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
