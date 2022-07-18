Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18850C43334
	for <ltp@archiver.kernel.org>; Mon, 18 Jul 2022 11:17:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3800B3C97DE
	for <ltp@archiver.kernel.org>; Mon, 18 Jul 2022 13:17:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9FF8E3C9349
 for <ltp@lists.linux.it>; Mon, 18 Jul 2022 13:16:49 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EB3DA10004A4
 for <ltp@lists.linux.it>; Mon, 18 Jul 2022 13:16:48 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id DD2AF20A57;
 Mon, 18 Jul 2022 11:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1658143007;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1k4+0Z8oeJ9MV0f46XcvGgP2r7Ul0U1hKx0PDCaGz/k=;
 b=bjZhgAg/qFb2bNKUVjpaSsNOa/huL6NGorrZZLfdAhteVgDewLsDzAZcmGk/UYhqeb+3CF
 N4UUPCUDw07pEEz8boCBMwS0TuWnp/lmEgw4Cetiq6s+ms+pJd27/hUHvEuC6ucXHW8ftT
 /mPiiHncqDEr7OA6Wx6Zpv5UJjjLxSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1658143007;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1k4+0Z8oeJ9MV0f46XcvGgP2r7Ul0U1hKx0PDCaGz/k=;
 b=6oFl76JmQqpqFJnGfLqprCdEe8PK4keOgW1jt+ncygmqkigiQLvrdix9RMRAjyO6XRP+ME
 DXuykQtWlKdbVkBg==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id ABE3D2C141;
 Mon, 18 Jul 2022 11:16:47 +0000 (UTC)
References: <20220712124617.23139-1-rpalethorpe@suse.com>
 <CAASaF6xwEpong-apUxxZxQB47cw-2yaBEpn+AjjogU3qxHag1g@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Jan Stancek <jstancek@redhat.com>
Date: Mon, 18 Jul 2022 11:57:39 +0100
In-reply-to: <CAASaF6xwEpong-apUxxZxQB47cw-2yaBEpn+AjjogU3qxHag1g@mail.gmail.com>
Message-ID: <87h73eisbk.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] read_all: Add worker timeout
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

Hello,

Jan Stancek <jstancek@redhat.com> writes:

> On Tue, Jul 12, 2022 at 2:46 PM Richard Palethorpe via ltp
> <ltp@lists.linux.it> wrote:
>>
>> Kill and restart workers that take too long to read a file. The
>> default being one second. A custom time can be set with the new -t
>> option.
>>
>> This is to prevent a worker from blocking forever in a read. Currently
>> when this happens the whole test times out and any remaining files in
>> the worker's queue are not tested.
>>
>> As a side effect we can now also set the timeout very low to cause
>> partial reads.
>>
>> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>> Cc: Joerg Vehlow <lkml@jv-coder.de>
>> Cc: Li Wang <liwang@redhat.com>
>> ---
>>  testcases/kernel/fs/read_all/read_all.c | 83 ++++++++++++++++++++++++-
>>  1 file changed, 82 insertions(+), 1 deletion(-)
>
>>
>> +static void restart_worker(struct worker *const worker)
>> +{
>> +       int wstatus, ret, i, q_len;
>> +       struct timespec now;
>> +
>> +       kill(worker->pid, SIGKILL);
>> +       ret = waitpid(worker->pid, &wstatus, 0);
>
> Is there a chance we could get stuck in uninterruptible read? I think I saw some
> in past, but those may be blacklisted already, so this may only be something
> to watch for if we still get test timeouts in future.
>

I was hoping that kill is special somehow, but I suppose that I should
check exactly what happens. If the process is stuck inside the kernel
then we don't want to wait too long for it. We just need to know that
the kill signal was delivered and that the process will not return to
userland. If we have a large number of zombies then it could exhaust the
PIDs or some other resource, but most reads are done very quickly and
don't need interrupting.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
