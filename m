From: Qu WenRuo <wqu@suse.com>
Date: Mon, 13 Jan 2020 13:16:31 +0000
Subject: [LTP] [PATCH v3] Use real FS block size in fallocate05
In-Reply-To: <e684c55a-5973-af77-ff24-2dfc6a1f67b1@suse.cz>
References: <461386048.17251961.1576663655809.JavaMail.zimbra@redhat.com>
 <20191218131533.15323-1-mdoucha@suse.cz> <20200107152108.GA27182@rei.lan>
 <6f2c4482-9a8f-1b14-be18-10b486576f13@suse.cz>
 <e684c55a-5973-af77-ff24-2dfc6a1f67b1@suse.cz>
Message-ID: <4da4e1ec-d5dc-06e2-bea8-280533f5d022@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 2020/1/13 ??8:16, Martin Doucha wrote:
> Hello, dear Btrfs devs,
> we know that you're busy fixing bugs and implementing new features but
> could you spare a minute to answer a question that'll help us improve
> Btrfs test coverage in LTP?
> 
> We'd like to include the improved fallocate() test in the new LTP
> release which is planned for early next week. See the question below:
> 
> On 1/7/20 4:50 PM, Martin Doucha wrote:
>> On 1/7/20 4:21 PM, Cyril Hrubis wrote:
>>> Hi!
>>>> Changes since v1:
>>>> - Increase test device size to 1GB to avoid unrealistic Btrfs edge cases.
>>>
>>> Do we really need 1GB here? That quadruples the runtime. Aren't we good
>>> with just 512MB, that would just double it?
>>
>> I guess that's a question for Btrfs devs, so let's ask them.
>>
>> We're trying to test fallocate()/write() on various file systems (both
>> space allocation and deallocation).

Just a small tip, btrfs defaults to data CoW, and unlike other CoW fs
(like xfs), btrfs has an extent booking behavior, that even only part of
a large extent (e.g 128MiB) is referred, the whole extent will not be freed.

So for the following case, it may cause problem for used space accounting:

# xfs_io -f -c "fallocate 0 128M" -c sync -c "fpunch 0 127M" \
  /mnt/btrfs/file1

That 128M will still be considered as used, that 127M punch won't free
any space.

>> What's the minimum block device size
>> where Btrfs will use the same code paths as in real-world use cases?

Mkfs.btrfs no longer enables --mixed for small fs.

But btrfs still has a pretty complex minimal device size, it depends on
profile (-m and -d options).

If LTP guys want to be safe for single device, it needs 256MiB for
`mkfs.btrfs -m dup -d dup` to run successfully.

If only default case (-m dup -d single) is needed, then 128MiB is enough.

Thanks,
Qu

>> mkfs.btrfs is called without --mixed.
> 
