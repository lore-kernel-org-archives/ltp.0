Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA89C2BD09
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 07:58:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A6DF63D198D
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 09:58:20 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F1893CB579
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 09:58:05 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5A6671410503
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 09:58:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ACEFB21A49;
 Fri, 12 Jul 2024 07:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720771083;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/759WtNk2cVBoxt8rsNOd6tU+ntvq4vtPWUp3I7cV5k=;
 b=wfiH42KAFRji0ce9SrZdjlR4eiAxbrSU+DjYOkdJfwiJmwL0ljJF7ui6RkTQkJAqcU0rbP
 C3zflbISvuNbtsRHM3p+01b7/7CJBHVZVPPD4w6jHwf4wkx02+GwgH45dU1hxx8eRTkfy5
 PxukYqHLsvgx+brjlfXb9Si/TbWmFLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720771083;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/759WtNk2cVBoxt8rsNOd6tU+ntvq4vtPWUp3I7cV5k=;
 b=h0ToJ2OL3PTGHtTKofZMJgWYws969MmP5I6bNJql4m9xilblju6gl8xmOPJe04V8KxEmx7
 L7KxTxyNwk/JgqBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720771083;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/759WtNk2cVBoxt8rsNOd6tU+ntvq4vtPWUp3I7cV5k=;
 b=wfiH42KAFRji0ce9SrZdjlR4eiAxbrSU+DjYOkdJfwiJmwL0ljJF7ui6RkTQkJAqcU0rbP
 C3zflbISvuNbtsRHM3p+01b7/7CJBHVZVPPD4w6jHwf4wkx02+GwgH45dU1hxx8eRTkfy5
 PxukYqHLsvgx+brjlfXb9Si/TbWmFLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720771083;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/759WtNk2cVBoxt8rsNOd6tU+ntvq4vtPWUp3I7cV5k=;
 b=h0ToJ2OL3PTGHtTKofZMJgWYws969MmP5I6bNJql4m9xilblju6gl8xmOPJe04V8KxEmx7
 L7KxTxyNwk/JgqBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D5AE1373E;
 Fri, 12 Jul 2024 07:58:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TCOaIQvikGZ2egAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 12 Jul 2024 07:58:03 +0000
Date: Fri, 12 Jul 2024 09:57:58 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240712075758.GB103986@pevik>
References: <20240711-landlock-v3-0-c7b0e9edf9b0@suse.com>
 <20240711-landlock-v3-5-c7b0e9edf9b0@suse.com>
 <20240711204007.GC85696@pevik>
 <CAEemH2fdFsQqN3a8sZ7+oeU7w3j+X7HdnGa=zC4H4+iXO9YUAw@mail.gmail.com>
 <CAEemH2eYZ05Fn0ZYhpG16UUzYo=F3GKBpYeRG_X2BUdrLbY8PA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eYZ05Fn0ZYhpG16UUzYo=F3GKBpYeRG_X2BUdrLbY8PA@mail.gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; REPLY(-4.00)[];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.992]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 05/11] Add landlock01 test
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

Hi Andrea, Li,

...
> >> First, this fails at least on various kernel versions (tested: Tumbleweed
> >> 6.10.0-rc7-3.g92abc10-default, and SLE15-SP4 5.14.21 with lsm=landlock and
> >> Debian 6.6.15-amd64):

> >> landlock01.c:49: TFAIL: Size is too small expected EINVAL: ENOMSG (42)

> >> Is it a kernel bug or a test bug?


> > You probably need to check the `/usr/include/linux/landlock.h` header file
> > exist,
> > and to see if 'struct landlock_ruleset_attr' contains the new field
> > 'handled_access_net'.

> > If not exist or does not contain that, the test defines 'struct
> > landlock_ruleset_attr'
> > in lapi/landlock.h which contains handled_access_net directly, this is
> > likely the
> > root cause lead test failed on your box.

> And, if the header file does not exist, the macro condition will choose to
> use 'rule_size - 1',
> and that caused the ENOMSG error during test on the newer kernel.

> #ifdef HAVE_STRUCT_LANDLOCK_RULESET_ATTR_HANDLED_ACCESS_NET
>     rule_small_size = rule_size - sizeof(uint64_t) - 1;
> #else
>     rule_small_size = rule_size - 1;
> #endif

> So to keep the kernel-headers and running kernel version consistent should
> be required
> for the landlock01 test. Otherwise the #ifdef possibly won't work correctly.

FYI Having inconsistent kernel headers and running kernel would be a problem for
more LTP tests than just landlock01 (basically many tests which have autotools
check). But this can be problematic for some development (e.g. linux-next).
Therefore we at least assume UAPI headers shouldn't be newer than running
kernel, see https://lore.kernel.org/ltp/ZJP_qPeJ37H4qhEN@yuki/.

> I guess we might have to resolve this on the test side.

Trying to compare versions <linux/version.h> could be used:

#define LINUX_VERSION_CODE 395008
#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + ((c) > 255 ? 255 : (c)))
#define LINUX_VERSION_MAJOR 6
#define LINUX_VERSION_PATCHLEVEL 7
#define LINUX_VERSION_SUBLEVEL 0

We already use KERNEL_VERSION() in kdump and device-drivers tests.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
