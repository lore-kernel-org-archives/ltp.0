Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WPsyA-0000MD-9b
	for ltp-list@lists.sourceforge.net; Tue, 18 Mar 2014 12:18:10 +0000
Date: Tue, 18 Mar 2014 13:17:49 +0100
From: chrubis@suse.cz
Message-ID: <20140318121748.GA12070@rei>
References: <1395140489-15791-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1395140489-15791-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH] tools/apicmd: add tst_get_unused_port
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
> +#include <sys/socket.h>
>  #include <stdio.h>
>  #include <string.h>
>  #include <stdlib.h>
> @@ -289,6 +290,40 @@ void apicmd_kvercmp2(int argc, char *argv[])
>  	exit(exit_value);
>  }
>  
> +struct param_pair {
> +	char *cmd;
> +	int value;
> +};
> +
> +unsigned short apicmd_get_unused_port(int argc, char *argv[])
> +{
> +	if (argc != 3)
> +		goto err;
> +
> +	const struct param_pair params[][3] = {
> +		{{ "ipv4", AF_INET }, { "ipv6", AF_INET6 }, { 0, 0 }},
                                                              ^
					I would rather see NULL here.

Because I'm not 100% sure that the automatic cast will do the right
thing on all implementations.

Otherwise it's fine.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
