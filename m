From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Mon, 30 May 2016 15:26:37 +0200
Subject: [LTP] [LTP-20160510] acl_test01: 44: .: test.sh: not found
Message-ID: <CA+icZUWdzSCUCPM_91Rg3vk1LNGQ7iuAWVqxbPRcjs5ijKSFaw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I wanted to test the "Xattr inode operation removal" patchset from
Andreas Gruenbacher.

So LTP has a testcase called "acl_test01" which I tried for my testing.

In LTP v20160126 and v20160510 I see...

root# cd /opt/ltp ; LC_ALL=C ./runltp -s acl_test01 | tee acl_test01.log

...
/opt/ltp/testcases/bin/acl_test01: 44: .: test.sh: not found
...

...and...

/dev/loop2 on /tmp/ltp-6pUha1I7Ey/tacl/mount-ext3 type ext3
(rw,relatime,data=ordered)
loop: can't delete device /dev/loop2: No such device or address
loop: can't delete device /dev/loop2: No such device or address
...

The 1st issue I tried to hack by...

# diff -uprN testcases/bin/acl_test01.orig testcases/bin/acl_test01
--- testcases/bin/acl_test01.orig       2016-05-30 15:11:10.771931080 +0200
+++ testcases/bin/acl_test01    2016-05-30 15:22:31.627909726 +0200
@@ -41,8 +41,6 @@ export TCID=acltest01
 export TST_TOTAL=5
 export TST_COUNT=1

-. test.sh
-
 TMP=${TMP:=/tmp}

 TEST_USER1="acltest1"
@@ -54,6 +52,8 @@ FILE_ACL="$TMP/tacl/mount-ext3/test_file
 FILE_ACL_LINK="$TMP/tacl/mount-ext3/test_file_link"
 TCbin=`pwd`

+. $TCbin/test.sh
+
 COMMAND=$(command -v "getenforce" "setenforce" |wc -l)
 if [ $COMMAND -eq 2 ]; then
        SELINUX=$(getenforce)

Not sure if this correct.

For the 2nd issue - dunno what's going on.

Beyond all this, how can I test the work of Andreas with LTP?
Any help appreciated.

Regards,
- Sedat -

[1] http://marc.info/?t=146459873600015&r=1&w=2
[2] http://marc.info/?l=linux-fsdevel&m=146461299113521&w=2
-------------- next part --------------
A non-text attachment was scrubbed...
Name: acl_test01.log
Type: application/octet-stream
Size: 8956 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160530/1008f519/attachment-0002.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: LTP_RUN_ON-2016_05_30-15h_19m_49s.log
Type: application/octet-stream
Size: 430 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160530/1008f519/attachment-0003.obj>
