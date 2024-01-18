Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9AFC4707B
	for <ltp@archiver.kernel.org>; Thu, 18 Jan 2024 14:23:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A34D53CFCBF
	for <ltp@archiver.kernel.org>; Thu, 18 Jan 2024 15:23:45 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F0943C1DC2
 for <ltp@lists.linux.it>; Thu, 18 Jan 2024 15:23:30 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 037631009BCC
 for <ltp@lists.linux.it>; Thu, 18 Jan 2024 15:23:29 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DF7F7222ED;
 Thu, 18 Jan 2024 14:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705587808;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F9FhmIw+N2WfIR6kw1osrIF3+G9R9lQSIwhmZhrYvp4=;
 b=ZREC05r20qA1JuyLfkgE1L7i+gB/Pl7K793uw/zyZnBTKVi+EMmd9mvR0n8W/yo63SIA5B
 JOtfHo4JBSqAJ7xIuO5bx2nyNnvhbGbCXykzJ1VW2dNLS+2b2Z7r51CCGlB3nmrFOD9Ysd
 8fEhGuZAFCFFbaSOP5KP4nbKFIelaN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705587808;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F9FhmIw+N2WfIR6kw1osrIF3+G9R9lQSIwhmZhrYvp4=;
 b=wGR8+0VrfMPnvVsWAoYKllaBjQ1J3hg41X+Beqn3qmIkFuQ0vmdeGethS8I8+WjskHY25h
 YySNQxw2fb96Q5CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705587807;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F9FhmIw+N2WfIR6kw1osrIF3+G9R9lQSIwhmZhrYvp4=;
 b=iVkFdBXrXS6FBueYs+ZNFRZv1g1dWb94Vyh0PVsLS55WA7B1hWWHn63ZDGBFV5UPG7uXkD
 qZm6vEHzqtpHwU9sg336+76a0ud8WUikf/ndkdiiKZcRUzE2pojgncBU25YoaLSKKCPKtt
 ma4EiDIJ4CudslClYd7Ps4qlhYV+hM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705587807;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F9FhmIw+N2WfIR6kw1osrIF3+G9R9lQSIwhmZhrYvp4=;
 b=vTHQw90t3KljOTcsjhh+l5dtAcRkP7C4ib0MEqrLGjFvNwG80JmstbLlEpZ2wRQ1NJcxKp
 ghH5m4WQDvv0t+CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D281136F5;
 Thu, 18 Jan 2024 14:23:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bFAbFl80qWU4GgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 18 Jan 2024 14:23:27 +0000
Date: Thu, 18 Jan 2024 15:23:25 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240118142325.GB2774347@pevik>
References: <20240111100636.1897637-1-pvorel@suse.cz> <Zakb4b4EKURkixiC@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zakb4b4EKURkixiC@yuki>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-6.30 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 RCVD_COUNT_THREE(0.00)[3]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] keyctl05: Improve the dns_res_payload for
 boundary testing
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
Cc: David Howells <dhowells@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > NOTE: I would wait with this to at least v6.8-rc2. Ideally it should be
> > released, when the commit reaches any stable tree or when v6.8 is released.

> What is the status here? Shall we include this for the January stable
> release? Did the kernel patch got backported to stable kernels allready?

I guess the question was to David (and I prefer him to clarify).

I see patches backported to stable already, e.g. for 6.6.x stable:

$ git show afc360e8a1256acb7579a6f5b6f2c30b85b39301
commit afc360e8a1256acb7579a6f5b6f2c30b85b39301
Author: David Howells <dhowells@redhat.com>
Date:   Sat Dec 9 00:41:55 2023 +0000

    keys, dns: Allow key types (eg. DNS) to be reclaimed immediately on expiry

    [ Upstream commit 39299bdd2546688d92ed9db4948f6219ca1b9542 ]
...

$ git tag --contains afc360e8a1256acb7579a6f5b6f2c30b85b39301
v6.6.10
v6.6.11
v6.6.12
v6.6.9

And Greg had it in his stable-queue [1]:

$ git grep -l 39299bdd2546688d92ed9db4948f6219ca1b9542
releases/5.10.206/keys-dns-allow-key-types-eg.-dns-to-be-reclaimed-imm.patch
releases/5.15.146/keys-dns-allow-key-types-eg.-dns-to-be-reclaimed-imm.patch
releases/6.1.70/keys-dns-allow-key-types-eg.-dns-to-be-reclaimed-imm.patch
releases/6.6.9/keys-dns-allow-key-types-eg.-dns-to-be-reclaimed-imm.patch

(Although it fixes the original addition of the module in 1a4240f4764a from
v2.6.36-rc1, it was probably unportable to 5.4.x and 4.19.x.)

=> I guess we can merge even the fix itself has not been released yet (there is
not even v6.8-rc1, but I suppose it will be tagged before we release LTP).

Credit for the Edward, who suggested to fix keyctl05.c [2]:

	The reason for the failure of add_key() is that the length of the incoming data
	is 5, which is less than sizeof(*v1), so keyctl05.c failed.
	Suggest modifying keyctl05.c to increase the length of the incoming data to 6
	bytes or more.

Suggested-by: Edward Adam Davis <eadavis@qq.com>

Kind regards,
Petr

[1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/
[2] https://lore.kernel.org/all/tencent_CF4FEF0D9B25A08DD7920E5D93DDBC194E07@qq.com/

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
