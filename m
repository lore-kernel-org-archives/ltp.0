Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0703FCDB479
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 10:51:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C2CA3E620A
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 12:51:18 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB8763C5BAD
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 12:51:01 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 40BE41000760
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 12:51:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E19697191D;
 Wed, 24 Jun 2026 10:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782298260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QM8JSRG2WW2brJ0gAm3tSGgkE4DU/x09ri1GR6XBuAU=;
 b=dmcjxrZIqdLhVINUeO/xbLmy6fUBnBJHGJwHA2SCAoS9fuSm9BJIW8mFq+jkiAkbNCDGUN
 grFbaQn32pvLK9yHnqXv741DXMUw2U1QKoilqtmIWVpKYZTxWKPRkwgLakyqqm4UpO9gQj
 QjGxdHsoia1V1yUm3nA1A3Pc7d69tnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782298260;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QM8JSRG2WW2brJ0gAm3tSGgkE4DU/x09ri1GR6XBuAU=;
 b=7NcRQflkFfGmP/jxyaKaYQtYK/WSUpIie2pX2yfAmCD7m7UAZ6x97IiV3QLIBygMLFHJkA
 VhRQELN8wH+b8GAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782298259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QM8JSRG2WW2brJ0gAm3tSGgkE4DU/x09ri1GR6XBuAU=;
 b=jxpLv/M4xFtf7AShG97nCDIRYE9JGJ8u5cSA9FWZALr713NK9tbEtYFZTySd0n2y90U3I8
 JL7BmiDfHSMBycayYdvTXqp6GZO1VV4Xe5TLuz4Y9tBWFXoK/MdkbNA3SDWJDp0BvNWL04
 Yo3jjAFcNskoz46WdocQnOI/3VkLyAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782298259;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QM8JSRG2WW2brJ0gAm3tSGgkE4DU/x09ri1GR6XBuAU=;
 b=ZAsbTPW/G0f7jrLDaesdKF/vpwYm6fp+bXeJfdI89h3RvFQ00j5qVE0ou3LvBHSdaWEXu+
 UKNaQXX1MBvSmbAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC090779A8;
 Wed, 24 Jun 2026 10:50:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QE4CMJO2O2pxawAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 24 Jun 2026 10:50:59 +0000
Date: Wed, 24 Jun 2026 12:50:55 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aju2jwCz8aky9FgR@yuki.lan>
References: <20260624091900.4107041-6-chrubis@suse.cz>
 <6a3bb499.283787d8.200e76.abe2@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a3bb499.283787d8.200e76.abe2@mx.google.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[];
 URIBL_BLOCKED(0.00)[yuki.lan:mid,imap1.dmz-prg2.suse.org:helo,suse.cz:email]; 
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid, imap1.dmz-prg2.suse.org:helo,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 05/13] vma05.sh, keyctl01.sh: Add groups
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
> as I already mentioned, I think we should do this in all tests,
> instead of having it only for shell tests. I know manual groups
> are error-prone, but they give us good control over what we are
> setting up.
> 
> I'm not sure if adding groups based on folders as we decided to
> do it for C API is a good idea. A tst_test->groups array feels
> better suited, if shell tests can't automatically support the
> same approach.

I fear that we will have a lot of typos and wrong data in there. We had
quite a few wrong CVE tags already, because we weren't checking them for
validity.

I'm okay with this as long as we have a checks in 'make check' that make
sure that the manually assigned groups are correct. For that we would
need the same heuristic we have for automatic groups to check that we
didn't miss anything and a list of valid groups to check againts to
guard againts typos.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
