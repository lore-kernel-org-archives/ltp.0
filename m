Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NzYQ6-0004My-5s
	for ltp-list@lists.sourceforge.net; Wed, 07 Apr 2010 16:48:02 +0000
Received: from mail-iw0-f183.google.com ([209.85.223.183])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NzYQ5-0008SV-By
	for ltp-list@lists.sourceforge.net; Wed, 07 Apr 2010 16:48:02 +0000
Received: by iwn13 with SMTP id 13so412629iwn.10
	for <ltp-list@lists.sourceforge.net>;
	Wed, 07 Apr 2010 09:47:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100407133918.GA20569@us.ibm.com>
References: <000401cad217$b1382d10$13a88730$@co.jp>
	<20100405132140.GB32049@us.ibm.com>
	<000901cad613$7d894030$789bc090$@co.jp>
	<20100407133918.GA20569@us.ibm.com>
Date: Wed, 7 Apr 2010 09:47:56 -0700
Message-ID: <x2o364299f41004070947sfd26d988p666317d87dce1f49@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] cap_bset_inh_bounds.c build failure
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
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: ltp-list@lists.sourceforge.net, Mitani <mitani@ryobi.co.jp>

On Wed, Apr 7, 2010 at 6:39 AM, Serge E. Hallyn <serue@us.ibm.com> wrote:
> Quoting Mitani (mitani@ryobi.co.jp):
>> Hi,

[...]

> Agreed, since this is LTP it's not right to expect "sane"
> userspace-kernel combos. =A0So we need to check both. =A0Unfortunately
> I won't have time to work with that this week.
>
> Even if I did, I'd have a guidance question for Garrett: =A0Do we
> want to assume that people will change kernels, but not libraries,
> between compile/install and run of ltp? =A0If so, then we can stick
> with the autoconf checks for libraries+includes, and add a check
> at runtime (as I believe was there originally) for the requisite
> kernel support - file capabilities, bounding sets, and 64-bit
> capabilities.

Assuming that kernels remain constant between compile and install
would be a nice thing to shoot for, but I personally on an embedded
project [for instance] have compiled LTP once, not had the major libs
change, but the kernel potentially changed, and then dropped in ltp
and voila.. it worked perfectly fine. With that in mind, yes..
breaking that assumption would be painful, as many packagers actually
compile and distribute one version of ltp as a package (debian for
instance is one said example).

> OTOH if you're ok with assuming kernel is same at ltp configure
> and run, then we can do a test in autoconf which makes for a cleaner
> run.

Yes, it's fine to have runtime tests. The point that I've tried to
make in the past (and partially failed) is that the following needs to
be kept in mind:

1. Groups can backport patches from kernel versions; thus using kernel
version checks to determine whether or not functionality A exists is
dubious. It's better just to compile the functionality in such a way
that the test works and let the group executing the test do so without
hacking the test.
2. Compiling at runtime is no bueno for almost everything in the
source tree. There are a handful of tests in the source tree that do
do that, but by and large this is a bad idea as we aren't guaranteed
to have a full compile toolchain on the running system -- only the
build system.

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
