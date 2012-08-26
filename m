Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1T5arz-0005PB-Dp
	for ltp-list@lists.sourceforge.net; Sun, 26 Aug 2012 11:19:07 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T5arx-0007Ub-VP
	for ltp-list@lists.sourceforge.net; Sun, 26 Aug 2012 11:19:07 +0000
Date: Sun, 26 Aug 2012 07:18:56 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1030988505.10747274.1345979936065.JavaMail.root@redhat.com>
In-Reply-To: <043301cd82b6$a9809f10$fc81dd30$@pv@huawei.com>
MIME-Version: 1.0
Subject: Re: [LTP] sendto syscall fails because of the error value
	missmatch	from 3.6-rc1 kernel onwards
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
To: shyju pv <shyju.pv@huawei.com>
Cc: Sanil kumar <sanil.kumar@huawei.com>, ltp-list@lists.sourceforge.net, nagamani mantha <nagamani.mantha@huawei.com>

Hi,

this looks like kernel commit, which caused it:

commit cf60af03ca4e71134206809ea892e49b92a88896
Author: Yuchung Cheng <ycheng@google.com>
Date:   Thu Jul 19 06:43:09 2012 +0000
    net-tcp: Fast Open client - sendmsg(MSG_FASTOPEN)

And it depends also on value of tcp_fastopen:
echo 1 > /proc/sys/net/ipv4/tcp_fastopen
# ./sendto01
...
sendto01    1  TFAIL  :  invalid flags set ; returned -1 (expected 0), errno 106 (expected 32)

# echo 0 > /proc/sys/net/ipv4/tcp_fastopen
# ./sendto01
...
sendto01    1  TFAIL  :  invalid flags set ; returned -1 (expected 0), errno 95 (expected 32)

Regards,
Jan

----- Original Message -----
> From: "Shyju PV" <shyju.pv@huawei.com>
> To: ltp-list@lists.sourceforge.net
> Cc: "Sanil kumar" <sanil.kumar@huawei.com>, "nagamani mantha" <nagamani.mantha@huawei.com>
> Sent: Saturday, 25 August, 2012 1:42:09 PM
> Subject: [LTP] sendto syscall fails because of the error value missmatch	from 3.6-rc1 kernel onwards
> 
> LTP_Version: 2012-06-14
> LTP Test case: sendto01
> Description : Verifies the sendto syscall errorno for various failure
> cases
> Failure Analysis : when the invalid flag is set, The error no
> EOPNOTSUPP
> (95) and syscall returns 0 .instead LTP expects EPIPE (32) and the
> syscall
> return value as -1.
> Fix : Modify  the LTP code with respect the the system return values
> of the
> latest kernel(3.6-rc1)
> Test case passed in Kernel 3.5
> Failed from  3.6-rc1,rc2and rc3
> 
> Test output :: <<<test_output>>>
> incrementing stop
> sendto01    1  TPASS  :  bad file descriptor successful
> sendto01    2  TPASS  :  invalid socket successful
> sendto01    3  TPASS  :  invalid send buffer successful
> sendto01    4  TPASS  :  connected TCP successful
> sendto01    5  TPASS  :  not connected TCP successful
> sendto01    6  TPASS  :  invalid to buffer length successful
> sendto01    7  TPASS  :  invalid to buffer successful
> sendto01    8  TPASS  :  UDP message too big successful
> sendto01    9  TPASS  :  local endpoint shutdown successful
> sendto01   10  TFAIL  :  invalid flags set ; returned -1 (expected
> 0), errno
> 95
> (expected 32)
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=1 corefile=no
> cutime=0 cstime=0
> <<<test_end>>>
> INFO: ltp-pan reported some tests FAIL
> 
> Shyju
> 
> 
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond.
> Discussions
> will include endpoint security, mobile security and the latest in
> malware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

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
