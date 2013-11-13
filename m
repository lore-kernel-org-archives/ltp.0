Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VgdTk-0006uq-MS
	for ltp-list@lists.sourceforge.net; Wed, 13 Nov 2013 16:39:44 +0000
Date: Wed, 13 Nov 2013 17:39:28 +0100
From: chrubis@suse.cz
Message-ID: <20131113163928.GA12406@rei.Home>
References: <81212EE27BC298499DBD7CA069AAD07142E38D167A@LGEVEXMBAPSVC2.LGE.NET>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <81212EE27BC298499DBD7CA069AAD07142E38D167A@LGEVEXMBAPSVC2.LGE.NET>
Subject: Re: [LTP] [PATCH V2] BindMounts: fix to properly unmount during
 cleanup
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
To: Siva Padhy <siva.padhy@lge.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> The fs_bind testcases creates the mount directories for testing.
> When the testcase exits, those directories were not properly unmounted.
> The reason of the issues are:
> 
>  1. Some directories were kept mounted, even after the cleanup() routine, as the unmount code is missing.
>  2. Some "umount" command execution fails, as they are dependent on some other mounted directories.
> 
> Error Report
> ------------
> rbind/test02    1  TPASS  :  rbind/test02: PASSED
> /kvt.new/ltp/testscripts/test_fs_bind.sh    0  TWARN  :  rbind/test02 did not properly clean up "/tmp/ltp-XXXX9qdYqG/sandbox"
> 
> rbind/test38    1  TPASS  :  rbind/test38: PASSED
> /kvt.new/ltp/testscripts/test_fs_bind.sh    0  TWARN  :  rbind/test38 did not properly clean up "/tmp/ltp-XXXX9qdYqG/sandbox"
> 
> This patch add/reorder the unmount code to fix the above TWARN messages.
> 
> Modified-by: Jan Stancek <jstancek@redhat.com>
> Signed-off-by: Siva  <siva.padhy@lge.com>

Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
