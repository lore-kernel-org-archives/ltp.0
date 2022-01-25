Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3447C433EF
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 14:48:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 19FCC3C9543
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 15:48:50 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 204A53C932A
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 15:48:40 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4E11E1A009AA
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 15:48:39 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 803D51F380;
 Tue, 25 Jan 2022 14:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643122119;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oGIpa4uqOv4MJ9J5tvdRQ+7juvZBfy/52tA7ET63Noc=;
 b=aY/mWVZvbusuw+pjRPdRP4rtG76+wyb6F1YVIaIkGjZ8LHj0JVduFojTPMemXo5a43AH3k
 cDsmsDy0aWi6XSpTE6/JvfdRTCk14kqsBkYOKTaMj4pnLjoxq9PfAfOMCIb3edTEQTLna2
 e1c36E1V5xsrhNjwtd/lxINpV5HhV/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643122119;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oGIpa4uqOv4MJ9J5tvdRQ+7juvZBfy/52tA7ET63Noc=;
 b=O/VjsqUexThlvooqMtFHD9L62rDOybJaD45RZ09HlBMeOnszF3CNhUD7zchkrv6MVTOKmu
 VQDoAmvbP54f+PBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4EA7B13E02;
 Tue, 25 Jan 2022 14:48:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WLM5EccN8GEPeQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 25 Jan 2022 14:48:39 +0000
Date: Tue, 25 Jan 2022 15:48:37 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it, Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YfANxZOv13yZwY3C@pevik>
References: <20220125144043.31798-1-pvorel@suse.cz>
 <20220125144043.31798-4-pvorel@suse.cz> <YfANU1rO2niDncMA@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YfANU1rO2niDncMA@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/4] sched_get_priority_min01: Add missing
 policies
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

> this test and sched_get_priority_max01 (latest commit) need to include lapi/sched.h.
> I'll fix it before merge.
For a record: on traditional distros with glibc it's required only on CentOS 7
and Ubuntu Xenial (very old distros, but Centos 7 EOL in 2024).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
