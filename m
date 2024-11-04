Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA9BD132C0
	for <ltp@archiver.kernel.org>; Mon,  4 Nov 2024 13:20:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C3683D0AD9
	for <ltp@archiver.kernel.org>; Mon,  4 Nov 2024 14:20:09 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE3A73D0718
 for <ltp@lists.linux.it>; Mon,  4 Nov 2024 14:19:53 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 217D560D471
 for <ltp@lists.linux.it>; Mon,  4 Nov 2024 14:19:51 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 960F91FF32;
 Mon,  4 Nov 2024 13:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730726390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FccnCAPsUkkPnEpH/a+bhn38p7NqzYW2XMWb4GREFVc=;
 b=wh0pSwQU6wPr/mUzNFWEyzNx9fEpoay2lvMdbbk3PGQKabeidsMVPgthGIC5V5B3pXnvfe
 jXH0I8UWg+07EvDAoNQvRH6KwyQcxjsaW1RwsO3fZ+XYsNig8Hw0qfj/KQkA/oOL6V+MRh
 aBvW8W2m3up8EI+5GciNDvZA41Yq7Tg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730726390;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FccnCAPsUkkPnEpH/a+bhn38p7NqzYW2XMWb4GREFVc=;
 b=FZwkG96oyFtCKyAAn1eVSAc/U5kvWyuPKR4tq+w/QsES0LDFEHVnNWXIWBUvl6VH2+QHmc
 okkXgD2y7CmcmPDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730726390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FccnCAPsUkkPnEpH/a+bhn38p7NqzYW2XMWb4GREFVc=;
 b=wh0pSwQU6wPr/mUzNFWEyzNx9fEpoay2lvMdbbk3PGQKabeidsMVPgthGIC5V5B3pXnvfe
 jXH0I8UWg+07EvDAoNQvRH6KwyQcxjsaW1RwsO3fZ+XYsNig8Hw0qfj/KQkA/oOL6V+MRh
 aBvW8W2m3up8EI+5GciNDvZA41Yq7Tg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730726390;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FccnCAPsUkkPnEpH/a+bhn38p7NqzYW2XMWb4GREFVc=;
 b=FZwkG96oyFtCKyAAn1eVSAc/U5kvWyuPKR4tq+w/QsES0LDFEHVnNWXIWBUvl6VH2+QHmc
 okkXgD2y7CmcmPDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80D9F1373E;
 Mon,  4 Nov 2024 13:19:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KQAOH/bJKGdjaAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 04 Nov 2024 13:19:50 +0000
Date: Mon, 4 Nov 2024 14:19:50 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZyjJ9iywT4boYavJ@yuki.lan>
References: <20241101141111.104803-1-mdoucha@suse.cz>
 <20241101141111.104803-6-mdoucha@suse.cz>
 <20241101233221.GC1324664@pevik> <ZyjGiQ7-oyBZBG-S@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZyjGiQ7-oyBZBG-S@yuki.lan>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/5] Add test for data integrity over NFS
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
> > The quickest way would be to use the same calculation (* $TST_CNT + 5% for spare
> > time) in nfs10.sh and increase tst_set_timeout with.
> > 
> > Or, I wonder if using tst_loader.sh and tst_run_shell.c would help to integrate
> > these. But I'm not sure how easily could be nfs_lib.sh integrated, e.g.
> > * isn't it too late, when it uses tst_net.sh (maybe this file would need to be
> >   integrated)
> > * should use keep using TST_ALL_FILESYSTEMS=1 from tst_test.sh or configure
> >   via all_filesystems=1 via json?
> 
> I guess that the best solution would be to add NFS support into the
> tst_test.c as another filesystem. That way we would get much more
> coverate than we do now. I guess that it would be doable as long as the
> configuration on how to do that is passed to the test library somehow.

I'm looking at the nfs_lib.sh, we do have a lot there actually since it
runs for all filesystems and we run the nfs tests for different nfs
versions as well. This does not seem that would integrate well into the
tst_test all_filesystems testing.

I will think a bit how to integrate things better, because having LTP
test inside LTP test will never work well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
