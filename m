Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1RhswK-0006Cp-9O
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 01:13:20 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RhswI-0002Vt-KS
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 01:13:20 +0000
Message-ID: <4F024C98.8050203@cn.fujitsu.com>
Date: Tue, 03 Jan 2012 08:32:24 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1325235186-20625-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<201201021520.58152.vapier@gentoo.org>
In-Reply-To: <201201021520.58152.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] gitignore: ignore the files compiled
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net, Wanlong Gao <wanlong.gao@gmail.com>

On 01/03/2012 04:20 AM, Mike Frysinger wrote:

> On Friday 30 December 2011 03:53:06 Wanlong Gao wrote:
>> +/testcases/kernel/syscalls/fork/fork13
>> +/testcases/kernel/syscalls/getrusage/getrusage03
>> +/testcases/kernel/syscalls/getrusage/getrusage03_child
>> +/testcases/kernel/syscalls/mlock/mlock04
>> +/testcases/kernel/syscalls/pwrite/pwrite01_64
>> +/testcases/kernel/syscalls/pwrite/pwrite02_64
>> +/testcases/kernel/syscalls/pwrite/pwrite03_64
>> +/testcases/kernel/syscalls/pwrite/pwrite04_64
>> +/testcases/kernel/syscalls/syslog/syslog11
>> +/testcases/kernel/syscalls/syslog/syslog12
>> +/testcases/kernel/syscalls/syslog/syslogtst
> 
> i merged these into the testcases/kernel/syscalls/.gitignore file.  the other 
> testcases/kernel/ ignores should get split up accordingly.
> -mike


It should be better, thanks
-Wanlong Gao

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
