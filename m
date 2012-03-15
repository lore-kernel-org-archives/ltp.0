Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1S81uM-00025V-K8
	for ltp-list@lists.sourceforge.net; Thu, 15 Mar 2012 04:03:22 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1S81uK-0000uV-Dk
	for ltp-list@lists.sourceforge.net; Thu, 15 Mar 2012 04:03:22 +0000
Received: by dado14 with SMTP id o14so4332385dad.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 14 Mar 2012 21:03:14 -0700 (PDT)
Message-ID: <4F6169B5.9020205@casparzhang.com>
Date: Thu, 15 Mar 2012 12:01:57 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <4F61650D.2060308@casparzhang.com>
	<1331783585-18980-1-git-send-email-gaowanlong@cn.fujitsu.com>
In-Reply-To: <1331783585-18980-1-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH V3] readlink03: fix return value for the syscall
	readlink()
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
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi,

On 03/15/2012 11:53 AM, Wanlong Gao wrote:
> Since commit http://git.kernel.org/linus/65cfc672
> which added O_PATH support to the *at() calls, the error return for readlink/readlinkat
> for the empty pathname has switched from ENOENT to EINVAL. And this patch merged to linux v2.6.39,
> So LTP commit https://github.com/linux-test-project/ltp/commit/0cc7514
> fix this with the kernel version v2.6.39 compared.
> 
> But recently, commit http://git.kernel.org/linus/1fa1e7f6
> which ensure we return ENOENT for the empty pathname for normal lookups.
> 
> Now, the patch whitch switch the return value back again is already queued for
> 3.0 and 3.1 stable release.
> 
> So, if the return value is EINVAL for empty pathname, it may be a kernel bug, so we
> needn't to check the kernel version but return the "kernel bug" INFO to LTP the users.

Hmmm, picky advice: wrapper the line <= 73 character in commit message.

> 
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> Acked-by: Jan Stancek <jstancek@redhat.com>
> ---

[snip]

> +				if ((strncmp(test_desc, "Symlink Pathname is empty", 25) == 0) &&
> +				     TEST_ERRNO == EINVAL)
> +					tst_resm(TWARN, "It may be a Kernel Bug, see the patch:\n"

picky advice #2: I think without this \n we can still get a good-looking
warning message.

> +						 "http://git.kernel.org/linus/1fa1e7f6\n");

I guess \n in this line should be removed.

How do you think?

Thanks,
Caspar

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
