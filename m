Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NLrcI-0002ub-0R
	for ltp-list@lists.sourceforge.net; Sat, 19 Dec 2009 05:12:34 +0000
Received: from mail-pz0-f193.google.com ([209.85.222.193])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NLrcC-0000cN-OR
	for ltp-list@lists.sourceforge.net; Sat, 19 Dec 2009 05:12:33 +0000
Received: by pzk31 with SMTP id 31so2483596pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Fri, 18 Dec 2009 21:12:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4b2c35f8.4e44f10a.27a8.ffffd834SMTPIN_ADDED@mx.google.com>
References: <4b2c35f8.4e44f10a.27a8.ffffd834SMTPIN_ADDED@mx.google.com>
Date: Fri, 18 Dec 2009 21:12:22 -0800
Message-ID: <364299f40912182112w26648ebftdc99b13b1638d980@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Add (mandatory) parameters to linktest.sh in the
	runtest file
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

On Fri, Dec 18, 2009 at 6:06 PM, Jiri Palecek <jpalecek@web.de> wrote:
> Hello,
>
> linktest.sh is failing when ran using the stress.part1 file, because it l=
acks command line arguments. This patch just adds them (taken from the fs r=
untest file).
>
> Regards
> =A0Jiri Palecek
>
> Signed-off-by: Jiri Palecek <jpalecek@web.de>
> ---
> =A0runtest/stress.part1 | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/runtest/stress.part1 b/runtest/stress.part1
> index 236c471..b75d504 100644
> --- a/runtest/stress.part1
> +++ b/runtest/stress.part1
> @@ -156,7 +156,7 @@ rwtest05 export LTPROOT; rwtest.sh -N rwtest05 -c -q =
-i 50 -T 64b 500b:/tmp/rwte
> =A0iogen01 export LTPROOT; rwtest.sh -N iogen01 -i 120s -s read,write -c =
-Da -Dv -n 2 500b:doio.f1.$$ 1000b:doio.f2.$$
>
> =A0fs_inod01 fs_inod $TMP 10 10 1
> -linker01 linktest.sh
> +linker01 linktest.sh 1000 1000
> =A0openfile01 openfile -f10 -t10
> =A0inode01 inode01
> =A0inode02 inode02

Done -- thanks!
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
