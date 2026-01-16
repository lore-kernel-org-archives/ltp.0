Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A03FD4A605
	for <ltp@archiver.kernel.org>; Fri, 16 Jan 2026 07:20:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F342A3CA75B
	for <ltp@archiver.kernel.org>; Fri, 16 Jan 2026 08:20:39 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A2B373C2A26
 for <ltp@lists.linux.it>; Fri, 16 Jan 2026 08:20:23 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C0112600CFC
 for <ltp@lists.linux.it>; Fri, 16 Jan 2026 08:20:22 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A066E5BCC6;
 Fri, 16 Jan 2026 07:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768548021;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BGEKGsJ+xIC4w1OwwIesVYSNUkLHaPKc0sPf9hLIHu0=;
 b=ThYW352/sAj9Wxawc6vI+sMPKQ0SffkKHn7bYH2kW/El15zNbRtPjJdLl9xSVDpsrGJv1o
 gI8mbIjgOUOnalQFAcTF38bVPkOwGY+urfvUgEmbe+xzBzJ+/hl3onyluZJOsXX76RBWtm
 MA0OKx17vABbqVuI+yMKUdm/lHSoTwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768548021;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BGEKGsJ+xIC4w1OwwIesVYSNUkLHaPKc0sPf9hLIHu0=;
 b=I0nuwR4MjmU/u386ExVu8O/slQGoegSvWoMhNLmBwZken11dPmmvWxWP5ao/d/8JEV960t
 kZu82MIWopS6OWBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="ThYW352/";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=I0nuwR4M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768548021;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BGEKGsJ+xIC4w1OwwIesVYSNUkLHaPKc0sPf9hLIHu0=;
 b=ThYW352/sAj9Wxawc6vI+sMPKQ0SffkKHn7bYH2kW/El15zNbRtPjJdLl9xSVDpsrGJv1o
 gI8mbIjgOUOnalQFAcTF38bVPkOwGY+urfvUgEmbe+xzBzJ+/hl3onyluZJOsXX76RBWtm
 MA0OKx17vABbqVuI+yMKUdm/lHSoTwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768548021;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BGEKGsJ+xIC4w1OwwIesVYSNUkLHaPKc0sPf9hLIHu0=;
 b=I0nuwR4MjmU/u386ExVu8O/slQGoegSvWoMhNLmBwZken11dPmmvWxWP5ao/d/8JEV960t
 kZu82MIWopS6OWBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D9D23EA63;
 Fri, 16 Jan 2026 07:20:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RXLhGLXmaWnVQQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 16 Jan 2026 07:20:21 +0000
Date: Fri, 16 Jan 2026 08:20:20 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260116072020.GB556902@pevik>
References: <aWjZX0fsrTJMqq49@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aWjZX0fsrTJMqq49@yuki.lan>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A066E5BCC6
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preprations
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
Cc: Liu Jian <liujian56@huawei.com>, ltp@lists.linux.it,
 Ricardo Branco <rbranco@suse.de>, Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril, all,

> Hi!
> It's about we start to prepare for the January release. We have roughly
> a week for getting in all patches that should go in. So if there is
> anything that should be reviewed please point it out ASAP.

> As for me I'm going to (hopefully) finalize the ground rules patch and
> send another version today.

I plan to merge today Martin's fix for lio_listio/2-1.c:
https://lore.kernel.org/ltp/20260115171847.28091-1-mdoucha@suse.cz/

I hope we could merge userfaultfd rewrite:
https://github.com/linux-test-project/ltp/pull/1280

Hopefully v7 "new cmd support option for needs_cmds" is ready now:
https://lore.kernel.org/ltp/20260109061716.20258-1-wegao@suse.com/

ioctl_pidfd02-06: Add CONFIG_USER_NS and CONFIG_PID_NS to needs_kconfigs
https://patchwork.ozlabs.org/project/ltp/patch/20251209211629.95436-1-terry.tritton@linaro.org/
(I somehow agree with Jan that sometimes just check /proc or /sys path is better
than imply kconfig, but majority agreed to use .needs_kconfigs).

Maybe fix clone10.c on 32 bit, if we find a root cause. This is just an
investigation:
https://lore.kernel.org/ltp/aWmqFAzdtsR0t5aJ@autotest-wegao.qe.prg2.suse.org/

We got no further response for some RPC fix, I'm not sure if it's ready:
https://lore.kernel.org/ltp/20260112015047.2184003-1-liujian56@huawei.com/

If we have time:
tst_filesystems01.c: Add test for .filesystems
https://patchwork.ozlabs.org/project/ltp/list/?series=481881&state=*

checkpatch.pl update
https://patchwork.ozlabs.org/project/ltp/list/?series=487179&state=*

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
