Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE651FEA83E
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 09:58:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A1A1D3E2AD4
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 10:58:01 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B02B53E1365
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 10:57:43 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2D1781A0109E
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 10:57:42 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A088A5BCE7;
 Wed, 25 Mar 2026 09:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774432661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bOzvw1wzT2Kxo24cMtwAuJGyNsl7vFNmJdIShCvlGYg=;
 b=c125QiYoIW1/dIMS3T+RISz1yjAs/uHdeABLntXGW+jEcXLHByTwgT9Qxh1FB6PXEGT8sz
 qn3ZY7mMOCFrFKYe4wA0C5foCE/FW2SIUK3RzgE0kAvxi/AqlHpIimAovBUP3TJCgx4PQn
 tOs79KUsrJ01HzzJjxCmfjmPQCTP1Rc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774432661;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bOzvw1wzT2Kxo24cMtwAuJGyNsl7vFNmJdIShCvlGYg=;
 b=WTRQUn+91j4cjXsqNXIf0Ze+wlAsYpPaIcN+R0EcQeQ1WCTYSfD9vub/xnk86Kxx3juexm
 If8RLow1S5AON6AQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=c125QiYo;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WTRQUn+9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774432661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bOzvw1wzT2Kxo24cMtwAuJGyNsl7vFNmJdIShCvlGYg=;
 b=c125QiYoIW1/dIMS3T+RISz1yjAs/uHdeABLntXGW+jEcXLHByTwgT9Qxh1FB6PXEGT8sz
 qn3ZY7mMOCFrFKYe4wA0C5foCE/FW2SIUK3RzgE0kAvxi/AqlHpIimAovBUP3TJCgx4PQn
 tOs79KUsrJ01HzzJjxCmfjmPQCTP1Rc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774432661;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bOzvw1wzT2Kxo24cMtwAuJGyNsl7vFNmJdIShCvlGYg=;
 b=WTRQUn+91j4cjXsqNXIf0Ze+wlAsYpPaIcN+R0EcQeQ1WCTYSfD9vub/xnk86Kxx3juexm
 If8RLow1S5AON6AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F41744338;
 Wed, 25 Mar 2026 09:57:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pQBIIpWxw2nbLQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 25 Mar 2026 09:57:41 +0000
Date: Wed, 25 Mar 2026 10:57:42 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Cermak <mcermak@redhat.com>
Message-ID: <acOxlitfqdMfAbZs@yuki.lan>
References: <20260323210805.20929-1-pvorel@suse.cz> <acKPE_1MwQhayd4O@yuki.lan>
 <20260324140938.nxlzn5f2f6iakrm5@lida.tpb.lab.eng.brq.redhat.com>
 <20260325090648.diugdugszgd3inuo@lida.tpb.lab.eng.brq.redhat.com>
 <20260325091003.GA86256@pevik>
 <20260325092156.3sxnn26nlejzzygn@lida.tpb.lab.eng.brq.redhat.com>
 <acOs7mrlNceEtchW@yuki.lan>
 <20260325094215.aiv3he5pdgm2v4fn@lida.tpb.lab.eng.brq.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260325094215.aiv3he5pdgm2v4fn@lida.tpb.lab.eng.brq.redhat.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 URIBL_BLOCKED(0.00)[yuki.lan:mid,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email]
X-Rspamd-Queue-Id: A088A5BCE7
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Valgrind-developers] [RFC PATCH 1/1] LTP tests: Run
 without LTP_REPRODUCIBLE_OUTPUT=1
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
Cc: valgrind-developers@lists.sourceforge.net, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > That sounds reasonable to me.  Which one would you prefer to
> > > keep?  I'm inclined to suggest keeping LTP_REPRODUCIBLE_OUTPUT
> > > and dropping LTP_QUIET but no really strong preference on my
> > > side.  Thoughts?
> > 
> > Maybe we can finally implement proper debug levels in LTP. E.g. hide
> > TINFO and TWARN messages with debug level 0 and default to debug level
> > 1. With debug level 2 we would show TDEBUG as well and with debug level
> > 3 we would show TDEBUG messages for library too.
> 
> That would require running valgrind tests with something like
> debug level -1 ;) because what LTP_REPRODUCIBLE_OUTPUT actually
> does is that it hides testrun specific output like e.g. testrun
> specific addresses, temporary file names etc.

The LTP_REPRODUCIBLE_OUTPUT would have to stay, but the LTP_QUITE would
have been replaced by different debug levels.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
