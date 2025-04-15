Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D241FC369B9
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 15:12:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B1B5E3CA513
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 17:12:44 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3DC263CA513
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 17:12:27 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9643B1A010BB
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 17:12:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C8A8621170;
 Tue, 15 Apr 2025 15:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744729945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jocY5r5EM46bJMFLVIUNjkgg0osizy+5gIom0dKAJS0=;
 b=flXdoXfv4wko/6+E/fs0V4w/7vEkdbRcikYzAHO0JM5ZMBA3CwKnduHKJUuVlGpS/pxl4y
 dDJJ8pIiLIRbpq4PGh4qcZX5cN9fcUwfLndP/5AsAlZfh18BZstPgBrnkfIrxqcjTCBKAt
 cL6+pV4FO+XNo7Ai6ISOI8QV4F+vF3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744729945;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jocY5r5EM46bJMFLVIUNjkgg0osizy+5gIom0dKAJS0=;
 b=XnXhkaFx2FV73H/HlMo/k8/HUc92cxMtgqgDE40IZ6ezJK3ZJm2YyxHsmmeFk0E35FssNS
 DDortIGPjqgcmaDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744729944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jocY5r5EM46bJMFLVIUNjkgg0osizy+5gIom0dKAJS0=;
 b=pK4LsG26nbv18LhLzDQyexF7KTBFN7tZpYh52VVECkD7Dvxv9WlAzJvPONJ4W9TzHfoO40
 L3yI5JIXbnarT2nhjXPBSAD6Qab+QG1rmDt5EQ20C8nZfj7OAL1m6fM4eiijpnfBg2moXd
 5mmVfX0HNDMYK6ZIdBOVxGP7ZIuYHYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744729944;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jocY5r5EM46bJMFLVIUNjkgg0osizy+5gIom0dKAJS0=;
 b=LdMNSncdlDrC6YbYoNTMMLbK4cmjKWeCLumXYvpVZUC92jQxDhKJzCJ44TNkz0CxWm9+5u
 1o9Qk+/pZaUBXICg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB2C9137A5;
 Tue, 15 Apr 2025 15:12:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id e0UoLFh3/medSgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 15 Apr 2025 15:12:24 +0000
Date: Tue, 15 Apr 2025 17:12:56 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Z_53eNAcp0piNyuO@yuki.lan>
References: <20250415-patchwork_ci-v6-0-81e6d4184af5@suse.com>
 <20250415-patchwork_ci-v6-3-81e6d4184af5@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250415-patchwork_ci-v6-3-81e6d4184af5@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 3/4] ci: add ci-patchwork-trigger workflow
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
> Add ci-patchwork-trigger workflow that is meant to run every 30 minutes,
> checking for new untested LTP patches in the Mailing List and running
> the ci-docker-build workflow on them.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  .github/workflows/ci-patchwork-trigger.yml | 65 ++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/.github/workflows/ci-patchwork-trigger.yml b/.github/workflows/ci-patchwork-trigger.yml
> new file mode 100644
> index 0000000000000000000000000000000000000000..0938aed5ad0df8af8e2e575283b56475ff219ff3
> --- /dev/null
> +++ b/.github/workflows/ci-patchwork-trigger.yml
> @@ -0,0 +1,65 @@
> +# Copyright (c) 2025 Andrea Cervesato <andrea.cervesato@suse.com>
> +
> +name: "Patchwork checker"
> +on:
> +  push:

Does it make sense to run the script both on schedulle and push?

> +  schedule:
> +    - cron: '*/15 * * * 1-5'
> +    - cron: '*/45 * * * 6,0'

So we run this less on weekends, I suppose that may make some sense.

> +env:
> +  PATCHWORK_CI_FILE: patchwork-ci-output.txt
> 
> +jobs:
> +  checker:
> +    if: ${{ github.repository == 'linux-test-project/ltp' }}
> +    runs-on: ubuntu-latest
> +    steps:
> +      - name: Git checkout
> +        uses: actions/checkout@v1
> +
> +      - name: Verify new patches
> +        id: verify
> +        run: |
> +          ./ci/tools/patchwork.sh verify > "$PATCHWORK_CI_FILE"
> +          cat "$PATCHWORK_CI_FILE"
> +
> +      - name: Run tests
> +        if: success()
> +        uses: actions/github-script@v7
> +        with:
> +          script: |
> +            const fs = require('fs');
> +
> +            const output = fs.readFileSync(process.env.PATCHWORK_CI_FILE, 'utf8');
> +            if (output.length === 0) {
> +              console.log("'patchwork-ci.sh verify' output is empty");
> +              return;
> +            }
> +
> +            const lines = output.split('\n');
> +            if (lines.length === 0) {
> +              console.log("No new patch-series found");
> +              return;
> +            }
> +
> +            for (const data of lines) {
> +              const [series_id, series_mbox] = data.split('|');
> +              if (series_id.length === 0 || series_mbox.length === 0) {
> +                console.log(`Malformed data: ${data}`);
> +                continue;
> +              }
> +
> +              const response = await github.rest.actions.createWorkflowDispatch({
> +                owner: context.repo.owner,
> +                repo: context.repo.repo,
> +                ref: context.ref,
> +                workflow_id: 'ci-docker-build.yml',
> +                inputs: {
> +                  SERIES_ID: series_id,
> +                  SERIES_MBOX: series_mbox,
> +                }
> +              });
> +
> +              console.log(response);
> +            }

The code looks sane to me, though I'm not expert on github CI.

You can add my:

Acked-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
