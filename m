Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1TEBOD-0001QK-Ff
	for ltp-list@lists.sourceforge.net; Wed, 19 Sep 2012 03:55:53 +0000
Received: from acsinet15.oracle.com ([141.146.126.227])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1TEBOC-00071V-Sa
	for ltp-list@lists.sourceforge.net; Wed, 19 Sep 2012 03:55:53 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by acsinet15.oracle.com (Sentrion-MTA-4.2.2/Sentrion-MTA-4.2.2) with
	ESMTP id q8J3tj3Y025684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 19 Sep 2012 03:55:46 GMT
Received: from acsmt357.oracle.com (acsmt357.oracle.com [141.146.40.157])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	q8J3tjj3016514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 19 Sep 2012 03:55:45 GMT
Received: from abhmt108.oracle.com (abhmt108.oracle.com [141.146.116.60])
	by acsmt357.oracle.com (8.12.11.20060308/8.12.11) with ESMTP id
	q8J3tjja016931
	for <ltp-list@lists.sourceforge.net>; Tue, 18 Sep 2012 22:55:45 -0500
Message-ID: <5059423D.2090401@oracle.com>
Date: Wed, 19 Sep 2012 11:55:41 +0800
From: Simon Xu <xu.simon@oracle.com>
MIME-Version: 1.0
Subject: [LTP] dead loop of closing/removing tmp file when TMPDIR is on nfsv4
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

Hi,

If nfsv4 filesystem is used for TMPDIR, some testcases will have dead 
loop when closing/removing tmp dir or file, and LTP output file will 
quickly reach several gigabytes in less than 10 seconds.

For example:

access02:

<<<test_output>>>
access02    1  TBROK  : chown(/mnt/nfsv4/ltp-7QMNLSoD0z/accsjrpxj, -1, 
0) failed: errno=EPERM(1): Operation not permitted
access02    2  TBROK  :  Remaining cases broken
access02    0  TWARN  :  tst_brk: Invalid Type: 4. Using TBROK
access02    3  TBROK  :  tmpdir_cleanup: no user cleanup function called 
before exiting
access02    4  TBROK  :  unexpected signal 11 received (pid = 6283).
access02    5  TFAIL  :  close(test_file2) failed: errno=EBADF(9): Bad 
file descriptor
access02    6  TFAIL  :  close(temp_file) failed: errno=EBADF(9): Bad 
file descriptor
access02    7  TFAIL  :  close(temp_file) failed: errno=EBADF(9): Bad 
file descriptor
access02    8  TFAIL  :  close(temp_file) failed: errno=EBADF(9): Bad 
file descriptor
access02    9  TFAIL  :  close(temp_file) failed: errno=EBADF(9): Bad 
file descriptor
access02   10  TFAIL  :  close(temp_file) failed: errno=EBADF(9): Bad 
file descriptor
access02   11  TFAIL  :  close(temp_file) failed: errno=EBADF(9): Bad 
file descriptor
access02   12  TFAIL  :  close(temp_file) failed: errno=EBADF(9): Bad 
file descriptor
access02   13  TFAIL  :  close(temp_file) failed: errno=EBADF(9): Bad 
file descriptor
access02   14  TFAIL  :  close(temp_file) failed: errno=EBADF(9): Bad 
file descriptor
access02   15  TFAIL  :  close(temp_file) failed: errno=EBADF(9): Bad 
file descriptor
.....
.....

access01:

access01    0  TWARN  :  tst_rmdir: 
rmobj(/mnt/nfsv4/ltp-pGpmqg8e6y/acc8wRrm5) failed: 
lstat(/mnt/nfsv4/ltp-pGpmqg8e6y/acc8wRrm5) failed; errno=2: No such file 
or directory
access01    0  TWARN  :  tst_brk: Invalid Type: 4. Using TBROK
access01 6621  TBROK  :  tmpdir_cleanup: no user cleanup function called 
before exiting
access01    0  TWARN  :  tst_rmdir: 
rmobj(/mnt/nfsv4/ltp-pGpmqg8e6y/acc8wRrm5) failed: 
lstat(/mnt/nfsv4/ltp-pGpmqg8e6y/acc8wRrm5) failed; errno=2: No such file 
or directory
access01    0  TWARN  :  tst_brk: Invalid Type: 4. Using TBROK
access01 6622  TBROK  :  tmpdir_cleanup: no user cleanup function called 
before exiting
access01    0  TWARN  :  tst_rmdir: 
rmobj(/mnt/nfsv4/ltp-pGpmqg8e6y/acc8wRrm5) failed: 
lstat(/mnt/nfsv4/ltp-pGpmqg8e6y/acc8wRrm5) failed; errno=2: No such file 
or directory
access01    0  TWARN  :  tst_brk: Invalid Type: 4. Using TBROK
access01 6623  TBROK  :  tmpdir_cleanup: no user cleanup function called 
before exiting
......
......

nfs mount option: (rw,vers=4,addr=192.168.1.15,clientaddr=192.168.1.137)
My first guess is that this has something to do with nfs silly 
renaming.  Any idea?

Thanks
Simon

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
