Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13C7C4828D
	for <ltp@archiver.kernel.org>; Mon,  5 Feb 2024 17:21:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 966763CF61C
	for <ltp@archiver.kernel.org>; Mon,  5 Feb 2024 18:21:20 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A207B3C044A
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 18:21:06 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AFB841000D39
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 18:21:05 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C7C5822154;
 Mon,  5 Feb 2024 17:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707153662;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KMJRHpQhJZYdncZEKk7qkpvWJNofb+Ut6qQfqFDesm4=;
 b=k79fsa9sJZFS/hi14B6TXGNkssSuddet1NxJAUQHXxrPQIxMugXvglZ6xanh3p/jOHjgiI
 QWtVoS5UF5DdFIcMTiTbhKXgZgkN/+FdkjrZ37M5g+wKmlQYMnsJAJOtL813IADxpggtzM
 Qxa5isfB4d/pkKjdlvUV/nZzi51IcaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707153662;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KMJRHpQhJZYdncZEKk7qkpvWJNofb+Ut6qQfqFDesm4=;
 b=uAaC/mRHikpSxqopKrPK5ghIg3BtkjKUG6BcGeVSEfVL/yuzF0xngw2EKL0aUBSdWxefOY
 ltHvSVo81n/CF5Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707153662;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KMJRHpQhJZYdncZEKk7qkpvWJNofb+Ut6qQfqFDesm4=;
 b=k79fsa9sJZFS/hi14B6TXGNkssSuddet1NxJAUQHXxrPQIxMugXvglZ6xanh3p/jOHjgiI
 QWtVoS5UF5DdFIcMTiTbhKXgZgkN/+FdkjrZ37M5g+wKmlQYMnsJAJOtL813IADxpggtzM
 Qxa5isfB4d/pkKjdlvUV/nZzi51IcaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707153662;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KMJRHpQhJZYdncZEKk7qkpvWJNofb+Ut6qQfqFDesm4=;
 b=uAaC/mRHikpSxqopKrPK5ghIg3BtkjKUG6BcGeVSEfVL/yuzF0xngw2EKL0aUBSdWxefOY
 ltHvSVo81n/CF5Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 746C3132DD;
 Mon,  5 Feb 2024 17:21:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OK4oF/4YwWWoHgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 05 Feb 2024 17:21:02 +0000
Date: Mon, 5 Feb 2024 18:21:00 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20240205172100.GA218023@pevik>
References: <534e6d05-fc91-43e4-b384-b7a43125961d@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <534e6d05-fc91-43e4-b384-b7a43125961d@suse.com>
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=k79fsa9s;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="uAaC/mRH"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.71 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; TO_DN_EQ_ADDR_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.cz:+];
 RCPT_COUNT_TWO(0.00)[2]; MX_GOOD(-0.01)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: C7C5822154
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] msgstress SysV IPC testing suite
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

> Hi all,

> I was taking a look msgstress testing suite that is supposed to stress the
> kernel SysV IPC.
> It's a well known testing suite that used to randomly stuck or fail, due to
> the poorly written code.

> I'm about to refactor its code, but I noticed that all 4 tests inside it
> (msgstress01-04) are basically implementing the same concept, if not the
> same code that looks copy-pasted.

> We basically have 2 or more processes reading/writing messages into the SysV
> IPC at the same time.
> If all messages are correctly sent and received, the test passes. The only
> difference is if these processes are spawned inside children or not.

> So I have a quite obvious observation: our main goal is to stress the SysV
> IPC, so we can trigger a bug and it doesn't matter if this is done inside
> children or not.

I hope so. It also looks to me, that all 4 tests do very similar thing.

Also test docs claims that msgstress03.c is msgstress01.c but reads
/proc/sys/kernel/msgmni, similarly msgstress04.c is msgstress02.c but reads
/proc/sys/kernel/msgmni. But I don't see that msgstress0[34].c would read
/proc/sys/kernel/msgmni.  msgget03.c (already rewritten to new API) is the only
test which reads it via .save_restore.

I suppose get_used_msgqueues() (in libs/libltpipc/libipc.c) can still be kept in
the old API and converted after all files are converted. But I would consider
using /proc/sysvipc/msg instead of "ipcs -q".

Thanks for looking this!

Kind regards,
Petr

> I'm planning to remove all those tests and to write a new one following the
> main concept, but without the actual redundancy. What do you think?

> Regards,
> Andrea Cervesato

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
