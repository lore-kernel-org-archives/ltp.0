Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0300C433F5
	for <ltp@archiver.kernel.org>; Fri, 13 May 2022 09:08:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AC6FE3CA9E8
	for <ltp@archiver.kernel.org>; Fri, 13 May 2022 11:08:43 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 14C4C3CA9CC
 for <ltp@lists.linux.it>; Fri, 13 May 2022 11:08:33 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CD1061A01178
 for <ltp@lists.linux.it>; Fri, 13 May 2022 11:08:32 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 33F421F932;
 Fri, 13 May 2022 09:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652432912;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+bwbYtGBQiQ0BFK+mBmAzqTkMstvnNNGKGi+xtCy8Fs=;
 b=lNYVg6NU4mPUeDvIVQMUMXUNM7/uwHZ9AkeIWigApuBCf4nUL3EfQydo6qIr5EzihgX7Vi
 w1gzm/vsdXcqWE21rJjUE0ip3JuK1Sz+e8JiBuwgL7MYGuwpDIxiQvPbRP1x/5LJQ/SyD0
 Ij5BKRP4zsqjd59R1kxYMa8hrXcYpNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652432912;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+bwbYtGBQiQ0BFK+mBmAzqTkMstvnNNGKGi+xtCy8Fs=;
 b=7BP5zxUmQQULhzq0iKflo5s1gNUXOVWZHIxQjqzqqJ9Oyp3CEkcYq+EIRKqU3rSm4tWSTe
 3lgH+t85m0uZexCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F286513A84;
 Fri, 13 May 2022 09:08:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9XqgOQ8gfmLVcgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 13 May 2022 09:08:31 +0000
Date: Fri, 13 May 2022 11:08:30 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <Yn4gDgUqjBo8naOa@pevik>
References: <20220512194557.30911-1-pvorel@suse.cz>
 <20220512194557.30911-9-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220512194557.30911-9-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 8/8] nfs07.sh: Use TST_ALL_FILESYSTEMS=1
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
Cc: Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

>  testcases/network/nfs/nfs_stress/nfs07.sh | 2 ++
...
>  TST_TESTFUNC="do_test"
>  TST_SETUP="do_setup"
>  TST_USAGE="show_usage"
> +TST_ALL_FILESYSTEMS=1

It will not be that simple. Because $TST_TMPDIR is not the mountpoint
($TST_MNTPOINT mountpoint is $PWD/mntpoint, which is $TST_TMPDIR/mntpoint for
$TST_ALL_FILESYSTEMS) IMHO we need at least to:

1) cd to $TST_MNTPOINT on lhost and rhost (nfs_setup_server() runs NFS server
on lhost for netns, otherwise on rhost)
2) local_dir and remote_dir in nfs_setup need to use $TST_MNTPOINT instead of $TST_TMPDIR
=> it'd be easier to port *all* NFS tests to $TST_ALL_FILESYSTEMS, not sure if we
want that.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
