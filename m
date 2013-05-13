Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1Ubnd3-0000N7-Bp
	for ltp-list@lists.sourceforge.net; Mon, 13 May 2013 07:57:05 +0000
Received: from mail-da0-f48.google.com ([209.85.210.48])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Ubnd2-0000W8-I5
	for ltp-list@lists.sourceforge.net; Mon, 13 May 2013 07:57:05 +0000
Received: by mail-da0-f48.google.com with SMTP id h32so2170012dak.21
	for <ltp-list@lists.sourceforge.net>;
	Mon, 13 May 2013 00:56:58 -0700 (PDT)
Message-ID: <51909CD7.9050408@casparzhang.com>
Date: Mon, 13 May 2013 15:57:11 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <83efca15b955541cfdd6a0d7a07bd303381e5ed4.1368177082.git.zliu@redhat.com>
In-Reply-To: <83efca15b955541cfdd6a0d7a07bd303381e5ed4.1368177082.git.zliu@redhat.com>
Subject: Re: [LTP] [PATCH 1/3] mm/ksm: set the merge_across_nodes knob
 before testing
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

On 05/10/2013 05:13 PM, Zhouping Liu wrote:
> +		/*
> +		 * Save the current value of merge_across_nodes knob,
> +		 * and make it perform as the default behavior.
> +		 */

This comment is unnecessary. it's not difficult to know it's a 
save/recover operation. I think you can remove it or give a short 
comment of where does this new sysfile come from (e.g. kernel ver/commit 
id, etc)

Caspar

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and 
their applications. This 200-page book is written by three acclaimed 
leaders in the field. The early access version is available now. 
Download your free book today! http://p.sf.net/sfu/neotech_d2d_may
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
