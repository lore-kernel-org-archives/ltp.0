Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A1DFCA100C
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 20:15:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8557F3D28A4
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 22:15:29 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7749A3D1A09
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 22:15:13 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9AF6C1001272
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 22:15:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1095E21A4F;
 Fri, 30 Aug 2024 20:15:11 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA3B413A3D;
 Fri, 30 Aug 2024 20:15:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qHN8L04o0mYXSgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 30 Aug 2024 20:15:10 +0000
Date: Fri, 30 Aug 2024 22:15:09 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240830201509.GC90470@pevik>
References: <20240830141453.28379-1-mdoucha@suse.cz>
 <20240830141453.28379-2-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240830141453.28379-2-mdoucha@suse.cz>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 1095E21A4F
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] nfsstat01: Check that RPC stats don't leak
 between net namespaces
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
Cc: NeilBrown <neilb@suse.de>, Chuck Lever III <chuck.lever@oracle.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> When the NFS server and client run on the same host in different net
> namespaces, check that RPC calls from the client namespace don't
> change RPC statistics in the root namespace.

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---

> I've initially tried to test both NFS and RPC client stats but it appears
> that NFS client stats are still shared across all namespaces. Only RPC
> client stats are separate for each net namespace. The kernel patchset[1]
> which introduced per-NS stats confirms that only RPC stats have been changed.

> If NFS client stats should be separate for each namespace as well, let
> me know and I'll return the second set of NS checks in patch v2.

> Tested on kernel v5.14 with Neil's backports.

> [1] https://lore.kernel.org/linux-nfs/cover.1708026931.git.josef@toxicpanda.com/

>  testcases/network/nfs/nfsstat01/nfsstat01.sh | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)

> diff --git a/testcases/network/nfs/nfsstat01/nfsstat01.sh b/testcases/network/nfs/nfsstat01/nfsstat01.sh
> index 8d7202cf3..3379c4d46 100755
> --- a/testcases/network/nfs/nfsstat01/nfsstat01.sh
> +++ b/testcases/network/nfs/nfsstat01/nfsstat01.sh
> @@ -22,6 +22,7 @@ get_calls()
>  	local name=$1
>  	local field=$2
>  	local nfs_f=$3
> +	local netns=${4:-rhost}
>  	local type="lhost"
>  	local calls opt

> @@ -30,7 +31,8 @@ get_calls()

>  	if tst_net_use_netns; then
>  		# In netns setup, rhost is the client
> -		[ "$nfs_f" = "nfs" ] && [ $NS_STAT_RHOST -ne 0 ] && type="rhost"
> +		[ "$nfs_f" = "nfs" ] && [ $NS_STAT_RHOST -ne 0 ] && \
> +			type="$netns"
>  	else
>  		[ "$nfs_f" != "nfs" ] && type="rhost"
>  	fi
> @@ -64,13 +66,14 @@ get_calls()
>  do_test()
>  {
>  	local client_calls server_calls new_server_calls new_client_calls
> -	local client_field server_field
> +	local client_field server_field root_calls new_root_calls
>  	local client_v=$VERSION server_v=$VERSION

>  	tst_res TINFO "checking RPC calls for server/client"

>  	server_calls="$(get_calls rpc 2 nfsd)"
>  	client_calls="$(get_calls rpc 2 nfs)"
> +	root_calls="$(get_calls rpc 2 nfs lhost)"

>  	tst_res TINFO "calls $server_calls/$client_calls"

> @@ -79,6 +82,7 @@ do_test()

>  	new_server_calls="$(get_calls rpc 2 nfsd)"
>  	new_client_calls="$(get_calls rpc 2 nfs)"
> +	new_root_calls="$(get_calls rpc 2 nfs lhost)"
>  	tst_res TINFO "new calls $new_server_calls/$new_client_calls"

>  	if [ "$new_server_calls" -le "$server_calls" ]; then
> @@ -93,6 +97,16 @@ do_test()
>  		tst_res TPASS "client RPC calls increased"
>  	fi

> +	if [ $NS_STAT_RHOST -ne 0 ]; then
> +		tst_res TINFO "Root NS client RPC calls: $root_calls => $new_root_calls"
> +
> +		if [ $root_calls -ne $new_root_calls ]; then
> +			tst_res TFAIL "RPC stats leaked between net namespaces"
> +		else
> +			tst_res TPASS "RPC stats stay within net namespaces"
> +		fi

Maybe also add TCONF message? (can be added before merge)

    else
		tst_res TCONF "Not testing leak between root NS and net NS due old kernel"

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>

Thanks for this test!

Kind regards,
Petr

> +	fi
> +
>  	tst_res TINFO "checking NFS calls for server/client"
>  	case $VERSION in
>  	2) client_field=13 server_field=13

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
