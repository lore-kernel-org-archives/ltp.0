Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C006BE9A03B
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 15:52:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B5F03D0778
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 16:52:58 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 178D43D053E
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 16:52:38 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9F9661400BF0
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 16:52:37 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 333505BCEC;
 Thu, 19 Feb 2026 15:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771516356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EWbRQ+GyrkCBym3qRQeqnLfxy+NGnvnH7VfhMmlcKbU=;
 b=06GSnkt1oW0Zw0pYNnouwCTJAWzV621gdNCBS4sChiCyodoBVuZDdYsQiJ60zoyXQT44TY
 1ScOSdolg5CKF3brqvngO3D1kLF/jRCn0cFLUSqYTg24yLNOi+eJ3M4HDvqmiai7Y1vgjz
 Pf5JFP0S8X9MMLinxho0DHcZNo90Sqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771516356;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EWbRQ+GyrkCBym3qRQeqnLfxy+NGnvnH7VfhMmlcKbU=;
 b=t9uswyPW8DulRtmlw/Ksu0D9qmQY+BcToKiNKHou1ixiiknd6yg6z8edik7yp8FEvvRNe6
 nfrK/PyoZUMTv+CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771516356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EWbRQ+GyrkCBym3qRQeqnLfxy+NGnvnH7VfhMmlcKbU=;
 b=06GSnkt1oW0Zw0pYNnouwCTJAWzV621gdNCBS4sChiCyodoBVuZDdYsQiJ60zoyXQT44TY
 1ScOSdolg5CKF3brqvngO3D1kLF/jRCn0cFLUSqYTg24yLNOi+eJ3M4HDvqmiai7Y1vgjz
 Pf5JFP0S8X9MMLinxho0DHcZNo90Sqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771516356;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EWbRQ+GyrkCBym3qRQeqnLfxy+NGnvnH7VfhMmlcKbU=;
 b=t9uswyPW8DulRtmlw/Ksu0D9qmQY+BcToKiNKHou1ixiiknd6yg6z8edik7yp8FEvvRNe6
 nfrK/PyoZUMTv+CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11F6E3EA65;
 Thu, 19 Feb 2026 15:52:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id suWTAsQxl2kPTQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 19 Feb 2026 15:52:36 +0000
Date: Thu, 19 Feb 2026 16:52:41 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Ricardo Branco <rbranco@suse.de>
Message-ID: <aZcxySLjRJj4FbiC@yuki.lan>
References: <20260218135026.159676-1-rbranco@suse.de>
 <DGIUIYEL9H07.TK6CF1O2WP7H@suse.com> <aZby3eA2UvAnpWzd@yuki.lan>
 <d26ee751-638d-4a01-97f7-61adcdabea60@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d26ee751-638d-4a01-97f7-61adcdabea60@suse.de>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] userfaultfd: Add test using UFFDIO_POISON
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> >> WARNING: Use of volatile is usually wrong: see Documentation/process/v=
olatile-considered-harmful.rst
> >> #88: FILE: userfaultfd06.c:88:
> >> +       volatile char dummy;
> > I do not think that volatile is needed here.
> =

> This is needed.=A0 Without it, the test hangs.

I suppose that the compiler optimizes out the read because we are not
using the value. We do have a maybe a bit more descriptive macro for
these cases called LTP_VAR_USED().

-- =

Cyril Hrubis
chrubis@suse.cz

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
