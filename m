Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A61C433F5
	for <ltp@archiver.kernel.org>; Mon, 29 Nov 2021 11:06:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 769143C5DF0
	for <ltp@archiver.kernel.org>; Mon, 29 Nov 2021 12:06:12 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 167283C2183
 for <ltp@lists.linux.it>; Mon, 29 Nov 2021 12:06:02 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2AA85600141
 for <ltp@lists.linux.it>; Mon, 29 Nov 2021 12:06:01 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5C346212CB;
 Mon, 29 Nov 2021 11:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638183961;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=su0deqCifw2eI0CwA0XnZ5KRCl6VSLoIQqSUpnXvIw8=;
 b=Fr5DSwl/JBYmuG7q1/fPubpzOj3TB4SRBSRPJ4MgqcupyFTQEwzftGGNXYrWqaAiotFXtc
 iOa3oW45MROP9T/SJVDd14o+VFOEGcKZ0kecfNoByzHm/H7qYP5pxSNax+poVDOsQ8D612
 66racl4iFdlu9lh/HKi00nkXXoaiVek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638183961;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=su0deqCifw2eI0CwA0XnZ5KRCl6VSLoIQqSUpnXvIw8=;
 b=dUz1rTfzIj3+NZmzDv0yhO/mQp3WYmSI7l/P/PqrxIRtW/DBz+11JTebhGLbf8IxzRWIxq
 dR7E/6YSgPqtiDBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2A26A13B4B;
 Mon, 29 Nov 2021 11:06:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0gC+CBm0pGEKBwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 29 Nov 2021 11:06:01 +0000
Date: Mon, 29 Nov 2021 12:05:59 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, Joerg Vehlow <lkml@jv-coder.de>,
 Li Wang <liwang@redhat.com>
Message-ID: <YaS0F9/ZyPtZi5zE@pevik>
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC] Using shellcheck for shell make check
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

checkbashisms does not detect all things: e.g. not catching {1..$FILE_COUNT}
[1]. Maybe we should reconsider using *also* shellcheck as Joerg suggested
(keep checkbashisms).

I don't like shellcheck output, but it can detects errors checkbashisms cannot
detect (checkbashisms is regexp based, but shellcheck IMHO evaluates the code).
Also it's configurable, thus ve could disable check we don't like or enable only
what we want to check. Or we can run just --severity=warning or
--severity=error. If you're not against it, I can have look into this.

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/YZy5HNteJmoicTtJ@pevik/



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
