Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B606C4321E
	for <ltp@archiver.kernel.org>; Mon,  5 Dec 2022 11:47:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A00133CC204
	for <ltp@archiver.kernel.org>; Mon,  5 Dec 2022 12:47:41 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 29B753CAC66
 for <ltp@lists.linux.it>; Mon,  5 Dec 2022 12:47:31 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 859E961AD9D
 for <ltp@lists.linux.it>; Mon,  5 Dec 2022 12:47:30 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 5B9EF1FD94
 for <ltp@lists.linux.it>; Mon,  5 Dec 2022 11:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1670240850;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=/ynPACEE8X+9oaprmC8nlzAqbLVI9S4fBbpUFC/0cVQ=;
 b=XryCBzJlVnjExpy4oKcyjmrEjHwE5aZDe0kXelGYK25oFFj3N5qb+z4TGpHFz0MfmVhovF
 ztemInXbrQHRGsoCQFzZrwgrAeI7YA7JJyCZcoY0lS51e/Bzn40j3GjkSFoGhx2lttDH/6
 Xvrup+hKLJ0WoIH0Hm7bURLnRV127Fc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1670240850;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=/ynPACEE8X+9oaprmC8nlzAqbLVI9S4fBbpUFC/0cVQ=;
 b=/XsjFBjJZ8wsjUIqXnnETxKBvztYTyctctj3j8OcMYfOtDrQHGKfD/5xrL5Z4MZynzxAei
 oMacJFiZ8G0h90CA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 38AF12C141
 for <ltp@lists.linux.it>; Mon,  5 Dec 2022 11:47:30 +0000 (UTC)
User-agent: mu4e 1.8.11; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: ltp@lists.linux.it <ltp@lists.linux.it>
Date: Mon, 05 Dec 2022 11:44:30 +0000
Organization: Linux Private Site
Message-ID: <87v8mqt6lq.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] text/html mails should now be rejected
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
Reply-To: rpalethorpe@suse.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

I have disallowed HTML message attachments in mailman because they are
not supported by a variety of tooling. Please complain loudly if this
breaks something.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
