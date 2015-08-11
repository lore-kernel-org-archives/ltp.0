Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZPDrP-0000gm-6F
	for ltp-list@lists.sourceforge.net; Tue, 11 Aug 2015 18:01:15 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZPDrH-0007Ce-1J
	for ltp-list@lists.sourceforge.net; Tue, 11 Aug 2015 18:01:09 +0000
Date: Tue, 11 Aug 2015 20:00:40 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150811180040.GA24227@rei.suse.de>
References: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
	<1436424468-11756-5-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1436424468-11756-5-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH 04/23] network/virt_lib.sh: use ROD_SILENT in
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> --- a/testcases/network/virt/virt_lib.sh
> +++ b/testcases/network/virt/virt_lib.sh
> @@ -90,7 +90,8 @@ cleanup_vifaces()
>  	tst_resm TINFO "cleanup virtual interfaces..."
>  	local viface=`ip link | sed -nE 's/^[0-9]+: (ltp_v[0-9]+):.+/\1/p'`
>  	for vx in $viface; do
> -		ip link delete $vx
> +		ROD_SILENT "ip link set $vx down"
> +		ROD_SILENT "ip link delete $vx"

Do we really want to exit the cleanup if deleting one of the interfaces
has failed?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
