Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43827C433EF
	for <ltp@archiver.kernel.org>; Wed,  2 Feb 2022 16:45:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BCB2C3C9905
	for <ltp@archiver.kernel.org>; Wed,  2 Feb 2022 17:45:38 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9AAA53C989C
 for <ltp@lists.linux.it>; Wed,  2 Feb 2022 17:45:29 +0100 (CET)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BFFE81A00376
 for <ltp@lists.linux.it>; Wed,  2 Feb 2022 17:45:28 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: krisman) with ESMTPSA id 744211F44994
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1643820327;
 bh=QGhPBZ5UqGHJzYqFmfNE2i/ZkVErlT75jg/7lW6yZeY=;
 h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
 b=C24LCKfXFpvHjPC+89u7IWLr4z/dhbD+NmT8OoBWv7+65te+q+6rE60OBwvPhwtFQ
 8D2cFzpG4Fp/norxRo/4xlHeO7+golXBZeQZ7hTjdReMeDEN49anSB0TzjM+i92F9D
 fL1mU/PEg33kfwNC1hDG90YOCvV08pBCLBgJ25UhlD5YWIGM0w6kmOGUMv8PfCdhHq
 8gflEXMfw9sPBONHcY2ne3lU08XpKmyOguQ1FykeI+xgsP5MecQT2Af3xMNPIz78Ra
 DJk3qCbz7k7oaSeRyOYwMgP8PMcdOjZWZPC3rrUEaJhSYJQ69kGLJjcVX0xVMBhnAf
 ExwMbtPer2GvA==
From: Gabriel Krisman Bertazi <krisman@collabora.com>
To: Jan Stancek <jstancek@redhat.com>
Organization: Collabora
References: <20211118235744.802584-1-krisman@collabora.com>
 <YdxN6HBJF+ATgZxP@pevik>
 <CAOQ4uxia2NNMPUCQzjo6Gsnz8xr_9YKTeTqzOu-hgdsjfHHx0w@mail.gmail.com>
 <CAASaF6xQG691q9JxiEF5HgqCNfGd1FHhwEX5TG_WpW3rHpBFKQ@mail.gmail.com>
Date: Wed, 02 Feb 2022 11:45:24 -0500
In-Reply-To: <CAASaF6xQG691q9JxiEF5HgqCNfGd1FHhwEX5TG_WpW3rHpBFKQ@mail.gmail.com>
 (Jan Stancek's message of "Wed, 2 Feb 2022 15:10:26 +0100")
Message-ID: <875ypxgqu3.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Cc: Ext4 <linux-ext4@vger.kernel.org>, Matthew Bobrowski <repnop@google.com>,
 Khazhismel Kumykov <khazhy@google.com>, Jan Kara <jack@suse.com>,
 kernel@collabora.com, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Jan Stancek <jstancek@redhat.com> writes:

> On Wed, Feb 2, 2022 at 2:49 PM Amir Goldstein <amir73il@gmail.com> wrote:
>> Guys,
>>
>> Looks like we have a regression.
>
> agreed, "abort" option stopped working:
> https://gitlab.com/cki-project/kernel-tests/-/issues/945
>
> Lukas pointed out this patch that didn't make it in yet:
> https://lkml.org/lkml/2021/12/21/384
> This should be new version:
> https://lore.kernel.org/linux-ext4/YcSYvk5DdGjjB9q%2F@mit.edu/T/#t

I gave this patch a try and verified it fixes the test case regression.
Let me ask Ted to make sure it is merged for the 5.17 release.

Thanks,

-- 
Gabriel Krisman Bertazi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
