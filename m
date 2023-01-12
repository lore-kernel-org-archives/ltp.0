Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C92C54EBD
	for <ltp@archiver.kernel.org>; Thu, 12 Jan 2023 09:02:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 953DD3CCA7C
	for <ltp@archiver.kernel.org>; Thu, 12 Jan 2023 10:02:00 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C03B43CB53A
 for <ltp@lists.linux.it>; Thu, 12 Jan 2023 10:01:50 +0100 (CET)
Received: from mail.steuer-voss.de (mail.steuer-voss.de [85.183.69.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DFEE51A00984
 for <ltp@lists.linux.it>; Thu, 12 Jan 2023 10:01:49 +0100 (CET)
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
 id A06573173; Thu, 12 Jan 2023 10:01:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by mail.steuer-voss.de (Postfix) with ESMTP id 9CF66C95;
 Thu, 12 Jan 2023 10:01:45 +0100 (CET)
Date: Thu, 12 Jan 2023 10:01:45 +0100 (CET)
From: Nikolaus Voss <nv@vosn.de>
To: Petr Vorel <pvorel@suse.cz>
In-Reply-To: <Y79WyOooDNfPojIA@pevik>
Message-ID: <655dd7b3-1b70-8d3c-c43-414e1d6e86@vosn.de>
References: <20230111142316.A0DBECA25@mail.steuer-voss.de>
 <Y79WyOooDNfPojIA@pevik>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/keyctl/keyctl09.c: fix test encrypted
 key
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
Cc: ltp@lists.linux.it, Yael Tzur <yaelt@google.com>,
 Nikolaus Voss <nikolaus.voss@haag-streit.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On Thu, 12 Jan 2023, Petr Vorel wrote:
> Hi Nikolaus,
>
> thank you for this update.
>
>
> I pushed your patch through mailing list, because you posted unsubscribed.

thanks!

>
>> Link: https://lore.kernel.org/ltp/20221006081709.92303897@mail.steuer-voss.de/
>
> From a link above you were able to send patch to kernel mailing list, thus you
> managed to subscribed. Why do you expect LTP would work for unsubscribed mails
> addresses?

I don't remember, maybe I subscribed, posted and then unsubscribed for v1 
and didn't remember I have to be subscribed before posting v2. As an 
irregular contributor I'm not subscribed to any list and use the archives 
instead. The majority of lists don't require subscription.

As an additional complication I use two mail-addresses, as I'm forced to 
use Outlook on the job, which doesn't work well with posting patches.

> I also dared to enable this mail for posting to LTP mailing list,
> but better would be if you subscribed before sending patches.
>
> v1 is not in patchwork, but it's in lore:
> https://lore.kernel.org/ltp/d2d2afa4-b031-3455-38dd-c099715319e4@vosn.de/

The above link (in the patch) _is_ a lore link, isn't it?

Niko

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
