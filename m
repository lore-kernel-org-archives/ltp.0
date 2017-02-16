From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 16 Feb 2017 09:20:23 +0800
Subject: [LTP] [PATCH] syscalls/mq_open: fix limits for queues_max
In-Reply-To: <20170215152406.GB29673@rei.lan>
References: <1486384930-28588-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20170215152406.GB29673@rei.lan>
Message-ID: <58A4FE57.1040109@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2017/02/15 23:24, Cyril Hrubis wrote:
> Hi!
>> This case fails on RHEL6.8GA and RHEL6.9Beta, because setting
>> queues_max to 0 is invalid.  the minimum value of queues_max
>> has been limitted to 1 on some distributions, Please see the
>> following kernel commit:
>>
>> commit 5b5c4d1a1440e94994c73dddbad7be0676cd8b9a
>> Author: Doug Ledford<dledford@redhat.com>
>> Date:   Thu May 31 16:26:30 2012 -0700
>>
>> 	ipc/mqueue: update maximums for the mqueue subsystem
>>
>> We set queues_max to 1 instead of 0, so this case can work on RHEL6.
> First I think that you have wrong commit, the one that actually added
> the limits was:
>
> commit 93e6f119c0ce8a1bba6e81dc8dd97d67be360844
> Author: Doug Ledford<dledford@redhat.com>
> Date:   Thu May 31 16:26:28 2012 -0700
>
>      ipc/mqueue: cleanup definition names and locations
>
> Since this commit changes the proc handler in sysctl table and adds the minimum
> and maximum values there.
>
> Secondly these limits were removed in:
>
> commit a5c5928b759d8c7382cccc7be36769a68046cc58
> Author: Joe Perches<joe@perches.com>
> Date:   Fri Jun 6 14:38:07 2014 -0700
>
>      ipc: convert use of typedef ctl_table to struct ctl_table
>
Hi Cyril

Thanks for your review.
I will change commit as you said and send v2 patch.

Best Regards,
Xiao Yang
> I'm not sure if this is worth the effort.
>
> Jan what do you think, should we apply this to fix the test on RHEL6?
>



