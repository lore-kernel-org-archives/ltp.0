Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C287BC43458
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 05:42:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D853F3E215B
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 07:42:06 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A6D93E20D5
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 07:41:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F0650200939
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 07:41:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8FAAE3E21;
 Tue, 14 Jul 2026 05:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784007710;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xR/SgIjZS+wQ+UoFCGHfox13kayTf7LJb61KLbgCHpw=;
 b=Ff5QYxoXmlpBOflKwIRj+NAecD/BNPmYyOEirUAaEsdf7qM7siBupInO+dIEjCNgfR54Me
 KUfpr9Cqm68w7n39NhWDZcDpIykYLwYcG1pyrT4YfjABvANr1JI4uPTmyPL47H082amlPY
 UNSWNjPmvhJT5Nx0/cMF0XtbxniXTZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784007710;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xR/SgIjZS+wQ+UoFCGHfox13kayTf7LJb61KLbgCHpw=;
 b=XcFOQockonmZxSVqv42FNASCsr8Mg5+7SupQ1G4VOf7MzcFjPBN0PVyKyNcncrIKEcw0dl
 bEXqYgR2vEKVcdBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784007710;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xR/SgIjZS+wQ+UoFCGHfox13kayTf7LJb61KLbgCHpw=;
 b=Ff5QYxoXmlpBOflKwIRj+NAecD/BNPmYyOEirUAaEsdf7qM7siBupInO+dIEjCNgfR54Me
 KUfpr9Cqm68w7n39NhWDZcDpIykYLwYcG1pyrT4YfjABvANr1JI4uPTmyPL47H082amlPY
 UNSWNjPmvhJT5Nx0/cMF0XtbxniXTZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784007710;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xR/SgIjZS+wQ+UoFCGHfox13kayTf7LJb61KLbgCHpw=;
 b=XcFOQockonmZxSVqv42FNASCsr8Mg5+7SupQ1G4VOf7MzcFjPBN0PVyKyNcncrIKEcw0dl
 bEXqYgR2vEKVcdBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79685779AE;
 Tue, 14 Jul 2026 05:41:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 41RoHB7MVWpJCgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 14 Jul 2026 05:41:50 +0000
Date: Tue, 14 Jul 2026 07:41:49 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20260714054149.GA42742@pevik>
References: <20260713155739.48823-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260713155739.48823-1-mdoucha@suse.cz>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify25: Add CVE reference and include it in
 CVE runfile
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

Hi Martin,

> The kernel bug tested by fanotify25 is assigned CVE 2023-52879. Add
> CVE reference and git reference for the kernel fix. Also add the test
> to the CVE runfile.

Thanks, merged!

...
>  /*\
> + * CVE-2023-52879
> + *
>   * Verify that :manpage:`fanotify(7)` monitoring can be applied to the tracing
> - * filesystem and write events will be correctly delivered.
> + * filesystem and write events will be correctly delivered. NULL pointer
> + * dereference fixed in:
> + *
> + * commit bb32500fb9b78215e4ef6ee8b4345c5f5d7eafb4
> + * Author: Steven Rostedt (Google) <rostedt@goodmis.org>
> + * Date:   Tue Oct 31 12:24:53 2023 -0400
> + *
> + * tracing: Have trace_event_file have ref counters

Using this form in /*\ results in ugly inline string in the test catalog:
commit bb32500fb9b78215e4ef6ee8b4345c5f5d7eafb4 Author: Steven Rostedt (Google) <rostedt@goodmis.org> Date: Tue Oct 31 12:24:53 2023 -0400


I dared to convert this to inline + add kernel version.

...
+ * dereference fixed in kernel 6.7:
+ * bb32500fb9b7 ("tracing: Have trace_event_file have ref counters")

If we really see a benefit of having author and date in the docs, it'd be better
to have it in C comments /* */ which aren't generated in the test catalog. Or,
we could shift it so that it is preformatted (<pre>...</pre>). Or we could use
sphinx automarkup extension to detect this form and format it as is (not inline)
+ use link.

...
> @@ -118,6 +127,11 @@ static struct tst_test test = {
>  	.needs_kconfigs = (const char *[]) {
>  		"CONFIG_TRACING",
>  		NULL
> +	},
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "bb32500fb9b7"},
And I should have changed the hash to the longer one:
bb32500fb9b78215e4ef6ee8b4345c5f5d7eafb4

FYI we have decided keep in the description the long the short variant (with
strlen) to minimize possibility of git hash collision.  I plan to convert all
with script/agent.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
