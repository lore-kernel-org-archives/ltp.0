Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <lizf@cn.fujitsu.com>) id 1Oo4fI-0007eu-3d
	for ltp-list@lists.sourceforge.net; Wed, 25 Aug 2010 01:20:32 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Oo4fC-0001us-S2
	for ltp-list@lists.sourceforge.net; Wed, 25 Aug 2010 01:20:32 +0000
Message-ID: <4C7470FC.4090800@cn.fujitsu.com>
Date: Wed, 25 Aug 2010 09:25:16 +0800
From: Li Zefan <lizf@cn.fujitsu.com>
MIME-Version: 1.0
References: <4C73452A.3020006@cn.fujitsu.com>
	<1282647771.4833.10.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1282647771.4833.10.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [PATCH] Add ftrace-stress-test to LTP
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net, Frederic Weisbecker <fweisbec@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Eugene Teo <eugene@redhat.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>

Subrata Modak wrote:
> Thanks. I need to test this on a suitable kernel. But doubtful if i can
> add in the default run.
> 

Why? Because it costs 90 secs? This is configurable, and some other
test suites like cpuctl cost more time.

If a test suite is not run by default, I guess people won't know its
existence, probably.

> Regards--
> Subrata
> 
> On Tue, 2010-08-24 at 12:06 +0800, Li Zefan wrote: 
>> We test ftrace by forking processes to simultaneously and
>> constantly read/write different tracing files in debugfs
>> and procfs.
>>
>> The test will be skipped if the kernel is older than 2.6.34,
>> mainly because it can crash old kernels.
>>
>> The test will run by default and will run for 90 seconds.
>>
>> To run this test only:
>>
>> 	# ./runltp -f tracing
>>
>> Signed-off-by: Li Zefan <lizf@cn.fujitsu.com>

------------------------------------------------------------------------------
Sell apps to millions through the Intel(R) Atom(Tm) Developer Program
Be part of this innovative community and reach millions of netbook users 
worldwide. Take advantage of special opportunities to increase revenue and 
speed time-to-market. Join now, and jumpstart your future.
http://p.sf.net/sfu/intel-atom-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
