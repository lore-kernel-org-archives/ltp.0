Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MzfNT-0006Ga-3E
	for ltp-list@lists.sourceforge.net; Sun, 18 Oct 2009 23:41:31 +0000
Received: from mail-px0-f181.google.com ([209.85.216.181])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MzfNN-0003ld-39
	for ltp-list@lists.sourceforge.net; Sun, 18 Oct 2009 23:41:31 +0000
Received: by pxi11 with SMTP id 11so385639pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Sun, 18 Oct 2009 16:41:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1255890117.5359.17.camel@subratamodak.linux.ibm.com>
References: <8368651DACC1964480F951191B94A0780153D7BE@svexch01.mvista.com>
	<364299f40910162217w545c9108rbdac6e26fa0cf563@mail.gmail.com>
	<1255890117.5359.17.camel@subratamodak.linux.ibm.com>
Date: Sun, 18 Oct 2009 16:41:18 -0700
Message-ID: <364299f40910181641o6fc1ffd8va3810be69d5cb10d@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [LTP{PATCH][fs tests] modify tests to honor tmp directory
	passed into runltp, convert to LTP format
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
To: subrata@linux.vnet.ibm.com
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>

On Sun, Oct 18, 2009 at 11:21 AM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
>
> On Fri, 2009-10-16 at 22:17 -0700, Garrett Cooper wrote:
>> On Fri, Oct 16, 2009 at 1:31 PM, Henry Yei <hyei@mvista.com> wrote:
>> > This is a set of patches for tests in the fs runtest file which make u=
se of tst_tmpdir functions or alternatively, the base tmpdir set by the use=
r. Some of the tests have been converted to LTP test format as well.
>> >
>> > Tests that are changed:
>> > fs_di
>> > fs_perms
>> > lftest
>> > linker01
>> > quota_remount_test01
>> > writetest
>>
>> Note: linker01 is a bourne shell script now.
>
> And as Garret said, and apart from that, the lftest.patch fails too:
>
> patching file testcases/kernel/fs/lftest/lftest.c
> patch: **** malformed patch at line 94:
>
> can't find file to patch at input line 3
> Perhaps you used the wrong -p or --strip option?
> The text leading up to this was:
> --------------------------
> |--- ltp-20090531/testcases/kernel/fs/linktest/linktest.pl
> 2008-07-30 06:18:22.000000000 -0700
> |+++ ltp-wdir/testcases/kernel/fs/linktest/linktest.pl =A02009-07-27
> 20:59:55.370039414 -0700
> --------------------------
> File to patch:
>
> Regards--
> Subrata

Here's a version that improves upon the old version of linktest.sh (I
directly translated linktest.pl to linktest.sh, and I noticed several
items that were either not caught before, or where lost in
translation). I've just checked this into cvs.

1. Honor TMPDIR, as per Henry Yei's note, because linktest.sh doesn't
currently do that.
2. Add error checking for cd(1) failure.
3. Suffix the temporary directory with $$ to allow multiple copies to
execute on the directory at any given time.
4. Add trap(1)'s to delete the temporary files / directories generated
in the script.

gcooper@orangebox /scratch/ltp-dev2/ltp $
testcases/kernel/fs/linktest/linktest.sh 200 1000
linker01    1  TPASS  :  Symbolic Link Errors: 0
linker01    2  TPASS  :  Hard Link Errors: 0

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

Index: testcases/kernel/fs/linktest/linktest.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/kernel/fs/linktest/linktest.sh,v
retrieving revision 1.1
diff -u -r1.1 linktest.sh
--- testcases/kernel/fs/linktest/linktest.sh    14 Oct 2009 19:32:12
-0000      1.1
+++ testcases/kernel/fs/linktest/linktest.sh    18 Oct 2009 23:39:24 -0000
@@ -25,19 +25,34 @@
 #  HISTORY     :
 #      A rewrite of testcases/kernel/fs/linktest.pl

-# XXX: Change to a temp dir via mktemp -d.
-cd "${0%/*}"
-
 export TCID=3Dlinker01
 export TST_TOTAL=3D2
 export TST_COUNT=3D1

 if [ $# -ne 2 ]; then
-       tst_res TBROK "" "Usage: $0 {softlink count} {hardlink count}"
-       exit -1
+       tst_res TBROK "" "usage: $0 {softlink count} {hardlink count}"
+       exit 1
 fi

-mkdir hlink slink && touch hlink/hfile slink/sfile
+# TMPDIR not specified.
+if [ "x$TMPDIR" =3D x -o ! -d "$TMPDIR" ] ; then
+
+       if ! TMPDIR=3D$(mktemp -d) ; then
+               tst_res TBROK "" 'Failed to create $TMPDIR'
+               exit 1
+       fi
+       # We created the directory, so we have the power to delete it as we=
ll.
+       trap "rm -Rf '$TMPDIR'" EXIT
+
+# Most likely runltp provided; don't delete $TMPDIR, but instead delete the
+# files under it belonging to this process.
+else
+       trap "rm -Rf '$TMPDIR/[hs]link.$$'" EXIT
+fi
+
+cd "$TMPDIR" || tst_res TBROK "" "Failed to cd to $TMPDIR"
+
+mkdir hlink.$$ slink.$$ && touch hlink.$$/hfile slink.$$/sfile

 do_link() {
        pfix=3D$1
@@ -49,7 +64,7 @@

        i=3D0

-       cd ${pfix}link
+       cd "${pfix}link.$$"
        while [ $i -lt $limit ]; do
                if ! ln ${ln_opts} "$PWD/${pfix}file" ${pfix}file${i}; then
                        : $(( lerrors +=3D 1 ))
@@ -73,4 +88,4 @@
 do_link s "-s" ${1} "Symbolic"
 do_link h   "" ${2} "Hard"

-rm -Rf hlink slink
+rm -Rf hlink.$$ slink.$$

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
