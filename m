Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56053CD1292
	for <ltp@archiver.kernel.org>; Thu,  4 Apr 2024 13:53:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C40CF3CE3E0
	for <ltp@archiver.kernel.org>; Thu,  4 Apr 2024 15:53:46 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B9FA3CE2AA
 for <ltp@lists.linux.it>; Thu,  4 Apr 2024 15:53:31 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 16C80613F1B
 for <ltp@lists.linux.it>; Thu,  4 Apr 2024 15:53:30 +0200 (CEST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AFC4A5DA09;
 Thu,  4 Apr 2024 13:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712238809;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mDJDCDVYQZlz2Z7MGcraRx98B2e4MHcEdasz3kUjeCQ=;
 b=EIpdvUvwgsLpSfuGHL0V/dqWEb+Q4JOhDqEKwJB6IQAjfU0260lNBjI9JJIYbOE+kCSApc
 JBMLSn4+BuuWI+RGo4qJpAQvhiEthjgc9MhjJrEQ83U9R38s8uGjxNEhSxuw5+hnAK6GUc
 4WXtLTz+rdK21fVCQF5PewGYyuKteoo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712238809;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mDJDCDVYQZlz2Z7MGcraRx98B2e4MHcEdasz3kUjeCQ=;
 b=0vACxkCd/teHycFiEZKT9C02SymA/+uEwRpXe/2rY+MHwod0MxmgaiKgagiZ2bous7CJrT
 mnBz7Jvuuo1qEGCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712238809;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mDJDCDVYQZlz2Z7MGcraRx98B2e4MHcEdasz3kUjeCQ=;
 b=EIpdvUvwgsLpSfuGHL0V/dqWEb+Q4JOhDqEKwJB6IQAjfU0260lNBjI9JJIYbOE+kCSApc
 JBMLSn4+BuuWI+RGo4qJpAQvhiEthjgc9MhjJrEQ83U9R38s8uGjxNEhSxuw5+hnAK6GUc
 4WXtLTz+rdK21fVCQF5PewGYyuKteoo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712238809;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mDJDCDVYQZlz2Z7MGcraRx98B2e4MHcEdasz3kUjeCQ=;
 b=0vACxkCd/teHycFiEZKT9C02SymA/+uEwRpXe/2rY+MHwod0MxmgaiKgagiZ2bous7CJrT
 mnBz7Jvuuo1qEGCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8684713298;
 Thu,  4 Apr 2024 13:53:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 7WXcHtmwDmYQfAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 04 Apr 2024 13:53:29 +0000
Date: Thu, 4 Apr 2024 15:53:23 +0200
From: Petr Vorel <pvorel@suse.cz>
To: yangfeng <yangfeng59949@163.com>
Message-ID: <20240404135323.GB526878@pevik>
References: <20240329154715.7130-1-yangfeng59949@163.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240329154715.7130-1-yangfeng59949@163.com>
X-Spamd-Result: default: False [-1.36 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 BAYES_HAM(-0.86)[85.48%]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; FREEMAIL_TO(0.00)[163.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[163.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
 RCPT_COUNT_THREE(0.00)[3]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sctp: bugfix for
 utils/sctp/func_tests/test_1_to_1_events.c
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
Cc: yangfeng <yangfeng@kylinos.cn>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

> event not initialized to 0 causes "Got a notification,
> expecting a datamsg" issues

Out of curiosity which architecture, kernel version, toolchain version and
distro do you see the issue? I cannot reproduce it on any of systems we test.

...
> +++ b/utils/sctp/func_tests/test_1_to_1_events.c
> @@ -96,6 +96,7 @@ main(void)
>  	/* Create the client socket.  */
>  	clt_sk = test_socket(AF_INET, SOCK_STREAM, IPPROTO_SCTP);

> +	memset(&event, 0, sizeof(struct sctp_event_subscribe));

Obviously correct.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Note, nowadays it'd be enough to initialize as:

struct sctp_event_subscribe event = {0};

But because we use the old style with the rest of the functions, memset() is OK.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
