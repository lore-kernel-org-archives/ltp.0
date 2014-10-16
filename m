Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Xekgf-0001Bp-Ey
	for ltp-list@lists.sourceforge.net; Thu, 16 Oct 2014 13:01:49 +0000
Date: Thu, 16 Oct 2014 15:01:28 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141016130128.GF20676@rei.suse.de>
References: <b8054b8185431bf461ab892b87fd647c03b323b8.1413463764.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b8054b8185431bf461ab892b87fd647c03b323b8.1413463764.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] doc: document tst_checkpoint_create and
 tst_checkpoint_init
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
> @@ -642,6 +642,22 @@ the same working directory (they use FIFO for synchronization). The checkpoint
>  interface provides two pairs of signal and wait functions. One pair to be used
>  to signal child from parent and second to signal parent from child.
>  
> +Checkpoint is represented by 'struct tst_checkpoint', which has to be
> +initialized before first usage and FIFO has to be created. This is
> +usually done in parent process in single step by calling
> +'tst_checkpoint_create()'.
> +
> +Child processes created via fork() are ready to use tst_checkpoint_*
> +synchronization functions, as they inherited already initialized
> +'struct tst_checkpoint'.
> +
> +Child processes started via exec*, or any other process can use already
> +created FIFO, provided they initialize 'struct tst_checkpoint' first by
> +call to 'tst_checkpoint_init()'. This function does not create any FIFO,
> +it relies on fact, that it was already created by some other process.
> +Note, that if you use multiple FIFOs in this scenario, these should be
> +initialized in same order as in process you are sychronizing against.
> +
>  For the details of the interface, look into the 'include/tst_checkpoint.h' and
>  'lib/tests/tst_checkpoint_*'.

Nicely done.

We should also add:

IMPORTANT: Be wary that using single checkpoint to signal child/parent followed
           immediately by wait for parent/child creates an race condtion
	   between opening the pipe and reading from it (the process
	   writing to the fifo may may be the wery same process that
	   reads from it and the checkpoint code will exit the test
	   with error). You are advised to use two checkpoints in this
	   case.

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
