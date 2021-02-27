From: zhaogongyi <zhaogongyi@huawei.com>
Date: Sat, 27 Feb 2021 09:46:50 +0000
Subject: [LTP] [PATCH] unshare01.sh: Setup parent mount flag before
 unshare testing
Message-ID: <F3D3F6AC3820BB4C9FCA340DB5C32CB40387BFBC@dggeml511-mbs.china.huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yang,

>           6) unshare_test "--mount --propagation shared" \
>                        "mount --bind dir_A dir_B" "mounted";;

> For example:
> # 6) If we run with "--mount --propagation shared" and parent mount
> namespace is shared, mount and unmount events can do propagation. "
> # 7) If we run with "--mount --propagation shared" and parent mount
> namespace is not shared, mount and unmount events cannot do
> propagation. "

	In test 6, when we run with "--mount --propagation shared" and parent mount namespace is not shared,
	there are 3 steps:
		1) unshare --mount --propagation shared
		2) mount --bind dir_A dir_B
		3) exit the namespace

	So the test has no sence sinc step 3) has exit the namespace.

Thanks!

============================================================= 
> On 2021/2/25 18:02, zhaogongyi wrote:
> > Hi Yang,
> >
> >> I don't like the approach which enforces mountpoint to be shared in
> >> parent mount namespace.
> >> I think we can tune expected value by checking propagation flag in
> >> parent mount namespace because of two reasons:
> >> 1) Make test cover more cases.
> >> 2) Don't depend on the fixed tmpfs.
> >
> > If we have no fixed parent mount namespace, the test looks like will pass
> at any cases since we judge result by "grep -w 'dir_B' /proc/self/mountinfo
> | grep -qw 'shared'".
> Hi Zhongyi,
> 
> This issue is caused by the state(e.g. share or private) of parent mount
> namespace and both of results are expected.
> 
> > It seems a bit tangential to our test objective as " # 6) If we run with
> "--mount --propagation shared", mount and unmount events propagate to
> its parent mount namespace. "
> We also need to update the description of #6 because it is true only when
> the parent mount namespace is shared.
> For example:
> # 6) If we run with "--mount --propagation shared" and parent mount
> namespace is shared, mount and unmount events can do propagation. "
> # 7) If we run with "--mount --propagation shared" and parent mount
> namespace is not shared, mount and unmount events cannot do
> propagation. "
> 
> Best Regards,
> Xiao Yang
> >
> > Thanks!
> >
> >
> =========================================================
> =
> >
> >> Hi Zhongyi, Petr
> >>
> >> I don't like the approach which enforces mountpoint to be shared in
> >> parent mount namespace.
> >> I think we can tune expected value by checking propagation flag in
> >> parent mount namespace because of two reasons:
> >> 1) Make test cover more cases.
> >> 2) Don't depend on the fixed tmpfs.
> >>
> >> Zhongyi,  could you test the following patch on your enviorment?
> >> ---------------------------------------------------------------------
> >> ---------------------------- diff --git
> >> a/testcases/commands/unshare/unshare01.sh
> >> b/testcases/commands/unshare/unshare01.sh
> >> index bf163a7f4..78ea83fc0 100755
> >> --- a/testcases/commands/unshare/unshare01.sh
> >> +++ b/testcases/commands/unshare/unshare01.sh
> >> @@ -40,6 +40,17 @@
> >> max_mntns_path="/proc/sys/user/max_mnt_namespaces"
> >>    default_max_userns=-1
> >>    default_max_mntns=-1
> >>
> >> +parse_propagation_flag()
> >> +{
> >> +       mount --bind dir_A dir_B
> >> +       if grep -w 'dir_B' /proc/self/mountinfo | grep -qw 'shared';
> then
> >> +               echo "mounted"
> >> +       else
> >> +               echo "unmounted"
> >> +       fi
> >> +       umount dir_B
> >> +}
> >> +
> >>    setup()
> >>    {
> >>           # On some distributions(e.g RHEL7.4), the default value of
> >> @@
> >> -149,7 +160,8 @@ do_test()
> >>           4) unshare_test "--user --map-root-user" "id -g" "0";;
> >>           5) unshare_test "--mount" "mount --bind dir_A dir_B"
> >> "unmounted";;
> >>           6) unshare_test "--mount --propagation shared" \
> >> -                       "mount --bind dir_A dir_B" "mounted";;
> >> +                       "mount --bind dir_A dir_B" \
> >> +                       "$(parse_propagation_flag)";;
> >>           7) unshare_test "--user --map-root-user --mount" \
> >>                           "mount --bind dir_A dir_B"
> "unmounted";;
> >>           8) unshare_test "--user --map-root-user --mount
> >> --propagation shared" \
> >> --
> >> ---------------------------------------------------------------------
> >> ---------------------
> >>
> >> Best Regards,
> >> Xiao Yang
> >> On 2021/2/24 9:40, Petr Vorel wrote:
> >>> Hi,
> >>>
> >>>> We need setup parent mount flag to shared before unshare testing,
> >>>> or it will fail for system which has no systemd service since the
> >>>> propagation flag is changed by systemd. From man 7
> >> mount_namespaces.
> >>> Do I understand correctly that all distros without systemd are
> >>> affected, because systemd "automatically remounts all mount points
> >>> as MS_SHARED on system startup" and test expect it?
> >>>
> >>>> Signed-off-by: Zhao Gongyi<zhaogongyi@huawei.com>
> >>>> ---
> >>>>    testcases/commands/unshare/unshare01.sh | 9 ++++++++-
> >>>>    1 file changed, 8 insertions(+), 1 deletion(-) diff --git
> >>>> a/testcases/commands/unshare/unshare01.sh
> >>>> b/testcases/commands/unshare/unshare01.sh
> >>>> index bf163a7f4..e1fb15035 100755
> >>>> --- a/testcases/commands/unshare/unshare01.sh
> >>>> +++ b/testcases/commands/unshare/unshare01.sh
> >>>> @@ -31,7 +31,6 @@ TST_SETUP=setup
> >>>>    TST_CLEANUP=cleanup
> >>>>    TST_TESTFUNC=do_test
> >>>>    TST_NEEDS_ROOT=1
> >>>> -TST_NEEDS_TMPDIR=1
> >>> You still need TST_NEEDS_TMPDIR=1, because you create files and
> >> directories.
> >>> Also your patch breaks bind test on very old systems (kernel 2.6,
> >>> util-linux 2.17.2, glibc 2.12):
> >>> unshare01 5 TFAIL: unshare --mount mount --bind dir_A dir_B got
> bind
> >>> info
> >>>
> >>> Any idea why (how to avoid this regression)?
> >>>
> >>>>    TST_NEEDS_CMDS="unshare id mount umount"
> >>>>    . tst_test.sh
> >>>> @@ -39,6 +38,7 @@
> >> max_userns_path="/proc/sys/user/max_user_namespaces"
> >>>>    max_mntns_path="/proc/sys/user/max_mnt_namespaces"
> >>>>    default_max_userns=-1
> >>>>    default_max_mntns=-1
> >>>> +CURR=$(pwd)
> >>> Instead of $CURR, cd - can be used.
> >>>
> >>>>    setup()
> >>>>    {
> >>>> @@ -55,6 +55,10 @@ setup()
> >>>>    		echo 1024>   "${max_mntns_path}"
> >>>>    	fi
> >>>> +	mkdir $CURR/dir_C
> >>> just mkdir dir_C
> >>>> +	mount -t tmpfs none dir_C
> >>>> +	mount --make-shared dir_C
> >>> FYI We have tst_mount, but it'd not help much here.
> >>>
> >>>> +	cd dir_C
> >>>>    	mkdir -p dir_A dir_B
> >>>>    	touch dir_A/A dir_B/B
> >>>>    }
> >>>> @@ -66,6 +70,9 @@ cleanup()
> >>>>    		echo ${default_max_userns}>   "${max_userns_path}"
> >>>>    	[ ${default_max_mntns} -ne -1 ]&&   \
> >>>>    		echo ${default_max_mntns}>   "${max_mntns_path}"
> >>>> +	cd $CURR
> >>>> +	umount dir_C
> >>> tst_umount dir_C
> >>>
> >>>> +	rm -rf dir_C
> >>> rm is not needed (cleanup is done automatically).
> >>>>    }
> >>>>    check_id()
> >>> Full diff of changes I propose below.
> >>>
> >>> Kind regards,
> >>> Petr
> >>>
> >>> diff --git testcases/commands/unshare/unshare01.sh
> >>> testcases/commands/unshare/unshare01.sh
> >>> index e1fb15035..0b5c56811 100755
> >>> --- testcases/commands/unshare/unshare01.sh
> >>> +++ testcases/commands/unshare/unshare01.sh
> >>> @@ -31,6 +31,7 @@ TST_SETUP=setup
> >>>    TST_CLEANUP=cleanup
> >>>    TST_TESTFUNC=do_test
> >>>    TST_NEEDS_ROOT=1
> >>> +TST_NEEDS_TMPDIR=1
> >>>    TST_NEEDS_CMDS="unshare id mount umount"
> >>>    . tst_test.sh
> >>>
> >>> @@ -38,7 +39,6 @@
> >> max_userns_path="/proc/sys/user/max_user_namespaces"
> >>>    max_mntns_path="/proc/sys/user/max_mnt_namespaces"
> >>>    default_max_userns=-1
> >>>    default_max_mntns=-1
> >>> -CURR=$(pwd)
> >>>
> >>>    setup()
> >>>    {
> >>> @@ -55,7 +55,7 @@ setup()
> >>>    		echo 1024>   "${max_mntns_path}"
> >>>    	fi
> >>>
> >>> -	mkdir $CURR/dir_C
> >>> +	mkdir dir_C
> >>>    	mount -t tmpfs none dir_C
> >>>    	mount --make-shared dir_C
> >>>    	cd dir_C
> >>> @@ -70,9 +70,8 @@ cleanup()
> >>>    		echo ${default_max_userns}>   "${max_userns_path}"
> >>>    	[ ${default_max_mntns} -ne -1 ]&&   \
> >>>    		echo ${default_max_mntns}>   "${max_mntns_path}"
> >>> -	cd $CURR
> >>> -	umount dir_C
> >>> -	rm -rf dir_C
> >>> +	cd ->/dev/null
> >>> +	tst_umount dir_C
> >>>    }
> >>>
> >>>    check_id()
> >>>
> >>
> >
> >
> > .
> >
> 
> 

