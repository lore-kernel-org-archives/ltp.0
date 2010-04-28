Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1O707O-00031t-Pl
	for ltp-list@lists.sourceforge.net; Wed, 28 Apr 2010 05:47:30 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24]
	helo=mx01.colomx.prod.int.phx2.redhat.com)
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O707N-000136-P2
	for ltp-list@lists.sourceforge.net; Wed, 28 Apr 2010 05:47:30 +0000
Date: Wed, 28 Apr 2010 01:47:22 -0400 (EDT)
From: Caspar ZHANG <czhang@redhat.com>
Message-ID: <103530624.1121001272433642504.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1607411888.1120911272433367028.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] UTIMENSAT test fails hugely
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
Cc: ltp-list <ltp-list@lists.sf.net>


----- "Garrett Cooper" <yanegomi@gmail.com> wrote:
> 
> Almost there :). Some comments:
> 
> +	trap 'trap EXIT; teardown' EXIT
> 
> Should be:
> 
> +	trap 'trap "" EXIT; teardown' EXIT

Thanks for the tip :-) If I understood correctly, the EXIT 
signal is triggered when the program terminates(like after an
`exit' command). I find that resetting the signal to original
disposition and ignoring the signal have the same effect since
the program is always ready to terminate after finishing the
handler execution. Thus I think using `trap EXIT', `trap - EXIT'
and `trap "" EXIT' all work.

Cheers,
Caspar

> 
> The double quotes tell the shell to ignore all future signals trapped
> for the EXIT event (from bash(1)'s trap section, but the same also
> applies for ash(1), which is the predecessor to dash ):
> 
> ...
> 
> 									If arg is absent (and  there  is  a
>               single  sigspec)  or  -,  each  specified signal is
> reset to its
>               original disposition (the value it  had  upon  entrance 
> to  the
>               shell).   If arg is the null string the signal specified
> by each
>               sigspec is ignored by the shell and by the commands it 
> invokes.
> 
> ...
> 
> The `set' sed could be like this:
> 
> 	pattern="[[:space:]]*Defaults[[:space:]]*requiretty.*"
> 	sed -E -i "" -e "s/^($pattern)/#\1/" /etc/sudoers
> 
> The restore sed could be like this:
> 
> 	sed -E -i "" -e "s/^#($pattern)/\1/" /etc/sudoers
> 	# with $pattern being set like before.
> 
> Don't forget the ^ anchors and the quoting's important :).
> 
> >> 
> >> 	You may want to execute the handler before the setup call is
> invoked
> >> to ensure that everything done is properly undone in the event of
> a
> >> failure during setup.
> >> 	Also, watch out for cases where a user may have done:
> >> 
> >> # requiretty
> >> 
> >> instead of:
> >> 
> >> requiretty
> >> 
> >> 	It probably would be wise to preserve all leading and trailing
> >> characters for teardown to avoid inadvertently enabling requiretty
> in
> >> sudo.
> >> 	The EXIT trap handler isn't 100% foolproof, but it protects
> against
> >> all but SIGKILL or SIGSTOP from being executed as they're NMIs.
> 
> Cheers,
> -Garrett

-- 
Kernel Associate Quality Engineer
Red Hat Inc. (Beijing R&D Branch)

Red Hat China R&D Branch Unit 907, North Tower C, 
  Raycom Infotech Park, No.2 Kexueyuan Nanlu, 
  Haidian District, Beijing 100190

TEL: +86-10-62608150
Web: http://www.redhat.com/

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
