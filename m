Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9161E606A319
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 15:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=lD7PUUta;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3bGj+/J2;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=ePY/T+Fz;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Gyn5Kyz/
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 52BA63D3A84
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 17:33:09 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 855CF3D266C
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 17:32:54 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B5B141A01143
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 17:32:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CED6122189;
 Thu, 22 Oct 2026 15:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1792683172;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i7jMmAXKXU3ZgQ2x/1xI6Oz+VIonwQQf2lrgWBYRetI=;
 b=lD7PUUtaSFFnUtlkYdZPIHdoPMqvvdYPklyxLoRoxmaD3hkoXkmUESM8rjuUmOUb/eJghT
 SKVmno4Qnc/coslpDywcHBEwOx2DNruZ+v1mcRdcGoJMtcEF33l66tmgW7VzszKoQRJLOb
 qy8zbAO3F0Wn3RFslLhUg3PoS3JVK5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1792683172;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i7jMmAXKXU3ZgQ2x/1xI6Oz+VIonwQQf2lrgWBYRetI=;
 b=3bGj+/J2vhjEh3aVdK9/faft/6tvJZCaW7mRNJ+aClti6nqA32kDmjE0oX65tSH7HVTwo7
 JoIZFaE5VJu61uAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1792683171;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i7jMmAXKXU3ZgQ2x/1xI6Oz+VIonwQQf2lrgWBYRetI=;
 b=ePY/T+FzMuMU9wVDIS5V3okHiIq/K1jFcwyVuX/J2U6WXLF7j5JJkO3NyiNn9aZwljPlD+
 SBzFFLnQs5UxrWRE56m7MCraI9LQvd3WsHuuNVxKPwsNxSxFfcOvdocWjyeXUlq29sJnC7
 UOoqtV9dHgIG6hd5V1oovrtUTNTHOew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1792683171;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i7jMmAXKXU3ZgQ2x/1xI6Oz+VIonwQQf2lrgWBYRetI=;
 b=Gyn5Kyz/E+010i9NG5hFmQjesweQpIxmb9yrTzZKVWPqldPO2L2u+fGE9ceKsABK2eiZJC
 NfEVtMupD5YU4cAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 522DD134E6;
 Thu, 22 Oct 2026 15:32:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UUG4BqMs2moObQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 22 Oct 2026 15:32:51 +0000
Date: Thu, 22 Oct 2026 17:32:49 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>, ltp@lists.linux.it,
 Andrea Cervesato <andrea.cervesato@suse.com>,
 Martin Doucha <martin.doucha@suse.com>
Message-ID: <20261022153249.GB405225@pevik>
References: <20261022022824.19735-1-wegao@suse.com>
 <20261022022824.19735-2-wegao@suse.com>
 <20261022152542.GA405225@pevik>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261022152542.GA405225@pevik>
X-Spam-Level: 
X-Spamd-Result: default: False [-12.50 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -12.50
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v16 1/2] lib: New library function tst_get_free_uid
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Reply-To: Petr Vorel <pvorel@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Wei,

> > +uid_t tst_get_free_uid_(const char *file, const int lineno, uid_t skip);
> > +
> > +/**
> > + * tst_get_free_uid() - Find a UID not assigned to any user.
> > + * @skip: UID value to skip (pass 0 to skip none).
> > + *
> > + * Scans the password database for the first unused UID starting
> > + * from 1, skipping @skip. Calls tst_brk(TBROK) if no free UID
> > + * is found or a lookup error occurs.
> > + *
> > + * Return: An unused uid_t value.
> > + */
> > +#define tst_get_free_uid(skip) tst_get_free_uid_(__FILE__, __LINE__, (skip))
> > +
> >  /*
> >   * Find unassigned gid. The skip argument can be used to ignore e.g. the main
> >   * group of a specific user in case it's not listed in the group file. If you
> > diff --git a/lib/tst_uid.c b/lib/tst_uid.c
> > index b0b087362..47c267bc4 100644
> > --- a/lib/tst_uid.c
> > +++ b/lib/tst_uid.c
> > @@ -5,6 +5,7 @@

> >  #include <sys/types.h>
> >  #include <grp.h>
> > +#include <pwd.h>
> >  #include <errno.h>

> >  #define TST_NO_DEFAULT_MAIN
> > @@ -12,6 +13,33 @@
> >  #include "tst_uid.h"

> >  #define MAX_GID 32767
> > +#define MAX_UID 32767
> > +
> > +uid_t tst_get_free_uid_(const char *file, const int lineno, uid_t skip)
> > +{
> > +	uid_t ret;
> > +
> > +	for (ret = 1; ret < MAX_UID; ret++) {
> > +		if (ret == skip)
> > +			continue;
> > +
> > +		errno = 0;
> > +		if (getpwuid(ret))
> > +			continue;


> If you don't mind I'd prefer to use the same approach which is on
> tst_get_free_gid_(), e.g. set errno first:

> 	errno = 0;

> 	for (ret = 1; ret < MAX_UID; ret++) {
> 		if (ret == skip || getpwuid(ret))
> 			continue;

> Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Other than that LGTM.

> Cc Martin in case he wants to add his ack before I merge.

> Kind regards,
> Petr

> > +
> > +		if (errno == 0 || errno == ENOENT || errno == ESRCH) {
> > +			tst_res_(file, lineno, TINFO,
Actually also here TERRNO probably makes sense.

I suggest to merge with following diff:

+++ lib/tst_uid.c
@@ -19,16 +19,14 @@ uid_t tst_get_free_uid_(const char *file, const int lineno, uid_t skip)
 {
 	uid_t ret;
 
-	for (ret = 1; ret < MAX_UID; ret++) {
-		if (ret == skip)
-			continue;
+	errno = 0;
 
-		errno = 0;
-		if (getpwuid(ret))
+	for (ret = 1; ret < MAX_UID; ret++) {
+		if (ret == skip || getpwuid(ret))
 			continue;
 
 		if (errno == 0 || errno == ENOENT || errno == ESRCH) {
-			tst_res_(file, lineno, TINFO,
+			tst_res_(file, lineno, TINFO | TERRNO,
 				"Found unused UID %d", (int)ret);
 			return ret;
 		}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
