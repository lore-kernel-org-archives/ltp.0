Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1O6ygL-00038T-2Y
	for ltp-list@lists.sourceforge.net; Wed, 28 Apr 2010 04:15:29 +0000
Received: from mail-gy0-f174.google.com ([209.85.160.174])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O6ygK-0002e8-6W
	for ltp-list@lists.sourceforge.net; Wed, 28 Apr 2010 04:15:28 +0000
Mime-Version: 1.0 (Apple Message framework v1078)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <1121510575.1119571272426489438.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
Date: Tue, 27 Apr 2010 21:15:17 -0700
Message-Id: <1FBE1CC5-5583-4060-9D1A-FF1F32C1DC27@gmail.com>
References: <1121510575.1119571272426489438.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
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
To: Caspar ZHANG <czhang@redhat.com>
Cc: ltp-list <ltp-list@lists.sf.net>

On Apr 27, 2010, at 8:48 PM, Caspar ZHANG wrote:

> 
> ----- "Garrett Cooper" <yanegomi@gmail.com> wrote:
> 
>> On Apr 27, 2010, at 4:03 AM, Caspar ZHANG wrote:
>> 
>>> 
>>> ----- "Garrett Cooper" <yanegomi@gmail.com> wrote:
>>> 
>>>> On Apr 27, 2010, at 2:23 AM, Caspar ZHANG wrote:
>>>> 
>>>>> <syscalls-utimensat01-run-sudo-without-tty.patch>
>>>> 
>>>> 	What good would this do if the value's deleted and not restored?
>> It's
>>>> better to document this IMO because then it at least brings the
>> issue
>>>> to light as there may be other areas of the tree that require this
>>>> kind of intervention.
>>> 
>>> I didn't realize this matter, thanks for pointing it out. So what if
>> adding 
>>> the `Defaults requiretty' value back after this test finished? 
>> 
>> 	If it's commented out (which is better than it being deleted), sure.
>> Just be sure to do the inverse operation via trap ... EXIT ;), like:
>> 
>> setup
>> trap 'trap "" EXIT; teardown' EXIT
> 
> Thanks Garrett, the modified patch attached.

Almost there :). Some comments:

+	trap 'trap EXIT; teardown' EXIT

Should be:

+	trap 'trap "" EXIT; teardown' EXIT

The double quotes tell the shell to ignore all future signals trapped for the EXIT event (from bash(1)'s trap section, but the same also applies for ash(1), which is the predecessor to dash ):

...

									If arg is absent (and  there  is  a
              single  sigspec)  or  -,  each  specified signal is reset to its
              original disposition (the value it  had  upon  entrance  to  the
              shell).   If arg is the null string the signal specified by each
              sigspec is ignored by the shell and by the commands it  invokes.

...

The `set' sed could be like this:

	pattern="[[:space:]]*Defaults[[:space:]]*requiretty.*"
	sed -E -i "" -e "s/^($pattern)/#\1/" /etc/sudoers

The restore sed could be like this:

	sed -E -i "" -e "s/^#($pattern)/\1/" /etc/sudoers
	# with $pattern being set like before.

Don't forget the ^ anchors and the quoting's important :).

>> 
>> 	You may want to execute the handler before the setup call is invoked
>> to ensure that everything done is properly undone in the event of a
>> failure during setup.
>> 	Also, watch out for cases where a user may have done:
>> 
>> # requiretty
>> 
>> instead of:
>> 
>> requiretty
>> 
>> 	It probably would be wise to preserve all leading and trailing
>> characters for teardown to avoid inadvertently enabling requiretty in
>> sudo.
>> 	The EXIT trap handler isn't 100% foolproof, but it protects against
>> all but SIGKILL or SIGSTOP from being executed as they're NMIs.

Cheers,
-Garrett
------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
