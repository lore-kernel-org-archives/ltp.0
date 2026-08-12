Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B4EC5B56A
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 13:11:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE8B63E7011
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 15:11:42 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 47B0A3C9EF8
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 15:11:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D05486001FD
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 15:11:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 17EDE3E60;
 Wed, 12 Aug 2026 13:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786540282;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XW+DNZdaGiOEWXPMSEB+xr/KY4PTQKdD/irBpzeqdaE=;
 b=kjaZgq4a9sWFC4nzn0XR8FdX5gaTQ7KQ93rGEIXM9hgYa/sji9lKPxIAgXfpuEWSarsKau
 8lnjc88J6F1jJbPkS2/ZlzUpv96kHbEW89hSU2rqlmqBNBjr/o35d2C48kPP5dhxc0bzw7
 N/xevGgHYawL7WRS2QhqfyYszPt2/6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786540282;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XW+DNZdaGiOEWXPMSEB+xr/KY4PTQKdD/irBpzeqdaE=;
 b=7D5l+inmoYYHdiOW+Ufg/y0Ck/s28k/Kehy3vYrcNBpKHttqOji3VYEHLx407feuBWOZMF
 vuppm53PLVlFmLBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786540278;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XW+DNZdaGiOEWXPMSEB+xr/KY4PTQKdD/irBpzeqdaE=;
 b=uqom/4mPcZKm4zBCScXxDa4pAWmN6Ucedvqx+sexOIRbcfkA0MsewMTqrYzGZFmhu2ZpUn
 goGY+Vcu4mgZXQqddZcN3E5m982yDjYZ7wgcRNstlCGwsdmZ5EA9hSnWI4Vvgqi5bpDYUL
 /wHJB5U+s4xorfRfHHBNbyQzNAkpuU4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786540278;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XW+DNZdaGiOEWXPMSEB+xr/KY4PTQKdD/irBpzeqdaE=;
 b=Uw/Wmcjj84hUDK8lVSidfE9EdUaf9Wu4seFHgE6yiGF4zpoYkPmGngVveGSDmdZg8lToBh
 y4x+Hj3YlrBf9tCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDEE4779B2;
 Wed, 12 Aug 2026 13:11:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1x4lOfVwfGr6UgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 12 Aug 2026 13:11:17 +0000
Date: Wed, 12 Aug 2026 15:11:12 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260812131112.GC1758016@pevik>
References: <20260810160048.1040517-1-pvorel@suse.cz>
 <20260810160048.1040517-4-pvorel@suse.cz>
 <anxTci_fnDEztVVT@yuki.lan> <20260812123007.GA1758016@pevik>
 <anxo4jwILKGq_H8J@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <anxo4jwILKGq_H8J@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,tst_test.sh:url,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > I deliberately did not add it and documented my intention in
> > doc/developers/writing_tests.rst LTP C And Shell Test API Comparison table
> > +    * - .max_kver
> > +      - not implemented

> This is correct since this is different shell API (v2). The change I
> requested is newest shell API (v3).

Unfortunately we have many tests in v2, I hoped we would at lest mention there
is v2. I'm not happy with the fact that we document only v3, IMHO at least have
link v2 API is in doc/old/Shell-.... would be good.

> This is also reason why I asked for deletion of this table, it
> documments older API (tst_test.sh) and confuses people.

BTW the test was moved there in 4a72aada873, which was 4 months ago before you
wrote shell loader API (5528da0231).

I still think it's useful (until we rewrite more tests into shell API => now we
have many tests for which we delete documentation), but it should be clearly
visible it's for tst_test.sh (v2 API). But I'm ok to remove it if you don't want
to waste time with v2 (we removed part of old docs in 4a72aada873 which removed
also doc/old/Test-Writing-Guidelines.asciidoc which had this table).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
