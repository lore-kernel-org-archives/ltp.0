Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DACFC5B572
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 07:55:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 57B5D3C7279
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 09:55:25 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E66A43C0031
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 09:55:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 58A651A001BD
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 09:55:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3C37E3ED5;
 Wed, 19 Aug 2026 07:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787126104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pZ24We+22X1YlEmqT+5xipRz9bBDacNulgsyemDq2ck=;
 b=CPF+OsLvCMMZ6PlDjexSPt56UTS0t/LqPGrgHZ9rJHPdUTy+N+0HhwzdfBxK2eDAvE6J/6
 6TTKpPZy8/+lI6Solc6Qq/sKTnhaYIOdaj5D5xz1y+TcwDd/CLVQuZj47WfltLlqpcRhuL
 f57zUR5oTNgo9KgJkTHH225l2Dh3BPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787126104;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pZ24We+22X1YlEmqT+5xipRz9bBDacNulgsyemDq2ck=;
 b=DPmTd98j4NMD7Mbo6Hl2AbqAtQaGHaBB5aIfKGsMqMVozxL3mInX9NUFLlCJ3+bGG9qToX
 hoGtyPa9+xRKH9Dw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Nx7Fm/Xp";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lna+8YWx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787126100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pZ24We+22X1YlEmqT+5xipRz9bBDacNulgsyemDq2ck=;
 b=Nx7Fm/Xp6LAGmOTRVDLjhRf8u3m6DP9jkClK0GLUKxY6I/omwMJFHH9knDd7R4AiWf1WbN
 phcuHmvi4tOl5r5DpiLCfqRfzPtYKu4c6//6ZNl5Xi0Q0hP4TyAis0a/8naOQEeXy/nfu4
 +SfYSf5UsvBN1J2IC0GiNdsex9o/cDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787126100;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pZ24We+22X1YlEmqT+5xipRz9bBDacNulgsyemDq2ck=;
 b=lna+8YWx239c5f1Yzk/qkftfbDM+J+VRCuwN3qFHStU98Dhsx0YrFoY2w0BssgAE2Z0ZNS
 CshrGJ9rO40Ke9Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B1B0779BE;
 Wed, 19 Aug 2026 07:55:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id p8BgCVRhhWqqUwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 19 Aug 2026 07:55:00 +0000
Date: Wed, 19 Aug 2026 09:55:04 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <aoVhWFX9xD_pkjeI@yuki.lan>
References: <20260818141311.1265557-1-chrubis@suse.cz>
 <CAASaF6zQ=S_Y=X_zkgY1xDR0LTDcUJk19_Aig_4hyLGQvBYHew@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6zQ=S_Y=X_zkgY1xDR0LTDcUJk19_Aig_4hyLGQvBYHew@mail.gmail.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim,yuki.lan:mid];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 3C37E3ED5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 00/31] Add sysfs sanity tests
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> My first thought is whether we really need a separate test for each of these?
> 
> We could have a single test where you just map file patterns to expected format.
> 
> Or extend "read_all_sys", which already tries to read from all /sys files, and
> check that what was read matches expected format.

The main motivation for keeping things separate is that having it all in
one binary makes it unreasonably hard to debug failures. The idea is to
have small, easy to understand and reason about tests.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
