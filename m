From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 13 Jan 2020 14:25:32 +0100
Subject: [LTP] [PATCH v3] Use real FS block size in fallocate05
In-Reply-To: <4da4e1ec-d5dc-06e2-bea8-280533f5d022@suse.com>
References: <461386048.17251961.1576663655809.JavaMail.zimbra@redhat.com>
 <20191218131533.15323-1-mdoucha@suse.cz> <20200107152108.GA27182@rei.lan>
 <6f2c4482-9a8f-1b14-be18-10b486576f13@suse.cz>
 <e684c55a-5973-af77-ff24-2dfc6a1f67b1@suse.cz>
 <4da4e1ec-d5dc-06e2-bea8-280533f5d022@suse.com>
Message-ID: <f3211331-b7ec-4d14-7f3b-d8fb5c72c1fe@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 1/13/20 2:16 PM, Qu WenRuo wrote:
> Just a small tip, btrfs defaults to data CoW, and unlike other CoW fs
> (like xfs), btrfs has an extent booking behavior, that even only part of
> a large extent (e.g 128MiB) is referred, the whole extent will not be freed.

I know, I reported the bug where we discussed this.

>>> What's the minimum block device size
>>> where Btrfs will use the same code paths as in real-world use cases?
> 
> Mkfs.btrfs no longer enables --mixed for small fs.
> 
> But btrfs still has a pretty complex minimal device size, it depends on
> profile (-m and -d options).
> 
> If LTP guys want to be safe for single device, it needs 256MiB for
> `mkfs.btrfs -m dup -d dup` to run successfully.
> 
> If only default case (-m dup -d single) is needed, then 128MiB is enough.

Sorry but my question was not about the minimum for mkfs. My question
was about the minimum device size so that the kernel driver will use the
same block allocation logic as on a 100GB+ partition (instead of some
special case allocation logic for tiny block devices).

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
