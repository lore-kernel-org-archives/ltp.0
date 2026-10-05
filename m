Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0399CA5FF0
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 15:12:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 950EB3E9DAE
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 17:12:39 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BDDC33E6B43
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 17:12:22 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7FE51140077F
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 17:12:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 763D51F790;
 Mon,  5 Oct 2026 15:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1791213137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZNeFY+DkXxyX84rmFm/GvjhsII5PzA3ZDYGMW/mNtxc=;
 b=NvzfGMoHBgPOnUuB4ykK06WKq2/kDrphBB2CkBKP2YuBwuSOiBQMHYJ1OYfN5y6IIHSIXD
 Y3l4z7xpgaJXwK2Idpajmqy8cXg86lhtpMgLA0NsIqD5iYHYhUEtPVZDnDqhf0n7OM32CH
 1EI1QGgyOrej5xfGj6wtAQLd2PAtygM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1791213137;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZNeFY+DkXxyX84rmFm/GvjhsII5PzA3ZDYGMW/mNtxc=;
 b=mUFaeZP5aiW6Oy9m+6VYS+eInOkp4O50L8tRw0+gigOevWyBEvLBT2K4EnX7AJLNg3GeI+
 4cnvZxiwsZH/E7BA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=15h6PO5b;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QL7i80K8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1791213133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZNeFY+DkXxyX84rmFm/GvjhsII5PzA3ZDYGMW/mNtxc=;
 b=15h6PO5bMo27WzAgijGP4SHAF1WTQo+R2h30x+MC0QfPL18dF87QBbfRGYGAhRhnEr7n9z
 tbAS+1fupJywRAuO5MtKYm3VM6jdJyRgG4KEcGINeiqswIEqA0aOGNWpGDqLoi7eJueFMG
 vbT50xYSVLdUuz/A5RIwMipH2OEyWvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1791213133;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZNeFY+DkXxyX84rmFm/GvjhsII5PzA3ZDYGMW/mNtxc=;
 b=QL7i80K8DXb6vgqZFmJA8jgi3GDuTEA4dGqKyW9pTTiX68FLkpS+PA6mZl7paYZWhEKNs8
 QYFjxx/QSVVRVbAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 435F513688;
 Mon,  5 Oct 2026 15:12:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id K1p2CE2+w2ohYwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 05 Oct 2026 15:12:13 +0000
Date: Mon, 5 Oct 2026 17:12:25 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <asO-WcR2_2xoQiEI@yuki.lan>
References: <20261005-fix_core_lib_deepseek-v1-0-fec334ce8e80@suse.com>
 <20261005-fix_core_lib_deepseek-v1-3-fec334ce8e80@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261005-fix_core_lib_deepseek-v1-3-fec334ce8e80@suse.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,suse.com:email];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 763D51F790
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 03/15] ujson: reader: Prevent infinite loop on EOF
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
> When read() returns 0 before reaching the size reported by lseek()
> (e.g. sysfs files or truncated files), off does not advance and the
> loop spins indefinitely. Treat read() == 0 as EOF by breaking the loop
> and updating the buffer length and terminator.
> 
> Fixes: c50a0e0751c8 ("libs: Vendor ujson library")
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  libs/ujson/ujson_reader.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/libs/ujson/ujson_reader.c b/libs/ujson/ujson_reader.c
> index 9f86f25b7..2219c5801 100644
> --- a/libs/ujson/ujson_reader.c
> +++ b/libs/ujson/ujson_reader.c
> @@ -1032,9 +1032,15 @@ ujson_reader *ujson_reader_load(const char *path)
>  			goto err1;
>  		}
>  
> +		if (res == 0)
> +			break;
> +
>  		off += res;
>  	}
>  
> +	ret->buf[off] = 0;
> +	ret->len = off;
> +

This is mostly theoretical, since it's unlikely that the file we are
reading has changed size during the loop that reads it.

I suppose that it would be safer to just fail the load call instead of
loading truncated file that would likely be rejected by the parser later
on anyways.

So maybe just:

diff --git a/ujson_reader.c b/ujson_reader.c
index f4ec607..0f34bc5 100644
--- a/ujson_reader.c
+++ b/ujson_reader.c
@@ -1032,6 +1032,11 @@ ujson_reader *ujson_reader_load(const char *path)
                        goto err1;
                }

+               if (res == 0) {
+                       fprintf(stderr, "read() returned 0 (file was truncated?)\n");
+                       goto err1;
+               }
+
                off += res;
        }


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
