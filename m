Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DE7C433FE
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 10:36:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 50D6B3CD9D7
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 11:36:31 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6191A3C0181
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 11:36:21 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8BAFA60007C
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 11:36:20 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 79C9F225CE;
 Mon,  7 Nov 2022 10:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1667817380;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gTHZV2y4QNQ5VeQtIwS7zWJnTqwqEHfQRgw6RbKB3X0=;
 b=ZU4v1L3QvRJ4sTSJzmtA+tuXJJDn3W/i5aFfOQyk5GmscKO6OhqsO4se7lUlYKLj4lnGWd
 3f4tlcC7bzTtpKF+ZV+aAgv/m+S6vUe1j0pj0kJkCj2i/FOEObuSmNMAkh4uznHtM4Uj20
 Z/ukWQTkisxshVszE8R1RMeiQJG/0ao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1667817380;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gTHZV2y4QNQ5VeQtIwS7zWJnTqwqEHfQRgw6RbKB3X0=;
 b=oAel+Gtk8yQ74mNYzMwpQ76QpxMq9k1CyiLInOaYgtcU4WrtGave3N2jQFUoQfYVLHAkdm
 hgadqJftlKXf4aDQ==
Received: from UNKNOWN (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id EEA422C141;
 Mon,  7 Nov 2022 10:36:19 +0000 (UTC)
References: <20221020133715.256521-1-akihiko.odaki@daynix.com>
 <Y1GFvU/ixieqDSq6@pevik> <Y1JiQSWlxVSkhuoq@yuki> <Y1KBzfdqbibHmAa3@pevik>
 <Y1KTyn/9pv5lvbhj@yuki> <Y1KanyaTySzBG7xN@pevik> <Y1KdjE6gu/ILnEO6@yuki>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 07 Nov 2022 10:27:23 +0000
Organization: Linux Private Site
In-reply-to: <Y1KdjE6gu/ILnEO6@yuki>
Message-ID: <87cz9zxd98.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] tst_test.sh: Normalize the locale
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
Reply-To: rpalethorpe@suse.de
Cc: Yan Vugenfirer <yan@daynix.com>, ltp@lists.linux.it,
 Yuri Benditovich <yuri.benditovich@daynix.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> Yep. I thought more about pure C API programs. Mostly they don't have any locale
>> related code, but sometimes they call other programs via shell (e.g.
>> tst_system(), but there are more).
>>
>> I also aimed for consistency between C and shell API.
>> That's why I thought we should consider setlocale() on LC_ALL and LANG in
>> lib/tst_test.c. But maybe I'm wrong.
>
> I do not think that we need to call setlocale() in tst_test.c we do not
> have any support for locales there anyways.
>
> As for any programs executed from these as long as environment is
> propagated correctly the locale would be set to C once the corresponding
> program calls setlocale() in main().
>
> -- 
> Cyril Hrubis
> chrubis@suse.cz

Well I see no argument against setting the locale to C. So I have merged
it.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
