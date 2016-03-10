From: Zirong Lang <zlang@redhat.com>
Date: Thu, 10 Mar 2016 11:08:02 -0500 (EST)
Subject: [LTP] [PATCH v2] tst_mkfs: add new parameter extra_opts to
 tst_mkfs function
In-Reply-To: <20160310142428.GB19672@rei.lan>
References: <1457617584-436-1-git-send-email-zlang@redhat.com>
 <20160310142428.GB19672@rei.lan>
Message-ID: <831178725.28235426.1457626082972.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it



----- 原始邮件 -----
> 发件人: "Cyril Hrubis" <chrubis@suse.cz>
> 收件人: "Zorro Lang" <zlang@redhat.com>
> 抄送: ltp@lists.linux.it
> 发送时间: 星期四, 2016年 3 月 10日 下午 10:24:28
> 主题: Re: [PATCH v2] tst_mkfs: add new parameter extra_opts to tst_mkfs function
> 
> > diff --git a/doc/test-writing-guidelines.txt
> > b/doc/test-writing-guidelines.txt
> > index 1f260cb..e9c56c8 100644
> > --- a/doc/test-writing-guidelines.txt
> > +++ b/doc/test-writing-guidelines.txt
> > @@ -906,15 +906,21 @@ NOTE: The default filesytem is hardcoded to 'ext2' in
> > the sources and can be
> >  #include "test.h"
> >  
> >  void tst_mkfs(void (cleanup_fn)(void), const char *dev,
> > -              const char *fs_type, const char *const fs_opts[]);
> > +              const char *fs_type, const char *const fs_opts[]
> > +              const char *extra_opts);
> >  -------------------------------------------------------------------------------
> >  
> >  This function takes a path to a device, filesystem type and an array of
> >  extra
> >  options passed to mkfs.
> >  
> > -The extra options 'fs_opts' should either be 'NULL' if there are none, or
> > a
> > +The fs options 'fs_opts' should either be 'NULL' if there are none, or a
> >  'NULL' terminated array of strings such as '{"-b", "1024", NULL}'.
> >  
> > +The extra options 'extra_opts' should either be 'NULL' if there are none,
> > or
> > +a string such as "102400". 'extra_opts' will be used behind device name.
> > e.g:
> > +mkfs -t ext4 -b 1024 /dev/sda1 102400
> > +                               ^^^^^^
> 
> The documentation file si ascii-doc formatted and the ^^^^^ under 102400
> is not correct syntax.

Oh, I will delete this ^^^^^.

> 
> >  2.2.16 Verifying a filesystem's free space
> >  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >  
> > diff --git a/include/test.h b/include/test.h
> > index 5c78b1d..211ffb6 100644
> > --- a/include/test.h
> > +++ b/include/test.h
> > @@ -316,10 +316,12 @@ int tst_system(const char *command);
> >   *
> >   * @dev: path to a device
> >   * @fs_type: filesystem type
> > - * @fs_opts: NULL or NULL terminated array of extra mkfs options
> > + * @fs_opts: NULL or NULL terminated array of mkfs options
> > + * @extra_opts: extranal mkfs options which need to behind the device name
>          ^
> 	 should be extra_opt right?

Yes, you're right. Only one option. I haven't find any other options need to behind
device name. If I find more than one, I will change it to char *extra_opts[].

> 
> >   */
> >  void tst_mkfs(void (cleanup_fn)(void), const char *dev,
> > -	      const char *fs_type, const char *const fs_opts[]);
> > +              const char *fs_type, const char *const fs_opts[],
> > +              const char *extra_opts);
> >  
> >  /*
> >   * Returns filesystem type to be used for the testing. Unless your test is
> > diff --git a/lib/tests/tst_device.c b/lib/tests/tst_device.c
> > index 6a7925e..525bdc0 100644
> > --- a/lib/tests/tst_device.c
> > +++ b/lib/tests/tst_device.c
> > @@ -46,7 +46,7 @@ int main(void)
> >  
> >  	printf("Test device='%s'\n", dev);
> >  
> > -	tst_mkfs(cleanup, dev, "ext2", NULL);
> > +	tst_mkfs(cleanup, dev, "ext2", NULL, NULL);
> >  
> >  	cleanup();
> >  	tst_exit();
> > diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
> > index 5f959a4..7b02578 100644
> > --- a/lib/tst_mkfs.c
> > +++ b/lib/tst_mkfs.c
> > @@ -21,12 +21,24 @@
> >  
> >  #define OPTS_MAX 32
> >  
> > +/*
> > + * tst_mkfs: mkfs.$fs_type on $dev with options $fs_opts and $extra_opts
> > + *     cleanup_fn - run it when exit with error.
> > + *     dev        - device path name
> > + *     fs_opts    - store the options for mkfs (except -t fs_type). Set
> > + *                  NULL if don't need options.
> > + *     extra_opts - extranal mkfs options for mkfs, these options need
> > + *                  behind the device name, e.g. [fs_size] for ext4.
> > + *                  Set NULL, if don't need options behind device name.
> > + */
> >  void tst_mkfs(void (cleanup_fn)(void), const char *dev,
> > -	      const char *fs_type, const char *const fs_opts[])
> > +              const char *fs_type, const char *const fs_opts[],
> > +              const char *extra_opts)
> >  {
> >  	int i, pos = 3;
> >  	const char *argv[OPTS_MAX] = {"mkfs", "-t", fs_type};
> >  	char fs_opts_str[1024] = "";
> > +	const char *fs_extra_opts = extra_opts;
> >  
> >  	if (!fs_type)
> >  		tst_brkm(TBROK, cleanup_fn, "No fs_type specified");
> > @@ -68,10 +80,22 @@ void tst_mkfs(void (cleanup_fn)(void), const char *dev,
> >  	}
> >  
> >  	argv[pos++] = dev;
> > +
> > +	if (fs_extra_opts) {
> > +		argv[pos++] = extra_opts;
> > +
> > +		if (pos + 1 > OPTS_MAX) {
> > +			tst_brkm(TBROK, cleanup_fn,
> > +			         "Too much mkfs options");
> > +		}
> > +	} else {
> > +		fs_extra_opts = "None";
> > +	}
> > +
> >  	argv[pos] = NULL;
> >  
> > -	tst_resm(TINFO, "Formatting %s with %s extra opts='%s'",
> > -		 dev, fs_type, fs_opts_str);
> > +	tst_resm(TINFO, "Formatting %s with %s opts='%s' extra opts='%s'",
> > +	         dev, fs_type, fs_opts_str, fs_extra_opts);
> 
> You can do just:
> 
> extra_opts ? extra_opts : ""
> 
> In order to save the trouble of fidling with two similary named
> variables that sometimes does not hold the same value.

Yes, good idea!

> 
> >  	tst_run_cmd(cleanup_fn, argv, "/dev/null", NULL, 0);
> >  }
> >  

<skip ...>

> > diff --git a/testcases/kernel/syscalls/mmap/mmap16.c
> > b/testcases/kernel/syscalls/mmap/mmap16.c
> > index c5828ea..494cd93 100644
> > --- a/testcases/kernel/syscalls/mmap/mmap16.c
> > +++ b/testcases/kernel/syscalls/mmap/mmap16.c
> > @@ -158,7 +158,7 @@ static void setup(void)
> >  	device = tst_acquire_device(cleanup);
> >  	if (!device)
> >  		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
> > -	tst_mkfs(cleanup, device, fs_type, fs_opts);
> > +	tst_mkfs(cleanup, device, fs_type, fs_opts, "10240");
> 
> So mkfs.ext4 works with 10Mb device as well? The we should go with 10Mb.

I tested 10Mb for mmap16, it works well.

I will send V3 patch with above review suggestions.

Thanks,
Zorro
