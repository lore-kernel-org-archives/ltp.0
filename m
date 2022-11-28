Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D19A9C43217
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 11:57:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 148963CC65A
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 12:57:14 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8EA713C0367
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 12:57:04 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 03D616005C8
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 12:57:03 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1140A21B90;
 Mon, 28 Nov 2022 11:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669636623;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3k5MfLHZOh/0hmp+hjvGu6P6hGNeeyQvQpovKQ5yxZ0=;
 b=A2tLpVUmYI5uOCzgBqj1mE8QvRSCmtb/hXpzHUcqEhq1qpQ+UGjhYiCwHudqZ9REIvLr7u
 1NnfOeQcAgUQeOb+Y/ZkibUirfDsQTKbju7nC4UdmiyRfX6b1ymrV8HOAPP4dAtuubXD+A
 F2aFUN60PJp4hK2DPIVAd9t0P503h8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669636623;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3k5MfLHZOh/0hmp+hjvGu6P6hGNeeyQvQpovKQ5yxZ0=;
 b=yrQ3tLhjI+m1VxNzQEJXwjVi4Y2ruSCQCRxbAPs6OQMc6HOJyX9//Lr1sgRd0NUApWcco+
 xZfI/L4S2chkb0BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD9A51326E;
 Mon, 28 Nov 2022 11:57:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KfrDNA6ihGO8UAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 28 Nov 2022 11:57:02 +0000
Date: Mon, 28 Nov 2022 12:57:01 +0100
From: Petr Vorel <pvorel@suse.cz>
To: David Hildenbrand <david@redhat.com>
Message-ID: <Y4SiDZXCSqMafjIb@pevik>
References: <20221128111833.98937-1-david@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221128111833.98937-1-david@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 0/3] userfaultfd: Fix and remove compile-time
 TCONF handling
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

Hi David,

If I remember correctly the reason for runtime check was ppc64le
missing userfaultfd minor fault support which needs to be check in runtime,
right? [1]. At least this is how I understand Martin's suggestion [2] to replace
compile time check with lapi. I'd state this reason at first commit message as
it's not obvious.

Otherwise whole patchset LGTM.

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/30abc28c-be3c-0f9e-0c2e-6614fdd30e0c@suse.cz/
[2] https://lore.kernel.org/ltp/6ce3a102-f2ec-16be-927d-a32ab46eaf0c@suse.cz/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
