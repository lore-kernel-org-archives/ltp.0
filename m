Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1OpB76-0006jg-O5
	for ltp-list@lists.sourceforge.net; Sat, 28 Aug 2010 02:25:48 +0000
Received: from mail-qw0-f47.google.com ([209.85.216.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OpB75-0000aE-O1
	for ltp-list@lists.sourceforge.net; Sat, 28 Aug 2010 02:25:48 +0000
Received: by qwa26 with SMTP id 26so1372586qwa.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 27 Aug 2010 19:25:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1282647757.4833.7.camel@subratamodak.linux.ibm.com>
References: <52CF90264091A14888078A031D780F43064456F9@ism-mail03.corp.ad.wrs.com>
	<1282647757.4833.7.camel@subratamodak.linux.ibm.com>
From: Henry Yei <hyei@mvista.com>
Date: Fri, 27 Aug 2010 19:25:22 -0700
Message-ID: <AANLkTimM3YR5ArZgBG+s2mwW5fMWpYEXfahHSLUgSFjR@mail.gmail.com>
Subject: Re: [LTP] Rt_sigprocmask01 test case caused "segment fault" on x86
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net, "Fu, Yingang" <Yingang.Fu@windriver.com>

Subrata,


I do not see this patch committed in the ltp-dev git tree on
sourceforge. Perhaps I am looking in the wrong place?

Henry Yei <hyei@mvista.com>





On Tue, Aug 24, 2010 at 4:02 AM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
> On Wed, 2010-08-18 at 13:22 +0200, Fu, Yingang wrote:
>> hi, Garrett
>>
>> This is a similar problem as rt_sigsuspend01 which has been fix
>> before.
>>
>> Failed log:
>>
>> root@Congatec:/opt/ltp-full> ./testcases/bin/rt_sigprocmask01
>> Segmentation fault
>>
>> After apply the patch:
>> root@ Congregate:/opt/ltp-full> ./testcases/bin/rt_sigprocmask01
>> rt_sigprocmask01 =A0 =A01 =A0TPASS =A0: =A0rt_sigprocmask functionality =
passed
>>
>> Signed-off-by: Yingang Fu <yingang.fu@windriver.com>
>
> Thanks. Applied.
>
> Regards--
> Subrata
>
>>
>> Thanks
>> Yingang
>> ------------------------------------------------------------------------=
------
>> This SF.net email is sponsored by
>>
>> Make an app they can't live without
>> Enter the BlackBerry Developer Challenge
>> http://p.sf.net/sfu/RIM-dev2dev
>> _______________________________________________ Ltp-list mailing list Lt=
p-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/l=
tp-list
>
>
> -------------------------------------------------------------------------=
-----
> Sell apps to millions through the Intel(R) Atom(Tm) Developer Program
> Be part of this innovative community and reach millions of netbook users
> worldwide. Take advantage of special opportunities to increase revenue and
> speed time-to-market. Join now, and jumpstart your future.
> http://p.sf.net/sfu/intel-atom-d2d
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>

---------------------------------------------------------------------------=
---
Sell apps to millions through the Intel(R) Atom(Tm) Developer Program
Be part of this innovative community and reach millions of netbook users =

worldwide. Take advantage of special opportunities to increase revenue and =

speed time-to-market. Join now, and jumpstart your future.
http://p.sf.net/sfu/intel-atom-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
