Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03203C54FB3
	for <ltp@archiver.kernel.org>; Wed, 28 Aug 2024 13:34:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 76E903D2796
	for <ltp@archiver.kernel.org>; Wed, 28 Aug 2024 15:34:31 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 21C943C01D3
 for <ltp@lists.linux.it>; Wed, 28 Aug 2024 15:34:15 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 99B35600756
 for <ltp@lists.linux.it>; Wed, 28 Aug 2024 15:34:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9E96A21B76;
 Wed, 28 Aug 2024 13:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724852053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SJistlukBXxKWcPvEbsMNLhQgjWnAez7HDI8o2VGKh4=;
 b=K3EET9KTZr23WVurRccj4CVADzEgPvsZpt78Kz2/GDYsZvctpAiRYjkm8ON8VKBwmtH4IF
 MSr9RXNM6sGLNgokyqq3IdEL9kd+5DP90TibzIJksXw4yr6yVer+wlsW+TNMChvJOJrFoR
 qWej/HPJMXpdA0DJExWNb6voMlNDLys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724852053;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SJistlukBXxKWcPvEbsMNLhQgjWnAez7HDI8o2VGKh4=;
 b=EudmruQIcqjFAO2wONH4yTwUSydE3zsAEp2OXrUgYyKepJaX2zjD8uMxd/Qp0sEpfzLmZ8
 mPpZcKZAlhW8nsAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=K3EET9KT;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EudmruQI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724852053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SJistlukBXxKWcPvEbsMNLhQgjWnAez7HDI8o2VGKh4=;
 b=K3EET9KTZr23WVurRccj4CVADzEgPvsZpt78Kz2/GDYsZvctpAiRYjkm8ON8VKBwmtH4IF
 MSr9RXNM6sGLNgokyqq3IdEL9kd+5DP90TibzIJksXw4yr6yVer+wlsW+TNMChvJOJrFoR
 qWej/HPJMXpdA0DJExWNb6voMlNDLys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724852053;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SJistlukBXxKWcPvEbsMNLhQgjWnAez7HDI8o2VGKh4=;
 b=EudmruQIcqjFAO2wONH4yTwUSydE3zsAEp2OXrUgYyKepJaX2zjD8uMxd/Qp0sEpfzLmZ8
 mPpZcKZAlhW8nsAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E4C1138D2;
 Wed, 28 Aug 2024 13:34:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id atGUIVUnz2ZlKQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 28 Aug 2024 13:34:13 +0000
Date: Wed, 28 Aug 2024 15:33:05 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: chenguanxi11234@163.com
Message-ID: <Zs8nEXethFkWi-d5@yuki.lan>
References: <c82e787a5e77e6c7bc7cbac6338f4ce33b1079b2.1722929348.git.chen.haonan2@zte.com.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c82e787a5e77e6c7bc7cbac6338f4ce33b1079b2.1722929348.git.chen.haonan2@zte.com.cn>
X-Rspamd-Queue-Id: 9E96A21B76
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[163.com]; MISSING_XM_UA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_ENVRCPT(0.00)[163.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3]
 posix/conformance/interfaces/sem_timedwait/2-1: Fix test
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
Cc: yang.guang5@zte.com.cn, ltp@lists.linux.it, chen.haonan2@zte.com.cn
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
Pushed with a minor change, thanks.

> -		if (!WEXITSTATUS(i)) {
> +		if (WEXITSTATUS(i)) {
>  			return PTS_FAIL;
>  		}

The return value from WEXITSTATUS() is only valid if WIFEXITED() is true
so I've changed this part as:

@@ -71,7 +71,7 @@ int main(void)
                        return PTS_UNRESOLVED;
                }

-               if (WEXITSTATUS(i)) {
+               if (!WIFEXITED(i) || WEXITSTATUS(i)) {
                        return PTS_FAIL;
                }
                puts("TEST PASSED");

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
