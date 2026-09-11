Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59887C88E53
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 07:31:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 95AD33E9210
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 09:31:49 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 35DC23C876A
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 09:31:34 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 853E41A00A3A
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 09:31:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 97DF521D0B;
 Fri, 11 Sep 2026 07:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789111887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Duyp+9psgbPVzJ6v192r9oFXgfbfILnNJE5XNDemoyU=;
 b=NnGnjGCS070M7kXBURHgFyqvjwtrMIqQjE0GJ9lyyimK8poWCUyDBtrQgd9qhd9MV2wZ8K
 wyMzREB5FhGBvfVtZ4r1w739y5SToYMc2+UmAUb5ZxwpKPHnmP/DMuoeGpux4Xcpg+5wqE
 uZqKfXpLVDiIp0Ic+OwbTtBpCWwAa0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789111887;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Duyp+9psgbPVzJ6v192r9oFXgfbfILnNJE5XNDemoyU=;
 b=ANv+d5JuqxCysAzkc+DLDy4L7WtJYYKhfZSbe8uf84SREQqqq98lwgWeTtQ679pmvSmjyA
 L5gCYuduH/CIzRDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=u77IhbDr;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="WmindHi/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789111883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Duyp+9psgbPVzJ6v192r9oFXgfbfILnNJE5XNDemoyU=;
 b=u77IhbDruQXyFLJr+Phvz6FzZ2nWlC4iBz1OQoaxFn7oB/7RfkC9tA2Wv1JPTa6MrV3S/s
 tEIsHRqCe5knIH9jt4kUwUROC38LfhHozfzKfXB/rkoYXz7/ywEXnIzawfTIip+wmKXOFE
 z45FUdRaJRlanuOoNM1iDw5miXIgBm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789111883;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Duyp+9psgbPVzJ6v192r9oFXgfbfILnNJE5XNDemoyU=;
 b=WmindHi/gYGbi7x8YzqWmn/GdwX29YH5RnD4sXuvec3w8yljWnmlzd1bN/GLQ+WBOVKtic
 AhQRHMYqp1vxT9Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66AA813715;
 Fri, 11 Sep 2026 07:31:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IzIKGUuuo2qjSgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 11 Sep 2026 07:31:23 +0000
Date: Fri, 11 Sep 2026 09:31:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aqOuUYRACyd8JwIF@yuki.lan>
References: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
 <20260904-keyctl_coverage-v2-1-43b78b15ef9f@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260904-keyctl_coverage-v2-1-43b78b15ef9f@suse.com>
X-Rspamd-Queue-Id: 97DF521D0B
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,yuki.lan:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> --- a/m4/ltp-keyutils.m4
> +++ b/m4/ltp-keyutils.m4
> @@ -7,4 +7,17 @@ AC_DEFUN([LTP_CHECK_KEYUTILS_SUPPORT], [
>  	AC_CHECK_LIB([keyutils], [add_key],
>  	[AC_DEFINE(HAVE_LIBKEYUTILS, 1, [Define to 1 if you have libkeyutils installed.])
>  	      AC_SUBST(KEYUTILS_LIBS, "-lkeyutils")])
> +
> +	LTP_KEYCTL_HEADERS=""
> +
> +	if test "x$ac_cv_header_keyutils_h" = "xyes" && \
> +	   test "x$ac_cv_lib_keyutils_add_key" = "xyes"; then
> +		LTP_KEYCTL_HEADERS="#include <keyutils.h>"
> +	elif test "x$ac_cv_header_linux_keyctl_h" = "xyes"; then
> +		LTP_KEYCTL_HEADERS="#include <linux/keyctl.h>"
> +	fi
> +
> +	AC_CHECK_TYPES([struct keyctl_dh_params, struct keyctl_kdf_params,
> +			struct keyctl_pkey_query, struct keyctl_pkey_params],,,
> +			[$LTP_KEYCTL_HEADERS])
>  ])

Maybe we can simplify this to just linux/keyctl.h. The linux uapi header
has been quite stable for nearly a decade.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
