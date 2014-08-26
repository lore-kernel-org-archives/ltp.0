Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XMCYA-0002ZC-VR
	for ltp-list@lists.sourceforge.net; Tue, 26 Aug 2014 08:56:22 +0000
Date: Tue, 26 Aug 2014 10:55:19 +0200
From: chrubis@suse.cz
Message-ID: <20140826085518.GA25390@rei.suse.cz>
References: <d00e2fbc8b2b96403e841845b3df25104dada721.1408543124.git.jstancek@redhat.com>
	<20140820143252.GA23782@rei>
	<290231308.10805374.1408632310290.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <290231308.10805374.1408632310290.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH/RFC] profil01: don't use address of function
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
Cc: ltp-list@lists.sourceforge.net

Hi!
> I think it was introduced in 90s, though not every architecture supported
> it at first.
> 
> I see it in very first release of clang 1.0 sources:
> ./src/gcc/builtins.def:DEF_GCC_BUILTIN
>         (BUILT_IN_RETURN_ADDRESS, "return_address", BT_FN_PTR_UNSIGNED, ATTR_NULL)
> but I didn't try to compile it with that.
> 
> > 
> > If we are in doubt, we should add a configure check and use it only when
> > available. And probably to default to &test_profil in all cases but
> > ppc64 BE which is known to fail.
> 
> I'm trying one other idea:
> 
> +static inline void *get_pc(void)
> +{
> +       extern void *profil01_label;
> +
> +       asm("profil01_label:");
> +       return &profil01_label;
> +}

It looks like I've accidentally deleted your reply to this email, sorry.

As both methods (the one with builtin and the one with asm()) seems to
work fine, feel free to proceed with either one of them.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
