Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PQFmR-0001wx-CK
	for ltp-list@lists.sourceforge.net; Wed, 08 Dec 2010 08:53:43 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PQFmQ-0005VB-Kl
	for ltp-list@lists.sourceforge.net; Wed, 08 Dec 2010 08:53:43 +0000
Received: by wwi18 with SMTP id 18so840795wwi.10
	for <ltp-list@lists.sourceforge.net>;
	Wed, 08 Dec 2010 00:53:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <531179765.253021291706934211.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
References: <91982603.253001291706928092.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<531179765.253021291706934211.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Date: Wed, 8 Dec 2010 00:53:36 -0800
Message-ID: <AANLkTi=ZyjribNfx+eqZQNieipodkXJCMRxuvh6o4G=h@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH v7] functional testing for Kernel Samepage Merging
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
To: caiqian@redhat.com
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Mon, Dec 6, 2010 at 11:28 PM,  <caiqian@redhat.com> wrote:
> Basic tests were to start several programs with same and different
> memory contents and ensure only to merge the ones with the same
> contents. When changed the content of one of merged pages in a
> process and to the mode "unmerging", it should discard all merged
> pages there. Also tested it is possible to disable KSM. There are
> also command-line options to specify the memory allocation size, and
> number of processes have same memory contents so it is possible to
> test more advanced things like KSM + OOM etc. KSM statistics numbers
> look like hard to predict, so only check the ranges.

Committed.

------------------------------------------------------------------------------
What happens now with your Lotus Notes apps - do you make another costly 
upgrade, or settle for being marooned without product support? Time to move
off Lotus Notes and onto the cloud with Force.com, apps are easier to build,
use, and manage than apps on traditional platforms. Sign up for the Lotus 
Notes Migration Kit to learn more. http://p.sf.net/sfu/salesforce-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
