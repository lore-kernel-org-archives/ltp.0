Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD50CC48BC3
	for <ltp@archiver.kernel.org>; Wed, 21 Feb 2024 14:50:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 261643D0453
	for <ltp@archiver.kernel.org>; Wed, 21 Feb 2024 15:50:43 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 703243C8EE0
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 15:50:27 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EFC0A60240D
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 15:50:26 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EFD0B21AE3;
 Wed, 21 Feb 2024 14:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708527026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/KvgJDmRVNv2ryVUp+peUvqxokC60Q5PeDUKbX8ugNA=;
 b=WG1guBesfYEJQ/iY+lSWnOUHfkoyYWI6bCeZxvRGkOfLU8TlULYxbRRLktyRrPTbB6vsCP
 aesKyUjIGw7r1BrLFscXkAjbIHB5lZUHU336r7FCdzMk9GDaD3+hDKvk45kqk2MXJoFnF8
 u4x4SKq/Y8BYf9zvYl0BeaY3CXMM8Jg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708527026;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/KvgJDmRVNv2ryVUp+peUvqxokC60Q5PeDUKbX8ugNA=;
 b=ZwnG0cV+VssOYWkrWH1Mqqi6jCW9ac/p59HYpZAZ/RgArkzHZOMnEy9MHht842/KvIVYr3
 AgVRcSSV4ZhHDODQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708527024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/KvgJDmRVNv2ryVUp+peUvqxokC60Q5PeDUKbX8ugNA=;
 b=IybTkj8LQo5T5bolAyH7PdqZmzpJtQ+gGdlfXXNPtZyT1A3ZNk8Pku28GoAPQAn1UQE13f
 J26qC6IBS8/CS7LRmuXjiAHzm3oVCZUWtWcNTbuIHLQdCEbC9OdAZ/Wdvr/qvcDAgLDAtk
 ARFDb9WJgx0kuoXo9+dzlg3Uh1rGF0k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708527024;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/KvgJDmRVNv2ryVUp+peUvqxokC60Q5PeDUKbX8ugNA=;
 b=lz+CUiNnpS1fUFZVzYgh7twEHbZVijJFjslB/jfIzvDygdsN3ytA3z+a75yy9KvdjidviV
 3AujT+ZrMssi+yDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDF25139D0;
 Wed, 21 Feb 2024 14:50:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id E2EyMbAN1mWSCAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 21 Feb 2024 14:50:24 +0000
Date: Wed, 21 Feb 2024 15:49:09 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZdYNZcSmezIeGKsq@yuki>
References: <20240220123743.7181-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240220123743.7181-1-andrea.cervesato@suse.de>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.58 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.98)[99.91%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Add more testcases in mkdir03
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
>  runtest/syscalls                           |  2 +-
>  testcases/kernel/syscalls/mkdir/.gitignore |  1 +
>  testcases/kernel/syscalls/mkdir/mkdir03.c  | 10 ++++
>  testcases/kernel/syscalls/mkdir/mkdir10.c  | 57 ++++++++++++++++++++++

I guess that the whole mkdir10.c addition is a accidental...

And the mkdir03 misses the "/dev/null" addition, otherwise it looks
good.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
