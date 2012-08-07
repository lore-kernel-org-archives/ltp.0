Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1Sym58-0003Y9-Lz
	for ltp-list@lists.sourceforge.net; Tue, 07 Aug 2012 15:52:30 +0000
Received: from mail-yx0-f175.google.com ([209.85.213.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Sym54-0000YN-Tm
	for ltp-list@lists.sourceforge.net; Tue, 07 Aug 2012 15:52:30 +0000
Received: by yenm1 with SMTP id m1so507256yen.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 07 Aug 2012 08:52:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1344331752-817-1-git-send-email-xu.simon@oracle.com>
References: <1344331752-817-1-git-send-email-xu.simon@oracle.com>
Date: Tue, 7 Aug 2012 08:52:21 -0700
Message-ID: <CAGH67wT32j4P8eH_R2+Qbve5B5gVcSjU4npzs5dB2Bze=BS6rQ@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 1/1] runltp: fix -d option processing
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
To: Simon Xu <xu.simon@oracle.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, Aug 7, 2012 at 2:29 AM, Simon Xu <xu.simon@oracle.com> wrote:
> When converting the path specified for -d to absolute path, an extra '/' is
> added, e.g. if '/mypath' is specified, TMPBASE will be '//mypath'.
> Some testcases fail because of this, e.g. chdir01A fails with:
>
> chdir01     1  TFAIL  :  symlink(object, symbolic) was succesful.
> mkdir(object, 0700) was successful
> chdir(2) returned successfully, but getcwd(3) indicated new current
> working directory location /ext4/ltp-2nHcAjcGKr/chd2Y4XkO/object not equal
> to expected //ext4/ltp-2nHcAjcGKr/chd2Y4XkO/object
>
> Use readlink to get absolute path.
>
> Signed-off-by: Simon Xu <xu.simon@oracle.com>

Reviewed-by: Garrett Cooper <yanegomi@gmail.com>

Pushed to the repo.
Thanks!
-Garrett

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
