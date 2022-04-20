Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED031C433EF
	for <ltp@archiver.kernel.org>; Wed, 20 Apr 2022 09:50:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D61DA3CA6BD
	for <ltp@archiver.kernel.org>; Wed, 20 Apr 2022 11:50:19 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B8BE43CA699
 for <ltp@lists.linux.it>; Wed, 20 Apr 2022 11:50:08 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1DF766002ED
 for <ltp@lists.linux.it>; Wed, 20 Apr 2022 11:50:07 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3C47C1F757;
 Wed, 20 Apr 2022 09:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1650448207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RSyAgMZgCqKB5525g4Y77Q7201WcnUARXkU4sPHR2Ac=;
 b=WXC80Fn6eXGUE7PEE7TG0Q321xCrvq/8GPeYSBD+k9au+Exi7Y6ikWcAIPCvLupD96n13x
 laxmBpKqbRNu7T0O4U37k1IrMzRQzFIFKKkuToJpYCXNGdFlH+2hXqOnX0ozVFHaTELf7w
 Y72KYU8XRZ1DQaV8StkZOe+DIpOabwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1650448207;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RSyAgMZgCqKB5525g4Y77Q7201WcnUARXkU4sPHR2Ac=;
 b=PhhlT7BXEcksBl0+HhA5OrwDXtaRyJUqjnYJX1WNB1fPuUzfzIAMk3vEz5Npm4D/JsRx5S
 zhHmGNM8KxOg4LBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2A30413A30;
 Wed, 20 Apr 2022 09:50:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0pQICk/XX2KrGwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 20 Apr 2022 09:50:07 +0000
Date: Wed, 20 Apr 2022 11:52:23 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Yl/X1+luV4T+ZA+1@yuki>
References: <20220331113324.14742-1-mdoucha@suse.cz>
 <20220331113324.14742-3-mdoucha@suse.cz> <Ylf2hd82r1pLFlbd@yuki>
 <a4feb22e-d4f8-00dd-5970-0832dc90ddfa@suse.cz>
 <Yl/OO5mBXW5h1e91@yuki>
 <1148ebad-dce6-dbcb-63e5-db7131f914b9@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1148ebad-dce6-dbcb-63e5-db7131f914b9@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] KVM test infrastructure
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> >> I didn't #include the tst_res_flags.h because the main LTP include
> >> directory is not passed to the preprocessor when compiling KVM payload.
> >> I'd have to do it like this:
> >> #include "../../../../include/tst_res_flags.h"
> > 
> > And I guess that this is on purpose right?
> > 
> > As we can easily add it by adding -I$(top_src_dir)/include/ to the
> > CFLAGS.
> 
> Yes, this is on purpose. I want any #include of standard LTP headers to
> trigger error because the vast majority of the functions declared in
> there are not available in KVM guest library. So should I add the dirty
> #include or should I keep the duplicate definition of tst_res flags?

I wonder what is cleaner solution. I do not like either one that much to
be honest, but I guess that I slightly prefer the ugly relative path
over copying the definitions over.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
