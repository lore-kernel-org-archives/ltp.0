From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 10 Apr 2017 15:50:21 +0200
Subject: [LTP] [PATCH] pan/ltp-pan.c: fix incorrect number of total tests
In-Reply-To: <1491544700-6312-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1491544700-6312-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20170410135021.GC23301@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  pan/ltp-pan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/pan/ltp-pan.c b/pan/ltp-pan.c
> index 1614c70..beed623 100644
> --- a/pan/ltp-pan.c
> +++ b/pan/ltp-pan.c
> @@ -645,7 +645,7 @@ int main(int argc, char **argv)
>  				strerror(errno));
>  		fprintf(logfile,
>  			"\n-----------------------------------------------\n");
> -		fprintf(logfile, "Total Tests: %d\n", coll->cnt);
> +		fprintf(logfile, "Total Tests: %d\n", (coll->cnt - starts));

This change does not make much sense to me. The coll->cnt is number of
tests loaded from the runtest file, right? The starts is basically
number of tests to be executed. The runltp script executes ltp-pan with
-S which means that starts is set to coll->cnt in the main() function
and so after this change it would print "Total Tests: 0" regardless.

-- 
Cyril Hrubis
chrubis@suse.cz
