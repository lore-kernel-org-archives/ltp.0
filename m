Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FA9C48BC3
	for <ltp@archiver.kernel.org>; Wed, 21 Feb 2024 16:28:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E7293D086C
	for <ltp@archiver.kernel.org>; Wed, 21 Feb 2024 17:28:18 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B46783CD900
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 17:28:02 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 68EA4600C61
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 17:28:00 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 626251F385;
 Wed, 21 Feb 2024 16:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708532880;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ezF21mCvGiqcyxCeXQEJqxhTpcFakkttzT6WRRncEvU=;
 b=M5JdTm3uNYdVzL0iAgANOcsmTGm/3vb8ZI1FwfmNNSiyBDakudHL5k6ExEpZO3WrprX8Va
 tsYtqt8a5Ov7kn7vvSe+v58M0E0hRG4NJd9sHo/xCbSl4YIzEEItDE1K1qmoP7JVGsliXK
 /uA6NoJPeRkPNFfoOj8wbizZDTWds4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708532880;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ezF21mCvGiqcyxCeXQEJqxhTpcFakkttzT6WRRncEvU=;
 b=eqgsA1vyRSkJZUdno7/SajBORPuvB6WsflthlaplF2psJICH0dX+fMwKBwLVqMwzInC4Vc
 EFW3omv0EbVqLMBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708532880;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ezF21mCvGiqcyxCeXQEJqxhTpcFakkttzT6WRRncEvU=;
 b=M5JdTm3uNYdVzL0iAgANOcsmTGm/3vb8ZI1FwfmNNSiyBDakudHL5k6ExEpZO3WrprX8Va
 tsYtqt8a5Ov7kn7vvSe+v58M0E0hRG4NJd9sHo/xCbSl4YIzEEItDE1K1qmoP7JVGsliXK
 /uA6NoJPeRkPNFfoOj8wbizZDTWds4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708532880;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ezF21mCvGiqcyxCeXQEJqxhTpcFakkttzT6WRRncEvU=;
 b=eqgsA1vyRSkJZUdno7/SajBORPuvB6WsflthlaplF2psJICH0dX+fMwKBwLVqMwzInC4Vc
 EFW3omv0EbVqLMBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 48499139D1;
 Wed, 21 Feb 2024 16:28:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id C3O9D5Ak1mUzZgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 21 Feb 2024 16:28:00 +0000
Date: Wed, 21 Feb 2024 17:27:54 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240221162754.GA1270838@pevik>
References: <20240220091328.2946023-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240220091328.2946023-1-liwang@redhat.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.30 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] move_pages12: compacting memory before each test
 loop
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

> These simple steps are added to prepare the system's memory state
> for the test, aiming to increase the test's reliability and
> consistency by starting from a clean and defragmented memory state.

> To reduce accidental failures on small (1.5G) RAM system:

>   7 tst_test.c:1558: TINFO: Timeout per run is 0h 21m 00s
>   8 move_pages12.c:273: TINFO: Free RAM 1542656 kB
>   9 move_pages12.c:289: TINFO: Increasing 16384kB hugepages pool on node 0 to 4
>   10 move_pages12.c:299: TINFO: Increasing 16384kB hugepages pool on node 1 to 4
>   11 move_pages12.c:216: TINFO: Allocating and freeing 4 hugepages on node 0
>   12 move_pages12.c:216: TINFO: Allocating and freeing 4 hugepages on node 1
>   13 move_pages12.c:207: TPASS: Bug not reproduced
>   14 move_pages12.c:106: TFAIL: madvise failed: ENOMEM (12)
>   ...<repeats 741 times>...
>   756 move_pages12.c:207: TPASS: Bug not reproduced

> Note:
>   This is a single hugetlb test without invoking the hugetlb-lib of LTP,
>   so we add the compacting memory/cache steps additionally.

> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  testcases/kernel/syscalls/move_pages/move_pages12.c | 3 +++
>  1 file changed, 3 insertions(+)

> diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
> index fd7017d79..c387a326f 100644
> --- a/testcases/kernel/syscalls/move_pages/move_pages12.c
> +++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
> @@ -154,6 +154,9 @@ static void do_test(unsigned int n)
>  	pid_t cpid = -1;
>  	int status;

> +	SAFE_FILE_PRINTF("/proc/sys/vm/drop_caches", "3");
> +	SAFE_FILE_PRINTF("/proc/sys/vm/compact_memory", "1");

LGTM
Reviewed-by: Petr Vorel <pvorel@suse.cz>

BTW we clear cache with /proc/sys/vm/drop_caches in quite a few files,
I wonder if it would make sense to add a helper for it. Likely not
(it's oneliner).

Kind regards,
Petr

> +
>  	addr = SAFE_MMAP(NULL, tcases[n].tpages * hpsz, PROT_READ | PROT_WRITE,
>  		MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
