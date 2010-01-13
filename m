Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NV7dP-0007wM-JG
	for ltp-list@lists.sourceforge.net; Wed, 13 Jan 2010 18:07:59 +0000
Received: from mail-px0-f171.google.com ([209.85.216.171])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NV7dO-0006CQ-Ei
	for ltp-list@lists.sourceforge.net; Wed, 13 Jan 2010 18:07:59 +0000
Received: by pxi1 with SMTP id 1so7078573pxi.25
	for <ltp-list@lists.sourceforge.net>;
	Wed, 13 Jan 2010 10:07:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1263401044.7900.4.camel@lucio-t400>
References: <000101ca79f4$7af702b0$70e50810$@co.jp>
	<2937C931-7CC9-4FCF-8B9F-7D67BDF055EA@gmail.com>
	<1263234549.18451.1.camel@lucio-t400>
	<364299f41001120226y2c7c51ecu7ef222b1ce2ca0ee@mail.gmail.com>
	<1263401044.7900.4.camel@lucio-t400>
Date: Wed, 13 Jan 2010 10:07:51 -0800
Message-ID: <364299f41001131007k4d7a8eesc69d6c6af1da3f57@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Tests of "iogen01" et al. fail with ltp-2009-12-10 cvs
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
To: ljhc@br.ibm.com
Cc: ltp-list@lists.sourceforge.net

On Wed, Jan 13, 2010 at 8:44 AM, Lucio Correia <ljhc@br.ibm.com> wrote:
> Hi Garret,
>
> I'm running on a ppc64 machine.
>
> I noticed it by running ./runltp (all tests). I found these messages in
> the .log file:
> gf30 =A0 =A0 =A0 =A01 =A0TPASS =A0: =A0Test passed
> sh: rwtest.sh: command not found
> sh: rwtest.sh: command not found
> sh: rwtest.sh: command not found
> sh: rwtest.sh: command not found
> sh: rwtest.sh: command not found
> sh: rwtest.sh: command not found
> FS_INODE: File system stress - inode allocation/deallocation
>
> Then I looked for rwtest.sh and didn't find. But I found rwtest
>
> Now I'm running it manually:
>
> # export LTPROOT; rwtest.sh -N iogen01 -i 120s -s read,write -Da -Dv -n
> 2 500b:doio.f1.$$ 1000b:doio.f2.$$
> bash: rwtest.sh: command not found
>
> # export LTPROOT; rwtest -N iogen01 -i 120s -s read,write -Da -Dv -n 2
> 500b:doio.f1.$$ 1000b:doio.f2.$$
> /opt/ltp/testcases/bin/iogen -N iogen01 -i 120s -s read,write
> 500b:doio.f1.29698 1000b:doio.f2.29698 | /opt/ltp/testcases/bin/doio -N
> iogen01 -a -v -n 2 -k
>
> iogen(iogen01) starting up with the following:
>
> Out-pipe: =A0 =A0 =A0 =A0 =A0 =A0 =A0stdout
> Iterations: =A0 =A0 =A0 =A0 =A0 =A0120 seconds
> Seed: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A029976
> Offset-Mode: =A0 =A0 =A0 =A0 =A0 sequential
> Overlap Flag: =A0 =A0 =A0 =A0 =A0off
> Mintrans: =A0 =A0 =A0 =A0 =A0 =A0 =A01 =A0 =A0 =A0 =A0 =A0 (1 blocks)
> Maxtrans: =A0 =A0 =A0 =A0 =A0 =A0 =A0131072 =A0 =A0 =A0(256 blocks)
> O_RAW/O_SSD Multiple: =A0(Determined by device)
> Syscalls: =A0 =A0 =A0 =A0 =A0 =A0 =A0read write
> Aio completion types: =A0none
> Flags: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buffered sync
>
> Test Files:
>
> Path =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Length =A0 =A0iou =A0 raw iou
> file
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(bytes) (bytes) (bytes)
> type
> -------------------------------------------------------------------------=
----
> /opt/ltp/doio.f1.29698 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 25=
6000 =A0 =A0 =A0 1 =A0 =A0 512
> regular
> /opt/ltp/doio.f2.29698 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 51=
2000 =A0 =A0 =A0 1 =A0 =A0 512
> regular
> iogen01 =A0 =A0 1 =A0TPASS =A0: =A0Test passed
> Test passed

Everything's fine on CVS with this item:

optimus ltp # grep -r 'rwtest.sh' runtest/ | grep -v rwtest.sh
optimus ltp # find testcases -name 'rwtest*'
testcases/kernel/fs/doio/rwtest
optimus ltp # cvs diff runtest/
cvs diff: Diffing runtest
optimus ltp #

> On Tue, 2010-01-12 at 02:26 -0800, Garrett Cooper wrote:
>> On Mon, Jan 11, 2010 at 10:29 AM, Lucio Correia <ljhc@br.ibm.com> wrote:
>> > Hi Garrett,
>> >
>> > I'm still seeing this issue with LTP-20091231.
>>
>> Hi Lucio,
>> What's the error message and how are you trying to run the test (the
>> files checked in are correct as well as the runtest file itself which
>> was out of sync before)?
>> Thanks,
>> -Garrett
>>
>> > On Fri, 2009-12-11 at 01:52 -0800, Garrett Cooper wrote:
>> >> On Dec 10, 2009, at 3:57 PM, Mitani wrote:
>> >>
>> >> > Hi,
>> >> >
>> >> > In the following thread, "rwtest has been renamed to rwtest.sh" is
>> >> > written.
>> >> > http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg08896=
.html
>> >> >
>> >> > But, I got following message when I ran tests of "rwtest{01...05}"
>> >> > and
>> >> > "iogen01" in my system with "ltp-2009-12-10" cvs.
>> >> >
>> >> > ------------
>> >> > sh: rwtest.sh: command not found
>> >> > ------------
>> >> >
>> >> > I think that "rwtest.sh" has been renamed to "rwtest" at about
>> >> > 2009/11/14.
>> >> >
>> >> > Here is a patch that reverts the previous patch applied to
>> >> > runtest/fs.
>> >> > After applied this patch, "rwtest{01...05}" and "iogen01" passed in
>> >> > my
>> >> > system.
>> >> >
>> >> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> > --- fs 2009-12-10 10:23:21.000000000 +0900
>> >> > +++ fs.new 2009-12-10 11:23:53.000000000 +0900
>> >> > @@ -29,15 +29,15 @@
>> >> > gf28 growfiles -W gf28 -b -D 0 -w -g 16b -C 1 -b -i 1000 -u
>> >> > gfsparse-2-$$
>> >> > -d $TMPDIR
>> >> > gf29 growfiles -W gf29 -b -D 0 -r 1-4096 -R 0-33554432 -i 0 -L 60 -C
>> >> > 1 -u
>> >> > gfsparse-3-$$ -d $TMPDIR
>> >> > gf30 growfiles -W gf30 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -o
>> >> > O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 gf-sync-$$ -d $TMPDIR
>> >> > -rwtest01 export LTPROOT; rwtest.sh -N rwtest01 -c -q -i 60s =A0-f
>> >> > sync
>> >> > 10%25000:$TMPDIR/rw-sync-$$
>> >> > -rwtest02 export LTPROOT; rwtest.sh -N rwtest02 -c -q -i 60s =A0-f
>> >> > buffered
>> >> > 10%25000:$TMPDIR/rw-buffered-$$
>> >> > -rwtest03 export LTPROOT; rwtest.sh -N rwtest03 -c -q -i 60s -n 2
>> >> > =A0-f
>> >> > buffered -s mmread,mmwrite -m random -Dv 10%25000:$TMPDIR/mm-buff-$$
>> >> > -rwtest04 export LTPROOT; rwtest.sh -N rwtest04 -c -q -i 60s -n 2
>> >> > =A0-f sync
>> >> > -s mmread,mmwrite -m random -Dv 10%25000:$TMPDIR/mm-sync-$$
>> >> > -rwtest05 export LTPROOT; rwtest.sh -N rwtest05 -c -q -i 50 -T 64b
>> >> > 500b:$TMPDIR/rwtest01%f
>> >> > +rwtest01 export LTPROOT; rwtest -N rwtest01 -c -q -i 60s =A0-f sync
>> >> > 10%25000:$TMPDIR/rw-sync-$$
>> >> > +rwtest02 export LTPROOT; rwtest -N rwtest02 -c -q -i 60s =A0-f
>> >> > buffered
>> >> > 10%25000:$TMPDIR/rw-buffered-$$
>> >> > +rwtest03 export LTPROOT; rwtest -N rwtest03 -c -q -i 60s -n 2 =A0-f
>> >> > buffered
>> >> > -s mmread,mmwrite -m random -Dv 10%25000:$TMPDIR/mm-buff-$$
>> >> > +rwtest04 export LTPROOT; rwtest -N rwtest04 -c -q -i 60s -n 2 =A0-f
>> >> > sync -s
>> >> > mmread,mmwrite -m random -Dv 10%25000:$TMPDIR/mm-sync-$$
>> >> > +rwtest05 export LTPROOT; rwtest -N rwtest05 -c -q -i 50 -T 64b
>> >> > 500b:$TMPDIR/rwtest01%f
>> >> >
>> >> > #must be run as root
>> >> > #iogen01 iogen -i 120s -s read,write 500b:doio.f1.$$
>> >> > 1000b:doio.f2.$$ |
>> >> > doio -akv -n 2
>> >> > -iogen01 export LTPROOT; rwtest.sh -N iogen01 -i 120s -s read,write
>> >> > -Da -Dv
>> >> > -n 2 500b:doio.f1.$$ 1000b:doio.f2.$$
>> >> > +iogen01 export LTPROOT; rwtest -N iogen01 -i 120s -s read,write -Da
>> >> > -Dv -n
>> >> > 2 500b:doio.f1.$$ 1000b:doio.f2.$$
>> >> >
>> >> > fs_inod01 fs_inod $TMP 10 10 10
>> >> > linker01 linktest.sh 1000 1000
>> >> >
>> >>
>> >>
>> >> Done -- thanks!
>> >> -Garrett
>> >>
>> >>
>> >>
>> >>
>> >> ---------------------------------------------------------------------=
---------
>> >> Return on Information:
>> >> Google Enterprise Search pays you back
>> >> Get the facts.
>> >> http://p.sf.net/sfu/google-dev2dev
>> >> _______________________________________________
>> >> Ltp-list mailing list
>> >> Ltp-list@lists.sourceforge.net
>> >> https://lists.sourceforge.net/lists/listinfo/ltp-list
>> >
>> >
>
>

---------------------------------------------------------------------------=
---
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
