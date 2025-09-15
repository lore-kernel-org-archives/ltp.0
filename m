Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93ABFCAC597
	for <ltp@archiver.kernel.org>; Mon, 15 Sep 2025 09:05:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8028C3CD9CA
	for <ltp@archiver.kernel.org>; Mon, 15 Sep 2025 11:05:47 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 678363C0962
 for <ltp@lists.linux.it>; Mon, 15 Sep 2025 11:05:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 922461000759
 for <ltp@lists.linux.it>; Mon, 15 Sep 2025 11:05:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 042401F821;
 Mon, 15 Sep 2025 09:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1757927129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x0sm3p6HRT53C5i/L8davkIpW1DKsn8M7HMXG/SoV7o=;
 b=d+UjVN84VxhPxzwj4rO8HgW6e3V/nJ5NdAutGlbabm1C5X+UpsxuQnu2GRIPC3MEderx/G
 nlm/80OPhydFXbJfgh2NMGo/UeBgSvMLqA1TymVJf9Ji4QOb/Nfjal3Juq0xbShH+cL1Uy
 5HDgZHQ3b/1RT1AEJ/n9PYue04j2ymE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1757927129;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x0sm3p6HRT53C5i/L8davkIpW1DKsn8M7HMXG/SoV7o=;
 b=ySoOdjvUvS4O4BfvZ/GbeYqCo9nOvkRFUf9fwU+xWHmpibEeIWq4aF1OL6V95ACf271sA/
 nUxx19DcxzZJ3jDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1757927128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x0sm3p6HRT53C5i/L8davkIpW1DKsn8M7HMXG/SoV7o=;
 b=InWezuWAkptQFL2az8ysOK+EsTeQWdPxaZDFvG4At3GD+oIj/ey+OzQsT/31wggTI1PTO8
 W8oxoDKvYkiFIoeivBO37KiubcXdK1hAt58J4TxLmg6krPYD7RVgPXwFfYtyalAefALXWL
 D3bYyq1dyl3Ld/j9GZaBE8uhQqE5DeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1757927128;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x0sm3p6HRT53C5i/L8davkIpW1DKsn8M7HMXG/SoV7o=;
 b=aSRF1t7jkm+GfzxWmHTozBWglLoXNepvL9cMyQbaj9+TCaqPvbZ3Sgq1yoMU0azONCCXlb
 FSwgnRRt8ew6nHCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB1B11372E;
 Mon, 15 Sep 2025 09:05:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kNyaNNfWx2iedAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 15 Sep 2025 09:05:27 +0000
Date: Mon, 15 Sep 2025 11:06:05 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Jack Morgan <jmorgan@naotchy.com>
Message-ID: <aMfW_bP12FUgR15H@yuki.lan>
References: <20250913005759.2946000-1-jmorgan@naotchy.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250913005759.2946000-1-jmorgan@naotchy.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[];
 URIBL_BLOCKED(0.00)[suse.cz:email,linux.it:url,imap1.dmz-prg2.suse.org:helo,naotchy.com:email];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] statmount.h: add check for STATMOUNT_MNT_NS_ID
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
> Enable mnt_ns_id check for kenels that support it
> It's can be deinfed as envornment variable with
> LTP_HAVE_STATMOUNT_MNT_NS_ID.
> 
> Fixes: #1260
> 
> Signed-off-by: Jack Morgan <jmorgan@naotchy.com>
> ---
>  testcases/kernel/syscalls/statmount/statmount.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/statmount/statmount.h b/testcases/kernel/syscalls/statmount/statmount.h
> index d21d7f8da..b1696515d 100644
> --- a/testcases/kernel/syscalls/statmount/statmount.h
> +++ b/testcases/kernel/syscalls/statmount/statmount.h
> @@ -13,6 +13,11 @@
>  #include "lapi/syscalls.h"
>  #include "tst_safe_stdio.h"
> 
> +/* Enable mnt_ns_id check when system struct statmount is not defined. */
> +#if !defined(HAVE_STRUCT_STATMOUNT) && !defined(LTP_HAVE_STATMOUNT_MNT_NS_ID)
> +#define LTP_HAVE_STATMOUNT_MNT_NS_ID 1
> +#endif

We actually have a fallback definition for the statmount structure in
include/lapi/mount.h so the structure is always defined. So there is no
need for this and we can just do:

#if !defined(LTP_HAVE_STATMOUNT_MNT_NS_ID) \


in the test.

>  static inline int statmount(uint64_t mnt_id, uint64_t mask, struct statmount *buf,
>  		     size_t bufsize, unsigned int flags)
>  {
> --
> 2.51.0
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
