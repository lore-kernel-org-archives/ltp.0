Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B0F0CF34B0
	for <ltp@archiver.kernel.org>; Thu,  3 Oct 2024 14:44:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 084FB3C5FDC
	for <ltp@archiver.kernel.org>; Thu,  3 Oct 2024 16:44:14 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B0F03C5F6C
 for <ltp@lists.linux.it>; Thu,  3 Oct 2024 16:43:58 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F33BE1416759
 for <ltp@lists.linux.it>; Thu,  3 Oct 2024 16:43:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9599421D8A;
 Thu,  3 Oct 2024 14:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1727966633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c/CDrZk6USS4cZo13nrO6srMjaeAaD6/OBf/6rmpDMY=;
 b=t7QKQv/IgORkJbg9e9LFreWyV0Ak/QZ+3flIKYXPj2xdNUcHWMGBhf5Mkz6cGtoHM4Hsz1
 6vyErVBfE0sfSh6n6i+YB9KedKpLTH1hJ4BS2VlQjS+zvXAY7kaXwml4PHnfcn+7lmsDic
 YiKKrvKEJdbx0vTuMHkRze70+Ds029U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1727966633;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c/CDrZk6USS4cZo13nrO6srMjaeAaD6/OBf/6rmpDMY=;
 b=+7rk4aBZWTVLdibNlOXBpmptMooTyPXES3p9jl7VeXqt0VeVsgYniEJNo+epl9HBkz+abk
 efVjxMXWzUG4AqCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1727966633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c/CDrZk6USS4cZo13nrO6srMjaeAaD6/OBf/6rmpDMY=;
 b=t7QKQv/IgORkJbg9e9LFreWyV0Ak/QZ+3flIKYXPj2xdNUcHWMGBhf5Mkz6cGtoHM4Hsz1
 6vyErVBfE0sfSh6n6i+YB9KedKpLTH1hJ4BS2VlQjS+zvXAY7kaXwml4PHnfcn+7lmsDic
 YiKKrvKEJdbx0vTuMHkRze70+Ds029U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1727966633;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c/CDrZk6USS4cZo13nrO6srMjaeAaD6/OBf/6rmpDMY=;
 b=+7rk4aBZWTVLdibNlOXBpmptMooTyPXES3p9jl7VeXqt0VeVsgYniEJNo+epl9HBkz+abk
 efVjxMXWzUG4AqCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85C2C13882;
 Thu,  3 Oct 2024 14:43:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pTmZH6mt/mb3UgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 03 Oct 2024 14:43:53 +0000
Date: Thu, 3 Oct 2024 16:42:46 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Zv6tZhQozpxEdOM7@yuki.lan>
References: <20240909-listmount_statmount-v4-0-39558204ddf0@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240909-listmount_statmount-v4-0-39558204ddf0@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 00/13] statmount/listmount testing suites
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
And we still need an invalid parameters for listmount() test I suppose.

I suppose that we can at least pass invalid size, flags and invalid
mnt_id and invalid param.

Also we should add a check for EPERM with LISTMOUNT_UNREACHABLE and
unpriviledged user.

See errors at:
https://lore.kernel.org/linux-man/cover.1719840964.git.josef@toxicpanda.com/T/#m0eba3ca21ebf29bd5a5cfe681fc4cb2b9aa7f6e7

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
