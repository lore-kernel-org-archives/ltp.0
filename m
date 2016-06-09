From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 9 Jun 2016 14:49:17 +0300
Subject: [LTP] [PATCH] Shell wrappers for the checkpoint interface
In-Reply-To: <20160608142344.GD27367@rei.lan>
References: <1465379944-21713-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160608142344.GD27367@rei.lan>
Message-ID: <575957BD.3000206@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

On 06/08/2016 05:23 PM, Cyril Hrubis wrote:
> Hi!
>> +	if (!type)
>> +		ret = tst_checkpoint_wait(id, timeout);
>> +	else
>> +		ret = tst_checkpoint_wake(id, nr_wake, timeout);
>
> I find it silly that you do negate the flag here. You could have set it
> the other way, or swap the wait and wake in the if and else branch...

I swapped the wait and wake and pushed it.

Thanks!


>
> Anyway the rest looks good to me, ackend.
>
