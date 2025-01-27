Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C0DC0218C
	for <ltp@archiver.kernel.org>; Mon, 27 Jan 2025 09:39:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8119F3C2BFA
	for <ltp@archiver.kernel.org>; Mon, 27 Jan 2025 10:39:48 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 89AD53C2B98
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 10:39:33 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 02FBE1A0BEB9
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 10:39:32 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B00A5210ED;
 Mon, 27 Jan 2025 09:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737970770;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5XglpmasqFM0fzpywfeuMHlLVUb8/7rmS4DF5sdMjMc=;
 b=CwKgC5mgzhmncZR7e9KW/Ms4g4eI1KPJcuFlBYpEtLCBXhw9zqKpGxue6MlvmXHI4DK1Er
 6FpDVCdqK/+huSU1Eoqu/eNgK+m+HswYNfza13ge7XgEsZHPi8yeTgoOu+kZSW+US5ilTl
 C2f4c471MlEz8e9n73X8pz3wvc2i5+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737970770;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5XglpmasqFM0fzpywfeuMHlLVUb8/7rmS4DF5sdMjMc=;
 b=Pgo3q+KEpryOKy25vrNWoWIJ1Zn22ZHTfycrbaX5/3Aut1xgXirSRMaXOcXPjU/80zHALu
 LQXwqgJbnFi80/Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737970770;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5XglpmasqFM0fzpywfeuMHlLVUb8/7rmS4DF5sdMjMc=;
 b=CwKgC5mgzhmncZR7e9KW/Ms4g4eI1KPJcuFlBYpEtLCBXhw9zqKpGxue6MlvmXHI4DK1Er
 6FpDVCdqK/+huSU1Eoqu/eNgK+m+HswYNfza13ge7XgEsZHPi8yeTgoOu+kZSW+US5ilTl
 C2f4c471MlEz8e9n73X8pz3wvc2i5+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737970770;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5XglpmasqFM0fzpywfeuMHlLVUb8/7rmS4DF5sdMjMc=;
 b=Pgo3q+KEpryOKy25vrNWoWIJ1Zn22ZHTfycrbaX5/3Aut1xgXirSRMaXOcXPjU/80zHALu
 LQXwqgJbnFi80/Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B877137C0;
 Mon, 27 Jan 2025 09:39:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id C0EOIVJUl2fJFAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 27 Jan 2025 09:39:30 +0000
Date: Mon, 27 Jan 2025 10:39:29 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Alessandro Carminati <acarmina@redhat.com>
Message-ID: <20250127093929.GA268709@pevik>
References: <20250127083227.77560-1-acarmina@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250127083227.77560-1-acarmina@redhat.com>
X-Spamd-Result: default: False [-6.00 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; SUSPICIOUS_RECIPS(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[suse.cz,gmail.com,redhat.com,lists.linux.it];
 REPLYTO_EQ_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] cfs-scheduler/starvation.c: Skip test on
 realtime kernels
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
Cc: ltp@lists.linux.it, Alessandro Carminati <alessandro.carminati@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> This commit introduces a check in the starvation test case to detect and
> skip execution on realtime kernels. The test is designed for use with the
> Completely Fair Scheduler and produces meaningless results when run on
> realtime kernels.

> By skipping the test on realtime kernels, we avoid confusion caused by
> misleading results.

Thanks a lot for fixing -1 in v3. I was thinking to merge v2 and fix -1
manually, but I'm really not sure if the test is meaningless for realtime.
Was the test really written for CFS? It would be nice to get ack from any
realtime developer.

BTW test is working well on x86_64 SLES realtime kernel on VM, i.e. both you
want to skip (RT) or warn about unreliable results (VM). That of course
does not mean it's relevant for RT kernel.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
