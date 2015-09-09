Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZZf8q-0001SW-0a
	for ltp-list@lists.sourceforge.net; Wed, 09 Sep 2015 13:10:24 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZZf8l-0005K4-RB
	for ltp-list@lists.sourceforge.net; Wed, 09 Sep 2015 13:10:23 +0000
Date: Wed, 9 Sep 2015 15:09:34 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150909130934.GA13918@rei.suse.cz>
References: <dde73925917fe3524a598d859fdb66ca95711fc3.1441798744.git.jstancek@redhat.com>
	<20150909123737.GA13664@rei.suse.cz>
	<559206696.7848057.1441803641337.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <559206696.7848057.1441803641337.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH] mprotect04: fix powerpc crash when copying
 exec_func
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
> It doesn't seem reliable:
> 
> open("/dev/null", O_WRONLY|O_CREAT, 0644) = 3
> write(3, NULL, 1)                       = 1
> close(3)                                = 0
> 
> I'm seeing this on RHEL6.7 kernel, I haven't tried latest upstream yet.

Ah, you are right, the memory is not touched in the write_null()
function at all.

drivers/char/mem.c:

static ssize_t write_null(struct file *file, const char __user *buf,
                          size_t count, loff_t *ppos)
{
        return count;
}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Monitor Your Dynamic Infrastructure at Any Scale With Datadog!
Get real-time metrics from all of your servers, apps and tools
in one place.
SourceForge users - Click here to start your Free Trial of Datadog now!
http://pubads.g.doubleclick.net/gampad/clk?id=241902991&iu=/4140
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
