Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1UGMKS-0001WP-KP
	for ltp-list@lists.sourceforge.net; Fri, 15 Mar 2013 04:33:16 +0000
Received: from mail-pb0-f41.google.com ([209.85.160.41])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UGMKN-0001wC-VN
	for ltp-list@lists.sourceforge.net; Fri, 15 Mar 2013 04:33:16 +0000
Received: by mail-pb0-f41.google.com with SMTP id um15so3278471pbc.14
	for <ltp-list@lists.sourceforge.net>;
	Thu, 14 Mar 2013 21:33:05 -0700 (PDT)
Message-ID: <5142A491.3020107@casparzhang.com>
Date: Fri, 15 Mar 2013 12:33:21 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <2046829337.8696311.1363319824336.JavaMail.root@redhat.com>
In-Reply-To: <2046829337.8696311.1363319824336.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH 2/5] mm/oom02: modified 'OOM for NUMA' as 'OOM for
 mempolicy'
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
To: Zhouping Liu <zliu@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 03/15/2013 11:57 AM, Zhouping Liu wrote:
>> >you've moved all mempolicy check stuff to testoom(), so you can
>> >completely remove this variable.
> I'm not sure which variable you mean, pid and status variable? but they are needed.
>
never mind, I see the 4/5 patch that removed this variable :)

Caspar

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
