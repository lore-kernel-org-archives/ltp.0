Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D28F9C5B572
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 06:27:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 874C63D8D59
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 08:27:31 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D5963D86E3
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 08:27:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1DF87600063
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 08:27:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4331D827DB;
 Thu, 13 Aug 2026 06:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786602425;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c0rh/VlMAmoGjSOusVE1iXYC/43xizuJN+uWlHPQH1Y=;
 b=IuTlN0DrAiSfkENDpl2/PwdJbn8WD9GgqdJzw/81juX+DLeC3WWuh6SfCN1wZ5MYosnZBw
 TJHCEzO0p2SWl2kZxoScREOP8q54SAhryU/z8vA6F/apHcc1jAuTNv3CoVeDxtpDLXfLv9
 wx4aGWup6MY8GziDIfNF8N9egkDAVoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786602425;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c0rh/VlMAmoGjSOusVE1iXYC/43xizuJN+uWlHPQH1Y=;
 b=JnToFKWOYTQgi9HkKESwuKHJM5sHReB4bZMIsuDkDUskzN3fdVDjVUrg7uPuWNQWY6AJdQ
 QaImV+UpydZqFgCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786602421;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c0rh/VlMAmoGjSOusVE1iXYC/43xizuJN+uWlHPQH1Y=;
 b=FyhuhdDAyCQueNLi+F8QWb9suWMfuHFALZsNvphuv4zsph81b4ImpfvHwRe1xPIUArebvS
 WxtqvEgOrxH3FIeDaIK2F3yCaUmb832sLfjNSfPMWVusd5cEEn0LdgOcdi7FagvWwBtqG7
 p3snWHVcuZG0A6xBRHfJ07EAyRHPMZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786602421;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c0rh/VlMAmoGjSOusVE1iXYC/43xizuJN+uWlHPQH1Y=;
 b=sLNmORkhMZt2mlM6+N0RdWzjU8egaENASHSt2uXS6DG/HlxkWs6ZyJawip/ahdWP11o0MW
 kOY/807/C+gndQDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8411777C94;
 Thu, 13 Aug 2026 06:27:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ADi2HrRjfWrJEAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 13 Aug 2026 06:27:00 +0000
Date: Thu, 13 Aug 2026 08:26:54 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <avinesh.kumar@suse.com>
Message-ID: <20260813062654.GA1801742@pevik>
References: <20260813023216.79848-1-li.wang@linux.dev>
 <95979fc4-682a-4fa5-8833-28f9b9573be8@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <95979fc4-682a-4fa5-8833-28f9b9573be8@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MISSING_XM_UA(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscall: set FORK in tst_sig for some old tests
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
Cc: ltp@lists.linux.it, Li Wang <liwang@hygon.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Hi Li,

> Thank you for addressing this.

Li, thanks for fixing it!

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>

> Reviewed-by: Avinesh Kumar <avinesh.kumar@suse.com>

> Petr,
> I think we should use this solution instead of reverting the patch.

+1, thanks for a notification

Kind regards,
Petr

> Regards,
> Avinesh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
