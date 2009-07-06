Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MNxgr-0007DU-An
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 23:33:41 +0000
Received: from mail-yx0-f195.google.com ([209.85.210.195])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MNxgm-0004Jo-Nk
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 23:33:41 +0000
Received: by yxe33 with SMTP id 33so5240261yxe.28
	for <ltp-list@lists.sourceforge.net>;
	Mon, 06 Jul 2009 16:33:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200907070047.40979.jpalecek@web.de>
References: <4a413e9b.160bca0a.2226.fffff184SMTPIN_ADDED@mx.google.com>
	<364299f40907061045s567f00dbq7a198ef37fa438dc@mail.gmail.com>
	<200907070047.40979.jpalecek@web.de>
Date: Mon, 6 Jul 2009 16:33:29 -0700
Message-ID: <364299f40907061633w6583f3d3l8fd3ca90d217b38a@mail.gmail.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jiri Palecek <jpalecek@web.de>
Cc: ltp-list@lists.sourceforge.net

On Mon, Jul 6, 2009 at 3:47 PM, Jiri Palecek<jpalecek@web.de> wrote:
> On Monday 06 July 2009 19:45:08 Garrett Cooper wrote:
>> Jiri,
>> =A0 =A0 This patch looks ok for the most part, but here are some comment=
s:
>>
>> 1. if [[ -z "$vnet0" -z "$vnet1" ]] =3D> if [ -z "$vnet0" ] || [ -z "$vn=
et1" ]
>>
>> It's better read as the following, IMO:
>>
>> [ -z "$vnet0" -o -z "$vnet1" ]
>
> I think this is another "I like this more than that, because this is cool=
 and that sucks" debate. If other think test's "-o" should be used in this =
case, I would make the change. After all, this can be done by hand directly=
 on the patch...

Why call [(1) twice?

>> 2. All numeric test(1) comparisons could and should be switched from:
>>
>> command
>> if [ $? =3D 0 ]; then
>>
>> to:
>>
>> if command; then
>>
>> for brevity.
>
> Why should them be changed? This is only a cosmetic change, which would m=
ake the patch unnecessarily larger (when it's already a little too large IM=
HO). If it could be in the former form till now, I think it can stay there =
a few months/years.
>
> IMHO this usage is still much better than
>
> =A0command; RC=3D$?
> =A0if [ $RC =3D 0 ] ...
> =A0... RC is not read later ...
>
> or (incorrect)
>
> =A0command || RC=3D$?
> =A0if [ $RC =3D 0 ] ...

Yes, I agree with what you said about the above usage, but if you're
not using $? for other than just the [ $? -ne 0 ], then I wouldn't
even bother doing that, because if command; then saves a fork-exec,
and an additional line in the source. As long as it's readable and
doesn't expand multiple lines with a trailing \, you're fine.

>> 3. About &>
>>
>> =A0 =A0Redirecting Standard Output and Standard Error
>> =A0 =A0 =A0 =A0Bash allows both the standard output (file descriptor 1) =
and
>> the standard error output (file descriptor 2) to be redirected to the
>> file whose name is the expansion of word with this construct.
>>
>> =A0 =A0 =A0 =A0There are two formats for redirecting standard output and=
 standard error:
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 &>word
>> =A0 =A0 =A0 =A0and
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 >&word
>>
>> The output redirection above captures all output (and most of the time
>> you're capturing stdout, but losing stderr to the operating console,
>> which can be undesirable). >& is more portable IIRC (it works with
>> many ash variants, like FreeBSD's sh -- for sure -- and Solaris's sh
>> -- IIRC), which makes it more ideal than &>.
>
> Still, it isn't POSIX, it doesn't work with dash and actually causes pain=
. See:
>
> =A0cmd &> fn
>
> POSIX: run cmd in background, write empty file fn
> BASH: run cmd (foreground), send its (normal & error) output to file fn
>
> =A0cmd >& fn
>
> POSIX: syntax error
> BASH: same as above
>
> But I don't see the point you are making here - do you have a system, whe=
re the POSIX way
>
> =A0cmd > fn 2>&1
>
> doesn't work? Or did you see something else in the patch?

This changes the behavior of the patch though. That's the point ;)...

> Regards
> =A0 =A0Jiri Palecek
>
> BTW: Jiri Palecek <jirka@debian.org> is not my address.

Ok. Your original REPLY-TO email is wonky in your emails though, so I
was playing it by ear...

Thanks,
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
