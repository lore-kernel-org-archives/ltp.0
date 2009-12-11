Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NJ2Az-0000Xo-C9
	for ltp-list@lists.sourceforge.net; Fri, 11 Dec 2009 09:52:41 +0000
Received: from mail-yw0-f175.google.com ([209.85.211.175])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NJ2At-0000wz-UC
	for ltp-list@lists.sourceforge.net; Fri, 11 Dec 2009 09:52:41 +0000
Received: by ywh5 with SMTP id 5so1583385ywh.11
	for <ltp-list@lists.sourceforge.net>;
	Fri, 11 Dec 2009 01:52:30 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1077)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <000101ca79f4$7af702b0$70e50810$@co.jp>
Date: Fri, 11 Dec 2009 01:52:26 -0800
Message-Id: <2937C931-7CC9-4FCF-8B9F-7D67BDF055EA@gmail.com>
References: <000101ca79f4$7af702b0$70e50810$@co.jp>
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
Content-Type: multipart/mixed; boundary="===============9154268646040342052=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net


--===============9154268646040342052==
Content-Type: multipart/alternative; boundary=Apple-Mail-3-897589006


--Apple-Mail-3-897589006
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Dec 10, 2009, at 3:57 PM, Mitani wrote:

> Hi,
> 
> In the following thread, "rwtest has been renamed to rwtest.sh" is written.
> http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg08896.html
> 
> But, I got following message when I ran tests of "rwtest{01...05}" and
> "iogen01" in my system with "ltp-2009-12-10" cvs.
> 
> ------------
> sh: rwtest.sh: command not found
> ------------
> 
> I think that "rwtest.sh" has been renamed to "rwtest" at about 2009/11/14.
> 
> Here is a patch that reverts the previous patch applied to runtest/fs.
> After applied this patch, "rwtest{01...05}" and "iogen01" passed in my
> system.
> 
> ============
> --- fs	2009-12-10 10:23:21.000000000 +0900
> +++ fs.new	2009-12-10 11:23:53.000000000 +0900
> @@ -29,15 +29,15 @@
> gf28 growfiles -W gf28 -b -D 0 -w -g 16b -C 1 -b -i 1000 -u gfsparse-2-$$
> -d $TMPDIR
> gf29 growfiles -W gf29 -b -D 0 -r 1-4096 -R 0-33554432 -i 0 -L 60 -C 1 -u
> gfsparse-3-$$ -d $TMPDIR
> gf30 growfiles -W gf30 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -o
> O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 gf-sync-$$ -d $TMPDIR
> -rwtest01 export LTPROOT; rwtest.sh -N rwtest01 -c -q -i 60s  -f sync
> 10%25000:$TMPDIR/rw-sync-$$
> -rwtest02 export LTPROOT; rwtest.sh -N rwtest02 -c -q -i 60s  -f buffered
> 10%25000:$TMPDIR/rw-buffered-$$
> -rwtest03 export LTPROOT; rwtest.sh -N rwtest03 -c -q -i 60s -n 2  -f
> buffered -s mmread,mmwrite -m random -Dv 10%25000:$TMPDIR/mm-buff-$$
> -rwtest04 export LTPROOT; rwtest.sh -N rwtest04 -c -q -i 60s -n 2  -f sync
> -s mmread,mmwrite -m random -Dv 10%25000:$TMPDIR/mm-sync-$$
> -rwtest05 export LTPROOT; rwtest.sh -N rwtest05 -c -q -i 50 -T 64b
> 500b:$TMPDIR/rwtest01%f
> +rwtest01 export LTPROOT; rwtest -N rwtest01 -c -q -i 60s  -f sync
> 10%25000:$TMPDIR/rw-sync-$$
> +rwtest02 export LTPROOT; rwtest -N rwtest02 -c -q -i 60s  -f buffered
> 10%25000:$TMPDIR/rw-buffered-$$
> +rwtest03 export LTPROOT; rwtest -N rwtest03 -c -q -i 60s -n 2  -f buffered
> -s mmread,mmwrite -m random -Dv 10%25000:$TMPDIR/mm-buff-$$
> +rwtest04 export LTPROOT; rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s
> mmread,mmwrite -m random -Dv 10%25000:$TMPDIR/mm-sync-$$
> +rwtest05 export LTPROOT; rwtest -N rwtest05 -c -q -i 50 -T 64b
> 500b:$TMPDIR/rwtest01%f
> 
> #must be run as root
> #iogen01 iogen -i 120s -s read,write 500b:doio.f1.$$ 1000b:doio.f2.$$ |
> doio -akv -n 2
> -iogen01 export LTPROOT; rwtest.sh -N iogen01 -i 120s -s read,write -Da -Dv
> -n 2 500b:doio.f1.$$ 1000b:doio.f2.$$
> +iogen01 export LTPROOT; rwtest -N iogen01 -i 120s -s read,write -Da -Dv -n
> 2 500b:doio.f1.$$ 1000b:doio.f2.$$
> 
> fs_inod01 fs_inod $TMP 10 10 10
> linker01 linktest.sh 1000 1000

Done -- thanks!
-Garrett



--Apple-Mail-3-897589006
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space; =
"><div><div><div>On Dec 10, 2009, at 3:57 PM, Mitani wrote:</div><br =
class=3D"Apple-interchange-newline"><blockquote =
type=3D"cite"><div>Hi,<br><br>In the following thread, "rwtest has been =
renamed to rwtest.sh" is written.<br><a =
href=3D"http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg0889=
6.html">http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg0889=
6.html</a><br><br>But, I got following message when I ran tests of =
"rwtest{01...05}" and<br>"iogen01" in my system with "ltp-2009-12-10" =
cvs.<br><br>------------<br>sh: rwtest.sh: command not =
found<br>------------<br><br>I think that "rwtest.sh" has been renamed =
to "rwtest" at about 2009/11/14.<br><br>Here is a patch that reverts the =
previous patch applied to runtest/fs.<br>After applied this patch, =
"rwtest{01...05}" and "iogen01" passed in =
my<br>system.<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>--- fs<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2009-12-10 10:23:21.000000000 +0900<br>+++ fs.new<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2009-12-10 11:23:53.000000000 +0900<br>@@ -29,15 +29,15 @@<br> =
gf28 growfiles -W gf28 -b -D 0 -w -g 16b -C 1 -b -i 1000 -u =
gfsparse-2-$$<br>-d $TMPDIR<br> gf29 growfiles -W gf29 -b -D 0 -r 1-4096 =
-R 0-33554432 -i 0 -L 60 -C 1 -u<br>gfsparse-3-$$ -d $TMPDIR<br> gf30 =
growfiles -W gf30 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 =
-o<br>O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 gf-sync-$$ -d =
$TMPDIR<br>-rwtest01 export LTPROOT; rwtest.sh -N rwtest01 -c -q -i 60s =
&nbsp;-f sync<br>10%25000:$TMPDIR/rw-sync-$$<br>-rwtest02 export =
LTPROOT; rwtest.sh -N rwtest02 -c -q -i 60s &nbsp;-f =
buffered<br>10%25000:$TMPDIR/rw-buffered-$$<br>-rwtest03 export LTPROOT; =
rwtest.sh -N rwtest03 -c -q -i 60s -n 2 &nbsp;-f<br>buffered -s =
mmread,mmwrite -m random -Dv 10%25000:$TMPDIR/mm-buff-$$<br>-rwtest04 =
export LTPROOT; rwtest.sh -N rwtest04 -c -q -i 60s -n 2 &nbsp;-f =
sync<br>-s mmread,mmwrite -m random -Dv =
10%25000:$TMPDIR/mm-sync-$$<br>-rwtest05 export LTPROOT; rwtest.sh -N =
rwtest05 -c -q -i 50 -T 64b<br>500b:$TMPDIR/rwtest01%f<br>+rwtest01 =
export LTPROOT; rwtest -N rwtest01 -c -q -i 60s &nbsp;-f =
sync<br>10%25000:$TMPDIR/rw-sync-$$<br>+rwtest02 export LTPROOT; rwtest =
-N rwtest02 -c -q -i 60s &nbsp;-f =
buffered<br>10%25000:$TMPDIR/rw-buffered-$$<br>+rwtest03 export LTPROOT; =
rwtest -N rwtest03 -c -q -i 60s -n 2 &nbsp;-f buffered<br>-s =
mmread,mmwrite -m random -Dv 10%25000:$TMPDIR/mm-buff-$$<br>+rwtest04 =
export LTPROOT; rwtest -N rwtest04 -c -q -i 60s -n 2 &nbsp;-f sync =
-s<br>mmread,mmwrite -m random -Dv =
10%25000:$TMPDIR/mm-sync-$$<br>+rwtest05 export LTPROOT; rwtest -N =
rwtest05 -c -q -i 50 -T 64b<br>500b:$TMPDIR/rwtest01%f<br><br> #must be =
run as root<br> #iogen01 iogen -i 120s -s read,write 500b:doio.f1.$$ =
1000b:doio.f2.$$ |<br>doio -akv -n 2<br>-iogen01 export LTPROOT; =
rwtest.sh -N iogen01 -i 120s -s read,write -Da -Dv<br>-n 2 =
500b:doio.f1.$$ 1000b:doio.f2.$$<br>+iogen01 export LTPROOT; rwtest -N =
iogen01 -i 120s -s read,write -Da -Dv -n<br>2 500b:doio.f1.$$ =
1000b:doio.f2.$$<br><br> fs_inod01 fs_inod $TMP 10 10 10<br> linker01 =
linktest.sh 1000 1000<font class=3D"Apple-style-span" =
color=3D"#000000"><font class=3D"Apple-style-span" =
color=3D"#144FAE"><br></font></font></div></blockquote><br></div><div>Done=
 -- =
thanks!<div>-Garrett</div><div><br></div></div><br></div></body></html>=

--Apple-Mail-3-897589006--


--===============9154268646040342052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev

--===============9154268646040342052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============9154268646040342052==--

