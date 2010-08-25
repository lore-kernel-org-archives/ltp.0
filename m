Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <lizf@cn.fujitsu.com>) id 1Oo68j-00031K-2u
	for ltp-list@lists.sourceforge.net; Wed, 25 Aug 2010 02:55:01 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Oo68h-0006D5-Hb
	for ltp-list@lists.sourceforge.net; Wed, 25 Aug 2010 02:55:01 +0000
Message-ID: <4C748721.3020909@cn.fujitsu.com>
Date: Wed, 25 Aug 2010 10:59:45 +0800
From: Li Zefan <lizf@cn.fujitsu.com>
MIME-Version: 1.0
References: <4C73452A.3020006@cn.fujitsu.com>	<1282647771.4833.10.camel@subratamodak.linux.ibm.com>	<4C7470FC.4090800@cn.fujitsu.com>
	<AANLkTi=+8rsbAtHg=N+RCBqDH2W6xD+NVWdXScyJH2Mc@mail.gmail.com>
In-Reply-To: <AANLkTi=+8rsbAtHg=N+RCBqDH2W6xD+NVWdXScyJH2Mc@mail.gmail.com>
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Frederic Weisbecker <fweisbec@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Eugene Teo <eugene@redhat.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>

Garrett Cooper wrote:
> On Tue, Aug 24, 2010 at 6:25 PM, Li Zefan <lizf@cn.fujitsu.com> wrote:
>> Subrata Modak wrote:
>>> Thanks. I need to test this on a suitable kernel. But doubtful if i can
>>> add in the default run.
>>>
>> Why? Because it costs 90 secs? This is configurable, and some other
>> test suites like cpuctl cost more time.
>>
>> If a test suite is not run by default, I guess people won't know its
>> existence, probably.
> 
> I think that more of the concern stems from the fact that it's a
> performance test, and a lot of people complain if and when their test
> machines slow down to a halt (take hackbench, proc01, for example).
> 

It's not a performance test, but a stress test, which aims at revealing
racy corners in ftrace. Though it will slow down the machine, it won't
halt the machine, unless we hit a serious kernel bug.

> There are issues with the code, but it's dealing with the fact that
> it's not really written in a portable way. Give me a bit of time and
> I'll comment on what needs to be changed.
> 

Thanks for reviewing the code. I'm not good at writing protable bash
scripts..

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
