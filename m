Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC09C27C79
	for <ltp@archiver.kernel.org>; Thu, 20 Jun 2024 05:36:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F32D3CF2D7
	for <ltp@archiver.kernel.org>; Thu, 20 Jun 2024 07:36:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A11283CF2D7
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 07:36:23 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E3769201117
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 07:36:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1820821AC0;
 Thu, 20 Jun 2024 05:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718861781;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZR8AsRivQ9/WqLcPMSrJCHWAKNf+AOL95Zr6ZyLbtcg=;
 b=mH1pQU422SNvfk3UWdabW8ZssqGLm4Jq0AK0ZFf9TUasAB8RVAEbv3hbyGeIXrt6Qq4+Vo
 GTrKY7AYGPClA9h1NrPCLmGz01TV8ZAhQY9tBqlH91UJy6gdMSPCA9boyqkuHu48Q6d6je
 3HcIHT9gLHfwTGheVOGW4MQ1wXKVkAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718861781;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZR8AsRivQ9/WqLcPMSrJCHWAKNf+AOL95Zr6ZyLbtcg=;
 b=SXCwwKsZCeAshr+QRW7DQxwRa7SJs/uGEmvIAgvXvEMP5QhNuL3UNzWL1A4c3CN5gGwNXB
 80/nNAj8V9L4G9Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718861780;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZR8AsRivQ9/WqLcPMSrJCHWAKNf+AOL95Zr6ZyLbtcg=;
 b=A2IUK+Plij9MWwKu0fWXn9ymlfbKLQACmXgvNcsjaetwyikAnkuFgoGX6za0QYf46kxw4B
 Mk66EI4UE4qynwT4gpNexdYTL8NJaE/Y4mipWb/zL+rV1cKkeFABm6siVKhTOM2Z4M5eYB
 HCSsiQcL5428ukVgFQD919nBSApZqo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718861780;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZR8AsRivQ9/WqLcPMSrJCHWAKNf+AOL95Zr6ZyLbtcg=;
 b=mtrBficikdsTLTEVGpxxV+TM+tEfW/LVpjfiNf6n9ooOE7aC8rQsM9hgN9EKt9g9ndIw+z
 omUObboAzFagHGBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8FD513AC1;
 Thu, 20 Jun 2024 05:36:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MbnxMtO/c2b7LQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 20 Jun 2024 05:36:19 +0000
Date: Thu, 20 Jun 2024 07:36:18 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240620053618.GD537887@pevik>
References: <20240527222947.374475-1-pvorel@suse.cz>
 <37603272-8ea2-4828-96df-4b6381cc26ad@suse.com>
 <ZldFa-3CXXbVKmVW@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZldFa-3CXXbVKmVW@yuki>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] lib: Add TINFO_WARN
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

> Hi!
> > I'm not sure about this. Why not enabling TINFO + TWARN combination instead?

> > tst_res(TINFO | TWARN, "my message");

> That's even more confusing. Does that propagate into results or not?

> To be honest we even have problem deciding if we should use TINFO or
> TWARN in some cases and adding third variant would make things even
> worse, sicne we would have three options.

> So I would really keep just TINFO which is something that is printed by
> default but does not propagate into results and TWARN that is printed as
> well but propagates into results.

> Maybe it would be even better to actually remove TWARN. That way we
> would have only TFAIL and TBROK that propagate into results since TWARN
> is kind of lesser TBROK anyways...

Understand to your points. But tst_res TWARN is quite understandable
(simple warning, which propagates), IMHO better to use than
tst_res TBROK. But sure, feel free to go ahead and send a patch to remove TWARN.

BTW I was also surprised how many tests use tst_resm TBROK ... / tst_resm(TBROK,
...) followed by exit 1 / exit(1). These should be converted to tst_brkm TBROK /
tst_resm(TBROK, ...).

Other thing is, that I would prefer to have macro for tst_res(TINFO, "WARNING: ...")
e.g. WARNING(...) would produce tst_res(TINFO, "WARNING: ...") from simple point I
don't like to hardwire text (there can be typos). BTW more than for this rare
case I would prefer to have macros for .tags, e.g. LINUX_GIT(43a6684519ab) would
produce {"linux-git", "43a6684519ab"} CVE(2017-2671) would produce {"CVE", "2017-2671"}
(again, typos).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
