Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1P2lP0-0001eQ-3x
	for ltp-list@lists.sourceforge.net; Mon, 04 Oct 2010 13:48:26 +0000
Received: from mail-gx0-f174.google.com ([209.85.161.174])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P2lOz-0000bi-2U
	for ltp-list@lists.sourceforge.net; Mon, 04 Oct 2010 13:48:26 +0000
MIME-Version: 1.0
In-Reply-To: <4CA9D1B2.7070107@suse.de>
References: <4CA9D1B2.7070107@suse.de>
Date: Mon, 4 Oct 2010 06:48:19 -0700
Message-ID: <AANLkTinZCKnwAofMwYU9iVsVog8K4TFxLttsfH5QL2e1@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] patch to define PTRACE_KILL and PTRACE_CONT
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
To: Yi Xu <yxu@suse.de>
Cc: ltp-list@lists.sf.net

On Mon, Oct 4, 2010 at 6:08 AM, Yi Xu <yxu@suse.de> wrote:
> Hi,
>
> this patch solves compiling error that appears with certain GCC version.

Hi Yi,

You most likely need to fix your headers or your compiler:

[gcooper@bayonetta /scratch/ltp]$ grep -r __PTRACE_KILL__ .
[gcooper@bayonetta /scratch/ltp]$ grep -r __PTRACE_CONT__ .
[gcooper@bayonetta /scratch/ltp]$

Nowhere in the sourcebase are those symbols defined / used (at least
not directly).

Furthermore, rwatson@'s search indexer returns NIL for the symbol:

http://fxr.watson.org/fxr/trackident?v=linux-2.6;i=__PTRACE_KILL__

If you provided your error logs we might be able to help you...

Thanks,
-Garrett

------------------------------------------------------------------------------
Virtualization is moving to the mainstream and overtaking non-virtualized
environment for deploying applications. Does it make network security 
easier or more difficult to achieve? Read this whitepaper to separate the 
two and get a better understanding.
http://p.sf.net/sfu/hp-phase2-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
