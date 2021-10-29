Return-Path: <SRS0=M8Fp=PR=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CD3C433F5
	for <ltp@archiver.kernel.org>; Fri, 29 Oct 2021 15:03:34 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF18E61166
	for <ltp@archiver.kernel.org>; Fri, 29 Oct 2021 15:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CF18E61166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 201D53C6FE5
	for <ltp@archiver.kernel.org>; Fri, 29 Oct 2021 17:03:31 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 885083C6DE0
 for <ltp@lists.linux.it>; Fri, 29 Oct 2021 17:03:21 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1215E140B9BF
 for <ltp@lists.linux.it>; Fri, 29 Oct 2021 17:03:19 +0200 (CEST)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: krisman)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C21601F45B3F;
 Fri, 29 Oct 2021 16:03:17 +0100 (BST)
From: Gabriel Krisman Bertazi <krisman@collabora.com>
To: Amir Goldstein <amir73il@gmail.com>
Organization: Collabora
References: <20211026184239.151156-1-krisman@collabora.com>
 <20211026184239.151156-11-krisman@collabora.com>
 <CAOQ4uxia5Qhieui+keBLumWwGd2+wv88+FykWq-zMrDrHmZUrA@mail.gmail.com>
Date: Fri, 29 Oct 2021 12:03:11 -0300
In-Reply-To: <CAOQ4uxia5Qhieui+keBLumWwGd2+wv88+FykWq-zMrDrHmZUrA@mail.gmail.com>
 (Amir Goldstein's message of "Wed, 27 Oct 2021 13:00:07 +0300")
Message-ID: <87bl37an68.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 10/10] syscalls/fanotify20: Test capture of
 multiple errors
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

Amir Goldstein <amir73il@gmail.com> writes:

> On Tue, Oct 26, 2021 at 9:44 PM Gabriel Krisman Bertazi
>> --- a/testcases/kernel/syscalls/fanotify/fanotify20.c
>> +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
>> @@ -78,6 +78,18 @@ static void tcase2_trigger_lookup(void)
>>                         ret, BAD_DIR, errno, EUCLEAN);
>>  }
>>
>> +static void tcase3_trigger(void)
>> +{
>> +       trigger_fs_abort();
>> +       tcase2_trigger_lookup();
>
> So after remount,abort filesystem operations can still be executed?
> Then I guess my comment from the previous patch about running the test in a loop
> is not relevant?

Hi Amir,

As you mentioned here, -i works fine.  Abort will remount with
MS_RDONLY, and this doesn't affect the existing tests.  Future tests
that write to the file system inside .trigger_error() would require the
umount-mount cycle but, since the goal is testing fanotify and not
specific fs errors, I think we don't need the added complexity of such
tests.

Output of '-i #' always pass:

  root@test-box:~/ltp/testcases/kernel/syscalls/fanotify# ./fanotify20 -i 5
  tst_device.c:88: TINFO: Found free device 0 '/dev/loop0'
  tst_test.c:932: TINFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
  mke2fs 1.46.4 (18-Aug-2021)
  tst_test.c:1363: TINFO: Timeout per run is 0h 05m 00s
  fanotify.h:252: TINFO: fid(test_mnt) = 469af9fc.8ced5767.2.0.0...
  fanotify.h:252: TINFO: fid(test_mnt/internal_dir/bad_dir) = 469af9fc.8ced5767.8002.acd05469.0...
  debugfs 1.46.4 (18-Aug-2021)
  fanotify20.c:234: TPASS: Successfully received: Trigger abort
  fanotify20.c:234: TPASS: Successfully received: Lookup of inode with invalid mode
  fanotify20.c:234: TPASS: Successfully received: Multiple error submission
  fanotify20.c:234: TPASS: Successfully received: Multiple error submission 2
  fanotify20.c:234: TPASS: Successfully received: Trigger abort
  fanotify20.c:234: TPASS: Successfully received: Lookup of inode with invalid mode
  fanotify20.c:234: TPASS: Successfully received: Multiple error submission
  fanotify20.c:234: TPASS: Successfully received: Multiple error submission 2
  fanotify20.c:234: TPASS: Successfully received: Trigger abort
  fanotify20.c:234: TPASS: Successfully received: Lookup of inode with invalid mode
  fanotify20.c:234: TPASS: Successfully received: Multiple error submission
  fanotify20.c:234: TPASS: Successfully received: Multiple error submission 2
  fanotify20.c:234: TPASS: Successfully received: Trigger abort
  fanotify20.c:234: TPASS: Successfully received: Lookup of inode with invalid mode
  fanotify20.c:234: TPASS: Successfully received: Multiple error submission
  fanotify20.c:234: TPASS: Successfully received: Multiple error submission 2
  fanotify20.c:234: TPASS: Successfully received: Trigger abort
  fanotify20.c:234: TPASS: Successfully received: Lookup of inode with invalid mode
  fanotify20.c:234: TPASS: Successfully received: Multiple error submission
  fanotify20.c:234: TPASS: Successfully received: Multiple error submission 2

  Summary:
  passed   20
  failed   0
  broken   0
  skipped  0
  warnings 0

Thanks,

-- 
Gabriel Krisman Bertazi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
