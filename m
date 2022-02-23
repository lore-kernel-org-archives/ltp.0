Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 414F8C433F5
	for <ltp@archiver.kernel.org>; Wed, 23 Feb 2022 12:42:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A6EB3C97A8
	for <ltp@archiver.kernel.org>; Wed, 23 Feb 2022 13:42:19 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA4973C690D
 for <ltp@lists.linux.it>; Wed, 23 Feb 2022 13:42:10 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 50A351A019B1
 for <ltp@lists.linux.it>; Wed, 23 Feb 2022 13:42:09 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7F72B1F3A3;
 Wed, 23 Feb 2022 12:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645620129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=30Cf9/muSiEf8oLqeqhQ9h0EN2amnWy2E7cIiYvCAl8=;
 b=txzTGd7lcPdIqT9cy47UaylAPJNsN3amonzkI4u+779GMy3d3odYl5jH3vHY3/7g5GpALZ
 ThFyOcAjyzDjis/j//VHBeLtjPcfVBXHZrQw80TDrQRVq8REamfALzZv1BiCkGNMSiCibX
 Ot09TTqJ6OvsSv8tsaV9nPbGlLQGpm0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645620129;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=30Cf9/muSiEf8oLqeqhQ9h0EN2amnWy2E7cIiYvCAl8=;
 b=H8Go6GNlN4NLPeYwRxFyVNOqiFehbDZ98T9TtgJYrehP8zznWVl1RVFcozTs+QmIPR+gsT
 0SjzhVVU7hQijeBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6C9EF13D36;
 Wed, 23 Feb 2022 12:42:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2IinGaErFmIzEgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 23 Feb 2022 12:42:09 +0000
Date: Wed, 23 Feb 2022 13:44:22 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YhYsJqnjs1kIt13E@yuki>
References: <20220222155514.2255913-1-nikita.yushchenko@virtuozzo.com>
 <YhUKtWP8dwNBAcmy@yuki>
 <26fe8a19-8557-5a63-7e5f-fb126e8eed95@virtuozzo.com>
 <YhUe1yp0ukdUJs1V@yuki> <YhUsAQKHl8w9AyRq@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YhUsAQKHl8w9AyRq@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] testcases/lib: introduce sysctl wrapper
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
Cc: kernel@openvz.org, ltp@lists.linux.it,
 Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > Ah, right. But I guess that adding a simple tool that would behave just
> > as echo but the first parameter would be filename may be cleaner
> > solution than wrapping around the sysctl command.
> +1. If really requested please create C binary testcases/lib/tst_sysctl.c.
> Code which use simple SAFE_FILE_PRINTF() as many C code does would be fairly
> simple, more portable and probably faster than shell script. FYI we tend to
> rewrite shell code into C.

I would even call it tst_write since it's pretty generic tool that does
write to a file.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
