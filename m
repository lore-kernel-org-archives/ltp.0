Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDFEC76196
	for <ltp@archiver.kernel.org>; Tue, 11 Apr 2023 14:29:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B6D003CC84E
	for <ltp@archiver.kernel.org>; Tue, 11 Apr 2023 16:29:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD9843C0123
 for <ltp@lists.linux.it>; Tue, 11 Apr 2023 16:29:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 53194200393
 for <ltp@lists.linux.it>; Tue, 11 Apr 2023 16:29:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 86B54219E2;
 Tue, 11 Apr 2023 14:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1681223385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=foVboWb5FTUvuZwtwRMapTwPJ/42OHrDhj7hzVHiKm4=;
 b=eIeb/DFXixS8Dq/DOOKdr6f+iNF+NkXO3AbcIVngMexfg44KAF4VAtzE09b9qON37B/bZk
 +5r/HE/rwTu84EJFFKDrHc88RZzR8FH+e21/GJn/9SMUmOoaYO38UetGvhkurIzl3sSoO9
 7KgMLCd/Ae2pRyeTU9rWkPIiYsTI4+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1681223385;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=foVboWb5FTUvuZwtwRMapTwPJ/42OHrDhj7hzVHiKm4=;
 b=ZH5/rmxJ8hjqY/X3xOLWCoMzXYgKnF9urGx7CRWguBxR1+kShaNEEAZDpQGLkfn7mX0qZg
 3en0/4A3OuurW/CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7021C13638;
 Tue, 11 Apr 2023 14:29:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /Uf9GdluNWSUWgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 11 Apr 2023 14:29:45 +0000
Date: Tue, 11 Apr 2023 16:30:51 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Enze Li <lienze@kylinos.cn>
Message-ID: <ZDVvG4Z17jfoWXGV@yuki>
References: <20230404030712.914700-1-lienze@kylinos.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230404030712.914700-1-lienze@kylinos.cn>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] gitignore: ignore GNU Global output files
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
Cc: ltp@lists.linux.it, enze.li@gmx.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Update .gitignore to ignore GNU Global outputs.
> 
> Signed-off-by: Enze Li <lienze@kylinos.cn>
> ---
>  .gitignore | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/.gitignore b/.gitignore
> index 915d22104..c626d7153 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -48,6 +48,12 @@ autom4te.cache
>  cscope.*
>  ncscope.*
>  
> +# GNU Global outputs
> +GPATH
> +GTAGS
> +GRTAGS
> +GSYMS

These files are not created by the LTP build system, so it does not make
sense to add them into the .gitignore file.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
