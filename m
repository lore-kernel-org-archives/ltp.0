Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XoAL1-0004S7-HZ
	for ltp-list@lists.sourceforge.net; Tue, 11 Nov 2014 12:14:23 +0000
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 8F07FABE7
	for <ltp-list@lists.sourceforge.net>;
	Tue, 11 Nov 2014 12:14:15 +0000 (UTC)
Date: Tue, 11 Nov 2014 13:13:45 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141111121345.GA29189@rei>
References: <1415639518-4906-1-git-send-email-jack@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1415639518-4906-1-git-send-email-jack@suse.cz>
Subject: Re: [LTP] [PATCH v2] syscalls/fanotify: Verify that inode ignore
 masks are properly reflected
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
To: Jan Kara <jack@suse.cz>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Verify that when inode has an ignore mask set, it is properly reflected
> when notifying a mountpoint. The test verifies fix "fanotify: Fix notification
> of groups with inode & mount marks" in the Linux kernel.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Pushed with small change to get rid of another signed vs unsigned
comparsion warning.

@@ -201,7 +201,7 @@ int main(int ac, char **av)
                                         (int)EVENT_BUF_LEN);
                        }
                        event = (struct fanotify_event_metadata *)event_buf;
-                       if (ret > event->event_len) {
+                       if (ret > (int)event->event_len) {
                                tst_resm(TFAIL, "group %d got more than one "
                                         "event (%d > %d)", i, ret,
                                         event->event_len);


Thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://pubads.g.doubleclick.net/gampad/clk?id=154624111&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
