Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A89C4725D
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 16:31:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8CC293CE3DC
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 17:31:23 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 728C23CC85D
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 17:31:09 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 16B6B204713
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 17:31:08 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6A0191FD29;
 Fri, 19 Jan 2024 16:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705681868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nhzl7vlO93HwdQuIi2Yy2EUPv/L+W8wmDo96croN/oY=;
 b=WOVUzGZiUyncmcVjTI3vqS/t1NakKCtm/3QkbtF5EtPCAet2mW61H1317uhmoM7FhMVFOc
 BjWiG1/4aJBn28DAMQyCRvYBdZ8FFsb8WN8jPXzz39s2daRg/vLv1Q8kkeRsjyZdxXw2Pv
 xsvKrcodW1jDrmT+WF1KEjwRDb5RZs8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705681868;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nhzl7vlO93HwdQuIi2Yy2EUPv/L+W8wmDo96croN/oY=;
 b=XZyNNTJpqU8nGoiARBchYxHIwnt+zIhp/MOIqU5F0H3j7xbQ9U0yGvyuqEZSwjvBnlqUZr
 g7pHmUZPsG3bRtBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705681866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nhzl7vlO93HwdQuIi2Yy2EUPv/L+W8wmDo96croN/oY=;
 b=SkEXBhWR22UB1SC2qQ8yOVtGNhh9Ur/bU5LU3Jd1k2+Hou35iZYv5RHdq2CwVUYu48paTy
 2ZsVp75B2a3EjUAskoI2mqfTDlCIxdRYSSZDb5UcGF1erJsMF/tj5H/gbff0G7MQiHDPkL
 YZRZ6VXrjAEJlRrhcvA3jTLwrWZu5Hc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705681866;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nhzl7vlO93HwdQuIi2Yy2EUPv/L+W8wmDo96croN/oY=;
 b=ZdSRQbESfqhPaDc1KrJAYf0TlqdPaG9Fk19XyIyR9eSil7VHiIGNZ2KYmGaelRqJsXA+G1
 IUCldRcjrAoDQ9Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4BABE136F5;
 Fri, 19 Jan 2024 16:31:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yF53EcqjqmXvWQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 19 Jan 2024 16:31:06 +0000
Date: Fri, 19 Jan 2024 17:31:16 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Zaqj1KxiyUNi_pfQ@yuki>
References: <20231031160918.17845-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231031160918.17845-1-pvorel@suse.cz>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.57 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.77)[84.39%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] tst_test.sh: Print test command + params
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
> +	tst_res TINFO "Running: $(basename $0) $TST_ARGS"

If you think that it's important I suppose this is probably safe enough
for the release.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
