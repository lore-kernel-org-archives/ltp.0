Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF33EC369AB
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 16:34:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1118E3CB91C
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 18:34:42 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D3FED3CA513
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 18:34:24 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BE3EA60015C
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 18:34:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 797181F74A;
 Tue, 15 Apr 2025 16:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744734861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rAaQZZFYc1RPCZcQ4w0OMfZfwRYcTzxLo77bybzFwlM=;
 b=DZIP5+cH2pnyLgffKXAazDC4moBC8683BIr1Prr0ArEemJSQRmqwNn2lW1gMXV5SWgSugc
 9gak+5Q0yVxCPYEeRc329uZoIoUkDl/d3HG8szcnEPRCI+PFGcp8On+53eTOvSl96Q+U7F
 vd8naP9I+9L7cCeQHIl0Mqo2eEKZC1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744734861;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rAaQZZFYc1RPCZcQ4w0OMfZfwRYcTzxLo77bybzFwlM=;
 b=1FfDAZMnucdrHuOzIoi0fXguOi9cAoCXK0kNys62yYBECqIMr1kHhGiQDZ/8CrBo9zYj1G
 YwTI6T+47CnLkBCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744734861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rAaQZZFYc1RPCZcQ4w0OMfZfwRYcTzxLo77bybzFwlM=;
 b=DZIP5+cH2pnyLgffKXAazDC4moBC8683BIr1Prr0ArEemJSQRmqwNn2lW1gMXV5SWgSugc
 9gak+5Q0yVxCPYEeRc329uZoIoUkDl/d3HG8szcnEPRCI+PFGcp8On+53eTOvSl96Q+U7F
 vd8naP9I+9L7cCeQHIl0Mqo2eEKZC1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744734861;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rAaQZZFYc1RPCZcQ4w0OMfZfwRYcTzxLo77bybzFwlM=;
 b=1FfDAZMnucdrHuOzIoi0fXguOi9cAoCXK0kNys62yYBECqIMr1kHhGiQDZ/8CrBo9zYj1G
 YwTI6T+47CnLkBCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C236137A5;
 Tue, 15 Apr 2025 16:34:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xAvqGY2K/mf4YwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 15 Apr 2025 16:34:21 +0000
Date: Tue, 15 Apr 2025 18:34:52 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Z_6KrACqq3DUs_ty@yuki.lan>
References: <20250415-patchwork_ci-v6-0-81e6d4184af5@suse.com>
 <20250415-patchwork_ci-v6-4-81e6d4184af5@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250415-patchwork_ci-v6-4-81e6d4184af5@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 4/4] ci: apply patchwork series in
 ci-docker-build workflow
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
> +    - name: Apply Patchwork series
> +      if: inputs.SERIES_ID != '' && inputs.SERIES_MBOX != ''
> +      env:
> +        PATCHWORK_TOKEN: ${{ secrets.PATCHWORK_TOKEN }}
> +      run: |
> +        git config --global user.name 'GitHub CI'
> +        git config --global user.email 'github@example.com'
> +        git config --global --add safe.directory "$GITHUB_WORKSPACE"
> +
> +        git checkout -b review_patch_series_"${{ inputs.SERIES_ID }}"

So we create a branch for each CI run but I do not see any place where
we get rid of it. Shouldn't we remove it after the CI run?

> +        curl -k "${{ inputs.SERIES_MBOX }}" | git am
> +
> +        ./ci/tools/patchwork.sh state "${{ inputs.SERIES_ID }}" "needs-review-ack"
> +
>      - name: ver_linux
>        run: ./ver_linux
>  
> @@ -158,3 +184,14 @@ jobs:
>        run: |
>          if [ "$MAKE_INSTALL" = 1 ]; then INSTALL_OPT="-i"; fi
>          ./build.sh -r install -o ${TREE:-in} $INSTALL_OPT
> +
> +    - name: Send results to Patchwork
> +      if: always() && inputs.SERIES_ID != '' && inputs.SERIES_MBOX != ''
> +      env:
> +        PATCHWORK_TOKEN: ${{ secrets.PATCHWORK_TOKEN }}
> +      run: |
> +        ./ci/tools/patchwork.sh check \
> +          "${{ inputs.SERIES_ID }}" \
> +          "${{ github.server_url }}/${{ github.repository }}/actions/runs/${{ github.run_id }}" \
> +          "${{ matrix.container }}" \
> +          "${{ job.status }}"

The rest looks good, once the branch deletion is clarified or fixed:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
