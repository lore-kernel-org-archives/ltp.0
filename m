From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Aug 2016 17:57:13 +0200
Subject: [LTP] [PATCH] du01: create the temp file outside of the working
 directory
In-Reply-To: <1469451123-9296-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1469451123-9296-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20160816155713.GG25540@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I noticed that with older kernels and with XFS the 'du -B 512'
> scenario of this test case may fail:
> 
> [root@kholmanskikh du01]# uname -r
> 3.8.13-98.2.2.el6uek.x86_64
> [root@kholmanskikh du01]# ls -l
> total 10240
> drwxr-xr-x 2 root root       24 Jul 25 14:48 testdir
> -rw-r--r-- 1 root root 10485760 Jul 25 14:48 testfile
> [root@kholmanskikh du01]# du -B 512
> 0		   ./testdir
> 20480		   .
> [root@kholmanskikh du01]# du -B 512 > temp; cat temp
> 0		   ./testdir
> 20608		   .
> [root@kholmanskikh du01]#
> 
> This happens because we create 'temp' file in the working directory,
> i.e. 'temp' may already contain some data at the moment 'du' tries
> to 'fstat' it.
> 
> So let's keep the working directory clean and create any extra
> files outside of it.

Looks good to me, acked.

-- 
Cyril Hrubis
chrubis@suse.cz
