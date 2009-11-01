Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N4OEq-0001gw-Pk
	for ltp-list@lists.sourceforge.net; Sun, 01 Nov 2009 00:24:08 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N4OEm-000479-2D
	for ltp-list@lists.sourceforge.net; Sun, 01 Nov 2009 00:24:08 +0000
Received: by pwj6 with SMTP id 6so1296759pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Sat, 31 Oct 2009 17:23:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <op.u2nxgmm3u2flwt@debian>
References: <200910211528.n9LFST8q028289@e35.co.us.ibm.com>
	<1256576544.4929.54.camel@subratamodak.linux.ibm.com>
	<loom.20091029T190532-79@post.gmane.org>
	<1256902668.13702.2.camel@subratamodak.linux.ibm.com>
	<op.u2l52sjuu2flwt@debian>
	<1256905177.13702.4.camel@subratamodak.linux.ibm.com>
	<364299f40910302339h5940a0cdjdcb9a18ccbbb0a7d@mail.gmail.com>
	<op.u2nxgmm3u2flwt@debian>
Date: Sat, 31 Oct 2009 17:15:46 -0700
Message-ID: <364299f40910311715s6cc5123aj17052a7aa6da49b@mail.gmail.com>
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
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi Jiri!

2009/10/31 Ji=F8=ED Pale=E8ek <jpalecek@web.de>:
> On Sat, 31 Oct 2009 07:39:54 +0100, Garrett Cooper <yanegomi@gmail.com>
> wrote:
>
>> On Fri, Oct 30, 2009 at 5:19 AM, Subrata Modak
>> <subrata@linux.vnet.ibm.com> wrote:
>>>
>>> On Fri, 2009-10-30 at 13:53 +0100, Ji=F8=ED Pale=E8ek wrote:
>>>>
>>>> On Fri, 30 Oct 2009 12:37:48 +0100, Subrata Modak
>>>> <subrata@linux.vnet.ibm.com> wrote:
>>>>
>>>> > On Thu, 2009-10-29 at 18:12 +0000, Ji=F8=EDPale=E8ek wrote:
>>>> >> Hello,
>>>> >>
>>>> >> Subrata Modak <subrata@...> writes:
>>>> >>
>>>> >> >
>>>> >> > On Wed, 2009-10-21 at 02:19 +0200, Jiri Palecek wrote:
>>>> >> > > Hello,
>>>> >> > >
>>>> >> > > this is another patch fixing bashisms in LTP tests (the fixes a=
re
>>>> >> more or
>>>> >> less the same as in the previous
>>>> >> > patches, except for a few exceptions). Note that the patch is not
>>>> >> complete,
>>>> >> in the sense that there may
>>>> >> > remain further bashisms in the source even after applying the pat=
ch
>>>> >> (like use
>>>> >> of arrays, which is visible
>>>> >> > even from this patch).
>>>> >> > >
>>>> >> > > Regards
>>>> >> > > =A0 =A0 Jiri Palecek
>>>> >> > >
>>>> >> > > Signed-off-by: Jiri Palecek <jpalecek@...>
>>>> >> >
>>>> >> > Hmm,. Some of them failed to apply. Can you please resend only the
>>>> >> error
>>>> >> > part(s):
>>>> >> >
>>>> >>
>>>> >> according to my git repository. these are the missing parts:
>>>> >>
>>>> >> Signed-off-by: Jiri Palecek <jpalecek@web.de>
>>>> >
>>>> > Then something wrong with my CVS:
>>>> >
>>>> > patching file testcases/kernel/fs/fs-bench/modaltr.sh
>>>> > Hunk #1 FAILED at 43.
>>>> > 1 out of 1 hunk FAILED -- saving rejects to file
>>>> > testcases/kernel/fs/fs-bench/modaltr.sh.rej
>>>> > patching file testcases/kernel/fs/mongo/test.sh
>>>> > Hunk #1 FAILED at 26.
>>>> > Hunk #2 FAILED at 52.
>>>> > Hunk #3 FAILED at 70.
>>>> > 3 out of 3 hunks FAILED -- saving rejects to file
>>>> > testcases/kernel/fs/mongo/test.sh.rej
>>>> > patching file testcases/network/tcp_cmds/netstat/netstat01
>>>> >
>>>> > Can you please verify ?
>>>>
>>>> It works for me in CVS, so I guess it was just a linewrap, whitespace =
or
>>>> something issue. See attachment for the original (uncrippled) patch.
>>>
>>> Yes, it works fine now :-)
>>> patching file testcases/kernel/fs/fs-bench/modaltr.sh
>>> patching file testcases/kernel/fs/mongo/test.sh
>>> patching file testcases/network/tcp_cmds/netstat/netstat01
>>
>> Sorry for replying late again, but just for future reference, there's
>> a function called is_root in $(abs_top_srcdir)/testcases/lib/cmdlib.sh
>> [in the install tree -- it gets put in
>> $(abs_top_builddir)/testcases/bin] that can be leveraged s.t. you
>> don't have to do $(id -ru) -eq 0 everywhere. There are some other
>> handy constructs and functions too that can be used for expediting
>> setup, execution, and teardown. The only thing that might be a
>> detractor for some legacy scripts is that I explicitly did set -u to
>> avoid QA issues with unset variables, so all variables must be defined
>> before including the cmd library.
>>
>> Using that script though would be helpful as it cuts down on a lot of
>> duplicate code and aims to be completely POSIX compliant. Some other
>> pluses:
>>
>> 1. incr_tst_count - increments $TST_COUNT appropriately.
>> 2. TCID is automatically set if not already provided.
>> 3. exists is a function which ensures that commands exist on a given
>> system before executing a test.
>> 4. Common SHELL_DEBUG logic.
>>
>> Just trying to make life a little easier for test writers and
>> maintainers if possible :]...
>
> Thanks for noting it. I think, however, that it would be much more valuab=
le
> to create exact duplicate of the C test API (or a subset of it) for shell
> scripts, as this would permit to remove much of the hacky stuff about
> maintaining TST_COUNT and return value from the shell scripts.

Ok. I'll definitely take that into consideration, but it's up to the
test writer to determine how many `subtestcases' are being executed in
a master testcase.

> Looking at the file you mentioned, I have just a few remarks:
>
> tst_cleanup()
> {
> =A0 =A0# Disable the trap EXIT handler.
> =A0 =A0trap '' EXIT
> =A0 =A0# To ensure set -u passes...
> =A0 =A0TCtmp=3D${TCtmp:=3D}
>
> Why? Shouldn't it catch invalid use (eg. without doing tst_setup first)?

Yeah, that's useless if TCtmp is exported in tst_setup and tst_setup
is executed to completion (or at least this variable is exported
there) first. I may need to adjust the trap(1) to get this to function
in a better way.

> =A0 =A0# Nuke the testcase temporary directory if it exists.
> =A0 =A0[ -d "$TCtmp" ] && rm -rf "$TCtmp" =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 (1)
> }
>
> tst_setup() {
>
> =A0 =A0TST_COUNT=3D1
> =A0 =A0TST_TOTAL=3D${TST_TOTAL:=3D1} =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(2)
> =A0 =A0export TCID TST_COUNT TST_TOTAL
>
> =A0 =A0for varname in TST_TOTAL; do
> =A0 =A0 =A0 =A0if eval "test -z \"\$${varname}\""; then
> =A0 =A0 =A0 =A0 =A0 =A0end_testcase "You must set ${varname} before calli=
ng setup()."
> =A0 =A0 =A0 =A0fi
> =A0 =A0done
>
> What is the sense of doing "test -z "$TST_TOTAL"" in such an elaborate wa=
y,
> especially when you reset TST_TOTAL in (2) so test -z $TST_TOTAL can never
> be true here?

I was trying to avoid duplicate logic, but if it makes sense to do:

if test "x$foo" =3D x ; then

fi
if test "x$foo" =3D x ; then

fi

and do some basic arithmetic on the values to ensure they're in range,
then I'll gladly rewrite it :]. The point was to avoid the nasty `you
need to defined variable X.Y.Z' message from tst_res*(3), etc, because
this is quick and resolves coding issues with the underlying
testcases.

> ...
>
> =A0 =A0TCtmp=3D${TCtmp:=3D$TEMPDIR/$TC$$}
> =A0 =A0# User wants a temporary sandbox to play with.
> =A0 =A0if [ -n "$TCtmp" -a "$TCtmp" !=3D "$TEMPDIR/$$" ] ; then
> =A0 =A0 =A0 =A0test -d "$TCtmp" || mkdir -p "$TCtmp"
>
> What is so special about "$TEMPDIR/$$" that you refuse to create a direct=
ory
> with this name, but still delete it in (1)?

Good point; this is not very well thought-out logic that I implemented
on impulse a while ago (I think that the original logic test was
`"$TCtmp" !=3D "$TEMPDIR"').

> ...
> }
>
> incr_tst_count()
> {
> =A0 =A0: $(( TST_COUNT + 1 ))
> }
>
> Was this really meant this way (ie. as a code with no effect), or should =
it
> be "+=3D"?

That's a really stupid mistake that I made. Fixed now (thanks!).

Thanks for the review!
-Garrett

---------------------------------------------------------------------------=
---
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay =

ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
