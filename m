Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Npa3q-0001z7-Fx
	for ltp-list@lists.sourceforge.net; Thu, 11 Mar 2010 04:31:50 +0000
Received: from mail-iw0-f191.google.com ([209.85.223.191])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Npa3p-000322-JR
	for ltp-list@lists.sourceforge.net; Thu, 11 Mar 2010 04:31:50 +0000
Received: by iwn29 with SMTP id 29so5289795iwn.10
	for <ltp-list@lists.sourceforge.net>;
	Wed, 10 Mar 2010 20:31:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <001901cac0d2$697152a0$3c53f7e0$@co.jp>
References: <001901cac0d2$697152a0$3c53f7e0$@co.jp>
Date: Wed, 10 Mar 2010 20:31:44 -0800
Message-ID: <364299f41003102031j2e659d19o2e245bdf9f56d431@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] fixing memcg_control
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
To: Yuki Yao <y_yao@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

On Wed, Mar 10, 2010 at 8:22 PM, Yuki Yao <y_yao@ryobi.co.jp> wrote:
> Hi,
>
> I found following problem about "memcg_control" test.
> ---------
> /opt/ltp/testcases/bin/memcg_control_test.sh: line 30: [: : integer
> expression expected
> ----------
>
> This happens because of following process.
> [ memcg_control_test.sh: line 30 ]
> ---------
> if [ "$(grep -w memory /proc/cgroups | cut -f4)" -ne "1" ]; then
> =A0 =A0 =A0 =A0echo "WARNING:"
> =A0 =A0 =A0 =A0echo "Either kernel does not support memory resource contr=
oller or
> feature not ena bled"
> =A0 =A0 =A0 =A0echo "Skipping all memcg_control testcases...."
> =A0 =A0 =A0 =A0exit 0
> fi
> ---------
>
> "$(grep -w memory /proc/cgroups | cut -f4)" can't comparable with "1"
> if "$(grep -w memory /proc/cgroups | cut -f4)" =3D nothing.
>
> How about fixing like the other "memcg" tests?
>
> Signed-off-by: Yuki Yao<y_yao@ryobi.co.jp>
>
> Index: ./testcases/kernel/controllers/memcg/control/memcg_control_test.sh
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> ---
> /home/LTP/ltp-dev-20100311/testcases/kernel/controllers/memcg/control/mem=
cg_
> control_test.sh.org =A0 =A0 2010-03-11 11:31:07.000000000 +0900
> +++
> /home/LTP/ltp-dev-20100311/testcases/kernel/controllers/memcg/control/mem=
cg_
> control_test.sh 2010-03-11 11:32:21.000000000 +0900
> @@ -27,7 +27,7 @@
> =A0##
> ##
>
> #########################################################################=
###
> ####
>
> -if [ "$(grep -w memory /proc/cgroups | cut -f4)" -ne "1" ]; then
> +if [ "x$(grep -w memory /proc/cgroups | cut -f4)" !=3D "x1" ]; then
> =A0 =A0 =A0 =A0echo "WARNING:"
> =A0 =A0 =A0 =A0echo "Either kernel does not support memory resource contr=
oller or
> feature not enabled"
> =A0 =A0 =A0 =A0echo "Skipping all memcg_control testcases...."

Ack, I knew I missed a spot. Committed...
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
