Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NSOrb-0007No-7F
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 05:55:23 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NSOra-0005MX-9z
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 05:55:23 +0000
Received: by pwj11 with SMTP id 11so11812425pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Tue, 05 Jan 2010 21:55:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B42F101.2070009@cn.fujitsu.com>
References: <4B42F101.2070009@cn.fujitsu.com>
Date: Tue, 5 Jan 2010 21:55:16 -0800
Message-ID: <364299f41001052155p497ec20bo65198ada7d35a114@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] cpuset: fix a lost compile target in Makefile
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
To: Shi Weihua <shiwh@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Mon, Jan 4, 2010 at 11:57 PM, Shi Weihua <shiwh@cn.fujitsu.com> wrote:
> In latest ltp version, the following message occured when run the case of=
 cpuset.
> -----
> ./cpuset_hotplug_test.sh: line 39: ./cpuset_list_compute: No such file or=
 directory
> ./cpuset_hotplug_test.sh: line 227: ./cpuset_list_compute: No such file o=
r directory
> -----
>
> The reason is that cpuset_list_compute.c(in testcases/kernel/controllers/=
cpuset/
> cpuset_hotplug_test/) has not been compiled.
> This patch fix it.
>
> Signed-off-by: Shi Weihua <shiwh@cn.fujitsu.com>
> ---
> --- ltp-intermediate-20091209.orig/testcases/kernel/controllers/cpuset/cp=
uset_hotplug_test/Makefile =A0 =A0 2009-12-09 02:48:49.000000000 -0500
> +++ ltp-intermediate-20091209/testcases/kernel/controllers/cpuset/cpuset_=
hotplug_test/Makefile =A02010-01-05 10:53:55.000000000 -0500
> @@ -25,6 +25,6 @@ top_srcdir =A0 =A0 =A0 =A0 =A0 =A0 =A0?=3D ../../../../.
> =A0include $(top_srcdir)/include/mk/testcases.mk
> =A0include $(abs_srcdir)/../Makefile.inc
>
> -MAKE_TARGETS =A0 =A0 =A0 =A0 =A0 :=3D
> +LDLIBS =A0 =A0 =A0 =A0 +=3D -lpthread
>
> =A0include $(top_srcdir)/include/mk/generic_leaf_target.mk

Committed -- thanks!
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
