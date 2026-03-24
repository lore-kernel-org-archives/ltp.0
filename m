Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D5AAF54AD7
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 16:00:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 11FB03E5B8C
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 17:00:17 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A831D3E1712
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 16:59:57 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 24774600658
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 16:59:55 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 384DA5BD5B;
 Tue, 24 Mar 2026 15:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774367995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=05vzY2E/nouTUwDyNd8YLJY6cxjpW4C4hKroux60JAM=;
 b=a0cpdj1mbZxX73ZScW2/+Tx61VjpBoRIF7r4NSgq2+4BZFYs2yZ/EoaOTbi5EfBqRPpU/Z
 CNi7TMbSSvIcst3ZB4ozaOWQayHmRKFhefEtFXrDiitILr5VsAgECosRxoj3pnjuo3hWL9
 skA0Qk5mWg74nHB/GRdMKPnnGW1Druo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774367995;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=05vzY2E/nouTUwDyNd8YLJY6cxjpW4C4hKroux60JAM=;
 b=6+j6bLMtrQuWAqEWpsY9dw5dZBu+BcsECcXqAqnjOZM+VjcU7zzg+WYsIP7+drCJfyJs16
 ogb2HF3AtHOFlcBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774367995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=05vzY2E/nouTUwDyNd8YLJY6cxjpW4C4hKroux60JAM=;
 b=a0cpdj1mbZxX73ZScW2/+Tx61VjpBoRIF7r4NSgq2+4BZFYs2yZ/EoaOTbi5EfBqRPpU/Z
 CNi7TMbSSvIcst3ZB4ozaOWQayHmRKFhefEtFXrDiitILr5VsAgECosRxoj3pnjuo3hWL9
 skA0Qk5mWg74nHB/GRdMKPnnGW1Druo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774367995;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=05vzY2E/nouTUwDyNd8YLJY6cxjpW4C4hKroux60JAM=;
 b=6+j6bLMtrQuWAqEWpsY9dw5dZBu+BcsECcXqAqnjOZM+VjcU7zzg+WYsIP7+drCJfyJs16
 ogb2HF3AtHOFlcBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D2E543F05;
 Tue, 24 Mar 2026 15:59:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id p0ENBfu0wmn/RgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 24 Mar 2026 15:59:55 +0000
Date: Tue, 24 Mar 2026 17:00:00 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: sowmya.indranna@ibm.com
Message-ID: <acK1AIOCm0qpXsat@yuki.lan>
References: <20260324143332.2200651-1-sowmya.indranna@ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260324143332.2200651-1-sowmya.indranna@ibm.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid, imap1.dmz-prg2.suse.org:helo,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] vmcp: skip test on non-s390x architectures
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
> The vmcp test is specific to s390x systems and is not supported on
> other architectures such as ppc64le. Currently, the test fails on
> unsupported platforms.
> 
> Add an architecture check to skip execution on non-s390x systems
> by reporting TCONF, avoiding false test failures.
> 
> Signed-off-by: Sowmya Indranna <sowmya.indranna@ibm.com>
> ---
>  testcases/commands/vmcp/vmcp_m.sh | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/testcases/commands/vmcp/vmcp_m.sh b/testcases/commands/vmcp/vmcp_m.sh
> index 3924a6e11..e40dec4bd 100644
> --- a/testcases/commands/vmcp/vmcp_m.sh
> +++ b/testcases/commands/vmcp/vmcp_m.sh
> @@ -15,6 +15,15 @@ TST_CNT=2
>  TST_TESTFUNC=vmcp_main
>  TST_NEEDS_CMDS="vmcp"
>  
> +# Check if running on s390x architecture
> +check_arch()
> +{
> +	local arch=$(uname -m)
> +	if [ "$arch" != "s390x" ]; then
> +		tst_brk TCONF "vmcp test requires s390x architecture, current: $arch"
> +	fi
> +}

The test has TST_NEEDS_CMDS="vmcp" it shouldn't even start unless there
is vmcp installed. And would expect that vmcp is not installed unless we
are on s390x.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
