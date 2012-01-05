Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RipOw-0002o1-Mu
	for ltp-list@lists.sourceforge.net; Thu, 05 Jan 2012 15:38:46 +0000
Date: Thu, 5 Jan 2012 16:49:41 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120105154941.GE20860@saboteur.suse.cz>
References: <1325775471-19975-1-git-send-email-eguan@redhat.com>
	<1325775471-19975-4-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1325775471-19975-4-git-send-email-eguan@redhat.com>
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
> +#include "test.h"
> +#include "usctest.h"
> +
> +#define XATTR_TEST_KEY "user.testkey"
> +#define XATTR_TEST_VALUE "this is a test value"
> +#define XATTR_TEST_VALUE_SIZE 20
> +
> +static void setup(void);
> +static void cleanup(void);
> +
> +char *TCID = "setxattr02";
> +
> +char file[] = "setxattr02testfile";
> +char dir[] = "setxattr02testdir";
> +char sym[] = "setxattr02symlink";
> +char fifo[] = "setxattr02fifo";
> +char chr[] = "setxattr02chr";
> +char blk[] = "setxattr02blk";
> +char sock[] = "setxattr02sock";

Just to be extra correct here, there is a difference between

char *var = "foo";

and 

char var[] = "foo";

The first one is const and thus not modifiable while the second
is an array and as a such it may be modified at the runtime.

I think we should rather use *var = "foo" here.

Also I tend to declare global variables static as that way compiler
prints warning when they became unused.

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
