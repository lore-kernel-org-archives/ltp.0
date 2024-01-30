Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF56C46CD2
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 12:37:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A506E3CF96F
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 13:37:32 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7EC8E3C8E42
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 13:37:18 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id ACF60200077
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 13:37:17 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CB28F1F839;
 Tue, 30 Jan 2024 12:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706618236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=os6bWvhGghGBqZn1/+qU2GS11gPhdCHllj+0YPc0G1w=;
 b=VX451dNqbrTBrn9kjMl3UywI147ya1lF6zoudI0cSVPHzDSEolOjjH06iJNqK/V7CPZlxj
 I6joLaRuSM62TobXf/fotggT6kPTt7hgPB8jdJwRSnfk9xhZD4rtKaG1qyGxzzzWPeUxx8
 1xfdtkv86W2QNTkYkEuzBfyTk1Ecr5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706618236;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=os6bWvhGghGBqZn1/+qU2GS11gPhdCHllj+0YPc0G1w=;
 b=vwAFdDodhJrmrHNwG8kOW2D0haO2FtQTLvcbwPLJq+K82D0TZPP1h3miVgj3P1iXiPCqXf
 StAT7UEIW31vEEBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706618236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=os6bWvhGghGBqZn1/+qU2GS11gPhdCHllj+0YPc0G1w=;
 b=VX451dNqbrTBrn9kjMl3UywI147ya1lF6zoudI0cSVPHzDSEolOjjH06iJNqK/V7CPZlxj
 I6joLaRuSM62TobXf/fotggT6kPTt7hgPB8jdJwRSnfk9xhZD4rtKaG1qyGxzzzWPeUxx8
 1xfdtkv86W2QNTkYkEuzBfyTk1Ecr5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706618236;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=os6bWvhGghGBqZn1/+qU2GS11gPhdCHllj+0YPc0G1w=;
 b=vwAFdDodhJrmrHNwG8kOW2D0haO2FtQTLvcbwPLJq+K82D0TZPP1h3miVgj3P1iXiPCqXf
 StAT7UEIW31vEEBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA7C413A66;
 Tue, 30 Jan 2024 12:37:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SKC9LHztuGVQUQAAD6G6ig
 (envelope-from <akumar@suse.de>); Tue, 30 Jan 2024 12:37:16 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 30 Jan 2024 13:37:16 +0100
Message-ID: <12395443.O9o76ZdvQC@localhost>
Organization: SUSE
In-Reply-To: <20240129174647.635944-1-pvorel@suse.cz>
References: <20240129174647.635944-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.39 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; HAS_ORG_HEADER(0.00)[];
 RCVD_COUNT_THREE(0.00)[3]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; CTE_CASE(0.50)[];
 BAYES_HAM(-0.09)[64.64%]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.cz:email,readme.md:url,opensuse.org:url];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] README: Mention -f param for strace
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

Hi Petr,

On Monday, January 29, 2024 6:46:47 PM CET Petr Vorel wrote:
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi,
> 
> probably obvious, but it does not harm to mention it.
> Hopefully users will find it.
> 
> Kind regards,
> Petr
> 
>  README.md | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/README.md b/README.md
> index 6147c5f6f..abbea8f4f 100644
> --- a/README.md
> +++ b/README.md
> @@ -215,12 +215,13 @@ SUSE also publishes a
>  [smaller LTP
> container](https://registry.opensuse.org/cgi-bin/cooverview?srch_term=proje
> ct%3D%5Ebenchmark+container%3D.*) that is not based on the Containerfile.
> 
> -Debugging with gdb
> -==================
> +Debugging with gdb and strace
> +=============================
> 
>  The new test library runs the actual test, i.e. the `test()` function in a
>  forked process. To get stack trace of a crashing test in gdb it's needed to
> [`set follow-fork-mode
> child`](https://ftp.gnu.org/old-gnu/Manuals/gdb/html_node/gdb_25.html). +To
> trace test with strace use `-f`.
For a second I thought ltp tests has `-f` option.
So maybe if we can make it absolutely clear, or maybe it is just me. :D

Reviewed-by: Avinesh Kumar <akumar@suse.de>

> 
>  Developers corner
>  =================

Thanks,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
