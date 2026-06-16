Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5381CD98DA
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 09:13:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 951773E5967
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 11:12:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B414A3C96A5
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 11:12:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4AFE62001CF
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 11:12:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 74D946C8DD;
 Tue, 16 Jun 2026 09:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781601162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cyEzKxydyJ50x3glxksTv8DUwV4wOO2EPJumaiMkyWo=;
 b=FwntGw9EeDZz4eHTNFJ8n7cMkANuxO3IGUWbQcoqaTNbISxD9RGi3fHYdrgp8dNCIrmC6T
 gko2a21rlTd8VUQwmYJh4AzcSqZDkaVnX0zdWNwFPhSKpI02iukKoAFIoJocwWw56d3Xaz
 eOJrf+KwGwKNQAnE/LH2Yc8rO5hRUaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781601162;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cyEzKxydyJ50x3glxksTv8DUwV4wOO2EPJumaiMkyWo=;
 b=CVFimgrjBAftXZ4Womarv09FnA+bYqY5SEZje58deg5R4smbUuZ4BgJIL6xqPW432GZGZs
 bb21czqKqLDrbBDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FwntGw9E;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CVFimgrj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781601162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cyEzKxydyJ50x3glxksTv8DUwV4wOO2EPJumaiMkyWo=;
 b=FwntGw9EeDZz4eHTNFJ8n7cMkANuxO3IGUWbQcoqaTNbISxD9RGi3fHYdrgp8dNCIrmC6T
 gko2a21rlTd8VUQwmYJh4AzcSqZDkaVnX0zdWNwFPhSKpI02iukKoAFIoJocwWw56d3Xaz
 eOJrf+KwGwKNQAnE/LH2Yc8rO5hRUaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781601162;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cyEzKxydyJ50x3glxksTv8DUwV4wOO2EPJumaiMkyWo=;
 b=CVFimgrjBAftXZ4Womarv09FnA+bYqY5SEZje58deg5R4smbUuZ4BgJIL6xqPW432GZGZs
 bb21czqKqLDrbBDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6922A779A8;
 Tue, 16 Jun 2026 09:12:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lZOgGYoTMWofKAAAD6G6ig
 (envelope-from <jack@suse.cz>); Tue, 16 Jun 2026 09:12:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 02F2EA12D3; Tue, 16 Jun 2026 11:12:37 +0200 (CEST)
Date: Tue, 16 Jun 2026 11:12:37 +0200
From: Jan Kara <jack@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <un4jlftokjfzo7girjmf6yrpheg5nyye6wywtgmr3oxfnc3hob@uljmnxlllygu>
References: <20260615180629.7148-5-anonymemeow@gmail.com>
 <6a310842.7d2905a5.2ed87e.3229@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a310842.7d2905a5.2ed87e.3229@mx.google.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 74D946C8DD
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_THREE(0.00)[3];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_LAST(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,suse.cz,lists.linux.it];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim, imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/5] fanotify21: Add test variants for
 FAN_REPORT_TID
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
Cc: amir73il@gmail.com, jack@suse.cz, ltp@lists.linux.it,
 AnonymeMeow <anonymemeow@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello!

On Tue 16-06-26 08:24:33, Andrea Cervesato wrote:
> the patch-set is failing to compile on our CI. Please send a new
> version fixing it:
> 
> https://github.com/linux-test-project/ltp/actions/runs/27572447779/job/81512172691

Hum, I had a look and the failure actually is:

parse_opts.c: In function 'usc_test_looping':
parse_opts.c:521:3: warning: call to function 'usc_recressive_func' without a real prototype [-Wunprototyped-calls]
   usc_recressive_func(0, STD_LP_recfun, *STD_bigstack);
   ^
parse_opts.c:107:13: note: 'usc_recressive_func' was declared here
 static void usc_recressive_func();
             ^
CC libs/numa/tse_numa.o
AR libltpnuma.a
RANLIB libltpnuma.a
CC lib/random_range.o
CC lib/parse_opts.o
CC lib/safe_file_ops.o
In file included from ../../include/tse_sigwait.h:11:0,
                 from tse_sigwait.c:8:
../../include/tst_timer.h: In function 'tst_ts_from_timespec':
../../include/tst_timer.h:626:3: warning: missing initializer for field 'tv_nsec' of 'struct timespec' [-Wmissing-field-initializers]
   .ts.libc_ts.tv_nsec = ts.tv_nsec,
   ^
In file included from /usr/include/sys/select.h:43:0,
                 from /usr/include/sys/types.h:219,
                 from /usr/include/stdlib.h:314,
                 from tse_sigwait.c:6:
/usr/include/time.h:123:23: note: 'tv_nsec' declared here
     __syscall_slong_t tv_nsec; /* Nanoseconds.  */
                       ^
CC lib/safe_pthread.o

So I'm a bit at loss what change in fanotify tests could have caused a
failure in compilation of the generic LTP library code? Any idea?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
