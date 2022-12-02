Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7722CC4321E
	for <ltp@archiver.kernel.org>; Fri,  2 Dec 2022 13:09:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 017CB3CC43A
	for <ltp@archiver.kernel.org>; Fri,  2 Dec 2022 14:09:51 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 49C1C3CA956
 for <ltp@lists.linux.it>; Fri,  2 Dec 2022 14:09:42 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CA10A30A8D4
 for <ltp@lists.linux.it>; Fri,  2 Dec 2022 14:09:41 +0100 (CET)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A655E1F88C;
 Fri,  2 Dec 2022 13:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669986580;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0idnbKqmsGtrJOkZyEPROmHLQqcJoyVx39fJRuiH39M=;
 b=S0z4rZmvFh9sUT6aOfPK46pIEeJQTD8EkWzybgLTCzXFQpyckl/G8xaIMt+S1gIWtSKq4V
 Q21rmrmLgw50Le/hvBXb2YWsIFQvRMhA9tGPAUjEer098IfvqwLITj8SL/owBzibXMJV3j
 jvMea0ed7/AKwpGTbo7ihwCFJWSWUt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669986580;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0idnbKqmsGtrJOkZyEPROmHLQqcJoyVx39fJRuiH39M=;
 b=WLfeLhgL1c/TEq5DzmzkAmgLW0VJuWOHP3GOX4NlMSUmXeNvC57DZUv7F/wfmXEmU7856d
 amjDPbhT7pVvTTDw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 70FC9133DE;
 Fri,  2 Dec 2022 13:09:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id B1/KGBT5iWOEQgAAGKfGzw
 (envelope-from <pvorel@suse.cz>); Fri, 02 Dec 2022 13:09:40 +0000
Date: Fri, 2 Dec 2022 14:09:38 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>, ltp@lists.linux.it
Message-ID: <Y4n5Es6nvz8oe+I1@pevik>
References: <20221202114205.11077-1-mdoucha@suse.cz> <Y4nxfJrxPQ6AiTFI@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y4nxfJrxPQ6AiTFI@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cve-2017-16939: Improve and fix test
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

> > +++ b/testcases/cve/cve-2017-16939.c
> > @@ -29,50 +29,63 @@

> >  #define BUFSIZE 2048
> Actually, BUFSIZE needs to be removed too.
> I'll do it before merge.

Merged with the change above.
Thank you!

Kind regards,
Petr

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
