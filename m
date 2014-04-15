Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mats.liljegren@enea.com>) id 1Wa0to-0004Yq-JI
	for ltp-list@lists.sourceforge.net; Tue, 15 Apr 2014 10:47:32 +0000
Received: from sestofw01.enea.se ([192.36.1.252] helo=mx-3.enea.com)
	by sog-mx-1.v43.ch3.sourceforge.com with smtp (Exim 4.76)
	id 1Wa0tm-0006NJ-7f
	for ltp-list@lists.sourceforge.net; Tue, 15 Apr 2014 10:47:32 +0000
Date: Tue, 15 Apr 2014 12:47:17 +0200
From: Mats Liljegren <mats.liljegren@enea.com>
Message-ID: <20140415124717.516e6851@mats-desktop>
MIME-Version: 1.0
Subject: [LTP] fs_ext4 fails
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

I'm just wondering whether fs_ext4 is known to fail. I ran the
following command line:

./runltp -f fs_ext4 -z /dev/sda2

<lots of output>

ext4-uninit-groups   23  TPASS  :  ext4 uninit groups test pass
[ 6526.254961] EXT4-fs (sda2): Ignoring removed oldalloc option
[ 6526.315061] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: oldalloc,nodelalloc
ext4-uninit-groups   24  TPASS  :  ext4 uninit groups test pass
<<<execution_status>>>
initiation_status="ok"
duration=5246 termination_type=exited termination_id=0 corefile=no
cutime=551 cstime=23041
<<<test_end>>>
<<<test_start>>>
tag=ext4-persist-prealloc stime=1397562084
cmdline="ext4_persist_prealloc_test.sh"
contacts=""
analysis=exit
<<<test_output>>>
[ 6527.908973] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
ext4-persistent-preallocation    1  TFAIL  :  fsck returned failure
[ 6529.716461] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
ext4-persistent-preallocation    2  TFAIL  :  fsck returned failure
<<<execution_status>>>
initiation_status="ok"
duration=3 termination_type=exited termination_id=1 corefile=no
cutime=12 cstime=27
<<<test_end>>>
<<<test_start>>>
tag=ext4-subdir-limit stime=1397562087
cmdline="ext4_subdir_limit_test.sh"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
ext4-subdir-limit    0  TINFO  :  Num of dirs to create: 65537, Dir name len: short name, 
[ 6531.410938] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
ext4-subdir-limit    1  TFAIL  :  fsck: the filesystem has errors
ext4-subdir-limit    0  TINFO  :  Num of dirs to create: 65537, Dir name len: short name, 
[ 6735.110894] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
ext4-subdir-limit    2  TFAIL  :  fsck: the filesystem has errors
ext4-subdir-limit    0  TINFO  :  Num of dirs to create: 65537, Dir name len: short name, 
[ 6755.240577] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
ext4-subdir-limit    3  TFAIL  :  fsck: the filesystem has errors
ext4-subdir-limit    0  TINFO  :  Num of dirs to create: 65537, Dir name len: long name, 
[ 6770.146701] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
ext4-subdir-limit    4  TFAIL  :  fsck: the filesystem has errors
ext4-subdir-limit    0  TINFO  :  Num of dirs to create: 65537, Dir name len: short name, 
[ 6841.867884] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
ext4-subdir-limit    5  TFAIL  :  fsck: the filesystem has errors
ext4-subdir-limit    0  TINFO  :  Num of dirs to create: 65537, Dir name len: long name, 
[ 6854.664835] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
ext4-subdir-limit    6  TFAIL  :  fsck: the filesystem has errors
ext4-subdir-limit    0  TINFO  :  Num of dirs to create: 65537, Dir name len: short name, 
[ 6902.995160] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
ext4-subdir-limit    7  TFAIL  :  fsck: the filesystem has errors
ext4-subdir-limit    0  TINFO  :  Num of dirs to create: 65537, Dir name len: long name, 
[ 6915.333474] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
ext4-subdir-limit    8  TFAIL  :  fsck: the filesystem has errors
ext4-subdir-limit    0  TINFO  :  Num of dirs to create: 65537, Dir name len: short name, 
[ 6941.661018] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
ext4-subdir-limit    9  TFAIL  :  fsck: the filesystem has errors
ext4-subdir-limit    0  TINFO  :  Num of dirs to create: 65537, Dir name len: long name, 
[ 6953.724298] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
ext4-subdir-limit   10  TFAIL  :  fsck: the filesystem has errors
<<<execution_status>>>
initiation_status="ok"
duration=443 termination_type=exited termination_id=1 corefile=no
cutime=293 cstime=2246
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20140115

       ###############################################################

            Done executing testcases.
            LTP Version:  20140115
       ###############################################################

Since a lot passes, I'd think that there shouldn't be an error with my
setup. But I'm not totally convinced about it...

/Mats

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
