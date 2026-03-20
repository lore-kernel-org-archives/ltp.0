Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790E3108B8EC
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 10:29:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 08A633E2362
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 11:29:17 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 193D23E181C
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 11:28:57 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 38EB4600851
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 11:28:57 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E9D325BD9B;
 Fri, 20 Mar 2026 10:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774002536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QhZ+E06f4utE0qy7EXOAJI3TPaLfpxhXNEv+kDH+14s=;
 b=bzRB5sGYYohELHOSmqxMn28qnD2YLZORsicorJMuI4z7JTDggJZrgW8GSQM0iCLtnIgyxn
 zWZcJ+zvBd6scRm9IPSpHlaWSqgUyLqZSRbH0zeybb6MteTUKD9TBt1YmQ+hcP08szOFO4
 bLP0Wq4tl0CMZ7XNmEJAZqsfVEPz9yw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774002536;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QhZ+E06f4utE0qy7EXOAJI3TPaLfpxhXNEv+kDH+14s=;
 b=f4Is4t5vRqt2xk2ekBZULcVj/RislhgOuEHAy7p3cWz4v0ji5jh/Ewdf0ZwlrRMVRgmakt
 GzL6W7kC1EyD1zAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774002535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QhZ+E06f4utE0qy7EXOAJI3TPaLfpxhXNEv+kDH+14s=;
 b=UmM6LmBX851L8BdoKNMPGpl1qzPzTuNGHmfPpmJK+QlBt3nXyFHWEOyAdnqMtRn2hCNj/U
 0KKkEH6qrG1RAuoAAeYHBWZ4nFW9vBnTVZLCKq0RJcwxhtdYYXrUcWQFwqXL8ZC/LFCHP/
 BXOGORVAQnIv/n0oufdH108KM5gzYT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774002535;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QhZ+E06f4utE0qy7EXOAJI3TPaLfpxhXNEv+kDH+14s=;
 b=VZQCcgqw0OJ7SScAMaQhpQ9QptzDPTOtk0/A/cJkktYCzuPscAMF9X/Q+7Ds3QPnKLAi+d
 YW4HAZsV1TLNJSDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D71754273B;
 Fri, 20 Mar 2026 10:28:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qMBVM2chvWkjPwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 20 Mar 2026 10:28:55 +0000
Date: Fri, 20 Mar 2026 11:28:44 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ab0hXPbw1dXD4JY3@yuki.lan>
References: <20260313-listns-v2-0-38384fae9b1f@suse.com>
 <20260313-listns-v2-1-38384fae9b1f@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260313-listns-v2-1-38384fae9b1f@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/5] Update architectures syscalls identifiers
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
>  include/lapi/syscalls/arc.in         |   2 +
>  include/lapi/syscalls/arm.in         |   3 +-
>  include/lapi/syscalls/arm64.in       |   2 +
>  include/lapi/syscalls/i386.in        |   3 +-
>  include/lapi/syscalls/loongarch64.in |   3 ++
>  include/lapi/syscalls/mips64.in      |   4 +-
>  include/lapi/syscalls/mips64n32.in   |   4 +-
>  include/lapi/syscalls/mipso32.in     |   4 +-
>  include/lapi/syscalls/parisc.in      |   3 +-
>  include/lapi/syscalls/powerpc.in     |   3 +-
>  include/lapi/syscalls/powerpc64.in   |   3 +-
>  include/lapi/syscalls/s390.in        | 102 +++++++++--------------------------

Why do we change so much in the s390.in? I'm not saying it's wrong (I
haven't checked) but even if it's correct it at least should have been
explained in the commit message.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
