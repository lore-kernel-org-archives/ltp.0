From: Zirong Lang <zlang@redhat.com>
Date: Wed, 9 Mar 2016 10:31:32 -0500 (EST)
Subject: [LTP] [PATCH 1/2] lib/tst_mkfs: new tst_mkfs_sized function for
 create appointed size fs
In-Reply-To: <20160309130709.GA28171@rei.lan>
References: <1457444133-5671-1-git-send-email-zlang@redhat.com>
 <20160309130709.GA28171@rei.lan>
Message-ID: <1202691488.27788761.1457537492316.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it



----- 原始邮件 -----
> 发件人: "Cyril Hrubis" <chrubis@suse.cz>
> 收件人: "Zorro Lang" <zlang@redhat.com>
> 抄送: ltp@lists.linux.it
> 发送时间: 星期三, 2016年 3 月 09日 下午 9:07:10
> 主题: Re: [PATCH 1/2] lib/tst_mkfs: new tst_mkfs_sized function for create appointed size fs
> 
> Hi!
> >  #include "test.h"
> >  #include "ltp_priv.h"
> >  
> >  #define OPTS_MAX 32
> >  
> > -void tst_mkfs(void (cleanup_fn)(void), const char *dev,
> > -	      const char *fs_type, const char *const fs_opts[])
> > +long long cvtnum(const char *s)
> > +{
> > +	long long i;
> > +	char *sp = NULL;
> > +
> > +	i = strtoll(s, &sp, 0);
> > +	if (i == 0 && sp == s)
> > +		return -1LL;
> > +	if (*sp == '\0')
> > +		return i;
> > +
> > +	if (*sp == 'k' && sp[1] == '\0')
> > +		return 1024LL * i;
> > +	if (*sp == 'm' && sp[1] == '\0')
> > +		return 1024LL * 1024LL * i;
> > +	if (*sp == 'g' && sp[1] == '\0')
> > +		return 1024LL * 1024LL * 1024LL * i;
> > +	if (*sp == 't' && sp[1] == '\0')
> > +		return 1024LL * 1024LL * 1024LL * 1024LL * i;
> > +	if (*sp == 'p' && sp[1] == '\0')
> > +		return 1024LL * 1024LL * 1024LL * 1024LL * 1024LL * i;
> > +	if (*sp == 'e' && sp[1] == '\0')
> > +		return 1024LL * 1024LL * 1024LL * 1024LL * 1024LL * 1024LL * i;
> > +	return -1LL;
> > +}
> 
> We allready have bytes_by_prefix() in LTP library.

Oh, I just noticed that function. The difference is bytes_by_prefix() run an
int value, so it can't bigger than 2^31. But some FS, likes XFS can support
very huge size, even in RHEL-7, XFS support 500T. it's bigger than 2^31.

But generally we won't run LTP on a 500T device:) So if you don't want to change
that, we should say mkfs size can't bigger than 2^31 bytes, or the result will
be unexpected.

> 
> > +void tst_mkfs_sized(void (cleanup_fn)(void), const char *dev,
> > +                    const char *fs_type, const char *const fs_opts[],
> > +                    const char *fssize, const char *blocksize)
> 
> What about passing the size parameter as we do in tst_fs_has_free()?
> 
> I.e. with two paramters where one is size and the second is units?

Oh, I don't know why we need two parameters to describe one size. I use
"char *fssize" due to tst_mkfs() use string paramters directly, it don't
need an int value(but int value is OK too).

> 
> Also why have you added the blocksize parameter as well? The block size
> is needed only for the mmap16 test while limiting filesystem size seems
> like good addition to the library?

Block size is needed because some fs need to know the block count, if you
want to create a sized fs. For example if we want to make 512m ext4 and xfs:

xfs can directly use mkfs -t xfs -d size=512m device

but mkfs.ext4 need to do like: mkfs -t ext4 -b $block_size device 512*1024*1024/$block_size

So we need to know block size for some fs, as I know udf fs need to know block count too.

> 
> >  {
> >  	int i, pos = 3;
> >  	const char *argv[OPTS_MAX] = {"mkfs", "-t", fs_type};
> >  	char fs_opts_str[1024] = "";
> > +	char blk_size_str[256] = "";
> > +	char fs_size_str[256] = "";
> > +	long long fssz = 0;
> > +	unsigned int blsz= 0;
> >  
> >  	if (!fs_type)
> >  		tst_brkm(TBROK, cleanup_fn, "No fs_type specified");
> >  
> > -	/*
> > -	 * mkfs.xfs and mkfs.btrfs aborts if it finds a filesystem
> > -	 * superblock on the device, which is the case here as we
> > -	 * reuse one device for all tests.
> > -	 */
> >  	if (!strcmp(fs_type, "xfs")) {
> > +		/*
> > +		 * mkfs.xfs and mkfs.btrfs aborts if it finds a filesystem
> > +		 * superblock on the device, which is the case here as we
> > +		 * reuse one device for all tests.
> > +		 */
> >  		tst_resm(TINFO, "Appending '-f' flag to mkfs.%s", fs_type);
> >  		argv[pos++] = "-f";
> > -	}
> > +		if (blocksize) {
> > +			argv[pos++] = "-b";
> > +			strcat(blk_size_str, "size=");
> > +			strcat(blk_size_str, blocksize);
> > +			argv[pos++] = blk_size_str;
> > +		}
> >  
> > -	if (!strcmp(fs_type, "btrfs")) {
> > +		if (!fssize) {
> > +			argv[pos++] = "-d";
> > +			strcat(fs_size_str, "size=");
> > +			strcat(fs_size_str, fssize);
> > +			argv[pos++] = fs_size_str;
> > +		}
> > +	} else if (!strncmp(fs_type, "ext", 3)) {
> > +		if (blocksize) {
> > +			argv[pos++] = "-b";
> > +			argv[pos++] = blocksize;
> > +		}
> > +		/*
> > +		 * If fs is extX, the fs_size should be set behind device name.
> > +		 * Not set at here.
> > +		 */
> > +	} else if (!strcmp(fs_type, "btrfs")) {
> >  		/*
> >  		 * The -f option was added to btrfs-progs v3.12
> >  		 */
> > @@ -50,6 +102,21 @@ void tst_mkfs(void (cleanup_fn)(void), const char *dev,
> >  				fs_type);
> >  			argv[pos++] = "-f";
> >  		}
> > +		if (fssize) {
> > +			/*
> > +			 * The recommended size for the mixed mode is for filesystems less than
> > 1GiB
> > +			 */
> > +			if (cvtnum(fssize) < 1024 * 1024 * 1024)
> > +				argv[pos++] = "--mixed";
> > +			argv[pos++] = "-b";
> > +			argv[pos++] = fssize;
> > +		}
> > +	} else if (fssize || blocksize) {
> > +		/*
> > +		 * Can't set fs size or block size for others fs,
> > +		 * except add new fs support as above.
> > +		 */
> > +		tst_brkm(TBROK, cleanup_fn, "tst_mkfs_sized don't support '%s' fs,
> > please add this fs as a new feature", fs_type);
> >  	}
> >  
> >  	if (fs_opts) {
> > @@ -68,10 +135,30 @@ void tst_mkfs(void (cleanup_fn)(void), const char
> > *dev,
> >  	}
> >  
> >  	argv[pos++] = dev;
> > +
> > +	/*
> > +	 * According to mke2fs(8) manual, fs-size need be behind the device
> > +	 * parameter. So add fs size into argv[pos++] after dev name.
> > +	 */
> > +	if (!strncmp(fs_type, "ext", 3) && fssize && blocksize) {
> > +		fssz = cvtnum(fssize);
> > +		blsz = cvtnum(blocksize);
> > +		if (fssz > 0 && blsz > 0){
> > +			sprintf(fs_size_str, "%llu", fssz / blsz);
> > +		} else {
> > +			tst_brkm(TBROK, cleanup_fn, "No suitable filesystem/block size
> > specified");
> > +		}
> > +		argv[pos++] = fs_size_str;
> > +	}
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
>
