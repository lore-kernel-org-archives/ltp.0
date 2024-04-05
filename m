Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA79C67861
	for <ltp@archiver.kernel.org>; Fri,  5 Apr 2024 11:24:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D1E13CEF28
	for <ltp@archiver.kernel.org>; Fri,  5 Apr 2024 13:24:34 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 299A03CE4DF
 for <ltp@lists.linux.it>; Fri,  5 Apr 2024 13:24:20 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9A9977A9222
 for <ltp@lists.linux.it>; Fri,  5 Apr 2024 13:24:19 +0200 (CEST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D0F4721A3A;
 Fri,  5 Apr 2024 11:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712316258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2k+lRp1URGqf1yPchi0I8vs5jACrNPmaBSu9iXGZ60w=;
 b=DTC9llGAiNfcCewQ5cefq5jl2WNGt0Uo5p1Z93VwXMIaVMJ4ToPMKIqvaykUFP2zs8sG0a
 Me+706Gnw+9JW0W75eSl3jBQUWrWczOi58CXjTSLAhDdHZN1TOLD7EF1JgFdwFBt1GE6bs
 FWoloS+W4GcPcKyTwnwcrKOg50fqS8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712316258;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2k+lRp1URGqf1yPchi0I8vs5jACrNPmaBSu9iXGZ60w=;
 b=yy3TSLXkI5BEmue/fMSWz2ssVXkybfHRIZO+x43YOktmHEt2YT+5Dn+l8gnDEPVuLoM740
 PSlW078z5rNhfJDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712316257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2k+lRp1URGqf1yPchi0I8vs5jACrNPmaBSu9iXGZ60w=;
 b=HFKd0DXgD9yqByP0PzH0aKt03xSiY6gFVaSNudgTkLoQTxt/+lmPEXz+Wi6DkVSw89Qgha
 FIBq++Zuz3F1CFOwjSalX91Zei/+p+9wq12QvXEpJwxsmVTw2HtbqXaF09lHPF7PyN5spo
 1rofgcD73aLQog1Lqkyk1faM6QrNAfI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712316257;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2k+lRp1URGqf1yPchi0I8vs5jACrNPmaBSu9iXGZ60w=;
 b=oAq4x3LzGuIUrNaJgOHAR135IHrj2lG4HGnVErybE8VvSSkFIAM/98W9tNKuyJJx5fwOm6
 Ot+G0K5lda+zCpBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B65BF139F1;
 Fri,  5 Apr 2024 11:24:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id sBFhK2HfD2ZHAQAAn2gu4w
 (envelope-from <chrubis@suse.cz>); Fri, 05 Apr 2024 11:24:17 +0000
Date: Fri, 5 Apr 2024 13:23:24 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Zg_fLIQ9Fsv94H_Q@yuki>
References: <20240327034923.30987-1-wegao@suse.com>
 <20240403032859.3826-1-wegao@suse.com>
 <20240403032859.3826-2-wegao@suse.com> <Zg6wV8Xb004kAqkK@yuki>
 <20240404160151.GE503552@pevik> <Zg-8HwWdC5eOZseY@yuki>
 <20240405102828.GA622461@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240405102828.GA622461@pevik>
X-Spamd-Result: default: False [-7.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,
 imap2.dmz-prg2.suse.org:rdns]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/3] lib: TST_EXP_{FAIL,PASS}_PTR_{NULL,VOID}
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
Also is anybody going to work on the PASS variant? Looks like the huge*
tests would need that...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
