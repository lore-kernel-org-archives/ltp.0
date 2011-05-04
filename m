Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1QHfMJ-0000l4-1e
	for ltp-list@lists.sourceforge.net; Wed, 04 May 2011 16:55:31 +0000
Received: from mail-vx0-f175.google.com ([209.85.220.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1QHfMI-0006vn-9n
	for ltp-list@lists.sourceforge.net; Wed, 04 May 2011 16:55:31 +0000
Received: by vxd7 with SMTP id 7so2185792vxd.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 04 May 2011 09:55:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1304500023-2657-1-git-send-email-yanpai.chen@gmail.com>
References: <1304500023-2657-1-git-send-email-yanpai.chen@gmail.com>
Date: Wed, 4 May 2011 09:55:24 -0700
Message-ID: <BANLkTik2ah048h5+9dQrG870hiaQHDXDHw@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] fix Makefiles for out of source tree build
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
To: Andrew Chen <yanpai.chen@gmail.com>
Cc: ltp-list@lists.sourceforge.net, andrew chen <ypchen@faraday-tech.com>

On Wed, May 4, 2011 at 2:07 AM, Andrew Chen <yanpai.chen@gmail.com> wrote:
> From: andrew chen <ypchen@faraday-tech.com>
>
> For out of source tree build, realtime_config.h is created under the
> top_builddir. Add it into the include path or you will get a missing
> file issue.
>
> Signed-off-by: Andrew Chen <ypchen@faraday-tech.com>

Committed with small adjustments to comments -- thanks!
-Garrett

------------------------------------------------------------------------------
WhatsUp Gold - Download Free Network Management Software
The most intuitive, comprehensive, and cost-effective network 
management toolset available today.  Delivers lowest initial 
acquisition cost and overall TCO of any competing solution.
http://p.sf.net/sfu/whatsupgold-sd
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
