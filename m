Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72332C433F5
	for <ltp@archiver.kernel.org>; Thu,  5 May 2022 08:16:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DFCAF3CA8BE
	for <ltp@archiver.kernel.org>; Thu,  5 May 2022 10:16:48 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 009DD3CA3BE
 for <ltp@lists.linux.it>; Thu,  5 May 2022 10:16:37 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7A3491000A22
 for <ltp@lists.linux.it>; Thu,  5 May 2022 10:16:37 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A8972210DF;
 Thu,  5 May 2022 08:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651738596;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xAOTt3/QtTZnX8kocvvIddF95I3hLgmYCN+xgpPO52Q=;
 b=1ThxjackPVEJKyu7V68fJrk6eJpgJN7rY8EgBAo1/xJMTFNjaFbifR6hjGWbYUVsdQmC+y
 hzEEmvX/xjhw7KBTrXSVMVR4EB5iAgw4uA6DcOfgsR2aTiNkYeCWJmhx1cNaGNrFWHCC+p
 Wrip3ap4GVj2QeZuF8YEiRgN9rdNcLI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651738596;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xAOTt3/QtTZnX8kocvvIddF95I3hLgmYCN+xgpPO52Q=;
 b=IO0OevK1epNz1VurLrK1lLg+Z0rUktcda9OrIs6kuBdtqI3/6/Cv60wBLS1sUSg46JIuP3
 TrQH9/8bSG1GrzBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C68513B11;
 Thu,  5 May 2022 08:16:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1W4UHeSHc2KkBwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 05 May 2022 08:16:36 +0000
Date: Thu, 5 May 2022 10:16:34 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Message-ID: <YnOH4h8rTbg1NzCO@pevik>
References: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
 <3d85635f6b87c73a2389627bc94c847c52165dc7.1651176646.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3d85635f6b87c73a2389627bc94c847c52165dc7.1651176646.git.luke.nowakowskikrijger@canonical.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 11/19] controllers: Expand cgroup_lib shell
 library
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

Hi Luke,

> diff --git a/testcases/kernel/controllers/cgroup_lib.sh b/testcases/kernel/controllers/cgroup_lib.sh
...
> +_cgroup_state=
> +
> +_cgroup_check_return()
> +{
> +	local ret="$1"
> +	local msg="$2"
> +
> +	tst_flag2mask TBROK
> +	[ "$ret" = "$?" ] && tst_brk TBROK "$msg"
> +
> +	tst_flag2mask TCONF
> +	[ "$ret" = "$?" ] && tst_brk TCONF "$msg"
> +}
As I wrote in previous patch likely we can avoid tst_flag2mask in new API.

In few cases where needed we hardwired numbers (IMHO POSIX shell does not
support constants, which would be better than variables which can be changed).

In this case you could probably use ROD() or EXPECT_PASS_BRK().
We use ROD() for external commands, thus support only TBROK on 0,
but it should be probably safe to add TCONF on 32. If others consider it
dangerous, we can add another function in tst_test.sh, e.g. ROD_LTP() which
would expect LTP exit codes.

...
> +# Cleans up any setup done by calling cgroup_require.
> +# USAGE: cgroup_cleanup
> +# Can be safely called even when no setup has been done
> +cgroup_cleanup()
> +{
> +	[ "$_cgroup_state" = "" ] && return 0
> +
> +	tst_cgctl cleanup "$_cgroup_state"
> +
> +	_cgroup_check_return "$?" "cgroup_cleanup: tst_cgctl cleanup exited"
> +
> +	_cgroup_state=""
nit: can be just
_cgroup_state=


Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
