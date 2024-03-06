Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4A7C5475B
	for <ltp@archiver.kernel.org>; Wed,  6 Mar 2024 12:44:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE3B73CFE39
	for <ltp@archiver.kernel.org>; Wed,  6 Mar 2024 13:44:57 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 784113CD783
 for <ltp@lists.linux.it>; Wed,  6 Mar 2024 13:44:42 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C3B95608A64
 for <ltp@lists.linux.it>; Wed,  6 Mar 2024 13:44:41 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0052576C1F;
 Wed,  6 Mar 2024 12:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709729079;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vcTWCc0aJ9gBZM5xDxP3TPrhBxjuMvsmjIFItBowNq4=;
 b=iOBm+Y4jY3tMYIEkYCHB7CHHWv9xTYUE6bMekFLVTwvkzdutw1oVysi/Ce2FGU+RigcYdc
 crRpqpb/zdcN23FRkSbxHDLNOloD7bGoYB0skGbszhjUd34Y0/MLDTPC80dJ8ho1jqDZg5
 OB1zuntMbkkYy37fZCv+p9lBurr0eZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709729079;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vcTWCc0aJ9gBZM5xDxP3TPrhBxjuMvsmjIFItBowNq4=;
 b=BaTS4g7FK77LRtRfETjlqZt45K9gga7yG+6DNNj3v1t1bKilUVvdYOlnemhVv13gl2V/yg
 wfcJZQHyAxKC0hBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709729078;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vcTWCc0aJ9gBZM5xDxP3TPrhBxjuMvsmjIFItBowNq4=;
 b=xocOTrAIn8F0+2uJ7ZpBjzQSu1kriGr9lHwvnxJO9935R9fPB410waRzvg/6ieGV9A8guJ
 z4rwrcJ/nzpMIbg75ktrgKveXaiwOZrT/UuhpKWybuhZfenVZ8vliBX5GO0ECMSMh7IyoY
 kFoNVCk57srVH25dTz7Y37sX5a5SMdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709729078;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vcTWCc0aJ9gBZM5xDxP3TPrhBxjuMvsmjIFItBowNq4=;
 b=8otr+BhZ/sUcY6nJzDKMFykgdsUyjR+cU4Z1XDvys+hV/VkOyckaPNCaSYRLNGzBMJ1R6H
 uCCfNcgxggLmaUDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C2D371377D;
 Wed,  6 Mar 2024 12:44:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id jaspLjVl6GV3UgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 06 Mar 2024 12:44:37 +0000
Date: Wed, 6 Mar 2024 13:44:36 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Dennis Brendel <dbrendel@redhat.com>
Message-ID: <20240306124436.GA746976@pevik>
References: <20240306085254.534940-1-dbrendel@redhat.com>
 <CAEemH2fi7pQUX2WVWqz1-px5reA3mcGjAHm=A3j3xnOVqF9vDg@mail.gmail.com>
 <20240306104110.GC558578@pevik>
 <4d7c9726-d74f-41da-982c-91abca628649@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4d7c9726-d74f-41da-982c-91abca628649@redhat.com>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xocOTrAI;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8otr+BhZ
X-Spamd-Result: default: False [0.48 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.01)[46.77%];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0052576C1F
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] munlockall: add test case that verifies memory
 has been unlocked
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

Hi Dennis,

> Hi Petr and Li,

> Thank you very much for your valuable feedback!

> What's left to do for me? Re-submit as v4 with sign-off and
> proper commit message?

v3 is ready to be merged, I'll add your SBT and cleanup the commit message,
while I'll be adding my and Li's RBT.

I'm just waiting a little bit because Cyril looked into this patchset,
he might have look (I merge tonight).

Kind regards,
Petr

> Thanks,
> Dennis

> On 3/6/24 11:41, Petr Vorel wrote:
> > Hi Dennis, Li,

> >> Hi Dennis,

> >> Good to see your patch soon, nice work!

> >> Next time remember to commit the patch with Signed-off-by.
> >>   `git commit -sm  xxxx`

> > +1 (planning to add that before merge).

> > Also these comments "Changes compared to v2:" should be below "---",
> > that way we can read them but they will not endup in the git commit message when
> > we apply the patch.

> > Kind regards,
> > Petr







-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
