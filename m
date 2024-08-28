Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF184C54FAA
	for <ltp@archiver.kernel.org>; Wed, 28 Aug 2024 14:02:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E8F33D2799
	for <ltp@archiver.kernel.org>; Wed, 28 Aug 2024 16:02:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BDBD53C7031
 for <ltp@lists.linux.it>; Wed, 28 Aug 2024 16:01:47 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0E37F61762E
 for <ltp@lists.linux.it>; Wed, 28 Aug 2024 16:01:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3279421B80;
 Wed, 28 Aug 2024 14:01:46 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 045821398F;
 Wed, 28 Aug 2024 14:01:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id P/e6M8ctz2YrMwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 28 Aug 2024 14:01:43 +0000
Date: Wed, 28 Aug 2024 16:01:41 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240828140141.GA1716031@pevik>
References: <20240828132325.23111-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240828132325.23111-1-mdoucha@suse.cz>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 3279421B80
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] nfsstat01: Read client stats from netns rhost
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
Cc: NeilBrown <neilb@suse.de>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

Thanks for fixing the test.

> On newer kernels, network namespaces have separate NFS stats. Detect
> support for per-NS files and read stats from the correct NS.

I'll mention before merging that it was kernel 6.9 and it got backported to up
to 5.15 so far.


Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---

> The /proc/net/rpc/nfs file did not exist in nested network namespaces
> on older kernels. The per-NS stats patchset adds it so we need to check
> for its presence to read the correct stats on kernels where it was
> backported.

> Kernel devs have also asked for a test that'll ensure the patchset doesn't
> get accidentaly reverted. Since this test uses namespaces only when
> the server and client run on the same machine, it'll be better to create
> a separate test for that. I'll send it later.
Thanks!

Kind regards,
Petr

>  testcases/network/nfs/nfsstat01/nfsstat01.sh | 24 +++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)

> diff --git a/testcases/network/nfs/nfsstat01/nfsstat01.sh b/testcases/network/nfs/nfsstat01/nfsstat01.sh
> index c2856eff1..8d7202cf3 100755
> --- a/testcases/network/nfs/nfsstat01/nfsstat01.sh
> +++ b/testcases/network/nfs/nfsstat01/nfsstat01.sh
> @@ -3,8 +3,19 @@
>  # Copyright (c) 2016-2018 Oracle and/or its affiliates. All Rights Reserved.
>  # Copyright (c) International Business Machines  Corp., 2001

> +TST_SETUP="nfsstat_setup"
>  TST_TESTFUNC="do_test"
>  TST_NEEDS_CMDS="nfsstat"
> +NS_STAT_RHOST=0
> +
> +nfsstat_setup()
> +{
> +	nfs_setup
> +
> +	if tst_net_use_netns && [ -z "$LTP_NFS_NETNS_USE_LO" ]; then
> +		tst_rhost_run -c "test -r /proc/net/rpc/nfs" && NS_STAT_RHOST=1
> +	fi
> +}

>  get_calls()
>  {
> @@ -15,15 +26,22 @@ get_calls()
>  	local calls opt

>  	[ "$name" = "rpc" ] && opt="r" || opt="n"
> -	! tst_net_use_netns && [ "$nfs_f" != "nfs" ] && type="rhost"
> +	[ "$nfs_f" = "nfsd" ] && opt="-s$opt" || opt="-c$opt"
> +
> +	if tst_net_use_netns; then
> +		# In netns setup, rhost is the client
> +		[ "$nfs_f" = "nfs" ] && [ $NS_STAT_RHOST -ne 0 ] && type="rhost"
> +	else
> +		[ "$nfs_f" != "nfs" ] && type="rhost"
> +	fi

>  	if [ "$type" = "lhost" ]; then
>  		calls="$(grep $name /proc/net/rpc/$nfs_f | cut -d' ' -f$field)"
> -		ROD nfsstat -c$opt | grep -q "$calls"
> +		ROD nfsstat $opt | grep -q "$calls"
>  	else
>  		calls=$(tst_rhost_run -c "grep $name /proc/net/rpc/$nfs_f" | \
>  			cut -d' ' -f$field)
> -		tst_rhost_run -s -c "nfsstat -s$opt" | grep -q "$calls"
> +		tst_rhost_run -s -c "nfsstat $opt" | grep -q "$calls"
>  	fi

>  	if ! tst_is_int "$calls"; then

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
