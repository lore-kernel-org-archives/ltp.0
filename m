From: Steve East <sge@cray.com>
Date: Thu, 23 Mar 2017 19:35:23 +0000
Subject: [LTP] Out-of-tree build missing some data files.
Message-ID: <BN6PR11MB2051C2F128C4DC206D611144CD3F0@BN6PR11MB2051.namprd11.prod.outlook.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When I do an out-of-tree build I am missing some of the files from the datafiles sub-directories. The ones that get installed in testcases/data are:

drwxr-xr-x 2 sge sdivmisc 1024 Mar 22 12:50 ext4-ffsb/
drwxr-xr-x 2 sge sdivmisc   80 Mar 22 12:48 file01/
drwxr-xr-x 2 sge sdivmisc 1024 Mar 22 12:50 ima_policy/
drwxr-xr-x 2 sge sdivmisc   80 Mar 22 12:48 ldd01/
drwxr-xr-x 2 sge sdivmisc 1024 Mar 22 12:49 mc_member/
drwxr-xr-x 2 sge sdivmisc 1024 Mar 22 12:48 nm01/
drwxr-xr-x 2 sge sdivmisc   80 Mar 22 12:49 rpc01/
drwxr-xr-x 3 sge sdivmisc   80 Mar 22 12:50 stress_floppy/
drwxr-xr-x 2 sge sdivmisc   80 Mar 22 12:48 unzip01/

but I don't see the datafiles for ld and ar. In the case of ld, the data files are *.c files which I believe are supposed to be installed uncompiled. For ar, the data files are *.in which also need to be installed as is.

This works for an in-tree build. Bug?

Thanks,
Steve.

