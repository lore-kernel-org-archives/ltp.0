Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD37FCDB46E
	for <ltp@archiver.kernel.org>; Thu, 12 Oct 2023 09:45:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 21A423CEE52
	for <ltp@archiver.kernel.org>; Thu, 12 Oct 2023 11:45:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5CAB03C888B
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 11:45:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 90C4C600435
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 11:45:19 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E22DC1F74B;
 Thu, 12 Oct 2023 09:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697103918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=leDWbY4EaIUl/P62jFnjYdUqGR2zvvBMK07SnEhY6FY=;
 b=IC6YgUFCKy9HmkOxZYA6+fh22NYf3bISfKTN1hQ+6aK40aCAjVJ68nd5ogUhgr/aidJNfa
 0xmSmsnT2tM7g8Mn0KCXqhMtQlTJ/62p/9HJJEFPDMDGRaXveBoPTFumHhas78UKnMi6To
 f1LPWnAgLgAMDiFXD5kJja+Ipev4WvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697103918;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=leDWbY4EaIUl/P62jFnjYdUqGR2zvvBMK07SnEhY6FY=;
 b=CoBTshpxkXbngrP0I1lAM7x2WXRja+UTwjy2AEVCvTVXIEu53PDJYmZLgM+XmdJ2n3nhxN
 FANteAm5ojbv2kDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CDA07139ED;
 Thu, 12 Oct 2023 09:45:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OfgiMS7AJ2V9dwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 12 Oct 2023 09:45:18 +0000
Date: Thu, 12 Oct 2023 11:46:02 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZSfAWoGD1ceYPYzW@yuki>
References: <20231012094254.611488-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231012094254.611488-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] README: Document gdb debugging
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Oct 12, 2023 at 11:42:54AM +0200, Petr Vorel wrote:
> From: Petr Vorel <petr.vorel@gmail.com>
> 
> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> ---
>  README.md | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/README.md b/README.md
> index fa9559398..adeac5fdf 100644
> --- a/README.md
> +++ b/README.md
> @@ -215,6 +215,12 @@ SUSE also publishes a
>  [smaller LTP container](https://registry.opensuse.org/cgi-bin/cooverview?srch_term=project%3D%5Ebenchmark+container%3D.*)
>  that is not based on the Containerfile.
>  
> +Debugging with gdb
> +==================
> +
> +To get stack trace of a crashing test in gdb it's useful to
> +[`set follow-fork-mode child`](https://ftp.gnu.org/old-gnu/Manuals/gdb/html_node/gdb_25.html).

Maybe we should start with a sentence that actually describes how things
are organized so that it's clear why this is needed. Maybe just:

The new test library runs the actual test, i.e. the `test()` function in
a forked process. To get the stack trace of a crashing test it's needed
to [`set ....


>  Developers corner
>  =================
>  
> -- 
> 2.42.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
