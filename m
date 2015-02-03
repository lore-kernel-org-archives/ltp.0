Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YIcwq-0001z5-4B
	for ltp-list@lists.sourceforge.net; Tue, 03 Feb 2015 12:51:20 +0000
Date: Tue, 3 Feb 2015 13:51:05 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150203125105.GA15523@rei.scz.novell.com>
References: <54D08FAC.5010601@linux.vnet.ibm.com>
	<20150203093752.GA4264@rei.scz.novell.com>
	<1501572527.5689680.1422957604905.JavaMail.zimbra@redhat.com>
	<2062151122.5724081.1422960324625.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2062151122.5724081.1422960324625.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] proposed patch to fix sendmsg01 invalid flags set w/
 control ; returned -1 (expected -1), errno 22 (expected 95)
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
Cc: ltp-list@lists.sourceforge.net, Chuck Ebbert <cebbert.lkml@gmail.com>

Hi!
> > >     recvfrom01: fix test for invalid message flags
> > 
> > Agreed. We have seen in past, that this (.flags = ~MSG_CMSG_COMPAT)
> > leads to undefined behavior.
> 
> It appears the difference comes from LTP:
>   https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/utils/msg_common.h
> 
> The flags has 0 value when compiled with -m32, so we never make it pass
> this check:
>   if (flags & MSG_CMSG_COMPAT)
>       return -EINVAL;
> 
> but the kernel definition is rather based on config option:
>   #if defined(CONFIG_COMPAT)
>   #define MSG_CMSG_COMPAT 0x80000000      /* This message needs 32 bit fixups */
>   #else
>   #define MSG_CMSG_COMPAT 0               /* We never have 32 bit fixups */
>   #endif

Tricky.

But looking into the unix_dgram_sendmsg() which should be the one that
gets called in the particular case, the code realy just checks for the
MSG_OOB, just like the the recvmsg() case.

......

        err = -EOPNOTSUPP;
        if (msg->msg_flags&MSG_OOB)
                goto out;
......

So I guess that we should be safe with changing the test the same way as we did
with recvmsg().

> sendmsg01 seems to be the only place where this flag is used.

That is because it has been removed from the recvmsg01.c by the fix
mentioned in this thread. However the header in question stayed included
there...

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
