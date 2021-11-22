Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99945C433EF
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 17:35:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD3283C8DCB
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 18:35:18 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF4693C08C7
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 18:35:09 +0100 (CET)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 95FE9600D0F
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 18:35:06 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: krisman) with ESMTPSA id 291C51F44A7C
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
 t=1637602505; bh=CH6DK5G3pKGVLoMQePVrma0h6Kl0KQXPzOhitk/dw20=;
 h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
 b=joDlYuLd+5HOAi/dO/0ren/v8fUs6oEJzWq8dUY37PRpUE8JHKwZsYuNNDuf7ZzLT
 dzeLGvNsRmgi8MQGUHeJpbuyJXket8ozQxnGurbANWj4BdIMJdquUYssZZXlD1ZJ2q
 tD+DkYk1fJM9EW+xyAlCKRA4DNtSCobDzkkdOf1fI8FixU5jdwd1EYHLFyB6rf7Xd+
 0jzUyxpKrpo1k53BBN5NY5XKYh4pcRLb2h/Ec5YQ0exhwX0B0xnWq7dtxeW1DgMdU6
 le266VlpUAG5X5aLbs7Q1M8toTVl+H4or6sw4PkXiGnwEf/b8Jim9Um3Lr9dNOJRDm
 b3EQyb8RaNdgw==
From: Gabriel Krisman Bertazi <krisman@collabora.com>
To: Petr Vorel <pvorel@suse.cz>
Organization: Collabora
References: <20211118235744.802584-1-krisman@collabora.com>
 <CAOQ4uxhbDgdZZ0qphWg1vnW4ZoAkUxcQp631yZO8W49AE18W9g@mail.gmail.com>
 <8735nsuepi.fsf@collabora.com> <YZtLDXW01Cz0BfPU@pevik>
Date: Mon, 22 Nov 2021 12:35:01 -0500
In-Reply-To: <YZtLDXW01Cz0BfPU@pevik> (Petr Vorel's message of "Mon, 22 Nov
 2021 08:47:41 +0100")
Message-ID: <87mtlwt7p6.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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
Cc: kernel@collabora.com, Khazhismel Kumykov <khazhy@google.com>,
 Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.com>,
 Ext4 <linux-ext4@vger.kernel.org>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Petr Vorel <pvorel@suse.cz> writes:

> Hi all,
>
> <snip>
>> Hi Amir,
>
>> I have pushed v4 to :
>
>> https://gitlab.collabora.com/krisman/ltp.git -b fan-fs-error_v4
>
> FYI I've rebased it on my fix 3b2ea2e00 ("configure.ac: Add struct
> fanotify_event_info_pidfd check")
>
> https://github.com/linux-test-project/ltp.git -b gertazi/fanotify21.v4.fixes
>
> diff to krisman/fan-fs-error_v4:

Petr,

Should I send a v5 or is v4 getting picked up and merged with the fixup
hunk?

Thanks,

-- 
Gabriel Krisman Bertazi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
