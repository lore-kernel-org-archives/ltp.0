Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63E0C25B75
	for <ltp@archiver.kernel.org>; Fri, 31 May 2024 08:00:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 329553D0754
	for <ltp@archiver.kernel.org>; Fri, 31 May 2024 10:00:01 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 66CDA3CFFC8
 for <ltp@lists.linux.it>; Fri, 31 May 2024 09:59:46 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8063F60110B
 for <ltp@lists.linux.it>; Fri, 31 May 2024 09:59:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3829221AC5;
 Fri, 31 May 2024 07:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717142382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1tP8XVNlc8MaovVZZI69zi2uEi6M2d6VoD6+LbMKLuU=;
 b=BvcDgbO4bZCzM9KIB5Yuy7XC+bSG0wto7SBFGtWBEgiVXrEYAf+Q1QwU5apwuDXj9z3u4X
 m7z3Q5xfhzBEbwAmvEWYnslOwrwSEMZ+X+wzqjmx8FCX5bMnaKhOVy4Ij7XAfSbug7kf2x
 njPenMechma4G6UCJj2H85LpiKc7v2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717142382;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1tP8XVNlc8MaovVZZI69zi2uEi6M2d6VoD6+LbMKLuU=;
 b=OTOEwLAHghlhcTx0cErJAfTnwoDYCuOF6M8QX5NVcntWcW4ZVt4SMgGI1m0KN4ozB3ZhnD
 y6BySq/ngdPofdBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717142382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1tP8XVNlc8MaovVZZI69zi2uEi6M2d6VoD6+LbMKLuU=;
 b=BvcDgbO4bZCzM9KIB5Yuy7XC+bSG0wto7SBFGtWBEgiVXrEYAf+Q1QwU5apwuDXj9z3u4X
 m7z3Q5xfhzBEbwAmvEWYnslOwrwSEMZ+X+wzqjmx8FCX5bMnaKhOVy4Ij7XAfSbug7kf2x
 njPenMechma4G6UCJj2H85LpiKc7v2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717142382;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1tP8XVNlc8MaovVZZI69zi2uEi6M2d6VoD6+LbMKLuU=;
 b=OTOEwLAHghlhcTx0cErJAfTnwoDYCuOF6M8QX5NVcntWcW4ZVt4SMgGI1m0KN4ozB3ZhnD
 y6BySq/ngdPofdBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1777B137C3;
 Fri, 31 May 2024 07:59:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MRJyBW6DWWapfgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 31 May 2024 07:59:42 +0000
Date: Fri, 31 May 2024 10:01:12 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ZlmDyAiceBB_-2V_@rei>
References: <20240530-ioctl_ficlone-v1-0-fa96f07d0fca@suse.com>
 <20240530-ioctl_ficlone-v1-1-fa96f07d0fca@suse.com>
 <ZlhZiZBUsEnmtwNT@yuki>
 <885f7007-5726-475e-8f34-5554bed7aa1f@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <885f7007-5726-475e-8f34-5554bed7aa1f@suse.com>
X-Spamd-Result: default: False [-7.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] Add ioctl_ficlone01 test
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
> > I suppose that we need .use_filesystems or similar and convert the
> > dev_fs_type to an array so that we can run this test on xfs as well...
> This might be tricky to implement, since we need to adapt .dev_fs_ops as 
> well..

I guess that we need to do a bigger surgery and put all the device
related flags into a structure, e.g.

struct tst_fs {
	const char *dev_fs_type;

	const char *const *mkfs_opts;
        const char *const *mkfs_extra_opts;

	unsigned int mnt_flags;
	const char *mnt_data;
};

struct tst_test {
	...
	struct tst_fs filesystems[];
	...
};

That way we can specify all the options per a filesystems. I can try to
do prepare the patchset next week.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
