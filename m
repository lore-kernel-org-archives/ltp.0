From: zhanglianjie <zhanglianjie@uniontech.com>
Date: Fri,  2 Apr 2021 11:19:34 +0800
Subject: [LTP] [PATCH] fs/iso9660: bugfix for iso9660/isofs.sh
Message-ID: <20210402031934.14615-1-zhanglianjie@uniontech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
>Hi,
>
>> Debian uses genisoimage to replace mkisofs, the prompt of genisoimage
>> is the same as that of mkisofs.
>
>...
>> +++ b/testcases/kernel/fs/iso9660/isofs.sh
>> @@ -12,6 +12,12 @@
>> TST_NEEDS_CMDS="mkisofs"
>> TST_NEEDS_TMPDIR=1
>> TST_TESTFUNC=do_test
>> +which mkisofs >/dev/null 2>&1
>> +if [ $? -ne 0 ]; then
>> + TST_NEEDS_CMDS="genisoimage"
>> +fi
>
>You can omit whole $? check:
>
>if ! which mkisofs >/dev/null 2>&1; then
>TST_NEEDS_CMDS="genisoimage"
>fi
>
>Also IMHO mkisofs is not dead [1], it just moved to schilytools [2] and some
>distros use it (at least openSUSE [3]).
>Thus asking for genisoimage (from cdrkit) can be a bit misleading.
>
>But, is it really needed? Both Debian [4] and Fedora [5] creates
>mkisofs symlink to genisoimage, Debian installs automatically genisoimage when
>installing mkisofs.
>
>Kind regards,
>Petr
>
>[1] https://wiki.osdev.org/Mkisofs
>[2] http://sf.net/projects/schilytools/files/
>[3] https://build.opensuse.org/package/show/utilities/schily
>[4] https://tracker.debian.org/media/packages/c/cdrkit/changelog-91.1.11-3.2
>[5] https://src.fedoraproject.org/rpms/cdrkit/blob/rawhide/f/cdrkit.spec
>
>> +MKISOFS_CMD=$TST_NEEDS_CMDS


Currently in Debian, only the package genisoimage in sid and bullseye contains mkisofs,
and there is no deb package of mkisofs in architectures such as mips. In addition, 
this patch increases compatibility and is better than the previous one. 
It is necessary to modify it.
Reference: https://packages.debian.org/search?suite=sid&searchon=contents&keywords=mkisofs 

According to your suggestion, the revised patch:
---
 testcases/kernel/fs/iso9660/isofs.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/fs/iso9660/isofs.sh b/testcases/kernel/fs/iso9660/isofs.sh
index 9de3f7cdc..1da3a398f 100755
--- a/testcases/kernel/fs/iso9660/isofs.sh
+++ b/testcases/kernel/fs/iso9660/isofs.sh
@@ -12,6 +12,11 @@
 TST_NEEDS_CMDS="mkisofs"
 TST_NEEDS_TMPDIR=1
 TST_TESTFUNC=do_test
+if ! which mkisofs >/dev/null 2>&1; then
+       TST_NEEDS_CMDS="genisoimage"
+fi
+MKISOFS_CMD=$TST_NEEDS_CMDS
+
 . tst_test.sh

 MAX_DEPTH=3
@@ -56,7 +61,7 @@ do_test() {
 		"-allow-lowercase -allow-multidot -iso-level 3 -f -l -D -J -allow-leading-dots -R"
 	do
 		rm -f isofs.iso
-		EXPECT_PASS mkisofs -o isofs.iso -quiet $mkisofs_opt $make_file_sys_dir 2\> /dev/null \
+		EXPECT_PASS $MKISOFS_CMD -o isofs.iso -quiet $mkisofs_opt $make_file_sys_dir 2\> /dev/null \
 			|| continue

 		for mount_opt in \
--
2.20.1


