From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 28 Nov 2018 11:04:22 +0800
Subject: [LTP] [PATCH] fs/growfiles.c: Fix the max size of every growing
 file
In-Reply-To: <20181127124000.GA31527@dell5510>
References: <1539771685-28323-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20181127124000.GA31527@dell5510>
Message-ID: <5BFE05B6.6070807@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2018/11/27 20:40, Petr Vorel wrote:
> Hi Xiao,
>
> Reviewed-by: Petr Vorel<pvorel@suse.cz>
>
> ...
>>   	unsigned long curr_size = 0;	/* BUG:14136 (keep track of file size) */
>> -	const unsigned long ext2_limit = 2147483647;	/* BUG:14136 (2GB ext2 filesize limit) */
>> +	unsigned long fs_limit = 2147483647; /* BUG:14136 (filesystem size limit is 2G by default) */
> BTW I wonder if the "bug" is this one:
> https://access.redhat.com/solutions/29129
Hi Petr,

Sorry, i am not sure.

The following old patch try to fix defect 14136, but i don't know what 
the defect 14136 is.
https://github.com/linux-test-project/ltp/commit/dec5a46e9939ac99c30afb5b2605dbd9aa9ed6ef

I cannot find the bug(id: 14136) of filesystem, is it the issue of LTP?
> doio code really needs cleanup.
Agreed.

Best Regards,
Xiao Yang
> Kind regards,
> Petr
>
>
>



