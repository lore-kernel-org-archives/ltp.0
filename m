Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F4FEC433F5
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 17:03:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C35B3C8CBD
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 18:03:33 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8644C3C8C8C
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 18:03:23 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C6E101A0065F
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 18:03:22 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CEAC31F37F;
 Fri, 11 Mar 2022 17:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647018201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y0DnAo0hp0wZJg03C6GY2crs7InFOrgsgI3zkNXhvog=;
 b=Rywo8C14rr3V4jJg646V+Hn2DtDG4/R9pGi3jE0mC0UwKewOc9OOmaVPCDMnkgpcmXNY2H
 2S7YpcvemkWaIq35y2mn61aZz4Lovfgi73qv0M83cS/cpfsnj6R/3egJd2m9w9/c4FiqNd
 YVwBOHIYIjHWc4GFyYRyPMS99Gq/pdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647018201;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y0DnAo0hp0wZJg03C6GY2crs7InFOrgsgI3zkNXhvog=;
 b=NbXpMdwe+C9BaPFnaBECAHBDbrfW8kuwuByDCHYsXTHsoFXls9xBKifO5QNOYO3fHDHMHs
 lp9uUDv0Tj7wdbAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B132013A95;
 Fri, 11 Mar 2022 17:03:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wuAyKtmAK2L+NwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 11 Mar 2022 17:03:21 +0000
Message-ID: <7366ca0a-b57a-94ed-8ffe-124ae3a0d6a3@suse.cz>
Date: Fri, 11 Mar 2022 18:03:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20220311132245.14639-1-pvorel@suse.cz>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20220311132245.14639-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] nfs_lib.sh: Require mount.nfs, print version
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
Cc: Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
looks good to me.

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 11. 03. 22 14:22, Petr Vorel wrote:
> mount.nfs is required for mounting nfs.
> NOTE: we check only on lhost. Unlike for exportfs which is actually
> required on rhost when testing via ssh, mount.nfs is required on lhost
> (unless netns testing, but that is actually always on lhost).
> 
> Print its version for better debugging.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/network/nfs/nfs_stress/nfs_lib.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> index 1bf31eed25..55ce1e11a4 100644
> --- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
> +++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> @@ -29,7 +29,7 @@ TST_PARSE_ARGS=nfs_parse_args
>  TST_USAGE=nfs_usage
>  TST_NEEDS_TMPDIR=1
>  TST_NEEDS_ROOT=1
> -TST_NEEDS_CMDS="$TST_NEEDS_CMDS mount exportfs"
> +TST_NEEDS_CMDS="$TST_NEEDS_CMDS mount exportfs mount.nfs"
>  TST_SETUP="${TST_SETUP:-nfs_setup}"
>  TST_CLEANUP="${TST_CLEANUP:-nfs_cleanup}"
>  TST_NEEDS_DRIVERS="nfsd"
> @@ -153,6 +153,8 @@ nfs_setup()
>  		done
>  	fi
>  
> +	tst_res TINFO "$(mount.nfs -V)"
> +
>  	for i in $VERSION; do
>  		type=$(get_socket_type $n)
>  		tst_res TINFO "setup NFSv$i, socket type $type"


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
