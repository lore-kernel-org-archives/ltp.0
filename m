Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1S5TQe-0008Rn-8c
	for ltp-list@lists.sourceforge.net; Thu, 08 Mar 2012 02:50:08 +0000
Received: from mail-tul01m020-f175.google.com ([209.85.214.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1S5TQd-00047Q-Hg
	for ltp-list@lists.sourceforge.net; Thu, 08 Mar 2012 02:50:08 +0000
Received: by obqv19 with SMTP id v19so55536obq.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 07 Mar 2012 18:50:01 -0800 (PST)
Message-ID: <4F581E1B.60208@casparzhang.com>
Date: Thu, 08 Mar 2012 10:48:59 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <4F578418.2060100@redhat.com>
In-Reply-To: <4F578418.2060100@redhat.com>
Subject: Re: [LTP] [PATCH] getrusage04: initialise [us]last to current values
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net, Jeffrey Burke <jburke@redhat.com>

On 03/07/2012 11:51 PM, Jan Stancek wrote:
> 
> On slower machines, startup can take some time,
> set last values to current [us]time before actual test.
> 
> This caused test to fail, because first delta contained
> time spent by test starting up:
> getrusage04    0  TINFO  :  utime:         999us; stime:        6998us
> getrusage04    0  TINFO  :  utime:         999us; stime:        6998us
> getrusage04    1  TFAIL  :  stime increased > 1000us: delta = 6998us
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>   testcases/kernel/syscalls/getrusage/getrusage04.c |    4 +++-
>   1 files changed, 3 insertions(+), 1 deletions(-)

Hi Jan, committed.

Thanks,
Caspar

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
