Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NpZrU-0006sv-CY
	for ltp-list@lists.sourceforge.net; Thu, 11 Mar 2010 04:19:04 +0000
Received: from mail-iw0-f176.google.com ([209.85.223.176])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NpZrT-0003xK-Lo
	for ltp-list@lists.sourceforge.net; Thu, 11 Mar 2010 04:19:04 +0000
Received: by iwn6 with SMTP id 6so5640501iwn.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 10 Mar 2010 20:18:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1268244692.10784.6.camel@lucio-t400>
References: <1268244692.10784.6.camel@lucio-t400>
Date: Wed, 10 Mar 2010 20:18:58 -0800
Message-ID: <364299f41003102018j1a334006rd6a0752eddd7f670@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [patch] Fixing cpuacct_setup.sh script
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
To: ljhc@br.ibm.com
Cc: ltp-list@lists.sourceforge.net

On Wed, Mar 10, 2010 at 10:11 AM, Lucio Correia <ljhc@br.ibm.com> wrote:
> Fixes cut command. The output is empty with -f1, it should be -f2.
>
> Signed-off-By: Lucio Correia <ljhc@br.ibm.com>
>
> diff -Nurp ltp-full-20100228.orig/testcases/kernel/controllers/cpuacct/cp=
uacct_setup.sh ltp-full-20100228.new/testcases/kernel/controllers/cpuacct/c=
puacct_setup.sh
> --- ltp-full-20100228.orig/testcases/kernel/controllers/cpuacct/cpuacct_s=
etup.sh =A0 =A0 =A0 =A02010-03-01 11:58:28.000000000 -0300
> +++ ltp-full-20100228.new/testcases/kernel/controllers/cpuacct/cpuacct_se=
tup.sh 2010-03-10 14:59:50.000000000 -0300
> @@ -58,7 +58,7 @@ cleanup ()
> =A0}
> =A0task_kill ()
> =A0{
> - =A0 =A0 =A0 for i in `ps -e | grep cpuacct_taski* | cut -d" " -f1`
> + =A0 =A0 =A0 for i in `ps -e | grep cpuacct_taski* | cut -d" " -f2`
> =A0 =A0 =A0 =A0do
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kill -SIGUSR1 $i
> =A0 =A0 =A0 =A0done

    That may fix it on your distro, but it's not guaranteed to be
portable as different versions of ps(1) do different things. A better
idea than the one proposed above would be:

    ps -eo 'pid,command' | grep cpuacct_taski | grep -v grep

    Jiri may have a better idea of what to do in this case...
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
