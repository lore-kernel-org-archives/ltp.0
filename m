Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A59EC3600B
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 11:11:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C8D313C9DDB
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 12:11:27 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 544693C06A7
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 12:11:10 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 371B81A00E04
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 12:11:09 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 041ED1F453;
 Thu, 27 Mar 2025 11:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743073869;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2+dbiYGlwpNa5JbVNnKEGSwZSPJ+kpaR9B7vz7s4sYw=;
 b=Md0zmIjCvhGgod4M7QYxtcY8Cm7BbQjwT1CcVXmrti2fEo/qUVsMKZguVz/qz3e+SRyJXt
 ULfpSgUgNGzjNovavan0Hd+WDveSDvCtYgBvPCQPyf426FV86lYjM3nw67Q90l+aL9rCzR
 Xz7ODa5EJ5gGz3YxlAoWTy8zYfDorhk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743073869;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2+dbiYGlwpNa5JbVNnKEGSwZSPJ+kpaR9B7vz7s4sYw=;
 b=/Kr4iI0kw/lpLJdl6pADLO7E2aLHyS46le3l0j+HBpGdmhPk5WJn+uJeEjU59VkiZh3NPV
 266PQJrGSSZEFWBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743073868;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2+dbiYGlwpNa5JbVNnKEGSwZSPJ+kpaR9B7vz7s4sYw=;
 b=FyD3e7xrLS5WjUOaFgiE9iHdgOWlxagtmmB6RnzY62ozhTPVmnvs1Y2JWLf0TmNHX5F1nH
 SamU5GXFgXkm40ZaDfjw7FGWvaEo9I/NFQ3C5NGxHLeJj6qQugZH4ia6XssYJ51gIk7vr5
 SoQat31VG5gbjoFURxcxa9LznOBd1sY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743073868;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2+dbiYGlwpNa5JbVNnKEGSwZSPJ+kpaR9B7vz7s4sYw=;
 b=6GhSbwWLMRsaQXd9tfjmrphIn8iP/hM8WilaXT9Mvr5BARH6Qwi/6V4xUqfwW3Y2Df8tDK
 sbfwJ4ryfFgmMPAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D635F1376E;
 Thu, 27 Mar 2025 11:11:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id L6VDM0sy5Wf0IgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 27 Mar 2025 11:11:07 +0000
Date: Thu, 27 Mar 2025 12:11:06 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "T.J. Mercier" <tjmercier@google.com>
Message-ID: <20250327111106.GA77751@pevik>
References: <20250326223532.3411149-1-tjmercier@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250326223532.3411149-1-tjmercier@google.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] memcg_control_test: Disable swapping in test
 cgroup
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
Cc: Michal Koutny <mkoutny@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

> memcg_control_test_1 sets both a memory limit and a memsw/swap limit to
> a single page, and then asks mem_process to allocate 2 pages in an
> attempt to cause a memcg OOM kill. However, if swapping is enabled the
> first page can be swapped before the second is allocated causing neither
> limit to be exceeded, and no OOM kill to occur which results in a test
> failure. Fix this by disabling swap in the test cgroup if it is enabled,
> causing both pages to always be accounted under the same counter such
> that memory.max (v2) / memory.limit_in_bytes (v1) causes an OOM kill.

LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

I suppose the old shell tests which cgroupv1 memory.memsw.limit_in_bytes are
written to test memory limits, thus only this one is suitable to modify.

The new C based tests (cgroupv2) should not be affected either.

Kind regards,
Petr

> Fixes: c0b815736 ("New testcase added by Naufal.")
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> ---
>  .../kernel/controllers/memcg/control/memcg_control_test.sh   | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

> diff --git a/testcases/kernel/controllers/memcg/control/memcg_control_test.sh b/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
> index 68287a70c..eb8db3e30 100644
> --- a/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
> +++ b/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
> @@ -12,7 +12,6 @@ TST_NEEDS_TMPDIR=1

>  PAGE_SIZE=$(tst_getconf PAGESIZE)

> -TOT_MEM_LIMIT=$PAGE_SIZE
>  ACTIVE_MEM_LIMIT=$PAGE_SIZE
>  PROC_MEM=$((PAGE_SIZE * 2))

> @@ -50,13 +49,13 @@ test1()

>  	# If the kernel is built without swap, the $memsw_memory_limit file is missing
>  	if [ -e "$test_dir/$memsw_memory_limit" ]; then
> -		ROD echo "$TOT_MEM_LIMIT" \> "$test_dir/$memsw_memory_limit"
> +		ROD echo 0 \> "$test_dir/$memsw_memory_limit"
>  	fi

>  	KILLED_CNT=0
>  	test_proc_kill

> -	if [ $PROC_MEM -gt $TOT_MEM_LIMIT ] && [ $KILLED_CNT -eq 0 ]; then
> +	if [ $KILLED_CNT -eq 0 ]; then
>  		tst_res TFAIL "Test #1: failed"
>  	else
>  		tst_res TPASS "Test #1: passed"

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
