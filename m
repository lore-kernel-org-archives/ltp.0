Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1NmW0d-0002Jk-1K
	for ltp-list@lists.sourceforge.net; Tue, 02 Mar 2010 17:35:51 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NmW0a-00080K-NV
	for ltp-list@lists.sourceforge.net; Tue, 02 Mar 2010 17:35:50 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o22HR0cV012461
	for <ltp-list@lists.sourceforge.net>; Tue, 2 Mar 2010 10:27:00 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o22HZeHa112278
	for <ltp-list@lists.sourceforge.net>; Tue, 2 Mar 2010 10:35:40 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o22HZaPB009905
	for <ltp-list@lists.sourceforge.net>; Tue, 2 Mar 2010 10:35:38 -0700
Date: Tue, 2 Mar 2010 11:35:35 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100302173535.GA14556@us.ibm.com>
References: <OF3DD1AE6A.65D45C56-ON652576DA.002F585D-652576DA.00384F54@in.ibm.com>
	<20100302152135.GA6691@us.ibm.com>
	<B02F7096-7406-4AAE-8BBF-AD16D5228F47@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <B02F7096-7406-4AAE-8BBF-AD16D5228F47@gmail.com>
Subject: Re: [LTP] LTP's filecaps test gives false positive results
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: Rishikesh K Rajak <risrajak@in.ibm.com>, Iranna D Ankad <iranna.ankad@in.ibm.com>, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Quoting Garrett Cooper (yanegomi@gmail.com):
> Sent from my iPhone
> 
> On Mar 2, 2010, at 7:21 AM, "Serge E. Hallyn" <serue@us.ibm.com> wrote:
> 
> >Quoting Iranna D Ankad (iranna.ankad@in.ibm.com):
> >>LTP reports setcap is installed, but actually, my system has setcap
> >>installed, along with all required libcap related rpms.
> >>
> >>mx3950:/opt/ltp # setc
> >>setcap      setconsole  setctsid
> >>mx3950:/opt/ltp #
> >>
> >>mx3950:/opt/ltp # rpm -qa | grep cap
> >>libcap1-1.10-6.10
> >>libcap2-2.11-2.15
> >>libcap-progs-2.11-2.15
> >>libpcap0-0.9.8-50.4.32
> >>libcap2-32bit-2.11-2.15
> >>libcap1-32bit-1.10-6.10
> >>mx3950:/opt/ltp #
> >
> >THere are a bunch of #if directives in there (only looked at
> >check_simple_capset.c which I assume is where your trouble is) which
> >are not defined on my fedora 10 test system.  Don't know where they
> >came from - they predate the git history.
> >
> >HAVE_SYS_CAPABILITY_H, HAVE_DECL_CAP_FROM_TEXT, etc.
> >
> >-serge
> 
> That would be from me; I do that via autoconf and they probably
> fubared the headers on Redhat or something... Do you have

Oh, ok.  Well I suspect we can ditch the check_simple_capset.c
altogether if autoconf is (eventually :) doing the detection for
us.  The only point of check_simple_capset.c was to check whether
libcap is there and whether we should run the real tests.

> libcap-devel installed?

yup:

[root@oracer4b ltp-dev]# rpm -qa|grep libcap
libcap-2.10-2.fc10.x86_64
libcap-devel-2.10-2.fc10.x86_64

[root@oracer4b ltp-dev]# grep CAP_LIB *
config.log:CAP_LIBS=''
config.status:S["CAP_LIBS"]=""
configure:CAP_LIBS'
configure:					CAP_LIBS="-lcap"

so somehow -lcap was not detected by configure?

> Fwiw, that probably could be grossly simplified at the top of the
> file or something, do I'll look into doing that later.

Thanks

-serge

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
