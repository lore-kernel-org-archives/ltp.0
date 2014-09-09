Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XRLe4-0004Af-OL
	for ltp-list@lists.sourceforge.net; Tue, 09 Sep 2014 13:39:44 +0000
Date: Tue, 9 Sep 2014 15:39:28 +0200
From: chrubis@suse.cz
Message-ID: <20140909133928.GB5193@rei>
References: <1408099965-15748-1-git-send-email-mmarhefk@redhat.com>
	<1408099965-15748-2-git-send-email-mmarhefk@redhat.com>
	<555865557.12247931.1408962364264.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <555865557.12247931.1408962364264.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH 2/3] containers: added mountns dir
	and	mountns/mountns01.c
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
> We should probably also check availability of MS_SHARED/MS_PRIVATE/MS_REC/etc.
> For example, an old distro like RHEL5.3 has kernel support, but these
> flags are not defined in glibc headers ().

We can also add these to an header to include/lapi/ to ensure that they
are defined (we do have these definitions allready in
testcases/kernel/fs/fs_bind/bin/smount.c so technically we just need to
move them there). Then we can get rid of the ifdefs in the test code,
but I'm wondering if the kernel version check is enough to be sure these
flags are implemented (there seems to be no error checking for unknown
flags in fs/namespace.c do_mount() function and it looks like these are
simply ignored).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce.
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
