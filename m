Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7297FCFA74C
	for <ltp@archiver.kernel.org>; Fri,  4 Oct 2024 09:18:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF2653C616B
	for <ltp@archiver.kernel.org>; Fri,  4 Oct 2024 11:18:44 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA1583C54F0
 for <ltp@lists.linux.it>; Fri,  4 Oct 2024 11:18:29 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5983A600C89
 for <ltp@lists.linux.it>; Fri,  4 Oct 2024 11:18:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5769F1F458;
 Fri,  4 Oct 2024 09:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728033508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i/ANdfpiHJIQZshCfwKOU5SNpz9Qb9stZ9Nk1YW5+0A=;
 b=X7RE+o6zcpndjxhCYh1TK/DBvB0q0tQ7IDTsJ/8cKxCMdrTaiFiocSzH8bU4L4RPm5iFRI
 2HcDjk2X1TnwPEJgSG9S4dqBcxuAAFV/BDI0SDG6UAfzsm/C5hYIfS7HCCwuhNJdfhjqK1
 P0ujOXBx3+aswwBD8R2e9+1BoUAKd0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728033508;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i/ANdfpiHJIQZshCfwKOU5SNpz9Qb9stZ9Nk1YW5+0A=;
 b=7r99GJEnCeZYE4Loe5wz0PiUCUjEoz9hrBaCm8zC+oLj1jlUf6E59QIrylylvtzje/YoCE
 7Deu21FYuAy460AA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=X7RE+o6z;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7r99GJEn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728033508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i/ANdfpiHJIQZshCfwKOU5SNpz9Qb9stZ9Nk1YW5+0A=;
 b=X7RE+o6zcpndjxhCYh1TK/DBvB0q0tQ7IDTsJ/8cKxCMdrTaiFiocSzH8bU4L4RPm5iFRI
 2HcDjk2X1TnwPEJgSG9S4dqBcxuAAFV/BDI0SDG6UAfzsm/C5hYIfS7HCCwuhNJdfhjqK1
 P0ujOXBx3+aswwBD8R2e9+1BoUAKd0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728033508;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i/ANdfpiHJIQZshCfwKOU5SNpz9Qb9stZ9Nk1YW5+0A=;
 b=7r99GJEnCeZYE4Loe5wz0PiUCUjEoz9hrBaCm8zC+oLj1jlUf6E59QIrylylvtzje/YoCE
 7Deu21FYuAy460AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 471E513A55;
 Fri,  4 Oct 2024 09:18:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1JJWEeSy/2Y7CAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 04 Oct 2024 09:18:28 +0000
Date: Fri, 4 Oct 2024 11:17:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <Zv-yoVOl1Bn7WZcM@yuki.lan>
References: <20240909-listmount_statmount-v4-0-39558204ddf0@suse.com>
 <20240909-listmount_statmount-v4-13-39558204ddf0@suse.com>
 <Zv6rklWkNJaT8uvJ@yuki.lan>
 <6cac9a7d-3a8c-4502-bd4a-23be491cf0ab@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6cac9a7d-3a8c-4502-bd4a-23be491cf0ab@suse.com>
X-Rspamd-Queue-Id: 5769F1F458
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 13/13] Add statmount07 test
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> That seems to be a valid value, since I get PASS. Kernel bug?

Looking at kernel it's a bit confusing, the bufsize is supposed to be
the size of the structure plus the buffer allocated for the string
reply. Which makes the code more complicated than it could have been if
these two were separeted properly.


However we do have:

       if (kbufsize >= s->bufsize)
                return -EOVERFLOW;

in statmount_string(), so we will trigger the error there if we pass one
of the requests that is supposed to produce a string reply.


But there seems to be something strange going on in the
prepare_kstatmount() as well, we do have:

        if (ks->mask & STATMOUNT_STRING_REQ) {
                if (bufsize == sizeof(ks->sm))
                        return -EOVERFLOW;

		^ This line should probably be if (bufsize <= sizeof(ks->sm))
                  because we are trying to make sure that the structure is large
		  enough that we can write at the offset where the
		  string area starts.

		  It seems to be guarded by the checks in
		  statmount_string() later on as well, so I suppose that we
		  will trigger the EOVERFLOW slightly later if this does not
		  work though. CCying Jan to have a look.

                ks->seq.buf = kvmalloc(seq_size, GFP_KERNEL_ACCOUNT);
                if (!ks->seq.buf)
                        return -ENOMEM;

                ks->seq.size = seq_size;
        }




However the size seems to be properly used in the
copy_statmount_to_user()

        size_t copysize = min_t(size_t, s->bufsize, sizeof(*sm));

	...

	if (copy_to_user(s->buf, sm, copysize))
                return -EFAULT;


This means that we will copy as much of the statmount structure to
userspace as we requested, so in the case that we pass 0 as bufsize none
of the data should be copied and indeed we should get back success.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
