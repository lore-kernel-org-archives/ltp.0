Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB980C282DE
	for <ltp@archiver.kernel.org>; Fri,  7 Mar 2025 23:46:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D81C23CA181
	for <ltp@archiver.kernel.org>; Sat,  8 Mar 2025 00:46:17 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DA2F3CA0DD
 for <ltp@lists.linux.it>; Sat,  8 Mar 2025 00:46:00 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7CDE510007BE
 for <ltp@lists.linux.it>; Sat,  8 Mar 2025 00:46:00 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5AC351F38C;
 Fri,  7 Mar 2025 23:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741391157;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AV2+qiyRU7vmMzfXxA3kgVPEE7+LrPSNpVZAat4CEt8=;
 b=tc4lIt8r+M2Bus8fMzQBlPC/gtmJQumaGOGAXkW7KcgbXV/2ajS5Nc9gQm9fmboLAi2IeJ
 vs2iLbhoby9Sdt4dNMEzMJAiG7LyZv/NgzyBTWflutrNZCMN7pXV0zb2IifZyxOyvYzYnM
 7ZwTwEoJmN40xrDF1cCAmBu8C//wSK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741391157;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AV2+qiyRU7vmMzfXxA3kgVPEE7+LrPSNpVZAat4CEt8=;
 b=RUkAhuiwxxlaXRc+Sc4QzNGyURv8YRugeMnR39hDjMsgv7XNKMcl8w+Pg17XxugbtvQOhA
 7osKjCSmS8FIWrAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741391156;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AV2+qiyRU7vmMzfXxA3kgVPEE7+LrPSNpVZAat4CEt8=;
 b=2aKS0QLoGXGPNQhwGjalIPxytQiNYt55ukfb2aGPbhvhSutmNMJn7Kb1DHYapfA2S84ZzQ
 6iMEq5qZsaYNXD66POZQOE5PtDjXEqlEcOp1EgR+oot2ql1Cn1ymu3C6eom6Wc/K7HfgKp
 mvU1KNIYMzvX1szZjWrpQMVN8DmuVdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741391156;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AV2+qiyRU7vmMzfXxA3kgVPEE7+LrPSNpVZAat4CEt8=;
 b=Yn+aw8sdBGD9joze591tYuJ/uhYxXfg6KLWld04LZzdlJbA6RKkNLE3ocB67Rm0lYfnfRH
 +EcllTpoDStt8zDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BA7A13A22;
 Fri,  7 Mar 2025 23:45:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +THdODOFy2fjSgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 07 Mar 2025 23:45:55 +0000
Date: Sat, 8 Mar 2025 00:45:54 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>,
 Stanislav Kholmanskikh <stanislav.kholmanskikh@bell-sw.com>,
 ltp@lists.linux.it
Message-ID: <20250307234554.GA347736@pevik>
References: <20231027174322.710674-1-pvorel@suse.cz>
 <CAEemH2fuA+YfFGNzSResMprEeT8+zhO1S_2Kscc14d2T828YYw@mail.gmail.com>
 <20231030072819.GA9167@pevik>
 <CAEemH2eUQxxQAh-Ln_hyzu_C_AL36fXsjbKZJqC3rcHsASgQgQ@mail.gmail.com>
 <20231030142055.GA21733@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231030142055.GA21733@pevik>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] compat_16.mk: Cleanup INTERMEDIATE object
 syntax
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

> > > > > -%_16: CPPFLAGS += -D$(DEF_16)=1

> > > Not related to this effort: shouldn't we convert all CPPFLAGS to CFLAGS?
> > > Or the
> > > LTP build system it just prepared to the crazy ideas about using C++? :)


> > No, I don't think so. I guess you memories it confused with CXXFLAGS :).

> > FYI:

> > CPPFLAGS (C PreProcessor Flags) are options for the C preprocessor,
> > which is the first stage of compilation where macro substitution occurs,
> > and conditional compilation directives are processed. These flags are often
> > used to specify additional include directories.
> >     e.g. CPPFLAGS="-I/some/include/path"

> > CFLAGS (C Compiler Flags) are options for the C compiler. These
> > flags are often used to specify various compiler settings, such as
> > optimization level, warnings level, and debugging information.
> >     e.g.  CFLAGS="-O2 -g -Wall"

> > CXXFLAGS (C++ Compiler Flags) are options for the C++ compiler.
> > It can be used to define options like optimization levels, debugging
> > information, warning levels, and more.
> >     e.g.  CXXFLAGS="-O2 -g -Wall"

> Ah, you're right. Thanks!

> > > > Seems we need to keep this one line, otherwise it can't transfer the
> > > > 'TST_USE_COMPAT16_SYSCALL=1' macro in the compilation.

> > > Ah, thanks!

> > > > The rest looks good to me.
> > > > Reviewed-by: Li Wang <liwang@redhat.com>

> > > BTW I'm going to push it with you as an author + with your Signed-off-by:
> > > tag
> > > (you're effectively the autor of the code) and with my RBT.


> > Sure, thanks for doing this for me.

> Yw.

Finally merged :).
(Obviously I forgot to merge back then although I set this in patchwork as accepted.)

Kind regards,
Petr

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
