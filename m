Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UHxz7-0005FU-0d
	for ltp-list@lists.sourceforge.net; Tue, 19 Mar 2013 14:57:53 +0000
Date: Tue, 19 Mar 2013 15:58:35 +0100
From: chrubis@suse.cz
Message-ID: <20130319145835.GA11291@rei>
References: <df80cf17650d9280457b66e44fb09b55c1cdbce4.1363703473.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <df80cf17650d9280457b66e44fb09b55c1cdbce4.1363703473.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] inode02: fix "slash" array overrun
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
> testcases/kernel/fs/inode/inode02.c:254 is initializing it as:
>     slash[0] = '/';
>     slash[1] = '\0';
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/kernel/fs/inode/inode02.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/kernel/fs/inode/inode02.c b/testcases/kernel/fs/inode/inode02.c
> index 783edf8..f70c5d8 100644
> --- a/testcases/kernel/fs/inode/inode02.c
> +++ b/testcases/kernel/fs/inode/inode02.c
> @@ -80,7 +80,7 @@ int nchild;
>  FILE *list_stream = NULL;
>  int list_id;
>  int file_id;
> -char slash[1];
> +char slash[2];

Good catch, but could you go ahead and convert the strcats into one
snprintf() so that the slash array wouldn't be needed at all?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
