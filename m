Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XeNrX-0003hG-GY
	for ltp-list@lists.sourceforge.net; Wed, 15 Oct 2014 12:39:31 +0000
Date: Wed, 15 Oct 2014 14:39:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141015123911.GA7271@rei.suse.cz>
References: <1409047170-18251-2-git-send-email-mmarhefk@redhat.com>
	<1409320025-12778-1-git-send-email-mmarhefk@redhat.com>
	<2033057817.18477225.1409840498036.JavaMail.zimbra@redhat.com>
	<20141002134709.GB4544@rei.suse.cz>
	<1080778288.46330076.1412258911538.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1080778288.46330076.1412258911538.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH 2/2 v2] containers: added mountns/mountns04.c
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
To: Matus Marhefka <mmarhefk@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Yes, mounting B is unnecessary and it does not affect the test result.
> The test() function can be simplified to:
> 
> static void test(void)
> {
>         /* unshares the mount ns */
>         if (unshare(CLONE_NEWNS) == -1)
>                 tst_brkm(TBROK | TERRNO, cleanup, "unshare failed");
>         /* makes sure mounts/umounts have no effect on a real system */
>         SAFE_MOUNT(cleanup, "none", "/", "none", MS_REC|MS_PRIVATE, NULL);
> 
>         /* bind mounts DIRA to itself */
>         SAFE_MOUNT(cleanup, DIRA, DIRA, "none", MS_BIND, NULL);
>         /* makes mount DIRA unbindable */
>         SAFE_MOUNT(cleanup, "none", DIRA, "none", MS_UNBINDABLE, NULL);
> 
>         /* tries to bind mount unbindable DIRA to DIRB which should fail */
>         if (mount(DIRA, DIRB, "none", MS_BIND, NULL) == -1) {
>                 tst_resm(TPASS, "unbindable mount passed");
>         } else {
>                 SAFE_UMOUNT(cleanup, DIRB);
>                 tst_resm(TFAIL, "unbindable mount faled");
>         }
> 
>         SAFE_UMOUNT(cleanup, DIRA);
> }

I've simplified the test function and updated the test description (in
the comment at the start of the file) and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
