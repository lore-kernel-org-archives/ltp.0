Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OsgoQ-0008Hr-N4
	for ltp-list@lists.sourceforge.net; Mon, 06 Sep 2010 18:53:02 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OsgoP-0000bX-IT
	for ltp-list@lists.sourceforge.net; Mon, 06 Sep 2010 18:53:02 +0000
Received: by bwz12 with SMTP id 12so4602813bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 06 Sep 2010 11:52:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1283789802.4947.19.camel@subratamodak.linux.ibm.com>
References: <4C73452A.3020006@cn.fujitsu.com>
	<1282647771.4833.10.camel@subratamodak.linux.ibm.com>
	<4C7470FC.4090800@cn.fujitsu.com>
	<AANLkTi=+8rsbAtHg=N+RCBqDH2W6xD+NVWdXScyJH2Mc@mail.gmail.com>
	<1283789802.4947.19.camel@subratamodak.linux.ibm.com>
Date: Mon, 6 Sep 2010 11:52:55 -0700
Message-ID: <AANLkTi=8VCo72Ztj_SQ3FRxEAQVYMcFL+VAOXCMB5_xK@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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

On Mon, Sep 6, 2010 at 9:16 AM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
> Garret,
>
> Did you get a chance to review these tests further?

(see below for bottom post)

> On Tue, 2010-08-24 at 19:41 -0700, Garrett Cooper wrote:
>> On Tue, Aug 24, 2010 at 6:25 PM, Li Zefan <lizf@cn.fujitsu.com> wrote:
>> > Subrata Modak wrote:
>> >> Thanks. I need to test this on a suitable kernel. But doubtful if i can
>> >> add in the default run.
>> >>
>> >
>> > Why? Because it costs 90 secs? This is configurable, and some other
>> > test suites like cpuctl cost more time.
>> >
>> > If a test suite is not run by default, I guess people won't know its
>> > existence, probably.
>>
>> I think that more of the concern stems from the fact that it's a
>> performance test, and a lot of people complain if and when their test
>> machines slow down to a halt (take hackbench, proc01, for example).
>>
>> There are issues with the code, but it's dealing with the fact that
>> it's not really written in a portable way. Give me a bit of time and
>> I'll comment on what needs to be changed.

Li needs to fix some of my concerns which are valid (shell portability
by removing bashisms). Once that's done, then we can move on to the
next stage of review and potentially commit.

Thanks,
-Garrett

PS I still think that tst_kvercmp should be used because it's a lot
more versatile than what's added here, and will result in less
bitrotted code in the future.

------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
