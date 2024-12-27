Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFB0E7718B
	for <ltp@archiver.kernel.org>; Fri, 27 Dec 2024 11:07:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 744763EC83E
	for <ltp@archiver.kernel.org>; Fri, 27 Dec 2024 12:07:10 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C4DD3D9A3A
 for <ltp@lists.linux.it>; Fri, 27 Dec 2024 12:06:54 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 478BE10128F9
 for <ltp@lists.linux.it>; Fri, 27 Dec 2024 12:06:52 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 692E43368A;
 Fri, 27 Dec 2024 11:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735297612;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h+vbvBxa7AUJigBcTbtojc1cUXRE+GF/GWXdbIFbMis=;
 b=zgiSeZdMfZwKRsNdCm6Sa18SiqL0m6NXb3lLJ5uJ6VArT1Peys7uVsYeVGLw96cafUfkcJ
 I7JmMTtG6+nn12ZwHk9vdqBDNidrO1eIo9u8Fsk21KKg1wcRAd91AkaynyQ5VB9KJ+6c5r
 AIJhGMlWsHIWOsUzqcFTUtSzUmMI9gw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735297612;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h+vbvBxa7AUJigBcTbtojc1cUXRE+GF/GWXdbIFbMis=;
 b=cTF3BJZX4oW3+IQ7CyYdHQ+soUMNJuEKRJglemkwlaGbrzwpaYb/0bjV1Wrc791lrHRo5v
 zceHgNwHXLmVUkAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735297612;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h+vbvBxa7AUJigBcTbtojc1cUXRE+GF/GWXdbIFbMis=;
 b=zgiSeZdMfZwKRsNdCm6Sa18SiqL0m6NXb3lLJ5uJ6VArT1Peys7uVsYeVGLw96cafUfkcJ
 I7JmMTtG6+nn12ZwHk9vdqBDNidrO1eIo9u8Fsk21KKg1wcRAd91AkaynyQ5VB9KJ+6c5r
 AIJhGMlWsHIWOsUzqcFTUtSzUmMI9gw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735297612;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h+vbvBxa7AUJigBcTbtojc1cUXRE+GF/GWXdbIFbMis=;
 b=cTF3BJZX4oW3+IQ7CyYdHQ+soUMNJuEKRJglemkwlaGbrzwpaYb/0bjV1Wrc791lrHRo5v
 zceHgNwHXLmVUkAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 216D613A30;
 Fri, 27 Dec 2024 11:06:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /6RFBkyKbmfxXQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 27 Dec 2024 11:06:52 +0000
Date: Fri, 27 Dec 2024 12:06:46 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20241227110646.GF317565@pevik>
References: <20241218184518.16190-1-chrubis@suse.cz>
 <20241218184518.16190-9-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241218184518.16190-9-chrubis@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 08/13] testcases/kernel/mem: Move oom() fucntions
 to oom tests
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

> Functions that are used only by the oom testcases are moved into
> oom/oom.h.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
