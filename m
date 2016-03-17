From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 17 Mar 2016 05:35:37 -0400 (EDT)
Subject: [LTP] [PATCH] Change memory units to MB to support embedded
	devices
In-Reply-To: <1458097251-2708-1-git-send-email-jcsistemas2001@gmail.com>
References: <1458097251-2708-1-git-send-email-jcsistemas2001@gmail.com>
Message-ID: <1059278052.10541669.1458207337814.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Julio Cruz" <jcsistemas2001@gmail.com>
> To: "julio cruz" <julio.cruz@smartmatic.com>, ltp@lists.linux.it, chrubis@suse.cz, jstancek@redhat.com
> Cc: "Julio Cruz" <jcsistemas2001@gmail.com>
> Sent: Wednesday, 16 March, 2016 4:00:51 AM
> Subject: [PATCH] Change memory units to MB to support embedded devices
> 
> This patch made two changes: 1) check the available memory
> before to perform the test case, and 2) change the memory units
> from GB to MB.
> Both changes are needed during testing on embedded devices
> with RAM memory limitation (i.e. 512MB)
> This patch no changed the test case procedure and the default
> memory size is the same (1GB=1000MB).
> To use this test case in embedded devices, I suggest to change
> the testrun 'mm' as below from: "mtest06_2 mmap2 -x 0.002 -a -p"
> to "mtest06_2 mmap2 -x 0.002 -a -p -s 100"

I think we can make default a smaller value without any impact
on what this test is doing. Test doesn't say why 1GB was chosen.

I'd go with 128M, that still covers most scenarios where we'd
use at least 2 consecutive huge pages (of most common sizes).

Regards,
Jan

> 
> Signed-off-by: Julio Cruz <jcsistemas2001@gmail.com>
> ---
>  testcases/kernel/mem/mtest06/mmap2.c | 40
>  +++++++++++++++++++++++++-----------
>  1 file changed, 28 insertions(+), 12 deletions(-)
> 
> diff --git a/testcases/kernel/mem/mtest06/mmap2.c
> b/testcases/kernel/mem/mtest06/mmap2.c
> index ad81dbe..ebeebe5 100644
> --- a/testcases/kernel/mem/mtest06/mmap2.c
> +++ b/testcases/kernel/mem/mtest06/mmap2.c
> @@ -48,9 +48,9 @@
>  /*									      */
>  /* Description: Test the LINUX memory manager. The program is aimed at
>  */
>  /*              stressing the memory manager by repeaded map/write/unmap of
>  a */
> -/*		of a large gb size file.				      */
> +/*		large mb size file.				              */
>  /*									      */
> -/*		Create a file of the specified size in gb, map the file,      */
> +/*		Create a file of the specified size in mb, map the file,      */
>  /*		change the contents of the file and unmap it. This is repeated*/
>  /*		several times for the specified number of hours.	      */
>  /*									      */
> @@ -73,7 +73,7 @@
>  #include <getopt.h>
>  #include "test.h"
>  
> -#define GB 1000000000
> +#define MB 1048576
>  #ifndef TRUE
>  #define TRUE 1
>  #endif
> @@ -99,7 +99,7 @@ static int mkfile(int size)
>  		fprintf(stdout, "creating tmp file and writing 'a' to it ");
>  	}
>  
> -	while (index < (size * GB)) {
> +	while (index < (size * MB)) {
>  		index += 4096;
>  		if (write(fd, buff, 4096) == -1) {
>  			perror("mkfile(): write()");
> @@ -136,16 +136,24 @@ static void usage(char *progname)
>  		"\t -p set map_flag to MAP_PRIVATE.\tdefault:"
>  		"MAP_SHARED\n"
>  		"\t -s size of the file/memory to be mmaped.\tdefault:"
> -		"1GB\n"
> +		"1000MB\n"
>  		"\t -x time for which test is to be run.\tdefault:"
>  		"24 Hrs\n", progname);
>  	exit(-1);
>  }
>  
> +long get_available_memory_mb(void)
> +{
> +	unsigned long long ps, pn;
> +	ps = sysconf(_SC_PAGESIZE);
> +	pn = sysconf(_SC_AVPHYS_PAGES);
> +	return ps * pn / (1024*1024);
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	int fd;
> -	int fsize = 1;
> +	int fsize = 1000;
>  	float exec_time = 24;
>  	int c;
>  	int sig_ndx;
> @@ -153,6 +161,7 @@ int main(int argc, char **argv)
>  	int map_anon = FALSE;
>  	int run_once = TRUE;
>  	char *memptr;
> +	long avail_memory_mb;
>  	struct sigaction sigptr;
>  
>  	static struct signal_info {
> @@ -188,7 +197,7 @@ int main(int argc, char **argv)
>  			fsize = atoi(optarg);
>  			if (fsize == 0)
>  				fprintf(stderr, "Using default "
> -					"fsize %d GB\n", fsize = 1);
> +					"fsize %d MB\n", fsize = 1000);
>  			break;
>  		case 'x':
>  			exec_time = atof(optarg);
> @@ -205,7 +214,14 @@ int main(int argc, char **argv)
>  
>  	fprintf(stdout, "MM Stress test, map/write/unmap large file\n"
>  		"\tTest scheduled to run for:       %f\n"
> -		"\tSize of temp file in GB:         %d\n", exec_time, fsize);
> +		"\tSize of temp file in MB:         %d\n", exec_time, fsize);
> +
> +	avail_memory_mb = get_available_memory_mb();
> +	fprintf(stdout, "Available memory: %ldMB\n", avail_memory_mb);
> +	if (fsize > avail_memory_mb) {
> +		fprintf(stdout, "Not enough memory to run this case\n");
> +		exit(0);
> +	}
>  
>  	alarm(exec_time * 3600.00);
>  
> @@ -235,7 +251,7 @@ int main(int argc, char **argv)
>  			fd = -1;
>  			map_flags = map_flags | MAP_ANONYMOUS;
>  		}
> -		memptr = mmap(0, (fsize * GB), PROT_READ | PROT_WRITE,
> +		memptr = mmap(0, (fsize * MB), PROT_READ | PROT_WRITE,
>  			      map_flags, fd, 0);
>  		if (memptr == MAP_FAILED) {
>  			perror("main(): mmap()");
> @@ -244,15 +260,15 @@ int main(int argc, char **argv)
>  			fprintf(stdout, "file mapped at %p\n"
>  				"changing file content to 'A'\n", memptr);
>  
> -		memset(memptr, 'A', ((fsize * GB) / sizeof(char)));
> +		memset(memptr, 'A', ((fsize * MB) / sizeof(char)));
>  
> -		if (msync(memptr, ((fsize * GB) / sizeof(char)),
> +		if (msync(memptr, ((fsize * MB) / sizeof(char)),
>  			  MS_SYNC | MS_INVALIDATE) == -1) {
>  			perror("main(): msync()");
>  			exit(-1);
>  		}
>  
> -		if (munmap(memptr, (fsize * GB) / sizeof(char)) == -1) {
> +		if (munmap(memptr, (fsize * MB) / sizeof(char)) == -1) {
>  			perror("main(): munmap()");
>  			exit(-1);
>  		} else
> --
> 1.9.1
> 
> 
