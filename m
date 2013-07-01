Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UteY9-0004qv-OL
	for ltp-list@lists.sourceforge.net; Mon, 01 Jul 2013 13:53:49 +0000
Date: Mon, 1 Jul 2013 15:55:19 +0200
From: chrubis@suse.cz
Message-ID: <20130701135519.GA21561@rei.suse.cz>
References: <1372662230-6993-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<20130701094958.GA12050@rei.suse.cz>
	<51D17373.3080908@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51D17373.3080908@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] lib: add tst_rh_kvercmp to test RHEL kernel
	version
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: Garrett Cooper <yanegomi@gmail.com>, LTP <ltp-list@lists.sourceforge.net>, Mike Frysinger <vapier@gentoo.org>

Hi!
> Yes, for inotify04 on RHEL5. Below commit is back-ported to RHEL5 updated
> version, so then inotify will send IN_ATTRIB events when link count changes.
> But in test case, we only judge the kernel version 2.6.25 to add IN_ATTRIB
> event.

> commit ece95912db94d98e202cbedb8f35206deb29d83d
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Feb 6 01:37:13 2008 -0800

<snip>

> RHEL5 changelog:
> - [fs] inotify: send IN_ATTRIB event on link count changes (Eric Paris ) [471893]
> 
> 
> The man page of inotify said that:
> IN_ATTRIB         Metadata changed, e.g., permissions, timestamps, extended attributes, link count (since Linux 2.6.25), UID, GID, etc. (*).
> 
> So, in the test case, we judge that if the kernel version is less than 2.6.25, we
> assume that the IN_ATTRIB will not be sent in the event. But after back-port
> this patch, RHEL5 includes this event when the link count changes.
> 
> There are many test cases are suffering such situation, because sometimes the patch
> back-port may break our kernel version check. So I considering introduce some
> vendor specific kernel version check like RHEL and SLES.

So the case here is that the test is disabled because the we think that
it will not work. I'm fine with adding more information to the
tst_kvercmp() but we should do it more extensible and data driven
manner.

What about we create an array with extra version strings per
distribution that gets passed to tst_kvercmp2() function and is used
when particular distribution is detected?

Roughly something as:

In the LTP lib:

struct tst_kern_extraver {
	char *dist_name;
	char *extra_ver;
};

int tst_kvercmp2(int r1, int r2, int r3, struct tst_kern_extraver *vers);


In the testcase:

static struct tst_kern_extraver exver[] = {
	{"RHEL6", "234"},
	{"SLES10", "0.91"},
	{NULL, NULL}
};


...

	if (tst_kvercmp2(2, 6, 25, exver) < 0)
		...
...


-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
