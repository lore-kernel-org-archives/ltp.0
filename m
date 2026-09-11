Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BDEC88E53
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 08:59:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 02A8E3E72B5
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 10:59:01 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 570093E53C2
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 10:58:41 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id ABEEC600707
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 10:58:40 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E2AE121D1D;
 Fri, 11 Sep 2026 08:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789117115;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NEhlXAVmuFUUnvnc5jt5x4fcqF3IEndpxSdwxlAeMVQ=;
 b=P+miydjhN8R/I/Q1ywOU6gSpI221CKspOC+0bz6LCO4MHEvudVHb3bIsAyGHH/Jb6MuUdQ
 F6tCTJmJU2yTpKevETZYblDz/FXi/GuiXhKT9GWO6OJQCNqUnSPK1Ex8vXGJfTRGgIpvb5
 GcAlu8kP/OASXjb09AMw0qi6yhLrjxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789117115;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NEhlXAVmuFUUnvnc5jt5x4fcqF3IEndpxSdwxlAeMVQ=;
 b=D/VLh/SBLcnCPB3Le347bsBqsG4fYjZGbI6XUfl7inMU0sQ7lvicOajD+fPr4NpmhkKsV2
 hjK9s906yx6RTgAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WyY74Fid;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zajMe5Rr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789117110;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NEhlXAVmuFUUnvnc5jt5x4fcqF3IEndpxSdwxlAeMVQ=;
 b=WyY74FidsY159xgbyE5NL70tozskkUkHFhtDUVCIvFK0PqFGJummEEGvkcWKY3T/0FA/j9
 Sx2c6chguVQVcO0BI/x4a9tw7RupqZx1fZKI2kiFRFIm1AppQksacn2jtUxTITBnJCxmcg
 eSlbOjvfEgd7h88zUfT61xs9Cd9P5nU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789117110;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NEhlXAVmuFUUnvnc5jt5x4fcqF3IEndpxSdwxlAeMVQ=;
 b=zajMe5RrYF85VTHvUlmeohUASd+s1wUTJMx8ASpqQSctjtsxoQv2FnK8QbMvh0BBR7xzju
 yNOm3mX/p0PggoAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8083F13715;
 Fri, 11 Sep 2026 08:58:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /+43HrbCo2qyJQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 11 Sep 2026 08:58:30 +0000
Date: Fri, 11 Sep 2026 10:58:29 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260911085829.GA1435339@pevik>
References: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
 <20260904-keyctl_coverage-v2-1-43b78b15ef9f@suse.com>
 <aqOuUYRACyd8JwIF@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aqOuUYRACyd8JwIF@yuki.lan>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E2AE121D1D
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 01/33] lapi/keyctl.h: Add fallback definitions
 for extended ops
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > --- a/m4/ltp-keyutils.m4
> > +++ b/m4/ltp-keyutils.m4
> > @@ -7,4 +7,17 @@ AC_DEFUN([LTP_CHECK_KEYUTILS_SUPPORT], [
> >  	AC_CHECK_LIB([keyutils], [add_key],
> >  	[AC_DEFINE(HAVE_LIBKEYUTILS, 1, [Define to 1 if you have libkeyutils installed.])
> >  	      AC_SUBST(KEYUTILS_LIBS, "-lkeyutils")])
> > +
> > +	LTP_KEYCTL_HEADERS=""
> > +
> > +	if test "x$ac_cv_header_keyutils_h" = "xyes" && \
> > +	   test "x$ac_cv_lib_keyutils_add_key" = "xyes"; then
> > +		LTP_KEYCTL_HEADERS="#include <keyutils.h>"
> > +	elif test "x$ac_cv_header_linux_keyctl_h" = "xyes"; then
> > +		LTP_KEYCTL_HEADERS="#include <linux/keyctl.h>"
> > +	fi
> > +
> > +	AC_CHECK_TYPES([struct keyctl_dh_params, struct keyctl_kdf_params,
> > +			struct keyctl_pkey_query, struct keyctl_pkey_params],,,
> > +			[$LTP_KEYCTL_HEADERS])
> >  ])

> Maybe we can simplify this to just linux/keyctl.h. The linux uapi header
> has been quite stable for nearly a decade.

I was going to write the same. I checked that:

struct keyctl_dh_params was added in ddbb411487243 => v4.7-rc1.
struct keyctl_kdf_params was added in f1c316a3ab9d2 => v4.12-rc1
struct keyctl_pkey_query and keyctl_pkey_params were added in 00d60fd3b9321 => v4.20-rc1

And please move it to configure.ac.
(Ideally we would slowly simplify and move all m4/ltp-*.m4 to configure.ac.)

Anyway, very nice patchset, thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
