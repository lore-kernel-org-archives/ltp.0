Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MNz4S-0002ZJ-Vc
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 01:02:08 +0000
Received: from an-out-0708.google.com ([209.85.132.248])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MNz4O-0008Ul-Ap
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 01:02:08 +0000
Received: by an-out-0708.google.com with SMTP id c38so1801533ana.37
	for <ltp-list@lists.sourceforge.net>;
	Mon, 06 Jul 2009 18:02:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <op.uwn8cy0au2flwt@debian>
References: <4a413e9b.160bca0a.2226.fffff184SMTPIN_ADDED@mx.google.com>
	<364299f40907061045s567f00dbq7a198ef37fa438dc@mail.gmail.com>
	<200907070047.40979.jpalecek@web.de>
	<364299f40907061633w6583f3d3l8fd3ca90d217b38a@mail.gmail.com>
	<op.uwn8cy0au2flwt@debian>
Date: Mon, 6 Jul 2009 17:31:25 -0700
Message-ID: <364299f40907061731j70ec779asf40630eb9b2e83b4@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
To: =?ISO-8859-2?B?Smn47SBQYWxl6GVr?= <jpalecek@web.de>
Cc: ltp-list@lists.sourceforge.net

2009/7/6 Ji=F8=ED Pale=E8ek <jpalecek@web.de>:
> On Tue, 07 Jul 2009 01:33:29 +0200, Garrett Cooper <yanegomi@gmail.com>
> wrote:
>
>> On Mon, Jul 6, 2009 at 3:47 PM, Jiri Palecek<jpalecek@web.de> wrote:
>>>
>>> On Monday 06 July 2009 19:45:08 Garrett Cooper wrote:
>>>>
>>>> Jiri,
>>>> =A0 =A0 This patch looks ok for the most part, but here are some comme=
nts:
>>>>
>>>> 1. if [[ -z "$vnet0" -z "$vnet1" ]] =3D> if [ -z "$vnet0" ] || [ -z
>>>> "$vnet1" ]
>>>>
>>>> It's better read as the following, IMO:
>>>>
>>>> [ -z "$vnet0" -o -z "$vnet1" ]
>>>
>>> I think this is another "I like this more than that, because this is co=
ol
>>> and that sucks" debate. If other think test's "-o" should be used in th=
is
>>> case, I would make the change. After all, this can be done by hand dire=
ctly
>>> on the patch...
>>
>> Why call [(1) twice?
>
> Does it (measurably) matter? Do the shell scripts contribute a big part to
> the time the tests take?
>
>>>> 2. All numeric test(1) comparisons could and should be switched from:
>>>>
>>>> command
>>>> if [ $? =3D 0 ]; then
>>>>
>>>> to:
>>>>
>>>> if command; then
>>>>
>>>> for brevity.
>>>
>>> Why should them be changed? This is only a cosmetic change, which would
>>> make the patch unnecessarily larger (when it's already a little too lar=
ge
>>> IMHO). If it could be in the former form till now, I think it can stay =
there
>>> a few months/years.
>>>
>>> IMHO this usage is still much better than
>>>
>>> =A0command; RC=3D$?
>>> =A0if [ $RC =3D 0 ] ...
>>> =A0... RC is not read later ...
>>>
>>> or (incorrect)
>>>
>>> =A0command || RC=3D$?
>>> =A0if [ $RC =3D 0 ] ...
>>
>> Yes, I agree with what you said about the above usage, but if you're
>> not using $? for other than just the [ $? -ne 0 ], then I wouldn't
>> even bother doing that, because if command; then saves a fork-exec,
>> and an additional line in the source. As long as it's readable and
>> doesn't expand multiple lines with a trailing \, you're fine.
>
> Are you talking only about efficiency and bash scripts? :-)

Efficiency, and more importantly readability.

> Anyway, if you want to save the fork-exec, you can just use a shell with a
> test builtin (ksh, bash, dash ... and I believe many others do).
>
> If you are concerned about readability, I suggest considering another
> alternative:
>
> =A0command || {
> =A0 do_something_on_error
> =A0}
>
> =A0command && {
> =A0 do_something_when_ok
> =A0}
>
> Of course, usable only when there's no "else" branch.

That's ugly and hard to read with large logic blocks.

> Still, I think the original form is correct and quite straightforward. I
> would probably not use the extra test myself, but I don't feel like it ne=
eds
> changing. Just looking at the patch, I see places where the check is done
> really suspiciously:
>
>
> =A0 =A0 =A0 =A0tst_resm TINFO "Test #1: changing mtu size of eth0:1 devic=
e."
>
> - =A0 =A0 =A0 ip link set eth0:1 mtu 300 &>$LTPTMP/tst_ip.err
> + =A0 =A0 =A0 ip link set eth0:1 mtu 300 >$LTPTMP/tst_ip.err 2>&1
> =A0 =A0 =A0 =A0if [ $RC -ne 0 ]
> =A0 =A0 =A0 =A0then
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_res TFAIL $LTPTMP/tst_ip.err \
>
> I think this needs much more attention than "calling [ twice" or "extra l=
ine
> in the script".

Yeah, true. Why not run everything through set -u then?

>>>> 3. About &>
>>>>
>>>> =A0 =A0Redirecting Standard Output and Standard Error
>>>> =A0 =A0 =A0 =A0Bash allows both the standard output (file descriptor 1=
) and
>>>> the standard error output (file descriptor 2) to be redirected to the
>>>> file whose name is the expansion of word with this construct.
>>>>
>>>> =A0 =A0 =A0 =A0There are two formats for redirecting standard output a=
nd
>>>> standard error:
>>>>
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 &>word
>>>> =A0 =A0 =A0 =A0and
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 >&word
>>>>
>>>> The output redirection above captures all output (and most of the time
>>>> you're capturing stdout, but losing stderr to the operating console,
>>>> which can be undesirable). >& is more portable IIRC (it works with
>>>> many ash variants, like FreeBSD's sh -- for sure -- and Solaris's sh
>>>> -- IIRC), which makes it more ideal than &>.
>>>
>>> Still, it isn't POSIX, it doesn't work with dash and actually causes
>>> pain. See:
>>>
>>> =A0cmd &> fn
>>>
>>> POSIX: run cmd in background, write empty file fn
>>> BASH: run cmd (foreground), send its (normal & error) output to file fn
>>>
>>> =A0cmd >& fn
>>>
>>> POSIX: syntax error
>>> BASH: same as above
>>>
>>> But I don't see the point you are making here - do you have a system,
>>> where the POSIX way
>>>
>>> =A0cmd > fn 2>&1
>>>
>>> doesn't work? Or did you see something else in the patch?
>>
>> This changes the behavior of the patch though. That's the point ;)...
>
> How does it change the semantics? It redirects standard output to fn, and
> standard error to standard output (which is redirected to fn). Is there
> anything else it should do?

Ugh. Nevermind -- you're right ><. Keep on forgetting about that bloody syn=
tax.
-Garrett

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
