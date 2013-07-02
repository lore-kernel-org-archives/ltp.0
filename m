Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Uu5ER-00041r-RO
	for ltp-list@lists.sourceforge.net; Tue, 02 Jul 2013 18:23:15 +0000
Date: Tue, 2 Jul 2013 20:24:33 +0200
From: chrubis@suse.cz
Message-ID: <20130702182433.GA990@rei.Home>
References: <1372765421-2934-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1372765421-2934-1-git-send-email-alexey.kodanev@oracle.com>
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> This test checks the device firmware loading. Since Linux 3.7 it can be loaded
> directly (by-pass udev). The test consists of the two parts: userspace and
> kernelspace.
> 
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>

This version looks good to me.

But there is one catch there, as we divided the module load function
into the load_module and run_cmd functions the testcase will end up with
TBROK rather than with TCONF when the kernel module couldn't be loaded
due to version mismatch and I would preffer the TCONF in this case.

But that does not block the inclusion of this testcase (and the
configure patch that needs to be applied beforhand) and if we agree that
TCONF is better we can fix the module_load later. One solution that
seems easy enough is to make the run_cmd() return the wait status (as
system() does).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
