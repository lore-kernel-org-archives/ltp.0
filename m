From: Steve Muckle <smuckle.linux@gmail.com>
Date: Wed,  6 Dec 2017 17:54:02 -0800
Subject: [LTP] [PATCH] fs_racer: fix binary paths in fs_racer scripts
Message-ID: <20171207015402.5131-1-smuckle.linux@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Hsin-Yi Chen <hsinyichen@google.com>

Replace /bin/true with true so as not to depend on the path of the
true binary.

Signed-off-by: Hsin-Yi Chen <hsinyichen@google.com>
Signed-off-by: Steve Muckle <smuckle.linux@gmail.com>
---
 testcases/kernel/fs/racer/fs_racer_dir_create.sh   | 2 +-
 testcases/kernel/fs/racer/fs_racer_dir_test.sh     | 2 +-
 testcases/kernel/fs/racer/fs_racer_file_concat.sh  | 2 +-
 testcases/kernel/fs/racer/fs_racer_file_create.sh  | 2 +-
 testcases/kernel/fs/racer/fs_racer_file_link.sh    | 2 +-
 testcases/kernel/fs/racer/fs_racer_file_list.sh    | 2 +-
 testcases/kernel/fs/racer/fs_racer_file_rename.sh  | 2 +-
 testcases/kernel/fs/racer/fs_racer_file_rm.sh      | 2 +-
 testcases/kernel/fs/racer/fs_racer_file_symlink.sh | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/fs/racer/fs_racer_dir_create.sh b/testcases/kernel/fs/racer/fs_racer_dir_create.sh
index 54ec875b688d..1ac94408f1ce 100755
--- a/testcases/kernel/fs/racer/fs_racer_dir_create.sh
+++ b/testcases/kernel/fs/racer/fs_racer_dir_create.sh
@@ -26,7 +26,7 @@ create(){
     echo "asdf" > $DIR/$file/$file/$file
 }
 
-while /bin/true ; do
+while true ; do
     file=$(($RANDOM%$MAX))
     mkdir -p $DIR/$file/$file/ 2> /dev/null
     create 2> /dev/null
diff --git a/testcases/kernel/fs/racer/fs_racer_dir_test.sh b/testcases/kernel/fs/racer/fs_racer_dir_test.sh
index c2b55ab4ad12..a85506003c49 100755
--- a/testcases/kernel/fs/racer/fs_racer_dir_test.sh
+++ b/testcases/kernel/fs/racer/fs_racer_dir_test.sh
@@ -22,7 +22,7 @@
 
 count=1
 dir=""
-while /bin/true ; do
+while true ; do
     dir=$dir"/a"
     mkdir race/$dir
     count=$(($count + 1))
diff --git a/testcases/kernel/fs/racer/fs_racer_file_concat.sh b/testcases/kernel/fs/racer/fs_racer_file_concat.sh
index a077e071341f..b9cb5d385e8f 100755
--- a/testcases/kernel/fs/racer/fs_racer_file_concat.sh
+++ b/testcases/kernel/fs/racer/fs_racer_file_concat.sh
@@ -28,7 +28,7 @@ concat(){
 
 }
 
-while /bin/true ; do
+while true ; do
     file=$(($RANDOM%$MAX))
     new_file=$(($RANDOM%$MAX))
     concat 2> /dev/null
diff --git a/testcases/kernel/fs/racer/fs_racer_file_create.sh b/testcases/kernel/fs/racer/fs_racer_file_create.sh
index 97789f44ba30..2d3b04d59fad 100755
--- a/testcases/kernel/fs/racer/fs_racer_file_create.sh
+++ b/testcases/kernel/fs/racer/fs_racer_file_create.sh
@@ -29,7 +29,7 @@ create() {
     dd if=/dev/zero of=$DIR/$file bs=1k count=$SIZE
 }
 
-while /bin/true ; do
+while true ; do
     file=$(($RANDOM%$MAX))
     create 2> /dev/null
 done
diff --git a/testcases/kernel/fs/racer/fs_racer_file_link.sh b/testcases/kernel/fs/racer/fs_racer_file_link.sh
index efe1b9f6ab08..9fb59059d3f4 100755
--- a/testcases/kernel/fs/racer/fs_racer_file_link.sh
+++ b/testcases/kernel/fs/racer/fs_racer_file_link.sh
@@ -22,7 +22,7 @@
 DIR=$1
 MAX=$2
 
-while /bin/true ; do
+while true ; do
     file=$(($RANDOM%$MAX))
     new_file=$((($file + 1)%$MAX))
     ln -s $file $DIR/$new_file 2> /dev/null
diff --git a/testcases/kernel/fs/racer/fs_racer_file_list.sh b/testcases/kernel/fs/racer/fs_racer_file_list.sh
index ec5deaa74259..9775d9544dad 100755
--- a/testcases/kernel/fs/racer/fs_racer_file_list.sh
+++ b/testcases/kernel/fs/racer/fs_racer_file_list.sh
@@ -22,7 +22,7 @@
 DIR=$1
 MAX=$2
 
-while /bin/true ; do
+while true ; do
     ls -R $DIR/ > /dev/null 2> /dev/null &
     ls -R $DIR/ > /dev/null 2> /dev/null &
     ls -R $DIR/ > /dev/null 2> /dev/null &
diff --git a/testcases/kernel/fs/racer/fs_racer_file_rename.sh b/testcases/kernel/fs/racer/fs_racer_file_rename.sh
index dd2a6a25dc8b..7e2e6b1b25c9 100755
--- a/testcases/kernel/fs/racer/fs_racer_file_rename.sh
+++ b/testcases/kernel/fs/racer/fs_racer_file_rename.sh
@@ -22,7 +22,7 @@
 DIR=$1
 MAX=$2
 
-while /bin/true ; do
+while true ; do
     file=$(($RANDOM%$MAX))
     new_file=$((($file + 1)%$MAX))
     mv $DIR/$file $DIR/$new_file 2> /dev/null
diff --git a/testcases/kernel/fs/racer/fs_racer_file_rm.sh b/testcases/kernel/fs/racer/fs_racer_file_rm.sh
index c26f823a7b39..2b28a96f2aef 100755
--- a/testcases/kernel/fs/racer/fs_racer_file_rm.sh
+++ b/testcases/kernel/fs/racer/fs_racer_file_rm.sh
@@ -22,7 +22,7 @@
 DIR=$1
 MAX=$2
 
-while /bin/true ; do
+while true ; do
     file=$(($RANDOM%$MAX))
     rm -rf $DIR/$file 2> /dev/null
     sleep 1
diff --git a/testcases/kernel/fs/racer/fs_racer_file_symlink.sh b/testcases/kernel/fs/racer/fs_racer_file_symlink.sh
index f9b14879c411..77b57ec3f73a 100755
--- a/testcases/kernel/fs/racer/fs_racer_file_symlink.sh
+++ b/testcases/kernel/fs/racer/fs_racer_file_symlink.sh
@@ -22,7 +22,7 @@
 DIR=$1
 MAX=$2
 
-while /bin/true ; do
+while true ; do
     file=$(($RANDOM%$MAX))
     new_file=$((($file + 1)%$MAX))
     ln -s $file $DIR/$new_file 2> /dev/null
-- 
2.13.6

