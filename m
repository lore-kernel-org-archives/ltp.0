Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NYXjD-0001Y7-NF
	for ltp-list@lists.sourceforge.net; Sat, 23 Jan 2010 04:36:07 +0000
Received: from mail-pz0-f190.google.com ([209.85.222.190])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NYXjC-0006Qk-Tz
	for ltp-list@lists.sourceforge.net; Sat, 23 Jan 2010 04:36:07 +0000
Received: by pzk28 with SMTP id 28so557389pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Fri, 22 Jan 2010 20:36:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4b598c04.5c44f10a.590a.2f18SMTPIN_ADDED@mx.google.com>
References: <4b598c04.5c44f10a.590a.2f18SMTPIN_ADDED@mx.google.com>
Date: Fri, 22 Jan 2010 20:36:00 -0800
Message-ID: <364299f41001222036w59d5aa65i5911f9cefe13e452@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Fix a probable typo in ftp03
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

On Fri, Jan 22, 2010 at 4:28 AM, Jiri Palecek <jpalecek@web.de> wrote:
> Hello,
>
> there is no 'vftpd' mentioned in the script elsewhere, so I guess this is=
 just a typo.
>
> Regards
> =A0 =A0Jiri Palecek
>
> Signed-off-by: Jiri Palecek <jpalecek@web.de>
> ---
> =A0testcases/network/tcp_cmds/ftp/ftp03 | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/testcases/network/tcp_cmds/ftp/ftp03 b/testcases/network/tcp=
_cmds/ftp/ftp03
> index e85a985..c934f85 100755
> --- a/testcases/network/tcp_cmds/ftp/ftp03
> +++ b/testcases/network/tcp_cmds/ftp/ftp03
> @@ -48,7 +48,7 @@ do_setup()
>
> =A0 =A0 tst_setup
>
> - =A0 =A0exists ftp useradd userdel vftpd
> + =A0 =A0exists ftp useradd userdel vsftpd
>
> =A0 =A0 for vsftp_conf in /etc/vsftpd /etc; do

    Is this the groupname used in the other ftp* scripts?
Thanks!
-Garrett

---------------------------------------------------------------------------=
---
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Confere=
nce
attendees to learn about information security's most important issues throu=
gh
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
