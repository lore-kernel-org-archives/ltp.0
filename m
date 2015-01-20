Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YDZ4K-00064P-Ia
	for ltp-list@lists.sourceforge.net; Tue, 20 Jan 2015 13:42:08 +0000
Date: Tue, 20 Jan 2015 14:41:10 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150120134110.GA15178@rei>
References: <20150119155156.GA30735@rei>
	<1421742761-10192-1-git-send-email-zenglg.jy@cn.fujitsu.com>
	<1421742761-10192-12-git-send-email-zenglg.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1421742761-10192-12-git-send-email-zenglg.jy@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v3 12/12] smack_set_socket_labels.c: Cleanup
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
>  int main(int argc, char *argv[])
>  {
> -	char message[256];
>  	char *anin = "security.SMACK64IPIN";
>  	char *anout = "security.SMACK64IPOUT";
>  	char *annot = "security.SMACK64IPNOT";
> @@ -40,35 +46,36 @@ int main(int argc, char *argv[])
>  	char *avnot = "TheBadValue";
>  	int sock;
>  	int rc;
> +	char buf[256];

We may also put the parse_opts() here and do the TEST_LOOPING(), feel
free to send follow up patch.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
