Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69061C2BD09
	for <ltp@archiver.kernel.org>; Thu, 27 Jun 2024 11:09:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D01D3D1309
	for <ltp@archiver.kernel.org>; Thu, 27 Jun 2024 13:09:48 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A9D43D122D
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 13:09:33 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3EED11A027A3
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 13:09:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 56AD21FBBC;
 Thu, 27 Jun 2024 11:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719486571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2bhB1lkG8EPrM0vJy+vjaxcel2CtnJdi/w2razIuTSI=;
 b=gvnS1nze1L/ojAlyIqxsCvIjJhAzw5ACEBHjjcbJa+qnFTbHvseFh1Tbn00nLQvrztgakW
 0UYmWOfrOiUUjQlDElsbFwahvXEPiVLOcSOF3lSY8hz+TgJYC1IHtOIh2t6g3dQS0shrRh
 wfSXApYSAQtVyJl26IiOXheVd1eDsPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719486571;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2bhB1lkG8EPrM0vJy+vjaxcel2CtnJdi/w2razIuTSI=;
 b=NpYLrMHDcGXNXSbY/GU+vS+SOo4qieSwpbGstKRHgj+z0GYE7CTAw8L+iXVSeWOnb355W3
 Fh4seDNQfviHtwBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719486570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2bhB1lkG8EPrM0vJy+vjaxcel2CtnJdi/w2razIuTSI=;
 b=ZMBp5gm4FDjB/kRSH19WCNRk3D2+qmg9R8ZvsrbugkElwP8xVE1OxWhdd1j4hNYCvCKIYJ
 kN6cOHTEYbOA4tQcDF57ajAxzGzsmO/RRSm7ojqauzGS0zTHPpDO2Kk3Nfm5RTRs98X267
 RLM1dDdm7r5sbMU9m+T5u2zhZWaw46k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719486570;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2bhB1lkG8EPrM0vJy+vjaxcel2CtnJdi/w2razIuTSI=;
 b=7u6NcwH6kYWgOGJFZt2QWLWwP8mwuVvk+uNiy5jETHHZg5ON7gzGUZBIqIoRZULLgCz0DG
 gXNuyoVu79j+svBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 438061384C;
 Thu, 27 Jun 2024 11:09:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id slYuEGpIfWZ4OAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 27 Jun 2024 11:09:30 +0000
Date: Thu, 27 Jun 2024 13:09:19 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Zn1IX0NgCWuJKcEm@yuki>
References: <Zi9jL1jycx6oo37g@yuki>
 <CANDhNCq__ZY9w3Nse-+K+d9gyXhrOe_6oZ=X01x_HufZwQ_6ig@mail.gmail.com>
 <Zjn1-1YRyZGIUtEP@yuki> <ZnlORS6RGTAA4UhS@yuki>
 <CANDhNCqk-3o+Bu_c9PbqoxSacGQaGUrdTM5VDoZCOipEttXKLw@mail.gmail.com>
 <CAEemH2fT2NsoZfRvNrhRrstF=dhzF8Y90HqVQSCf1VxqpNHgEw@mail.gmail.com>
 <CANDhNCr4-cE7_Uy86Pa3kjzFG_EOOB38C_mSGSfZtc=vd7L5yQ@mail.gmail.com>
 <CAEemH2cUj4U4Z=G437fduyQA6-UrnhE4b1_QtRB0kmPn5OMgAA@mail.gmail.com>
 <CANDhNCpYjncxr-fn8o5vDDYScf4zvVmH_w_Ms1Jhg9tsn-UgDQ@mail.gmail.com>
 <CAEemH2eQwPSQrHKY3AxT03Nf9Y7NoKpY3y+XE8donjLhHYbP2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eQwPSQrHKY3AxT03Nf9Y7NoKpY3y+XE8donjLhHYbP2Q@mail.gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[build.sh:url, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/6] sched_football: Use atomic for ball
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
Cc: kernel-team@android.com, John Stultz <jstultz@google.com>,
 Darren Hart <darren@os.amperecomputing.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Hmm, at least in the build.sh script, it enables in the configuration phase,
> if you build by that (./build.sh) it should be included.
> 
> But I'm not very sure if it's worth to enable by default.  @Cryil, @Petr.

I do not think that it actually makes a big sense to have the configure
switch for something so small as the realtime testsuite. It's ~30 tests
that are compiled in a few seconds and it does not add too much space to
the installed LTP as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
