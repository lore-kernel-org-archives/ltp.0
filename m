Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539B7C4332F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 17:01:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 24B033CDCC1
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 18:01:45 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E7B73CC88F
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 18:01:35 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 63482200E03
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 18:01:33 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 509D61FD81;
 Fri, 25 Nov 2022 17:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669395693;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+/LVg9c20jAKYq9HLjL0a2b/l1RX6G5YZt8+Nm1dBPs=;
 b=yyMcqtosYp87siYHu+Aai6aCnHR/eZ1cID9Wldlax82CXMg8n9ZZxURso15b3vtl78aBza
 hkafMgaCdXclwIjhX7CDoP+kDrB32fY3vnUP2kwjK4umKEv6samBtdXQiFl/EUW/WjtiaD
 dV4F3SFljGPrIeJfxFxa0zVYcGxOvz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669395693;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+/LVg9c20jAKYq9HLjL0a2b/l1RX6G5YZt8+Nm1dBPs=;
 b=pMFnJ/sh0tQ173W9AarZTzMTVM05wJrk09usOeYqDlKXMc9e2VID828YdPBsY/kI4nPazU
 Yroh0b/FLctUT0Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2743413A08;
 Fri, 25 Nov 2022 17:01:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VSi+B+30gGOaNwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 25 Nov 2022 17:01:33 +0000
Date: Fri, 25 Nov 2022 18:01:31 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Y4D066q2R/0S2xFe@pevik>
References: <20221125153453.19323-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221125153453.19323-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] Implement tst_setup_netns() helper function
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

Hi Martin,

> +void tst_setup_netns(void)
> +{
> +	int real_uid = getuid();
> +	int real_gid = getgid();
> +	int nscount = 1;
> +
> +	if (!access("/proc/sys/user/max_user_namespaces", F_OK)) {
Out of curiosity, this can happen only on old kernel, which does not support
user namespaces (kernel < 3.8) ? I guess there must be other case,
I suppose you would not bother about 3.8, right?

Also asking that if not readable we don't TCONF (int nscount = 1).

Kind regards,
Petr

> +		SAFE_FILE_SCANF("/proc/sys/user/max_user_namespaces", "%d",
> +			&nscount);
> +	}
> +
> +	if (!nscount)
> +		tst_brk(TCONF, "User namespaces are disabled");
> +
> +	SAFE_UNSHARE(CLONE_NEWUSER);
> +	SAFE_UNSHARE(CLONE_NEWNET);
> +	SAFE_FILE_PRINTF("/proc/self/setgroups", "deny");
> +	SAFE_FILE_PRINTF("/proc/self/uid_map", "0 %d 1", real_uid);
> +	SAFE_FILE_PRINTF("/proc/self/gid_map", "0 %d 1", real_gid);
> +}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
