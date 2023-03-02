Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2980FC678D4
	for <ltp@archiver.kernel.org>; Thu,  2 Mar 2023 14:48:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4792E3CDCFB
	for <ltp@archiver.kernel.org>; Thu,  2 Mar 2023 15:48:16 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B9FF43CB9ED
 for <ltp@lists.linux.it>; Thu,  2 Mar 2023 15:48:02 +0100 (CET)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E12B81A00CDC
 for <ltp@lists.linux.it>; Thu,  2 Mar 2023 15:47:59 +0100 (CET)
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
 by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 322Elq4o005214;
 Thu, 2 Mar 2023 23:47:52 +0900 (JST)
 (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Thu, 02 Mar 2023 23:47:52 +0900 (JST)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
 (authenticated bits=0)
 by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 322ElppJ005211
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 2 Mar 2023 23:47:51 +0900 (JST)
 (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <b641cc8e-2950-fb6d-9c26-28f1e1b0fc1d@I-love.SAKURA.ne.jp>
Date: Thu, 2 Mar 2023 23:47:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>,
 Andrea Cervesato <andrea.cervesato@suse.com>
References: <20230302093406.29799-1-andrea.cervesato@suse.com>
 <ZACzPkhrRxsDL3Am@yuki>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <ZACzPkhrRxsDL3Am@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] [RFC] Remove tomoyo testing suite
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
Cc: tomoyo-users-en@lists.osdn.me, tomoyo-contact@I-love.SAKURA.ne.jp,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello.

Thank you for heads-up.

Removing testing suite for tomoyo from the LTP testcases folder is fine, for
the latest testing suite for tomoyo is maintained at
https://osdn.net/projects/tomoyo/scm/svn/tree/head/trunk/2.6.x/tomoyo-tools/kernel_test/
and tomoyo is tested by syzbot.

But the reasoning "the whole Tomoyo linux functionality seems replaced by
SELinux or AppArmor" is wrong; the functionality cannot be replaced by
other LSM modules. ;-)

On 2023/03/02 23:31, Cyril Hrubis wrote:
> Hi!
> CCing the contact on https://tomoyo.osdn.jp/support.html.en
> 
> If anyone wants to pick up the testsuite and maintain it please speak
> up.
> 
>> The tomoyo testing suite is built and installed inside the LTP testcases
>> folder, but it's not used by any runtest file. It seems an old and
>> unmaintained testing suite that uses old LTP API and ltp_clone_quick
>> that is going to be deprecated.
>>
>> We suppose to update it using new LTP API, cleaning up the code and
>> removing deprecated functions, but nowadays the whole Tomoyo linux
>> functionality seems replaced by SELinux or AppArmor and not maintained
>> anymore in years of development.
>>
>> For this reason, this patch is going to remove it from LTP installation.
>>
>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
