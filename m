Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A902BC5B56A
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 12:44:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 006FF3E6CAC
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 14:44:35 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1AF733D06FC
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 14:44:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6B4DB1A006B2
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 14:44:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5996282284;
 Wed, 12 Aug 2026 12:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786538653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KLjkRut6ET7xeHlp2ej4xZmMvnYUxJOGCCeI70Vfg5k=;
 b=RjpfJhYnesWqNgLQ7zpLmvnkPiaYC7XdU+zOjJKS1K2NfE9V6NFckOEKyMJVwh9adJXkd/
 2ekut07EVnWUxxIl1q4Y+HFPh6I8Nr2BjrgCHKm7ZTazowH0zrZ26KWoJMG+YJLV15qiiw
 2qLgomTBafyLj6UtR8pxbmVBERVFYUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786538653;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KLjkRut6ET7xeHlp2ej4xZmMvnYUxJOGCCeI70Vfg5k=;
 b=gYoDmZPh/7kvR00J0pgPC3xQalEnIHJ9WIIuA0tZq8iiBGsVo1r1fBLBwJ0PpzvmVMKIru
 /yO1hwnA+7MuhZBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786538649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KLjkRut6ET7xeHlp2ej4xZmMvnYUxJOGCCeI70Vfg5k=;
 b=YiQ7LwihXyP/6OP29smqgciRUj151cvlpWD/sIKMfNKJZggrRhWO15HPIp4ffYq6mQl32i
 NL3SS/0QUo+DrVKp85qigaS6vfsos5Ig015D5bGzq/CwcGouIgUAD+o5EybYErydDZYv6E
 dqr4H/CYHXVguguz3nLLd1KpXDAZJiY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786538649;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KLjkRut6ET7xeHlp2ej4xZmMvnYUxJOGCCeI70Vfg5k=;
 b=ujRfBS13Y0InxN6Cux6uz3/mDl/P5r7SHpUi64C7KFamXsvur4Mz30Wn3WuxGXfjvakIQ/
 PjbIc+MTXVyFvjDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49935779B1;
 Wed, 12 Aug 2026 12:44:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uhPaEJlqfGohOQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 12 Aug 2026 12:44:09 +0000
Date: Wed, 12 Aug 2026 14:44:07 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <anxql8XI7tWx_2gR@yuki.lan>
References: <20260810160048.1040517-1-pvorel@suse.cz>
 <20260810160048.1040517-4-pvorel@suse.cz>
 <anxTci_fnDEztVVT@yuki.lan> <20260812123007.GA1758016@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260812123007.GA1758016@pevik>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.cz:email,
 yuki.lan:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 3/7] lib: Add support for max_kver to struct
 tst_test and tst_fs
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
> > Uff, this is quite ugly. What exactly are we trying to do?
> 
> I hoped that was explained in the comment above the code:
>  .max_kver = "7.0" should run the test not only kernel <= 7.0,
> but also all stable kernels: 7.0.x.
> OTOH if there is something backported to stable kernel and one specifies:
> .max_kver = "7.0.5" it will be compared just to <= 7.0.5.
> 
> Sure, this can be avoided if .max_kver = "7.0" is not inclusive,
> i.e. < 7.0 (one would have to use .max_kver = "7.1"), which is less
> intuitive, because .min_kver is inclusive).

Or maybe instead of 7.0 the tests should require something as "7.0.*"
to make it clear that it will run on any 7.0.X patchlevel. And the
parser vould set the v3 to INT_MAX if it sees '*' as the value for v3.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
