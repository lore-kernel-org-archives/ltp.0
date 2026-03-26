Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A49410A1E9B
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 15:05:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 345FE3C5A8C
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 16:05:31 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA62A3C5A8C
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 16:05:11 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E471A1A0121B
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 16:05:10 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 474054D2C4;
 Thu, 26 Mar 2026 15:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774537509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=31gaRmO3BAYr2wdUxVeTpNf1S/JeymLvgKNAGFtdai4=;
 b=oMFLNxGS8760s/QlK7fArxKjC0uK6qRjsEhESdo2wS1JJLlaJqNx8iD8l3zWD5R8ifeTT7
 PGp7Z01JLCWQO2id7Q1tZBiLvep+4haEh54RGEtohcZsb6TYhdMYtokGlllo1NKlepveqb
 ogAX8D/vsqZtzmSaQFpdx8B82YPCEVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774537509;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=31gaRmO3BAYr2wdUxVeTpNf1S/JeymLvgKNAGFtdai4=;
 b=ZZITek47RZpA4N2tE7r4wokJp71p2iQ4H5IErc9e/Eec+ve+6MBaoOOXKyhVWOZ0WUZx+a
 N0550jtHz/gffHAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oMFLNxGS;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZZITek47
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774537509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=31gaRmO3BAYr2wdUxVeTpNf1S/JeymLvgKNAGFtdai4=;
 b=oMFLNxGS8760s/QlK7fArxKjC0uK6qRjsEhESdo2wS1JJLlaJqNx8iD8l3zWD5R8ifeTT7
 PGp7Z01JLCWQO2id7Q1tZBiLvep+4haEh54RGEtohcZsb6TYhdMYtokGlllo1NKlepveqb
 ogAX8D/vsqZtzmSaQFpdx8B82YPCEVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774537509;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=31gaRmO3BAYr2wdUxVeTpNf1S/JeymLvgKNAGFtdai4=;
 b=ZZITek47RZpA4N2tE7r4wokJp71p2iQ4H5IErc9e/Eec+ve+6MBaoOOXKyhVWOZ0WUZx+a
 N0550jtHz/gffHAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 324534A0A3;
 Thu, 26 Mar 2026 15:05:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id h7QICyVLxWk1SgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 26 Mar 2026 15:05:09 +0000
Date: Thu, 26 Mar 2026 16:05:15 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: kernel test robot <oliver.sang@intel.com>
Message-ID: <acVLK8F8i-eEZwLG@yuki.lan>
References: <20260316-mark-dirty-per-folio-v1-1-8dc39c94b7ce@ddn.com>
 <202603261451.d2a4cd46-lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202603261451.d2a4cd46-lkp@intel.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_CC(0.00)[birthelmer.com,intel.com,szeredi.hu,bsbernd.com,vger.kernel.org,ddn.com,lists.linux.it,lists.linux.dev,gmail.com];
 DKIM_TRACE(0.00)[suse.cz:+]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_SEVEN(0.00)[11];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email]
X-Rspamd-Queue-Id: 474054D2C4
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fuse: when copying a folio delay the mark dirty
 until the end
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
Cc: lkp@intel.com, Miklos Szeredi <miklos@szeredi.hu>,
 Bernd Schubert <bernd@bsbernd.com>, linux-kernel@vger.kernel.org,
 oe-lkp@lists.linux.dev, Horst Birthelmer <horst@birthelmer.com>,
 Horst Birthelmer <hbirthelmer@ddn.com>, Joanne Koong <joannelkoong@gmail.com>,
 linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> commit: 47f8dde97f35e32a1003d54e387273bcdf014ddf ("[PATCH] fuse: when copying a folio delay the mark dirty until the end")
> url: https://github.com/intel-lab-lkp/linux/commits/Horst-Birthelmer/fuse-when-copying-a-folio-delay-the-mark-dirty-until-the-end/20260316-234418
> patch link: https://lore.kernel.org/all/20260316-mark-dirty-per-folio-v1-1-8dc39c94b7ce@ddn.com/
> patch subject: [PATCH] fuse: when copying a folio delay the mark dirty until the end
> 
> in testcase: ltp
> version: 
> with following parameters:
> 
> 	disk: 1HDD
> 	fs: ext4
> 	test: fs-03

Looks like the test that has failed was fs_fill that runs several
threads that attempt to fill the filesystem (until they get ENOSCP) then
delete the files and try again. And apparently we managed to get EIO
when file has been closed() by one of the threads after a few minutes of
the runtime on NTFS mounted over FUSE.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
