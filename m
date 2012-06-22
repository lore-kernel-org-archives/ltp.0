Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1Shu07-0001Fv-4j
	for ltp-list@lists.sourceforge.net; Fri, 22 Jun 2012 02:53:35 +0000
Received: from mail-ob0-f175.google.com ([209.85.214.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Shu06-0007nS-Ci
	for ltp-list@lists.sourceforge.net; Fri, 22 Jun 2012 02:53:35 +0000
Received: by obcva7 with SMTP id va7so1356016obc.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 21 Jun 2012 19:53:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4FE2CCE3.1030500@windriver.com>
References: <4FE2CCE3.1030500@windriver.com>
Date: Thu, 21 Jun 2012 19:53:28 -0700
Message-ID: <CAGH67wTJ1Ya76eAWoUd-wy=Lg2xy+ShvtRG-3AP4V65goSaEAQ@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [bug report] a typo in runltp script
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
To: "Li, Jin" <Jin.Li@windriver.com>
Cc: ltp-list@lists.sourceforge.net

On Thu, Jun 21, 2012 at 12:27 AM, Li, Jin <Jin.Li@windriver.com> wrote:
> Hi,
>
> When I use runltp with the option [-b DEVICE], notice the typo as follows:
>
> sed -i "" -e "s|DEVICE_FS_TYPE|$DEVICE_FS_TYPE|" =A0${TMP}/alltests
>
> The runltp will hit error and exit.
>
> Is it a typo or I miss something else ?

    It wasn't an intentional "typo". It's an inconsistency between BSD
sed and GNU sed (something that irritates me from time to time). The
above form works with BSD sed.
    Replacing `-i ""` with `-i '.bk'` should work.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and =

threat landscape has changed and how IT managers can respond. Discussions =

will include endpoint security, mobile security and the latest in malware =

threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
