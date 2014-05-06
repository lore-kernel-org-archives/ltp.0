Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Whd6e-0003ji-Rs
	for ltp-list@lists.sourceforge.net; Tue, 06 May 2014 11:00:16 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Whd6e-0004e5-0M
	for ltp-list@lists.sourceforge.net; Tue, 06 May 2014 11:00:16 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s46B09nx032012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 6 May 2014 11:00:10 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	s46B08O6011933
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 6 May 2014 11:00:09 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s46B08xO005489
	for <ltp-list@lists.sourceforge.net>; Tue, 6 May 2014 11:00:08 GMT
Message-ID: <5368C0B6.4000307@oracle.com>
Date: Tue, 06 May 2014 15:00:06 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <1398855439-11869-1-git-send-email-shuang.qiu@oracle.com>
In-Reply-To: <1398855439-11869-1-git-send-email-shuang.qiu@oracle.com>
Subject: Re: [LTP] [PATCH 2/2-updated] syscalls/fstatfs02: Using temporary
 file description to test the syscall
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



On 04/30/2014 02:57 PM, shuang.qiu@oracle.com wrote:
> From: Shuang Qiu <shuang.qiu@oracle.com>
>
> It does not make sense to use stdout as the file description to test the
> system call fstatfs().We may get unexpected result(i.e.
> errno=38:Function not implemented) if redirect stdout when running ltp.
> Using ltp temporary file instead.
>
> Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>

The problem is that with the 2.6.39 series of kernels ENOSYS is returned 
where EFAULT is expected.

The reproducer:
#include <error.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/vfs.h>

int main(void)
{
   int fds[2];

   if (pipe(fds) < 0) {
     perror("pipe() failed");
     return 1;
   }

   if (fstatfs(fds[1], (void *)-1) < 0) {
     perror("fstatfs() failed");
     return 1;
   }

   return 0;
}

With 2.6.18, 2.6.32, 3.8.13 this reproducer returns EFAULT,
but with 2.6.39 - ENOSYS.

If we change '(void *)-1' to a vaild pointer, fstatfs() + 2.6.39 will 
succeed.

So it's a bug in 2.6.39, which is fixed in modern kernels.

 From one side, the above patch makes fstatfs02 pass by hiding an old 
(and already fixed) kernel bug.

But from the other side, it also enlarges the test scope by allowing to 
test different file systems.

So, personally, I would accept it.

Are there any thoughts about it?

Thanks.

------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
