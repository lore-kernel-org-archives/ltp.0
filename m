From: Xiaoli Feng <xifeng@redhat.com>
Date: Wed, 17 Apr 2019 01:58:44 -0400 (EDT)
Subject: [LTP] [PATCH v1] ext4_subdir_limit_test.sh: fix "No Space" issue
In-Reply-To: <20190411213509.GA4631@dell5510>
References: <20190408054050.28262-1-xifeng@redhat.com>
 <20190411213509.GA4631@dell5510>
Message-ID: <305667981.3947214.1555480724833.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

----- Original Message -----
> From: "Petr Vorel" <pvorel@suse.cz>
> To: "XiaoLi Feng" <xifeng@redhat.com>
> Cc: ltp@lists.linux.it, "Xiaoli Feng" <fengxiaoli0714@gmail.com>
> Sent: Friday, April 12, 2019 5:35:09 AM
> Subject: Re: [LTP] [PATCH v1] ext4_subdir_limit_test.sh: fix "No Space" issue
> 
> Hi Xiaoli,
> 
> > From: Xiaoli Feng <fengxiaoli0714@gmail.com>
> 
> > 1G ext4 filesystem default has 65536 inode. And some inodes
> > will be used after format. So it will be failed when try to
> > create 65536 sub-directorys in this ext4 mountpoint. Change
> > it to create 65536 - used inodes directorys.
> > ---
> 
> > Re-send this mail again. Because I subscripted the ltp mail list failed
> > last
> > time.
> We got your patch twice, even into patchwork ([1]). I disabled the first
> patch
> in patchwork.
> 
> ...
> > +++
> > b/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh
> > @@ -46,6 +46,8 @@ prev_result=$FAIL
> >  ext4_run_case()
> >  {
> >  	local dir_name_len=
> > +	local free_inode=
> > +	local max_directorys=$1
> max_directories, please (or better max_dirs) :).

Thanks Petr for the review. Yes, max_dirs is better.

> 
> >  	if [ $2 -eq $SHORT_DIR ]; then
> >  		dir_name_len="short name"
> > @@ -53,9 +55,6 @@ ext4_run_case()
> >  		dir_name_len="long name"
> >  	fi
> 
> > -	tst_resm TINFO "Num of dirs to create: $1, Dir name len: $dir_name_len, "
> > \
> > -			"Parent dir: $3, Block size: $4"
> > -
> >  	# only mkfs if block size has been changed,
> >  	# or previous case failed
> >  	if [ $prev_result -ne $PASS -o $4 -ne $prev_block_size ]; then
> > @@ -80,11 +79,18 @@ ext4_run_case()
> 
> >  	# create directories
> >  	mkdir -p $3 2> /dev/null
> > +	free_inode=`df -i $EXT4_DEV | awk '{print $4}' | tr -cd "[0-9]"`
> How about using tail instead of tr?
> df -i $EXT4_DEV | tail -1 | awk '{print $4}'
> 
> Maybe tail is more reliable and readable (and available [*]) than tr.

Ok. "tail" is more reliable.

> 
> Not, sure if this is a correct usage:
> # dd if=/dev/zero of=test_file bs=5000MB count=1
> # /opt/ltp/runltp -f fs_ext4 -z /root/test_file
> but in this case is zero Inodes:
> 
> Filesystem     Inodes IUsed IFree IUse% Mounted on
> /dev/vda2           0     0     0     - /
> 

I can't reproduce it when I execute "/opt/ltp/runltp -f fs_ext4 -z /root/test_file".
Do you format the device /dev/vda2? 

> [*]: In new API it's needed to specify required commands in TST_NEEDS_CMDS
> variable (i.e. TST_NEEDS_CMDS="tr"), but this is legacy API, which does not
> have
> it.
> 
> > +	if [ "$free_inode" -lt "$1" ]; then
> I guess here you should use $max_directorys instead of $1
> > +		max_directorys=$free_inode
> > +	fi
> > +
> > +	tst_resm TINFO "Num of dirs to create: $max_directorys, Dir name len:
> > $dir_name_len, " \
> > +			"Parent dir: $3, Block size: $4"
> 
> >  	if [ $2 -eq $SHORT_DIR ]; then
> > -		create_short_dirs $1 $3
> > +		create_short_dirs $max_directorys $3
> Ad $3: I hate using direct positional variables, but that's not related to
> the

I also hate it. :)

> fix. Whole ext4-new-features tests would deserve rewrite into new API and
> cleanup (big work due they all depend on ext4_funcs.sh).

Yes, they would deserve rewrite. I will have a try.

> 
> 
> Kind regards,
> Petr
> 
> [1] https://patchwork.ozlabs.org/patch/1080619/
> 
