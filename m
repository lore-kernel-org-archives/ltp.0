Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A483C433EF
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 10:48:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 41C1D3C90E4
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 11:48:18 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 28B0A3C4DBB
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 11:48:07 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 734191A00346
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 11:48:07 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9DCE41F388;
 Tue, 21 Dec 2021 10:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1640083686;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AbfCrwTcgXJNYxMWN99H4eXJ0A9mLBjD7Y9Uzue0Z+g=;
 b=pgxemyO4pXQGI6M4S5jNS8B5Ok4JZwefgkFlEyYw82QUuc+fFH1g/1/LbgAKCr7t+Q1Ypx
 RCaVDvS2ZlLgBNkVmQHjP1glK0nm80V1pzJqGUJ3pzedk2UjSqUe4dQaoS5j8HS4DfHtqQ
 P+nEDUTefVU0tcrLR+jjfiP7AZkMQnA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1640083686;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AbfCrwTcgXJNYxMWN99H4eXJ0A9mLBjD7Y9Uzue0Z+g=;
 b=DAr4EQNXoVKhGC1jQ9S3x94eg8Kb9hN+ciGFo2370AgAgutUzfrRVc4le4GZaxBgfAwl5i
 EUadzfpipKdZiGCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6142213C26;
 Tue, 21 Dec 2021 10:48:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +lGEFOawwWHmZwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 21 Dec 2021 10:48:06 +0000
Date: Tue, 21 Dec 2021 11:48:04 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Nageswara Sastry <rnsastry@linux.ibm.com>
Message-ID: <YcGw5Lyo+hBEnlFD@pevik>
References: <20211221023721.129689-1-yaelt@google.com>
 <aafb5351-a73a-dac3-b0fa-3faad707bafa@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aafb5351-a73a-dac3-b0fa-3faad707bafa@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/keyctl09: test encrypted keys.
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
Cc: linux-integrity@vger.kernel.org, Yael Tiomkin <yaelt@google.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Nageswara,

> On 21/12/21 8:07 am, Yael Tiomkin wrote:
> > Test that encrypted keys can be instantiated using
> > both user-provided decrypted data
> > (https://lore.kernel.org/linux-integrity/20211213192030.125091-1-yaelt@google.com/),
> > or kernel-generated numbers.

> > Signed-off-by: Yael Tiomkin <yaelt@google.com>

> Tested on ppc64le platform

I suppose it also fails on ppc64le when run more iterations.
./keyctl09 -i500
keyctl09.c:49: TPASS: Encrypted keys were successfully instantiated and read
keyctl09.c:49: TPASS: Encrypted keys were successfully instantiated and read
...
keyctl09.c:33: TFAIL: Failed to instantiate encrypted key using payload decrypted data

(It's always good to put higher number iterations.)

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
