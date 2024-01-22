Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F57C47DAF
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 11:17:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 776E23CEF1F
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 12:17:22 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 556913CC774
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 12:17:05 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5D3CB20022E
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 12:17:03 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5B83A22224;
 Mon, 22 Jan 2024 11:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705922223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uvb+GEqMsPC2wdrJNpEyAv381sr3W3SBpWeX49DiSq8=;
 b=Kp/beaPPZGfjCo3oABu4uiZ+1PSnkrDq4Fy7R8QF1G6yMDY8ORhwB/KRCgStNKWBP0OveE
 olHc8s4KeHasdaXcITJ4+qsE2NxSXtUnVOQkA7aiTE8g6F2+UB8FPA9du+A36kieOj0XfI
 aZ17rFqkqIsnxYZRJ7wpYhEek3oY6zA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705922223;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uvb+GEqMsPC2wdrJNpEyAv381sr3W3SBpWeX49DiSq8=;
 b=eET5cvMeKu81XdKeJHtqGaI88W4mODxueyk0yN/4m1+5yX0JNclKO5E+Z+zniUrAEpHZ9n
 Lp2iSDSd6pVooOBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705922223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uvb+GEqMsPC2wdrJNpEyAv381sr3W3SBpWeX49DiSq8=;
 b=Kp/beaPPZGfjCo3oABu4uiZ+1PSnkrDq4Fy7R8QF1G6yMDY8ORhwB/KRCgStNKWBP0OveE
 olHc8s4KeHasdaXcITJ4+qsE2NxSXtUnVOQkA7aiTE8g6F2+UB8FPA9du+A36kieOj0XfI
 aZ17rFqkqIsnxYZRJ7wpYhEek3oY6zA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705922223;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uvb+GEqMsPC2wdrJNpEyAv381sr3W3SBpWeX49DiSq8=;
 b=eET5cvMeKu81XdKeJHtqGaI88W4mODxueyk0yN/4m1+5yX0JNclKO5E+Z+zniUrAEpHZ9n
 Lp2iSDSd6pVooOBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D47613995;
 Mon, 22 Jan 2024 11:17:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ExYAEq9OrmVqFwAAD6G6ig
 (envelope-from <akumar@suse.de>); Mon, 22 Jan 2024 11:17:03 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Mon, 22 Jan 2024 12:17:03 +0100
Message-ID: <2309742.ElGaqSPkdT@localhost>
Organization: SUSE
In-Reply-To: <20240122063830.62477-1-pvorel@suse.cz>
References: <20240122063830.62477-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.93 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; MID_RHS_NOT_FQDN(0.50)[];
 REPLY(-4.00)[]; HAS_ORG_HEADER(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; CTE_CASE(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.83)[85.11%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] keyctl05: Require root
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

Reviewed-by: Avinesh Kumar <akumar@suse.de>


On Monday, January 22, 2024 7:38:30 AM CET Petr Vorel wrote:
> Modprobe always require root.
> 
> Fixes: f4e132233 ("keyctl05: Add modprobe dns_resolver")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> I hate require root for setup work, but in this case is needed in order
> to get dns_resolver tested. I'm sorry to forget on this.
> 
> Kind regards,
> Petr
> 
>  testcases/kernel/syscalls/keyctl/keyctl05.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/testcases/kernel/syscalls/keyctl/keyctl05.c
> b/testcases/kernel/syscalls/keyctl/keyctl05.c index a79a5763b..78ac490da
> 100644
> --- a/testcases/kernel/syscalls/keyctl/keyctl05.c
> +++ b/testcases/kernel/syscalls/keyctl/keyctl05.c
> @@ -228,6 +228,7 @@ static void do_test(unsigned int i)
>  }
> 
>  static struct tst_test test = {
> +	.needs_root = 1,
>  	.tcnt = 3,
>  	.setup = setup,
>  	.test = do_test,


Regards,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
