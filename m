From: Eryu Guan <eguan@redhat.com>
Date: Thu, 5 Nov 2015 20:55:34 +0800
Subject: [LTP] [PATCH 2/2] test_robind.sh: add xfs and btrfs support
In-Reply-To: <20151105122056.GA7226@rei>
References: <1446273800-2494-1-git-send-email-eguan@redhat.com>
 <1446273800-2494-2-git-send-email-eguan@redhat.com>
 <20151105122056.GA7226@rei>
Message-ID: <20151105125534.GB20082@dhcp-13-216.nay.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Nov 05, 2015 at 01:20:56PM +0100, Cyril Hrubis wrote:
> Hi!
> > Add btrfs support and fix opts for xfs, which needs "-f" too.
> > 
> > Signed-off-by: Eryu Guan <eguan@redhat.com>
> > ---
> >  testcases/kernel/fs/fs_readonly/test_robind.sh | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> > 
> > diff --git a/testcases/kernel/fs/fs_readonly/test_robind.sh b/testcases/kernel/fs/fs_readonly/test_robind.sh
> > index 5674ca4..371d5fa 100755
> > --- a/testcases/kernel/fs/fs_readonly/test_robind.sh
> > +++ b/testcases/kernel/fs/fs_readonly/test_robind.sh
> > @@ -197,10 +197,17 @@ for fstype in $FSTYPES; do
> >  	opts="-F"
> >  	if [ "$fstype" = "reiserfs" ]; then
> >  		opts="-f --journal-size 513 -q"
> > -	elif [ "$fstype" = "jfs" ]; then
> > +	elif [ "$fstype" = "jfs" -o "$fstype" = "xfs" ]; then
> >  		opts="-f"
> > -	elif [ "$fstype" = "xfs" ]; then
> > -		opts=""
> > +	elif [ "$fstype" = "btrfs" ]; then
> > +		# check if mkfs.btrfs supports -f option
> > +		# detect "-f --force" or "-f|--force" because btrfs-progs
> > +		# changes usage text in commit 3f312d500b73
> > +		if mkfs.btrfs 2>&1 | grep -q '\-f[ |]'; then
> > +			opts="-f"
> > +		else
> > +			opts=""
> > +		fi
> >  	fi
> 
> We have this special cases in tst_mkfs function in test.sh, you should
> really use that instead of copying the code around.

Thanks for the reminder, I was not aware of tst_mkfs helper.

> 
> Lookin at the code in test.sh we should add special case for jfs there
> and call tst_mkfs here instead of mkfs.$fstype.

Will update the helper and use it.

Thanks!

Eryu
