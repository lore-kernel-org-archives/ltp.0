Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDB2CD6E64
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 10:35:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 85C893E560A
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 12:35:01 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 091903D0E25
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 12:34:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A7285200078
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 12:34:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5FCDB674A1;
 Wed,  3 Jun 2026 10:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780482884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wza/Jn1XDmAyfjm7UDnBg0J5xOpZNfvOJMmYhma44w8=;
 b=wuvdWUEjkC9YaSAoqvW191wP8w5TT9TsEZz06GnwbGJIU+xdWdMIaSpzgU7McqU8oMsPiF
 jMGZs/WcMxrVhzTugFhh6BYVHaaiHtKOVeCgy3NEGmKYfxErulQ2ZReoFcLpsixVf7eTot
 AL8wfsiQvl++N0SsRVGBgOV053lku8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780482884;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wza/Jn1XDmAyfjm7UDnBg0J5xOpZNfvOJMmYhma44w8=;
 b=sKqljyb+X3Qkb/l/JRl+6D17u1wClvHyR4bUAV0Ez0Y+OALUygt4MKNkTld9XAyVcmLyRB
 5ikEvANDxt5SF/Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780482884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wza/Jn1XDmAyfjm7UDnBg0J5xOpZNfvOJMmYhma44w8=;
 b=wuvdWUEjkC9YaSAoqvW191wP8w5TT9TsEZz06GnwbGJIU+xdWdMIaSpzgU7McqU8oMsPiF
 jMGZs/WcMxrVhzTugFhh6BYVHaaiHtKOVeCgy3NEGmKYfxErulQ2ZReoFcLpsixVf7eTot
 AL8wfsiQvl++N0SsRVGBgOV053lku8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780482884;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wza/Jn1XDmAyfjm7UDnBg0J5xOpZNfvOJMmYhma44w8=;
 b=sKqljyb+X3Qkb/l/JRl+6D17u1wClvHyR4bUAV0Ez0Y+OALUygt4MKNkTld9XAyVcmLyRB
 5ikEvANDxt5SF/Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4AE005A501;
 Wed,  3 Jun 2026 10:34:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Ao0qEUQDIGr5GQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 03 Jun 2026 10:34:44 +0000
Date: Wed, 3 Jun 2026 12:34:40 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Darren Chang <chihsheng@google.com>
Message-ID: <aiADQJONiWJVh0Qa@yuki.lan>
References: <20260601165331.4077251-1-chihsheng@google.com>
 <20260602010754.190896-1-chihsheng@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260602010754.190896-1-chihsheng@google.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] syscalls/xattr: Add runtime probe for socket
 xattr backports
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
>  	socket_xattr_supported = tst_kvercmp(7, 1, 0) >= 0;
> +
> +	/*
> +	 * Commit dc0876b9846d "xattr: support extended attributes on sockets"
> +	 * merged in 7.1 mainline, but might be backported.
> +	 * Try to set xattr on socket to detect support.
> +	 */
> +	if (!socket_xattr_supported) {
> +		for (i = 0; i < ARRAY_SIZE(tc); i++) {
> +			if (tc[i].issocket) {
> +				socket_idx = i;
> +				break;
> +			}
> +		}
> +
> +		if (socket_idx != ARRAY_SIZE(tc)) {
> +			if (fsetxattr(tc[socket_idx].fd, tc[socket_idx].key,
> +				      tc[socket_idx].value, tc[socket_idx].size,
> +				      tc[socket_idx].flags) == 0) {
> +				tst_res(TINFO, "Socket xattr support detected (backport)");
> +				socket_xattr_supported = true;
> +
> +				SAFE_FREMOVEXATTR(tc[socket_idx].fd, tc[socket_idx].key);
> +			}

Instead of looking up the attribute in the array we can just create a
socket, try ato add an attribute and remove the socked instead. With
that we can up the code into a common header so that it's not duplicated
int two testcases. I guess that the best place would be the
lapi/socket.h header and we should add a static inline function
socket_xattrs_supported() there.

> +		}
> +	}
>  }
>  
>  static void cleanup(void)
> diff --git a/testcases/kernel/syscalls/setxattr/setxattr02.c b/testcases/kernel/syscalls/setxattr/setxattr02.c
> index 994ab655d..167e068cf 100644
> --- a/testcases/kernel/syscalls/setxattr/setxattr02.c
> +++ b/testcases/kernel/syscalls/setxattr/setxattr02.c
> @@ -196,6 +196,20 @@ static void setup(void)
>  	SAFE_MKNOD(SOCK, S_IFSOCK | 0777, 0);
>  
>  	socket_xattr_supported = tst_kvercmp(7, 1, 0) >= 0;
> +
> +	/*
> +	 * Commit dc0876b9846d "xattr: support extended attributes on sockets"
> +	 * merged in 7.1 mainline, but might be backported.
> +	 * Try to set xattr on socket to detect support.
> +	 */
> +	if (!socket_xattr_supported) {
> +		if (setxattr(SOCK, XATTR_TEST_KEY, XATTR_TEST_VALUE,
> +			     XATTR_TEST_VALUE_SIZE, XATTR_CREATE) == 0) {
> +			tst_res(TINFO, "Socket xattr support detected (backport)");
> +			socket_xattr_supported = true;
> +			SAFE_REMOVEXATTR(SOCK, XATTR_TEST_KEY);
> +		}
> +	}
>  }
>  
>  static struct tst_test test = {
> -- 
> 2.54.0.929.g9b7fa37559-goog
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
