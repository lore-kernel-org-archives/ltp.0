Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493F7F46102
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 12:48:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 97DF73E556B
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 13:48:31 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 035FF3E2B05
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 13:48:12 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8806A600100
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 13:48:12 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 617844D316;
 Mon, 23 Mar 2026 12:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774270091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+qEjuQevZqyO6CweEJ3yMgcImI5q9b4HueNFxukrWBY=;
 b=Joufvc4LWJSq7FAiyLxOvK3eftVpWbt6T9/kZmomAxH9awKWNXAVAEB1wCzq44cvXUBJUL
 5Y8KWvf6XHOHBOiXGwdEroH/RdMrsBeZhkaoDe0YkmiTPZYKrTKSd0GKcMRlSDu5piellC
 bGeLX/mt34GiqrogeCwBNR6Lmogowuo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774270091;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+qEjuQevZqyO6CweEJ3yMgcImI5q9b4HueNFxukrWBY=;
 b=phPD/sWHKY+NCUhR9uzFeKRKV62IZ4Ll1ZjQEekREjG+PT4lbbGN54bV7kN7l3J9IK3MQn
 B7+7XAictIAO8uAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774270091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+qEjuQevZqyO6CweEJ3yMgcImI5q9b4HueNFxukrWBY=;
 b=Joufvc4LWJSq7FAiyLxOvK3eftVpWbt6T9/kZmomAxH9awKWNXAVAEB1wCzq44cvXUBJUL
 5Y8KWvf6XHOHBOiXGwdEroH/RdMrsBeZhkaoDe0YkmiTPZYKrTKSd0GKcMRlSDu5piellC
 bGeLX/mt34GiqrogeCwBNR6Lmogowuo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774270091;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+qEjuQevZqyO6CweEJ3yMgcImI5q9b4HueNFxukrWBY=;
 b=phPD/sWHKY+NCUhR9uzFeKRKV62IZ4Ll1ZjQEekREjG+PT4lbbGN54bV7kN7l3J9IK3MQn
 B7+7XAictIAO8uAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44A2A438A4;
 Mon, 23 Mar 2026 12:48:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YQThD4s2wWkNMwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 23 Mar 2026 12:48:11 +0000
Date: Mon, 23 Mar 2026 13:48:07 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Disha Goel <disgoel@linux.ibm.com>
Message-ID: <acE2h36MCMzgouJy@yuki.lan>
References: <20260323110735.55473-1-disgoel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260323110735.55473-1-disgoel@linux.ibm.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/ustat: Skip tests on Btrfs using
 .skip_filesystems
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
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
