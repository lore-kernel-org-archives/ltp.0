From: Qu WenRuo <wqu@suse.com>
Date: Mon, 13 Jan 2020 13:30:08 +0000
Subject: [LTP] [PATCH v3] Use real FS block size in fallocate05
In-Reply-To: <f3211331-b7ec-4d14-7f3b-d8fb5c72c1fe@suse.cz>
References: <461386048.17251961.1576663655809.JavaMail.zimbra@redhat.com>
 <20191218131533.15323-1-mdoucha@suse.cz> <20200107152108.GA27182@rei.lan>
 <6f2c4482-9a8f-1b14-be18-10b486576f13@suse.cz>
 <e684c55a-5973-af77-ff24-2dfc6a1f67b1@suse.cz>
 <4da4e1ec-d5dc-06e2-bea8-280533f5d022@suse.com>
 <f3211331-b7ec-4d14-7f3b-d8fb5c72c1fe@suse.cz>
Message-ID: <6a4aae16-57eb-9a1d-fd64-af84d5c8cdb3@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 2020/1/13 ??9:25, Martin Doucha wrote:
> On 1/13/20 2:16 PM, Qu WenRuo wrote:
>> Just a small tip, btrfs defaults to data CoW, and unlike other CoW fs
>> (like xfs), btrfs has an extent booking behavior, that even only part of
>> a large extent (e.g 128MiB) is referred, the whole extent will not be freed.
> 
> I know, I reported the bug where we discussed this.
> 
>>>> What's the minimum block device size
>>>> where Btrfs will use the same code paths as in real-world use cases?
>>
>> Mkfs.btrfs no longer enables --mixed for small fs.
>>
>> But btrfs still has a pretty complex minimal device size, it depends on
>> profile (-m and -d options).
>>
>> If LTP guys want to be safe for single device, it needs 256MiB for
>> `mkfs.btrfs -m dup -d dup` to run successfully.
>>
>> If only default case (-m dup -d single) is needed, then 128MiB is enough.
> 
> Sorry but my question was not about the minimum for mkfs. My question
> was about the minimum device size so that the kernel driver will use the
> same block allocation logic as on a 100GB+ partition (instead of some
> special case allocation logic for tiny block devices).

Then the meaningful boundary is 50G.

Smaller 50G, metadata chunk is limited to 256M, otherwise metadata chunk
can be 1G sized.
Despite chunk size, there shouldn't be much difference in the code path.

I guess you're talking about the old `mixed` behavior, which is no
longer the default option for any fs size.

Thanks,
Qu
