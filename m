Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1TBy6r-0004l4-Bx
	for ltp-list@lists.sourceforge.net; Thu, 13 Sep 2012 01:20:49 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TBy6p-0000tq-Q2
	for ltp-list@lists.sourceforge.net; Thu, 13 Sep 2012 01:20:49 +0000
Message-ID: <505134C4.3060602@cn.fujitsu.com>
Date: Thu, 13 Sep 2012 09:20:04 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1346925057-5511-1-git-send-email-kai.kang@windriver.com>
	<1346925057-5511-2-git-send-email-kai.kang@windriver.com>
In-Reply-To: <1346925057-5511-2-git-send-email-kai.kang@windriver.com>
Subject: Re: [LTP] [PATCH] mq_open/16-1: use tmp file to share info
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Kang Kai <kai.kang@windriver.com>
Cc: ltp-list@lists.sourceforge.net

On 09/06/2012 05:50 PM, Kang Kai wrote:
> In this test case, it uses a variable to share data between child and
> parent processes. But after fork there is a copy of the variable in
> child process and modify it will not affect the variable in the parent
> process. Then when the child process call mq_open() before parent
> process, the case will fail.
> 
> Use tmp file to replace the variable. Any modification in child process
> can be seen in parent process.
> 
> Signed-off-by: Kang Kai <kai.kang@windriver.com>

Pushed, thank you .

Wanlong Gao


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
