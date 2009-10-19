Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MzhLT-000704-77
	for ltp-list@lists.sourceforge.net; Mon, 19 Oct 2009 01:47:35 +0000
Received: from mail-px0-f181.google.com ([209.85.216.181])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MzhLM-0001J7-WB
	for ltp-list@lists.sourceforge.net; Mon, 19 Oct 2009 01:47:35 +0000
Received: by pxi11 with SMTP id 11so439142pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Sun, 18 Oct 2009 18:47:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1255890114.5359.16.camel@subratamodak.linux.ibm.com>
References: <8368651DACC1964480F951191B94A0780153D7EE@svexch01.mvista.com>
	<1255890114.5359.16.camel@subratamodak.linux.ibm.com>
Date: Sun, 18 Oct 2009 18:39:22 -0700
Message-ID: <364299f40910181839w5c5dc73agfa147469881d4cc3@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH][runtest/fs] modify fs scenario to use working
	directory specified by runltp
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
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>

On Sun, Oct 18, 2009 at 11:21 AM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
> On Fri, 2009-10-16 at 17:03 -0700, Henry Yei wrote:
>> This patch modifies the fs scenario to remove hard coded paths with /tmp as well as make sure that tests that take directory arguments use the temporary directory specified by runltp.
>>
>> I've chosen to pass in the temporary directory rather than change the tests themselves for certain tests take a path as an argument.
>>
>> Signed-off by: Henry Yei <hyei@mvista.com>
>
> Thanks.

    Dumb question (and this is part of the reason why I didn't reply
earlier or check this into cvs) -- what happens if TMPDIR is unset or
is an empty value? Another function and/or set of bourne shell calls
should be added to tst_setup() in cmdlib.sh so it checks for this
directory and creates it as necessary, similar to what I did in
linktest.sh.
Thanks,
-Garrett

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
