Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD2F8C4345F
	for <ltp@archiver.kernel.org>; Fri, 12 Apr 2024 11:46:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3BC763CF911
	for <ltp@archiver.kernel.org>; Fri, 12 Apr 2024 13:46:36 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9723D3CF8B4
 for <ltp@lists.linux.it>; Fri, 12 Apr 2024 13:46:20 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8E694601903
 for <ltp@lists.linux.it>; Fri, 12 Apr 2024 13:46:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 653365FD78;
 Fri, 12 Apr 2024 11:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712922378;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=RoB2nvSVpoqrgm9jVjKmFKsCyrR0hYm2A4/G8DJXDDw=;
 b=n1VSsy4xbq7u7jjh/vi+CwmEG+rtM2mlHLu/9qchLVKTEaDPB6Zp70NNbWSqZX87uUlseV
 y4o9bIJe09f5zVZJo5MTZ+1+l7WvVOhSpD/Qf2r1sawwj3FjtE/6v50bScApsCBIN4Vao3
 fERATHr6uSLQWJS9w2nboa3iGN1SrvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712922378;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=RoB2nvSVpoqrgm9jVjKmFKsCyrR0hYm2A4/G8DJXDDw=;
 b=0rfmHHax14wRZRlM662YSzsy5kPrnBjF5wmVP7wh1cqbFj/dYyDYuqfqakmk6mZmEEnvKj
 idTPEdzoVGLiP1AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712922378;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=RoB2nvSVpoqrgm9jVjKmFKsCyrR0hYm2A4/G8DJXDDw=;
 b=n1VSsy4xbq7u7jjh/vi+CwmEG+rtM2mlHLu/9qchLVKTEaDPB6Zp70NNbWSqZX87uUlseV
 y4o9bIJe09f5zVZJo5MTZ+1+l7WvVOhSpD/Qf2r1sawwj3FjtE/6v50bScApsCBIN4Vao3
 fERATHr6uSLQWJS9w2nboa3iGN1SrvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712922378;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=RoB2nvSVpoqrgm9jVjKmFKsCyrR0hYm2A4/G8DJXDDw=;
 b=0rfmHHax14wRZRlM662YSzsy5kPrnBjF5wmVP7wh1cqbFj/dYyDYuqfqakmk6mZmEEnvKj
 idTPEdzoVGLiP1AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0955C13942;
 Fri, 12 Apr 2024 11:46:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id g5RpOwkfGWbHPQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 12 Apr 2024 11:46:17 +0000
Date: Fri, 12 Apr 2024 13:46:16 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, Li Wang <liwang@redhat.com>,
 Jan Stancek <jstancek@redhat.com>
Message-ID: <20240412114616.GB427746@pevik>
MIME-Version: 1.0
Content-Disposition: inline
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC] Dependency hell on static inline forced by off_t +
 _GNU_SOURCE
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

Hi there,

I have following function:

#include "tst_fs.h"
#include "lapi/fallocate.h"

#define SAFE_FALLOCATE(fd, mode, offset, len) \
	safe_access(__FILE__, __LINE__, (path), (mode), (offset), (len), #mode)

static inline int safe_fallocate(const char *file, const int lineno,
	int fd, int mode, off_t offset, off_t len, const char *smode)
{
	int rval;

	rval = fallocate(fd, mode, offset, len);

	if (rval == -1) {
		if (tst_fs_type_(NULL, ".") == TST_NFS_MAGIC && (errno == EOPNOTSUPP ||
							  errno == ENOSYS)) {
			tst_brk_(file, lineno, TCONF | TERRNO,
					 "fallocate(%d, %s, %ld, %ld) unsupported",
					 fd, smode, (long)offset, (long)len);
		}
		tst_brk_(file, lineno, TBROK | TERRNO,
				 "fallocate(%d, %s, %ld, %ld) failed",
				 fd, smode, (long)offset, (long)len);
	} else if (rval < 0) {
		tst_brk_(file, lineno, TBROK | TERRNO,
			"Invalid fallocate(%d, %s, %ld, %ld) return value %d",
				 fd, smode, (long)offset, (long)len, rval);
	}

	return rval;
}

I have no idea where to put it.
1) fallocate() requires '#define _GNU_SOURCE'
2) fallocate() off_t parameter requires to be in a header (see 9120d8a22 and
3f571da28).
3) Use of tst_fs_type_(NULL, ".") and TBROK etc requires tst_test.h.

I tried to put it into:

a) include/tst_safe_macros_inline.h
Natural choice, but that would require to add to include/tst_test.h:

#ifndef  _GNU_SOURCE
# define _GNU_SOURCE
#endif

because it includes tst_safe_macros.h.  Which means whole new API started to use
_GNU_SOURCE. Would it be OK?  I don't think so.

And #define _GNU_SOURCE into tst_test.c and few other lib/*.c sources (not that dramatic),
because we cannot rely on <fcntl.h> not being loaded before #define _GNU_SOURCE.

b) include/lapi/fallocate.h
I'm not sure if this is against LTP lapi conventions, because it would require
lapi header include tst_test.h due tst_fs_type_ and TBROK. Also, we'd make it
new API dependent (thus use tst_fs_type(".") instead of tst_fs_type_(NULL, ".")

Also we have error on fallocate01.c which is still old API:

from fallocate01.c:103:
../../../../include/tst_test.h:11:3: error: #error Oldlib test.h already included
   11 | # error Oldlib test.h already included

I could rewrite fallocate01.c and fallocate02.c first, so that there is nothing
using old API which also uses include/lapi/fallocate.h.

Another solution would be to pass int parameter fsmagic so that the caller would
have to run tst_fs_type(".") itself.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
