Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PD67d-0007F2-Ce
	for ltp-list@lists.sourceforge.net; Tue, 02 Nov 2010 01:57:13 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PD67c-00087y-7Q
	for ltp-list@lists.sourceforge.net; Tue, 02 Nov 2010 01:57:13 +0000
Received: by wwb31 with SMTP id 31so6249775wwb.10
	for <ltp-list@lists.sourceforge.net>;
	Mon, 01 Nov 2010 18:57:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4CCF6B53.5050109@cn.fujitsu.com>
References: <4CCF6B53.5050109@cn.fujitsu.com>
Date: Mon, 1 Nov 2010 18:57:06 -0700
Message-ID: <AANLkTimZFKMZ3YYjr7k3gkjagZUXwwWyjw5YjTfVLURO@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [POSIX][PATCH]Cleanup the test shm_open/2-1 to make a
	good format
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
To: Bian Naimeng <biannm@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Mon, Nov 1, 2010 at 6:37 PM, Bian Naimeng <biannm@cn.fujitsu.com> wrote:
> Although it's not important, but it makes a noise in the log.
>
> ----------------------------------------------------------------
> Cleanup the test shm_open/2-1 to make a good format.
>
> Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>
>
> ---
> =A0.../conformance/interfaces/shm_open/2-1.c =A0 =A0 =A0 =A0 =A0| =A0 =A0=
4 +++-
> =A01 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/shm_op=
en/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/shm_open/2=
-1.c
> index f4bab48..b0adce6 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/shm_open/2-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/shm_open/2-1.c
> @@ -17,7 +17,9 @@
>
> =A0int main()
> =A0{
> - =A0 =A0 =A0 =A0printf("Will not test that the shm_open() function creat=
e an open file description\nthat refers to the shared memory object and a f=
ile descriptor that refers to\nthat open file description.");
> + =A0 =A0 =A0 =A0printf("Will not test that the shm_open() function creat=
e an open file"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0"description that refers to the shared memor=
y object and a file"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0"descriptor that refers to that open file de=
scription.\n");
> =A0 =A0 =A0 =A0 return PTS_UNTESTED;
> =A0}

    Actually, that will look a lot worse because you just removed some
spaces in areas. description should be descriptor, etc.
    I'll fix this up and give you credit for the note :).
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store =

http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
