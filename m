Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1T2sE9-0007Mp-E2
	for ltp-list@lists.sourceforge.net; Sat, 18 Aug 2012 23:14:45 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T2sE8-0006bB-Hn
	for ltp-list@lists.sourceforge.net; Sat, 18 Aug 2012 23:14:45 +0000
Message-ID: <50302185.9000503@cn.fujitsu.com>
Date: Sun, 19 Aug 2012 07:13:09 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <8cf0e07f2b2d40fb137ce8e5eba8446dba4d4ddb.1345189299.git.jstancek@redhat.com>
In-Reply-To: <8cf0e07f2b2d40fb137ce8e5eba8446dba4d4ddb.1345189299.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH v2] ioctl: check if tty device nodes are usable
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 08/17/2012 03:43 PM, Jan Stancek wrote:
> ioctl testcases fail on s390x because it doesn't
> support virtual consoles.
> 
> Trying to use such device node fails:
> ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty0
> ioctl01     1  TBROK  :  Couldn't open /dev/tty0: errno=ENXIO(6): No
> such device or address
> 
> This patch tries to get terminal line settings for each tty,
> that would be used in test. If that fails, tty is skipped.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Pushed, thank you Jan.

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
