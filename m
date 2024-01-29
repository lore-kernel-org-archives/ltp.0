Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE955C47DB3
	for <ltp@archiver.kernel.org>; Mon, 29 Jan 2024 15:03:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01EE63CE15D
	for <ltp@archiver.kernel.org>; Mon, 29 Jan 2024 16:03:07 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A3A1B3CB7FF
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 16:02:51 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 929F410000E1
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 16:02:50 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 703532229A;
 Mon, 29 Jan 2024 15:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706540569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FS8YM8I0K7hwHduVK5ippHhN0PjrW6PvpHqgjwnMJx4=;
 b=DUB8VpVtIY6gHo4p7+OrrkeZ0riiJ9LegtylEyUbjw3aL6FpL4pLq4vxNwpdQndYUaOTGQ
 kpDSUUAAZ+Dr5dfr/gkWvub0YZSFMiJHnViDkg22qLsR7okzqd4o+uP64+CWZiNEIWEWNt
 m7sRp4EUuxyxefJE6JqzR5hc6wUaKd4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706540569;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FS8YM8I0K7hwHduVK5ippHhN0PjrW6PvpHqgjwnMJx4=;
 b=JmBGJiLEPRsNO/Rvvz08V1gmM060gQj5eNkyzSEEY9polilesu1vRO5zH5ye9ft4nujx9P
 3bZ4VN0I6TrAeUDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706540567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FS8YM8I0K7hwHduVK5ippHhN0PjrW6PvpHqgjwnMJx4=;
 b=KOoG03D0376nH1nwPt+uQuyqv9nlAe7t8w1X8evVfw0i/DYG1prztlpbZU7X0lkveqNcKb
 YTAbzgSAJAQWItBfnE49ldZ0uvxVwSEEIm/cgTuV7vJikrpZBqCkctj7S8mtF2POWi6AsV
 LC+cNQhX+HcdVwtDFZW1CJU9l5Vr08o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706540567;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FS8YM8I0K7hwHduVK5ippHhN0PjrW6PvpHqgjwnMJx4=;
 b=4gDQ+5zcYXxKbVBE4jyuGGbx9ql46jy0GUQFNm5Q76FAqEgJdnOtlIW6BNgUiPhTFX2yf5
 /3mO1Fss6LUeqIDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6003812FF7;
 Mon, 29 Jan 2024 15:02:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WCGOFhe+t2WvPgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 29 Jan 2024 15:02:47 +0000
Date: Mon, 29 Jan 2024 16:01:31 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Zbe9y0MHJZezVeFp@rei>
References: <20240129101448.14463-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240129101448.14463-1-andrea.cervesato@suse.de>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KOoG03D0;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4gDQ+5zc
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.82 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.81)[84.86%]
X-Rspamd-Queue-Id: 703532229A
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Fix synchronization problem with dio tests
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
> When system is really fast processing I/O syscalls, multiple childrean
> running I/O operations might lock the parent, causing
> tst_reap_childrean() to stuck. By adding a small usleep at the
> end of the reading I/O operations, which are used by dio_append and
> dio_read tests, we ensure that system has enough breath to end tests
> correctly and to process children exit.

This does smell like a kernel bug to be honest.

Which test is this? How to reproduce?

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  testcases/kernel/io/ltp-aiodio/common.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/testcases/kernel/io/ltp-aiodio/common.h b/testcases/kernel/io/ltp-aiodio/common.h
> index 200bbe18e..281072c3b 100644
> --- a/testcases/kernel/io/ltp-aiodio/common.h
> +++ b/testcases/kernel/io/ltp-aiodio/common.h
> @@ -90,6 +90,8 @@ static inline void io_read(const char *filename, int filesize, volatile int *run
>  			if (!*run_child || !tst_remaining_runtime())
>  				goto exit;
>  		}
> +
> +		usleep(100);
>  	}
>  
>  exit:
> @@ -121,6 +123,8 @@ static inline void io_read_eof(const char *filename, volatile int *run_child)
>  				break;
>  			}
>  		}
> +
> +		usleep(100);
>  	}
>  
>  	SAFE_CLOSE(fd);
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
