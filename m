Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1O7wdw-0002MM-Or
	for ltp-list@lists.sourceforge.net; Fri, 30 Apr 2010 20:17:00 +0000
Received: from mail-iw0-f192.google.com ([209.85.223.192])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O7wdv-0003t1-Br
	for ltp-list@lists.sourceforge.net; Fri, 30 Apr 2010 20:17:00 +0000
MIME-Version: 1.0
In-Reply-To: <m2z42aa607e1004301227tfec6a200kda741f32b6feeb11@mail.gmail.com>
References: <103530624.1121001272433642504.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
	<8B8139E0-F07A-433D-B38D-30DAB81E3FF5@gmail.com>
	<s2r700385ec1004272327n8b26491bt3609f8877b71a385@mail.gmail.com>
	<m2z42aa607e1004301227tfec6a200kda741f32b6feeb11@mail.gmail.com>
Date: Fri, 30 Apr 2010 13:15:48 -0700
Message-ID: <x2l364299f41004301315x20fa3ed6u488dc923334fd5d6@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] UTIMENSAT test fails hugely
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
To: Henry Yei <hyei@mvista.com>
Cc: ltp-list <ltp-list@lists.sf.net>

On Fri, Apr 30, 2010 at 12:27 PM, Henry Yei <hyei@mvista.com> wrote:
> Speaking of the utimesat test and prerequisites, our test systems
> don't have a sudoers file by default, so we have an internal patch to
> utimesat to create a default one if non exist and remove it after the
> test is done. Would that be of interest to LTP?
>
> On Tue, Apr 27, 2010 at 11:27 PM, Caspar Zhang <casparant@gmail.com> wrote:
>> On Wed, Apr 28, 2010 at 2:04 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
>>> The first item is different from the other two. The first one ignores the
>>> signal (SIG_IGN), whereas the latter two cases reset the handler to the
>>> default one (SIG_DFL). I prefer the former format, because otherwise the
>>> signal handlers become reentrable on accident.
>>
>> I see. Thank you.
>>
>> The final patch ;-)

If it:

1. Works in all cases, i.e. doesn't use version specific constructs
for sudo (which I haven't seen thus far, but just to be safe).
2. Is properly reverted when the test is done (which includes the
following scenarios):
    a. File already exists. Backup the old file, revert it when the
test is completed (regardless of whether or not the test passed or the
test failed properly [*]).
    b. File doesn't exist. Nuke the file after the test is done.

    ... sure.
Thanks,
-Garrett

[*] SIGKILL or SIGSTOP can't be avoided, so technically it's a best effort.

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
