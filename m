From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 2 Nov 2016 09:55:30 +0800
Subject: [LTP] [PATCH] syscalls/sendto02.c: add new testcase
In-Reply-To: <20161101162042.GB14966@rei.lan>
References: <1477994467-18497-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20161101162042.GB14966@rei.lan>
Message-ID: <58194792.9010007@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi cyril

Thanks for your review.
I will rewrite this pacth as you said, but i still have some doubts.
Please see the following comment.

On 2016/11/02 0:20, Cyril Hrubis wrote:
> Hi!
>> +#include<errno.h>
>> +#include<sys/types.h>
>> +#include<sys/socket.h>
>> +
>> +#include "tst_test.h"
>> +
>> +static int sockfd;
>> +static int rds_flag;
>> +static struct sockaddr_in sa;
>> +
>> +static void setup(void)
>> +{
>> +	int acc_res, load_res;
>> +	const char *cmd[] = {"modprobe", "sctp", NULL};
>> +
>> +	acc_res = access("/proc/sys/net/sctp", F_OK);
>> +	if (acc_res == -1&&  errno != ENOENT)
>> +		tst_brk(TFAIL | TERRNO, "failed to check stcp module");
>                                           ^
> I would make the error message as specific as possible here, so I would
> print what exactly has failed:
>
> tst_brk(TBROK | TERRNO, "access(/proc/sys/net/sctp, F_OK)");
>
>> +	if (acc_res == -1&&  errno == ENOENT) {
>> +		load_res = tst_run_cmd(cmd, NULL, NULL, 1);
>> +		if (load_res) {
>> +			tst_brk(TCONF, "failed to loaded sctp module, "
>                                                      ^
> 						    load
>> +				"so sctp modeule was not support by system");
>                                             ^
> 					  module
>
> Also I would say that all that needs to be printed here is the first
> part of the string, i.e. "failed to load sctp module".
>
>> +		}
>> +
>> +		tst_res(TINFO, "succeeded to load sctp module");
>> +		rds_flag = 1;
>                   ^
> 		 It would be a bit better to name it
> 		 rds_module_loaded or just module_loaded
>> +	}
>> +
>> +	tst_res(TINFO, "sctp module was supported by system");
> Just omit this message, it's misleading anyway.
>
>> +	sockfd = SAFE_SOCKET(AF_INET, SOCK_STREAM, 132 /*IPPROTO_SCTP*/);
>                                                      ^
> 						    This is way too ugly.
>
> If IPPROTO_SCTP is not supported on you system you should add a fallback
> definition such as:
>
> #ifndef IPPROTO_SCTP
> # define IPPROTO_SCTP 132
> #endif
>
> Also you didn't even try to include the<netinet/in.h>  header that
> contains this definition, so it's quite likely that all you need to do
> is to include this header as well.
>
>> +	memset(&sa, 0, sizeof(sa));
>> +	sa.sin_family = AF_INET;
>> +	sa.sin_addr.s_addr = inet_addr("127.0.0.1");
>> +	sa.sin_port = htons(11111);
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	int unload_res;
>> +	const char *cmd[] = {"modprobe", "-r", "sctp", NULL};
>> +
>> +	if (rds_flag == 1) {
>> +		unload_res = tst_run_cmd(cmd, NULL, NULL, 1);
>> +		if (unload_res) {
>> +			/* We failed to unload sctp module(modprobe -r sctp)
>> +			 * and the operation failed with "FATAL: Module sctp is
>> +			 * in use." lsmod shows a reference count of 2 for sctp.
>> +			 * If we rebuild kernel with CONFIG_MODULE_FORCE_UNLOAD
>> +			 * enabled, we can succeed to unload sctp module
>> +			 * (rmmod -f sctp).
>> +			 */
>> +			tst_res(TINFO, "failed to unload sctp module, you can"
>> +				" reboot system to unload sctp after testing");
> Isn't the problem here that you have to close the sctp socket *berofe*
> you try to remove the module?
>
> It's pretty clear that the module would be in use at least until the
> socked is closed.
>
this is not the problem here.  the module was in use even we have closed 
sctp socket before removing the module.
the sctp module was in use because of some references.
Please see the following url for detailed information:
http://www.spinics.net/lists/linux-sctp/msg02137.html

Thanks,
Xiao Yang
>> +		} else {
>> +			tst_res(TINFO, "succeeded to unload sctp modules");
>> +		}
>> +	}
>> +
>> +	if (sockfd>  0&&  close(sockfd))
>> +		tst_res(TWARN | TERRNO, "failed to close file");
>> +}
>> +
>> +static void verify_sendto(void)
>> +{
>> +	TEST(sendto(sockfd, NULL, 1, 0, (struct sockaddr *)&sa, sizeof(sa)));
>> +	if (TEST_RETURN != -1) {
>> +		tst_res(TFAIL, "sendto() succeeded unexpectedly");
>> +		return;
>> +	}
>> +
>> +	if (TEST_ERRNO == ENOMEM) {
>> +		tst_res(TFAIL | TTERRNO, "sendto() got unrepaired errno with"
>> +			" invalid buffer when sctp is selected in socket()");
> This message is absurdly long as well. Be short and to the point.
>
> Something as:
>
> 	tst_res(TFAIL | TTERRNO, "sendto(fd, NULL, ...) failed unexpectedly");
>
>> +		return;
>> +	}
>> +
>> +	if (TEST_ERRNO == EFAULT) {
>> +		tst_res(TPASS | TTERRNO, "sendto() got repaired errno with"
>> +			" invalid buffer when sctp is selected in socket()");
> Here as well. Shorten the message to something more reasonable.
>
>> +		return;
>> +	}
>> +
>> +	tst_res(TFAIL | TTERRNO, "sendto() got unexpected errno with invalid"
>> +		" buffer when sctp is selected in socket(), expected ENOMEM "
>> +		"or EFAULT");
> Why do we have special case for errno != ENOMEM&&  errno != EFAULT. We
> fail the testcase if the errno is not EFAULT anyway. There is no reason
> to complicate the code like this.
>> +}
>> +
>> +static struct tst_test test = {
>> +	.tid = "sendto02",
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.test_all = verify_sendto,
>> +};
>> -- 
>> 1.8.3.1
>>
>>
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp



