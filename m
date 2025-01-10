Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F99E77188
	for <ltp@archiver.kernel.org>; Fri, 10 Jan 2025 17:23:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EAD953C4C03
	for <ltp@archiver.kernel.org>; Fri, 10 Jan 2025 18:23:30 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B603E3C2F5B
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 18:23:14 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A3D9B237B72
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 18:23:13 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 87DC21F37C;
 Fri, 10 Jan 2025 17:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736529792;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a/tkFkvYZrnqC3PHo1zWvpFVa22ZEUyGe76Znam0Kbc=;
 b=Pm/D/6085d9XpBIiYbQliyP4SyFw7cVHH2bIB13KDPmo3TiZCrL+9IHDuQAvzcaIUwt2Ek
 XL7pTIO16L6JS7O3nozoCmTrobQCTgqLLaAeHxJZdpMxyyf3Jojon3yJ0CrL88XOt93ud3
 Uzdt9Gf33ciZRFitMvoMvS49j++O2XM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736529792;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a/tkFkvYZrnqC3PHo1zWvpFVa22ZEUyGe76Znam0Kbc=;
 b=doSVLuPrrYnhKZqyIPU3zJL44MBC+q29+xtQR4QJiCUmYPHDTDuBZxMjWWcWbKWU7SfE9A
 mbZaOzzy0pVUrCBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Pm/D/608";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=doSVLuPr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736529792;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a/tkFkvYZrnqC3PHo1zWvpFVa22ZEUyGe76Znam0Kbc=;
 b=Pm/D/6085d9XpBIiYbQliyP4SyFw7cVHH2bIB13KDPmo3TiZCrL+9IHDuQAvzcaIUwt2Ek
 XL7pTIO16L6JS7O3nozoCmTrobQCTgqLLaAeHxJZdpMxyyf3Jojon3yJ0CrL88XOt93ud3
 Uzdt9Gf33ciZRFitMvoMvS49j++O2XM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736529792;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a/tkFkvYZrnqC3PHo1zWvpFVa22ZEUyGe76Znam0Kbc=;
 b=doSVLuPrrYnhKZqyIPU3zJL44MBC+q29+xtQR4QJiCUmYPHDTDuBZxMjWWcWbKWU7SfE9A
 mbZaOzzy0pVUrCBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 26EC413763;
 Fri, 10 Jan 2025 17:23:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aZi6B4BXgWdfKwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 10 Jan 2025 17:23:12 +0000
Date: Fri, 10 Jan 2025 18:23:06 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>, ltp@lists.linux.it,
 Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250110172306.GA429264@pevik>
References: <20250109130032.50480-1-liwang@redhat.com>
 <CAEemH2e2D2xW5zJZsqUo8+f8Ta1GYUKCE4jNeaHECBbVmbY0TA@mail.gmail.com>
 <20250110171304.GB413134@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250110171304.GB413134@pevik>
X-Rspamd-Queue-Id: 87DC21F37C
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH V3] lib: redefine the overall timeout logic of test
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

Hi Li, Cyril,

I also did some tests on cve and syscalls. So far looks good,
testing also net.nfs + aiodio.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
