Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1ROjV3-0002MA-VM
	for ltp-list@lists.sourceforge.net; Fri, 11 Nov 2011 05:18:01 +0000
Received: from mail-vx0-f175.google.com ([209.85.220.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ROjV2-0007af-Pa
	for ltp-list@lists.sourceforge.net; Fri, 11 Nov 2011 05:18:01 +0000
Received: by vcbfl11 with SMTP id fl11so1536688vcb.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 10 Nov 2011 21:17:55 -0800 (PST)
Message-ID: <4EBCAAEB.6010004@casparzhang.com>
Date: Fri, 11 Nov 2011 12:56:11 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1320987154-28844-1-git-send-email-eguan@redhat.com>
In-Reply-To: <1320987154-28844-1-git-send-email-eguan@redhat.com>
Subject: Re: [LTP] [PATCH] syscall/dup03: Close all open files in cleanup
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
To: Eryu Guan <eguan@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 11/11/2011 12:52 PM, Eryu Guan wrote:
> 
> The 'silly rename' mechanism of NFS creates temporary file .nfsXXX in
> NFS mount. The cleanup() in dup03.c doesn't close all open files and
> leaves .nfsXXX file in the testing directory. Then rmdir(2) complains
> about "Directory not empty".
> 
> dup03       1  TPASS  :  dup failed as expected with EMFILE
> dup03       0  TWARN  :  tst_rmdir: rmobj(/mnt/nfs/dupxesX9v) failed: remove(/mnt/nfs/dupxesX9v) failed; errno=39: Directory not empty
> 
> So close all open files in cleanup().
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>

Acked-by: Caspar Zhang <caspar@casparzhang.com>


------------------------------------------------------------------------------
RSA(R) Conference 2012
Save $700 by Nov 18
Register now
http://p.sf.net/sfu/rsa-sfdev2dev1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
