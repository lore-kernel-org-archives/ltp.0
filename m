Return-Path: <SRS0=7Ptb=QG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC212C433EF
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 19:29:35 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56F1E61AED
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 19:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 56F1E61AED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DED043C8B6A
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 20:29:33 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F21C83C21D9
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 20:29:23 +0100 (CET)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 034AC602327
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 20:29:21 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: krisman) with ESMTPSA id AF4B51F45CF5
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
 t=1637350158; bh=Cp5u0lgs3VuHtc6UzMsQZYUM+vp88f2hbnH9saBd4+w=;
 h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
 b=JbcynB2V2r9KDSmJcKb1+WfwP8+4KW2OkQBL0jNGlIwdcSSNp/K5WL0eBInTscN6L
 hKRR8ctTiLGEoifQ3ZYOc2cCNnTl5s5NfubTo/AeJQz3fQrSw1YmTN5X441foM5DDU
 eHpsJgTgOa2coo+t+/miWL4d75wvXpGTzZ0LsLERU3sqff6BE2SeA6i87WTasVXaE5
 3VKRse09q/GeWHX/nbjnIrSd9nYyUslf+iBvu7vnEdYuJDR5ELz7Asa9ox4AeQJYq3
 EAIldXug0kejZ5jxb14oUVi3pUwDymKRhvJCWdQYgIm1nlhCwtc1CBtzkUUMLZb2Cx
 +rTemnq5CgS8A==
From: Gabriel Krisman Bertazi <krisman@collabora.com>
To: Amir Goldstein <amir73il@gmail.com>
Organization: Collabora
References: <20211118235744.802584-1-krisman@collabora.com>
 <CAOQ4uxhbDgdZZ0qphWg1vnW4ZoAkUxcQp631yZO8W49AE18W9g@mail.gmail.com>
Date: Fri, 19 Nov 2021 14:29:13 -0500
In-Reply-To: <CAOQ4uxhbDgdZZ0qphWg1vnW4ZoAkUxcQp631yZO8W49AE18W9g@mail.gmail.com>
 (Amir Goldstein's message of "Fri, 19 Nov 2021 07:48:29 +0200")
Message-ID: <8735nsuepi.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 0/9] Test the new fanotify FAN_FS_ERROR event
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
Cc: kernel@collabora.com, Matthew Bobrowski <repnop@google.com>,
 Khazhismel Kumykov <khazhy@google.com>, Jan Kara <jack@suse.com>,
 Ext4 <linux-ext4@vger.kernel.org>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Amir Goldstein <amir73il@gmail.com> writes:

> On Fri, Nov 19, 2021 at 1:57 AM Gabriel Krisman Bertazi
> <krisman@collabora.com> wrote:
>>
>> Hi,
>>
>> FAN_FS_ERROR was merged into Linus tree, and the PIDFD testcases reached
>> LTP.  Therefore, I'm sending a new version of the FAN_FS_ERROR LTP
>> tests.  This is the v4 of this patchset, and it applies the feedback of
>> the previous version.
>>
>> Thanks,
>>
>> ---
>>
>> Original cover letter:
>>
>> FAN_FS_ERROR is a new (still unmerged) fanotify event to monitor
>> fileystem errors.  This patchset introduces a new LTP test for this
>> feature.
>>
>> Testing file system errors is slightly tricky, in particular because
>> they are mostly file system dependent.  Since there are only patches for
>> ext4, I choose to make the test around it, since there wouldn't be much
>> to do with other file systems.  The second challenge is how we cause the
>> file system errors, since there is no error injection for ext4 in Linux.
>> In this series, this is done by corrupting specific data in the
>> test device with the help of debugfs.
>>
>> The FAN_FS_ERROR feature is flying around linux-ext4 and fsdevel, and
>> the latest version is available on the branch below:
>>
>>     https://gitlab.collabora.com/krisman/linux -b fanotify-notifications-v9
>>
>> A proper manpage description is also available on the respective mailing
>> list, or in the branch below:
>>
>>     https://gitlab.collabora.com/krisman/man-pages.git -b fan-fs-error
>>
>> Please, let me know your thoughts.
>>
>
> Gabriel,
>
> Can you please push these v4 patches to your gitlab tree?

Hi Amir,

I have pushed v4 to :

https://gitlab.collabora.com/krisman/ltp.git -b fan-fs-error_v4

Thank you!

-- 
Gabriel Krisman Bertazi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
