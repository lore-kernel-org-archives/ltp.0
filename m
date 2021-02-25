From: zhaogongyi <zhaogongyi@huawei.com>
Date: Thu, 25 Feb 2021 09:38:20 +0000
Subject: [LTP] [PATCH] unshare01.sh: Setup parent mount flag before
 unshare testing
Message-ID: <F3D3F6AC3820BB4C9FCA340DB5C32CB40387A31F@dggeml511-mbs.china.huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

> Do I understand correctly that all distros without systemd are affected,
> because systemd "automatically remounts all mount points as MS_SHARED
> on system startup" and test expect it?

Yes, the test on system without systemd would be affected.

> Also your patch breaks bind test on very old systems (kernel 2.6, util-linux
> 2.17.2, glibc 2.12):
> unshare01 5 TFAIL: unshare --mount mount --bind dir_A dir_B got bind
> info
> 
> Any idea why (how to avoid this regression)?

I don't known the reason now, maybe relevant to the version of kernel or util-linux. It's need to check.

---------------------------------------------------------------------------------------------------------

> 
> Hi,
> 
> > We need setup parent mount flag to shared before unshare testing, or
> > it will fail for system which has no systemd service since the
> > propagation flag is changed by systemd. From man 7
> mount_namespaces.
> Do I understand correctly that all distros without systemd are affected,
> because systemd "automatically remounts all mount points as MS_SHARED
> on system startup" and test expect it?
> 
> > Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> > ---
> >  testcases/commands/unshare/unshare01.sh | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> > diff --git a/testcases/commands/unshare/unshare01.sh
> > b/testcases/commands/unshare/unshare01.sh
> > index bf163a7f4..e1fb15035 100755
> > --- a/testcases/commands/unshare/unshare01.sh
> > +++ b/testcases/commands/unshare/unshare01.sh
> > @@ -31,7 +31,6 @@ TST_SETUP=setup
> >  TST_CLEANUP=cleanup
> >  TST_TESTFUNC=do_test
> >  TST_NEEDS_ROOT=1
> > -TST_NEEDS_TMPDIR=1
> You still need TST_NEEDS_TMPDIR=1, because you create files and
> directories.
> 
> Also your patch breaks bind test on very old systems (kernel 2.6, util-linux
> 2.17.2, glibc 2.12):
> unshare01 5 TFAIL: unshare --mount mount --bind dir_A dir_B got bind
> info
> 
> Any idea why (how to avoid this regression)?
> 
> >  TST_NEEDS_CMDS="unshare id mount umount"
> >  . tst_test.sh
> 
> > @@ -39,6 +38,7 @@
> max_userns_path="/proc/sys/user/max_user_namespaces"
> >  max_mntns_path="/proc/sys/user/max_mnt_namespaces"
> >  default_max_userns=-1
> >  default_max_mntns=-1
> > +CURR=$(pwd)
> Instead of $CURR, cd - can be used.
> 
> >  setup()
> >  {
> > @@ -55,6 +55,10 @@ setup()
> >  		echo 1024 > "${max_mntns_path}"
> >  	fi
> 
> > +	mkdir $CURR/dir_C
> just mkdir dir_C
> > +	mount -t tmpfs none dir_C
> > +	mount --make-shared dir_C
> FYI We have tst_mount, but it'd not help much here.
> 
> > +	cd dir_C
> >  	mkdir -p dir_A dir_B
> >  	touch dir_A/A dir_B/B
> >  }
> > @@ -66,6 +70,9 @@ cleanup()
> >  		echo ${default_max_userns} > "${max_userns_path}"
> >  	[ ${default_max_mntns} -ne -1 ] && \
> >  		echo ${default_max_mntns} > "${max_mntns_path}"
> > +	cd $CURR
> > +	umount dir_C
> tst_umount dir_C
> 
> > +	rm -rf dir_C
> rm is not needed (cleanup is done automatically).
> >  }
> 
> >  check_id()
> 
> Full diff of changes I propose below.
> 
> Kind regards,
> Petr
> 
> diff --git testcases/commands/unshare/unshare01.sh
> testcases/commands/unshare/unshare01.sh
> index e1fb15035..0b5c56811 100755
> --- testcases/commands/unshare/unshare01.sh
> +++ testcases/commands/unshare/unshare01.sh
> @@ -31,6 +31,7 @@ TST_SETUP=setup
>  TST_CLEANUP=cleanup
>  TST_TESTFUNC=do_test
>  TST_NEEDS_ROOT=1
> +TST_NEEDS_TMPDIR=1
>  TST_NEEDS_CMDS="unshare id mount umount"
>  . tst_test.sh
> 
> @@ -38,7 +39,6 @@
> max_userns_path="/proc/sys/user/max_user_namespaces"
>  max_mntns_path="/proc/sys/user/max_mnt_namespaces"
>  default_max_userns=-1
>  default_max_mntns=-1
> -CURR=$(pwd)
> 
>  setup()
>  {
> @@ -55,7 +55,7 @@ setup()
>  		echo 1024 > "${max_mntns_path}"
>  	fi
> 
> -	mkdir $CURR/dir_C
> +	mkdir dir_C
>  	mount -t tmpfs none dir_C
>  	mount --make-shared dir_C
>  	cd dir_C
> @@ -70,9 +70,8 @@ cleanup()
>  		echo ${default_max_userns} > "${max_userns_path}"
>  	[ ${default_max_mntns} -ne -1 ] && \
>  		echo ${default_max_mntns} > "${max_mntns_path}"
> -	cd $CURR
> -	umount dir_C
> -	rm -rf dir_C
> +	cd - >/dev/null
> +	tst_umount dir_C
>  }
> 
>  check_id()
