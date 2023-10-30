Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D36C4332F
	for <ltp@archiver.kernel.org>; Mon, 30 Oct 2023 07:28:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 23B873CC988
	for <ltp@archiver.kernel.org>; Mon, 30 Oct 2023 08:28:36 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EFF6C3C88CE
 for <ltp@lists.linux.it>; Mon, 30 Oct 2023 08:28:25 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DD6701A0120B
 for <ltp@lists.linux.it>; Mon, 30 Oct 2023 08:28:23 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 433AD21D06;
 Mon, 30 Oct 2023 07:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698650901;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/LxSMhhhJ+DdrsqcJXJcXyL/2u6igIQveMe9M8vzsxU=;
 b=pwBlh7XnA/r62raXs4iTIJo2LgyQFdyM54p+B1uHuzdhl76T7dgj5/qcrT+rxQ0lxHON7f
 bshc+qhNO0DuAznKlR6KsDNvCVVb8Uc5jrkJ5yXBY3MOiFsjoultptytja6wcaNp9wQ2vP
 uxbU1iRw7wrJPMdZEndXFBHKzOY/Mx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698650901;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/LxSMhhhJ+DdrsqcJXJcXyL/2u6igIQveMe9M8vzsxU=;
 b=QELtrn8nRygswGtX+EqX8kHHE1/VRHGXVYLzEj/Zg6HuBQZw/yVOKqhQF7CO0O6WNbFV3q
 Hp3X5bcMgy0YNzDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 19467138F8;
 Mon, 30 Oct 2023 07:28:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 17foBBVbP2UETAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 30 Oct 2023 07:28:21 +0000
Date: Mon, 30 Oct 2023 08:28:19 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20231030072819.GA9167@pevik>
References: <20231027174322.710674-1-pvorel@suse.cz>
 <CAEemH2fuA+YfFGNzSResMprEeT8+zhO1S_2Kscc14d2T828YYw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fuA+YfFGNzSResMprEeT8+zhO1S_2Kscc14d2T828YYw@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-6.22 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.92)[99.65%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] compat_16.mk: Cleanup INTERMEDIATE object
 syntax
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
Cc: Stanislav Kholmanskikh <stanislav.kholmanskikh@bell-sw.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

> Hi Petr,

> Petr Vorel <pvorel@suse.cz> wrote:


> >  DEF_16                 := TST_USE_COMPAT16_SYSCALL



> > ...



> > -%_16: CPPFLAGS += -D$(DEF_16)=1

Not related to this effort: shouldn't we convert all CPPFLAGS to CFLAGS? Or the
LTP build system it just prepared to the crazy ideas about using C++? :)


> Seems we need to keep this one line, otherwise it can't transfer the
> 'TST_USE_COMPAT16_SYSCALL=1' macro in the compilation.

Ah, thanks!

> The rest looks good to me.
> Reviewed-by: Li Wang <liwang@redhat.com>

BTW I'm going to push it with you as an author + with your Signed-off-by: tag
(you're effectively the autor of the code) and with my RBT.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
