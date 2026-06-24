Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E2FCDB479
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 13:27:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 07A8C3E6279
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 15:27:32 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F7E43E5872
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 15:27:16 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8D7461000A24
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 15:27:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 57BEF713CB;
 Wed, 24 Jun 2026 13:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782307634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v3t2Y+68jLhB0IEtS+1HwuiVe+onjYo9ALKEt2lDgIs=;
 b=M6r5vOAIBmHnh8TSeMxasfbtbgL57ySKRAmYLkZnsscLVGeQwG8IQBm7e2/MAha65nduso
 a4dK9iU1YmlHQVnxvBs2Zru0zMPjq4zTgP8Zb9GS1Mdzr7JRHxql7sOjmK5j2smtD2Q3TN
 bkHyg4h+DnhUT3b2fnUZr36nGqfMxtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782307634;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v3t2Y+68jLhB0IEtS+1HwuiVe+onjYo9ALKEt2lDgIs=;
 b=FjaDqWWuzV/grON5aVYxnipL52lUEWaHK8oQUgYqMXiZ+C56xkSiS0w1dZ/Ef8Ca8TCuK1
 Ch1e384gUFSKDzAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782307634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v3t2Y+68jLhB0IEtS+1HwuiVe+onjYo9ALKEt2lDgIs=;
 b=M6r5vOAIBmHnh8TSeMxasfbtbgL57ySKRAmYLkZnsscLVGeQwG8IQBm7e2/MAha65nduso
 a4dK9iU1YmlHQVnxvBs2Zru0zMPjq4zTgP8Zb9GS1Mdzr7JRHxql7sOjmK5j2smtD2Q3TN
 bkHyg4h+DnhUT3b2fnUZr36nGqfMxtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782307634;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v3t2Y+68jLhB0IEtS+1HwuiVe+onjYo9ALKEt2lDgIs=;
 b=FjaDqWWuzV/grON5aVYxnipL52lUEWaHK8oQUgYqMXiZ+C56xkSiS0w1dZ/Ef8Ca8TCuK1
 Ch1e384gUFSKDzAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47177779A8;
 Wed, 24 Jun 2026 13:27:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Lc9AETLbO2qDBwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 24 Jun 2026 13:27:14 +0000
Date: Wed, 24 Jun 2026 15:27:17 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ajvbNX51zO4oipbO@yuki.lan>
References: <20260624091900.4107041-14-chrubis@suse.cz>
 <6a3bda09.a05553f2.30663f.4863@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a3bda09.a05553f2.30663f.4863@mx.google.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, yuki.lan:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 13/13] metadata: Add runtest file generator
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
> There's a build issue related to runtest/ folder. It seems like
> by the time you call genruntest the folder is not present yet.
> 
> https://github.com/linux-test-project/ltp/actions/runs/28095394061/job/83183512348
> 
> This needs to be fixed in v2.

Sigh, that's the out-of-tree build, we should have dropped that long
time ago, since it overcomplicates everything...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
