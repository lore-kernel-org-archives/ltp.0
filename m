Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B2C1C61DA4
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 15:10:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A099B3CD55E
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 16:10:01 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF2DF3CAE69
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 16:09:51 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 247AF10006C0
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 16:09:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678720189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EEB271JNmpEasWeYz/lhDUF55p02bGxBafkBYSlmilM=;
 b=ZWhWAYwyyixUhF/COvQ1RhlZk71zKoRhx6L49mFjyXLyrPA3XVWzsL3fDn9sqBKFlkBE3z
 9aAxjqb9Cuph1ndatD8vMi6tY4fSbFTLPU889IEahb+31uHMTiLJUzcq38rotuG2k0mXAv
 h8CtibaoOyYURi3e1zjgVEV9PAoi30E=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-OXr-STRyO22cXlOZCcLecQ-1; Mon, 13 Mar 2023 11:09:47 -0400
X-MC-Unique: OXr-STRyO22cXlOZCcLecQ-1
Received: by mail-io1-f71.google.com with SMTP id
 d25-20020a0566022bf900b00745469852cfso6372904ioy.19
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 08:09:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678720187;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EEB271JNmpEasWeYz/lhDUF55p02bGxBafkBYSlmilM=;
 b=HEgtjBQ5un5lH0Lv3kaZUypsSYeWlxkdi0u2Q011cMrPGIg9syV8pdZR28mSVN8nuo
 Kt2UYhAuiaYwyBh4VjRZg8pYvPQh87Izz8XRfYhkxh69KoW4p5zXyP/OhtuRlHWOkHhW
 zEVDNgShNfCTH7D0L/QUXRUFwWlNEzYoG1GkhxnAEs+rn/9UjFUA5ASyCkvgCCFCCJMd
 h7RErSCYqjyB+9phGjVssuiMj3s1RtdPjAJ98WQihnw8QU/fVd/OQrDMfyA40EZTwdo/
 9Q9ZW8KZ8kl26j+cc//LHRRmdofHhpknXQ01O8cJhFMSxwoyfljZtCyPIq6geQC6/15G
 wV1w==
X-Gm-Message-State: AO0yUKU5tDsu10VYAamVhwe6QQ37+GkNzhb0DFPtjUpSy0Cg9bS7WdKJ
 4e2pIvJjd/gKdaG1j7YaCUtHtMzVwrdPsYgOr5Ne7u2B0P/+KUKVKnnECdh03dTnmLas5uuug8H
 xO4s29mk4B08=
X-Received: by 2002:a05:6e02:1d95:b0:323:5d8:57d2 with SMTP id
 h21-20020a056e021d9500b0032305d857d2mr3709759ila.4.1678720187210; 
 Mon, 13 Mar 2023 08:09:47 -0700 (PDT)
X-Google-Smtp-Source: AK7set9PFQhD+LvGG89pxOY7ezXL+ExEaS8Jj2JnrVKH5Sstnqiru3ZvxyNnY8+kfDQWqyLcA8n9Rw==
X-Received: by 2002:a05:6e02:1d95:b0:323:5d8:57d2 with SMTP id
 h21-20020a056e021d9500b0032305d857d2mr3709742ila.4.1678720186883; 
 Mon, 13 Mar 2023 08:09:46 -0700 (PDT)
Received: from [10.0.0.146] (sandeen.net. [63.231.237.45])
 by smtp.gmail.com with ESMTPSA id
 y13-20020a92d20d000000b003157696c04esm18760ily.46.2023.03.13.08.09.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Mar 2023 08:09:46 -0700 (PDT)
Message-ID: <9e05fdea-94f5-c7a2-6bd2-3107f0410e17@redhat.com>
Date: Mon, 13 Mar 2023 10:09:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
To: Cyril Hrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>
References: <20230307145517.1359-1-pvorel@suse.cz>
 <20230307145517.1359-3-pvorel@suse.cz> <ZA81c11hvBu4xlsd@yuki>
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <ZA81c11hvBu4xlsd@yuki>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] df01.sh: Use tst_fsfreeze for XFS on kernel
 >= 5.19
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
Cc: "Darrick J . Wong" <djwong@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 3/13/23 9:38 AM, Cyril Hrubis wrote:
> Hi!
>> XFS since kernel 5.19 postpone certain operation.  Use LTP fsfreeze
>> implementation to force all the background garbage collection to run
>> to completion.
>>
>> Link: https://lore.kernel.org/linux-block/974cc110-d47e-5fae-af5f-e2e610720e2d@redhat.com/
>> Suggested-by: Eric Sandeen <sandeen@redhat.com>
>> Signed-off-by: Petr Vorel <pvorel@suse.cz>
>> ---
>>  testcases/commands/df/df01.sh | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
>> index ae0449c3c..699d1538f 100755
>> --- a/testcases/commands/df/df01.sh
>> +++ b/testcases/commands/df/df01.sh
>> @@ -1,7 +1,7 @@
>>  #!/bin/sh
>>  # SPDX-License-Identifier: GPL-2.0-or-later
>>  # Copyright (c) 2015 Fujitsu Ltd.
>> -# Copyright (c) 2018-2022 Petr Vorel <pvorel@suse.cz>
>> +# Copyright (c) 2018-2023 Petr Vorel <pvorel@suse.cz>
>>  # Author: Zhang Jin <jy_zhangjin@cn.fujitsu.com>
>>  #
>>  # Test df command with some basic options.
>> @@ -46,6 +46,11 @@ df_test()
>>  
>>  	ROD_SILENT rm -rf $TST_MNTPOINT/testimg
>>  
>> +	# force all the background garbage collection to run to completion
>> +	if [ "$TST_FS_TYPE" = "xfs" ] && tst_kvcmp -ge "5.19"; then
>> +		tst_fsfreeze $TST_MNTPOINT
>> +	fi
> 
> This looks overly specific, can't we just freeze and unfreeze the FS
> without looking at kernel version? Or will we get errors on older XFS?
> 
> I suppose that this may still start to fail on distribution kernels if
> some of the newer functionality gets backported...

Yup, I agree. Freeze should be safe for any kernel, I wouldn't condition it either.

(You do want to be very sure that you're not freezing the root fs, tho,
if that is any possibility.)

-Eric

> Otherwise it looks good.
> 


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
