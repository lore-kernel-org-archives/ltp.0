Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E14C48BC4
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 08:32:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F8A53CF136
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 09:32:32 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 859653CCBD1
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 09:32:16 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9011D600822
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 09:32:15 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3B3B12239D;
 Fri, 23 Feb 2024 08:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708677134;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IVpu/wPzkxLvDiMzBzZBYPCrwd+LIA79GePTigxANY0=;
 b=eaFEJgbm1KSdyt70Zc8f1iEQp0LL5RM31UOqJxnbCtHUgV4weiitG5WF+UPyA28/Nh1rSO
 Jp5QJrReu0gKCH9OsAHTymIif1isPqrEAAjTUjREH1FW9I0NuQT8016znWLU8xTF8/g5st
 omzFWMbszDeyW0Y0+jQYS4xjHYJujjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708677134;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IVpu/wPzkxLvDiMzBzZBYPCrwd+LIA79GePTigxANY0=;
 b=S8a22pYEPMkvB4j0uTljxxe+Hp6NGMfyKq3i+mVvO7B8dSs6ETFC+N9XuP37UwAD9Eyoj6
 48rJDBp2xBsxsgDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708677134;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IVpu/wPzkxLvDiMzBzZBYPCrwd+LIA79GePTigxANY0=;
 b=eaFEJgbm1KSdyt70Zc8f1iEQp0LL5RM31UOqJxnbCtHUgV4weiitG5WF+UPyA28/Nh1rSO
 Jp5QJrReu0gKCH9OsAHTymIif1isPqrEAAjTUjREH1FW9I0NuQT8016znWLU8xTF8/g5st
 omzFWMbszDeyW0Y0+jQYS4xjHYJujjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708677134;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IVpu/wPzkxLvDiMzBzZBYPCrwd+LIA79GePTigxANY0=;
 b=S8a22pYEPMkvB4j0uTljxxe+Hp6NGMfyKq3i+mVvO7B8dSs6ETFC+N9XuP37UwAD9Eyoj6
 48rJDBp2xBsxsgDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1713513419;
 Fri, 23 Feb 2024 08:32:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id YPGjBA5Y2GV7MwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 23 Feb 2024 08:32:14 +0000
Date: Fri, 23 Feb 2024 09:32:12 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240223083212.GA1423688@pevik>
References: <20240222044119.28500-1-wegao@suse.com> <ZdcIT1WiEfV7MCQ-@rei>
 <ZddOKzhl1semChgB@wegao.166.144.58>
 <CAEemH2dtarpDtPuzHgG6eeoB3Bhbfa1u9fjsb6dBFX-rPg-3dw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dtarpDtPuzHgG6eeoB3Bhbfa1u9fjsb6dBFX-rPg-3dw@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.50 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_THREE(0.00)[3];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.987];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[39.85%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] swapoff01.c: Adjust blocks size base on
 pagesize
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

Hi all,

> Hi Wei, Cyril,


> > > I do not think that this is a right solution though. Is there any reason
> > > why we pass number of blocks to the make_swapfile instead of megabytes?

> > @Li Wang, could you give some clue for above question(for why pass number
> > of blocks instead of megabytes)?


> I just keep the function interface like the original
> (it wasn't designed by me:), but I guess the only
> advantage is to test 1 block for different FS types.

We use this function with 1 block, 10 blocks and 65536 blocks

How about to have special function for 1 block and then other function which
accepts MB? (e.g. 1 MB and 256 MB)?

But could we first merge Yang Xu patchset so that he does not have to rebase it
for ever?

https://patchwork.ozlabs.org/project/ltp/list/?series=395713&state=*

Also it'd be nice to have, but this can definitely wait after other things are
solved.

-int make_swapfile(const char *swapfile, int blocks, int safe)
+int _make_swapfile(const char *swapfile, int blocks, int safe)

+#define MAKE_SWAPFILE(const char *swapfile, int blocks, int safe) \
+	_make_swapfile(swapfile, blocks, 0)

+#define SAFE_SWAPFILE(const char *swapfile, int blocks, int safe) \
+	_make_swapfile(swapfile, blocks, 1)

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
