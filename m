Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OcMUc-00037f-04
	for ltp-list@lists.sourceforge.net; Fri, 23 Jul 2010 17:57:06 +0000
Received: from mail-gw0-f46.google.com ([74.125.83.46])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OcMUb-000696-6E
	for ltp-list@lists.sourceforge.net; Fri, 23 Jul 2010 17:57:05 +0000
MIME-Version: 1.0
In-Reply-To: <20100723171717.GA54890@medusa.sis.pasteur.fr>
References: <20100723171717.GA54890@medusa.sis.pasteur.fr>
Date: Fri, 23 Jul 2010 10:56:58 -0700
Message-ID: <AANLkTik=DJ+0NsMoD-ucZZtVrsaiBHeVEMmh-3GEixD+@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] abort01 testcase cleanup
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
To: Nicolas Joly <njoly@pasteur.fr>
Cc: LTP list <ltp-list@lists.sf.net>

On Fri, Jul 23, 2010 at 10:17 AM, Nicolas Joly <njoly@pasteur.fr> wrote:
>
> Hi,
>
> The attached patch do some cleanup in the abort01 testcase ...
>
> 1) The attempt to remove the generated core is wrong. The hard-coded
> =A0 `core' name is bad and the test temporary directory removal already
> =A0 take care of this.
>
> 2) Make the test fail gracefully if the running environment does not
> =A0 allow generating core files.
>
> njoly@lanfeust [syscalls/abort]> ./abort01
> abort01 =A0 =A0 1 =A0TPASS =A0: =A0Test passed
> njoly@lanfeust [syscalls/abort]> (ulimit -c 0 && ./abort01)
> abort01 =A0 =A0 1 =A0TCONF =A0: =A0core file size limit must be greater t=
han 0.
>
> Signed-off-by: Nicolas Joly <njoly@pasteur.fr>

Looks ok, but is there any particular reason why you removed the unlink(2) =
call?
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
