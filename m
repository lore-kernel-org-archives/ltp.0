Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F17C282D0
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 13:08:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CAB523C9FE0
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 14:08:55 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 08D503C7B04
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 14:08:39 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 732092206C4
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 14:08:39 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A0F1621157;
 Tue,  4 Mar 2025 13:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741093718;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=siT0VXwyGlHyMEMeSKVbM7pzBuYEXMJ5L3iYv5zAr2A=;
 b=IMeh9A/mNKoW7gJmWzsakjqRpCmYjfMyaeqMP5+aNp7eOoYyBYZK8BGXslnWz5/Yx1YwLy
 OBQo+5ePonU45lzHnq88uiulLst0mr9EKZDAapUAxkKcm79eBWdxwHgobS0m4t2ompvuCb
 ZGPqKLLTERi+8XMetnZycQvaV0VHvVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741093718;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=siT0VXwyGlHyMEMeSKVbM7pzBuYEXMJ5L3iYv5zAr2A=;
 b=jHKHyYGOZjsYl+QjjMm08tt6jDLWgADw5DM0aViaTvwvpla1ZxSiQFHPIQYTAjpjbcinqS
 4XufxHscSd/WfXDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741093718;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=siT0VXwyGlHyMEMeSKVbM7pzBuYEXMJ5L3iYv5zAr2A=;
 b=IMeh9A/mNKoW7gJmWzsakjqRpCmYjfMyaeqMP5+aNp7eOoYyBYZK8BGXslnWz5/Yx1YwLy
 OBQo+5ePonU45lzHnq88uiulLst0mr9EKZDAapUAxkKcm79eBWdxwHgobS0m4t2ompvuCb
 ZGPqKLLTERi+8XMetnZycQvaV0VHvVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741093718;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=siT0VXwyGlHyMEMeSKVbM7pzBuYEXMJ5L3iYv5zAr2A=;
 b=jHKHyYGOZjsYl+QjjMm08tt6jDLWgADw5DM0aViaTvwvpla1ZxSiQFHPIQYTAjpjbcinqS
 4XufxHscSd/WfXDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A2C413967;
 Tue,  4 Mar 2025 13:08:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 28QHHVb7xmcNGAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 04 Mar 2025 13:08:38 +0000
Date: Tue, 4 Mar 2025 14:08:33 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250304130833.GB81126@pevik>
References: <20250228172439.3276777-1-pvorel@suse.cz>
 <20250228172439.3276777-2-pvorel@suse.cz>
 <CAEemH2eBJ5AeTKgbDAbCpZKLA7DZMWhpEcrSUJAdJuNU5yULOA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eBJ5AeTKgbDAbCpZKLA7DZMWhpEcrSUJAdJuNU5yULOA@mail.gmail.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/5] shell lib: Add support for test cleanup
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

Hi Li,

...
> > +++ b/testcases/lib/run_tests.sh
> > @@ -9,6 +9,7 @@ shell_loader_filesystems.sh
> >  shell_loader_kconfigs.sh
> >  shell_loader_supported_archs.sh
> >  shell_loader_tcnt.sh
> > +shell_loader_cleanup.sh
> >  shell_test01
> >  shell_test02
> >  shell_test03
> > @@ -21,7 +22,8 @@ TESTS_TBROK="
> >  shell_loader_invalid_block.sh
> >  shell_loader_invalid_metadata.sh
> >  shell_loader_no_metadata.sh
> > -shell_loader_wrong_metadata.sh"
> > +shell_loader_wrong_metadata.sh

> It seems the shell_loader_wrong_metadata.sh is a duplicate of
> shell_loader_invalid_metadata. Maybe we can remove one of them.

Good catch. But I think there are testing a different thing:

shell_loader_wrong_metadata.sh IMHO has too high int value
("Wrong 'needs_tmpdir' type expected boolean" error):

"needs_tmpdir": 42,

# PATH="$PWD:$PWD/tests:$PATH" shell_loader_wrong_metadata.sh
Parse error at line 002

001: {
002:  "needs_tmpdir": 42,
                        ^
Wrong 'needs_tmpdir' type expected boolean
tst_run_shell.c:508: TBROK: Invalid metadata

shell_loader_invalid_metadata.sh IMHO has invalid JSON
("Expected ID string" error):

{"needs_tmpdir": 42,

# PATH="$PWD:$PWD/tests:$PATH" shell_loader_invalid_metadata.sh
Parse error at line 002

001: {
002:  {"needs_tmpdir": 42,
      ^
Expected ID string
tst_run_shell.c:508: TBROK: Invalid metadata

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
