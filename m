Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C0E1C4332F
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 10:55:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ACC4B3CC7D8
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 11:55:39 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 591FB3CB74B
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 11:55:29 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B024514010D9
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 11:55:28 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D31561F383
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 10:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1699008927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZPnP6B/l4ERRRvLNQjewl9YZ+ZRAHFmhmfSXIgjiDU4=;
 b=Df9uA1k8rkIK2/xfuwYjDSCzFQLIL3NyEWBQTm7Jw/bnei1XAlrc9FkYXHAtKTF4PxyOFK
 Tm2x7lYiD8ESIV4Sa04PUzVDoW0sdxyrKmExEHTWj3siEuGGXO1q3V0BGW2UG93n89xfBo
 5oEpf2Dsn3UhkkzKipAHIxHYa+KQ3xg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1699008927;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZPnP6B/l4ERRRvLNQjewl9YZ+ZRAHFmhmfSXIgjiDU4=;
 b=7BCsjHiqnjtLhApI/W6e4y/DIQXJLqem10DHUlYmkiLWfvCLsl/2odB6azd8a8uvvsQs1x
 WhTjqKnSAdAm0OCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C3F6E1348C
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 10:55:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bx3dLp/RRGXhJQAAMHmgww
 (envelope-from <mkittler@suse.de>)
 for <ltp@lists.linux.it>; Fri, 03 Nov 2023 10:55:27 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Fri, 03 Nov 2023 11:55:27 +0100
Message-ID: <2716876.mvXUDI8C0e@linux-9lzf>
In-Reply-To: <b600a737-bc44-4174-816a-58e24043589f@suse.cz>
References: <20231102152400.12705-1-mkittler@suse.de>
 <b600a737-bc44-4174-816a-58e24043589f@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Extend ioctl02 to test termio and termios
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Am Donnerstag, 2. November 2023, 17:35:24 CET schrieb Martin Doucha:
> Hi,
> the changes look good, just 3 small suggestions below that can be added
> during merge. Otherwise:
> 

Hi, I've just pushed v2 with these 3 small changes.




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
