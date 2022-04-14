Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B83C433EF
	for <ltp@archiver.kernel.org>; Thu, 14 Apr 2022 19:03:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CDA6E3CA5FA
	for <ltp@archiver.kernel.org>; Thu, 14 Apr 2022 21:03:27 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 99B233CA3B8
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 21:03:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1CC8F2005D0
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 21:03:11 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1429D21613;
 Thu, 14 Apr 2022 19:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1649962991;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lN99G0X9TfTnpJWGd508oHSDaMuGo+G9XBfOFf3SBRI=;
 b=1iITSigjjZvqkqWKhHvMtL/cdeZyAmdu85sdDmk4kbzeBe4Gpy9bmJVNEvVjiDWDUhQykn
 p+tYyJpHHJGAKDWeS2yOFOoE/Rt5S1EkUQRdU/bMhVxYHnMsfHY/ziBk5bkVISWgYFlozI
 aN/7SFzfdCDTNXTm9YdHauHVvfR8Ogo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1649962991;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lN99G0X9TfTnpJWGd508oHSDaMuGo+G9XBfOFf3SBRI=;
 b=WYmyu5sakVSaDrCvLJUOIw4cVHTI0xI1u8Jqoub7ZhEsTB+WsGjEjHdCj3kxnEvd8ydydW
 L5VlCJDOFA9CHBAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BBCED13A86;
 Thu, 14 Apr 2022 19:03:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IWWQK+5vWGIIOQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 14 Apr 2022 19:03:10 +0000
Date: Thu, 14 Apr 2022 21:03:05 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <Ylhv6eH5aGHppbBJ@pevik>
References: <20220414145357.3184012-1-amir73il@gmail.com>
 <20220414145357.3184012-2-amir73il@gmail.com>
 <Ylg51UMuHsxbHRSA@pevik>
 <CAOQ4uxgd4dGjr8HmUc4uO_jp6JoHHNjzCTddt8_BJ6OWGUEeRg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgd4dGjr8HmUc4uO_jp6JoHHNjzCTddt8_BJ6OWGUEeRg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/6] syscalls/fcntl: New test for DN_RENAME
 (dnotify)
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
Cc: Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Amir,

> Sorry forgot to run it with -i

> Here is the fix if you want to apply it yourself:

> --- a/testcases/kernel/syscalls/fcntl/fcntl39.c
> +++ b/testcases/kernel/syscalls/fcntl/fcntl39.c
> @@ -89,6 +89,12 @@ static void verify_dnotify(void)

>         SAFE_CLOSE(parent_fd);
>         SAFE_CLOSE(subdir_fd);
> +
> +       /* Cleanup before rerun */
> +       SAFE_RENAME(TEST_DIR2 "/" TEST_FILE, TEST_FILE);
> +       SAFE_RENAME(TEST_DIR2, TEST_DIR);
> +       got_parent_event = 0;
> +       got_subdir_event = 0;
>  }

Thanks for a quick fix, patch merged (with minor changes to keep checkpatch happy).

Kind regards,
Petr

> Thanks,
> Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
