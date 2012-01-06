Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Rj8Pw-0007Rr-O5
	for ltp-list@lists.sourceforge.net; Fri, 06 Jan 2012 11:57:04 +0000
Date: Fri, 6 Jan 2012 13:08:05 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120106120805.GA21376@saboteur.suse.cz>
References: <1325775471-19975-1-git-send-email-eguan@redhat.com>
	<1325775471-19975-4-git-send-email-eguan@redhat.com>
	<20120105154941.GE20860@saboteur.suse.cz>
	<20120106035408.GI30803@eguan-t400>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120106035408.GI30803@eguan-t400>
Subject: Re: [LTP] [PATCH v3 3/4] syscalls/setxattr02: new testcase to test
 setxattr(2)
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
To: Eryu Guan <eguan@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Yes, I know the difference, but 'char *file = "foo"' will generate a
> compiling error like:
> 
> setxattr02.c:88:3: error: initializer element is not constant
> setxattr02.c:88:3: error: (near initialization for ???tc[0].fname???)
> 
> So I used 'char file[] = "foo"'.
> 
> That turns out to be a limitation of the C language. Quote the spec
> 
> "All the expressions in an initializer for an object that has static
> storage duration shall be constant expressions or string literals."
> 
> Will macro be a better way? Like:
> #define FILENAME "setxattr02testfile"
> #define DIRNAME "setxattr02testdir"
> 

Ah, I see.

I think macros are better option here.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
