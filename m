Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B5BD132A3
	for <ltp@archiver.kernel.org>; Mon,  4 Nov 2024 09:13:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6818B3D035D
	for <ltp@archiver.kernel.org>; Mon,  4 Nov 2024 10:13:34 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B85C3D035D
 for <ltp@lists.linux.it>; Mon,  4 Nov 2024 10:13:18 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 151061BD9430
 for <ltp@lists.linux.it>; Mon,  4 Nov 2024 10:13:16 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BA0C721E34;
 Mon,  4 Nov 2024 09:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730711594;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PaPm5zzDZwk2oh8v4fKaII3XYs5jrVM8eghKoBPAY+g=;
 b=Wbn4uc0emlHuJXGEE3mFDk0rao6cTkWPhi82ENOU5qAWvk4jA8jCH/BOZsDpAwBRY9dc9t
 v/biYEny7aWWj1sZH0b5liqAcLSZamRyeahBv2PriYV6akMI/2HiZQHlD/pn9AZxLY47Li
 Yx5fZU1FANNGXCYJ8LSfRxj+X8kQTmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730711594;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PaPm5zzDZwk2oh8v4fKaII3XYs5jrVM8eghKoBPAY+g=;
 b=GJPWFs1ox/FEane0DfECBGW1tPZHqUUFlhKxYeTnE79nog47RnNKjToNfxcPaF/m5sGikB
 mT3m9zbJEBOgh8CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730711594;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PaPm5zzDZwk2oh8v4fKaII3XYs5jrVM8eghKoBPAY+g=;
 b=Wbn4uc0emlHuJXGEE3mFDk0rao6cTkWPhi82ENOU5qAWvk4jA8jCH/BOZsDpAwBRY9dc9t
 v/biYEny7aWWj1sZH0b5liqAcLSZamRyeahBv2PriYV6akMI/2HiZQHlD/pn9AZxLY47Li
 Yx5fZU1FANNGXCYJ8LSfRxj+X8kQTmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730711594;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PaPm5zzDZwk2oh8v4fKaII3XYs5jrVM8eghKoBPAY+g=;
 b=GJPWFs1ox/FEane0DfECBGW1tPZHqUUFlhKxYeTnE79nog47RnNKjToNfxcPaF/m5sGikB
 mT3m9zbJEBOgh8CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9173F1373E;
 Mon,  4 Nov 2024 09:13:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qJCXIiqQKGePGAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 04 Nov 2024 09:13:14 +0000
Date: Mon, 4 Nov 2024 10:13:05 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20241104091305.GA1382167@pevik>
References: <5be090bd107e8cff5823fc35d9c0b9c8ee082ec6.1730466072.git.jstancek@redhat.com>
 <CAEemH2fp41P8f1_BG=3uTgCo3eG49Bq8_kntz0+oj=pDS5DxPA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fp41P8f1_BG=3uTgCo3eG49Bq8_kntz0+oj=pDS5DxPA@mail.gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/sched_getattr02: use a fixed size for
 EINVAL test
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

Hi Jan, Li,

> Jan Stancek <jstancek@redhat.com> wrote:


> > -       {&pid, &attr_copy, sizeof(struct sched_attr) - 1, 0, EINVAL},
> > +       {&pid, &attr_copy, 47, 0, EINVAL},

LGTM. But using "SCHED_ATTR_SIZE_VER0 - 1" would be more descriptive than magic
number 47. But for that we would need to add a fallaback definition to
include/lapi/sched.h. But sure, it's described in the commit message, thus
documented.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> "EINVAL size is invalid; that is, it is smaller than the initial version of
> the sched_attr structure (48 bytes) or larger than the system page size."

> Or we could add one more item for testing 'page_size + 1'.

+1 (having to tests).

Kind regards,
Petr

> Anyway, this workaround looks good.
> Reviewed-by: Li Wang <liwang@redhat.com>

+++ include/lapi/sched.h
@@ -46,6 +46,8 @@ static inline int sched_getattr(pid_t pid, struct sched_attr *attr,
 {
 	return syscall(__NR_sched_getattr, pid, attr, size, flags);
 }
+#else
+# define SCHED_ATTR_SIZE_VER0	48	/* sizeof first published struct */
 #endif
 
 #ifndef HAVE_CLONE3

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
