Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF93AC5AC82
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 10:32:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E9113CEF0D
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 12:32:06 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E08B53CDB40
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 12:31:49 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D73D11A00374
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 12:31:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ED94E3E43;
 Mon, 10 Aug 2026 10:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786357900;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NymqEep+bMfSeJNd7RfMHMSfp8h1x2sXKLivvxHQN+Q=;
 b=F9UD+ipimmfAjdCi+rYbs+nj5AWa6UHi3xabjEuFlzKpWTKkmuFkCgNTQ8C7TMlc5vDQzM
 mIpOl39BH8Cg79B4hGHk4UeWFpD6xODcpNd5654KQuQu6EAkprDITisrjTRFL1Ma7nRxqy
 phJc5MFUVDn+YgefbleCzNIVdN2lIv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786357900;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NymqEep+bMfSeJNd7RfMHMSfp8h1x2sXKLivvxHQN+Q=;
 b=MGoxvHLR48NHO2fXD7CVHv7gxqWhJrKtN2z+8PMFy/gR8EzSvkLbAdbYeCAnRVXjXWod3T
 G8xjyoSpIfGGj0BA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bCL0Ck3s;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="I/7Hq50F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786357895;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NymqEep+bMfSeJNd7RfMHMSfp8h1x2sXKLivvxHQN+Q=;
 b=bCL0Ck3sxpX7HjRmurYP/locoXTMC7l0Ny8IM/9FCsXqPVIAqD2DaiF2BRb/u17WNfhaW7
 mPSFYA4m7VW0IK6x7Jxz5ov3mm/V9vEn9RHY3Rs1pJpzkVXp3rp9KVPpfGFvQ8gdHUNny3
 /Ilda5u8gH8SRDSxAujRBV/ITDChPc0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786357895;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NymqEep+bMfSeJNd7RfMHMSfp8h1x2sXKLivvxHQN+Q=;
 b=I/7Hq50FT5ismIiyyHj8flA4J7r1XWJKMxJKSz8etWzqURQbTo6TY/o3XoPdYJSIQefPU4
 CWZBKfQuqZHbwABA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2257779B2;
 Mon, 10 Aug 2026 10:31:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id X6viMYeoeWpaaAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 10 Aug 2026 10:31:35 +0000
Date: Mon, 10 Aug 2026 12:31:34 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <avinesh.kumar@suse.com>
Message-ID: <20260810103134.GA918586@pevik>
References: <20260806074713.158271-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260806074713.158271-1-avinesh.kumar@suse.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: ED94E3E43
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 REPLYTO_EQ_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[wooledge.org:url,suse.cz:replyto,suse.cz:email,suse.cz:dkim,nfs06.sh:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] nfs_lib: Skip NFS versions disabled on server
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

Hi Avinesh,

> nfs06.sh mount several NFS versions in a single run
> (e.g. "3,4.0,4.1,4.2"). If the server has disabled one of
> the requested versions (reported via /proc/fs/nfsd/versions),
> the whole test currently aborts with TBROK on the failed mount
> instead of continuing with the versions that are supported.

> nfs06 1 TINFO: setup NFSv4.0, socket type tcp
> nfs06 1 TINFO: Mounting /var/tmp/LTP_nfs06.GHDqCwPYES/4.0/1
> nfs06 1 TINFO: Mounting NFS: mount -v -t nfs -o proto=tcp,vers=4.0 10.0.0.2:/var/tmp/LTP_nfs06.GHDqCwPYES/mntpoint/4.0/tcp /var/tmp/LTP_nfs06.GHDqCwPYES/4.0/1
> mount.nfs: mount(2): Invalid argument
> mount.nfs: an incorrect mount option was specified for /var/tmp/LTP_nfs06.GHDqCwPYES/4.0/1
> mount.nfs: timeout set for Wed Aug  5 08:06:38 2026
> mount.nfs: trying text-based options 'proto=tcp,vers=4.0,addr=10.0.0.2,clientaddr=10.0.0.1'
> nfs06 1 TBROK: mount command failed

> Add nfs_server_vers_enabled() to check /proc/fs/nfsd/versions on the
> server, and nfs_filter_versions() to drop disabled versions from
> $VERSION (keeping $SOCKET_TYPE aligned by position) before mounting.
> If none of the requested versions are enabled, TCONF as before.

Thanks for handling this!

LGTM? few notes below.
Reviewed-by: Petr Vorel <pvorel@suse.cz>
...

> -get_socket_type()
> +get_socket_type_raw()
very nit: slightly confusing type, because there is a "raw" socket SOCK_RAW.
I guess any network programmer seeing this will think of that socket, e.g.:
socket(PF_INET, SOCK_RAW, ...);
socket(PF_NETLINK, SOCK_RAW, NETLINK_ROUTE);

But of course it can stay.

>  {
>  	local t
>  	local k=0
>  	for t in $SOCKET_TYPE; do
>  		if [ "$k" -eq "$1" ]; then
> -			echo "${t}${TST_IPV6}"
> +			echo "$t"
>  			return
>  		fi
>  		k=$(( k + 1 ))
>  	done
>  }

> +get_socket_type()
> +{
> +	echo "$(get_socket_type_raw "$1")${TST_IPV6}"
> +}
> +
>  # directory mounted by NFS client
>  get_local_dir()
>  {
> @@ -109,6 +114,51 @@ nfs_server_udp_enabled()
>  	tst_rhost_run -c "grep -q \"^[# ]*udp *= *y\" /etc/nfs.conf $config"
>  }

> +# nfs_server_vers_enabled VERS
> +# Only returns false (1) when the server explicitly lists "-VERS" in
> +# /proc/fs/nfsd/versions. If that file is unavailable or doesn't mention
> +# VERS at all, defaults to true so the mount is still attempted.
> +nfs_server_vers_enabled()
> +{
> +	local vers="$1"
> +	local versions=" $(tst_rhost_run -c 'cat /proc/fs/nfsd/versions 2>/dev/null') "
> +
> +	case "$versions" in
> +	*" -$vers "*) return 1;;
> +	esac

very nit: I was thinking if having the space in case would be slightly more
readable, but probably not. I consider spaces in both versions as unnecessary
(i.e. formatting error) but of course they are necessary.

	local versions="$(tst_rhost_run -c 'cat /proc/fs/nfsd/versions 2>/dev/null')"

	case " $versions " in

> +
> +	return 0
> +}
> +
> +# Drops NFS versions the server explicitly disabled from $VERSION, keeping
> +# $SOCKET_TYPE entries aligned by position with what remains.
> +nfs_filter_versions()
> +{
> +	local v type
> +	local n=0
> +	local new_version=
> +	local new_socket_type=
nit: it should be safe to use it without '=', right?
local v type new_version new_socket_type

> +
> +	for v in $VERSION; do
> +		type=$(get_socket_type_raw $n)
> +
> +		if nfs_server_vers_enabled "$v"; then
> +			new_version="$new_version $v"
> +			new_socket_type="$new_socket_type $type"
> +		else
> +			tst_res TINFO "NFSv$v disabled on server, skipping"

Could this be TCONF so that results summary at the end shows some TCONF?
That indicates something was skipped.

+			tst_res TINFO "NFSv$v disabled on server, skipping"
+			tst_res TCONF "NFSv$v disabled on server, skipping"

> +		fi
> +
> +		n=$(( n + 1 ))
> +	done
> +
> +	[ -z "$new_version" ] && \
> +		tst_brk TCONF "none of the requested NFS versions ($VERSION) are enabled on server"
nit: I would expect this would quit the test on system with
set -o errexit (equivalent of set -e), but magically it works.
FYI normally it's better if any test line exit with 0 => use || (or if ...; then
... fi) instead &&  i.e.

[ ... ] || tst_brk TCONF

But because it works it can stay.

> +
> +	VERSION="${new_version# }"
> +	SOCKET_TYPE="${new_socket_type# }"

Fortunately removing leading space works also on dash, although at least some
string operations aren't part of POSIX [1].

If this is ever problematic, we can fix it with:

	[ "$new_version" ] && new_version="$new_version $v" || new_version="$v"
	[ "$new_socket_type" ] && new_socket_type="$new_socket_type $type" || new_socket_type="$type"

But because removing leading space is not needed, because later code for t in
$SOCKET_TYPE; do will handle that, I'd remove this part entirely.

FYI: (no leading/trailing space in parameters, no $t having just empty space:
SOCKET_TYPE=' udp tcp  '; for t in $SOCKET_TYPE; do echo "'$t'"; done
'udp'
'tcp'

[1] https://mywiki.wooledge.org/Bashism#Parameter_Expansions

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
