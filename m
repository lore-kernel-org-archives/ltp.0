Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <huruomu@gmail.com>) id 1PQFt5-0006OW-7O
	for ltp-list@lists.sourceforge.net; Wed, 08 Dec 2010 09:00:35 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PQFt4-00061P-8J
	for ltp-list@lists.sourceforge.net; Wed, 08 Dec 2010 09:00:35 +0000
Received: by wwi18 with SMTP id 18so845852wwi.10
	for <ltp-list@lists.sourceforge.net>;
	Wed, 08 Dec 2010 01:00:28 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 8 Dec 2010 17:00:28 +0800
Message-ID: <AANLkTim7MX7BdppQMN5mjpGVuGgEqdMULiCd0t-d-zPj@mail.gmail.com>
From: Romu <huruomu@gmail.com>
Subject: [LTP] Problem about nfs01 and open_files
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

Hi all,

I installed ltp 20100831 on RHEL5u6 beta using the following commands:

./configure
make all
make install

nfs01 always fails during ltp stress test:

=================================
<<<test_start>>>
tag=nfs01 stime=1291796995
cmdline="export VERSION=2 SOCKET_TYPE=udp; export
TCbin=$LTPROOT/testcases/network/nfs/nfs01; nfs01"
contacts=""
analysis=exit
<<<test_output>>>

Test Options:
 VERSION: 2
 RHOST: ca-ostest212.us.oracle.com
 NFILES: 1000
 SOCKET_TYPE: udp
 NFS_TYPE: nfs
 TESTDIR: /tmp/nfs0114652.testdir
Setting up remote machine: ca-ostest212.us.oracle.com
connect to address 139.185.48.212 port 544: Connection refused
connect to address 139.185.48.212 port 544: Connection refused
trying normal rsh (/usr/bin/rsh)
connect to address 139.185.48.212 port 544: Connection refused
connect to address 139.185.48.212 port 544: Connection refused
trying normal rsh (/usr/bin/rsh)
Mounting NFS filesystem
ca-ostest212.us.oracle.com:/tmp/nfs0114652.testdir on
/opt/ltp/testcases/network/nfs/nfs01/nfs0114652 with options '-o
proto=udp,vers=2 '
Removing old and create new directories
cp: cannot stat `/opt/ltp/testcases/network/nfs/nfs01/open_files': No
such file or directory
Cleaning up testcase
=====================================

I checked /opt/ltp/testcases/network/nfs/nfs01 directory, there is no
"open_files".
I manually copied /opt/ltp/testcases/bin/open_files to
/opt/ltp/testcases/network/nfs/nfs01 directory, and ran nfs01 tests
again, all passed.

Why "open_files" is not copied into
/opt/ltp/testcases/network/nfs/nfs01 directory during "make install" ?


Regards,
Romu

------------------------------------------------------------------------------
What happens now with your Lotus Notes apps - do you make another costly 
upgrade, or settle for being marooned without product support? Time to move
off Lotus Notes and onto the cloud with Force.com, apps are easier to build,
use, and manage than apps on traditional platforms. Sign up for the Lotus 
Notes Migration Kit to learn more. http://p.sf.net/sfu/salesforce-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
