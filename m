From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 18 May 2017 15:46:55 +0200
Subject: [LTP] [PATCH 1/2] ltp/numa: add new test11
In-Reply-To: <1488526490-22120-1-git-send-email-liwang@redhat.com>
References: <1488526490-22120-1-git-send-email-liwang@redhat.com>
Message-ID: <20170518134655.GD29477@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> @@ -52,16 +52,43 @@ static void help(void)
>  	printf("Input:	Describe input arguments to this program\n");
>  	printf("	argv[1] == 1 then allocate 1MB of memory\n");
>  	printf("	argv[1] == 2 then allocate 1MB of share memory\n");
> -	printf("	argv[1] == 3 then pause the program to catch sigint\n");
> +	printf("        argv[1] == 3 then allocate 1HUGE PAGE SIZE of memory\n");
> +	printf("        argv[1] == 4 then pause the program to catch sigint\n");
>  	printf("Exit:	On failure - Exits with non-zero value\n");
>  	printf("	On success - exits with 0 exit value\n");

Can we, pretty please, change this parameter to a string that describes
the operation?

Something as:
	argv[1] == "alloc_1MB"
	argv[1] == "alloc_1MB_shared"
	argv[1] == "alloc_huge_page"
	argv[1] == "pause"

So that we can use the helper as:

numactl --cpunodebind=$node --membind=$node support_numa alloc_1MB &

The helper would then do the classical if else:

	if (!strcmp(argv[1], "alloc_1MB")) {

		...

	} else if (!strcmp(argv[1], "alloc_1MB_shared")) {

	...

	} else {
		help();
	}

Otherwise it looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz
