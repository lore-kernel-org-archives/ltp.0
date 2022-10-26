Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFBCC38A2D
	for <ltp@archiver.kernel.org>; Wed, 26 Oct 2022 13:08:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3AC633CA76F
	for <ltp@archiver.kernel.org>; Wed, 26 Oct 2022 15:08:57 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D7D03C9FF2
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 15:08:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EE2AA1000AE9
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 15:08:46 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 938DE1F8BE;
 Wed, 26 Oct 2022 13:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666789724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+XZwvQaKwjTK+LB6PwPquBqyVcuwk/Ttis23sLuxULc=;
 b=3CYSChQ1hCMAt9Rn/KLsF1jdkkOWBHlb3GIZUB8WCGcbanq+l7SAGlkvmbZrV8zMe8dpqR
 /wZdnARL+Fxnypr0gvHnvF6Drft0SvgvzYRJqOUXhyqiE9pSIwLXBY4d2Z29bWr3biSbiW
 xgFBsAJJErFubzv+2hq/OmkCmZeh9U4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666789724;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+XZwvQaKwjTK+LB6PwPquBqyVcuwk/Ttis23sLuxULc=;
 b=jVhiOCnifOlNqYbMlk1XDY7k3isHL+i7yzVkCFsLDzVtNC567ZNFRqvTpW9rKBhoxmU3Dw
 5Rxtok0PAMtbEbDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7E40913A77;
 Wed, 26 Oct 2022 13:08:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id THGIHVwxWWMJWAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 26 Oct 2022 13:08:44 +0000
Date: Wed, 26 Oct 2022 15:10:25 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <Y1kxwfYPNZ/g5MEl@yuki>
References: <20221021155740.8339-1-mdoucha@suse.cz> <Y1MCbP1yjLOuoPLb@pevik>
 <CAASaF6ySEcVE=b-7nGy+FeLyg_6dNMjL6J_bivjZ6JYzSx5b=w@mail.gmail.com>
 <3f3dca4e-79d9-9e5b-293f-f27c6644dec8@suse.cz>
 <CAASaF6xHrcko8Wcq_UAaLY9hscYZAGrSSJe=P07HYoOFXaoTyw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6xHrcko8Wcq_UAaLY9hscYZAGrSSJe=P07HYoOFXaoTyw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] save_restore: Check whether path is writable
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
> The case 2) looks like it could apply to non-optional paths too. So maybe
> best option would be to drop "!" and "?" prefixes and turn them into flags/enums
> which can be then combined together.
> 
> "/proc/sys/kernel/pid_max", 0, val // TCONF if path doesn't exist
> "/proc/sys/kernel/pid_max", SR_MUST_EXIST, val // TBROK if path doesn't exist
> "/proc/sys/kernel/pid_max", SR_MAY_EXIST, val // if exists, save it
> "/proc/sys/kernel/pid_max", SR_CONST_VAL, val // if already has val,
> skip saving it
> "/proc/sys/kernel/pid_max", SR_MAY_EXIST | SR_CONST_VAL, val // if
> exists check it already has val, otherwise save it
> 
> What do you think? Would that make it easier to represent/implement all cases?

Ah Jan already proposed something similar to what I had in mind. I agree
with moving the attributes from the path to a separate field too.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
