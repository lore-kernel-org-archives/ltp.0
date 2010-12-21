Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <biannm@cn.fujitsu.com>) id 1PUwHu-0002Nd-57
	for ltp-list@lists.sourceforge.net; Tue, 21 Dec 2010 07:05:34 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PUwHs-0007S9-OZ
	for ltp-list@lists.sourceforge.net; Tue, 21 Dec 2010 07:05:34 +0000
Message-ID: <4D105104.1000506@cn.fujitsu.com>
Date: Tue, 21 Dec 2010 15:02:28 +0800
From: Bian Naimeng <biannm@cn.fujitsu.com>
MIME-Version: 1.0
References: <924010297.25165.1292913561101.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <924010297.25165.1292913561101.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH]Fix building error.
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
To: CAI Qian <caiqian@redhat.com>
Cc: ltp-list@lists.sourceforge.net

CAI Qian wrote:
> Hi,
> 
>> What do you think about it? Any comments are welcome. ^_^
> This test is not designed for older kernels like RHEL5.5. Even if fixed the compilation error, the test will not be working correctly due to old KSM interfaces and implementation there. 
> 

  Thanks for your reply.

  Could you tell me which kernels are this test fit to? 

  If there is old KSM interface, and this test can not work correctly on it,
  i think we should fix the test, it should not do anything but reports 
  "This test is unsupported!"

-- 
Regards
Bian Naimeng

> CAI Qian
> 
> 


------------------------------------------------------------------------------
Lotusphere 2011
Register now for Lotusphere 2011 and learn how
to connect the dots, take your collaborative environment
to the next level, and enter the era of Social Business.
http://p.sf.net/sfu/lotusphere-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
