Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88249C6FA99
	for <ltp@archiver.kernel.org>; Fri, 10 Mar 2023 07:30:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 220B73CB7E5
	for <ltp@archiver.kernel.org>; Fri, 10 Mar 2023 08:30:31 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 56C2F3CB05E
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 08:30:19 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2EF85200983
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 08:30:18 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A98DD22A27;
 Fri, 10 Mar 2023 07:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678433416;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w8YSOODOL1au7/c/pUtrzC1cBKhw0kuJL2W3yFX0SpE=;
 b=C+IB+d4YDYFJh7Vxu5ORrO4JIDOqGZPISkySDH47R+BQ1aqi6oecA4K7UUw1MTqJLIeUm9
 KOz3dD399dGGYpEyA4+htcRV6FwcmAH0N0oRARHJyd/hv3OZ6KoUcpoJdGWlrD4IyqZuv4
 QmlsjCBvLpsCk+0DAYzvTzMM+Ql0BgE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678433416;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w8YSOODOL1au7/c/pUtrzC1cBKhw0kuJL2W3yFX0SpE=;
 b=YnVD5C9Qhfx/eo6+O0M5s6q+zPhHLc+AzcnG0R5NomQzuoZjl/78XpiHp8dMa+CiIRv70S
 BvBHjonmviZUgFDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 750D813A77;
 Fri, 10 Mar 2023 07:30:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KkCdGYjcCmRafwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 10 Mar 2023 07:30:16 +0000
Date: Fri, 10 Mar 2023 08:30:14 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <20230310073014.GA2216@pevik>
References: <fb88846b13f4b0c39c6e3f44b67454f5c3857f6d.1678432077.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fb88846b13f4b0c39c6e3f44b67454f5c3857f6d.1678432077.git.jstancek@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] endian_switch01.c: drop unused main4()
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

Hi Jan,

> Drop the unused main4() and move AT_HWCAP check to check_le_switch_supported().
> Tested on RHEL7.9 3.10 based kernel, and RHEL9.0 5.14.0 based kernel.

+1

I also tried to test it but currently have only VM, which is obviously without
endian switch:

endian_switch01.c:57: TCONF: fast endian switch (0x1ebe) N/A

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
