Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MNzEl-0002yD-Nx
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 01:12:47 +0000
Received: from fmmailgate01.web.de ([217.72.192.221])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MNzEh-0008PJ-CT
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 01:12:47 +0000
Date: Tue, 07 Jul 2009 02:16:00 +0200
From: =?iso-8859-2?B?Smn47SBQYWxl6GVr?= <jpalecek@web.de>
MIME-Version: 1.0
References: <4a413e9b.160bca0a.2226.fffff184SMTPIN_ADDED@mx.google.com>
	<364299f40907061045s567f00dbq7a198ef37fa438dc@mail.gmail.com>
	<200907070047.40979.jpalecek@web.de>
	<364299f40907061633w6583f3d3l8fd3ca90d217b38a@mail.gmail.com>
Message-ID: <op.uwn8cy0au2flwt@debian>
In-Reply-To: <364299f40907061633w6583f3d3l8fd3ca90d217b38a@mail.gmail.com>
Subject: Re: [LTP] [PATCH] Fix some bashisms
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, 07 Jul 2009 01:33:29 +0200, Garrett Cooper <yanegomi@gmail.com>  =

wrote:

> On Mon, Jul 6, 2009 at 3:47 PM, Jiri Palecek<jpalecek@web.de> wrote:
>> On Monday 06 July 2009 19:45:08 Garrett Cooper wrote:
>>> Jiri,
>>> =A0 =A0 This patch looks ok for the most part, but here are some commen=
ts:
>>>
>>> 1. if [[ -z "$vnet0" -z "$vnet1" ]] =3D> if [ -z "$vnet0" ] || [ -z  =

>>> "$vnet1" ]
>>>
>>> It's better read as the following, IMO:
>>>
>>> [ -z "$vnet0" -o -z "$vnet1" ]
>>
>> I think this is another "I like this more than that, because this is  =

>> cool and that sucks" debate. If other think test's "-o" should be used  =

>> in this case, I would make the change. After all, this can be done by  =

>> hand directly on the patch...
>
> Why call [(1) twice?

Does it (measurably) matter? Do the shell scripts contribute a big part to  =

the time the tests take?

>>> 2. All numeric test(1) comparisons could and should be switched from:
>>>
>>> command
>>> if [ $? =3D 0 ]; then
>>>
>>> to:
>>>
>>> if command; then
>>>
>>> for brevity.
>>
>> Why should them be changed? This is only a cosmetic change, which would  =

>> make the patch unnecessarily larger (when it's already a little too  =

>> large IMHO). If it could be in the former form till now, I think it can  =

>> stay there a few months/years.
>>
>> IMHO this usage is still much better than
>>
>> =A0command; RC=3D$?
>> =A0if [ $RC =3D 0 ] ...
>> =A0... RC is not read later ...
>>
>> or (incorrect)
>>
>> =A0command || RC=3D$?
>> =A0if [ $RC =3D 0 ] ...
>
> Yes, I agree with what you said about the above usage, but if you're
> not using $? for other than just the [ $? -ne 0 ], then I wouldn't
> even bother doing that, because if command; then saves a fork-exec,
> and an additional line in the source. As long as it's readable and
> doesn't expand multiple lines with a trailing \, you're fine.

Are you talking only about efficiency and bash scripts? :-)

Anyway, if you want to save the fork-exec, you can just use a shell with a  =

test builtin (ksh, bash, dash ... and I believe many others do).

If you are concerned about readability, I suggest considering another  =

alternative:

  command || {
    do_something_on_error
  }

  command && {
    do_something_when_ok
  }

Of coures, usable only when there's no "else" branch.

Still, I think the original form is correct and quite straightforward. I  =

would probably not use the extra test myself, but I don't feel like it  =

needs changing. Just looking at the patch, I see places where the check is  =

done really suspiciously:


  	tst_resm TINFO "Test #1: changing mtu size of eth0:1 device."

-	ip link set eth0:1 mtu 300 &>$LTPTMP/tst_ip.err
+	ip link set eth0:1 mtu 300 >$LTPTMP/tst_ip.err 2>&1
  	if [ $RC -ne 0 ]
  	then
  		tst_res TFAIL $LTPTMP/tst_ip.err \

I think this needs much more attention than "calling [ twice" or "extra  =

line in the script".

>>> 3. About &>
>>>
>>> =A0 =A0Redirecting Standard Output and Standard Error
>>> =A0 =A0 =A0 =A0Bash allows both the standard output (file descriptor 1)=
 and
>>> the standard error output (file descriptor 2) to be redirected to the
>>> file whose name is the expansion of word with this construct.
>>>
>>> =A0 =A0 =A0 =A0There are two formats for redirecting standard output an=
d  =

>>> standard error:
>>>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 &>word
>>> =A0 =A0 =A0 =A0and
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 >&word
>>>
>>> The output redirection above captures all output (and most of the time
>>> you're capturing stdout, but losing stderr to the operating console,
>>> which can be undesirable). >& is more portable IIRC (it works with
>>> many ash variants, like FreeBSD's sh -- for sure -- and Solaris's sh
>>> -- IIRC), which makes it more ideal than &>.
>>
>> Still, it isn't POSIX, it doesn't work with dash and actually causes  =

>> pain. See:
>>
>> =A0cmd &> fn
>>
>> POSIX: run cmd in background, write empty file fn
>> BASH: run cmd (foreground), send its (normal & error) output to file fn
>>
>> =A0cmd >& fn
>>
>> POSIX: syntax error
>> BASH: same as above
>>
>> But I don't see the point you are making here - do you have a system,  =

>> where the POSIX way
>>
>> =A0cmd > fn 2>&1
>>
>> doesn't work? Or did you see something else in the patch?
>
> This changes the behavior of the patch though. That's the point ;)...

How does it change the semantics? It redirects standard output to fn, and  =

standard error to standard output (which is redirected to fn). Is there  =

anything else it should do?

Regards
     Jiri Palecek

---------------------------------------------------------------------------=
---
Enter the BlackBerry Developer Challenge  =

This is your chance to win up to $100,000 in prizes! For a limited time, =

vendors submitting new applications to BlackBerry App World(TM) will have =

the opportunity to enter the BlackBerry Developer Challenge. See full prize =

details at: http://p.sf.net/sfu/blackberry
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
