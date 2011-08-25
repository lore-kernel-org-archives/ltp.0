Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QwbHc-0002K8-Hf
	for ltp-list@lists.sourceforge.net; Thu, 25 Aug 2011 14:51:52 +0000
Date: Thu, 25 Aug 2011 16:57:01 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110825145701.GA19113@saboteur.suse.cz>
References: <4E4C34E5.1090702@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4E4C34E5.1090702@linux.vnet.ibm.com>
Subject: Re: [LTP] [PATCH 1/1] fix ssh03 on system running mls policy
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
To: James Czyzak <czyzak2@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net, debora@linux.vnet.ibm.com

Hi!
> Modified ssh03 to unset TCtmp. On a system running the latest
> selinux mls policy the call to tst_setup in the cmdlib.sh script
> with the TCtmp variable still set with the TEST_USER directory will
> result in the directory being created with the context of the logged
> in user (i.e. administrator running the test
> ...staff_u:object_r:home_root_t:SystemLow) when the useradd is run
> afterwords the directory will already exist but the context of
> directory /home/ssh_user3 should be
> user_u:object_r:user_home_dir_t:SystemLow-SystemHigh. Now when the
> test is run to ssh login with the valid password the test will fail
> due to not being able to change to the user directory which is
> caused by a mismatched context. The unset of TCtmp will prevent
> this. This does not appear to be detrimental to systems running with
> a targeted policy and should have no ill affect systems not running
> selinux, although a test could be placed around the unset to
> determine if selinux is running and the mls policy is in use.
> 
> Signed-off-by James Czyzak <czyzak2@linux.vnet.ibm.com>
> <mailto:czyzak2@linux.vnet.ibm.com>
> 
> diff --git a/testcases/network/tcp_cmds/ssh/ssh03
> b/testcases/network/tcp_cmds/s
> index 8fbca34..a75032c 100755
> --- a/testcases/network/tcp_cmds/ssh/ssh03
> +++ b/testcases/network/tcp_cmds/ssh/ssh03
> @@ -42,7 +42,7 @@ do_setup()
>      TCtmp=/home/$TEST_USER
> 
>      rm -Rf $TCtmp
> -
> +    unset TCtmp
>      tst_setup
> 

What about not setting the TCtmp in the first place.

Change it from: 
TCtmp=/home/$TEST_USER
rm -Rf $TCtmp
unset $TCtmp
to:
rm -Rf /home/$TEST_USER

And the Signed-off-by line is missing double colon and there is mailto
html tag that shouldn't be there.

I wonder why people aren't using git commit -s and git format-patch to
generate correct patches, which is easier than doing them by hand...

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
EMC VNX: the world's simplest storage, starting under $10K
The only unified storage solution that offers unified management 
Up to 160% more powerful than alternatives and 25% more efficient. 
Guaranteed. http://p.sf.net/sfu/emc-vnx-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
