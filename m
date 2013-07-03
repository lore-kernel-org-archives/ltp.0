Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1UuI1b-0004jv-TH
	for ltp-list@lists.sourceforge.net; Wed, 03 Jul 2013 08:02:51 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UuI1Z-0000Sf-MG
	for ltp-list@lists.sourceforge.net; Wed, 03 Jul 2013 08:02:51 +0000
Message-ID: <51D3DA8A.5020602@oracle.com>
Date: Wed, 03 Jul 2013 12:02:18 +0400
From: alexey.kodanev@oracle.com
MIME-Version: 1.0
References: <1372765421-2934-1-git-send-email-alexey.kodanev@oracle.com>
	<201307021650.56483.vapier@gentoo.org>
In-Reply-To: <201307021650.56483.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH v6] fw_load: new test of device firmware loading
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!

On 07/03/2013 12:50 AM, Mike Frysinger wrote:
>> --- /dev/null
>> >  +++ b/testcases/kernel/firmware/fw_load_kernel/Makefile
>> >
>> >  +MAKE_TARGETS	:= ltp_fw_load.ko
>> >  +ltp_fw_load.ko: ltp_fw_load.c
>> >  +	-$(MAKE) -C $(LINUX_DIR) M=$(abs_srcdir)
>> >  +	-mv ltp_fw_load.ko ltp_fw_load.ko~
>> >  +	-$(MAKE) -C $(LINUX_DIR) M=$(abs_srcdir) clean
>> >  +	-mv ltp_fw_load.ko~ ltp_fw_load.ko
> what's with ignoring the exit status of all these ?  and why clean when you're
> done ?  doesn't seem like you'd want to do either of these.
>
Ignoring the exit status, allow to proceed with the LTP build, despite 
of any error during the module's build. Then, user-space test will 
return TCONF, if it doesn't find the module.

There are a lot of files that left after module's build and If I don't 
clean there, I have to manually add files to the clean target and 
perhaps, even more.

Thanks,
Alexey


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
