Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5AAFC433F5
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 13:55:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DDF223C9F0B
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 14:55:55 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E9F013C9B4B
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 14:55:46 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id ED3B21401438
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 14:55:45 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3114B1F3A2;
 Fri, 11 Feb 2022 13:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644587745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hh1dIIn4Ee5fzekG1eX7NPo2Fry7p5HWu1M5KpS2HmU=;
 b=mpxtypSanB9iRKQoFo2pC/nyMwK0ofmk9sdFfEfxBFsEXzfZsx9IYzvXF+ZwBsQP4rnVR7
 SaQepiMl0sRvLDJ2OXPMEKYUG9xbPCtW4QTn0lE9tzYtWMzUnyrAYZgRJssTKVMNV37OSv
 F1NK3O9wC29ThU/JcBgGsPMdlfbXvPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644587745;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hh1dIIn4Ee5fzekG1eX7NPo2Fry7p5HWu1M5KpS2HmU=;
 b=gyL3eHxOid/cpqaWlXODwVYsiof1u+lsiObdTwEPI+s9mcXxuqtknYo+hzijzd5l2ByhD9
 i0lgQnmhszPVgeAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 17B4713C8B;
 Fri, 11 Feb 2022 13:55:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LyZHBeFqBmJHHgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 11 Feb 2022 13:55:45 +0000
Date: Fri, 11 Feb 2022 14:57:53 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <YgZrYURgwCVvP/iN@yuki>
References: <20220210110712.23596-1-andrea.cervesato@suse.de>
 <20220210110712.23596-3-andrea.cervesato@suse.de>
 <YgZmTIZ0GtLYKF3D@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YgZmTIZ0GtLYKF3D@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] Rewrite process_vm_readv03.c test with new
 LTP API
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
> >  	for (i = 0; i < arr_sz - 1; i++) {
> > -		bufsz_single = rand() % (bufsz_left / 2) + 1;
> > -		arr[i] = bufsz_single;
> > -		bufsz_left -= bufsz_single;
> > +		int mod = MAX(1, (bufsz_left - arr_sz) / 2);
> > +
> > +		arr[i] = rand() % mod + 1;
>                                       ^
> 				      Haven't we discussed that passing
> 				      zero sized buffer will actually
> 				      test some corner cases?
> 
> We should just keep the original code here and just adjust the
> allocation of the buffers as:

Just to be clear, with 'the original' I mean the version you had in the
previous version of the patch.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
