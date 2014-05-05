Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WhH0p-0001Oq-4N
	for ltp-list@lists.sourceforge.net; Mon, 05 May 2014 11:24:47 +0000
Date: Mon, 5 May 2014 13:23:49 +0200
From: chrubis@suse.cz
Message-ID: <20140505112349.GC1544@rei>
References: <1399071397.9456.YahooMailNeo@web141601.mail.bf1.yahoo.com>
	<1399071464.2771.YahooMailNeo@web141601.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1399071464.2771.YahooMailNeo@web141601.mail.bf1.yahoo.com>
Subject: Re: [LTP] Fw: Typo
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
To: C Nandi <ccnandi@yahoo.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> Correction is required for the "netdefs.h" file.
> 
> 
> 
> 
> diff --git a/testcases/network/tcp_cmds/include/netdefs.h b/testcases/network/tcp_cmds/include/netdefs.h
> index 067f20a..c6647e9 100644
> --- a/testcases/network/tcp_cmds/include/netdefs.h
> +++
>  b/testcases/network/tcp_cmds/include/netdefs.h
> @@ -37,7 +37,7 @@ typedef struct sockaddr_in6?? sai_t;
> ?#define AFI??????????????????? AF_INET6
> ?#define IERP?????????????????? ICMP6_ECHO_REPLY
> ?#define IERQ?????????????????? ICMP6_ECHO_REQUEST
> -#define ICMP_PROTO???????????? "ipv6-imcp"
> +#define ICMP_PROTO???????????? "ipv6-icmp"
> ?#define
>  PFI??????????????????? PF_INET6
> 
> ?#else
> @@ -52,7 +52,7 @@ typedef struct sockaddr_in??? sai_t;
> ?#define AFI??????????????????? AF_INET
> ?#define IERP?????????????????? ICMP_ECHOREPLY
> ?#define IERQ?????????????????? ICMP_ECHO
> -#define ICMP_PROTO???????????? "imcp"
> +#define
>  ICMP_PROTO???????????? "icmp"
> ?#define PFI??????????????????? PF_INET
> 
> ?#endif

Can you please send a signed patch?

You can create these easily using git. All you have to do is to clone
LTP git repository, set your git name and address, commit signed patch,
export it and send it by email.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
