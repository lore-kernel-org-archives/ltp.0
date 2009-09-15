Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Geert.Uytterhoeven@sonycom.com>) id 1MnZHJ-000444-7z
	for ltp-list@lists.sourceforge.net; Tue, 15 Sep 2009 14:45:09 +0000
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=pophost.sonytel.be) by 1b2kzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1MnZHF-0005GL-6o
	for ltp-list@lists.sourceforge.net; Tue, 15 Sep 2009 14:45:09 +0000
Date: Tue, 15 Sep 2009 16:45:03 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <4AA5085D.2060201@bull.net>
Message-ID: <alpine.LRH.2.00.0909151636280.14402@vixen.sonytel.be>
References: <4AA5085D.2060201@bull.net>
MIME-Version: 1.0
Subject: Re: [LTP] acl_test01 TestCase
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jacky Malcles <Jacky.Malcles@bull.net>
Cc: ltp-list@lists.sourceforge.net, jyoung5@us.ibm.com

On Mon, 7 Sep 2009, Jacky Malcles wrote:
> runltp can not run acl_test01 by default, we need a mounted partition =

> with ACL options.
> =

> To have acl_test01 started by runltp (or manually) without any acl aware
> partition,

> --- acl_test01.ori	2009-09-01 16:12:53.000000000 +0200
> +++ acl_test01	2009-09-01 16:12:39.000000000 +0200

> +mount | grep ext2
> +if [ $? !=3D 0 ] =

> +then
> +        mkfs -t ext3 /dev/loop0 #> /dev/null 2>&1
> +        mkdir  -m 777 tacl/mount-ext3
> +        mount -t ext3 -o defaults,acl,user_xattr /dev/loop0 tacl/mount-e=
xt3
> +        if [ $? !=3D 0 ]
> +        then
> +                echo ""
> +                echo "FAILED: [ mount ] Make sure that ACL (Access Contr=
ol List)"
> +                echo -e "\t and Extended Attribute are built into the ke=
rnel"
> +                echo -e "\t Can not mount ext3 file system with acl and =
user_xattr options"
> +                exit 1
> +        fi

Shouldn't this return success, with TCONF?

However, it seems mount doesn't fail when trying this on a kernel with
CONFIG_EXT3_FS_ACL=3Dn, so this is not a good way to detect the absence of =
the
ACL/XA feature.

With kind regards,

Geert Uytterhoeven
Software Architect
Techsoft Centre

Technology and Software Centre Europe
The Corporate Village =B7 Da Vincilaan 7-D1 =B7 B-1935 Zaventem =B7 Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 =B7 RPR Brussels
Fortis =B7 BIC GEBABEBB =B7 IBAN BE41293037680010

---------------------------------------------------------------------------=
---
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay =

ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
