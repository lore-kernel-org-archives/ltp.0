From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 23 Nov 2016 14:26:12 +0100
Subject: [LTP] [PATCH 2/3] ltp/numa: cleanup work for numa/*
In-Reply-To: <1479872213-29969-1-git-send-email-liwang@redhat.com>
References: <1479872213-29969-1-git-send-email-liwang@redhat.com>
Message-ID: <20161123132612.GG3346@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/numa/support_numa.c b/testcases/kernel/numa/support_numa.c
> index 3991955..5c6b066 100644
> --- a/testcases/kernel/numa/support_numa.c
> +++ b/testcases/kernel/numa/support_numa.c
> @@ -1,34 +1,31 @@
>  /******************************************************************************/
>  /*                                                                            */
>  /* Copyright (c) International Business Machines  Corp., 2007                 */
> +/* Copyright (c) Linux Test Project, 2016                                     */
>  /*                                                                            */
> -/* This program is free software;  you can redistribute it and/or modify      */
> +/* This program is free software: you can redistribute it and/or modify       */
>  /* it under the terms of the GNU General Public License as published by       */
> -/* the Free Software Foundation; either version 2 of the License, or          */
> +/* the Free Software Foundation, either version 3 of the License, or          */
>  /* (at your option) any later version.                                        */
>  /*                                                                            */
>  /* This program is distributed in the hope that it will be useful,            */
> -/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
> -/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
> -/* the GNU General Public License for more details.                           */
> +/* but WITHOUT ANY WARRANTY; without even the implied warranty of             */
> +/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the              */
> +/* GNU General Public License for more details.                               */
>  /*                                                                            */
>  /* You should have received a copy of the GNU General Public License          */
> -/* along with this program;  if not, write to the Free Software               */
> -/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
> +/* along with this program. If not, see <http://www.gnu.org/licenses/>.       */
>  /*                                                                            */
>  /******************************************************************************/
>  
>  /******************************************************************************/
>  /*                                                                            */
> -/* File:        support_numa.c                                                     */
> +/* File:        support_numa.c                                                */
>  /*                                                                            */
>  /* Description: Allocates 1MB of memory and touches it to verify numa         */
>  /*                                                                            */
>  /* Author:      Sivakumar Chinnaiah  Sivakumar.C@in.ibm.com                   */
>  /*                                                                            */
> -/* History:     Created - Jul 18 2007 - Sivakumar Chinnaiah                   */
> -/*                                                 Sivakumar.C@in.ibm.com     */
> -/*                                                                            */
>  /******************************************************************************/
>  
>  #include <stdio.h>
> @@ -38,24 +35,14 @@
>  #include <signal.h>
>  #include <limits.h>
>  #include <string.h>
> -#include "test.h"
>  
>  /* Global Variables */
>  #define MB (1<<20)
>  #define PAGE_SIZE getpagesize()
>  #define barrier() __asm__ __volatile__("": : :"memory")
>  
> -/* Extern Global Variables */
> -extern int tst_count;		/* to avoid compilation errors. */
> -extern char *TESTDIR;		/* to avoid compilation errors. */
> -
> -/* Global Variables */
> -char *TCID = "support_numa";	/* to avoid compilation errors. */
> -int TST_TOTAL = 1;		/* to avoid compilation errors. */
> -
> -void sigfunc(int sig)
> +void sigfunc(__attribute__ ((unused)) int sig)
>  {
> -	tst_resm(TINFO, "#Caught signal signum=%d", sig);
>  }
>  
>  /******************************************************************************/
> @@ -65,9 +52,9 @@ void sigfunc(int sig)
>  /* Description: Alloctes 1MB of memory and touches it to verify numa behaviour*/
>  /*                                                                            */
>  /* Input:       Describe input arguments to this program                      */
> -/*               argv[1] ==1 then print pagesize                              */
> -/*               argv[1] ==2 then allocate 1MB of memory                      */
> -/*		 argv[1] ==3 then pause the program to catch sigint	      */
> +/*               argv[1] == 1 then print pagesize                             */
> +/*               argv[1] == 2 then allocate 1MB of memory                     */
> +/*		 argv[1] == 3 then pause the program to catch sigint          */
>  /*                                                                            */
>  /* Exit:       On failure - Exits with non-zero value.                        */
>  /*             On success - exits with 0 exit value.                          */

It would be much better to remove this whole comment and rather add a
help() function that explains the paramters and call it when wrong
parameter was encountered in the switch() below.

> @@ -78,40 +65,41 @@ int main(int argc, char *argv[])
>  {
>  	int i;
>  	char *buf = NULL;
> -	int count = 0;
>  	struct sigaction sa;
>  
> +	if (argc != 2) {
> +		printf("Error: arguments not right.\n");
                        ^
			This is pretty value and hence useless. You should
			rather explain that the program takes exactly one
			numeric parameter.

> +		exit(-1);

You should rather exit with 1 here.

> +	}
> +
>  	switch (atoi(argv[1])) {
>  	case 1:
>  		printf("%d", PAGE_SIZE);
> -		tst_exit();
> +		return 0;
>  	case 2:
>  		buf = malloc(MB);
>  		if (!buf) {
> -			tst_resm(TINFO, "#Memory is not available\n");
> -			tst_exit();
> +			printf("Memory is not available\n");

It would be a bit better to print the error messages into the stderr
instead.

>  			exit(2);
>  		}
>  		for (i = 0; i < MB; i += PAGE_SIZE) {
> -			count++;
>  			buf[i] = 'a';
>  			barrier();
>  		}
>  		free(buf);
> -		tst_exit();
> +		return 0;
>  	case 3:
>  		/* Trap SIGINT */
>  		sa.sa_handler = sigfunc;
>  		sa.sa_flags = SA_RESTART;
>  		sigemptyset(&sa.sa_mask);
>  		if (sigaction(SIGINT, &sa, 0) < 0) {
> -			tst_brkm(TBROK, NULL, "#Sigaction SIGINT failed\n");
> -			tst_exit();
> -			exit(1);
> +			printf("Sigaction SIGINT failed\n");
> +			exit(3);
>  		}
>  		/* wait for signat Int */
>  		pause();
> -		tst_exit();
> +		return 0;
>  	default:
>  		exit(1);
>  	}

-- 
Cyril Hrubis
chrubis@suse.cz
