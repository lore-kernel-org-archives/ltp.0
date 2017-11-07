From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue,  7 Nov 2017 15:02:19 +0100
Subject: [LTP] [RFC PATCH] scripts: Dump /proc and /sys
Message-ID: <20171107140219.5606-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When a test fails during automated testing, the state of the system may be
lost due to storage constraints or hardware availability. For example, if the
system under test is virtualized, then the VM image may no longer be available
due to storage capacity limits. Or if one is testing a bare metal system then the
hardware may no longer be accessible for whatever reason.

The serial console output may be available, but lacking some information. So
in order to retain more information (about the kernel at least), we can
systematically copy the contents of /proc and /sys.

Not all sysfs or proc files are meant to be read or block indefinitely or are
infinitely large etc. So the script only tries to copy ~256K from each file
and times out after a second. Files which appear to be OK to read from are
saved to a white list which can be used during future invocations to save some
time.
---
 scripts/proc_sys_dump.sh | 106 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)
 create mode 100644 scripts/proc_sys_dump.sh

diff --git a/scripts/proc_sys_dump.sh b/scripts/proc_sys_dump.sh
new file mode 100644
index 000000000..f845fb46a
--- /dev/null
+++ b/scripts/proc_sys_dump.sh
@@ -0,0 +1,106 @@
+#!/bin/sh
+
+dump_dir=/tmp/dump
+white_list=/tmp/dump/white.list
+use_white_list=
+timeout=1
+batch_size=1000
+
+echo Dump /proc and /sys script, written by rpalethorpe@suse.com
+
+while getopts d:w:u:t:b:h arg
+do case $arg in
+       d) dump_dir="$OPTARG" ;;
+       w) white_list="$OPTARG" ;;
+       u) use_white_list="$OPTARG" ;;
+       t) timeout="$OPTARG" ;;
+       b) batch_size="$OPTARG" ;;
+       h) cat <<-EOF >&1
+
+This script partially dumps the contents of /proc and /sys to a folder. It can
+attempt to dump all the contents and then write out which files were
+successful to a white list. Or use a previously generated white list.
+
+usage: ${0##*/}	[ [ -d dump_dir ]
+ 			[ -w white_list ] [ -u use_white_list ]
+ 			[ -t timeout ]
+ 			[ -b batch_size ]
+ 			|  -h ]
+
+-d dump_dir	  The output directory, note that this will be recreated.
+   		  Set to $dump_dir
+
+-w white_list	  The white list to output after dumping the files.
+   		  Set to $white_list
+
+-u use_white_list The list of files to dump, if this is unset then 'find' is
+   		  used to create a list.
+
+-t timeout	  How long, in seconds, we should wait for operations to finish.
+   		  Set to $timeout.
+
+-h		  Print this help message and exit.
+
+Files are added to the white list if they are small, but not empty and can be
+copied quickly. The idea is that when running the script with -W white_list
+the majority of useful information can be quickly saved during automated
+testing.
+
+EOF
+	  exit 0 ;;
+   esac
+done
+
+files=
+if [ ! $use_white_list ]
+then echo Finding files in /proc and /sys
+     proc_files=$(find -L /proc -maxdepth 4 -readable -not -regex '/proc/[0-9]+/.*' -not -type d 2> /dev/null)
+     sys_files=$(find -L /sys -maxdepth 4 -readable -not -type d 2> /dev/null)
+     files="$proc_files $sys_files"
+else echo Using file list $use_white_list
+     files=$(cat $use_white_list)
+fi
+
+dump_dir=${dump_dir%/}
+echo Dumping to $dump_dir
+rm -rf $dump_dir
+mkdir $dump_dir
+
+count=$batch_size
+for f in $files
+do
+    mkdir -p $dump_dir$(dirname $f)
+    ({
+	dd if=$f of=$dump_dir$f bs=$(getconf PAGESIZE) count=63 status=none &
+	ddproc=$!
+	sleep $timeout
+	if ps -p $ddproc > /dev/null
+	then echo dd $f is taking too long
+	     kill $ddproc
+	     rm $dump_dir$f
+	fi
+    }) &
+    count=$((count - 1))
+    if [ $count -le 0 ]
+    then
+	sleep $timeout
+	count=$batch_size
+    fi
+done
+
+sleep $timeout
+
+if [ ! $white_list ]
+then echo Finished copying files.
+     exit 0
+fi
+
+echo Finished copying files, now generating $white_list
+for f in $(find $dump_dir -not -type d)
+do
+    size=$(stat -c '%s' $f)
+    if [ ${size:=0} -gt 0 -a $size -lt 256000 ]
+    then echo ${f#$dump_dir} >> $white_list
+    else echo $f has invalid file size: ${size:=0}
+    fi
+done
-- 
2.14.3

