Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD1AE77180
	for <ltp@archiver.kernel.org>; Tue, 10 Dec 2024 12:16:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E8D723E2D2C
	for <ltp@archiver.kernel.org>; Tue, 10 Dec 2024 13:16:01 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B68883E8D45
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 13:15:44 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3F79E663F95
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 13:15:43 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2A8A41F395;
 Tue, 10 Dec 2024 12:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733832943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SE6sdXUp92kVfdcqD0HbHop14JEM9SC7p8+h4bTSQYU=;
 b=EBvYyTJfA0y8sZhkYbLdcodT+WHTzXrbyn/0cL+gt++Ql6a1SjPx9Vjsrr7ox+tz34CEvd
 95M4ctqePZnDJmL07BaTV0IsywmxRob35mYi54xfnU1Jfcv6grnd94IJCPBx/SsvV1uUtO
 k0R6Ib6pFimiPj2MzUqHWIHE9quPAlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733832943;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SE6sdXUp92kVfdcqD0HbHop14JEM9SC7p8+h4bTSQYU=;
 b=9ezIFBoiZnSOOB61abzJwWZ5/YOqySEmY4bzPpy0p2pQlgRyH/t9hc0olcQUELJmNKdruK
 gLaPC5mmHj19egDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EBvYyTJf;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9ezIFBoi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733832943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SE6sdXUp92kVfdcqD0HbHop14JEM9SC7p8+h4bTSQYU=;
 b=EBvYyTJfA0y8sZhkYbLdcodT+WHTzXrbyn/0cL+gt++Ql6a1SjPx9Vjsrr7ox+tz34CEvd
 95M4ctqePZnDJmL07BaTV0IsywmxRob35mYi54xfnU1Jfcv6grnd94IJCPBx/SsvV1uUtO
 k0R6Ib6pFimiPj2MzUqHWIHE9quPAlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733832943;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SE6sdXUp92kVfdcqD0HbHop14JEM9SC7p8+h4bTSQYU=;
 b=9ezIFBoiZnSOOB61abzJwWZ5/YOqySEmY4bzPpy0p2pQlgRyH/t9hc0olcQUELJmNKdruK
 gLaPC5mmHj19egDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0DC8613A15;
 Tue, 10 Dec 2024 12:15:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7UUDA+8wWGekaAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 10 Dec 2024 12:15:43 +0000
Date: Tue, 10 Dec 2024 13:15:58 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Xiubo Li <xiubli@redhat.com>
Message-ID: <Z1gw_mNXF7KIzklK@yuki.lan>
References: <20241119101357.951813-1-xiubli@redhat.com>
 <Z0mXHSnqmstCIMrF@yuki.lan>
 <a32c6381-8779-4dc5-878b-a46bff6454d6@redhat.com>
 <Z02PZRGzw5qM3z0w@yuki.lan>
 <2779c1f7-28fd-415f-a016-da3aa077659b@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2779c1f7-28fd-415f-a016-da3aa077659b@redhat.com>
X-Rspamd-Queue-Id: 2A8A41F395
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,yuki.lan:mid];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] doc: correct the build steps for
 open_posix_testsuite
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > The top level configure script configures the open posix testsuite, but
> > you have to pass the --with-open-posix-testsuite flag to it.
> >
> > Or you can run the open posix configure from the open posix directory.
> >
> Yeah, this looks better.
> 
> Does it make sense to fix the doc about this ? If so I will send the V3.

Yes please (and sorry for the delayed response).

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
