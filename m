From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 24 Jan 2017 20:33:07 +0100
Subject: [LTP] [PATCH] ltp/numa: add new test11
In-Reply-To: <1484898966-27753-1-git-send-email-liwang@redhat.com>
References: <1484898966-27753-1-git-send-email-liwang@redhat.com>
Message-ID: <20170124193307.GA780@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +# Verification of hugepage memory allocated on a node
> +test11()
> +{
> +	Mem_huge=0
> +
> +	if [ ! -d "/sys/kernel/mm/hugepages/" ]; then
> +		tst_brk TCONF "hugepage is not supported"

This should be tst_res followed by a return on a next line. The
tst_brk will exit the whole test just because hugepages are not
supported.

> +	fi
> +
> +	for node in $nodes_list; do
> +		Ori_hpgs=$(cat /sys/devices/system/node/node${node}/hugepages/hugepages-${HPAGE_SIZE}kB/nr_hugepages)
> +		echo 1 >/sys/devices/system/node/node${node}/hugepages/hugepages-${HPAGE_SIZE}kB/nr_hugepages

Uh, so this sysfs knob controlls how much hugepages can be allocated on
a node right? What if it was set to nonzero and some hugepages are
allocated already? Shouldn't we rather set it to current value + 1 ?

> +		numactl --cpunodebind=$node --membind=$node support_numa $HUGE_PAGE &
> +		pid=$!
> +		wait_for_support_numa $pid
> +
> +		Mem_huge=$(echo $(numastat -p $pid |grep '^Huge' |awk '{print $'$((node+2))'}'))
> +		Mem_huge=$(echo "$Mem_huge * 1024" |bc)

Eh, why not just $((Mem_huge * 1024)) ?

> +		if [ $(echo "$Mem_huge < $HPAGE_SIZE" | bc) -eq 1 ]; then

Here as well, why not just if [ "$Mem_huge" -lt "$HPAGE_SIZE" ]; then

> +			tst_res TFAIL \
> +				"NUMA memory allocated in node$node is less than expected"
> +			return
> +		fi
> +
> +		kill -CONT $pid >/dev/null 2>&1
> +		echo $Ori_hpgs >/sys/devices/system/node/node${node}/hugepages/hugepages-${HPAGE_SIZE}kB/nr_hugepages
> +	done
> +
> +	tst_res TPASS "NUMA local node hugepage memory allocated"
> +}
> +
>  tst_run
> diff --git a/testcases/kernel/numa/support_numa.c b/testcases/kernel/numa/support_numa.c
> index eaf63e3..0241a19 100644
> --- a/testcases/kernel/numa/support_numa.c
> +++ b/testcases/kernel/numa/support_numa.c
> @@ -22,7 +22,7 @@
>  /*                                                                            */
>  /* File:        support_numa.c                                                */
>  /*                                                                            */
> -/* Description: Allocates 1MB of memory and touches it to verify numa         */
> +/* Description: Allocates memory and touches it to verify numa                */
>  /*                                                                            */
>  /* Author:      Sivakumar Chinnaiah  Sivakumar.C@in.ibm.com                   */
>  /*                                                                            */
> @@ -52,16 +52,43 @@ static void help(void)
>  	printf("Input:	Describe input arguments to this program\n");
>  	printf("	argv[1] == 1 then allocate 1MB of memory\n");
>  	printf("	argv[1] == 2 then allocate 1MB of share memory\n");
> -	printf("	argv[1] == 3 then pause the program to catch sigint\n");
> +	printf("        argv[1] == 3 then allocate 1HUGE PAGE SIZE of memory\n");
> +	printf("        argv[1] == 4 then pause the program to catch sigint\n");
>  	printf("Exit:	On failure - Exits with non-zero value\n");
>  	printf("	On success - exits with 0 exit value\n");
>  
>  	exit(1);
>  }
>  
> +static int read_hugepagesize(void)
> +{
> +       FILE *fp;
> +       char line[BUFSIZ], buf[BUFSIZ];
> +       int val;
> +
> +       fp = fopen("/proc/meminfo", "r");
> +       if (fp == NULL) {
> +               fprintf(stderr, "Failed to open /proc/meminfo");
> +               return 1;
> +       }
> +
> +       while (fgets(line, BUFSIZ, fp) != NULL) {
> +               if (sscanf(line, "%64s %d", buf, &val) == 2)
> +                       if (strcmp(buf, "Hugepagesize:") == 0) {
> +                               fclose(fp);
> +                               return 1024 * val;
> +                       }
> +       }
> +
> +       fclose(fp);
> +       fprintf(stderr, "can't find \"%s\" in %s", "Hugepagesize:", "/proc/meminfo");
> +
> +       return 1;
> +}

We should rather return 0 on a failure so that we can easily check
hpsz != 0 in the main()

>  int main(int argc, char *argv[])
>  {
> -	int i, fd, rc;
> +	int i, fd, rc, hpsz;
>  	char *buf = NULL;
>  	struct stat sb;
>  
> @@ -114,6 +141,24 @@ int main(int argc, char *argv[])
>  		remove(TEST_SFILE);
>  		break;
>  	case 3:
> +		hpsz = read_hugepagesize();

Eh, we do not check for a failure and gracefully try to allocate 1 byte
here? That does not sound right.

> +		buf = mmap(NULL, hpsz, PROT_READ | PROT_WRITE,
> +				MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
> +				-1, 0);
> +
> +		if (buf == MAP_FAILED){
> +			fprintf(stderr, "mmap failed\n");

What about errno? We should rather use perror() here. Also coding style
is wrong, you should use checkpatch.pl to check for common mistakes.

> +			exit(1);
> +		}
> +
> +		memset(buf, 'a', hpsz);
> +
> +		raise(SIGSTOP);
> +
> +		munmap(buf, hpsz);
> +		break;
> +	case 4:
>  		raise(SIGSTOP);
>  		break;
>  	default:
> -- 
> 1.8.3.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz
