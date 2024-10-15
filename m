Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93483CFC280
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 09:52:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA6293C66F3
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 11:52:15 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EBD6C3C223C
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 11:51:58 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 164501A007E9
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 11:51:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0A62E1FB82;
 Tue, 15 Oct 2024 09:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728985917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jy5flH+B78Gx1LU5yQ52ylhY7WaxgPu5PRIW7sUbJTI=;
 b=ohCpwl0MRPHsBPBdXSpW4AOsQBAmAqEDfen8Cy/G45lyBPf/iu/50yzmfubUn1a/QkX1Nc
 Tw9jAzDAmMu96L4sKV01R+0nVRaCDW32kf9rcSEB2pA6/aIo5e1bidjN9NNoSB5UO1Ga46
 eSuIb6+G45tOpKyt9FQEHeliRVHAfqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728985917;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jy5flH+B78Gx1LU5yQ52ylhY7WaxgPu5PRIW7sUbJTI=;
 b=xAml26dJsuwz+3nsRRjSaJQuS4G2P0wI4rkELsoUZLETvQPap0zmNIJ6JY9QCSJwmra06w
 MsT8DMX//InJifBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728985917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jy5flH+B78Gx1LU5yQ52ylhY7WaxgPu5PRIW7sUbJTI=;
 b=ohCpwl0MRPHsBPBdXSpW4AOsQBAmAqEDfen8Cy/G45lyBPf/iu/50yzmfubUn1a/QkX1Nc
 Tw9jAzDAmMu96L4sKV01R+0nVRaCDW32kf9rcSEB2pA6/aIo5e1bidjN9NNoSB5UO1Ga46
 eSuIb6+G45tOpKyt9FQEHeliRVHAfqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728985917;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jy5flH+B78Gx1LU5yQ52ylhY7WaxgPu5PRIW7sUbJTI=;
 b=xAml26dJsuwz+3nsRRjSaJQuS4G2P0wI4rkELsoUZLETvQPap0zmNIJ6JY9QCSJwmra06w
 MsT8DMX//InJifBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EBCD813A53;
 Tue, 15 Oct 2024 09:51:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id f1dxODw7DmcoKgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 15 Oct 2024 09:51:56 +0000
Date: Tue, 15 Oct 2024 11:50:55 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <Zw46_xyBaWFPMShv@yuki.lan>
References: <892adc7c5b174221bf10e796ad29adaaf1559e5c.1728978957.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <892adc7c5b174221bf10e796ad29adaaf1559e5c.1728978957.git.jstancek@redhat.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/statmount07: drop "invalid buffer size"
 test
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
> The manpage doesn't say that 'smbuf' needs to be valid
> for entire range of 'bufsize'.
> 
> This check relies on access_ok() check, which can be skipped
> on some arches/configs, for example on s390x with
> CONFIG_ALTERNATE_USER_ADDRESS_SPACE=y. Test then fails with:
>   statmount07.c:117: TFAIL: invalid buffer size succeeded

And does it fail later on in the copy_to_user() if the buffer is
physically not accesible?

We may add a test that would look like:

| page mapped rw | page mapped read only |
             ^
	     buf pointer starts here

What do you think?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
