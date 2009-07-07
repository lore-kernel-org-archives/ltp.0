Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MO8L6-00018l-Vg
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 10:55:56 +0000
Received: from fmmailgate01.web.de ([217.72.192.221])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MO8Kz-0007Rz-M5
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 10:55:56 +0000
Date: Tue, 07 Jul 2009 12:29:04 +0200
From: =?iso-8859-2?B?Smn47SBQYWxl6GVr?= <jpalecek@web.de>
MIME-Version: 1.0
References: <4a413e9b.160bca0a.2226.fffff184SMTPIN_ADDED@mx.google.com>
	<364299f40907061045s567f00dbq7a198ef37fa438dc@mail.gmail.com>
	<200907070047.40979.jpalecek@web.de>
	<364299f40907061633w6583f3d3l8fd3ca90d217b38a@mail.gmail.com>
	<op.uwn8cy0au2flwt@debian>
	<364299f40907061731j70ec779asf40630eb9b2e83b4@mail.gmail.com>
Message-ID: <op.uwo0qqw7u2flwt@debian>
In-Reply-To: <364299f40907061731j70ec779asf40630eb9b2e83b4@mail.gmail.com>
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

On Tue, 07 Jul 2009 02:31:25 +0200, Garrett Cooper <yanegomi@gmail.com>  =

wrote:

> 2009/7/6 Ji=F8=ED Pale=E8ek <jpalecek@web.de>:
>> On Tue, 07 Jul 2009 01:33:29 +0200, Garrett Cooper <yanegomi@gmail.com>
>> wrote:
>>
>>> On Mon, Jul 6, 2009 at 3:47 PM, Jiri Palecek<jpalecek@web.de> wrote:
>>>>
>>>> On Monday 06 July 2009 19:45:08 Garrett Cooper wrote:
>>>>>
>>>>> 2. All numeric test(1) comparisons could and should be switched from:
>>>>>
>>>>> command
>>>>> if [ $? =3D 0 ]; then
>>>>>
>>>>> to:
>>>>>
>>>>> if command; then
>>>>>
>>>>> for brevity.
>>>>
>>>> Why should them be changed? This is only a cosmetic change, which  =

>>>> would
>>>> make the patch unnecessarily larger (when it's already a little too  =

>>>> large
>>>> IMHO). If it could be in the former form till now, I think it can  =

>>>> stay there
>>>> a few months/years.
>>>>
>>>> IMHO this usage is still much better than
>>>>
>>>> =A0command; RC=3D$?
>>>> =A0if [ $RC =3D 0 ] ...
>>>> =A0... RC is not read later ...
>>>>
>>>> or (incorrect)
>>>>
>>>> =A0command || RC=3D$?
>>>> =A0if [ $RC =3D 0 ] ...
>>>
>>> Yes, I agree with what you said about the above usage, but if you're
>>> not using $? for other than just the [ $? -ne 0 ], then I wouldn't
>>> even bother doing that, because if command; then saves a fork-exec,
>>> and an additional line in the source. As long as it's readable and
>>> doesn't expand multiple lines with a trailing \, you're fine.
>>
>> Are you talking only about efficiency and bash scripts? :-)
>
> Efficiency, and more importantly readability.
>
>> Anyway, if you want to save the fork-exec, you can just use a shell  =

>> with a
>> test builtin (ksh, bash, dash ... and I believe many others do).
>>
>> If you are concerned about readability, I suggest considering another
>> alternative:
>>
>> =A0command || {
>> =A0 do_something_on_error
>> =A0}
>>
>> =A0command && {
>> =A0 do_something_when_ok
>> =A0}
>>
>> Of course, usable only when there's no "else" branch.
>
> That's ugly and hard to read with large logic blocks.

I don't think so; I have no problems with a similar syntax in C, moreover,  =

I consider the braces more distinguishable than keywords.

>> Still, I think the original form is correct and quite straightforward. I
>> would probably not use the extra test myself, but I don't feel like it  =

>> needs
>> changing. Just looking at the patch, I see places where the check is  =

>> done
>> really suspiciously:
>>
>>
>> =A0 =A0 =A0 =A0tst_resm TINFO "Test #1: changing mtu size of eth0:1 devi=
ce."
>>
>> - =A0 =A0 =A0 ip link set eth0:1 mtu 300 &>$LTPTMP/tst_ip.err
>> + =A0 =A0 =A0 ip link set eth0:1 mtu 300 >$LTPTMP/tst_ip.err 2>&1
>> =A0 =A0 =A0 =A0if [ $RC -ne 0 ]
>> =A0 =A0 =A0 =A0then
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_res TFAIL $LTPTMP/tst_ip.err \
>>
>> I think this needs much more attention than "calling [ twice" or "extra  =

>> line
>> in the script".
>
> Yeah, true. Why not run everything through set -u then?

It would not help, IMO. At least in this particular case, the variable is  =

properly initialized.

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
