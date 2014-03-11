Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WNOY1-00081w-4P
	for ltp-list@lists.sourceforge.net; Tue, 11 Mar 2014 15:24:53 +0000
Date: Tue, 11 Mar 2014 16:24:35 +0100
From: chrubis@suse.cz
Message-ID: <20140311152435.GE10778@rei>
References: <b187cebc670c5e8d23f2405d95f82405a0416095.1394190599.git.jstancek@redhat.com>
	<2618bd2ff004c79412ab2045f9a1d6c9f8afccec.1394461554.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2618bd2ff004c79412ab2045f9a1d6c9f8afccec.1394461554.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH v2 1/2] add tst_get_unused_port()
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Returns unused port number for specified domain/type.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  include/test.h |    7 +++++
>  lib/tst_net.c  |   80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 87 insertions(+), 0 deletions(-)
>  create mode 100644 lib/tst_net.c
> 
> diff --git a/include/test.h b/include/test.h
> index 81fca3e..49a0f47 100644
> --- a/include/test.h
> +++ b/include/test.h
> @@ -288,6 +288,13 @@ int tst_fill_file(const char *path, char pattern, size_t bs, size_t bcount);
>  uid_t tst_get_unused_uid(void);
>  gid_t tst_get_unused_gid(void);
>  
> +/* lib/tst_net.c
> + *
> + * Return unused port
> + */
> +unsigned short tst_get_unused_port(unsigned short family, int type,
> +	void (cleanup_fn)(void));

Just am minor nit to the API. Most of the tst_ functions as well as
SAFE_MACROS() have cleanup callback as first parameter. Let's be
consistent with that.

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
