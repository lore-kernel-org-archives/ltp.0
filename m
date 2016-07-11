From: Vegard Nossum <vegard.nossum@oracle.com>
Date: Mon, 11 Jul 2016 13:26:47 +0200
Subject: [LTP] [lkp] [ext4] 5405511e1a: ltp.acl_test01.fail]
In-Reply-To: <20160711031553.GP26097@thunk.org>
References: <20160711015954.GA15084@yexl-desktop>
 <20160711031553.GP26097@thunk.org>
Message-ID: <57838277.3050700@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 07/11/2016 05:15 AM, Theodore Ts'o wrote:
> On Mon, Jul 11, 2016 at 09:59:54AM +0800, kernel test robot wrote:
>>
>> FYI, we noticed the following commit:
>>
>> https://github.com/0day-ci/linux Vegard-Nossum/ext4-validate-number-of-clusters-in-group/20160708-041426
>> commit 5405511e1a984ab644fa9e29a0d3d958b835ab75 ("ext4: validate number of meta clusters in group")
[...]
>
> Vegard, I'm guessing you didn't have a chance to test your patch
> before you sent it to the list?

I test all my patches against the failing test-case and a few other images.

This patch specifically I think was sent with an [RFC] tag which I
intended to signal that I'm *not* sure of the fix.

That said, I could do a better job of running more conventional fs tests
on my patches, so I'll incorporate xfstests into my workflow.

> 		bit_max = ext4_num_clusters_in_group(sb, i);
> 		if ((bit_max >> 3) >= sb->s_blocksize) {
> 			ext4_msg(sb, KERN_WARNING, "clusters in "
> 	  			  "group %u exceeds block size", i);
> 			goto failed_mount;
> 		}
>
>
> This is the test which is failing, but it will fail by default on
> pretty much all ext4 file systems, since by default there will be
> 32768 blocks (clusters) per group, with a 4k block size (and 32768 >>
> 3 == 4096).  And in the test that failed, this was a 1k block size
> with 8192 blocks per blocks (and 8192 >> 3 == 1024).

Ugh, brain-o on my part. It should say > rather than >=, agreed?

> Anyway, as I mentioned before, I'd much rather do very specific sanity
> checking on superblock fields, instead of sanity checking calculated
> values such as ext4_num_clusters_in_group().
>
> Perhaps the easist thing to do is to run e2fsck -n on those file
> systems that are causing problems?

The function (ext4_init_block_bitmap()) has even more problems than the
ones I reported to the list so far; ext4_block_bitmap(),
ext4_inode_bitmap(), and ext4_inode_table() may _also_ point outside the
buffer and cause random corruptions.

I'll try to come up with a new (and better tested) patch.

Thanks,


Vegard
