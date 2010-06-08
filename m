Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OM1YC-0001yh-8D
	for ltp-list@lists.sourceforge.net; Tue, 08 Jun 2010 16:21:16 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OM1YB-0001m3-Jr
	for ltp-list@lists.sourceforge.net; Tue, 08 Jun 2010 16:21:16 +0000
Received: by iwn6 with SMTP id 6so3596785iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 08 Jun 2010 09:21:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1276001198-17532-1-git-send-email-monstr@monstr.eu>
References: <1276001198-17532-1-git-send-email-monstr@monstr.eu>
Date: Tue, 8 Jun 2010 09:21:08 -0700
Message-ID: <AANLkTilzjOK_lLfz_o4KOZgdj9Px2qebOnIIEe_Um1TJ@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] syscalls: getdtablesize01 fix for missing
	/etc/hosts
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
To: monstr@monstr.eu
Cc: ltp-list@lists.sourceforge.net, michal.simek@petalinux.com.monstr.eu

On Tue, Jun 8, 2010 at 5:46 AM,  <monstr@monstr.eu> wrote:
> From: Michal Simek <monstr@monstr.eu>
>
> Embedded systems doesn't need to contain /etc/hosts that's why
> will be good to create it if doesn't exist. If file doesn't exist
> then syscall test failed.
>
> Error:
> getdtablesize01 =A0 =A00 =A0TINFO =A0: =A0Maximum number of files a proce=
ss can have opened is 1024
> getdtablesize01 =A0 =A00 =A0TINFO =A0: =A0Checking with the value returne=
d by getrlimit...RLIMIT_NOFILE
> getdtablesize01 =A0 =A01 =A0TPASS =A0: =A0got correct dtablesize, value i=
s 1024
> getdtablesize01 =A0 =A00 =A0TINFO =A0: =A0Checking Max num of files that =
can be opened by a process.Should be: RLIMIT_NOFILE - 1
> Opened file num -1
> getdtablesize01 =A0 =A02 =A0TFAIL =A0: =A00 !=3D 1023
>
> Signed-off-by: Michal Simek <monstr@monstr.eu>
> ---
> =A0.../syscalls/getdtablesize/getdtablesize01.c =A0 =A0 =A0 | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c b/=
testcases/kernel/syscalls/getdtablesize/getdtablesize01.c
> index a495501..568e1ad 100644
> --- a/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c
> +++ b/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c
> @@ -83,7 +83,7 @@ int main()
> =A0 =A0 =A0 =A0tst_resm(TINFO,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Checking Max num of files that can be op=
ened by a process.Should be: RLIMIT_NOFILE - 1");
> =A0 =A0 =A0 =A0for (loop =3D 1; loop <=3D max_val_opfiles; loop++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 fd =3D open("/etc/hosts", O_RDONLY);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fd =3D open("/etc/hosts", O_RDONLY | O_CREA=
T);
> =A0#ifdef DEBUG
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf("Opened file num %d\n", fd);
> =A0#endif

No. You need to fix your embedded system to have all of the files on
it before you try and run LTP. This would regress all sane Linux
systems running LTP because the file already exists.

I agree that this assumption is broken though; it might be better to
use a different file, like via mkstemp(3).

Also, leaking file descriptors is silly if getdtablesize(2) is busted,
or the OS fails to clean up all of the open file descriptors... it
should cache the opened filehandles if !=3D -1, then close each of them
one by one.

Thanks,
-Garrett

---------------------------------------------------------------------------=
---
ThinkGeek and WIRED's GeekDad team up for the Ultimate =

GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the =

lucky parental unit.  See the prize list and enter to win: =

http://p.sf.net/sfu/thinkgeek-promo
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
