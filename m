Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 173BDC98302
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 16:16:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 788B73E6CF0
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 18:16:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 11E393E1B18
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 18:15:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7A60260005A
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 18:15:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ABBEB1FB8D;
 Tue, 22 Sep 2026 16:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790093741;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BqLi6gT9ZdWoi2i1Xbhop2tFw/tKLSUjtrFo7cafj8c=;
 b=mBv3mo9JRVnQqxVBbY6K7H1cRJReJtGe+B1MFH40B6X5Eu96XlZNLa19nfSZ7Kk4aJu67+
 7t33d6Ec00fauK8rcxOb5KYSCsn6gW3Rq087HtwmZuD7kxOdQaMcv7Pj065ZD6Dzclcu4J
 bMSXIYkLosC5f8hXHEZ7eNFVUyA+kMU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790093741;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BqLi6gT9ZdWoi2i1Xbhop2tFw/tKLSUjtrFo7cafj8c=;
 b=c99dMbZUhNImyTjRCKcEjjKbbNnQVS36ecO3DIFWeTVVhKejTo45ckcAQXb5LsinacUH59
 wszJjxykXDTe6UAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790093737;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BqLi6gT9ZdWoi2i1Xbhop2tFw/tKLSUjtrFo7cafj8c=;
 b=irQreA6Kh4BMLRRmdM2SupAyeZtul7Jgqmt4c0DtZf0gNst3U0eb0cqB7Z1ZgkAaxYUfT5
 xIXhXIkcEMNUNM3rwGGdD+Ui2QfAQeCQECTFleO+FT4PotWsN2mgwCnKhfn7YUUCOGohaB
 fOy00ozVVwJHLUl8e3mX5YbFJFPmdtw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790093737;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BqLi6gT9ZdWoi2i1Xbhop2tFw/tKLSUjtrFo7cafj8c=;
 b=7QukoCHkq8iD4oSq4i5afYsVYJhcl4HhXBkn+jAYWuuOlFJYCuSAdfYnurszdqENsMpYe+
 4ZzIvahxFKVgE+Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 638C4132D3;
 Tue, 22 Sep 2026 16:15:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Tj6LC6mpsmppLQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 22 Sep 2026 16:15:37 +0000
Date: Tue, 22 Sep 2026 18:15:35 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it,
 Li Wang <li.wang@linux.dev>, Avinesh Kumar <avinesh.kumar@suse.com>,
 Wei Gao <wegao@suse.com>, Martin Doucha <mdoucha@suse.cz>,
 Andrea Cervesato <andrea.cervesato@suse.com>,
 linuxtestproject.agent@gmail.com
Message-ID: <20260922161535.GB2272582@pevik>
References: <20260922095126.2169599-1-pvorel@suse.cz>
 <arKIz5Oygb57INup@yuki.lan> <20260922154811.GD2205904@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260922154811.GD2205904@pevik>
X-Spamd-Result: default: False [-2.00 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; TAGGED_RCPT(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[suse.cz,lists.linux.it,linux.dev,suse.com,gmail.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[8]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] keyctl: Vendor struct keyctl_dh_params
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Hi Cyril,

> thank you, I tested and dared to merge this one.
I'm sorry for the noise, wrong thread. I merged "[v2] tst_kconfig: Add CONFIG_*
mappings for keyctl tests".

Kind regards,
Petr

[1] https://patchwork.kernel.org/project/ltp/patch/20260922151111.4099859-1-chrubis@suse.cz/

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
