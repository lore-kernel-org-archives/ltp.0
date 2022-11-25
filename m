Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B853C43217
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 14:33:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4A4883CDCBE
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 15:33:55 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E24083CC8E4
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 15:33:46 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9634C1000F1B
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 15:33:44 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 81BF81FD68;
 Fri, 25 Nov 2022 14:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669386824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cob/RWSfRqBKMcXny9P+gASgeTbVcb0UKRaaV7TrSuA=;
 b=vysxQ/Rc2voennmfyWzyw9+kxfk3bzK8CcHF/v7iSjR973iQSDNMyfj9M4bNry6A+L2Uqm
 KBXOkiE2rr1ktVmbQGlKeygdMtVt2LXWnMqvyQi7ZJvaD75jUABszEIngXSw28twCPe5fS
 LSc3vEtn+Zr81a0vPVwyZXkarBZTJjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669386824;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cob/RWSfRqBKMcXny9P+gASgeTbVcb0UKRaaV7TrSuA=;
 b=nB7AOM3hWTNigKKWBgW0mfCsu5THvGaFeULQUXoxJJ5AagX3qQ4hF500Dk+mwo35QzYtJE
 NaVoeCJdNTt5uKDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B5F41361C;
 Fri, 25 Nov 2022 14:33:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bvVoGUjSgGPqbQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 25 Nov 2022 14:33:44 +0000
Date: Fri, 25 Nov 2022 15:35:06 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Y4DSmk7uY9zUUQsV@yuki>
References: <20221123103547.54246-1-david@redhat.com>
 <8587b908-a035-a96a-7233-2863b7bc30ca@suse.cz>
 <Y4DPu7c+a939n2D5@yuki>
 <aedafbef-fc19-d552-9459-0878d9a6be8a@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aedafbef-fc19-d552-9459-0878d9a6be8a@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] security/dirtyc0w_shmem: Add new test for
 CVE-2022-2590
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
Cc: ltp@lists.linux.it, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> I think the point is that there's no guarantee that NULL will actually 
> be defined as (void*)0. It can be defined as a plain integer instead. 
> And it *IS* defined as plain integer when the header is #included in C++.

NULL is required to be 0 cast to void* in POSIX.

https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/stddef.h.html

So at least on POSIX-like systems in C NULL must be ((void*)0)

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
