Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yjwei@cn.fujitsu.com>) id 1MLBO8-0007WT-Va
	for ltp-list@lists.sourceforge.net; Mon, 29 Jun 2009 07:34:52 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLBO7-0008Nk-5k
	for ltp-list@lists.sourceforge.net; Mon, 29 Jun 2009 07:34:52 +0000
Message-ID: <4A486E66.5050102@cn.fujitsu.com>
Date: Mon, 29 Jun 2009 15:33:58 +0800
From: Wei Yongjun <yjwei@cn.fujitsu.com>
MIME-Version: 1.0
References: <4A48667F.9050101@in.ibm.com>
In-Reply-To: <4A48667F.9050101@in.ibm.com>
Subject: Re: [LTP] Issue observed with chmod05, fchmod05 test cases
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
To: Sharyathi Nagesh <sharyath@in.ibm.com>
Cc: ltp-list@lists.sourceforge.net, mbeeraka@in.ibm.com

Sharyathi Nagesh wrote:
> Hi
>   I am observing this anomaly with these 2 test cases chmod05.c and
> fchmod05.c.
> These 2 test cases are written to test the POSIX standard which says:
>
>      "If the calling process is not privileged  (Linux:  does  not 
> have  the
>        CAP_FSETID  capability),  and  the group of the file does not
> match the
>        effective group ID of the process or one  of  its 
> supplementary  group
>        IDs,  the  S_ISGID  bit  will be turned off, but this will not
> cause an
>        error to be returned."
>
>
> So the test case will try to setup a file in which the GID of the
> test/tmp file will be different from the effective group ID of the
> running process. But this criterion is found to be not sufficient
> condition for the clearing the S_ISGID bit of the file
>
> ------------------------------------------------------------
> Ex:
> There are 2 users nobody (uid=99, gid=99) and bin (uid=1, gid=1)
> let as assume temporary file as /tmp/zxcv
>
> Test will Pass if
>     Set UID/GID of /tmp/zxcv to            nobody->uid & nobody->GID
>     Set eUID/eGID of process to           nobody->uid & bin->GID
>
> Test will Fail if
>     Set UID/GID of /tmp/zxcv to            nobody->uid & bin->GID
>     Set eUID/eGID of process to           nobody->uid & nobody->GID
>
> I verified supplementary group IDs for both 'nobody' and 'bin' and
> they are mutually exclusive and none of the other is supplementary
> group ID of the ID being tested
> ------------------------------------------------------------
>
> Should we treat this as Test case issue or kernel bug?

The different of 'nobody' and 'bin' is bin->GID has the CAP_FSETID 
capability, but nobody->GID has not, I think.

Regards.





------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
