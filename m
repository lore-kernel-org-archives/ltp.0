Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08015C433EF
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 17:02:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 97EF13C8CA4
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 18:02:26 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E56FD3C61C8
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 18:02:16 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B858F6005D6
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 18:02:15 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E9B741F37F;
 Fri, 11 Mar 2022 17:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647018134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a3oEiWICtwMiWMd3tYaU8eXVmrHZCzUbl5aZvECM5Uo=;
 b=sEV7P69q837bWgKlHMdVLvUygvtRnnHOj6gj5Vib9SrMuVPobGRYrrAIjmF2UH/8R1noOV
 SAU6AvcAlJX6Lt9klM3oFETMKLVPHunP46yn/BZrQe4QERMCnE2Ppg476fyh7jCCKoS8MV
 3b2rjsL++b1MCrlQKQ9Y+0CsHTZIv28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647018134;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a3oEiWICtwMiWMd3tYaU8eXVmrHZCzUbl5aZvECM5Uo=;
 b=Btqin0FBT4BLTqF9GynimaclVR6ZQ3OI1wwuZ2AR4+In8nVdOUOR1pKtFjTPxVR3rA++bi
 ZRmpZJiALiz/H6CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C6E0E13A95;
 Fri, 11 Mar 2022 17:02:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id did5L5aAK2JmNwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 11 Mar 2022 17:02:14 +0000
Message-ID: <ea39e6ce-7b6f-66e1-40e9-f616506ece35@suse.cz>
Date: Fri, 11 Mar 2022 18:02:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20220311124923.6504-1-pvorel@suse.cz>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20220311124923.6504-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] nfs_lib: Fix fsid randomisation
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
Cc: Neil Brown <neilb@suse.de>, Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
I can confirm that this patch fixes the test failures.

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 11. 03. 22 13:49, Petr Vorel wrote:
> Testing nfs with multiple versions (-v, i.e. nfs0*_06 - testing with
> nfs06.sh) nfs_lib.sh exports multiple different directories all with the
> same fsid= value, which is not supposed to work (and breaks on older
> nfs-utils).
> 
> Therefore increase fsid value for each loop.
> 
> Reported-by: Neil Brown <neilb@suse.de>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi,
> 
> fsid check is not required, but added to prevent another false positive
> in the future.
> 
> Thanks Neil!
> 
> Kind regards,
> Petr
> 
>  testcases/network/nfs/nfs_stress/nfs_lib.sh | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> index 7a7cd9925b..ad96bb4438 100644
> --- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
> +++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> @@ -79,7 +79,11 @@ nfs_server_udp_enabled()
>  
>  nfs_setup_server()
>  {
> -	local export_cmd="exportfs -i -o fsid=$$,no_root_squash,rw *:$remote_dir"
> +
> +	local fsid="$1"
> +	local export_cmd="exportfs -i -o fsid=$fsid,no_root_squash,rw *:$remote_dir"
> +
> +	[ -z "$fsid" ] && tst_brk TBROK "empty fsid"
>  
>  	if tst_net_use_netns; then
>  		if ! test -d $remote_dir; then
> @@ -161,7 +165,7 @@ nfs_setup()
>  		remote_dir="$TST_TMPDIR/$i/$type"
>  		mkdir -p $local_dir
>  
> -		nfs_setup_server
> +		nfs_setup_server $(($$ + n))
>  
>  		opts="-o proto=$type,vers=$i"
>  		nfs_mount


-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
