Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E55C433EF
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 09:47:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F0343C9B1F
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 10:47:14 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE53E3C06B2
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 10:47:05 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D2F1C1400F2B
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 10:47:04 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 20975210FE;
 Tue,  8 Feb 2022 09:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644313624;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b4kHjJZq1yj/ox2++KtTsvHHtcavxrJtNeRwkp5RbHo=;
 b=kNiJuJBLJfYh/e/gxUphyr9ysALWPCxNbDSPrn1o/FFAGFVHIM6sRTcQmR+l/ZNHWgGR4O
 d1GKaxVAiX15GZjzWZCw4A1YZ1ShWPLh9oHMbcJd6kk29ZR0uYB/vKNBtY+mhB4k4sgEwz
 AWdIJkexdNhH5sOefsflfjsbfn9XndE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644313624;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b4kHjJZq1yj/ox2++KtTsvHHtcavxrJtNeRwkp5RbHo=;
 b=8aP15pWhJj3tQceYr89HedcVUfqrLL+FIXR/pkUJq1rnUNqUTRdwIWJST4JrZHf4hX0Be1
 g1ZqGVKXo3vZGxAg==
Received: from g78 (unknown [10.163.24.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id D8B34A3B83;
 Tue,  8 Feb 2022 09:47:03 +0000 (UTC)
References: <20220207141618.2844-1-rpalethorpe@suse.com>
 <20220207141618.2844-3-rpalethorpe@suse.com>
 <CAEemH2d-K=X0aodrLV=4AiVE-GWDkHv3+Rxf_NUq8btH=jF77A@mail.gmail.com>
 <87czjxwwgc.fsf@suse.de>
 <CAEemH2c0MTyitsSjbUqDsyW5rsOOAkXMJconVcBQRZLr0vK=4w@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Tue, 08 Feb 2022 09:46:47 +0000
In-reply-to: <CAEemH2c0MTyitsSjbUqDsyW5rsOOAkXMJconVcBQRZLr0vK=4w@mail.gmail.com>
Message-ID: <874k59wuzs.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/5] API/cgroup: Declare required controllers
 and version in test struct
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
Reply-To: rpalethorpe@suse.de
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

Pushed!

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
