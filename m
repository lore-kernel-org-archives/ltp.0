Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A88C433F5
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 15:27:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E17F83CA0AF
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 16:27:18 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BECB83C952F
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 16:27:09 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DAB3E1000655
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 16:27:08 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 10CA3218D9;
 Wed, 16 Feb 2022 15:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645025228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wSndpL5foCLlIAIQ64ZNHVJ4nW4d0X3m8AWBr5AZRfo=;
 b=HDjDqP3IiGkrEd//kw1+/jK5/FJtlECuLO7jmG/scMeY7AzRE7TkLERxdexh4QYIfXGkpp
 OyRJcqhO09onHnp/ht/4zefjQborHuYVCoQGQ33px03Qd29fhJYBeMXIHKGmfT1k2KT0r6
 0x4ge5F0mKi76x/qTQXAT9u6erS+1vA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645025228;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wSndpL5foCLlIAIQ64ZNHVJ4nW4d0X3m8AWBr5AZRfo=;
 b=ioKBFmvBY3gYwZx164gHk6log5tPeR9sW5GG+OxM9Cb5SnUVtZfEQXaoZQzRoqpaOdEdLO
 szhVQbaOegzYtJAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F020613B15;
 Wed, 16 Feb 2022 15:27:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HJgnOcsXDWIWMQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 16 Feb 2022 15:27:07 +0000
Date: Wed, 16 Feb 2022 16:26:56 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Yg0XwAb1LOso6dtf@rei>
References: <20220208140322.6842-1-rpalethorpe@suse.com>
 <20220208140322.6842-3-rpalethorpe@suse.com>
 <CAEemH2fjSLAdY4xO7WMekGX=3sPFjt0xVknNxJedk1-agsb3zQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fjSLAdY4xO7WMekGX=3sPFjt0xVknNxJedk1-agsb3zQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] API/cgroup: Shorten cgroup to cg in most
 symbols
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> To be honest, I only wanted that tst_cg_test pointer :).
> 
> But I have no objection to renaming 'tst_cgroup_*' to 'tst_cg_*'
> for the whole APIs. (Though I don't like it)
> 
> Let's hear more voices from peers.

Actually I like it, having the common prefix shortened to just tst_cg_
makes it easier to read, at least for me.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
