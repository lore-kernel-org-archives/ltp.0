Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F011C433EF
	for <ltp@archiver.kernel.org>; Mon, 29 Nov 2021 14:22:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E09243C56A7
	for <ltp@archiver.kernel.org>; Mon, 29 Nov 2021 15:22:00 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E154A3C042E
 for <ltp@lists.linux.it>; Mon, 29 Nov 2021 15:21:51 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A0EAC6011C4
 for <ltp@lists.linux.it>; Mon, 29 Nov 2021 15:21:50 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DC6841FD3A;
 Mon, 29 Nov 2021 14:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638195709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3afcrMtQWUAcwlC5Sn3ISd6W8rZtmtrQogbuuxGjfOI=;
 b=X8tgTruGYDRRa7UKwhigvoMbgwt7LKq/uWZNDbIwy388zx6YS3XSjDisFdQiIiegCZLkl0
 bqjWcfnzBa2ucKZjBOsQPdW2nawEP0aWRcZZRPGnp/HWPpTWna2hv1o4BF256fmakFzqQX
 ZrmRhsFxydZGyao4hJG98Dp12SvsjZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638195709;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3afcrMtQWUAcwlC5Sn3ISd6W8rZtmtrQogbuuxGjfOI=;
 b=ABpqJ91hOrd0YhC9n1G+NEVWn2xOwzcdJZ8TycCDlfQ2BvCS2oTZndyg1jX7eJTop5Xc0n
 snNClVJ+sHFh2+CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C5F8C13B15;
 Mon, 29 Nov 2021 14:21:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QsH5Lv3hpGH+fAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 29 Nov 2021 14:21:49 +0000
Date: Mon, 29 Nov 2021 15:23:00 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <YaTiRIANkIEdZ6zL@yuki>
References: <bd1156e573b0ea8bbf1feeee2cc2b5f84953c1ae.1638192701.git.jstancek@redhat.com>
 <YaTghxZ06GNiNaY1@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YaTghxZ06GNiNaY1@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] open_posix_testsuite/lio_listio/2-1: increase
 number of requests
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
> >  static volatile int received_selected;
> > @@ -98,7 +98,7 @@ int main(void)
> >  		memset(aiocbs[i], 0, sizeof(struct aiocb));
> >  
> >  		aiocbs[i]->aio_fildes = fd;
> > -		aiocbs[i]->aio_offset = 0;
> > +		aiocbs[i]->aio_offset = i * BUF_SIZE;
> 
> The only concern I have is that if the filesystem does not support
> sparse files this will eat up 256MB right?

Ah, it's the same file, that means that it will be just 256kB, that is
fine. Well it would be better to unlink() the file at the end of the
test, but regardless:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
