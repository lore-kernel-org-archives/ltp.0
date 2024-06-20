Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C9AC27C79
	for <ltp@archiver.kernel.org>; Thu, 20 Jun 2024 09:42:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 225353D0E12
	for <ltp@archiver.kernel.org>; Thu, 20 Jun 2024 11:42:10 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 96EF73D0DFB
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 11:41:54 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=jack@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CCD5E600C60
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 11:41:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1CE8321966;
 Thu, 20 Jun 2024 09:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718876512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=by6xbOtQhJMEqLZEgKtPj8oDDcf6k9Hues9GV1+zcyQ=;
 b=SAzaK/xoZwIuWUNy6d194BAU2VGW14tMKTKl2dDCq0fJojXr6vXLm/lkP/Phg0bY3HnTWS
 TpwGm0lRujT6/LM84g3Dr8niw21ljxNE3ofz8/e1VEeiXPy/xz7KQtsnj77XtGCm2lSIRM
 mi5PY1m+F6ZOg5ntsQLuGEMo/L28uCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718876512;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=by6xbOtQhJMEqLZEgKtPj8oDDcf6k9Hues9GV1+zcyQ=;
 b=BjacE3nt64e/Idvu0fGlwzUA/YgYLZoi/XC3w2bm7Yah/tBMLlGjXj/KqPs3ohXeanVbtL
 vOk/sPoq8k7VN7CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718876512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=by6xbOtQhJMEqLZEgKtPj8oDDcf6k9Hues9GV1+zcyQ=;
 b=SAzaK/xoZwIuWUNy6d194BAU2VGW14tMKTKl2dDCq0fJojXr6vXLm/lkP/Phg0bY3HnTWS
 TpwGm0lRujT6/LM84g3Dr8niw21ljxNE3ofz8/e1VEeiXPy/xz7KQtsnj77XtGCm2lSIRM
 mi5PY1m+F6ZOg5ntsQLuGEMo/L28uCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718876512;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=by6xbOtQhJMEqLZEgKtPj8oDDcf6k9Hues9GV1+zcyQ=;
 b=BjacE3nt64e/Idvu0fGlwzUA/YgYLZoi/XC3w2bm7Yah/tBMLlGjXj/KqPs3ohXeanVbtL
 vOk/sPoq8k7VN7CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BCFA13AC1;
 Thu, 20 Jun 2024 09:41:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UTPbAmD5c2bYewAAD6G6ig
 (envelope-from <jack@suse.cz>); Thu, 20 Jun 2024 09:41:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id A683FA0881; Thu, 20 Jun 2024 11:41:51 +0200 (CEST)
Date: Thu, 20 Jun 2024 11:41:51 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Message-ID: <20240620094151.cuamehtaioenokyv@quack3>
References: <171817619547.14261.975798725161704336@noble.neil.brown.name>
 <20240615-fahrrad-bauordnung-a349bacd8c82@brauner>
 <20240617093745.nhnc7e7efdldnjzl@quack3>
 <20240618-wahr-drossel-19297ad2a361@brauner>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240618-wahr-drossel-19297ad2a361@brauner>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[10];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_THREE(0.00)[3];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[suse.cz,suse.de,gmail.com,arm.com,lists.linux.it,vger.kernel.org,zeniv.linux.org.uk];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_LAST(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] VFS: generate FS_CREATE before FS_OPEN when
 ->atomic_open used.
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
Cc: linux-nfs@vger.kernel.org, Jan Kara <jack@suse.cz>,
 NeilBrown <neilb@suse.de>, LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org, ltp@lists.linux.it,
 Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue 18-06-24 16:19:37, Christian Brauner wrote:
> > AFAICT this will have a side-effect that now fsnotify_open() will be
> > generated even for O_PATH open. It is true that fsnotify_close() is getting
> 
> Thanks! That change seemed sensible because a close() event is
> generated.
> 
> But I don't agree that generating events for O_PATH fds doesn't make
> sense on principle. But I don't care if you drop events for O_PATH now.

Well, I can be convinced otherwise but I was not able to find a compeling
usecase for it. fanotify(8) users primarily care about file data
modification / access events and secondarily also about directory content
changes (because they change how data can be accessed). And creation of
O_PATH fds does not seem to fall into either of these categories...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
