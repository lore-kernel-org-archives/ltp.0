Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Sccva-0006KP-4C
	for ltp-list@lists.sourceforge.net; Thu, 07 Jun 2012 13:39:06 +0000
Date: Thu, 7 Jun 2012 15:38:02 +0200
From: chrubis@suse.cz
Message-ID: <20120607133802.GA9664@saboteur.suse.cz>
References: <1338363782-10590-1-git-send-email-penght@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1338363782-10590-1-git-send-email-penght@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] filecapstest.sh: fix a bug of fail in RHEL5
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +#ifdef HAVE_LIBCAP
>  	for (; i <= CAP_LAST_CAP; i++) {
>  #if HAVE_DECL_PR_CAPBSET_READ
>  		ret = prctl(PR_CAPBSET_READ, i);
> @@ -71,6 +72,9 @@ int check_remaining_caps(int lastdropped)
>  			return -i;
>  		}
>  	}
> +#else
> +	printf("System doesn't support full POSIX capabilities.\n");

This message is useless, as when HAVE_LIBCAP is not defined the
check_remaining_caps() is never called from the main() or am I mistaken?

> +#endif
>  	return 0;
>  }
>  
> @@ -79,6 +83,7 @@ int main(int argc, char *argv[])
>  	int ret = 1;
>  	int i;
>  
> +#ifdef HAVE_LIBCAP
>  #if HAVE_DECL_PR_CAPBSET_DROP
>  	ret = prctl(PR_CAPBSET_READ, -1);
>  #else
> @@ -131,5 +136,8 @@ int main(int argc, char *argv[])
>  		}
>  	}
>  	tst_resm(TPASS, "PR_CAPBSET_DROP tests passed\n");
> +#else
> +	printf("System doesn't support full POSIX capabilities.\n");
> +#endif
>  	tst_exit();

I'm a little lost in the ifdefs, but this one should IMHO be:

tst_resm(TCONF, "System doesn't support full POSIX capabilities.\n"


The rest seems to be fine.

-- 
Cyril Hrubis
chrubis@suse.cz

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
