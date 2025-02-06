Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E9AC02196
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 14:27:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C7AE53C9295
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 15:27:15 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8E1123C12C2
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 15:26:59 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E19A464807B
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 15:26:58 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 129871F38D;
 Thu,  6 Feb 2025 14:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738852018;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gHqx8bV/f3zzsDzAVR5ed+xJaTGyRQ4eNJg1PnsYnIE=;
 b=g7kJc5cnGucfOmqBihnlT+EOWkZ8ZVx0WbJtO9pBnTStsX0WzO2usl9WVXNsk0T9NdCJcP
 iQNRuu8nfHb1+uuqpfawhKWKG3DSrNWAgOD0WNIB6VlJgnJboDD6LkKA37dCNHXf8Qyado
 Ou5RYEhMYXuHaSD13KRZnnLzHou7E6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738852018;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gHqx8bV/f3zzsDzAVR5ed+xJaTGyRQ4eNJg1PnsYnIE=;
 b=na2Sj5ujENQY1ZSro5lqGndtYB9xCZpzhBgwqVh2YoB88BVTCpJpoq0X+GBHO+yQak8kHx
 q8sZ6lP7GrTlR7AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738852018;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gHqx8bV/f3zzsDzAVR5ed+xJaTGyRQ4eNJg1PnsYnIE=;
 b=g7kJc5cnGucfOmqBihnlT+EOWkZ8ZVx0WbJtO9pBnTStsX0WzO2usl9WVXNsk0T9NdCJcP
 iQNRuu8nfHb1+uuqpfawhKWKG3DSrNWAgOD0WNIB6VlJgnJboDD6LkKA37dCNHXf8Qyado
 Ou5RYEhMYXuHaSD13KRZnnLzHou7E6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738852018;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gHqx8bV/f3zzsDzAVR5ed+xJaTGyRQ4eNJg1PnsYnIE=;
 b=na2Sj5ujENQY1ZSro5lqGndtYB9xCZpzhBgwqVh2YoB88BVTCpJpoq0X+GBHO+yQak8kHx
 q8sZ6lP7GrTlR7AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E527F13697;
 Thu,  6 Feb 2025 14:26:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ClNtNrHGpGdiJQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 06 Feb 2025 14:26:57 +0000
Date: Thu, 6 Feb 2025 15:26:56 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20250206142656.GB1566904@pevik>
References: <20250206-doc_tests_list-v5-0-52110e1421a9@suse.com>
 <20250206-doc_tests_list-v5-2-52110e1421a9@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250206-doc_tests_list-v5-2-52110e1421a9@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 2/2] doc: add tests catalog page
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

Hi Andrea,

Acked-by: Petr Vorel <pvorel@suse.cz>

Thanks for extra comments to _generate_setup_table().

There is quite a lot of warnings. I'm not suggesting we should fix them (I don't
want to block this, let's merge it today), but more warnings and errors we get
the worse is to find a real problem which might appear in the future.

I might take time in the future to fix them - some of them could be easily
fixed and some of the warning means part of the description got lost, e.g.
"1. First test case" and "2. Second test case" in mountns0[1-3].c is not
followed by the actual description "X: bind mounts DIR_B to DIR_A", indent is
also wrong. This means sphinx syntax (reST) is not 100% compatible to
asciidoc{,tor} syntax. Syntax problems are also visible in Vim with highlighting
on.

_static/tests.rst:557: WARNING: Inline interpreted text or phrase reference start-string without end-string.

The code `mmap(2)`s reg
=> using unnecessary `...` (for formatting as code it would be ``..``, but I
would just remove it.

_static/tests.rst:693: WARNING: Bullet list ends without a blank line; unexpected unindent.
_static/tests.rst:694: WARNING: Enumerated list ends without a blank line; unexpected unindent.
_static/tests.rst:697: WARNING: Block quote ends without a blank line; unexpected unindent.
_static/tests.rst:698: WARNING: Enumerated list ends without a blank line; unexpected unindent.

_static/tests.rst:742: WARNING: Bullet list ends without a blank line; unexpected unindent.
_static/tests.rst:743: WARNING: Enumerated list ends without a blank line; unexpected unindent.
_static/tests.rst:746: WARNING: Block quote ends without a blank line; unexpected unindent.
_static/tests.rst:747: WARNING: Enumerated list ends without a blank line; unexpected unindent.
_static/tests.rst:792: WARNING: Bullet list ends without a blank line; unexpected unindent.
_static/tests.rst:793: WARNING: Enumerated list ends without a blank line; unexpected unindent.

These are the lost description.

_static/tests.rst:796: WARNING: Block quote ends without a blank line; unexpected unindent.
_static/tests.rst:797: WARNING: Enumerated list ends without a blank line; unexpected unindent.

_static/tests.rst:2530: ERROR: Unexpected indentation.

=> FYI  this one might be '.' instead of '*'

. It writes instead of reads to fill the page cache. Because no
  pages were allocated on tmpfs.

_static/tests.rst:2531: WARNING: Block quote ends without a blank line; unexpected unindent.
_static/tests.rst:2533: ERROR: Unexpected indentation.
_static/tests.rst:9425: WARNING: Inline emphasis start-string without end-string.
_static/tests.rst:11685: WARNING: Bullet list ends without a blank line; unexpected unindent.
_static/tests.rst:12122: WARNING: Bullet list ends without a blank line; unexpected unindent.
_static/tests.rst:14986: ERROR: Unexpected indentation.
_static/tests.rst:14987: WARNING: Block quote ends without a blank line; unexpected unindent.
_static/tests.rst:15779: ERROR: Unexpected indentation.
_static/tests.rst:15781: WARNING: Block quote ends without a blank line; unexpected unindent.
_static/tests.rst:15787: WARNING: Definition list ends without a blank line; unexpected unindent.
_static/tests.rst:17886: WARNING: Enumerated list ends without a blank line; unexpected unindent.
_static/tests.rst:17887: WARNING: Block quote ends without a blank line; unexpected unindent.
_static/tests.rst:17888: WARNING: Enumerated list ends without a blank line; unexpected unindent.
_static/tests.rst:24631: ERROR: Unexpected indentation.
_static/tests.rst:24632: WARNING: Block quote ends without a blank line; unexpected unindent.
_static/tests.rst:24766: ERROR: Unexpected indentation.
_static/tests.rst:27685: WARNING: Enumerated list ends without a blank line; unexpected unindent.
_static/tests.rst:27820: WARNING: Bullet list ends without a blank line; unexpected unindent.
_static/tests.rst:33084: WARNING: Bullet list ends without a blank line; unexpected unindent.
_static/tests.rst:33085: WARNING: Block quote ends without a blank line; unexpected unindent.
_static/tests.rst:33610: WARNING: Bullet list ends without a blank line; unexpected unindent.
_static/tests.rst:34692: ERROR: Unexpected indentation.
_static/tests.rst:34694: WARNING: Block quote ends without a blank line; unexpected unindent.
_static/tests.rst:34722: ERROR: Unexpected indentation.
_static/tests.rst:35279: WARNING: Bullet list ends without a blank line; unexpected unindent.
_static/tests.rst:35309: WARNING: Bullet list ends without a blank line; unexpected unindent.
_static/tests.rst:39506: WARNING: Bullet list ends without a blank line; unexpected unindent.
_static/tests.rst:41852: WARNING: Inline emphasis start-string without end-string.
_static/tests.rst:41855: WARNING: Inline emphasis start-string without end-string.
_static/tests.rst:41858: WARNING: Inline emphasis start-string without end-string.
_static/tests.rst:41862: WARNING: Inline emphasis start-string without end-string.
_static/tests.rst:41866: WARNING: Inline emphasis start-string without end-string.
_static/tests.rst:41869: WARNING: Inline emphasis start-string without end-string.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
