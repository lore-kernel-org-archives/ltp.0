Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NMvRB-0007o5-J4
	for ltp-list@lists.sourceforge.net; Tue, 22 Dec 2009 03:29:29 +0000
Received: from mail-px0-f189.google.com ([209.85.216.189])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NMvR4-0004Or-Of
	for ltp-list@lists.sourceforge.net; Tue, 22 Dec 2009 03:29:29 +0000
Received: by pxi27 with SMTP id 27so2335866pxi.4
	for <ltp-list@lists.sourceforge.net>;
	Mon, 21 Dec 2009 19:29:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <002701ca7edf$5b1e2730$115a7590$@co.jp>
References: <002701ca7edf$5b1e2730$115a7590$@co.jp>
Date: Mon, 21 Dec 2009 19:29:16 -0800
Message-ID: <364299f40912211929n533833c3s99e1111565262e74@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] "BindMounts" test failure
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

On Wed, Dec 16, 2009 at 10:08 PM, Mitani <mitani@ryobi.co.jp> wrote:
> Hi,
>
> I ran "runltp" with "ltp-2009-12-16" cvs.
> And I found the following failure in "BindMounts" testcase:
>
> ------------
> sh: /opt/ltp/testscripts/test_fs_bind.sh: Permission denied
> ------------
>
> When I added execution permission and tested this testcase, the
> following errors occurred.
>
> ------------
> ls: /opt/ltp/testcases/kernel/fs/fs_bind/move/test*: No such file or
> directory
> ls: /opt/ltp/testcases/kernel/fs/fs_bind/bind/test*: No such file or
> directory
> ls: /opt/ltp/testcases/kernel/fs/fs_bind/rbind/test*: No such file or
> directory
> ls: /opt/ltp/testcases/kernel/fs/fs_bind/regression/test*: No such file or
> directory
> ------------
>
> This error is caused by following:
> =A0(1) Execution files haven't permissions.
> =A0(2) "${LTPROOT}" directory isn't the current directory in which
> =A0 =A0 "make install" executed.
> =A0 =A0 By default, "${LTPROOT}" directory is "/opt/ltp".
> =A0(3) ".../ltp-2009-12-16/testcases/kernel/fs/fs_bind/" directory does e=
xist,
> =A0 =A0 but "/opt/ltp/testcases/kernel/fs/fs_bind/" directory doesn't exi=
st.
> =A0 =A0 =A0(I want to suggest using "/opt/ltp/testcases/bin/fs_bind/"
> =A0 =A0 =A0instead of "/opt/ltp/testcases/kernel/fs/fs_bind/".)
>
> Then, I think that it requires following three modifications to run
> "BindMounts" test exactly:
>
> =A0(1) Add the execution permissions to "${LTPROOT}/testscripts" directory
> =A0 =A0 when installation.
> =A0(2) Deploy following four directories under the "${LTPROOT}/testcases/=
bin"
> =A0 =A0 directory when installation.
> =A0 =A0 "./fs_bind/move/"
> =A0 =A0 "./fs_bind/bind/"
> =A0 =A0 "./fs_bind/rbind/"
> =A0 =A0 "./fs_bind/regression/"
> =A0(3) Apply the following patch:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- test_fs_bind.sh =A0 =A0 2008-06-29 04:30:19.000000000 +0900
> +++ test_fs_bind.sh.new 2009-12-17 11:32:27.000000000 +0900
> @@ -60,7 +60,7 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LTPROOT=3D"${PWD}"
> =A0 =A0 =A0 =A0fi
>
> - =A0 =A0 =A0 FS_BIND_ROOT=3D"${LTPROOT}/testcases/kernel/fs/fs_bind"
> + =A0 =A0 =A0 FS_BIND_ROOT=3D"${LTPROOT}/testcases/bin/fs_bind"
>
> =A0 =A0 =A0 =A0total=3D0 # total number of tests
> =A0 =A0 =A0 =A0for dir in "${test_dirs[@]}" ; do

    The install issues should be fixed now, but there may be some
issues with mountpoints, et all so please holler if you run into any
functional issues with the test.
Thanks,
-Garrett

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
