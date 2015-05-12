Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cuibixuan@huawei.com>) id 1Ys9fM-0000rN-LC
	for ltp-list@lists.sourceforge.net; Tue, 12 May 2015 12:52:08 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Ys9fG-0006tU-4m
	for ltp-list@lists.sourceforge.net; Tue, 12 May 2015 12:52:08 +0000
Message-ID: <5551F71E.7090400@huawei.com>
Date: Tue, 12 May 2015 20:50:38 +0800
From: Cui Bixuan <cuibixuan@huawei.com>
MIME-Version: 1.0
References: <20150504063425.GA9995@localhost.localdomain>
	<20150504115324.GB7674@rei.suse.de>
	<20150506135504.GC2752@localhost.localdomain>
In-Reply-To: <20150506135504.GC2752@localhost.localdomain>
Subject: Re: [LTP] [PATCH] performing test on loop device if noatime or
 relatime specified
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net, hanpt@linux.vnet.ibm.com


> +
> +		SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, MS_STRICTATIME, NULL);
> +		mount_flag =3D 1;
> +		SAFE_FILE_PRINTF(cleanup, TEST_FILE, TEST_FILE);
>  	}
Hi,
I run the LTP today:
.configure
make

then compile error:
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W -g -O2 -Wold-style-de=
finition -D_FORTIFY_SOURCE=3D2 -I/home/cuibixuan/home/git/ltp/ltp/testcases=
/kernel/include -I../../../../include -I../../../../include   -L../../../..=
/lib  open12.c   -lltp -o open12
open12.c: In function =91setup=92:
open12.c:103: error: =91MS_STRICTATIME=92 undeclared (first use in this fun=
ction)
open12.c:103: error: (Each undeclared identifier is reported only once
open12.c:103: error: for each function it appears in.)
make[4]: *** [open12] Error 1
make[4]: Leaving directory `/home/cuibixuan/home/git/ltp/ltp/testcases/kern=
el/syscalls/open'

Do 'man mount' and can not find 'MS_STRICTATIME'.

I get from man-pages of linux:
MS_STRICTATIME (since Linux 2.6.30)
              Always update the last access time (atime) when files on this
              filesystem are accessed.  (This was the default behavior
              before Linux 2.6.30.)  Specifying this flag overrides the
              effect of setting the MS_NOATIME and MS_RELATIME flags.

If not support 'MS_STRICTATIME'?
My system is SUSE11-SP2, linux 3.0.13, and gcc version 4.3.4.



---------------------------------------------------------------------------=
---
One dashboard for servers and applications across Physical-Virtual-Cloud =

Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
