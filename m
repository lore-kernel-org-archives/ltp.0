Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D82C7113C
	for <ltp@archiver.kernel.org>; Wed, 28 Aug 2024 21:13:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C79253D27B2
	for <ltp@archiver.kernel.org>; Wed, 28 Aug 2024 23:13:18 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 44F3A3D2782
 for <ltp@lists.linux.it>; Wed, 28 Aug 2024 23:13:03 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=neilb@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 70B141A00896
 for <ltp@lists.linux.it>; Wed, 28 Aug 2024 23:13:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BD05821B61;
 Wed, 28 Aug 2024 21:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724879580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TL7WEUhiYB0bwRCt0pHSgM9xNztAO5Zkx6iev8vzZ+E=;
 b=Aw0DwIztQ2StRRoblbyCkHU3Eu3KmTz94/TPO+N20MtCgqLTtfODBJWf9tvZ2yjYQzfRA9
 E2A96tfM2ULECpcWsTow8/3jMqNloooV3JfJ9H9lq/mm/ooDaoQtT0xr8F3mOqVgFvuKqk
 jvmo1ecrO0/phgATU58Myn0wgM+qRBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724879580;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TL7WEUhiYB0bwRCt0pHSgM9xNztAO5Zkx6iev8vzZ+E=;
 b=1/5USkg79HRaJ74PSbWkuCCZtsTDCLmanzqX8QVMEJasIjyn6ueWEv7tIZhx69Tw7sHNwV
 mn7i3XvNsyv3xTCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724879578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TL7WEUhiYB0bwRCt0pHSgM9xNztAO5Zkx6iev8vzZ+E=;
 b=MKISGjiFpWdsJFy/Pg4NWkVfs5D9pey1iC77U/Sgd8UN8j0Ofvg8bGtDeNJIiLtlqwQfrN
 D+AE3izbSG1FuzdaHzj3iqCVlA1q4R135iGwG1PfONEzVGeFhPExDMFks9lCN+dY2F5LI/
 ZMfseVuIQHMwqd6Hb0d7WYmHLUq47UI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724879578;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TL7WEUhiYB0bwRCt0pHSgM9xNztAO5Zkx6iev8vzZ+E=;
 b=UKVeJxC3rXXlSLS4qmbVZThZkUTuYl2KHeg2oCPIGJ4PCNxyv6rKOifNw9zcH6atoIkgo4
 xpxgrfVIAs4n5jCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C3FA1398F;
 Wed, 28 Aug 2024 21:12:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gCwtDNmSz2Z1NAAAD6G6ig
 (envelope-from <neilb@suse.de>); Wed, 28 Aug 2024 21:12:57 +0000
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Martin Doucha" <mdoucha@suse.cz>
In-reply-to: <20240828132325.23111-1-mdoucha@suse.cz>
References: <20240828132325.23111-1-mdoucha@suse.cz>
Date: Thu, 29 Aug 2024 07:12:46 +1000
Message-id: <172487956651.4433.5156438688517075305@noble.neil.brown.name>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[noble.neil.brown.name:mid,
 imap1.dmz-prg2.suse.org:helo, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, 28 Aug 2024, Martin Doucha wrote:
> On newer kernels, network namespaces have separate NFS stats. Detect
> support for per-NS files and read stats from the correct NS.
> 
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>

Thanks for doing this Martin.  I very much prefer this approach.

NeilBrown


> ---
> 
> The /proc/net/rpc/nfs file did not exist in nested network namespaces
> on older kernels. The per-NS stats patchset adds it so we need to check
> for its presence to read the correct stats on kernels where it was
> backported.
> 
> Kernel devs have also asked for a test that'll ensure the patchset doesn't
> get accidentaly reverted. Since this test uses namespaces only when
> the server and client run on the same machine, it'll be better to create
> a separate test for that. I'll send it later.
> 
>  testcases/network/nfs/nfsstat01/nfsstat01.sh | 24 +++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/network/nfs/nfsstat01/nfsstat01.sh b/testcases/network/nfs/nfsstat01/nfsstat01.sh
> index c2856eff1..8d7202cf3 100755
> --- a/testcases/network/nfs/nfsstat01/nfsstat01.sh
> +++ b/testcases/network/nfs/nfsstat01/nfsstat01.sh
> @@ -3,8 +3,19 @@
>  # Copyright (c) 2016-2018 Oracle and/or its affiliates. All Rights Reserved.
>  # Copyright (c) International Business Machines  Corp., 2001
>  
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
>  
>  get_calls()
>  {
> @@ -15,15 +26,22 @@ get_calls()
>  	local calls opt
>  
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
>  
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
>  
>  	if ! tst_is_int "$calls"; then
> -- 
> 2.46.0
> 
> 


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
