Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF030C3ABAC
	for <ltp@archiver.kernel.org>; Fri,  2 May 2025 09:36:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 178B53CBE2E
	for <ltp@archiver.kernel.org>; Fri,  2 May 2025 11:36:07 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B7063CA17A
 for <ltp@lists.linux.it>; Fri,  2 May 2025 11:35:51 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 54D74600861
 for <ltp@lists.linux.it>; Fri,  2 May 2025 11:35:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8113321262;
 Fri,  2 May 2025 09:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746178549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LD1IMAyxdw/q3kRxmKLHjC6/Xfbw0fKkBMzxiVmoBeA=;
 b=iermgcQwhRqb5VWVEcaY3EHD88TFp4aMN60VHDyQw+K0QjTK2U3qOmC5UwTB4oKYIR+EDu
 9CA95F41Ef2n6AwH4M7pFH9Xk5oroQ0Utx9egoKr0fsk2Sk5bq2kOcdosiLeCZF8MRNEsf
 i/XZyMdlMVauqz/pFyoYanpW3p+Obzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746178549;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LD1IMAyxdw/q3kRxmKLHjC6/Xfbw0fKkBMzxiVmoBeA=;
 b=/b5alKTBv5Ntd/iKKx3Ls6aRqUzkhJOD9FusY7ApHzkTH1cJ3mwaK64b1qZpC/9zc1xdrV
 CAHW7sXbm6TZgkDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746178549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LD1IMAyxdw/q3kRxmKLHjC6/Xfbw0fKkBMzxiVmoBeA=;
 b=iermgcQwhRqb5VWVEcaY3EHD88TFp4aMN60VHDyQw+K0QjTK2U3qOmC5UwTB4oKYIR+EDu
 9CA95F41Ef2n6AwH4M7pFH9Xk5oroQ0Utx9egoKr0fsk2Sk5bq2kOcdosiLeCZF8MRNEsf
 i/XZyMdlMVauqz/pFyoYanpW3p+Obzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746178549;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LD1IMAyxdw/q3kRxmKLHjC6/Xfbw0fKkBMzxiVmoBeA=;
 b=/b5alKTBv5Ntd/iKKx3Ls6aRqUzkhJOD9FusY7ApHzkTH1cJ3mwaK64b1qZpC/9zc1xdrV
 CAHW7sXbm6TZgkDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7017D1372E;
 Fri,  2 May 2025 09:35:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tW3rGfWRFGhNWwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 02 May 2025 09:35:49 +0000
Date: Fri, 2 May 2025 11:36:23 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aBSSF8bPjoKz8Umx@yuki.lan>
References: <20250430130417.43523-1-pvorel@suse.cz>
 <20250430130417.43523-4-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250430130417.43523-4-pvorel@suse.cz>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[tst_run.sh:url,tst_env.sh:url,test.sh:url,tst_loader.sh:url,yuki.lan:mid,imap1.dmz-prg2.suse.org:helo,suse.cz:email];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, yuki.lan:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/4] shell lib: Add basic support for test setup
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
> test.sh
>   . tst_env.sh
>   . tst_loader.sh
>     tst_run_shell test.sh
>       . tst_env.sh
>       . tst_loader.sh

Maybe we can even simplify this a bit more if we move the part that
calls the tst_run_shell before we parse the whole shell test.

I guess that this would work:

test.sh
  . tst_loader.sh
    tst_run_shell test.sh
    . tst_loader.sh
      . tst_env.sh
    . tst_run.sh


 And the tst_loader.sh would be untouched and the code you are adding to
 tst_loader.sh in this patch would go to the tst_run.sh.

 That way we would include tst_env.sh in the tst_loader.sh on it's
 second invocation, parse the shell test code and finally in tst_run.sh
 setup the cleanup trap, call the setup and run the actual test.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
