Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SGAI6-0003oF-DC
	for ltp-list@lists.sourceforge.net; Fri, 06 Apr 2012 14:37:30 +0000
Received: from mail-pz0-f46.google.com ([209.85.210.46])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SGAI5-0003Zj-Ad
	for ltp-list@lists.sourceforge.net; Fri, 06 Apr 2012 14:37:30 +0000
Received: by mail-pz0-f46.google.com with SMTP id z9so3386425dad.33
	for <ltp-list@lists.sourceforge.net>;
	Fri, 06 Apr 2012 07:37:29 -0700 (PDT)
Message-ID: <4F7EFFA2.6060105@casparzhang.com>
Date: Fri, 06 Apr 2012 22:37:22 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <4F58E36E.5000306@casparzhang.com>
In-Reply-To: <4F58E36E.5000306@casparzhang.com>
Subject: Re: [LTP] [RFC] make mce-test a submodule
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
To: LTP list <ltp-list@lists.sourceforge.net>

On 03/09/2012 12:50 AM, Caspar Zhang wrote:
> Hi Garrett, Andi, and all:
> 
> When I looked into current LTP tree, I found it a little messy due to
> some mce-test stuff, such as
> 
>   - mce-test docs goes to $TOPDIR/README, and
>   - some mce-test files still lying under testcase/mce-test/.
> 
> I think we need a cleanup for it.
> 
> Also an idea comes to my mind, that we can try to make mce-test a
> submodule of LTP.
> 
> I am also thinking about the pros and cons:
> 
> pro(s):
>   - easier for code maintenance, no need to sync periodically from
> maintainer side
> 
> con(s):
>   - two extra steps added for LTP users, they have to do:
>     $ git submodule init
>     $ git submodule update
> to enable using mce-test.
> 
> mce-test could no longer be found at kernel.org, so I cloned it from
> Andi's github repo, not sure if it is the right place:
> 
>     git://github.com/andikleen/mce-test.git
> 
> I have made this change to my personal LTP fork, you can review it here:
> 
>     https://github.com/casparant/ltp/commit/5cca17f633
> 
> Any comments are welcomed.
> 
> Thanks,
> Caspar

Thanks all for reviewing this change. Patch merged.

Caspar

------------------------------------------------------------------------------
For Developers, A Lot Can Happen In A Second.
Boundary is the first to Know...and Tell You.
Monitor Your Applications in Ultra-Fine Resolution. Try it FREE!
http://p.sf.net/sfu/Boundary-d2dvs2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
