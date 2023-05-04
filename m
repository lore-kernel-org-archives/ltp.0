Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0871BC77B7C
	for <ltp@archiver.kernel.org>; Thu,  4 May 2023 22:03:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 92AF03CD8BE
	for <ltp@archiver.kernel.org>; Fri,  5 May 2023 00:03:09 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2EC333CB737
 for <ltp@lists.linux.it>; Fri,  5 May 2023 00:02:58 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0AE6A6008BD
 for <ltp@lists.linux.it>; Fri,  5 May 2023 00:02:57 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 336B91FD6B;
 Thu,  4 May 2023 22:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683237777;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=chmLSqNowL16JqBY6RvWE0xmKKybZomj8imcuXLsOGA=;
 b=LuzDzYZBc4UPhw0eR4xZGrnHZUXgyalIhsGBajNo0lp2zIPL0IfgbU1LFh9ernxNyzObZ4
 weaNISE2pwUqg9mHAW+f8YHqVOh4RJmDli+GWYBhBy3MS23MzCbt88XJ+/+huwUKAavs07
 UC5a5S3aPMoIwa5mTU3+OoSIlmhJp2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683237777;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=chmLSqNowL16JqBY6RvWE0xmKKybZomj8imcuXLsOGA=;
 b=slo7459POaS3hEmF29RAV1ibMV2xEMp/1YSXVgHOkNjARBhDVu9y/H7LckhPwRHaYEmSU5
 XT7gOJbBtWTLkUCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7444D133F7;
 Thu,  4 May 2023 22:02:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XDs4F5ArVGQATQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 04 May 2023 22:02:56 +0000
Date: Fri, 5 May 2023 00:02:54 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it,
 NeilBrown <neilb@suse.de>, linux-nfs@vger.kernel.org,
 Jeff Layton <jlayton@kernel.org>
Message-ID: <20230504220254.GC4244@pevik>
References: <20230504131414.3826283-1-pvorel@suse.cz>
 <20230504131414.3826283-6-pvorel@suse.cz> <ZFO6ywouPkmNKtkr@yuki>
 <20230504220037.GB4244@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230504220037.GB4244@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

...
> check_umount()
> {
> 	local i
> 	local dir="$1"
> 	local type="${2:-lhost}"
> 	local cmd="grep -q $dir /proc/mounts"

> 	for i in $(seq 50); do
> 		if [ "$type" = "lhost" ]; then
> 			$cmd || return
> 		else
> 			tst_rhost_run -c "$cmd" || return
> 		fi
> 		tst_sleep 100ms
> 		tst_res TWARN "failed to umount '$dir'"
> 	done
Obviously TWARN should be here.
...

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
