Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3DDC77B78
	for <ltp@archiver.kernel.org>; Thu,  4 May 2023 14:00:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA87B3CBA6F
	for <ltp@archiver.kernel.org>; Thu,  4 May 2023 16:00:56 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF4373CB742
 for <ltp@lists.linux.it>; Thu,  4 May 2023 16:00:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 20E3C600915
 for <ltp@lists.linux.it>; Thu,  4 May 2023 16:00:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 01D4622392;
 Thu,  4 May 2023 14:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683208845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cSg8xEc+OUHSL0vqKyRefktIT42eQuoCl5F13vetUbY=;
 b=xvl5tOVN9zHrRZgPNmu8Kp9gIAzJCzid0+rIBzG+ryci57CGLsiZ83bDjaiLt8ZJZxsY3G
 W2F/SAPgb5gh+0TvAkimkvualsKgLUTxqKoyNJtG3kBsWTLwMXNKsSLGcP1iQg9YfBZw/+
 60NbxbrTfWJglgkHsVHcLuUJo5hAxWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683208845;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cSg8xEc+OUHSL0vqKyRefktIT42eQuoCl5F13vetUbY=;
 b=F5i6VI6x7uYKBFEsKc7pWz3YMPs7wQwAexNTR+6fCvfO/wJYyjKCl2HLKaj0oSSQd10+f0
 xTqNpJGUcgUZB2DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E0B7613444;
 Thu,  4 May 2023 14:00:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id O8TCNYy6U2TIcQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 04 May 2023 14:00:44 +0000
Date: Thu, 4 May 2023 16:01:47 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZFO6ywouPkmNKtkr@yuki>
References: <20230504131414.3826283-1-pvorel@suse.cz>
 <20230504131414.3826283-6-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230504131414.3826283-6-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 5/5] nfs: Run on btrfs, ext4, xfs
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
Cc: NeilBrown <neilb@suse.de>, linux-nfs@vger.kernel.org,
 Jeff Layton <jlayton@kernel.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
>  nfs_get_remote_path()
> @@ -210,6 +213,7 @@ nfs_cleanup()
>  		grep -q "$local_dir" /proc/mounts && umount $local_dir
>  		n=$(( n + 1 ))
>  	done
> +	sleep 2
>  
>  	n=0
>  	for i in $VERSION; do
> @@ -219,12 +223,15 @@ nfs_cleanup()
>  		if tst_net_use_netns; then
>  			if test -d $remote_dir; then
>  				exportfs -u *:$remote_dir
> +				sleep 1
>  				rm -rf $remote_dir
>  			fi
>  		else
>  			tst_rhost_run -c "test -d $remote_dir && exportfs -u *:$remote_dir"
> +			sleep 1
>  			tst_rhost_run -c "test -d $remote_dir && rm -rf $remote_dir"
>  		fi
> +
>  		n=$(( n + 1 ))
>  	done

Generally I'm not happy about the sleeps in the code, the main problem
is that the test still may fail in a case that something was slower than
usuall and we decided to proceed after we slept for a pre-defined
interval. Ideally these should be replaced with a active waiting, i.e.
loop that checks some condition 10 times in a second or so. Hoewever I'm
okay with getting this in so that we manage to have these tests in
before the release and fixing it later on.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
