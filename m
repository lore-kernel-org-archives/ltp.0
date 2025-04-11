Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C4AC36010
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 11:51:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A206F3CB5C6
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 13:51:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 69E533CAE86
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 13:51:05 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 43999200965
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 13:51:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B3A1D1F461;
 Fri, 11 Apr 2025 11:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744372263;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m2I+jtM6xIslr5EfKPrg9hP7laaMWbnrz+AjxvLnqcE=;
 b=wHxwOibObqOVvdL3zkT/W3HWeuo3ynIuTCHkkgSCRJhLZ1CSwCIlhr9lo3QR+JLeBxVtRn
 aM+UtX7/RPLHHxmXrtqLB6Q3wrjsFKhlpzrc2gIg4K9Ij98QosmRPXMiocq475sMPMa30F
 41XpFsEDPrO9i8bcA0i6J79zkUTWZ5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744372263;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m2I+jtM6xIslr5EfKPrg9hP7laaMWbnrz+AjxvLnqcE=;
 b=nXmJIkJ3NQDi4Thd1E0xcIJY4jMUGo3AuAtMptcrJbXcH9B/HozmmkH2teaPLh9WYHQ9tB
 ++cQ7kJWxeoOJvCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744372263;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m2I+jtM6xIslr5EfKPrg9hP7laaMWbnrz+AjxvLnqcE=;
 b=wHxwOibObqOVvdL3zkT/W3HWeuo3ynIuTCHkkgSCRJhLZ1CSwCIlhr9lo3QR+JLeBxVtRn
 aM+UtX7/RPLHHxmXrtqLB6Q3wrjsFKhlpzrc2gIg4K9Ij98QosmRPXMiocq475sMPMa30F
 41XpFsEDPrO9i8bcA0i6J79zkUTWZ5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744372263;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m2I+jtM6xIslr5EfKPrg9hP7laaMWbnrz+AjxvLnqcE=;
 b=nXmJIkJ3NQDi4Thd1E0xcIJY4jMUGo3AuAtMptcrJbXcH9B/HozmmkH2teaPLh9WYHQ9tB
 ++cQ7kJWxeoOJvCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D03013886;
 Fri, 11 Apr 2025 11:51:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xJ1ZIScC+WfOVgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 11 Apr 2025 11:51:03 +0000
Date: Fri, 11 Apr 2025 13:50:58 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ricardo =?utf-8?B?Qi4gTWFybGnDqHJl?= <rbm@suse.com>
Message-ID: <20250411115058.GA323772@pevik>
References: <20250408114432.220841-1-pvorel@suse.cz>
 <D91D850OFM7I.2P5YPKY3FWCG8@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <D91D850OFM7I.2P5YPKY3FWCG8@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] sphinx: Update to 7.2.6, python 3.12,
 ubuntu-24.04
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

Hi Ricardo,

...
> > -    python: "3.6"
> > +    python: "3.12"

> Can you please update the docs?

> https://github.com/linux-test-project/ltp/blob/master/doc/developers/documentation.rst?plain=1#L36

Good point, thanks! I'm going to merge with the change below.
I'll merge in few hours, to give you and Andrea time to have a look.

Kind regards,
Petr

> Thanks,
> -	Ricardo.

+++ doc/developers/documentation.rst
@@ -33,9 +33,9 @@ Once the procedure has been completed, documentation will be visible at
 
 .. warning::
 
-    The current :master:`.readthedocs.yml` workflow is using ``Python 3.6`` because
-    older Python versions were causing issues. No other version has been tested,
-    but it should work anyway.
+    Documentation requires ``Python >= 3.6``.
+    The current :master:`.readthedocs.yml` workflow is using ``Python 3.12``,
+    it is tested in GitHub Actions :master:`.github/workflows/ci-sphinx-doc.yml`.
 
 Validating spelling
 ~~~~~~~~~~~~~~~~~~~

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
