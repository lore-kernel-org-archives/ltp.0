From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 11 Oct 2016 11:51:56 +0200
Subject: [LTP] [PATCH v2 1/2] llistxattr: added a new test case to
 llistxattr02
In-Reply-To: <1476114001-24856-2-git-send-email-dejan.jovicevic@rt-rk.com>
References: <1476114001-24856-1-git-send-email-dejan.jovicevic@rt-rk.com>
 <1476114001-24856-2-git-send-email-dejan.jovicevic@rt-rk.com>
Message-ID: <20161011095156.GB14295@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  static void verify_llistxattr(unsigned int n)
> @@ -95,6 +101,9 @@ static void setup(void)
>  			tst_brk(TBROK | TERRNO, "lsetxattr() failed");
>  		}
>  	}
> +
> +	memset(&longpathname, 'a', sizeof(longpathname) - 1);
> +	longpathname[sizeof(longpathname)] = '\0';

This is off-by-one, the last array element is at sizeof(longpathname)-1.
Also this is not needed since the array is global, hence initialized to
0 and we fill first n-1 elements with the memset() leaving the last one
to be the '\0'.

>  }
>  
>  static struct tst_test test = {
> -- 
> 1.9.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
