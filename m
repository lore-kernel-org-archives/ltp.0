Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UKna9-0007Wk-7E
	for ltp-list@lists.sourceforge.net; Wed, 27 Mar 2013 10:27:49 +0000
Date: Wed, 27 Mar 2013 11:28:30 +0100
From: chrubis@suse.cz
Message-ID: <20130327102829.GB11865@rei.suse.cz>
References: <5151E122.3090203@linux.vnet.ibm.com>
	<20130326194718.GA11865@rei.suse.cz>
	<51529266.2080906@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51529266.2080906@linux.vnet.ibm.com>
Subject: Re: [LTP] syscalls/mount0* and inotify03 tests are getting skipped
 from runltp
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
To: Ramesh <rameshyr@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > The runtest files are processed before they are executed. See -b DEVICE and
> > -B DEVICE_FS_TYPE runltp parameters.
> >
> > The current runltp script is more of the hack than solution. I've send a
> > RFC email with a description of planned successor to the LTP mailing
> > list not that long ago (but I haven't started writing the code yet).
> 
> Thanks Cyril !
> 
> I got it from runltp --usage, then I tried to execute the tests by passing
> -b DEVICE and -B DEVICE_FS_TYPE to runltp but it failed with the below 
> error,
> 
> ---
> sed: can't read : No such file or directory
> FATAL: error during processing alltests file by sed
> ---
> 
> I went through the runltp script to see the cause for this error and 
> found that
> the below substitution by sed leading to the error.
> 
>  >> sed -i "" -e "s|DEVICE_FS_TYPE|$DEVICE_FS_TYPE|"  ${TMP}/alltests
> 
> Here, I don't see any reason why the -e is used with sed as we are not 
> performing
> sed operation on multiple expressions.
> 
> I just removed -e option and ran the tests, tests were successfully 
> executed.
> 
> <patch snippet>
> --- runltp_org    2013-03-27 14:40:12.029836439 +0530
> +++ runltp    2013-03-27 14:39:59.322856566 +0530
> @@ -719,7 +719,7 @@ main()
>       fi
> 
>       if [ -n "$DEVICE" ]; then
> -        sed -i "" -e "s|DEVICE_FS_TYPE|$DEVICE_FS_TYPE|"  ${TMP}/alltests
> +        sed -i "s|DEVICE_FS_TYPE|$DEVICE_FS_TYPE|"  ${TMP}/alltests
>       fi
> 
>       if [ $? -ne 0 ]; then
> 
> 
> 
> Please le me know if the removal of -e is a better solution for the 
> issue or is it really
> required for any other advantages.

This has been fixed in 0b6c356437acfa2b4cf131a80a52a8407d096fac (about
ten months ago).

If you runned into this bug you are not using latest release. You really
should use the latest release otherwise you will find more bugs that
were fixed meanwhile.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Own the Future-Intel&reg; Level Up Game Demo Contest 2013
Rise to greatness in Intel's independent game demo contest.
Compete for recognition, cash, and the chance to get your game 
on Steam. $5K grand prize plus 10 genre and skill prizes. 
Submit your demo by 6/6/13. http://p.sf.net/sfu/intel_levelupd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
