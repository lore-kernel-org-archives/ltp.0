Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3055E77180
	for <ltp@archiver.kernel.org>; Tue, 10 Dec 2024 11:03:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 248893E8CB1
	for <ltp@archiver.kernel.org>; Tue, 10 Dec 2024 12:03:34 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 36FDD3D96CB
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 12:03:17 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9EE8A1035C79
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 12:03:16 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DB4CC1F395;
 Tue, 10 Dec 2024 11:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733828595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4yHfunjFn93PlMmXuRmF+gySA7SL9sTXsoKqeo2yT9g=;
 b=ReTjWChqg8z+4jq1dfudrb4SY1JskOeYvJA4wiSCM8OgLjIF0USKwao+WkkNAKCnoiPt6P
 GcQq9DhQUpuEej2WC1vYAnsyJXaylPdMJOYmiMQFa0znG/HeJU45YY5CgJhTijvOg9lxwU
 9Lx1eKr1jk4TmlXdfASPyCc1AfqKjro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733828595;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4yHfunjFn93PlMmXuRmF+gySA7SL9sTXsoKqeo2yT9g=;
 b=Y/tXwp6QzIE+6SoIiC4E7vN3wGMGCCTq82EdOS1FeC7723dSwkD3owiMPSk/VFNsOpWXEf
 gdZnlhui3HSxa8DQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zj5k+LCN;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Fg+hV4O2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733828594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4yHfunjFn93PlMmXuRmF+gySA7SL9sTXsoKqeo2yT9g=;
 b=zj5k+LCNDx7STT6o+S8W11QgvgE37tYgTVwlLZ70sKGBowKKGaClP793qVg2I1Ul6xmRcr
 LywaN5zWYP1TG44YggUDG5yToQNhjJidsgVP2BCQ6+xyAKOe8CrzgvDK45Tn+L1iMMRe2u
 2JULoWHbEw05VTERA3Vs720sFatMAls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733828594;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4yHfunjFn93PlMmXuRmF+gySA7SL9sTXsoKqeo2yT9g=;
 b=Fg+hV4O2EQ1Re//UWgFRRcJ1yUpHL5s5ui6Y8CthAgKl9ZIbf9SNc/2wGDhgZBqlUJO+L4
 FOTvQ0CT880pw0Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC78D138D2;
 Tue, 10 Dec 2024 11:03:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +gGLMPIfWGeAUQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 10 Dec 2024 11:03:14 +0000
Date: Tue, 10 Dec 2024 12:03:22 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: samasth.norway.ananda@oracle.com
Message-ID: <Z1gf-odBjJ3XQhmT@yuki.lan>
References: <20240626010532.2845919-1-samasth.norway.ananda@oracle.com>
 <CAEemH2fskxgP9cFB-8zztts1qqtCJ2g01A=4+w6OxU6O_pE-9w@mail.gmail.com>
 <0865e127-cd49-4d8a-b334-039f94b80e76@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0865e127-cd49-4d8a-b334-039f94b80e76@oracle.com>
X-Rspamd-Queue-Id: DB4CC1F395
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [External] : Re: [PATCH] fallocate03:
 FALLOC_FL_PUNCH_HOLE must be used with FALLOC_FL_KEEP_SIZE
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
> >  From the fallocate() manual, I see that:
> > "The FALLOC_FL_PUNCH_HOLE flag must be ORed withFALLOC_FL_KEEP_SIZE in mode"
> > 
> > But it doesn't mean we wouldn't use FALLOC_FL_KEEP_SIZE singly in this test.
> 
> Oh okay. Sorry mistook that.

The problem here is that most of the fallocate() modes are not supported
on NFS just have a look on how fallocate is implemented in
linux/fs/nfs/nfs4file.c:

static long nfs42_fallocate(struct file *filep, int mode, loff_t offset, loff_t len)
{
        struct inode *inode = file_inode(filep);
        long ret;

        if (!S_ISREG(inode->i_mode))
                return -EOPNOTSUPP;

        if ((mode != 0) && (mode != (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE)))
                return -EOPNOTSUPP;

...

So only two combinations of modes are actually supported. I guess that
it may make sense to skip the unsupported modes for NFS.

And it may make sense to enable the test for all_filesystems as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
