Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C934C4345F
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 10:35:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B0DEC3CFB97
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 12:35:47 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C2A7A3CFA6D
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 12:35:32 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 49A73600C90
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 12:35:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5EC1633B17;
 Wed, 17 Apr 2024 10:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713350131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B41bPp2eHVuHLNzCs/zWwx/6XHOXfMjt4XdbheC6RVc=;
 b=CG8JnV/MFKHwMF2o0YgfLMfDNRQjdnHLfdLTgqFCp+e41MLaDMbuU4WbiKdOl7a2sHoQbr
 5nmAzgKzCd91oVLlUdWFzpkzuoyWeom9ij0I8u3qQRqPPH9aY6f/SgwlX7xagtjIpzgDlj
 nKK5xq5yGe8upzgWT4q9K0uFERe3kDQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713350131;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B41bPp2eHVuHLNzCs/zWwx/6XHOXfMjt4XdbheC6RVc=;
 b=kvoLBxlmqFrLIdtlC0+MgEV/WgFSqVT0Wta673NOl8/u0SuQYwfwcKM5N+td5X77SJzLyu
 gs/pcgfnWH//04Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713350131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B41bPp2eHVuHLNzCs/zWwx/6XHOXfMjt4XdbheC6RVc=;
 b=CG8JnV/MFKHwMF2o0YgfLMfDNRQjdnHLfdLTgqFCp+e41MLaDMbuU4WbiKdOl7a2sHoQbr
 5nmAzgKzCd91oVLlUdWFzpkzuoyWeom9ij0I8u3qQRqPPH9aY6f/SgwlX7xagtjIpzgDlj
 nKK5xq5yGe8upzgWT4q9K0uFERe3kDQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713350131;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B41bPp2eHVuHLNzCs/zWwx/6XHOXfMjt4XdbheC6RVc=;
 b=kvoLBxlmqFrLIdtlC0+MgEV/WgFSqVT0Wta673NOl8/u0SuQYwfwcKM5N+td5X77SJzLyu
 gs/pcgfnWH//04Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DD9C13976;
 Wed, 17 Apr 2024 10:35:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OsTFEvOlH2Z4cQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 17 Apr 2024 10:35:31 +0000
Date: Wed, 17 Apr 2024 12:34:36 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Zh-lvOimOYLd2Z4H@yuki>
References: <20240417101201.715518-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240417101201.715518-1-pvorel@suse.cz>
X-Spamd-Result: default: False [-7.58 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-2.78)[99.05%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc: documentation: Fix typo other => older
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
> I suppose you mean "older", otherwise the sentence does not make sense
> to me (i.e. which versions caused problems?)

Can we fix this one in the same patch as well?

diff --git a/doc/developers/documentation.rst b/doc/developers/documentation.rst
index 30dacd384..b56d5b4c7 100644
--- a/doc/developers/documentation.rst
+++ b/doc/developers/documentation.rst
@@ -11,7 +11,7 @@ and it's built on top of `Sphinx <https://www.sphinx-doc.org/en/master/>`_.
 Building documentation
 ~~~~~~~~~~~~~~~~~~~~~~

-First of all, to build the documentation we must be sure that all dependences
+First of all, to build the documentation we must be sure that all dependencies
 have been installed (please check ``doc/requirements.txt`` file). Sometimes the
 Linux distros are providing them, but the best way is to use ``virtualenv``

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
