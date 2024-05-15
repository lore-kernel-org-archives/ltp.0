Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5761C25B78
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 09:52:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D4173CF771
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 11:52:01 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5630C3CE97C
 for <ltp@lists.linux.it>; Wed, 15 May 2024 11:51:45 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4E65C1406109
 for <ltp@lists.linux.it>; Wed, 15 May 2024 11:51:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 49884204B1;
 Wed, 15 May 2024 09:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715766703;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bNfmteTKL2/fSUiQfhXmZkdQfkBvu1PouqDnCkhi03Q=;
 b=MDmUJyofGsdMT6b3d7lXi/I45OhOj9hHInfajcraVWivJmCLHzRyjS3DgyoycGOitbb2ix
 kFRTx/8EyHyZE+uJANDuN74HwTg4mJ++xROZ1CHzDw7STa5SBREo6tR/Nrcw4pIVayTpTq
 i2VDJGmMAS8L06ueRQVpgkyLIC+wYZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715766703;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bNfmteTKL2/fSUiQfhXmZkdQfkBvu1PouqDnCkhi03Q=;
 b=ADc/moZjyqwDKUQkbyltos8UMmBlT0jo6xCL/pqVNPapU/RNP+OaDnabEZYt6krgKI/ntV
 21SZeMx1U2KzV+Dw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MDmUJyof;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="ADc/moZj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715766703;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bNfmteTKL2/fSUiQfhXmZkdQfkBvu1PouqDnCkhi03Q=;
 b=MDmUJyofGsdMT6b3d7lXi/I45OhOj9hHInfajcraVWivJmCLHzRyjS3DgyoycGOitbb2ix
 kFRTx/8EyHyZE+uJANDuN74HwTg4mJ++xROZ1CHzDw7STa5SBREo6tR/Nrcw4pIVayTpTq
 i2VDJGmMAS8L06ueRQVpgkyLIC+wYZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715766703;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bNfmteTKL2/fSUiQfhXmZkdQfkBvu1PouqDnCkhi03Q=;
 b=ADc/moZjyqwDKUQkbyltos8UMmBlT0jo6xCL/pqVNPapU/RNP+OaDnabEZYt6krgKI/ntV
 21SZeMx1U2KzV+Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 180881372E;
 Wed, 15 May 2024 09:51:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id G020A6+FRGYkIQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 15 May 2024 09:51:43 +0000
Date: Wed, 15 May 2024 11:51:37 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Detlef Riekenberg <wine.dev@web.de>
Message-ID: <20240515095137.GA208965@pevik>
References: <trinity-74891c6d-f969-45be-ab73-89e340d7f6d3-1715633259373@3c-app-webde-bap30>
 <20240514185930.GA178649@pevik>
 <trinity-41dc0eb8-c7cf-4f51-9e88-2b2daa5bd204-1715766325023@msvc-mesg-web002>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <trinity-41dc0eb8-c7cf-4f51-9e88-2b2daa5bd204-1715766325023@msvc-mesg-web002>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 49884204B1
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[web.de];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_TO(0.00)[web.de]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] open_posix_testsuite: Replace old -W commandline argument
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
Cc: Joerg Vehlow <joerg.vehlow@aox.de>, LTP <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

>    Thanks all for your help and patience with a LTP newbie.

yw :).

>    Now, OpenWatcom (with my patched owcc frontend) passes >1100 tests
>    and more work on the OpenWatcom POSIX runtime can be done

Always interested to see who is using LTP.

>    (a big OW issue: "aio.h" and the related implementation is missing)

glibc and musl IMHO support aio.h unconditionally.  If you're using uclibc or
uclibc-ng, you need UCLIBC_HAS_REALTIME [1]. But below you mentioned glibc.

Kind regards,
Petr

[1] https://cgit.uclibc-ng.org/cgi/cgit/uclibc-ng.git/tree/extra/Configs/Config.in#n1166

>    ---
>    Testing with another Compiler on my system:
>    Using the Open Posix Testsuite with TinyC and the system installed glibc
>    gives one failed test.
>    This is the same result as using gcc.

>    -----
>    When someone has a working setup for "git-send-email" with "[1]web.de",
>    please let me know.
>    (I tried git-imap-send as fallback, but that only creates the draft mail.
>    A web login into the [2]web.de mail interface
>    with editing the draft mail and manually sending the patch
>    is needed afterwards)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
