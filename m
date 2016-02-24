From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed, 24 Feb 2016 15:47:16 +0300
Subject: [LTP] [RFC PATCH 1/2] tst_acquire_device: clear first sectors
 of LTP_DEV
In-Reply-To: <20160222103408.GA5530@rei.lan>
References: <1455975251-30056-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160222103408.GA5530@rei.lan>
Message-ID: <56CDA654.3040802@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

On 02/22/2016 01:34 PM, Cyril Hrubis wrote:
> Hi!
>> As we see in [1] ZAP_BOOTBLOCK is defined on all archs except SPARC.
>> I could not find the exact reason why it's so, but tend to think
>> that it was implemented to let ext{2,3,4} be created on the first
>> partition of a Sun disk label. The thing is that with Sun disk labels
>> it's absolutely fine to have the first partition starting at sector 0,
>> which is used by the disk label itself:
>>
>> ~# fdisk -lu /dev/vdiska
>>
>> Disk /dev/vdiska (Sun disk label): 255 heads, 63 sectors, 3916 cylinders
>> Units = sectors of 1 * 512 bytes
>>
>>        Device Flag    Start       End    Blocks   Id  System
>> /dev/vdiska1             0   2104515   1052257+   1  Boot
>> /dev/vdiska2       2104515  62910540  30403012+  83  Linux native
>> /dev/vdiska3             0  62910540  31455270    5  Whole disk
>>
>> If mkfs.ext{2,3,4} overwrote the first two sectors, then
>> 'mkfs.ext{2,3,4} /dev/vdiska1' would destroy the disk label.
>>
>> Clearing the first 512k of LTP_DEV solves this issue. I don't expect
>> it to make a noticeable impact on test execution time. 512k is fine
>> to cover superblocks of all file systems supported by libblkid [2].
>> Just in case.
>
> Sounds reasonable to me. I guess that we can remove the special cases
> for the force flag once this is applied as well.
>

I committed the series. Thank you.

Regarding the force flag. Yes, we no longer need it now.

I tried to execute mount* test cases with ext2/ext3/xfs/btrfs file 
systems with the attached patch and they all passed.

So am I proceeding with a more formal patch?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: mkfs_no_force_flag.patch
Type: text/x-diff
Size: 906 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160224/f039870e/attachment.patch>
