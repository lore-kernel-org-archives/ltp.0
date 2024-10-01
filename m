Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EFF1CEACDD
	for <ltp@archiver.kernel.org>; Tue,  1 Oct 2024 15:35:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 013E93C5974
	for <ltp@archiver.kernel.org>; Tue,  1 Oct 2024 17:35:13 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C5623C5820
 for <ltp@lists.linux.it>; Tue,  1 Oct 2024 17:34:57 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F15B21A001E8
 for <ltp@lists.linux.it>; Tue,  1 Oct 2024 17:34:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 75FAB1F8AE;
 Tue,  1 Oct 2024 15:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1727796895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fxKXSkhH0Tu1Bi4lPmn1tAejBhEXGY2LRgsVTm2xFD0=;
 b=puTibodPsMrnLL2F/iuhbDrYH1WlE/NGLsuKrt5y6zYgVhgmvSuvwzgTuIcDSG/2e2W+3n
 nOJZZ6Yb4rgn0T9EmbGUQCPchnEPc2I+g+Z/dwRvYsK8zy3brJ6KEEpM4wUIHaGHH5Eq7A
 mjAzO8Kaw2MLtKgOe0k3VuQ97f5Zs48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1727796895;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fxKXSkhH0Tu1Bi4lPmn1tAejBhEXGY2LRgsVTm2xFD0=;
 b=wZrYqoZszteNtiTM7A3PZrXfqcSFaLGe9QkCGg5spT4sMcOxnIEpMhUj+1ZTv85VAAP0u1
 dC0SW84XdFeb5CAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1727796895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fxKXSkhH0Tu1Bi4lPmn1tAejBhEXGY2LRgsVTm2xFD0=;
 b=puTibodPsMrnLL2F/iuhbDrYH1WlE/NGLsuKrt5y6zYgVhgmvSuvwzgTuIcDSG/2e2W+3n
 nOJZZ6Yb4rgn0T9EmbGUQCPchnEPc2I+g+Z/dwRvYsK8zy3brJ6KEEpM4wUIHaGHH5Eq7A
 mjAzO8Kaw2MLtKgOe0k3VuQ97f5Zs48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1727796895;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fxKXSkhH0Tu1Bi4lPmn1tAejBhEXGY2LRgsVTm2xFD0=;
 b=wZrYqoZszteNtiTM7A3PZrXfqcSFaLGe9QkCGg5spT4sMcOxnIEpMhUj+1ZTv85VAAP0u1
 dC0SW84XdFeb5CAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F06513A73;
 Tue,  1 Oct 2024 15:34:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id S3A+CJ8W/GbRNgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 01 Oct 2024 15:34:55 +0000
Date: Tue, 1 Oct 2024 17:33:50 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZvwWXjwDg31L1zSu@yuki.lan>
References: <20241001-ioctl_ficlone01_fix-v2-0-dd0b021dd31d@suse.com>
 <20241001-ioctl_ficlone01_fix-v2-3-dd0b021dd31d@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241001-ioctl_ficlone01_fix-v2-3-dd0b021dd31d@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] Setup minimal kernel for
 ioctl_clone(range) tests
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +		{
> +			.type = "bcachefs",
> +			.min_kver = "6.7",

I do not think that the min_kver is needed here, because if there is no
kernel support for bcachefs it will be skipped simply because it's
missing.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
