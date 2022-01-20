Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476CBC433EF
	for <ltp@archiver.kernel.org>; Thu, 20 Jan 2022 13:20:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8FD0C3C96B1
	for <ltp@archiver.kernel.org>; Thu, 20 Jan 2022 14:20:19 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 78EB63C95E4
 for <ltp@lists.linux.it>; Thu, 20 Jan 2022 14:20:09 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 98038600A85
 for <ltp@lists.linux.it>; Thu, 20 Jan 2022 14:20:08 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CB7C0218F9;
 Thu, 20 Jan 2022 13:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642684807;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9ZI8MfddGSPil4FVvWXaBsmiGsO5gHByhFlEB9G5Eg8=;
 b=Pvc+P3blXebGx+PSJtnLd10Nw5j6B8VCGRNnn31l/RFYN5+3zYaztz0krP1Cwxczbpe6zD
 y0e+JyN8pxKSe43L/52lOCC6IjHV0Y7LpQCD1nE94jKWby55khx6pGoRQ6RZ8O4tjrF1SS
 fAuQA+0ukR+1fgrAuR7iekO1kJi9bf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642684807;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9ZI8MfddGSPil4FVvWXaBsmiGsO5gHByhFlEB9G5Eg8=;
 b=J5CiA5iE0OIJcDwHuwhTPYR6qyooUAytrzezI7W9WPxQ5v3L3OdiY+TQg8x7usfmuD5Ja7
 R9fwTQGxUG0pmJBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A9BF013BCC;
 Thu, 20 Jan 2022 13:20:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7xqMJ4dh6WGwdwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 20 Jan 2022 13:20:07 +0000
Date: Thu, 20 Jan 2022 14:20:05 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YelhhSlDCnqt5nsV@pevik>
References: <20220120124023.17469-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220120124023.17469-1-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] configure: Fix summary for --disable-metadata
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

Hi Cyril,

> This changes the m4/ltp-docparse.m4 to skip the detection and sets the
> corresponding variables so that we get correct summary when the metadata
> are disable by users.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

LGTM, I'm for applying this before release.

./configure --disable-metadata-pdf --disable-metadata-html
...
configure: metadata generation disabled
...
METADATA
metadata generator: detect
HTML metadata: no
PDF metadata: no

=> this case is not handled well. Output during configure ("metadata generation
disabled") is IMHO more descriptive than our summary - "detect" can be confusing
for people. We could further tweak configure.ac:

@@ -43,6 +43,9 @@ fi

 if test "x$enable_metadata_html" = xyes -o "x$enable_metadata_pdf" = xyes; then
        AX_PROG_PERL_MODULES(Cwd File::Basename JSON LWP::Simple)
+else
+       with_metadata=no
+       with_metadata_generator=none
 fi

---
=> would lead to:
METADATA
metadata generator: none
HTML metadata: no
PDF metadata: no

But instead of that I'd also adjusted the summary to print "metadata disabled"
to reflect the reality, i.e. apply also my patch
https://lore.kernel.org/ltp/20220114125513.895-1-pvorel@suse.cz/

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
