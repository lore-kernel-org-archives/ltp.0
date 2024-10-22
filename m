Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFB9D1CDAB
	for <ltp@archiver.kernel.org>; Tue, 22 Oct 2024 07:50:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 59EB73C6F75
	for <ltp@archiver.kernel.org>; Tue, 22 Oct 2024 09:50:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 453F63C6EA3
 for <ltp@lists.linux.it>; Tue, 22 Oct 2024 09:50:22 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4A9E31A0153C
 for <ltp@lists.linux.it>; Tue, 22 Oct 2024 09:50:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 36BA01FD0E;
 Tue, 22 Oct 2024 07:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1729583418;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G+PQkMpPloFxa5xTgQwqCThmzs7Uwi0XZ4bPLJYf4B8=;
 b=rEfNlazAk031BhOUesUrFG9xLgyMm036XAyhrSQFie1sgMIpj3A+ykAio8Sjmq94TspV7X
 /xlKcF365ERpsYzr46fzBi1CpHP+5OtZNg87l5q9VbpJ+fdJN9/3Zs3E0i19ohT5b7dL+8
 seq4z3MXJ8I4TyyLw2nv/v1MhQ05cM8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1729583418;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G+PQkMpPloFxa5xTgQwqCThmzs7Uwi0XZ4bPLJYf4B8=;
 b=YOoyRhGVPMNBm24b0oVaVhuXZh0HSmCPHt400wIRgpC5jeSfYLduj03PZZSyJdrLBO4N+9
 N77f2MQ3bbwGkFDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1729583417;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G+PQkMpPloFxa5xTgQwqCThmzs7Uwi0XZ4bPLJYf4B8=;
 b=vdc8MQnT+sNJOGj11xmZu0YLX3gJBrOKy9a7cdW+zz0cnhJ9vIlMzDHbEDg31k+2YbU7kp
 B2YCiZA8/UCwtqLzzv5aNwTjbm26N7oG3CEyBPOamcM0ZmkakqjD4aaOMkW2LaVQuqAEuh
 bUwqjiIja8TJY39xeeBeUn+wS2aWAko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1729583417;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G+PQkMpPloFxa5xTgQwqCThmzs7Uwi0XZ4bPLJYf4B8=;
 b=FB9BxG+DIfsUdX4bnzH2yzg6RQ6TlMoScwen+jCIUujqwh1SG3DXZdc0XpO937zsex5Lt8
 8y2OdG76NmtvuVBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 587B413AC9;
 Tue, 22 Oct 2024 07:50:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id J+WkFDhZF2eibgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 22 Oct 2024 07:50:16 +0000
Date: Tue, 22 Oct 2024 09:50:06 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ma Xinjian <maxj.fnst@fujitsu.com>
Message-ID: <20241022075006.GA503931@pevik>
References: <20241022061434.2610583-1-maxj.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241022061434.2610583-1-maxj.fnst@fujitsu.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] clnt_create: Determine the return value of
 clnt_create()
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
Cc: chuck.lever@oracle.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Ma,

Thanks a lot, merged!

BTW I see some of the tests already had error control and they just printed 1
instead of rpc_createerr.cf_stat (rpc_clnt_call_dataint.c). Some other report
5 (e.g. rpc_clnt_call_performance.c). 

> Determine the return value of clnt_create() to avoid segmentation fault
> when executing clnt_destroy() when the return value of create is NULL.

...
> +++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_create/rpc_clnt_create_stress.c
> @@ -59,6 +59,12 @@ int main(int argn, char *argc[])

>  		if (clnt != NULL)
>  			nbOk++;
> +		else {
> +			clnt_pcreateerror("err");
> +			printf("%d\n", rpc_createerr.cf_stat);
> +
> +			return 1;
> +		}
>  	}

I reversed the condition of the check (more readable code):

		if (clnt == NULL) {
			clnt_pcreateerror("err");
			printf("%d\n", rpc_createerr.cf_stat);

			return 1;
		}

		nbOk++;

The testsuite contains a lot of duplicity and useless code. It could be
rewritten to use simple macro to remove most of the redundancy.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
