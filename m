From: James Dong =?unknown-8bit?b?6JGj5LiW5rGf?= <dongshijiang@inspur.com>
Date: Fri, 4 Jun 2021 06:19:53 +0000
Subject: [LTP] =?gb2312?b?tPC4tDogtPC4tDogtPC4tDogIFtQQVRDSF0gbHRwLWFp?=
 =?gb2312?b?b2Rpby9kaW9fYXBwZW5kOiBmaXggZGlvX2FwcGVuZCgp?=
In-Reply-To: <60B9A3D1.1040001@fujitsu.com>
References: <d87da351dd8cd8c8e51afc8922162e84@sslemail.net>
 <60B8A96C.8080503@fujitsu.com> <befea6726fc7467b9410db3e3b961f3e@inspur.com>
 <60B98598.7000905@fujitsu.com> <eddbe134055240cb8889b4df76404c1d@inspur.com>
 <60B9A3D1.1040001@fujitsu.com>
Message-ID: <720a6786a3204665b3418514fb782174@inspur.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi xuyang

Thank you very much for your reply, I understand


-----????-----
???: xuyang2018.jy@fujitsu.com [mailto:xuyang2018.jy@fujitsu.com] 
????: 2021?6?4? 11:53
???: James Dong (???) <dongshijiang@inspur.com>; Cyril Hrubis <chrubis@suse.cz>; Petr Vorel <pvorel@suse.cz>; Li Wang <liwang@redhat.com>
??: ltp@lists.linux.it
??: Re: ??: ??: [LTP] [PATCH] ltp-aiodio/dio_append: fix dio_append()

Hi Dong

> Hi xuyang
> 
> Thank you very much for your reply, but I think we should add the judgment of the return value in the "dio_append" function, because the final return value is 0 regardless of whether the test item passes or not, and 0 means PASS.
IMO, I don't like perror or printf function and use return value to tell runltp that this case failed. LTP has tst_res() function with different flag and ltp new test framework can check pass/fail/conf number in lib/tst_test.c do_exit function.

A generic fix shound use tst_resm(TFAIL,) and tst_exit function.
--- a/testcases/kernel/io/ltp-aiodio/dio_append.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_append.c
@@ -85,7 +85,7 @@ void dio_append(char *filename)
        fd = open(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666);

        if (fd < 0) {
-               perror("cannot create file");
+               tst_resm(TFAIL, "cannot create file %s", filename);
                return;
        }

@@ -99,7 +99,7 @@ void dio_append(char *filename)
        memset(bufptr, 0, 64 * 1024);
        for (i = 0; i < 1000; i++) {
                if ((w = write(fd, bufptr, 64 * 1024)) != 64 * 1024) {
-                       fprintf(stderr, "write %d returned %d\n", i, w);
+                       tst_resm(TFAIL, "write %d returned %d", i, w);
                }
        }
 }
@@ -139,5 +139,5 @@ int main(void)
        for (i = 0; i < num_children; i++) {
                kill(pid[i], SIGTERM);
        }
-       return 0;
+       tst_exit();
 }

It also need sto use setup and cleanup function. But it is old test api.
I guess we can use new api to do it.

@Cyril, Petr, Li
I think it is time to convert the whole ltp-aiodio cases into new api and we still can use ltp-aiodio.sh.

Best Regards
Yang Xu

> 
> -----????-----
> ???: xuyang2018.jy@fujitsu.com [mailto:xuyang2018.jy@fujitsu.com]
> ????: 2021?6?4? 9:44
> ???: James Dong (???)<dongshijiang@inspur.com>
> ??: ltp@lists.linux.it
> ??: Re: ??: [LTP] [PATCH] ltp-aiodio/dio_append: fix dio_append()
> 
> Hi Dong
> 
> Please see ltp/testcases/kernel/io/ltp-aiodio/README
> it said "
> Run the ltp-aiodio.sh file to execute all the tests. The tests can also be run individually, just execute the program and the excepted params will be output. No scripts were created to run the test standalone."
> 
> So use runltp to excute ltp-aiodio.part4 wasn't supported.
> 
> Zorro and Cyril also discuss about ltp-aiodio directory/file non-existed problem. Please see the following url.
> https://patchwork.ozlabs.org/project/ltp/patch/20210601155427.996321-1
> -zlang@redhat.com/
> 
> 
> Best Regards
> Yang Xu
>> Hi xuyang
>> 1. if not create directory, in the function dio_append The open file returns a failure, Because the directory "aiodio" does not exist.
>> 2. The mkdir command is called to recursively create directories
>>
>> -----????-----
>> ???: xuyang2018.jy@fujitsu.com [mailto:xuyang2018.jy@fujitsu.com]
>> ????: 2021?6?3? 18:05
>> ???: James Dong (???)<dongshijiang@inspur.com>
>> ??: ltp@lists.linux.it
>> ??: Re: [LTP] [PATCH] ltp-aiodio/dio_append: fix dio_append()
>>
>> Hi dong
>>> When running the dio_append test in the ltp-aiodiio.part4 test item, there was a problem that the file could not be created, but the test result was PASS. To this end, the following operations have been added.
>>> 1. create the directory where the file is located.
>> Why need to create directory?
>>> 2. rewrite the dio_append API. Add relevant return values.
>>>
>>> Signed-off-by: dongshijiang<dongshijiang@inspur.com>
>>> ---
>>>     testcases/kernel/io/ltp-aiodio/dio_append.c | 26 +++++++++++++++------
>>>     1 file changed, 19 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/testcases/kernel/io/ltp-aiodio/dio_append.c
>>> b/testcases/kernel/io/ltp-aiodio/dio_append.c
>>> index 3f0ed29d5..500dfdc31 100644
>>> --- a/testcases/kernel/io/ltp-aiodio/dio_append.c
>>> +++ b/testcases/kernel/io/ltp-aiodio/dio_append.c
>>> @@ -75,7 +75,7 @@ int read_eof(char *filename)
>>>     	return 0;
>>>     }
>>>
>>> -void dio_append(char *filename)
>>> +int dio_append(char *filename)
>>>     {
>>>     	int fd;
>>>     	void *bufptr;
>>> @@ -86,14 +86,14 @@ void dio_append(char *filename)
>>>
>>>     	if (fd<    0) {
>>>     		perror("cannot create file");
>>> -		return;
>>> +		return 1;
>>>     	}
>>>
>>>     	TEST(posix_memalign(&bufptr, 4096, 64 * 1024));
>>>     	if (TEST_RETURN) {
>>>     		tst_resm(TBROK | TRERRNO, "cannot malloc aligned memory");
>>>     		close(fd);
>>> -		return;
>>> +		return 1;
>>>     	}
>>>
>>>     	memset(bufptr, 0, 64 * 1024);
>>> @@ -102,17 +102,29 @@ void dio_append(char *filename)
>>>     			fprintf(stderr, "write %d returned %d\n", i, w);
>>>     		}
>>>     	}
>>> +	return 0;
>>>     }
>>>
>>>     int main(void)
>>>     {
>>> -	char filename[PATH_MAX];
>>> +	char filename[PATH_MAX], filepath[PATH_MAX-5];
>>>     	int pid[NUM_CHILDREN];
>>>     	int num_children = 1;
>>>     	int i;
>>> +	int ret = -1;
>>>
>>> -	snprintf(filename, sizeof(filename), "%s/aiodio/file",
>>> +	snprintf(filepath, sizeof(filepath), "%s/aiodio",
>>>     		 getenv("TMP") ? getenv("TMP") : "/tmp");
>>> +
>>> +	if (access(filepath, F_OK) == -1) {
>>> +		char command[PATH_MAX + 10];
>>> +
>>> +		snprintf(command, sizeof(command), "mkdir -p %s", filepath);
>>> +		if (system(command) != 0)
>>> +			return 1;
>> just only call mkdir syscall instead of command.
>>> +	}
>>> +
>>> +	snprintf(filename, sizeof(filename), "%s/file", filepath);
>>>
>>>     	printf("Begin dio_append test...\n");
>>>
>>> @@ -134,10 +146,10 @@ int main(void)
>>>     	 * Parent appends to end of file using direct i/o
>>>     	 */
>>>
>>> -	dio_append(filename);
>>> +	ret = dio_append(filename);
>>>
>>>     	for (i = 0; i<    num_children; i++) {
>>>     		kill(pid[i], SIGTERM);
>>>     	}
>>> -	return 0;
>>> +	return ret;
>>>     }
