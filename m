Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CABC79F9F
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 13:03:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F2173E9283
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 15:03:09 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E73BF3C0E10
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 15:02:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 11E3020014D
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 15:02:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A65BB1FCB8;
 Thu, 10 Sep 2026 13:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789045368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gu0sQQhcMZcqZwWyue+5+iS/0voStiRNvUbR3+cwNtQ=;
 b=CZi7pDCIA/FZ95gj7ShXJ328RYwWxtT2bCJF2hmZgzpUeNQTpwZMySbZEr2ptbxDpOvMi7
 SxkUbQCh+uTiWFQThaVtLV7tQ+eAwk5EYesHDptiAxYcpNoDkOWiKuibIohWte0oqlINmD
 XQDuAeGY05z9es8zgn1QCrypt+rDoTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789045368;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gu0sQQhcMZcqZwWyue+5+iS/0voStiRNvUbR3+cwNtQ=;
 b=HGYl20ftlWZylq9uUTmI0YBowtxtZ+zqaCOFJxkFum2VQWTJc9MGthednwBroHTjI4OSwP
 11qh6LutBGl9KdDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HL3Dlb4k;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NNlGOQ7L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789045364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gu0sQQhcMZcqZwWyue+5+iS/0voStiRNvUbR3+cwNtQ=;
 b=HL3Dlb4kL0qYFPn3dD+oawOe54mzLJ2jbJxOmF8xqG+1Xng1Qvwgsp+xNVSFuhj9et4cGl
 ZPY0edHZmdx2CkIJ0eGU2R+F7h4g8vPqDa5+v7p/1VNiZnsmuWSoie7V6/lJebJqphGYNs
 QhBUca8ajo1ex7F892y8FmspR+wWoxs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789045364;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gu0sQQhcMZcqZwWyue+5+iS/0voStiRNvUbR3+cwNtQ=;
 b=NNlGOQ7LD9GhQiIwh0lbyiqJzGERsEas4TEUSKxBMEMgWxmwduZswnXM76dvxMjmgQUlmx
 wRucIViCLSH0/zBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65FBD1326D;
 Thu, 10 Sep 2026 13:02:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZyzSGHSqomrwcwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 10 Sep 2026 13:02:44 +0000
Date: Thu, 10 Sep 2026 15:02:50 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aqKqev1nXfieuJK4@yuki.lan>
References: <aqKmzG1kexhUuv1c@yuki.lan>
 <6aa2aa04.c9eda3e9.76660.270b@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6aa2aa04.c9eda3e9.76660.270b@mx.google.com>
X-Rspamd-Queue-Id: A65BB1FCB8
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v10 3/3] coredump02: Verify ELF structure and notes
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > AFAIK the 4 byte padding may happen on x86_64 only for a historical
> > reasons and x86_64 is at the same time capable of handling unaligned
> > access. AArch64 should have 8 byte padding.
> 
> yes, it happens only in x86_64, but I wouldn't rely too much on unaligned
> access handling if it's just few bytes copy away. code is 100% stable like
> this.

It looks like working around potentional bugs rather than anything else.
The elements should be aligned so that they could be accessed on the
targed architecture.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
