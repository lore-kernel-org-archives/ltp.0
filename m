From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 25 Jul 2016 14:25:21 +0300
Subject: [LTP] [PATCH] zram: extend the zram3 disksize to 40MB
In-Reply-To: <5795F4E4.20005@oracle.com>
References: <1468238245-25535-1-git-send-email-liwang@redhat.com>
 <20160713085901.GA2448@rei.scz.novell.com> <5795F4E4.20005@oracle.com>
Message-ID: <5795F721.3@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 07/25/2016 02:15 PM, Alexey Kodanev wrote:
> Hi,
> On 07/13/2016 11:59 AM, Cyril Hrubis wrote:
>> Hi!
>>> It failed to format btrfs on /dev/zram3 device since the
>>> disk size is too small (btrfs-progs is v4.4.1).
>>>
>>> The error msg we catched:
>>>
>>> zram01 3 TINFO : make ext3 filesystem on /dev/zram0
>>> zram01 3 TINFO : make ext4 filesystem on /dev/zram1
>>> zram01 3 TINFO : make xfs filesystem on /dev/zram2
>>> zram01 3 TINFO : make btrfs filesystem on /dev/zram3
>>> '/dev/zram3' is too small to make a usable filesystem
>>> Minimum size for each btrfs device is 41943040.
>>> btrfs-progs v4.4.1
>>> See http://btrfs.wiki.kernel.org for more information.
>>> zram01 3 TFAIL : failed to make btrfs on /dev/zram3
>>> zram01 4 TINFO : zram cleanup
>> I've got the exact same failure with btrfs-progs 4.5.1 just recently,
>> the fix looks good to me.
>
> Looks good to me too. Patch applied.

Also noted that in case btrfs is not supported, ext2 will be used with 40MB.
I think it shouldn't be a problem, just one more change that patch made.

>
> Best regards,
> Alexey
>
>> And btw it looks like we need to increase the default loop device size
>> again since btrfs-progs 4.5.1 seems to request at least 136MB for mkfs01
>> test...
>>
>
>

