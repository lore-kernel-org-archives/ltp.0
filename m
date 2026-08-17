Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88C5C5DF70
	for <ltp@archiver.kernel.org>; Mon, 17 Aug 2026 08:54:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 06A6A3CB738
	for <ltp@archiver.kernel.org>; Mon, 17 Aug 2026 10:54:27 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF3573C5936
 for <ltp@lists.linux.it>; Mon, 17 Aug 2026 10:54:11 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7303F1400138
 for <ltp@lists.linux.it>; Mon, 17 Aug 2026 10:54:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 556D13DF4;
 Mon, 17 Aug 2026 08:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786956846;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=28IYwESFT9jaN0qKj4aUDlMTJr4g7zY2mbO0o0QtUII=;
 b=LugnnwUnflBNCCUWTxNxywzV7A6d0lgMcvmEAXoSNOvcMbq7jQi0A6c0Zk7X8UdE+YvOnG
 98F3BTk8iFwCUmzVdOQglwaNV3kwxtlzWz51y4Wd16W652+Dxh/hOh7P9jcbjUjBcV4QPP
 eisM1mMR2b+FbB4LOIDeyP3oFFr4hsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786956846;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=28IYwESFT9jaN0qKj4aUDlMTJr4g7zY2mbO0o0QtUII=;
 b=zBN4bNAzt63KO2RN7ShbcyII+5TMt/Tp5yY/C5Z57n8yqqSS8ak8IFK7guU631MmXWYrip
 xvM551oZcbRKJcBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786956842;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=28IYwESFT9jaN0qKj4aUDlMTJr4g7zY2mbO0o0QtUII=;
 b=zrshelwlQAgk1UeaY82QYAOUbFFCIpubggmQDh+2a9YXityTPpDOWaLBHmOnWSx709ghM7
 fGw8L1DUC1KmJo9qKAytBChWacPH2RzOfHaEuopBXCfjJ6TNLi7hGHKP1WBXcTIQ0/Stvj
 de/pI8Mrb+WHUpQv+fqW7RUe3ljhE3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786956842;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=28IYwESFT9jaN0qKj4aUDlMTJr4g7zY2mbO0o0QtUII=;
 b=sqsWwiPUIymqdBBvK4HloaVRUwl9gBvsPYQWtAyVRSah7clcjrh2DM3W30owJqZqaxljvP
 axPbdE4juEa2PgAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 120CC7939E;
 Mon, 17 Aug 2026 08:54:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fAF9AirMgmrVGwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 17 Aug 2026 08:54:02 +0000
Date: Mon, 17 Aug 2026 10:53:52 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wake Liu <wakel@google.com>
Message-ID: <20260817085352.GC302315@pevik>
References: <20260727121130.1294997-1-wakel@google.com>
 <20260814122123.633912-1-wakel@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260814122123.633912-1-wakel@google.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.993]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] listmount04: Detect EBADF behavior dynamically
 at runtime
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

Hi Wake,

> Hi Petr,

> Gentle ping on this v2 patch.

FYI it was merged in the end of July by Andrea.
https://github.com/linux-test-project/ltp/commit/b4b82b28dcc63827e59f4cbc45f718f5913940ce

Kind regards,
Petr

> All comments from v1 have been addressed (renamed macros back to
> BEFORE_6_18/AFTER_6_18 and removed the unnecessary ENOSYS check).

> Could you please take a look when you have time?

> Thanks,
> Wake

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
