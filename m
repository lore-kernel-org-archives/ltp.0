From: Theodore Ts'o <tytso@mit.edu>
Date: Sun, 10 Jul 2016 23:15:53 -0400
Subject: [LTP] [lkp] [ext4]  5405511e1a: ltp.acl_test01.fail]
In-Reply-To: <20160711015954.GA15084@yexl-desktop>
References: <20160711015954.GA15084@yexl-desktop>
Message-ID: <20160711031553.GP26097@thunk.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Jul 11, 2016 at 09:59:54AM +0800, kernel test robot wrote:
> 
> FYI, we noticed the following commit:
> 
> https://github.com/0day-ci/linux Vegard-Nossum/ext4-validate-number-of-clusters-in-group/20160708-041426
> commit 5405511e1a984ab644fa9e29a0d3d958b835ab75 ("ext4: validate number of meta clusters in group")

Hi, many thanks for the report.  One question -- is there some way the
reporting could be speeded up?  Vegard's patch was sent late on the
7th, and it looks like it hit the 0day-ci git repo a few hours later
on the 8th, and was run early in the morning Chinese time.  Was the
delay until the 11th due to the weekend and the desire to have a human
sanity check the result?  Is that because there was a concern that
there would be too many false positives?

Also, if there was some way the 0day robot report could include a
In-Reply-To: header to the patch being sent to the mailing list (in
this case: <577EB740.10502@oracle.com>), it would make this even
*more* useful.


Vegard, I'm guessing you didn't have a chance to test your patch
before you sent it to the list?

		bit_max = ext4_num_clusters_in_group(sb, i);
		if ((bit_max >> 3) >= sb->s_blocksize) {
			ext4_msg(sb, KERN_WARNING, "clusters in "
	  			  "group %u exceeds block size", i);
			goto failed_mount;
		}


This is the test which is failing, but it will fail by default on
pretty much all ext4 file systems, since by default there will be
32768 blocks (clusters) per group, with a 4k block size (and 32768 >>
3 == 4096).  And in the test that failed, this was a 1k block size
with 8192 blocks per blocks (and 8192 >> 3 == 1024).

Anyway, as I mentioned before, I'd much rather do very specific sanity
checking on superblock fields, instead of sanity checking calculated
values such as ext4_num_clusters_in_group().

Perhaps the easist thing to do is to run e2fsck -n on those file
systems that are causing problems?

Cheers,

						- Ted
