Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1O2Kgy-0005wa-Cq
	for ltp-list@lists.sourceforge.net; Thu, 15 Apr 2010 08:44:56 +0000
Received: from mail-iw0-f182.google.com ([209.85.223.182])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O2Kgv-0003as-BU
	for ltp-list@lists.sourceforge.net; Thu, 15 Apr 2010 08:44:56 +0000
Received: by iwn12 with SMTP id 12so530558iwn.24
	for <ltp-list@lists.sourceforge.net>;
	Thu, 15 Apr 2010 01:44:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100415065603.GB6261@linux.vnet.ibm.com>
References: <000401cad217$b1382d10$13a88730$@co.jp>
	<20100405132140.GB32049@us.ibm.com>
	<002201cadc47$24c528d0$6e4f7a70$@co.jp>
	<20100415065603.GB6261@linux.vnet.ibm.com>
Date: Thu, 15 Apr 2010 01:44:48 -0700
Message-ID: <k2u364299f41004150144i99db2243o1d8326e443780775@mail.gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mitani <mitani@ryobi.co.jp>, "Serge E. Hallyn" <serue@us.ibm.com>, ltp-list@lists.sourceforge.net, kamimura@ryobi.co.jp

On Wed, Apr 14, 2010 at 11:56 PM, Rishikesh K Rajak
<risrajak@linux.vnet.ibm.com> wrote:
> On Thu, Apr 15, 2010 at 11:55:44AM +0900, Mitani wrote:
>> Sorry.
>> My patch was destroyed by e-mail.
>> I attach patch for "cap_bset_inh_bounds.c" file.
>
> Will test and update to master by this weekend. It seems it has been already
> acked by serge.

    I agree with Serge as it's a pretty obvious compile error if
HAVE_SYS_CAPABILITY_H isn't defined.
-Garrett

Acked-by: Garrett Cooper <yanegomi@gmail.com>

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
