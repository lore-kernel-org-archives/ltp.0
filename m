From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 3 Nov 2015 12:39:23 +0100
Subject: [LTP] [PATCH] commands/mkfs: Added new testcase to test mkfs(8)
 command.
In-Reply-To: <56389879.6070101@cn.fujitsu.com>
References: <1446032247-18207-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <20151102152807.GC28478@rei> <56389879.6070101@cn.fujitsu.com>
Message-ID: <20151103113923.GB5795@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> +	mkfs_umount
> >> +
> >> +	if [ $blocknum -gt "$2" ]; then
> >> +		return 1
> >> +	fi
> > 
> > So the size we get as $2 is in kB and df -T reports 1k blocks shouldn't these
> > be equal, or are there any reserved block in play?
> > 
> 
> Indeed, "$blocknum" here is equal to struct statfs'f_blocks, which denotes total
> data blocks in filesystem(df uses statfs(2) to get this info) and does not contain
> some metadata in filesytem, e.g. ext3's journal space size. 

Ok, then we should check for lower bound as well. Something as blocknum
is greater than 90% of size or similar.

-- 
Cyril Hrubis
chrubis@suse.cz
