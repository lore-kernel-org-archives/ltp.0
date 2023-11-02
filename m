Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC124C4332F
	for <ltp@archiver.kernel.org>; Thu,  2 Nov 2023 13:15:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 81ED53CCD79
	for <ltp@archiver.kernel.org>; Thu,  2 Nov 2023 14:15:27 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB73B3CC8C8
 for <ltp@lists.linux.it>; Thu,  2 Nov 2023 14:15:17 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4B63A200741
 for <ltp@lists.linux.it>; Thu,  2 Nov 2023 14:15:16 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 51E8F1F8D4
 for <ltp@lists.linux.it>; Thu,  2 Nov 2023 13:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698930916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wB7A9LB9dQg6ydih0YkX6QHMvMS8L/GQaKaH8Ck4MOI=;
 b=2PTjgU+I3uuyFaDwti3vcJB4DO+dhLqvH27ShQ+hQU4xUZOJgnzOSKXM1ZWbBPhORMiF8T
 bgq27qvpWsyCzfVR+yJrB6D5bt8+wZam/URNEIO5a1YObXyPbYOdajEFU9c24rlczCQNfS
 cIYqp6yuo8/SFDY6KdAmLTf+HSmCnAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698930916;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wB7A9LB9dQg6ydih0YkX6QHMvMS8L/GQaKaH8Ck4MOI=;
 b=jOW856SFgTGC/CSUUKyCz1d7zI7Xwa23CFhLm471hs4cayBLu0wDqrgK5OCUi6dJHxpXsl
 EqleqK+t00YMU5AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 407AD13584
 for <ltp@lists.linux.it>; Thu,  2 Nov 2023 13:15:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SmqpDuSgQ2WFYQAAMHmgww
 (envelope-from <mkittler@suse.de>)
 for <ltp@lists.linux.it>; Thu, 02 Nov 2023 13:15:16 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Thu, 02 Nov 2023 14:15:15 +0100
Message-ID: <1880149.tdWV9SEqCh@linux-9lzf>
In-Reply-To: <ZTvQMpx-q4LnBJgN@yuki>
References: <20231026114716.17545-1-mkittler@suse.de>
 <20231026114716.17545-5-mkittler@suse.de> <ZTvQMpx-q4LnBJgN@yuki>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v9 4/4] Extend ioctl02 to test termio and termios
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

Am Freitag, 27. Oktober 2023, 16:58:58 CET schrieb Cyril Hrubis:
> Hi!
> 
> > +static void chk_tty_parms_termio(void)
> > +{
> > +	int i, flag = 0;
> > 
> > +	CMP_ATTR(termio_exp, termio, c_line);
> > +	CHECK_CONTROL_CHARS(termio);
> > +	CMP_ATTR(termio_exp, termio, c_lflag);
> > +	CMP_ATTR(termio_exp, termio, c_iflag);
> > +	CMP_ATTR(termio_exp, termio, c_oflag);
> 
> I do not see a reason why this cannot be a function, the only difference
> would be that we would have to do cmp_attr(termio_exp, termio->c_line)
> instead.

I'm not sure whether I understand this suggestion. If the first parameter is 
still just termio_exp, how would that function know what field in termio_exp to 
compare with? I guess you had an invocation like this in mind:

cmp_attr(termio_exp->c_line, termio->c_line)

That would be possible. The repetition of the attribute name is not nice. Of 
course we'd also lose the attribute name in the error message. This could be 
solved by passing it as string and doing a dynamic string concatenation in the 
function, so the invocation would look like this:

cmp_attr(termio_exp->c_line, termio->c_line, "c_line")

This would also mean two additional implicit type conversions per call of this 
function within chk_tty_parms_termio() because termio uses smaller sized types 
than termios and the cmp_attr() function would need to decide on one type (and 
we'd have to pick the larger size).

So I'm honestly not sure whether any of this is better than just making it a 
macro or maybe I don't understand your suggestion.



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
