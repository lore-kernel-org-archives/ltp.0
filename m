Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1O82e9-0006OU-Le
	for ltp-list@lists.sourceforge.net; Sat, 01 May 2010 02:41:37 +0000
Received: from mail-iw0-f192.google.com ([209.85.223.192])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O82e7-0003B3-Dp
	for ltp-list@lists.sourceforge.net; Sat, 01 May 2010 02:41:37 +0000
MIME-Version: 1.0
In-Reply-To: <q2w42aa607e1004301556s76e89e8nf68d4bee860da4bd@mail.gmail.com>
References: <103530624.1121001272433642504.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
	<8B8139E0-F07A-433D-B38D-30DAB81E3FF5@gmail.com>
	<s2r700385ec1004272327n8b26491bt3609f8877b71a385@mail.gmail.com>
	<m2z42aa607e1004301227tfec6a200kda741f32b6feeb11@mail.gmail.com>
	<x2l364299f41004301315x20fa3ed6u488dc923334fd5d6@mail.gmail.com>
	<q2w42aa607e1004301556s76e89e8nf68d4bee860da4bd@mail.gmail.com>
Date: Fri, 30 Apr 2010 19:41:29 -0700
Message-ID: <u2u364299f41004301941pe0e04112u34e7da16e7d1f3df@mail.gmail.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Henry Yei <hyei@mvista.com>
Cc: ltp-list <ltp-list@lists.sf.net>

On Fri, Apr 30, 2010 at 3:56 PM, Henry Yei <hyei@mvista.com> wrote:
> If a sudo file exists, the patch doesn't touch it. If it does not, a
> sudoers file will be created and then it will remove it afterwards. I
> wouldn't feel confortable having a script modify a sudoers file if it
> already exists. The sudoers content that it does put in place just
> enables the root user to use sudo, which would not give it any more
> access than it already has. This text is available in every sudoers
> file I've looked at.
>
>
>
> While I was testing the patch with the ltp-dev branch, I noticed that
> the -n option was put in front of every sudo call in commit
> 2aa40f7e10518977881b933cc93b8f50847cf3cf in order to suppress the
> interactive password check.
>
> However, neither sudo 1.6.8p12 from MontaVista Linux 6 or 1.6.9p17
> from Ubuntu 9.04 supports the =A0-n option. The patch also removes the
> -n option from sudo calls. This option was added in 3/2008.

Ugh. The sudo in gentoo did this though and that's the reason why I
added it in some scripts -- otherwise the pieces of junk halt waiting
for user input and I had manually kill the scripts >:(... I guess a
test will need to be added to ensure that sudo _does_ have the -n
option beforehand, if it does, add the -n option. Otherwise all people
running older versions are kind of SoL.

sudo is still a non-standard tool and a pain in the butt to deal with
in scripts as it changes from time to time.

FWIW your patch only deals with the case when the script `exits
cleanly' as there aren't any traps installed for cleanup_test.

> On Fri, Apr 30, 2010 at 1:15 PM, Garrett Cooper <yanegomi@gmail.com> wrot=
e:
>> On Fri, Apr 30, 2010 at 12:27 PM, Henry Yei <hyei@mvista.com> wrote:
>>> Speaking of the utimesat test and prerequisites, our test systems
>>> don't have a sudoers file by default, so we have an internal patch to
>>> utimesat to create a default one if non exist and remove it after the
>>> test is done. Would that be of interest to LTP?
>>>
>>> On Tue, Apr 27, 2010 at 11:27 PM, Caspar Zhang <casparant@gmail.com> wr=
ote:
>>>> On Wed, Apr 28, 2010 at 2:04 PM, Garrett Cooper <yanegomi@gmail.com> w=
rote:
>>>>> The first item is different from the other two. The first one ignores=
 the
>>>>> signal (SIG_IGN), whereas the latter two cases reset the handler to t=
he
>>>>> default one (SIG_DFL). I prefer the former format, because otherwise =
the
>>>>> signal handlers become reentrable on accident.
>>>>
>>>> I see. Thank you.
>>>>
>>>> The final patch ;-)
>>
>> If it:
>>
>> 1. Works in all cases, i.e. doesn't use version specific constructs
>> for sudo (which I haven't seen thus far, but just to be safe).
>> 2. Is properly reverted when the test is done (which includes the
>> following scenarios):
>> =A0 =A0a. File already exists. Backup the old file, revert it when the
>> test is completed (regardless of whether or not the test passed or the
>> test failed properly [*]).
>> =A0 =A0b. File doesn't exist. Nuke the file after the test is done.
>>
>> =A0 =A0... sure.
>> Thanks,
>> -Garrett
>>
>> [*] SIGKILL or SIGSTOP can't be avoided, so technically it's a best effo=
rt.

Thanks,
-Garrett

---------------------------------------------------------------------------=
---
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
