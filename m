Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NndeB-00075n-Ou
	for ltp-list@lists.sourceforge.net; Fri, 05 Mar 2010 19:57:19 +0000
Received: from mail-px0-f199.google.com ([209.85.216.199])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NndeA-0000He-HA
	for ltp-list@lists.sourceforge.net; Fri, 05 Mar 2010 19:57:19 +0000
MIME-Version: 1.0
In-Reply-To: <A69FA2915331DC488A831521EAE36FE4016A4F5195@dlee06.ent.ti.com>
References: <A69FA2915331DC488A831521EAE36FE4016A4F5195@dlee06.ent.ti.com>
Date: Fri, 5 Mar 2010 11:57:11 -0800
Message-ID: <364299f41003051157h5ac36e43pd6aab7478850b7fe@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] LTP compile errors
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "Gaur, Alok" <a-gaur2@ti.com>
Cc: "ltp-list@lists.sf.net" <ltp-list@lists.sf.net>

On Fri, Mar 5, 2010 at 7:42 AM, Gaur, Alok <a-gaur2@ti.com> wrote:
> Hi,
>
> I am trying to compile LTP using my ubuntu machine and get the errors as in
> the error_logs file attached herewith. Please help to resolve this issue. I
> have attached config.mk.in, config.h.in and config.log also. If any think
> else also required to debug this issue please let me know.

Your toolchain is broken:

configure:2849: checking for C compiler default output file name
configure:2871: gcc    conftest.c  >&5
/usr/bin/ld: crt1.o: No such file: No such file or directory
collect2: ld returned 1 exit status

Thanks,
-Garrett

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
