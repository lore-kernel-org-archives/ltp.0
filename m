Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Ol8dX-0006C9-Fz
	for ltp-list@lists.sourceforge.net; Mon, 16 Aug 2010 22:58:35 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ol8dW-0005ug-JF
	for ltp-list@lists.sourceforge.net; Mon, 16 Aug 2010 22:58:35 +0000
Received: by bwz12 with SMTP id 12so3068709bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 16 Aug 2010 15:58:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTinxT2tjOu_uxNTLxyuYEFSV_ypjM5wZQbKsiy7B@mail.gmail.com>
References: <AANLkTinxT2tjOu_uxNTLxyuYEFSV_ypjM5wZQbKsiy7B@mail.gmail.com>
Date: Mon, 16 Aug 2010 15:58:28 -0700
Message-ID: <AANLkTi=H4jm4Y-6=hwNjsHGTf64omsJPktrUZOvpmjkW@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH][ftests] use MAXPATHLEN for all character arrays
 that hold path/file names
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
To: Henry Yei <hyei@mvista.com>
Cc: ltp-list@lists.sourceforge.net

On Mon, Aug 16, 2010 at 2:13 PM, Henry Yei <hyei@mvista.com> wrote:
> This patch modifies all tests in the ftest directory to =A0use
> MAXPATHLEN on all character arrays that store path/file names rather
> than arbitrarily sized arrays. This corrects issues where there was
> truncation happening when copying a path from one array to another if
> the path was long enough. The ftest code may delete the tmp directory
> instead of the tmp file due to truncation, and cause LTP to report a
> failure/warning when the tmp directory disappears. We saw this in
> ftest03,07 where it was trying to copy wdbuf[MAXPATHLEN] into fuss[40]
> here:
>
> =A0 =A0sprintf(fuss, "%s/ftest03.%d", getcwd(wdbuf, sizeof( wdbuf)), getp=
id());
>
> and then attempting to delete the file but instead got the directory here:
>
> =A0 =A0execl("/bin/rm", "rm", "-rf", fuss, NULL);

ACK.

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by =


Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
